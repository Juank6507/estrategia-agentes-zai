# =============================================================================
# update_estrategia.ps1 — Script de actualización de estrategia Z.ai v1.1
# =============================================================================
# Uso: Ejecutar desde cualquier ubicación. El script es interactivo.
# Función: Automatiza la actualización de los repos de estrategia desde .zip
# =============================================================================

# --- Rutas predeterminadas ---
$LOCAL_COMPLETO   = "C:\Python\Proyectos\estrategia"
$ZIP_PATH         = "C:\Users\juanc\Downloads\estrategia.zip"
$REPO_OPERATIVO   = "https://github.com/Juank6507/estrategia-agentes-zai.git"
$TMP_OPERATIVO    = "C:\Python\Proyectos\tmp_operativo"

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  ACTUALIZACIÓN DE ESTRATEGIA Z.ai v1.1" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# --- Pregunta 1: Tipo de operación ---
Write-Host "PREGUNTA 1: Tipo de operación" -ForegroundColor Yellow
Write-Host "  1) zip    — Actualizar desde .zip (reemplazar archivos locales + push a GitHub)"
Write-Host "  2) push   — Solo push del repo local a GitHub (sin .zip)"
Write-Host "  3) sync   — Solo sincronizar repo operativo (clonar + copiar archivos operatives)"
Write-Host ""
$operacion = Read-Host "Seleccione operación (1/2/3)"

