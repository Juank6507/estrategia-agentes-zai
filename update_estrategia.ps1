# update_estrategia.ps1 -- Actualizacion de estrategia Z.ai v1.1
# ASCII-only: sin em-dash, sin smart quotes, sin caracteres Unicode especiales
# Uso: Extraer este archivo del .zip y ejecutarlo desde la carpeta del proyecto:
#   powershell -ExecutionPolicy Bypass -File .\update_estrategia.ps1

$ErrorActionPreference = "Stop"

# ============================================================
#  CONFIGURACION
# ============================================================

$REPO_URL = "https://github.com/Juank6507/estrategia-agentes-zai.git"
$REPO_DIR = $PSScriptRoot
if (-not $REPO_DIR) { $REPO_DIR = Get-Location }

# Archivos que contiene el .zip (estructura v1.1)
$ZIP_FILES = @(
    "agent-context\contrato.md",
    "agent-context\entorno.md",
    "agent-context\comunicacion.md",
    "agent-context\identidad.md",
    "agent-context\dcpa.md",
    "agent-context\proyecto.md",
    "agent-learn\lecciones_aprendidas.md",
    "agent-learn\patrones_recurrentes.md",
    "agent-learn\anti_patrones.md",
    "agent-learn\errores_comunes.md",
    "agent-learn\preferencias_director.md",
    "agent-learn\experiencias.md",
    "meta\spec_estrategia_v1.1.md",
    "meta\plan_estrategia_v1.1.md",
    "meta\historial_versiones.md",
    "meta\tareas_inmediatas.md",
    "meta\director-only\informe_estrategia_v1.1.md",
    "meta\director-only\prompt_inicio_sesion.txt",
    "meta\director-only\prompt_templates.md",
    "prompt_arranque.md",
    "worklog_template.md",
    "tareas_inmediatas.md"
)

# ============================================================
#  FUNCIONES AUXILIARES
# ============================================================

function Write-Title {
    Write-Host ""
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "  ACTUALIZACION DE ESTRATEGIA Z.ai v1.1" -ForegroundColor Cyan
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host ""
}

function Find-ZipFile {
    # Intentar localizar estrategia.zip en ubicaciones comunes
    $searchPaths = @(
        "$env:USERPROFILE\Downloads\estrategia.zip",
        "$env:USERPROFILE\Downloads\estrategia_v1.1.zip",
        "$env:USERPROFILE\Desktop\estrategia.zip",
        "$env:USERPROFILE\Desktop\estrategia_v1.1.zip",
        "$REPO_DIR\estrategia.zip",
        "$REPO_DIR\estrategia_v1.1.zip"
    )

    foreach ($p in $searchPaths) {
        if (Test-Path $p) {
            return $p
        }
    }
    return $null
}

function Ask-ZipPath {
    $autoFound = Find-ZipFile
    if ($autoFound) {
        Write-Host "  .zip encontrado: $autoFound" -ForegroundColor Green
        Write-Host "  (Enter = usar este archivo)" -ForegroundColor DarkGray
        $useAuto = Read-Host "  Usar otro? (N = no, Enter = usar este)"
        if ($useAuto -eq "" -or $useAuto -eq "N" -or $useAuto -eq "n") {
            return $autoFound
        }
    }

    # Buscar todos los .zip en Downloads como sugerencia
    $downloadsZip = Get-ChildItem -Path "$env:USERPROFILE\Downloads" -Filter "estrategia*.zip" -ErrorAction SilentlyContinue
    if ($downloadsZip) {
        Write-Host ""
        Write-Host "  Archivos .zip encontrados en Downloads:" -ForegroundColor Yellow
        $i = 1
        foreach ($f in $downloadsZip) {
            Write-Host "    $i) $($f.FullName)" -ForegroundColor Yellow
            $i++
        }
        Write-Host ""
    }

    Write-Host "  Ingrese la ruta completa al archivo .zip" -ForegroundColor White
    Write-Host "  (o arrastre el archivo aqui y presione Enter)" -ForegroundColor White
    $manualPath = Read-Host "  Ruta"

    # Limpiar comillas si el usuario arrastro el archivo
    $manualPath = $manualPath.Trim().Trim('"').Trim("'")

    if (-not (Test-Path $manualPath)) {
        Write-Host "  ERROR: No se encuentra el archivo en: $manualPath" -ForegroundColor Red
        return $null
    }
    return $manualPath
}

