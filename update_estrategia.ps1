# update_estrategia.ps1 -- v3.0
# El Director extrae este archivo del .zip de entrega y lo ejecuta. El script hace el resto.
# ASCII-only: sin em-dash, sin smart quotes, sin caracteres Unicode especiales
#
# AMBITO: este script es EXCLUSIVO del meta-proyecto de estrategia (estrategia-agentes-zai).
#         Los proyectos de aplicacion se entregan segun dcepi.md I.3a (solo archivos modificados,
#         salvo tests E2E) y NO usan este script.
#
# FLUJO DEL DIRECTOR (solo 2 acciones, orden del Director):
#   2.1 Extraer del .zip de entrega el archivo update_estrategia.ps1
#   2.2 Ejecutarlo:  powershell -ExecutionPolicy Bypass -File .\update_estrategia.ps1
#   (sin preguntas: acepta por defecto el .zip mas reciente y el repo local estandar)
#
# QUE HACE EL SCRIPT (actualizacion completa del meta-proyecto en UNA sola pasada):
#   3.1 Busca el .zip mas reciente estrategia*.zip en la carpeta de descargas del Director
#       (C:\Users\juanc\Downloads\ ; generico: %USERPROFILE%\Downloads) y lo fija como
#       entrega por defecto.
#   3.2 BORRA TODO lo que existe en la carpeta estrategia del repo local
#       (por defecto C:\Python\Proyectos\estrategia; se conserva unicamente .git, la memoria
#       de git necesaria para publicar) y descomprime el .zip de forma INTEGRA en la carpeta
#       del proyecto. El .zip trae dentro la carpeta estrategia/, de modo que extraerlo
#       integro en C:\Python\Proyectos y este paso producen EXACTAMENTE el mismo resultado.
#       Al ser reemplazo total NO hace falta purga de archivos retirados: el borrado los
#       elimina todos. Antes de borrar, verifica la integridad SHA256 de CADA archivo del
#       .zip contra MANIFIESTO_ENTREGA.txt (umbral cero: si algo no cuadra, ABORTA sin
#       tocar el repositorio).
#   3.3 Ejecuta las sentencias de actualizacion de GitHub (dcepi.md I.3c): commit + push a
#       la rama main y sincronizacion automatica de la rama operativo (1 repo / 2 ramas).
#   3.4 Si es posible, ejecuta el DIFF entre el repo de GitHub (tras actualizar) y la
#       carpeta local modificada por la implementacion: verifica DIFF CERO y guarda el
#       diff de la entrega en %USERPROFILE%\Downloads\DIFF_ENTREGA_estrategia_v<version>.txt
#
# ESQUEMA DE REPOSITORIO (R18): UN repo local = UN repo GitHub con DOS ramas:
#   - main: rama COMPLETA (todo, incluida meta/)
#   - operativo: rama COMPACTA (agent-context/, agent-learn/, worklog_template.md,
#               worklog_protocolo.md, prompt_arranque.md) para los agentes de proyecto.
#
# USO (Director en Windows):
#   powershell -ExecutionPolicy Bypass -File .\update_estrategia.ps1
# MODOS AUXILIARES:
#   -ZipPath "C:\Users\juanc\Downloads\estrategia_v1.2.zip"  (forzar un .zip concreto)
#   -RepoDir "C:\Python\Proyectos\estrategia"                (forzar el repo local)
#   -DryRun    (simulacion: verifica el .zip e informa, NO cambia nada)
#   -NoPush    (aplica en el repo local; NO toca GitHub ni la rama operativo)

