# plantilla_script_entrega_proyecto.ps1 -- plantilla v1.0 (estrategia Z.ai v1.5)
# Ubicacion: estrategia/plantillas/plantilla_script_entrega_proyecto.ps1 (PLANTILLA)
# Destino instanciado en cada proyecto (NH15): <RAIZ_DEL_REPO_DEL_PROYECTO>/update_entrega.ps1
#
# ESTANDAR R5 (v1.5): toda implementacion de cualquier agente viaja con su script de entrega,
# hermano del update_estrategia.ps1 del meta-proyecto (v4.x). Cubre de forma automatica, sin
# intervencion del Director donde sea posible y con calidad y garantia de implementacion
# completa, los 4 aspectos del cruce:
#   (a) CONTENIDO de la entrega segun su regimen I.3a (proyectos: solo modificados + tests +
#       tests E2E completos), verificado contra MANIFIESTO_ENTREGA.txt (SHA256, umbral cero).
#   (b) FUNCIONAMIENTO EN WINDOWS (I.3b): ejecuta las sentencias de prueba y los tests E2E
#       que viajan con la entrega, con datos reales del proyecto (R4/NH25).
#   (c) CONDICIONES PREVIAS (I.3c): comprueba las precondiciones que la entrega consume.
#   (d) CIERRE POR CONSTRUCCION (I.3e): veredicto JSON umbral cero asentado en el registro
#       de intentos; condiciona el re-clonado final. Recordatorio de retorno consolidado (R1).
#
# REGLA DE GENERACION R6 (dcepi.md I.3a): el agente de proyecto instancia ESTA plantilla
# sustituyendo TODOS los marcadores <<...>> por datos reales del proyecto (prohibido el
# hardcoding: los valores viven solo en la seccion CONFIGURACION). El script instanciado es
# parte de la implementacion, pasa el gauntlet de I.2 como cualquier archivo y debe superar
# la escalera de validacion R3: individual -> funcional -> e2e. Si no supera el estandar:
# correcciones oportunas y reintento con MAX_ITER = 5 intentos (I.2); agotados, ESCALADO al
# Director con el problema exacto (que item falla, evidencia, diagnostico), sin rodearlo ni
# reparar procesos ajenos.
#
# USO (quien recibe la entrega, en Windows): pegar la sentencia de lanzamiento que acompana
# la entrega (extrae este script del .zip y lo ejecuta apuntando a la carpeta extraida).
#
# ASCII-only: sin em-dash, sin smart quotes, sin caracteres Unicode especiales.

param(
    [string]$EntregaDir = "",      # carpeta donde se extrajo el .zip de la entrega
    [switch]$SkipTests,            # auxiliar de diagnostico: omite (b); el veredicto lo registra
    [switch]$NoReport              # auxiliar: no escribe el informe en Downloads
)

$ErrorActionPreference = "Stop"

# ============================================================
#  CONFIGURACION (instanciar con datos reales del proyecto;
#  ningun otro punto del script contiene valores fijos)
# ============================================================

$NombreProyecto    = "<<NOMBRE_PROYECTO>>"           # p. ej. APA
$VersionEntrega    = "<<VERSION_ENTREGA>>"           # p. ej. 1.0 (debe cuadrar con el manifiesto)
$RutaLocalProyecto = "<<RUTA_LOCAL_PROYECTO>>"       # raiz local del repo del proyecto
$RepoGitHub        = "<<REPO_GITHUB_PROYECTO>>"      # URL del repo del proyecto (fichero de entornos)
$RamaPrincipal     = "<<RAMA_PRINCIPAL>>"            # p. ej. main

# (a) Contenido requerido de la entrega (regimen I.3a: solo modificados + tests + E2E completos)
$ArchivosRequeridos = @(
    # <<ARCHIVOS_ENTREGA: una ruta relativa por linea, tal como viajan en el .zip>>
)

# (b) Funcionamiento en Windows: sentencias de prueba y tests E2E (datos reales, R4/NH25)
$SentenciasPrueba = @(
    # <<SENTENCIAS_PRUEBA: un comando por linea que demuestra la funcionalidad entregada>>
)
$TestsE2E = @(
    # <<TESTS_E2E: un comando por linea que ejecuta los tests E2E completos del proyecto>>
)

# (c) Condiciones previas (I.3c): cada comando debe terminar en exit 0 para cumplir
$CondicionesPrevias = @(
    # <<CONDICIONES_PREVIAS: un comando de comprobacion por linea>>
)

# Lo no automatizable queda senalado y escala (R5): cada item con su razon y quien lo valida
$NoAutomatizable = @(
    # <<ITEM_NO_AUTOMATIZABLE: descripcion | razon | quien lo valida>>
)

# Verificacion del retorno consolidado (R1/NH26): la entrega confirma el lugar determinado
$RutaRetornoConsolidado = "retorno/documento_consolidado.md"