function Ensure-SubDirs {
    # Crear subdirectorios necesarios si no existen
    $dirs = @(
        "agent-context",
        "agent-learn",
        "meta",
        "meta\director-only"
    )
    foreach ($d in $dirs) {
        $fullPath = Join-Path $REPO_DIR $d
        if (-not (Test-Path $fullPath)) {
            New-Item -ItemType Directory -Path $fullPath -Force | Out-Null
            Write-Host "  Creado: $d\" -ForegroundColor DarkGray
        }
    }
}

function Copy-FromZip {
    param([string]$ZipPath)

    # Crear directorio temporal para extraer
    $tempDir = Join-Path $env:TEMP "estrategia_zip_extract_$(Get-Random)"
    
    try {
        Write-Host "  Extrayendo .zip..." -ForegroundColor White
        Expand-Archive -Path $ZipPath -DestinationPath $tempDir -Force

        # La estructura dentro del .zip puede ser:
        #   estrategia\archivo.md  (carpeta raiz "estrategia")
        #   archivo.md            (directamente en la raiz)
        # Buscar la carpeta raiz correcta
        $zipRoot = $tempDir
        
        # Si hay una unica carpeta llamada "estrategia", usarla como raiz
        $topItems = Get-ChildItem $tempDir
        if ($topItems.Count -eq 1 -and $topItems[0].PSIsContainer -and $topItems[0].Name -eq "estrategia") {
            $zipRoot = $topItems[0].FullName
        }

        # Si hay una carpeta "estrategia" junto con update_estrategia.ps1
        $estrategiaSubDir = Join-Path $tempDir "estrategia"
        if (Test-Path $estrategiaSubDir) {
            # Verificar si tiene archivos .md adentro
            $mdFiles = Get-ChildItem $estrategiaSubDir -Filter "*.md" -Recurse -ErrorAction SilentlyContinue
            if ($mdFiles) {
                $zipRoot = $estrategiaSubDir
            }
        }

        Write-Host "  Raiz del .zip detectada: $zipRoot" -ForegroundColor DarkGray

        # Crear subdirectorios necesarios en el repo
        Ensure-SubDirs

        # Copiar cada archivo esperado
        $copiedCount = 0
        $missingCount = 0

        foreach ($relPath in $ZIP_FILES) {
            $srcFile = Join-Path $zipRoot $relPath
            $dstFile = Join-Path $REPO_DIR $relPath

            if (Test-Path $srcFile) {
                # Crear directorio destino si no existe
                $dstDir = Split-Path $dstFile -Parent
                if (-not (Test-Path $dstDir)) {
                    New-Item -ItemType Directory -Path $dstDir -Force | Out-Null
                }
                Copy-Item -Path $srcFile -Destination $dstFile -Force
                Write-Host "  OK: $relPath" -ForegroundColor Green
                $copiedCount++
            } else {
                Write-Host "  FALTA en .zip: $relPath" -ForegroundColor Yellow
                $missingCount++
            }
        }

        # Tambien copiar update_estrategia.ps1 si esta en el .zip
        $scriptSrc = Join-Path $tempDir "update_estrategia.ps1"
        if (Test-Path $scriptSrc) {
            $scriptDst = Join-Path $REPO_DIR "update_estrategia.ps1"
            Copy-Item -Path $scriptSrc -Destination $scriptDst -Force
            Write-Host "  OK: update_estrategia.ps1" -ForegroundColor Green
            $copiedCount++
        }

        # Copiar archivos extra no en la lista (otros .md encontrados)
        $allMdInZip = Get-ChildItem $zipRoot -Filter "*.md" -Recurse -ErrorAction SilentlyContinue
        foreach ($md in $allMdInZip) {
            $rel = $md.FullName.Substring($zipRoot.Length + 1)
            $dstFile = Join-Path $REPO_DIR $rel
            if (-not (Test-Path $dstFile)) {
                $dstDir = Split-Path $dstFile -Parent
                if (-not (Test-Path $dstDir)) {
                    New-Item -ItemType Directory -Path $dstDir -Force | Out-Null
                }
                Copy-Item -Path $md.FullName -Destination $dstFile -Force
                Write-Host "  OK (extra): $rel" -ForegroundColor DarkGreen
                $copiedCount++
            }
        }

        Write-Host ""
        Write-Host "  Resumen de copia:" -ForegroundColor White
        Write-Host "    Archivos copiados: $copiedCount" -ForegroundColor Green
        Write-Host "    Archivos faltantes: $missingCount" -ForegroundColor Yellow

        return $true
    }
    catch {
        Write-Host "  ERROR al extraer/copiar: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
    finally {
        # Limpiar directorio temporal
        if (Test-Path $tempDir) {
            Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

function Do-GitPush {
    param([string]$CommitMsg)

    Push-Location $REPO_DIR

    # Desactivar ErrorActionPreference para git (git escribe progreso por stderr)
    $prevEAP = $ErrorActionPreference
    $ErrorActionPreference = "Continue"

    try {
        # Verificar que es un repo git
        $isGitRepo = Test-Path ".git"
        if (-not $isGitRepo) {
            Write-Host "  Inicializando repo git..." -ForegroundColor White
            git init 2>&1 | Out-Null
            git remote add origin $REPO_URL 2>&1 | Out-Null
        }

        # Verificar remote
        $remoteUrl = (git remote get-url origin 2>$null)
        if ($remoteUrl -ne $REPO_URL) {
            Write-Host "  Configurando remote origin..." -ForegroundColor White
            git remote set-url origin $REPO_URL 2>&1 | Out-Null
        }

        # Add
        Write-Host "  Ejecutando git add..." -ForegroundColor White
        git add -A 2>&1 | Out-Null

        # Commit
        Write-Host "  Ejecutando git commit..." -ForegroundColor White
        git commit -m $CommitMsg 2>&1 | Out-Null

        # Pull --rebase (sincronizar con remoto antes de push)
        Write-Host "  Ejecutando git pull --rebase..." -ForegroundColor White
        git pull --rebase origin main 2>&1 | Out-Null
        $pullExit = $LASTEXITCODE
        if ($pullExit -ne 0) {
            Write-Host "  Aviso: pull --rebase tuvo conflictos (exit $pullExit), continuando..." -ForegroundColor Yellow
        }

        # Push
        Write-Host "  Ejecutando git push..." -ForegroundColor White
        $branch = (git branch --show-current 2>$null)
        if (-not $branch) { $branch = "main" }
        $pushOutput = (git push -u origin $branch 2>&1)
        $pushExit = $LASTEXITCODE

        if ($pushExit -eq 0) {
            Write-Host "  Push completado correctamente." -ForegroundColor Green
        } else {
            Write-Host "  ERROR: Push fallo (exit $pushExit)." -ForegroundColor Red
            Write-Host "  Salida: $pushOutput" -ForegroundColor Red
            Write-Host "  Intenta manualmente:" -ForegroundColor Yellow
            Write-Host "    cd $REPO_DIR" -ForegroundColor Yellow
            Write-Host "    git pull --rebase origin main" -ForegroundColor Yellow
            Write-Host "    git push -u origin main" -ForegroundColor Yellow
        }
    }
    finally {
        $ErrorActionPreference = $prevEAP
        Pop-Location
    }
}

function Do-SyncOnly {
    # Solo clonar/pull del repo operativo
    try {
        if (Test-Path (Join-Path $REPO_DIR ".git")) {
            Write-Host "  Repo existe. Ejecutando git pull..." -ForegroundColor White
            Push-Location $REPO_DIR
            git pull
            Pop-Location
        } else {
            Write-Host "  Clonando repo..." -ForegroundColor White
            git clone $REPO_URL $REPO_DIR
        }
        Write-Host "  Sincronizacion completada." -ForegroundColor Green
    }
    catch {
        Write-Host "  ERROR en sync: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# ============================================================
#  INTERFAZ PRINCIPAL
# ============================================================

Write-Title

# --- PREGUNTA 1: Tipo de operacion ---
Write-Host "PREGUNTA 1: Tipo de operacion" -ForegroundColor White
Write-Host "  1) zip    -- Actualizar desde .zip (reemplazar archivos + push a GitHub)"
Write-Host "  2) push   -- Solo push del repo local a GitHub (sin .zip)"
Write-Host "  3) sync   -- Solo sincronizar repo operativo (clonar + copiar archivos)"
Write-Host ""
$operacion = Read-Host "Seleccione operacion (Enter = 1/zip)"

if ($operacion -eq "") { $operacion = "1" }

switch ($operacion) {
    "1" { $opName = "zip" }
    "2" { $opName = "push" }
    "3" { $opName = "sync" }
    default {
        Write-Host "  Operacion no valida. Saliendo." -ForegroundColor Red
        exit 1
    }
}
Write-Host "  Operacion seleccionada: $opName" -ForegroundColor Green

# --- PREGUNTA 2: Mensaje de commit ---
$commitMsg = ""
$doPush = $false

if ($opName -eq "zip" -or $opName -eq "push") {
    Write-Host ""
    Write-Host "PREGUNTA 2: Mensaje de commit" -ForegroundColor White
    $defaultMsg = "v1.1: actualizacion de estrategia"
    $inputMsg = Read-Host "Mensaje (Enter = '$defaultMsg')"
    if ($inputMsg.Trim() -eq "") {
        $commitMsg = $defaultMsg
    } else {
        $commitMsg = $inputMsg
    }
    Write-Host "  Mensaje: $commitMsg" -ForegroundColor Green

    # --- PREGUNTA 3: Push a GitHub ---
    Write-Host ""
    Write-Host "PREGUNTA 3: Actualizar repo operativo en GitHub?" -ForegroundColor White
    $pushInput = Read-Host "Si (S) / No (N) (Enter = S)"
    if ($pushInput -ne "N" -and $pushInput -ne "n") {
        $doPush = $true
    }
}

# --- PREGUNTA 4 (solo para zip): Ruta del .zip ---
$zipPath = ""
if ($opName -eq "zip") {
    Write-Host ""
    $zipAutoFound = Find-ZipFile
    if ($zipAutoFound) {
        Write-Host "PREGUNTA 4: Archivo .zip" -ForegroundColor White
        Write-Host "  Detectado: $zipAutoFound" -ForegroundColor Green
        Write-Host "  (Enter = usar este archivo)" -ForegroundColor DarkGray
        $zipInput = Read-Host "  Usar otro .zip? (N = no, Enter = usar detectado)"
        if ($zipInput -eq "" -or $zipInput -eq "N" -or $zipInput -eq "n") {
            $zipPath = $zipAutoFound
        } else {
            # Pedir ruta manual
            Write-Host "  Ingrese la ruta completa al archivo .zip" -ForegroundColor White
            $manualPath = Read-Host "  Ruta"
            $manualPath = $manualPath.Trim().Trim('"').Trim("'")
            if (Test-Path $manualPath) {
                $zipPath = $manualPath
            } else {
                Write-Host "  ERROR: No se encuentra: $manualPath" -ForegroundColor Red
                exit 1
            }
        }
    } else {
        Write-Host "PREGUNTA 4: Archivo .zip" -ForegroundColor White
        Write-Host "  No se encontro automaticamente." -ForegroundColor Yellow
        $downloadsZip = Get-ChildItem -Path "$env:USERPROFILE\Downloads" -Filter "estrategia*.zip" -ErrorAction SilentlyContinue
        if ($downloadsZip) {
            Write-Host "  .zip en Downloads:" -ForegroundColor Yellow
            $i = 1
            foreach ($f in $downloadsZip) {
                Write-Host "    $i) $($f.FullName)" -ForegroundColor Yellow
                $i++
            }
        }
        Write-Host "  Ingrese ruta (o arrastre archivo aqui):" -ForegroundColor White
        $manualPath = Read-Host "  Ruta"
        $manualPath = $manualPath.Trim().Trim('"').Trim("'")
        if ((Test-Path $manualPath) -eq $true) {
            $zipPath = $manualPath
        } else {
            Write-Host "  ERROR: No se pudo localizar el .zip. Saliendo." -ForegroundColor Red
            exit 1
        }
    }
}

# --- RESUMEN ---
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  RESUMEN DE OPERACION" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Operacion:        $opName"
if ($opName -eq "zip" -or $opName -eq "push") {
    Write-Host "  Mensaje commit:   $commitMsg"
    Write-Host "  Actualizar GitHub: $(if ($doPush) {'Si'} else {'No'})"
}
Write-Host "  Carpeta local:    $REPO_DIR"
if ($opName -eq "zip") {
    Write-Host "  Archivo .zip:     $zipPath"
}
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# --- CONFIRMAR ---
$confirm = Read-Host "Confirmar ejecucion? (Enter = Si / N = No)"
if ($confirm -eq "N" -or $confirm -eq "n") {
    Write-Host "  Operacion cancelada." -ForegroundColor Yellow
    exit 0
}

# --- EJECUTAR ---
Write-Host ""
Write-Host "Ejecutando..." -ForegroundColor White

switch ($opName) {
    "zip" {
        # Paso 1: Copiar archivos del .zip
        $copyOk = Copy-FromZip -ZipPath $zipPath
        if (-not $copyOk) {
            Write-Host "  ERROR: Fallo la copia desde .zip." -ForegroundColor Red
            exit 1
        }

        # Paso 2: Push a GitHub
        if ($doPush) {
            Write-Host ""
            Do-GitPush -CommitMsg $commitMsg
        }
    }

    "push" {
        if ($doPush) {
            Do-GitPush -CommitMsg $commitMsg
        } else {
            Write-Host "  No se solicito push. Nada que hacer." -ForegroundColor Yellow
        }
    }

    "sync" {
        Do-SyncOnly
    }
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  ACTUALIZACION COMPLETADA" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Verifique los archivos en: $REPO_DIR" -ForegroundColor White
Write-Host ""