param(
    [string]$ZipPath = "",
    [string]$RepoDir = "",
    [string]$RepoUrl = "https://github.com/Juank6507/estrategia-agentes-zai.git",
    [switch]$NoPush,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

# ============================================================
#  CONFIGURACION
# ============================================================

$MAIN_BRANCH = "main"
$OPERATIVO_BRANCH = "operativo"
$MANIFEST_NAME = "MANIFIESTO_ENTREGA.txt"

# Repositorio local por defecto del Director (R18 / I.3c de dcepi.md)
$DEFAULT_REPO_DIR = "C:\Python\Proyectos\estrategia"

# Rutas que la rama operativo CONSERVA (lista cerrada aprobada por el Director).
$OPERATIVO_KEEP = @(
    "agent-context",
    "agent-learn",
    "worklog_template.md",
    "worklog_protocolo.md",
    "prompt_arranque.md"
)

# Archivos minimos que TODA entrega debe traer (estructura v1.2, Protocolo de Arranque)
$REQUIRED_FILES = @(
    "agent-context/premisa_respuesta.md",
    "agent-context/herramientas.md",
    "agent-context/dcepi.md",
    "agent-context/contrato.md",
    "agent-context/comunicacion.md",
    "agent-context/entorno.md",
    "agent-context/proyecto.md",
    "agent-context/identidad.md",
    "agent-learn/anti_patrones.md",
    "agent-learn/lecciones_aprendidas.md",
    "agent-learn/patrones_recurrentes.md",
    "agent-learn/preferencias_director.md",
    "prompt_arranque.md",
    "worklog_protocolo.md",
    "worklog_template.md",
    "update_estrategia.ps1"
)

# ============================================================
#  FUNCIONES AUXILIARES
# ============================================================

function Write-Title {
    Write-Host ""
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "  ACTUALIZACION DE ESTRATEGIA Z.ai (v3.0)" -ForegroundColor Cyan
    Write-Host "  zip -> borrado total -> repo local -> GitHub" -ForegroundColor Cyan
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host ""
}

function Write-Fatal {
    param([string]$Message)
    Write-Host ""
    Write-Host "FATAL: $Message" -ForegroundColor Red
    Write-Host "No se ha modificado nada (aborto con umbral cero)." -ForegroundColor Red
    exit 1
}

function Get-TempRoot {
    if ($env:TEMP) { return $env:TEMP }
    return [System.IO.Path]::GetTempPath()
}

function Get-DownloadsDir {
    if ($env:USERPROFILE) { return (Join-Path $env:USERPROFILE "Downloads") }
    return ""
}

function Resolve-RepoDir {
    # Orden de resolucion: -RepoDir > variable de entorno ESTRATEGIA_REPO > ruta por defecto.
    # El script puede ejecutarse desde cualquier carpeta (p. ej. Downloads, junto al .zip).
    if ($RepoDir -ne "") { return $RepoDir }
    if ($env:ESTRATEGIA_REPO -ne "" -and $env:ESTRATEGIA_REPO) { return $env:ESTRATEGIA_REPO }
    return $DEFAULT_REPO_DIR
}

function Find-ZipFile {
    # Generico: el .zip de entrega mas reciente (estrategia*.zip) en Downloads (carpeta
    # indicada por el Director), con respaldo en Escritorio, repo y carpeta del script.
    $searchDirs = @()
    $dl = Get-DownloadsDir
    if ($dl -ne "") { $searchDirs += $dl }
    if ($env:USERPROFILE) { $searchDirs += (Join-Path $env:USERPROFILE "Desktop") }
    $searchDirs += $REPO_DIR
    if ($PSScriptRoot) { $searchDirs += $PSScriptRoot }

    $candidates = @()
    foreach ($d in $searchDirs) {
        if (Test-Path $d) {
            $found = Get-ChildItem -Path $d -Filter "estrategia*.zip" -File -ErrorAction SilentlyContinue
            if ($found) { $candidates += $found }
        }
    }
    if ($candidates.Count -eq 0) { return $null }
    # El mas reciente por fecha de descarga
    $newest = $candidates | Sort-Object -Property LastWriteTime -Descending | Select-Object -First 1
    return $newest.FullName
}

function Select-ZipPath {
    # Sin preguntas (orden del Director): -ZipPath o el mas reciente encontrado; si no hay, FATAL.
    if ($ZipPath -ne "") {
        if (-not (Test-Path $ZipPath)) {
            Write-Fatal "El .zip indicado con -ZipPath no existe: $ZipPath"
        }
        return $ZipPath
    }
    $autoFound = Find-ZipFile
    if ($autoFound) { return $autoFound }
    $dl = Get-DownloadsDir
    Write-Fatal ("No se encontro ningun estrategia*.zip en " + $dl + " (ni en Escritorio/repo/script). " +
        "Descargue el .zip de entrega y reejecute, o use -ZipPath con la ruta completa.")
}

function Parse-Manifest {
    param([string]$ManifestFile)

    $result = @{
        Version    = ""
        Files      = @{}
        Eliminados = New-Object System.Collections.Generic.List[string]
    }

    $inElim = $false
    foreach ($line in (Get-Content -Path $ManifestFile -Encoding UTF8)) {
        $t = $line.Trim()
        if ($t -eq "") { continue }
        if ($t.StartsWith("#")) {
            if ($t -match "^#\s*ELIMINADOS") { $inElim = $true }
            continue
        }
        if (-not $inElim -and $t -match "^VERSION:\s*(.+)$") {
            $result.Version = $Matches[1].Trim()
            continue
        }
        if ($inElim) {
            $result.Eliminados.Add(($t -replace '\\', '/'))
            continue
        }
        if ($t -match "^([0-9a-fA-F]{64})\s+(.+)$") {
            $rel = ($Matches[2].Trim() -replace '\\', '/')
            $result.Files[$rel] = $Matches[1].ToLower()
        }
    }
    return $result
}

function Test-Delivery {
    # Extraccion + verificacion SHA256 umbral cero de TODA la entrega.
    # Se ejecuta ANTES de borrar nada del repo: si algo falla, el repo queda intacto.
    # Devuelve un hashtable con zipRoot, manifest y conteos; aborta si algo falla.
    param([string]$Zip)

    $tempDir = Join-Path (Get-TempRoot) ("estrategia_zip_" + [System.Guid]::NewGuid().ToString("N").Substring(0, 8))

    Write-Host "  Extrayendo .zip en carpeta temporal..." -ForegroundColor White
    Expand-Archive -Path $Zip -DestinationPath $tempDir -Force

    # Raiz generica: si hay una UNICA carpeta raiz y ningun archivo suelto, esa es la raiz
    $zipRoot = $tempDir
    $topItems = @(Get-ChildItem $tempDir -Force | Where-Object { $_.Name -ne "MANIFIESTO_ENTREGA.txt" })
    if ($topItems.Count -eq 1 -and $topItems[0].PSIsContainer) {
        $zipRoot = $topItems[0].FullName
    }

    $manifestFile = Join-Path $zipRoot $MANIFEST_NAME
    if (-not (Test-Path $manifestFile)) {
        Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        Write-Fatal "El .zip no contiene $MANIFEST_NAME. No es una entrega verificable de la estrategia."
    }

    Write-Host "  Verificando integridad SHA256 (umbral cero)..." -ForegroundColor White
    $m = Parse-Manifest -ManifestFile $manifestFile
    if ($m.Files.Count -eq 0) {
        Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        Write-Fatal "El manifest no contiene ninguna entrada de archivo."
    }

    # Estructura minima exigida
    foreach ($req in $REQUIRED_FILES) {
        if (-not $m.Files.ContainsKey($req)) {
            Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
            Write-Fatal "Falta en la entrega un archivo obligatorio: $req"
        }
    }
    $hasSpec = $false
    foreach ($k in $m.Files.Keys) {
        if ($k -like "meta/spec_estrategia_v*.md") { $hasSpec = $true }
    }
    if (-not $hasSpec) {
        Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        Write-Fatal "Falta en la entrega la especificacion versionada (meta/spec_estrategia_v*.md)."
    }

    # Hash de cada archivo del manifest
    $bad = New-Object System.Collections.Generic.List[string]
    foreach ($rel in $m.Files.Keys) {
        $src = Join-Path $zipRoot ($rel -replace '/', '\')
        if (-not (Test-Path $src)) { $bad.Add("FALTA: $rel"); continue }
        $h = (Get-FileHash -Path $src -Algorithm SHA256).Hash.ToLower()
        if ($h -ne $m.Files[$rel]) { $bad.Add("HASH: $rel") }
    }
    if ($bad.Count -gt 0) {
        Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        Write-Fatal ("Integridad del .zip INCORRECTA (entrega corrupta o incompleta):`n" + (($bad | Select-Object -First 10) -join "`n"))
    }

    Write-Host "  Integridad verificada: $($m.Files.Count) archivos OK, version $($m.Version)." -ForegroundColor Green
    return @{ ZipRoot = $zipRoot; Manifest = $m; TempDir = $tempDir }
}

function Ensure-Repo {
    # Garantiza que REPO_DIR existe, es un repo git con remote y esta en main.
    # NOTA v3.0: NO exige repo limpio (el borrado total reemplaza todo el contenido).
    if (-not (Test-Path $REPO_DIR)) {
        $parent = Split-Path $REPO_DIR -Parent
        if (-not (Test-Path $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }
        Write-Host "  El repo local no existe. Clonando $RepoUrl ..." -ForegroundColor White
        git clone $RepoUrl $REPO_DIR
        if ($LASTEXITCODE -ne 0) { Write-Fatal "Fallo el clon del repositorio." }
    }

    Push-Location $REPO_DIR
    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        if (-not (Test-Path (Join-Path $REPO_DIR ".git"))) {
            $isEmpty = (Get-ChildItem -Force -ErrorAction SilentlyContinue | Measure-Object).Count -eq 0
            if (-not $isEmpty) {
                Write-Fatal "$REPO_DIR existe pero NO es un repositorio git y no esta vacio."
            }
            git init
            if ($LASTEXITCODE -ne 0) { Write-Fatal "Fallo git init." }
        }

        # Solo configura el remote si no existe origin (no pisa el origin del Director)
        $remoteUrl = git remote get-url origin 2>$null
        if ($LASTEXITCODE -ne 0) {
            git remote add origin $RepoUrl
            if ($LASTEXITCODE -ne 0) { Write-Fatal "Fallo al configurar el remote origin." }
        } else {
            Write-Host "  Remote origin: $remoteUrl" -ForegroundColor DarkGray
        }

        # Identidad git necesaria para commit
        $gitEmail = git config user.email 2>$null
        if (-not $gitEmail) { $gitEmail = git config --global user.email 2>$null }
        $gitName = git config user.name 2>$null
        if (-not $gitName) { $gitName = git config --global user.name 2>$null }
        if (-not $gitEmail -or -not $gitName) {
            Write-Fatal "git no tiene identidad configurada (user.name / user.email). Ejecute: git config --global user.email `"tu@correo.com`" y git config --global user.name `"Su Nombre`""
        }

        # Trabajar siempre sobre la rama completa
        git rev-parse --verify $MAIN_BRANCH 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) {
            git checkout -b $MAIN_BRANCH 2>&1 | Out-Null
        } else {
            git checkout $MAIN_BRANCH 2>&1 | Out-Null
        }
        if ($LASTEXITCODE -ne 0) { Write-Fatal "No se pudo cambiar a la rama $MAIN_BRANCH." }
    }
    finally {
        $ErrorActionPreference = $prevEAP
        Pop-Location
    }
}

function Clear-RepoContent {
    # BORRA TODO el contenido de la carpeta del repo local excepto .git (orden del Director).
    # Al ser reemplazo total no hace falta purga de archivos retirados: el borrado los cubre.
    Push-Location $REPO_DIR
    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        $dirty = git status --porcelain
        if (@($dirty).Count -gt 0) {
            Write-Host "  AVISO: habia cambios sin confirmar; se descartan con el borrado total:" -ForegroundColor Yellow
            @($dirty) | Select-Object -First 15 | ForEach-Object { Write-Host "    descartado: $_" -ForegroundColor DarkYellow }
        }
        Get-ChildItem -Force | Where-Object { $_.Name -ne ".git" } | ForEach-Object {
            Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
        }
        $left = @(Get-ChildItem -Force | Where-Object { $_.Name -ne ".git" })
        if ($left.Count -gt 0) {
            Write-Fatal ("No se pudo vaciar el repo local (quedan " + $left.Count + " elementos bloqueados, probablemente en uso). Cierre editores/consolas con archivos abiertos y reejecute.")
        }
        Write-Host "  Repo local vaciado (se conserva solo .git)." -ForegroundColor Green
    }
    finally {
        $ErrorActionPreference = $prevEAP
        Pop-Location
    }
}