switch ($operacion) {
    "1" { $OP = "zip" }
    "2" { $OP = "push" }
    "3" { $OP = "sync" }
    default {
        Write-Host "Operación no válida. Saliendo." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "Operación seleccionada: $OP" -ForegroundColor Green

# --- Pregunta 2: Mensaje de commit ---
Write-Host ""
Write-Host "PREGUNTA 2: Mensaje de commit" -ForegroundColor Yellow
$commit_msg = Read-Host "Ingrese mensaje de commit (Enter para usar default)"
if ([string]::IsNullOrWhiteSpace($commit_msg)) {
    $commit_msg = "Actualización estrategia v1.1"
}
Write-Host "Mensaje: $commit_msg" -ForegroundColor Green

# --- Pregunta 3: Actualizar repo operativo ---
Write-Host ""
Write-Host "PREGUNTA 3: ¿Actualizar repo operativo en GitHub?" -ForegroundColor Yellow
$update_operativo = Read-Host "Sí (S) / No (N) (Enter = S)"
if ([string]::IsNullOrWhiteSpace($update_operativo)) {
    $update_operativo = "S"
}

# --- Pregunta 4: Confirmación ---
Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  RESUMEN DE OPERACIÓN" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Operación:        $OP"
Write-Host "  Mensaje commit:   $commit_msg"
Write-Host "  Actualizar GitHub: $update_operativo"
Write-Host "  Carpeta local:    $LOCAL_COMPLETO"
if ($OP -eq "zip") {
    Write-Host "  Archivo .zip:     $ZIP_PATH"
}
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
$confirmar = Read-Host "¿Confirmar ejecución? (S/N)"
if ($confirmar -ne "S") {
    Write-Host "Operación cancelada." -ForegroundColor Red
    exit 0
}

# =============================================================================
# EJECUCIÓN
# =============================================================================

Write-Host ""
Write-Host "Ejecutando..." -ForegroundColor Yellow

# --- Operación: ZIP ---
if ($OP -eq "zip") {
    
    # Verificar que el .zip existe
    if (-not (Test-Path $ZIP_PATH)) {
        Write-Host "ERROR: No se encuentra el archivo .zip en: $ZIP_PATH" -ForegroundColor Red
        exit 1
    }

    # Verificar que la carpeta local existe
    if (-not (Test-Path $LOCAL_COMPLETO)) {
        Write-Host "ERROR: No se encuentra la carpeta local: $LOCAL_COMPLETO" -ForegroundColor Red
        exit 1
    }

    # Paso 1: Eliminar archivos previos (preservando .git)
    Write-Host ""
    Write-Host "Paso 1: Eliminando archivos previos (preservando .git)..." -ForegroundColor Yellow
    Push-Location $LOCAL_COMPLETO
    Get-ChildItem -Path . -Exclude .git | Remove-Item -Recurse -Force
    Write-Host "  ✓ Archivos previos eliminados" -ForegroundColor Green

    # Paso 2: Desempaquetar .zip
    Write-Host ""
    Write-Host "Paso 2: Desempaquetando .zip..." -ForegroundColor Yellow
    Expand-Archive -Path $ZIP_PATH -DestinationPath "." -Force
    Write-Host "  ✓ .zip desempaquetado" -ForegroundColor Green
    Pop-Location

    # Paso 3: Commit y push del repo completo (local)
    Write-Host ""
    Write-Host "Paso 3: Commit en repo local..." -ForegroundColor Yellow
    Push-Location $LOCAL_COMPLETO
    git add -A
    git commit -m $commit_msg
    Write-Host "  ✓ Commit realizado" -ForegroundColor Green
    Pop-Location

    # Paso 4: Actualizar repo operativo en GitHub
    if ($update_operativo -eq "S") {
        Write-Host ""
        Write-Host "Paso 4: Actualizando repo operativo en GitHub..." -ForegroundColor Yellow
        
        # Crear carpeta temporal si no existe
        if (Test-Path $TMP_OPERATIVO) {
            Remove-Item -Path $TMP_OPERATIVO -Recurse -Force
        }
        New-Item -ItemType Directory -Path $TMP_OPERATIVO | Out-Null

        # Clonar repo operativo
        Push-Location $TMP_OPERATIVO
        git clone $REPO_OPERATIVO .
        
        # Copiar archivos operatives del completo al operativo
        # agent-context/
        $operativoDir = Join-Path $TMP_OPERATIVO "agent-context"
        $completoContextDir = Join-Path $LOCAL_COMPLETO "agent-context"
        if (-not (Test-Path $operativoDir)) {
            New-Item -ItemType Directory -Path $operativoDir | Out-Null
        }
        Copy-Item -Path "$completoContextDir\*" -Destination $operativoDir -Recurse -Force

        # agent-learn/
        $operativoLearnDir = Join-Path $TMP_OPERATIVO "agent-learn"
        $completoLearnDir = Join-Path $LOCAL_COMPLETO "agent-learn"
        if (-not (Test-Path $operativoLearnDir)) {
            New-Item -ItemType Directory -Path $operativoLearnDir | Out-Null
        }
        Copy-Item -Path "$completoLearnDir\*" -Destination $operativoLearnDir -Recurse -Force

        # worklog_template.md
        $completoWorklog = Join-Path $LOCAL_COMPLETO "worklog_template.md"
        Copy-Item -Path $completoWorklog -Destination $TMP_OPERATIVO -Force

        # Commit y push
        git add -A
        git commit -m $commit_msg
        git push origin main
        
        Write-Host "  ✓ Repo operativo actualizado en GitHub" -ForegroundColor Green
        Pop-Location

        # Limpiar temporal
        Remove-Item -Path $TMP_OPERATIVO -Recurse -Force
        Write-Host "  ✓ Carpeta temporal eliminada" -ForegroundColor Green
    }

    Write-Host ""
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "  ACTUALIZACIÓN DESDE .ZIP COMPLETADA" -ForegroundColor Green
    Write-Host "============================================" -ForegroundColor Cyan
}

# --- Operación: PUSH ---
if ($OP -eq "push") {
    
    Write-Host ""
    Write-Host "Paso 1: Commit en repo local..." -ForegroundColor Yellow
    Push-Location $LOCAL_COMPLETO
    git add -A
    git commit -m $commit_msg
    Write-Host "  ✓ Commit realizado" -ForegroundColor Green
    Pop-Location

    if ($update_operativo -eq "S") {
        Write-Host ""
        Write-Host "Paso 2: Push al repo operativo..." -ForegroundColor Yellow
        Push-Location $TMP_OPERATIVO
        git clone $REPO_OPERATIVO .
        
        # Copiar archivos operatives
        $operativoDir = Join-Path $TMP_OPERATIVO "agent-context"
        $completoContextDir = Join-Path $LOCAL_COMPLETO "agent-context"
        if (-not (Test-Path $operativoDir)) {
            New-Item -ItemType Directory -Path $operativoDir | Out-Null
        }
        Copy-Item -Path "$completoContextDir\*" -Destination $operativoDir -Recurse -Force

        $operativoLearnDir = Join-Path $TMP_OPERATIVO "agent-learn"
        $completoLearnDir = Join-Path $LOCAL_COMPLETO "agent-learn"
        if (-not (Test-Path $operativoLearnDir)) {
            New-Item -ItemType Directory -Path $operativoLearnDir | Out-Null
        }
        Copy-Item -Path "$completoLearnDir\*" -Destination $operativoLearnDir -Recurse -Force

        $completoWorklog = Join-Path $LOCAL_COMPLETO "worklog_template.md"
        Copy-Item -Path $completoWorklog -Destination $TMP_OPERATIVO -Force

        git add -A
        git commit -m $commit_msg
        git push origin main
        Write-Host "  ✓ Push realizado" -ForegroundColor Green
        Pop-Location

        Remove-Item -Path $TMP_OPERATIVO -Recurse -Force
    }

    Write-Host ""
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "  PUSH COMPLETADO" -ForegroundColor Green
    Write-Host "============================================" -ForegroundColor Cyan
}

# --- Operación: SYNC ---
if ($OP -eq "sync") {
    
    Write-Host ""
    Write-Host "Paso 1: Clonando repo operativo..." -ForegroundColor Yellow
    if (Test-Path $TMP_OPERATIVO) {
        Remove-Item -Path $TMP_OPERATIVO -Recurse -Force
    }
    New-Item -ItemType Directory -Path $TMP_OPERATIVO | Out-Null
    Push-Location $TMP_OPERATIVO
    git clone $REPO_OPERATIVO .
    Write-Host "  ✓ Repo operativo clonado" -ForegroundColor Green

    # Copiar archivos operatives al repo completo local
    Write-Host ""
    Write-Host "Paso 2: Copiando archivos operatives al repo local..." -ForegroundColor Yellow
    
    $operativoContextDir = Join-Path $TMP_OPERATIVO "agent-context"
    $completoContextDir = Join-Path $LOCAL_COMPLETO "agent-context"
    Copy-Item -Path "$operativoContextDir\*" -Destination $completoContextDir -Recurse -Force

    $operativoLearnDir = Join-Path $TMP_OPERATIVO "agent-learn"
    $completoLearnDir = Join-Path $LOCAL_COMPLETO "agent-learn"
    Copy-Item -Path "$operativoLearnDir\*" -Destination $completoLearnDir -Recurse -Force

    $operativoWorklog = Join-Path $TMP_OPERATIVO "worklog_template.md"
    Copy-Item -Path $operativoWorklog -Destination $LOCAL_COMPLETO -Force

    Write-Host "  ✓ Archivos copiados" -ForegroundColor Green
    Pop-Location

    Remove-Item -Path $TMP_OPERATIVO -Recurse -Force

    Write-Host ""
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "  SINCRONIZACIÓN COMPLETADA" -ForegroundColor Green
    Write-Host "============================================" -ForegroundColor Cyan
}

Write-Host ""
