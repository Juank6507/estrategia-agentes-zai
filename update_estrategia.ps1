# update_estrategia.ps1 -- v4.0.2
# v4.0 (v1.4, conciliacion V1/V6): (1) el script PREGUNTA con valores predeterminados
#       (Enter acepta): carpeta del .zip (por defecto Descargas; toma el estrategia_v#.#.zip
#       mas reciente), carpeta del repo local (borra y reemplaza) y los DOS repos GitHub a
#       publicar. (2) Publica en DOS repos publicos desde UN solo repo local: el COMPLETO
#       (todo el contenido) y el OPERATIVO (paquete de seis elementos), en lugar de un repo
#       con dos ramas (conciliacion V1 de la v1.4). (3) El Director ya NO extrae el script
#       a mano: la entrega trae una sentencia de PowerShell que lo extrae del .zip y lo
#       ejecuta (un solo paso).
# Hereda de v3.1: verificacion SHA256 umbral cero contra el manifiesto, borrado total del
# repo local (conserva .git), descompresion integra, informe DIFF con codificacion UTF-8
# (fix S53), modos auxiliares -DryRun/-NoPush.
# v4.0.1 (v1.4.1, errata de entrega S57): delimitacion ${VAR} antes de ':' en las lineas
#       348/364 (remotes COMPLETO/OPERATIVO): en PowerShell, "$NOMBRE:" dentro de una cadena
#       de comillas dobles se interpreta como variable de ambito (como $env:PATH) y rompe
#       el parseo. Resto del script sin cambios.
# v4.0.2 (v1.4.2, correccion de produccion S58): (1) la seleccion del .zip es por MAYOR VERSION
#       del nombre (empate: mas reciente por fecha), no solo por fecha: en Descargas del Director
#       un zip viejo re-descargado (v1.3.1) resulto el mas nuevo y la sentencia ejecuto la entrega
#       equivocada (banner "Version : 1.3.1"; la v1.4.1 no llego a aplicarse). (2) Guarda de
#       coherencia nombre del .zip <-> VERSION del manifiesto: si no cuadran, aviso rojo y
#       Enter = abortar (umbral cero; S = continuar). (3) El informe DIFF_ENTREGA_estrategia_v*.txt
#       se genera SIEMPRE, tambien cuando el repo local no cambia ("sin cambios"). (4) La sentencia
#       de cada entrega fija el NOMBRE EXACTO del .zip y se lo pasa al script con -ZipPath.
# ASCII-only: sin em-dash, sin smart quotes, sin caracteres Unicode especiales
#
# AMBITO: este script es EXCLUSIVO del meta-proyecto de estrategia (estrategia-agentes-zai).
#         Los proyectos de aplicacion se entregan segun dcepi.md I.3a (solo archivos modificados,
#         salvo tests E2E) y NO usan este script.
#
# FLUJO DEL DIRECTOR (UN solo paso, orden del Director V6):
#   Pegar en la consola de PowerShell la SENTENCIA que acompana la entrega: extrae este
#   script del .zip (el mas reciente en Descargas) y lo ejecuta. El script pregunta lo
#   imprescindible (Enter = valor predeterminado) y hace el resto solo.
#
# QUE HACE EL SCRIPT (actualizacion completa del meta-proyecto en UNA sola pasada):
#   3.1 Pregunta la carpeta del .zip (por defecto %USERPROFILE%\Downloads) y toma el
#       .zip estrategia_v* de MAYOR VERSION de esa carpeta (empate: el mas reciente por
#       fecha; fix v4.0.2: los timestamps de Descargas no son fiables). Respaldo: patron
#       generico estrategia*.zip.
#   3.2 Pregunta la carpeta del repo local (por defecto C:\Python\Proyectos\estrategia),
#       verifica la integridad SHA256 de CADA archivo del .zip contra MANIFIESTO_ENTREGA.txt
#       (umbral cero: si algo no cuadra, ABORTA sin tocar nada), BORRA TODO el contenido
#       del repo local (conserva solo .git) y descomprime el .zip de forma INTEGRA.
#       Al ser reemplazo total NO hace falta purga de retirados: el borrado los elimina todos.
#   3.3 Pregunta los DOS repos GitHub a publicar (por defecto: el completo y el operativo
#       validados en la v1.4) y publica: commit + push del contenido COMPLETO al repo
#       COMPLETO (remote 'origin') y del paquete OPERATIVO de seis elementos al repo
#       OPERATIVO (remote 'operativo').
#   3.4 Ejecuta el DIFF entre el repo de GitHub (tras actualizar) y la carpeta local:
#       verifica DIFF CERO y guarda el diff de la entrega en
#       %USERPROFILE%\Downloads\DIFF_ENTREGA_estrategia_v<version>.txt (UTF-8 correcto).
#
# ESQUEMA DE REPOSITORIO (v1.4, conciliacion V1): UN repo local -> DOS repos GitHub:
#   - COMPLETO  https://github.com/Juank6507/estrategia-agentes-zai.git
#               (todo: agent-context/, agent-learn/, worklogs, meta/, PDFs, manifiesto, script)
#               Lo clona el agente del meta-proyecto EP.
#   - OPERATIVO https://github.com/Juank6507/estrategia-agentes-zai-operativo.git
#               (paquete de seis elementos: agent-context/, agent-learn/,
#               worklog_template.md, worklog_protocolo.md, prompt_arranque.md,
#               premisa_respuesta.md). Lo clonan los agentes de proyecto.
#   Sin credenciales: la separacion de contenido es la separacion entre los dos repos.
#
# USO (Director en Windows): pegar la sentencia de la entrega en PowerShell (recomendado),
#   o ejecutar directamente:  powershell -ExecutionPolicy Bypass -File .\update_estrategia.ps1
# MODOS AUXILIARES (fuerzan valores y omiten su pregunta):
#   -ZipPath "C:\...\estrategia_v1.4.zip"    (forzar un .zip concreto)
#   -RepoDir "C:\Python\Proyectos\estrategia" (forzar el repo local)
#   -CompletoUrl "https://github.com/...git"  (forzar el repo completo)
#   -OperativoUrl "https://github.com/...git" (forzar el repo operativo)
#   -DryRun    (simulacion: verifica el .zip e informa, NO cambia nada)
#   -NoPush    (aplica en el repo local; NO toca GitHub)