function Apply-Delivery {
    # Descomprime INTEGRAMENTE la entrega sobre la carpeta del repo (reemplazo total)
    # y verifica post-copia: hash de cada archivo del repo == hash del manifest.
    param($Delivery)

    $copied = 0
    Get-ChildItem -Path $Delivery.ZipRoot -Force | ForEach-Object {
        $dst = Join-Path $REPO_DIR $_.Name
        Copy-Item -Path $_.FullName -Destination $dst -Recurse -Force
        $copied++
    }

    # Verificacion post-copia: hash del repo == hash del manifest
    $m = $Delivery.Manifest
    $bad = New-Object System.Collections.Generic.List[string]
    foreach ($rel in $m.Files.Keys) {
        $p = Join-Path $REPO_DIR ($rel -replace '/', '\')
        if (-not (Test-Path $p)) { $bad.Add("FALTA: $rel"); continue }
        $h = (Get-FileHash -Path $p -Algorithm SHA256).Hash.ToLower()
        if ($h -ne $m.Files[$rel]) { $bad.Add("HASH: $rel") }
    }
    if ($bad.Count -gt 0) {
        Write-Fatal ("Verificacion post-copia FALLIDA en: " + (($bad | Select-Object -First 10) -join ", ") + ". Restaure con: git checkout -- .")
    }
    return @{ Copied = $copied }
}

function Invoke-GitCommitAndPush {
    # Sentencias GitHub de dcepi.md I.3c: add, commit, pull --rebase, push -u origin main
    param([string]$CommitMsg)

    Push-Location $REPO_DIR
    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        Write-Host "  git add -A ..." -ForegroundColor White
        git add -A
        if ($LASTEXITCODE -ne 0) { Write-Fatal "Fallo git add." }

        $pending = git status --porcelain
        if (@($pending).Count -eq 0) {
            Write-Host "  Sin cambios respecto al repo local: nada que commitear." -ForegroundColor Yellow
            return "sin-cambios"
        }

        Write-Host "  git commit ..." -ForegroundColor White
        $commitOut = git commit -m $CommitMsg 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Fatal ("Fallo git commit:`n" + ($commitOut -join "`n"))
        }

        Write-Host "  git pull --rebase origin $MAIN_BRANCH ..." -ForegroundColor White
        git pull --rebase origin $MAIN_BRANCH 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) {
            Write-Fatal "git pull --rebase encontro conflictos. Resuelva a mano (git status / git rebase --abort) y reejecute."
        }
        return "ok"
    }
    finally {
        $ErrorActionPreference = $prevEAP
        Pop-Location
    }
}