# Fuente de datos reales de la validacion (R4/NH25): declarar SIEMPRE
$FuenteDatos = "<<FUENTE_DATOS_REALES>>"           # p. ej. base de datos del proyecto, fixtures reales, API real

# ============================================================
#  FUNCIONES AUXILIARES
# ============================================================

function Write-Title {
    Write-Host ""
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host "  ENTREGA DE PROYECTO - $NombreProyecto (v$VersionEntrega)" -ForegroundColor Cyan
    Write-Host "  estandar R5 v1.5: contenido + Windows + previas + cierre" -ForegroundColor Cyan
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host ""
}

function Write-Check ($Num, $Texto, $Ok) {
    if ($Ok) {
        Write-Host "  [$Num] [OK]   $Texto" -ForegroundColor Green
    } else {
        Write-Host "  [$Num] [FALLO] $Texto" -ForegroundColor Red
    }
}

function Get-VeredictoPath {
    # Registro de intentos y veredicto asentado (I.3e): vive en la raiz local del proyecto
    return (Join-Path $RutaLocalProyecto "entregas\registro_intentos.log")
}

function Add-Registro ($Linea) {
    $ruta = Get-VeredictoPath
    $dir = Split-Path $ruta -Parent
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    Add-Content -Path $ruta -Value $Linea -Encoding UTF8
}

# ============================================================
#  (a) CONTENIDO: archivos requeridos + SHA256 contra el manifiesto
# ============================================================