param(
    [string]$ZipPath = "",
    [string]$RepoDir = "",
    [string]$CompletoUrl = "",
    [string]$OperativoUrl = "",
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

# Repo local por defecto del Director
$DEFAULT_REPO_DIR = "C:\Python\Proyectos\estrategia"

# Los DOS repos GitHub por defecto (validados por el Director en la v1.4)
$DEFAULT_COMPLETO_URL = "https://github.com/Juank6507/estrategia-agentes-zai.git"
$DEFAULT_OPERATIVO_URL = "https://github.com/Juank6507/estrategia-agentes-zai-operativo.git"

$REMOTE_COMPLETO = "origin"      # remote del repo COMPLETO
$REMOTE_OPERATIVO = "operativo"  # remote del repo OPERATIVO

# Rutas que el repo operativo CONSERVA (paquete de seis elementos, conciliacion v1.4).
$OPERATIVO_KEEP = @(
    "premisa_respuesta.md",
    "agent-context",
    "agent-learn",
    "worklog_template.md",
    "worklog_protocolo.md",
    "prompt_arranque.md"
)

# Archivos minimos que TODA entrega debe traer (estructura v1.4, Protocolo de Arranque)
$REQUIRED_FILES = @(
    "premisa_respuesta.md",
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
    Write-Host "  ACTUALIZACION DE ESTRATEGIA Z.ai (v4.0.2)" -ForegroundColor Cyan
    Write-Host "  zip -> repo local -> 2 repos GitHub" -ForegroundColor Cyan
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

function Ask-Value {
    # Pregunta con valor predeterminado (Enter acepta). Si el valor llega forzado por
    # parametro, no pregunta y lo informa.
    param([string]$Prompt, [string]$Default, [string]$Forced)
    if ($Forced -ne "") {
        Write-Host "  $Prompt : $Forced (fijado por parametro)" -ForegroundColor DarkGray
        return $Forced
    }
    $answer = Read-Host "  $Prompt [Enter = $Default]"
    if ($answer.Trim() -eq "") { return $Default }
    return $answer.Trim()
}

function Get-TempRoot {
    if ($env:TEMP) { return $env:TEMP }
    return [System.IO.Path]::GetTempPath()
}

function Get-DownloadsDir {
    if ($env:USERPROFILE) { return (Join-Path $env:USERPROFILE "Downloads") }
    return ""
}

function Get-ZipVersionToken {
    # Token de version de un nombre de entrega: "estrategia_v1.4.2.zip" -> "1.4.2".
    # Sin version legible en el nombre -> "0" (queda el ultimo en la seleccion por version).
    param([string]$FileName)
    if ($FileName -match 'estrategia_v(\d+(?:\.\d+)*)') { return $Matches[1] }
    return "0"
}

function Find-ZipInFolder {
    # El .zip de entrega de UNA carpeta: el de MAYOR VERSION segun su nombre (fix v4.0.2:
    # el "mas reciente por fecha" fallo en produccion -- un zip viejo re-descargado pasa
    # por nuevo). Empate de version: gana el de fecha mas reciente. Patron estricto
    # estrategia_v*.zip, con respaldo del patron generico estrategia*.zip.
    param([string]$Folder)
    if (-not (Test-Path $Folder)) { return $null }
    $found = @(Get-ChildItem -Path $Folder -Filter "estrategia_v*.zip" -File -ErrorAction SilentlyContinue)
    if ($found.Count -eq 0) {
        $found = @(Get-ChildItem -Path $Folder -Filter "estrategia*.zip" -File -ErrorAction SilentlyContinue)
    }
    if ($found.Count -eq 0) { return $null }
    $ranked = foreach ($f in $found) {
        $tok = Get-ZipVersionToken -FileName $f.Name
        $ver = $null
        if (-not [System.Version]::TryParse($tok, [ref]$ver)) { $ver = New-Object System.Version(0, 0) }
        [pscustomobject]@{ File = $f; Ver = $ver; Ts = $f.LastWriteTime }
    }
    $best = $ranked |
        Sort-Object -Property @{ Expression = "Ver"; Descending = $true }, @{ Expression = "Ts"; Descending = $true } |
        Select-Object -First 1
    return $best.File.FullName
}

function Select-ZipPath {
    # Pregunta la carpeta del .zip (por defecto Descargas) y toma el mas reciente.
    # -ZipPath fuerza el .zip concreto y omite la pregunta.
    if ($ZipPath -ne "") {
        if (-not (Test-Path $ZipPath)) {
            Write-Fatal "El .zip indicado con -ZipPath no existe: $ZipPath"
        }
        return $ZipPath
    }
    $dl = Get-DownloadsDir
    if ($dl -eq "") { $dl = (Get-Location).Path }
    $folder = Ask-Value -Prompt "Carpeta donde esta el .zip de entrega" -Default $dl -Forced ""
    $zip = Find-ZipInFolder -Folder $folder
    if ($zip) {
        Write-Host ("  .zip seleccionado (mayor version): " + (Split-Path $zip -Leaf)) -ForegroundColor DarkGray
        return $zip
    }
    # Respaldo: Escritorio, repo local y carpeta del script
    if ($env:USERPROFILE) {
        $zip = Find-ZipInFolder -Folder (Join-Path $env:USERPROFILE "Desktop")
        if ($zip) {
            Write-Host "  No habia .zip en '$folder'; usado el de Escritorio: $zip" -ForegroundColor Yellow
            return $zip
        }
    }
    $zip = Find-ZipInFolder -Folder $DEFAULT_REPO_DIR
    if ($zip) {
        Write-Host "  No habia .zip en '$folder'; usado el del repo local: $zip" -ForegroundColor Yellow
        return $zip
    }
    if ($PSScriptRoot) {
        $zip = Find-ZipInFolder -Folder $PSScriptRoot
        if ($zip) {
            Write-Host "  No habia .zip en '$folder'; usado el de la carpeta del script: $zip" -ForegroundColor Yellow
            return $zip
        }
    }
    Write-Fatal ("No se encontro ningun estrategia_v*.zip en '$folder' (ni respaldos). " +
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
    param([string]$Zip)

    $tempDir = Join-Path (Get-TempRoot) ("estrategia_zip_" + [System.Guid]::NewGuid().ToString("N").Substring(0, 8))

    Write-Host "  Extrayendo .zip en carpeta temporal..." -ForegroundColor White
    Expand-Archive -Path $Zip -DestinationPath $tempDir -Force

    # Raiz generica: si hay una UNICA carpeta raiz y ningun archivo suelto, esa es la raiz
    $zipRoot = $tempDir
    $topItems = @(Get-ChildItem $tempDir -Force | Where-Object { $_.Name -ne $MANIFEST_NAME })
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

    # Guarda v4.0.2: el nombre del .zip debe cuadrar con la VERSION del manifiesto.
    # Si no cuadran, probablemente se selecciono un zip viejo o renombrado (fallo real en
    # produccion: se ejecuto la entrega v1.3.1 creyendo aplicar la v1.4.1). Enter = ABORTAR.
    $zipTok = ""
    if ((Split-Path -Path $Zip -Leaf) -match 'estrategia_v(\d+(?:\.\d+)*)') { $zipTok = $Matches[1] }
    $mTok = ("$($m.Version)" -replace '^v', '').Trim()
    if ($zipTok -ne "" -and $mTok -ne "" -and $zipTok -ne $mTok) {
        Write-Host ""
        Write-Host "  ATENCION: el .zip dice v$zipTok en su nombre pero su manifiesto dice VERSION: $mTok." -ForegroundColor Red
        Write-Host "  Nombre y contenido no coinciden: posible zip antiguo o renombrado." -ForegroundColor Red
        $resp = Read-Host "  Escriba S para continuar igualmente (Enter = ABORTAR)"
        if ($resp.Trim().ToUpper() -ne "S") {
            Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
            Write-Fatal "Abortado: nombre del .zip (v$zipTok) no coincide con VERSION del manifiesto ($mTok)."
        }
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

    Write-Host "  Integridad verificada: $($m.Files.Count) archivos OK, version $($m.Version) (zip: $(Split-Path $Zip -Leaf))." -ForegroundColor Green
    return @{ ZipRoot = $zipRoot; Manifest = $m; TempDir = $tempDir }
}

function Ensure-Repo {
    # Garantiza que REPO_DIR existe, es un repo git y tiene los DOS remotes configurados
    # con las URLs elegidas por el Director. NO exige repo limpio (el borrado total
    # reemplaza todo el contenido).
    if (-not (Test-Path $REPO_DIR)) {
        $parent = Split-Path $REPO_DIR -Parent
        if (-not (Test-Path $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }
        Write-Host "  El repo local no existe. Clonando $CompletoUrlFinal ..." -ForegroundColor White
        git clone $CompletoUrlFinal $REPO_DIR
        if ($LASTEXITCODE -ne 0) { Write-Fatal "Fallo el clon del repositorio completo." }
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

        # Remote del repo COMPLETO: se ajusta a la URL elegida en la pregunta
        $remoteUrl = git remote get-url $REMOTE_COMPLETO 2>$null
        if ($LASTEXITCODE -ne 0) {
            git remote add $REMOTE_COMPLETO $CompletoUrlFinal
            if ($LASTEXITCODE -ne 0) { Write-Fatal "Fallo al configurar el remote $REMOTE_COMPLETO." }
        } else {
            if ($remoteUrl.Trim() -ne $CompletoUrlFinal.Trim()) {
                git remote set-url $REMOTE_COMPLETO $CompletoUrlFinal
                if ($LASTEXITCODE -ne 0) { Write-Fatal "Fallo al actualizar la URL del remote $REMOTE_COMPLETO." }
                Write-Host "  Remote $REMOTE_COMPLETO actualizado a la URL elegida." -ForegroundColor DarkGray
            } else {
                Write-Host "  Remote ${REMOTE_COMPLETO}: $remoteUrl" -ForegroundColor DarkGray
            }
        }

        # Remote del repo OPERATIVO (v4.0): se ajusta a la URL elegida
        $remoteOpUrl = git remote get-url $REMOTE_OPERATIVO 2>$null
        if ($LASTEXITCODE -ne 0) {
            git remote add $REMOTE_OPERATIVO $OperativoUrlFinal
            if ($LASTEXITCODE -ne 0) { Write-Fatal "Fallo al configurar el remote $REMOTE_OPERATIVO." }
            Write-Host "  Remote $REMOTE_OPERATIVO creado: $OperativoUrlFinal" -ForegroundColor DarkGray
        } else {
            if ($remoteOpUrl.Trim() -ne $OperativoUrlFinal.Trim()) {
                git remote set-url $REMOTE_OPERATIVO $OperativoUrlFinal
                if ($LASTEXITCODE -ne 0) { Write-Fatal "Fallo al actualizar la URL del remote $REMOTE_OPERATIVO." }
                Write-Host "  Remote $REMOTE_OPERATIVO actualizado a la URL elegida." -ForegroundColor DarkGray
            } else {
                Write-Host "  Remote ${REMOTE_OPERATIVO}: $remoteOpUrl" -ForegroundColor DarkGray
            }
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

function Invoke-GitCommit {
    # Preparacion del commit en main: add + commit (+ pull --rebase para estar al dia)
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

        Write-Host "  git pull --rebase $REMOTE_COMPLETO $MAIN_BRANCH ..." -ForegroundColor White
        git pull --rebase $REMOTE_COMPLETO $MAIN_BRANCH 2>&1 | Out-Null
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

function Invoke-GitPushCompleto {
    # Publica el contenido COMPLETO en el repo COMPLETO (remote origin)
    Push-Location $REPO_DIR
    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        Write-Host "  git push -u $REMOTE_COMPLETO $MAIN_BRANCH (repo COMPLETO) ..." -ForegroundColor White
        $pushOut = git push -u $REMOTE_COMPLETO $MAIN_BRANCH 2>&1
        if ($LASTEXITCODE -ne 0) {
            Write-Host "  ERROR: el push al repo COMPLETO fallo (exit $LASTEXITCODE):" -ForegroundColor Red
            Write-Host ($pushOut -join "`n") -ForegroundColor Red
            Write-Host "  Manual: cd $REPO_DIR ; git push -u $REMOTE_COMPLETO $MAIN_BRANCH" -ForegroundColor Yellow
            exit 1
        }
        Write-Host "  Repo COMPLETO publicado." -ForegroundColor Green
    }
    finally {
        $ErrorActionPreference = $prevEAP
        Pop-Location
    }
}

function Publish-OperativoRepo {
    # Publica el paquete OPERATIVO de seis elementos en el repo OPERATIVO (remote 'operativo').
    # Mismo mecanismo probado de la rama operativo (espejo podado de main con la lista
    # cerrada OPERATIVO_KEEP), ahora empujando a su PROPIO repositorio (conciliacion V1).
    Push-Location $REPO_DIR
    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        Write-Host "  Preparando el paquete operativo (seis elementos)..." -ForegroundColor White

        git rev-parse --verify $OPERATIVO_BRANCH 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) {
            git fetch $REMOTE_OPERATIVO $OPERATIVO_BRANCH 2>&1 | Out-Null
            git rev-parse --verify "$REMOTE_OPERATIVO/$OPERATIVO_BRANCH" 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) {
                git checkout -b $OPERATIVO_BRANCH "$REMOTE_OPERATIVO/$OPERATIVO_BRANCH" 2>&1 | Out-Null
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

        # Poda: en operativo solo queda el paquete de seis elementos
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
        $syncOut = git commit -m "v$($ManifestGlobal.Version): paquete operativo (seis elementos) desde la entrega" 2>&1
        $syncExit = $LASTEXITCODE
        if ($syncExit -eq 0) {
            Write-Host "  git push -u $REMOTE_OPERATIVO $OPERATIVO_BRANCH (repo OPERATIVO) ..." -ForegroundColor White
            git push -u $REMOTE_OPERATIVO $OPERATIVO_BRANCH 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "  Repo OPERATIVO publicado (paquete de seis elementos)." -ForegroundColor Green
            } else {
                Write-Host "  ATENCION: el push al repo OPERATIVO fallo (exit $LASTEXITCODE). Verifique que el repo existe en GitHub y reejecute el push:" -ForegroundColor Yellow
                Write-Host "    cd $REPO_DIR ; git push -u $REMOTE_OPERATIVO $OPERATIVO_BRANCH" -ForegroundColor Yellow
            }
        } elseif (($syncOut -join " ") -match "nothing to commit") {
            Write-Host "  Paquete operativo ya estaba sincronizado." -ForegroundColor DarkGray
        } else {
            Write-Fatal ("Fallo el commit del paquete operativo:`n" + ($syncOut -join "`n"))
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
    # DIFF entre el repo COMPLETO de GitHub (tras actualizar) y la carpeta local.
    # Verifica DIFF CERO y guarda SIEMPRE el informe en Downloads (UTF-8 correcto, fix v3.1;
    # fix v4.0.2: tambien en estado "sin cambios").
    param([string]$Version, [string]$CommitState)

    $dlDir = Get-DownloadsDir
    if ($dlDir -eq "" -or -not (Test-Path $dlDir)) { $dlDir = (Get-TempRoot) }

    Push-Location $REPO_DIR
    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        # Informe DIFF: se genera SIEMPRE (fix v4.0.2: en "sin cambios" antes no habia txt).
        $diffFile = Join-Path $dlDir ("DIFF_ENTREGA_estrategia_v" + $Version + ".txt")
        # PowerShell 5.1 decodifica la salida de git con la codepage OEM (CP850 en
        # consolas espanolas) y el informe sale con los acentos rotos (mojibake). Se fuerza
        # UTF-8 solo durante la captura del diff y se restaura al terminar (fix v3.1, S53).
        $prevConsoleEnc = [Console]::OutputEncoding
        try { [Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch { }
        if ($CommitState -eq "ok") {
            # Diff de la entrega: cambios introducidos por esta version
            $hasParent = $true
            git rev-parse HEAD~1 2>&1 | Out-Null
            if ($LASTEXITCODE -ne 0) { $hasParent = $false }
            if ($hasParent) {
                Write-Host "  Diff de la entrega (HEAD~1 -> HEAD):" -ForegroundColor White
                git diff --stat HEAD~1 HEAD | ForEach-Object { Write-Host "    $_" -ForegroundColor DarkGray }
                git diff HEAD~1 HEAD | Out-File -FilePath $diffFile -Encoding utf8
                Write-Host "  Diff completo guardado en: $diffFile" -ForegroundColor Green
            } else {
                ("# DIFF_ENTREGA estrategia v$Version -- primer commit del repo: sin diff disponible.") |
                    Out-File -FilePath $diffFile -Encoding utf8
                Write-Host "  Diff de la entrega no disponible (primer commit del repo)." -ForegroundColor Yellow
            }
        } else {
            # La entrega ya estaba aplicada: sin cambios en el repo local. El informe se
            # escribe igual (fix v4.0.2), con nota y el diff contra GitHub (esperado vacio).
            $notas = @(
                "# DIFF_ENTREGA estrategia v$Version -- SIN CAMBIOS en el repo local",
                "# La entrega ya estaba aplicada: no hay diff HEAD~1 -> HEAD que generar."
            )
            if (-not $NoPush) {
                git fetch $REMOTE_COMPLETO $MAIN_BRANCH 2>&1 | Out-Null
                $notas += "# Diff $REMOTE_COMPLETO/$MAIN_BRANCH -> HEAD (esperado vacio):"
                $notas += (git diff "$REMOTE_COMPLETO/$MAIN_BRANCH" HEAD)
            } else {
                $notas += "# Modo -NoPush: diff contra GitHub omitido."
            }
            $notas | Out-File -FilePath $diffFile -Encoding utf8
            Write-Host "  Sin nuevos cambios en el repo local. Informe guardado en: $diffFile" -ForegroundColor Green
        }
        try { [Console]::OutputEncoding = $prevConsoleEnc } catch { }

        if ($NoPush) {
            Write-Host "  Modo -NoPush: GitHub no se ha actualizado; diff cero contra GitHub omitido." -ForegroundColor Yellow
            return
        }

        git fetch $REMOTE_COMPLETO $MAIN_BRANCH 2>&1 | Out-Null
        $gh = (git rev-parse "$REMOTE_COMPLETO/$MAIN_BRANCH").Trim()
        $loc = (git rev-parse HEAD).Trim()
        $dirty = (git status --porcelain) -join "`n"
        if ($gh -eq $loc -and $dirty.Trim() -eq "") {
            Write-Host "  DIFF CERO verificado: repo COMPLETO (GitHub) y carpeta local identicos." -ForegroundColor Green
        } else {
            Write-Host "  ATENCION: el repo COMPLETO y la carpeta local NO coinciden:" -ForegroundColor Red
            Write-Host ("    $REMOTE_COMPLETO/$MAIN_BRANCH : $gh   |   HEAD local: $loc") -ForegroundColor Red
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

$REPO_DIR = ""

# --- Preguntas con valores predeterminados (conciliacion V6; Enter = predeterminado) ---
# Orden conciliado: 1) carpeta del .zip, 2) carpeta local, 3) repos GitHub a publicar
$zipFinal = Select-ZipPath
$REPO_DIR = Ask-Value -Prompt "Carpeta del repo local (se borra y se reemplaza)" -Default $DEFAULT_REPO_DIR -Forced $RepoDir
if ($NoPush) {
    $CompletoUrlFinal = $DEFAULT_COMPLETO_URL
    $OperativoUrlFinal = $DEFAULT_OPERATIVO_URL
    Write-Host "  Modo -NoPush: se usan las URLs por defecto sin publicar en GitHub." -ForegroundColor Yellow
} else {
    $CompletoUrlFinal = Ask-Value -Prompt "Repo GitHub COMPLETO a publicar" -Default $DEFAULT_COMPLETO_URL -Forced $CompletoUrl
    $OperativoUrlFinal = Ask-Value -Prompt "Repo GitHub OPERATIVO a publicar" -Default $DEFAULT_OPERATIVO_URL -Forced $OperativoUrl
}

Write-Host ""
Write-Host "  Operacion : borrado total + entrega .zip integra + 2 repos GitHub + diff" -ForegroundColor White
Write-Host "  .zip      : $zipFinal" -ForegroundColor White
Write-Host "  Repo local: $REPO_DIR" -ForegroundColor White
if ($NoPush) { Write-Host "  GitHub    : NO (modo -NoPush, solo repo local)" -ForegroundColor Yellow }
else {
    Write-Host "  GitHub    : COMPLETO -> $CompletoUrlFinal" -ForegroundColor White
    Write-Host "              OPERATIVO -> $OperativoUrlFinal" -ForegroundColor White
}
if ($DryRun)  { Write-Host "  Modo      : SIMULACION (-DryRun, no cambia nada)" -ForegroundColor Yellow }
Write-Host ""

# Verificacion de integridad de la entrega (umbral cero) ANTES de tocar el repo
$delivery = Test-Delivery -Zip $zipFinal
$m = $delivery.Manifest
$ManifestGlobal = $m

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

# 1) Repositorio garantizado ANTES de borrar nada (remotes ya configurados)
Ensure-Repo

# 2) BORRADO TOTAL del contenido del repo local (excepto .git) -- orden del Director.
#    Sustituye a la purga ELIMINADOS: el borrado cubre tambien los archivos retirados.
Clear-RepoContent

# 3) Descompresion INTEGRA de la entrega sobre la carpeta del proyecto
$result = Apply-Delivery -Delivery $delivery
Remove-Item $delivery.TempDir -Recurse -Force -ErrorAction SilentlyContinue
Write-Host ""
Write-Host "  Aplicado: $($result.Copied) elementos escritos desde el .zip (reemplazo total)." -ForegroundColor Green

# 4) Publicacion en los DOS repos (conciliacion V1): commit + push completo + paquete operativo
$commitMsg = "v$($m.Version): reemplazo total desde entrega .zip (manifest SHA256 verificado)"
$commitState = Invoke-GitCommit -CommitMsg $commitMsg

if (-not $NoPush) {
    if ($commitState -eq "ok") {
        Invoke-GitPushCompleto
    } else {
        Write-Host "  Sin cambios en el repo COMPLETO: no se requiere push." -ForegroundColor Yellow
    }
    # El paquete OPERATIVO se publica SIEMPRE (si no hubo cambios, queda verificado)
    Publish-OperativoRepo
}

# 5) DIFF repo COMPLETO (tras actualizar) vs carpeta local modificada por la implementacion
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
if (-not $NoPush) {
    Write-Host "  GitHub    : repo COMPLETO actualizado + paquete OPERATIVO publicado" -ForegroundColor Green
}
Write-Host ""
Write-Host "  Siguiente paso del agente: re-clonado final (I.3e) al confirmarle el push." -ForegroundColor Cyan
Write-Host ""
exit 0