function Invoke-GitPushMain {
    Push-Location $REPO_DIR
    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        Write-Host "  git push -u origin $MAIN_BRANCH ..." -ForegroundColor White
        $pushOut = git push -u origin $MAIN_BRANCH 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Host "  ERROR: el push de $MAIN_BRANCH fallo (exit $LASTEXITCODE):" -ForegroundColor Red
            Write-Host ($pushOut -join "`n") -ForegroundColor Red
            Write-Host "  Manual: cd $REPO_DIR ; git push -u origin $MAIN_BRANCH" -ForegroundColor Yellow
            exit 1
        }
        Write-Host "  Push de '$MAIN_BRANCH' completado." -ForegroundColor Green
    }
    finally {
        $ErrorActionPreference = $prevEAP
        Pop-Location
    }
}

function Sync-OperativoBranch {
    # Espejo podado de main (lista cerrada OPERATIVO_KEEP) + push de la rama operativo.
    Push-Location $REPO_DIR
    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        Write-Host "  Sincronizando rama '$OPERATIVO_BRANCH' desde '$MAIN_BRANCH'..." -ForegroundColor White

        git rev-parse --verify $OPERATIVO_BRANCH 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) {
            git rev-parse --verify "origin/$OPERATIVO_BRANCH" 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) {
                git checkout -b $OPERATIVO_BRANCH "origin/$OPERATIVO_BRANCH" 2>&1 | Out-Null
            } else {
                git checkout -b $OPERATIVO_BRANCH $MAIN_BRANCH 2>&1 | Out-Null
            }
        } else {
            git checkout $OPERATIVO_BRANCH 2>&1 | Out-Null
        }
        if ($LASTEXITCODE -ne 0) { Write-Fatal "No se pudo cambiar a la rama $OPERATIVO_BRANCH." }

        # Vaciar y restaurar todo el contenido de main
        git rm -r -q --ignore-unmatch . 2>&1 | Out-Null
        git restore --source=$MAIN_BRANCH --worktree --staged -- . 2>&1 | Out-Null

        # Poda: en operativo solo queda la lista cerrada
        $topItems = Get-ChildItem -Force | Where-Object { $_.Name -ne ".git" }
        foreach ($item in $topItems) {
            $keep = $false
            foreach ($k in $OPERATIVO_KEEP) { if ($item.Name -eq $k) { $keep = $true } }
            if (-not $keep) {
                git rm -r -q --ignore-unmatch -- $item.Name 2>&1 | Out-Null
                if (Test-Path $item.FullName) {
                    Remove-Item $item.FullName -Recurse -Force -ErrorAction SilentlyContinue
                }
            }
        }

        git add -A 2>&1 | Out-Null
        $syncOut = git commit -m "sync operativo desde $MAIN_BRANCH (poda de rutas internas)" 2>&1
        $syncExit = $LASTEXITCODE
        if ($syncExit -eq 0) {
            git push -u origin $OPERATIVO_BRANCH 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "  Rama '$OPERATIVO_BRANCH' sincronizada y publicada." -ForegroundColor Green
            } else {
                Write-Host "  Aviso: el push de '$OPERATIVO_BRANCH' fallo (exit $LASTEXITCODE)." -ForegroundColor Yellow
            }
        } elseif (($syncOut -join " ") -match "nothing to commit") {
            Write-Host "  Rama '$OPERATIVO_BRANCH' ya estaba sincronizada." -ForegroundColor DarkGray
        } else {
            Write-Fatal ("Fallo el commit de la rama operativo:`n" + ($syncOut -join "`n"))
        }

        git checkout $MAIN_BRANCH 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) { Write-Fatal "No se pudo volver a la rama $MAIN_BRANCH." }
    }
    finally {
        $ErrorActionPreference = $prevEAP
        Pop-Location
    }
}