function Test-Contenido {
    Write-Host "  (a) Contenido de la entrega (I.3a)..." -ForegroundColor White
    $fallos = @()

    if ($EntregaDir -eq "" -or -not (Test-Path $EntregaDir)) {
        return @("C1: carpeta de la entrega no indicada o inexistente ($EntregaDir)")
    }

    foreach ($rel in $ArchivosRequeridos) {
        $p = Join-Path $EntregaDir $rel
        if (-not (Test-Path $p)) { $fallos += "C1: falta el archivo requerido $rel" }
    }

    $manifest = Join-Path $EntregaDir "MANIFIESTO_ENTREGA.txt"
    if (-not (Test-Path $manifest)) {
        $fallos += "C2: MANIFIESTO_ENTREGA.txt ausente en la entrega"
    } else {
        foreach ($linea in (Get-Content $manifest)) {
            if ($linea -match "^([0-9a-f]{64})\s{2}(.+)$") {
                $hash = $Matches[1]; $rel = $Matches[2]
                $p = Join-Path $EntregaDir ($rel -replace "/", "\")
                if (Test-Path $p) {
                    $real = (Get-FileHash $p -Algorithm SHA256).Hash.ToLower()
                    if ($real -ne $hash) { $fallos += "C2: SHA256 no cuadra en $rel (umbral cero)" }
                }
            } elseif ($linea -match "^VERSION:\s*(.+)$") {
                if ($Matches[1].Trim() -ne $VersionEntrega) {
                    $fallos += "C2: VERSION del manifiesto ($($Matches[1].Trim())) no cuadra con la configurada ($VersionEntrega)"
                }
            }
        }
    }

    $ret = Join-Path $EntregaDir ($RutaRetornoConsolidado -replace "/", "\")
    if (-not (Test-Path $ret)) {
        $fallos += "C6: el documento consolidado de retorno no esta en $RutaRetornoConsolidado (R1/NH26)"
    }

    Write-Check "C1" "archivos requeridos presentes segun regimen I.3a" (($fallos | Where-Object { $_ -like "C1*" }).Count -eq 0)
    Write-Check "C2" "manifiesto integro, SHA256 umbral cero y VERSION coherente" (($fallos | Where-Object { $_ -like "C2*" }).Count -eq 0)
    Write-Check "C6" "documento consolidado de retorno en el lugar determinado" (($fallos | Where-Object { $_ -like "C6*" }).Count -eq 0)
    return $fallos
}

# ============================================================
#  (c) CONDICIONES PREVIAS
# ============================================================

function Test-Precondiciones {
    Write-Host "  (c) Condiciones previas (I.3c)..." -ForegroundColor White
    $fallos = @()
    $i = 0
    foreach ($cmd in $CondicionesPrevias) {
        $i++
        try {
            $out = & cmd.exe /c $cmd 2>&1
            if ($LASTEXITCODE -ne 0) { $fallos += "C3: precondicion $i fallo ($cmd): $out" }
        } catch {
            $fallos += "C3: precondicion $i lanzo error ($cmd): $_"
        }
    }
    Write-Check "C3" "condiciones previas cumplidas ($($CondicionesPrevias.Count) comprobaciones)" ($fallos.Count -eq 0)
    return $fallos
}

# ============================================================
#  (b) FUNCIONAMIENTO EN WINDOWS: sentencias de prueba + tests E2E
# ============================================================

function Test-Funcionamiento {
    Write-Host "  (b) Funcionamiento en Windows (I.3b)..." -ForegroundColor White
    $fallos = @()

    if ($SkipTests) {
        Write-Check "C4" "funcionamiento OMITIDO por -SkipTests (diagnostico)" $false
        return @("C4: ejecucion con -SkipTests; el veredicto NO valida funcionamiento")
    }

    if ($SentenciasPrueba.Count -eq 0 -or $TestsE2E.Count -eq 0) {
        $fallos += "C4: la entrega no define sentencias de prueba o tests E2E (no se da por validado sin ellos)"
    }

    $i = 0
    foreach ($cmd in $SentenciasPrueba) {
        $i++
        try {
            $out = & cmd.exe /c $cmd 2>&1
            if ($LASTEXITCODE -ne 0) { $fallos += "C4: sentencia de prueba $i fallo ($cmd): $out" }
        } catch {
            $fallos += "C4: sentencia de prueba $i lanzo error ($cmd): $_"
        }
    }

    $j = 0
    foreach ($cmd in $TestsE2E) {
        $j++
        try {
            $out = & cmd.exe /c $cmd 2>&1
            if ($LASTEXITCODE -ne 0) { $fallos += "C4: test E2E $j fallo ($cmd): $out" }
        } catch {
            $fallos += "C4: test E2E $j lanzo error ($cmd): $_"
        }
    }

    Write-Check "C4" "sentencias de prueba ($($SentenciasPrueba.Count)) y tests E2E ($($TestsE2E.Count)) superados" ($fallos.Count -eq 0)
    $datosOk = ($FuenteDatos -ne "" -and $FuenteDatos -notlike "<<*>>")
    Write-Check "C5" "fuente de datos declarada y real o lo mas real posible (R4/NH25)" $datosOk
    if (-not $datosOk) { $fallos += "C5: fuente de datos de la validacion no declarada o con marcador sin instanciar" }
    return $fallos
}

# ============================================================
#  (d) CIERRE: veredicto JSON umbral cero + registro de intentos
# ============================================================

function Emit-Veredicto ($TodosLosFallos) {
    $aprobado = ($TodosLosFallos.Count -eq 0)
    $veredicto = [ordered]@{
        proyecto       = $NombreProyecto
        version        = $VersionEntrega
        fecha          = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
        aprobado       = $aprobado
        items_fallados = $TodosLosFallos
        motivo         = ""
        vuelve_a       = ""
        comandos_fallidos = @()
        no_automatizable  = $NoAutomatizable
    }
    if (-not $aprobado) {
        $veredicto.motivo = "Entrega NO aplicada: la entrega vuelve al DCEPI (I.3b). Escalar al Director con el problema exacto: item, evidencia y diagnostico."
        $veredicto.vuelve_a = "DCEPI"
    }

    $json = $veredicto | ConvertTo-Json -Depth 4
    Add-Registro "---- INTENTO $(Get-Date -Format o) ----"
    Add-Registro $json

    Write-Host ""
    if ($aprobado) {
        Write-Host "  VEREDICTO: APROBADO (umbral cero; veredicto asentado en registro_intentos.log)" -ForegroundColor Green
        Write-Host "  Siguiente paso: re-clonado final (I.3e) del repo $RepoGitHub (rama $RamaPrincipal)" -ForegroundColor Green
        Write-Host "  y verificacion de triple igualdad: disco == GitHub == entrega." -ForegroundColor Green
    } else {
        Write-Host "  VEREDICTO: RECHAZADO ($($TodosLosFallos.Count) items)" -ForegroundColor Red
        Write-Host "  La entrega NO se aplica y vuelve al DCEPI. ESCALAR AL DIRECTOR:" -ForegroundColor Red
        foreach ($f in $TodosLosFallos) { Write-Host "    - $f" -ForegroundColor Red }
    }

    if (-not $NoReport) {
        $informe = Join-Path $env:USERPROFILE "Downloads\VEREDICTO_ENTREGA_${NombreProyecto}_v$VersionEntrega.json"
        $json | Out-File -FilePath $informe -Encoding UTF8
        Write-Host "  Informe: $informe" -ForegroundColor Gray
    }
    return $aprobado
}

# ============================================================
#  PROGRAMA PRINCIPAL
# ============================================================

Write-Title
Write-Host "  Checklist embebida de la entrega (estandar R5, v1.5):" -ForegroundColor White

$fallos = @()
$fallos += Test-Contenido
$fallos += Test-Precondiciones
$fallos += Test-Funcionamiento
Write-Check "C7" "cierre por construccion: veredicto asentado y re-clonado condicionado (I.3e)" $true

$aprobado = Emit-Veredicto $fallos
if (-not $aprobado) { exit 1 }
exit 0