function Invoke-DiffCheck {
    # 3.4 DIFF entre el repo de GitHub (tras actualizar) y la carpeta local modificada.
    # Verifica DIFF CERO y guarda el diff de la entrega en Downloads.
    param([string]$Version, [string]$CommitState)

    $dlDir = Get-DownloadsDir
    if ($dlDir -eq "" -or -not (Test-Path $dlDir)) { $dlDir = (Get-TempRoot) }

    Push-Location $REPO_DIR
    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        if ($CommitState -eq "ok") {
            # Diff de la entrega: cambios introducidos por esta version
            $diffFile = Join-Path $dlDir ("DIFF_ENTREGA_estrategia_v" + $Version + ".txt")
            $hasParent = $true
            git rev-parse HEAD~1 2>&1 | Out-Null
            if ($LASTEXITCODE -ne 0) { $hasParent = $false }
            if ($hasParent) {
                Write-Host "  Diff de la entrega (HEAD~1 -> HEAD):" -ForegroundColor White
                git diff --stat HEAD~1 HEAD | ForEach-Object { Write-Host "    $_" -ForegroundColor DarkGray }
                git diff HEAD~1 HEAD | Out-File -FilePath $diffFile -Encoding utf8
                Write-Host "  Diff completo guardado en: $diffFile" -ForegroundColor Green
            } else {
                Write-Host "  Diff de la entrega no disponible (primer commit del repo)." -ForegroundColor Yellow
            }
        } else {
            Write-Host "  Sin nuevos cambios: el diff de la entrega coincide con lo ya publicado." -ForegroundColor DarkGray
        }

        if ($NoPush) {
            Write-Host "  Modo -NoPush: GitHub no se ha actualizado; diff cero contra GitHub omitido." -ForegroundColor Yellow
            return
        }

        git fetch origin $MAIN_BRANCH 2>&1 | Out-Null
        $gh = (git rev-parse "origin/$MAIN_BRANCH").Trim()
        $loc = (git rev-parse HEAD).Trim()
        $dirty = (git status --porcelain) -join "`n"
        if ($gh -eq $loc -and $dirty.Trim() -eq "") {
            Write-Host "  DIFF CERO verificado: GitHub (origin/main) y la carpeta local son identicos." -ForegroundColor Green
        } else {
            Write-Host "  ATENCION: GitHub y la carpeta local NO coinciden:" -ForegroundColor Red
            Write-Host ("    origin/main: $gh   |   HEAD local: $loc") -ForegroundColor Red
            if ($dirty.Trim() -ne "") {
                Write-Host "    cambios sin confirmar en local:" -ForegroundColor Red
                git status --short | Select-Object -First 10 | ForEach-Object { Write-Host "      $_" -ForegroundColor Red }
            }
        }
    }
    finally {
        $ErrorActionPreference = $prevEAP
        Pop-Location
    }
}

# ============================================================
#  PROGRAMA PRINCIPAL
# ============================================================

Write-Title

$REPO_DIR = Resolve-RepoDir
$zipFinal = Select-ZipPath

Write-Host "  Operacion : borrado total + entrega .zip integra + GitHub + diff" -ForegroundColor White
Write-Host "  .zip      : $zipFinal" -ForegroundColor White
Write-Host "  Repo local: $REPO_DIR" -ForegroundColor White
if ($NoPush)   { Write-Host "  GitHub    : NO (modo -NoPush, solo repo local)" -ForegroundColor Yellow }
else           { Write-Host "  GitHub    : SI (push a $MAIN_BRANCH + sync $OPERATIVO_BRANCH)" -ForegroundColor White }
if ($DryRun)   { Write-Host "  Modo      : SIMULACION (-DryRun, no cambia nada)" -ForegroundColor Yellow }
Write-Host ""

# Verificacion de integridad de la entrega (umbral cero) ANTES de tocar el repo
$delivery = Test-Delivery -Zip $zipFinal
$m = $delivery.Manifest

# Plan informativo
$existe = Test-Path $REPO_DIR
$nuevos = 0; $actualizados = 0; $intactos = 0
if ($existe) {
    foreach ($rel in $m.Files.Keys) {
        $p = Join-Path $REPO_DIR ($rel -replace '/', '\')
        if (-not (Test-Path $p)) { $nuevos++ }
        else {
            $h = (Get-FileHash -Path $p -Algorithm SHA256).Hash.ToLower()
            if ($h -ne $m.Files[$rel]) { $actualizados++ } else { $intactos++ }
        }
    }
}
Write-Host "  PLAN DE ACTUALIZACION (version $($m.Version)):" -ForegroundColor Cyan
Write-Host "    Archivos en la entrega: $($m.Files.Count)" -ForegroundColor White
if ($existe) {
    Write-Host "    Nuevos      : $nuevos" -ForegroundColor White
    Write-Host "    Actualizados: $actualizados" -ForegroundColor White
    Write-Host "    Intactos    : $intactos" -ForegroundColor White
}
if ($m.Eliminados.Count -gt 0) {
    Write-Host "    Retirados   : $($m.Eliminados.Count) (cubierto por el borrado total, sin purga adicional)" -ForegroundColor White
}
Write-Host ""

if ($DryRun) {
    Remove-Item $delivery.TempDir -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "  SIMULACION completada sin cambios (-DryRun)." -ForegroundColor Green
    Write-Host "============================================" -ForegroundColor Cyan
    exit 0
}

# 1) Repositorio garantizado ANTES de borrar nada
Ensure-Repo

# 2) BORRADO TOTAL del contenido del repo local (excepto .git) -- orden del Director.
#    Sustituye a la purga ELIMINADOS: el borrado cubre tambien los archivos retirados.
Clear-RepoContent

# 3) Descompresion INTEGRA de la entrega sobre la carpeta del proyecto
$result = Apply-Delivery -Delivery $delivery
Remove-Item $delivery.TempDir -Recurse -Force -ErrorAction SilentlyContinue
Write-Host ""
Write-Host "  Aplicado: $($result.Copied) elementos escritos desde el .zip (reemplazo total)." -ForegroundColor Green

# 4) Sentencias GitHub (dcepi.md I.3c): commit + push main + sync operativo
$commitMsg = "v$($m.Version): reemplazo total desde entrega .zip (manifest SHA256 verificado)"
$commitState = Invoke-GitCommitAndPush -CommitMsg $commitMsg

if (-not $NoPush) {
    if ($commitState -eq "ok") {
        Invoke-GitPushMain
    } else {
        Write-Host "  Sin cambios en main: no se requiere push." -ForegroundColor Yellow
    }
    # La rama operativo se sincroniza SIEMPRE (si main no cambio, queda verificada)
    Sync-OperativoBranch
}

# 5) DIFF GitHub (tras actualizar) vs carpeta local modificada por la implementacion
Invoke-DiffCheck -Version $m.Version -CommitState $commitState

# Estado final
Push-Location $REPO_DIR
$prevEAP = $ErrorActionPreference
$ErrorActionPreference = "Continue"
try {
    $finalBranch = git rev-parse --abbrev-ref HEAD
    $finalDirty = (git status --porcelain) -join "`n"
    $finalHash = git rev-parse --short HEAD
}
finally {
    $ErrorActionPreference = $prevEAP
    Pop-Location
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  ACTUALIZACION COMPLETADA" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Version   : $($m.Version)"
Write-Host "  Repo      : $REPO_DIR (rama $finalBranch, commit $finalHash)"
if ($finalDirty.Trim() -eq "") { Write-Host "  Estado    : repo limpio" -ForegroundColor Green }
else                           { Write-Host "  Estado    : ATENCION, quedan cambios sin confirmar" -ForegroundColor Yellow }
if (-not $NoPush) { Write-Host "  GitHub    : main actualizada + rama operativo sincronizada" -ForegroundColor Green }
Write-Host ""
Write-Host "  Siguiente paso: 7. I.3d (diff cero y aprendizajes)" -ForegroundColor Cyan
Write-Host ""
exit 0
