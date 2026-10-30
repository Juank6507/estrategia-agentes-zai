# Historial de Versiones -- Estrategia Z.ai

## v1.4.2 (2026-10-30)

### Motivacion
El Director ejecutó la sentencia de lanzamiento v1.4.1 y el script terminó en "ACTUALIZACION COMPLETADA" con "Version : 1.3.1" y sin DIFF_ENTREGA en txt. Diagnóstico (S58, causa raíz única): la sentencia toma el .zip "más reciente por fecha" de Descargas y ejecutó el zip VIEJO estrategia_v1.3.1.zip (un zip re-descargado/movido queda con timestamp más nuevo); su script antiguo (era 1 repo/2 ramas, banner coincidente línea por línea) re-aplicó contenido v1.3.1 ya presente (NO-OP inocuo; commit 99cf6fb inalterado) y no genera informe en estado "sin cambios". La v1.4.1 NUNCA se aplicó.

### Novedades
1. **update_estrategia.ps1 v4.0.1 -> v4.0.2 -- selección del .zip por MAYOR VERSION** del nombre (empate: más reciente por fecha); los timestamps de Descargas dejan de ser el criterio (fallo de producción: zip viejo pasó por nuevo).
2. **Guarda de coherencia nombre<->VERSION** del manifiesto (Test-Delivery): si no cuadran, aviso rojo y Enter = abortar (umbral cero; continúa solo con S explícita). El nombre del zip verificado se muestra junto a la versión.
3. **Informe DIFF SIEMPRE** -- DIFF_ENTREGA_estrategia_v<version>.txt se escribe también cuando el repo local no cambia ("sin cambios": nota + diff GitHub<->HEAD esperado vacío); antes no se generaba txt en ese estado.
4. **Sentencia de lanzamiento v1.4.2 con nombre exacto** -- fija `estrategia_v1.4.2.zip` en Descargas y se lo pasa al script con -ZipPath (cero ambigüedad; una pregunta menos); la selección por versión del script queda como red de seguridad.

### Archivos modificados
- update_estrategia.ps1 (v4.0.2), agent-context/herramientas.md (§6), agent-context/dcepi.md (I.3c), meta/tareas_inmediatas.md (pendiente del Director sustituido por el de la v1.4.2)
- meta/historial_versiones.md (esta entrada), worklog_EP.md + worklog_EP.backup.md (S58), MANIFIESTO_ENTREGA.txt (regenerado, VERSION: 1.4.2)
- spec/plan/informe v1.4 quedan como registro histórico de la v1.4 (sin cambios)

### Verificacion
- Manifest 34/34 SHA256 OK contra disco (umbral cero). Diff zip<->disco CERO (35 ficheros: 34 del manifest + MANIFIESTO_ENTREGA.txt). md5 worklog_EP == worklog_EP.backup.
- Validación estática del script en sandbox (ASCII-only, balance de llaves/paréntesis, sin regresión del patrón "$NOMBRE:", funciones presentes) + simulación Python de la nueva lógica de selección (escenario real: zip viejo con timestamp más nuevo pierde ante la mayor versión). Sin pwsh disponible en el sandbox esta iteración: la validación de parseo y ejecución corresponde al Windows del Director (I.3b) con la sentencia v1.4.2.
- Aprendizaje propuesto (ratificación del Director pendiente): la versión de una entrega se lee del nombre/manifiesto, nunca del timestamp de Descargas; la sentencia fija el nombre exacto de SU entrega.

## v1.4.1 (2026-10-30)

### Motivacion
Errata de la entrega v1.4 detectada por el Director en su primera ejecución de la sentencia de lanzamiento: ParserError en update_estrategia.ps1 línea 348 ("Variable reference is not valid. ':' was not followed by a valid variable name character"). La verificación íntegra pre-reempaquetado destapó además que la incorporación de las entradas 34-56 al worklog_EP.md del repo (registrada como hecha en la S56) no estaba en disco.

### Novedades
1. **update_estrategia.ps1 v4.0 -> v4.0.1** -- en PowerShell, "$NOMBRE:" dentro de una cadena de comillas dobles se interpreta como variable de ámbito (como $env:PATH) y rompe el parseo. Delimitación con ${NOMBRE} en las DOS ocurrencias de la clase (líneas 348 y 364: remotes COMPLETO y OPERATIVO). Barrido umbral cero del patrón en todo el repo: sin otras ocurrencias ($env: legítimos).
2. **worklog_EP.md del repo completado (entradas 34-56) + S57** -- historia común 1-33 verificada idéntica al canónico; entradas faltantes incorporadas desde el canónico (dueño); backup resincronizado (EP == backup). Corrige el registro incompleto de la S56 (AP16: nada declarado sin comprobar; verificación pre-reempaquetado).
3. **Re-empaquetado v1.4.1** (precedente v1.3.1: los fixes se publican como patch, nunca como re-entrega silenciosa del mismo número) -- MANIFIESTO regenerado desde disco (VERSION: 1.4.1; 34 entradas; verificación 34/34); download/estrategia_v1.4.1.zip con diff zip<->disco CERO; download/sentencias_actualizacion_v1.4.1.txt con LA MISMA sentencia (toma el zip más reciente de Descargas).

### Archivos modificados
- update_estrategia.ps1 (v4.0 -> v4.0.1: delimitación ${VAR} en líneas 348/364), agent-context/herramientas.md (mención vigente del script), agent-context/dcepi.md (I.3c), meta/tareas_inmediatas.md (tarea del Director al zip v1.4.1)
- meta/historial_versiones.md (esta entrada), worklog_EP.md + worklog_EP.backup.md (entradas 34-56 + S57), MANIFIESTO_ENTREGA.txt (regenerado, VERSION: 1.4.1)
- spec/plan/informe v1.4 quedan como registro histórico de la v1.4 (sin cambios)

### Verificacion
- Manifest 34/34 SHA256 OK contra disco (umbral cero). Diff zip<->disco CERO (35 ficheros: 34 del manifest + MANIFIESTO_ENTREGA.txt).
- La sentencia de lanzamiento NO cambia: la v1.4.1 se ejecuta pegando LA MISMA sentencia (toma el zip más reciente de Descargas).
- Ejecución final en Windows del Director (baremo de doble entorno I.3b): pendiente de su re-ejecución con el zip v1.4.1.

## v1.4 (2026-10-29)

### Motivacion
Auditoria de coherencia del ciclo v1.4 (32 ficheros revisados uno a uno; 7 vestigios informados sin corregir) + conciliacion del Director en C de las divergencias V1-V8 y de las nuevas decisiones: dos repos publicos, arranque por identidad, script con preguntas y sentencia unica, paquete de seis elementos, guardrail reforzado y via unica de aprendizajes. Autorizacion de implementacion con nombres validados (estrategia-agentes-zai + estrategia-agentes-zai-operativo).

### Novedades
1. **R30: Dos repos publicos desde un repo local (V1)** -- sustituye a R18 (1 repo/2 rondas): repo COMPLETO (lo clona EP) + repo OPERATIVO (paquete de seis elementos; lo clonan los agentes de proyecto). Sin credenciales: la separacion de contenido es la separacion entre repos. Cero vestigios de "proteccion fisica".
2. **R31: Arranque por identidad (V2)** -- el worklog identifica agente y proyecto; proyecto.md cataloga los 4 proyectos (EP, APA, MB, CZAI) con URLs, regla de aviso y que repo clonar cada identidad.
3. **R32: entorno.md integro (V3)** -- describe el entorno con guardrails, metodo DCEPI y herramientas (contexto_zai), remitiendo a las sedes canonicas.
4. **R33: dcepi.md integro (V4)** -- metodo completo: elementos, subelementos, como se usa/valora/implementa cada uno y que problema corrige; sentencias de cierre para los dos repos; re-clonado final por identidad (I.3e).
5. **R34: Cabecera del worklog del repo actualizada (V5)** -- por orden expresa del Director, sincronizada con la plantilla; NH20 en dos capas (cabecera de estrategia vs historia intocable); entradas 26-56 incorporadas.
6. **R35: Script v4.0 + sentencia unica (V6)** -- el script pregunta (Enter = predeterminado): carpeta del zip (Descargas; el estrategia_v#.#.zip mas reciente), carpeta local (borra y reemplaza) y los dos repos GitHub a publicar; hereda integridad umbral cero, informe DIFF UTF-8 (fix v3.1) y modos auxiliares. El Director ya no extrae el script: la entrega trae UNA sentencia de PowerShell que lo extrae y lo ejecuta (instruccion canonica unica).
7. **R36: Via unica de aprendizajes (V7)** -- se proponen al cerrar la conciliacion de la E y antes del plan; se implementan junto a todo lo demas y viajan dentro de la entrega; sin push directo (NH5 reformulada).
8. **R37: Paquete operativo de seis elementos (V8)** -- premisa_respuesta.md incluido en el repo operativo como archivo #1 (OPERATIVO_KEEP del script y todas las menciones).
9. **Guardrail reforzado** -- frase de control + panel como PRIMERA LINEA antes de cualquier pensamiento o comentario; su omision detiene el proceso y/o invalida la respuesta (triple redaccion: premisa, contrato, prompt_arranque).
10. **Revision integral sin exclusiones** -- factor 6 de la E reformulado: todo archivo se revisa; solo worklogs (historia; correcciones como notas) y PDFs (referencia externa) no se reescriben por naturaleza. Informe completo en meta/informe_revision_integral_v1.4.md.
11. **Criterio "un dato, un dueño"** -- sedes canonicas declaradas y ningun dato repetido sin regla expresa (triple redaccion y remisiones).

### Archivos nuevos
- meta/spec_estrategia_v1.4.md
- meta/plan_estrategia_v1.4.md
- meta/informe_revision_integral_v1.4.md

### Archivos modificados
- premisa_respuesta.md, prompt_arranque.md (reescrito v1.4), agent-context/proyecto.md (reescrito), agent-context/entorno.md (reescrito), agent-context/dcepi.md (reescrito), agent-context/comunicacion.md, agent-context/contrato.md, agent-context/herramientas.md, agent-context/identidad.md
- worklog_template.md, worklog_protocolo.md, worklog_EP.md (cabecera v1.4 + entradas 26-56, orden expresa del Director), worklog_EP.backup.md
- update_estrategia.ps1 (v3.1 -> v4.0), MANIFIESTO_ENTREGA.txt (regenerado, VERSION: 1.4)
- meta/historial_versiones.md (esta entrada), meta/tareas_inmediatas.md
- agent-learn/lecciones_aprendidas.md (+L015/L016), agent-learn/anti_patrones.md (+AP16/AP17), agent-learn/patrones_recurrentes.md (P10 al flujo v4.0), agent-learn/preferencias_director.md (+1)

### Verificacion
- Validacion estatica del script v4.0 en sandbox (ASCII puro, balance de llaves/parentesis, 16 funciones integras, LF); sin PowerShell disponible en el sandbox en esta pasada: la verificacion de ejecucion corresponde al Windows del Director (baremo de doble entorno I.3b).
- Búsquedas umbral cero de vestigios en archivos operativos (criterio 1 de la spec v1.4).
- Manifiesto regenerado con umbral cero y diff zip<->clon CERO (registro en tareas_inmediatas).

## v1.3.1 (2026-10-28)

### Motivacion
Orden del Director tras valorar el informe DIFF_ENTREGA de la segunda pasada (S52: contenido correcto; unico defecto = la codificacion del informe) y cerrar los pendientes de decision abiertos: "No pueden haber errores por lo tanto se corrige y se vuelve a actualizar el repo. por otro lado si es necesario se corrigen los worklog del resto de los proyectos en un .zip adicional" (S53).

### Novedades
1. **update_estrategia.ps1 v3.1** -- el informe DIFF_ENTREGA se genera con la salida de git decodificada como UTF-8 ([Console]::OutputEncoding = UTF8 durante la captura del diff, restaurado al terminar). Corrige el mojibake CP850 repetido en cada pasada (diagnosticado en S49 con prueba matematica y correccion propuesta, reconfirmado en S52). Resto del script sin cambios.
2. **Worklogs adaptados v1.3 (zip adicional, fuera del repo)** -- worklog_{czai,mb,apa}.md regenerados con cabecera v1.3: REGLA CONDUCTUAL MINIMA de 5 puntos (incl. punto 5: panel R29 con su punto 7, lenguaje natural) y ruta de prompt_arranque corregida a la raiz. Entradas byte-identicas al original (NH20; verificado con diff; marcadores 8/24/1 intactos). Entrega: download/worklogs_adaptados_v1.3.zip (+ README_NOTA_ADAPTACION.md).
3. **Aprendizajes (regla L013: completados ANTES de regenerar la entrega)** -- lecciones_aprendidas.md +L014 (cero errores conocidos: todo defecto detectado se corrige en cuanto se autoriza) y preferencias_director.md +1 (Calidad -- cero errores conocidos).

### Archivos modificados
- update_estrategia.ps1 (v3.0 -> v3.1: fix de codificacion en la captura del diff)
- agent-learn/lecciones_aprendidas.md (+L014), agent-learn/preferencias_director.md (+1)
- meta/historial_versiones.md (esta entrada), meta/tareas_inmediatas.md (S53)
- MANIFIESTO_ENTREGA.txt (regenerado, VERSION: 1.3.1)

### Verificacion
- Manifiesto 31/31 SHA256 OK (umbral cero). Zip<->clon: CERO diferencias, 32 ficheros.
- Cambio del script verificado por inspeccion (diff quirurgico, ASCII y LF intactos); el efecto en el informe se confirma en la siguiente pasada del Director (PowerShell 5.1 en su equipo).

## v1.3 (2026-10-28)

### Motivacion
Dos fallos convergentes: (1) el guardrails v1.2 moria en la perdida de contexto (el agente arrancaba por el worklog y la cabecera no lo llevaba nunca a la premisa; la compresion de contexto es invisible y el resumen automatico mata conductas); (2) la incidencia S45: el metodo tenia elementos y subelementos pero se saltaban "a la torera" -- la primera implementacion de esta v1.3 fue INVALIDADA por el Director (vicio de procedimiento: I ejecutada sin baremo estrategico fijado en C, segundo ciclo consecutivo saltandose un subelemento prescrito). La v1.3 re-ancla la premisa embebida en el worklog, la reubica en la raiz, documenta la recuperacion como herramienta y codifica el protocolo del panel de checkmarks: cero interpretacion del LLM en guardrails, metodo y subelementos.

### Novedades
1. **R22: Reubicacion de la premisa** -- premisa_respuesta.md pasa de agent-context/ a la RAIZ de la estrategia (git mv, historia preservada)
2. **R23: Re-anclaje embebido en el worklog** -- bloque de Regla Conductual Minima (5 puntos) en la cabecera del worklog canonico y de worklog_template.md; Paso 4 corregido y Paso 12 con nota de deprecacion en el canonico
3. **R24: Recuperacion documentada como herramienta** -- premisa 3 ampliada a 6 pasos; nueva seccion 8 "Recuperacion de contexto" en herramientas.md con via de escalado
4. **R25: I.3e re-clonado final** -- el ciclo termina con re-clonado fresco desde GitHub tras el push del Director (disco == GitHub == entrega por construccion)
5. **R26: Via de escalado** -- fallo de herramienta/proceso externo -> documentar y escalar al Director (dcepi.md I.2)
6. **R27: Transferencia de worklog entre agentes** -- protocolo de toma de posesion en worklog_protocolo.md
7. **R28: Regla de agente/proyecto nuevo** -- worklog_template.md se copia como worklog de sesion y rige desde el minuto 1 (Apertura paso 0)
8. **R29: Protocolo del panel de checkmarks** -- norma en el elemento E de dcepi.md, ejecucion en premisa_respuesta.md (2.4 + 5), linea conductual en la Regla Conductual Minima; panel por respuesta con [x]/[?] precedidos de la pregunta; solo se reabre lo desconocido; subsubelementos a criterio del agente; checklist integra al cierre de cada elemento (orden del Director, incidencia S45)
9. **Baremo estrategico v1.3 FIJADO por el Director en C (S46, verbatim)** -- verificacion con datos reales del chat del cumplimiento de cada aspecto conciliado de la spec (precedente v1.2/S21); aplicado en S46
10. **DESVIACION 1 (ratificada, S44)** -- update_estrategia.ps1: REQUIRED_FILES y OPERATIVO_KEEP ajustados a la reubicacion de la premisa
11. **Re-anclaje del entorno** -- entorno.md: tras una perdida de contexto, la re-lectura de premisa, worklog y tareas es OBLIGATORIA

### Procedimiento de esta version
- Primera implementacion INVALIDADA por el Director (S45). Re-implementada en S48 sobre el clon reseteado a f7cc61d, con el baremo fijado (S46) y R29 conciliados DENTRO del ciclo. Evidencia de la implementacion invalidada preservada fuera del repo (snapshot + zip de evidencia).
- I.3c primera pasada VERIFICADA desde el sandbox (S49): origin/main = 49c7d6a (hijo de f7cc61d), diff clon↔GitHub CERO y zip↔clon CERO.
- I.3d en segunda pasada (S49): aprendizajes AUTORIZADOS por el Director ("Aprendizaje Ok") y poblados; zip regenerado con agent-learn poblado (mismo patron de cierre que la v1.2).
- Enmienda del Director ANTES de la segunda pasada (S50): R29 punto 7 (lenguaje natural del panel), a peticion expresa del Director ("el lenguaje tecnico en los checkmarks incumple las normas de comunicacion con el director"). Codificada en la triple redaccion (dcepi.md elemento E, premisa 2.4, Regla Conductual Minima de plantilla y canonico); viaja en la misma entrega de segunda pasada.

### Archivos movidos
- agent-context/premisa_respuesta.md -> premisa_respuesta.md (raiz; git mv, historia preservada)

### Archivos nuevos
- meta/spec_estrategia_v1.3.md
- meta/plan_estrategia_v1.3.md

### Archivos modificados
- premisa_respuesta.md (raiz, 3 a 6 pasos, 2.4 panel R29, nota de panel en 5)
- agent-context/herramientas.md (seccion 8 "Recuperacion de contexto" + via de escalado)
- agent-context/dcepi.md (titulo v1.3, ruta de la premisa, escalado I.2, I.3e, protocolo R29 en el elemento E)
- agent-context/entorno.md (re-lectura obligatoria tras perdida de contexto)
- worklog_protocolo.md (Apertura paso 0, Transferencia entre agentes, ruta de la premisa en Deteccion)
- worklog_template.md (cabecera v1.3: Regla Conductual Minima de 5 puntos con panel R29 + regla de copia)
- prompt_arranque.md (premisa #1 desde la raiz, raiz(1)+agent-context(7), v1.3)
- update_estrategia.ps1 (DESVIACION 1: dos listas ajustadas a la reubicacion)
- meta/historial_versiones.md (esta entrada)
- meta/tareas_inmediatas.md (pendientes/hechas v1.3)
- MANIFIESTO_ENTREGA.txt (regenerado)
- agent-learn/ (I.3d segunda pasada S49: lecciones_aprendidas +L010/L011/L012, anti_patrones +AP14, patrones_recurrentes +P11, preferencias_director +2)
- worklog canonico del meta-proyecto (bloque conductual con punto 5 R29; fuera del repo, viaja en la entrega)

---

## v1.2 (2026-10-24)

### Novedades
1. **R12: DCEPI refinado** -- 5 elementos (Diagnostico -> Conciliacion -> Especificacion -> Plan -> Implementacion) con subelementos conciliados; barrido de la descomposicion antigua, DCPA y la taxonomia de 18 aspectos
2. **R13: Premisa de respuesta** -- premisa_respuesta.md nuevo, #1 del arranque (10 archivos); frase de control, recuperacion espontanea, triple redaccion, verificabilidad externa, limite honesto, tabla de mapeo por elemento
3. **R14: Baremos** -- estrategico (Director, en C, registrado en el DTI del proyecto) y tactico (agente, en P, aplicado en I.2); dcepi.md solo procedimiento
4. **R15: I.1 Precondiciones** -- snapshot de regresion, repo montado, tabla de alcance, grafos/algoritmo protegidos
5. **R16: I.2 ACCL v2** -- Orquestador/Actor/Critico, 7 fases, Gauntlet de 6 pasos en orden obligatorio, veredicto JSON, 3 capas, MAX_ITER=5
6. **R17: I.3 Entregas en 4 subfases** -- I.3a DOS regimenes (proyectos: solo modificados salvo E2E; meta-proyecto: siempre completa), I.3b doble entorno, I.3c sentencias GitHub, I.3d diff cero
7. **R18: 1 repo/2 ramas** -- main completa + operativo compacta; sustituye a la estructura 2-repos de R6; update_estrategia.ps1 sincroniza la rama operativo automaticamente
8. **R19: agent-learn 6 -> 4** -- errores_comunes fundido en anti_patrones; experiencias fundido en lecciones_aprendidas
9. **R20: Worklog** -- protocolo migrado a worklog_protocolo.md; proteccion ante truncados externos
10. **R21: Documentacion** -- PDFs ACCL v1 y v2 en estrategia/meta/; contexto_zai/ fuera del alcance del proyecto
11. **Conciencia instrumental** -- herramientas.md nuevo (inventario de herramientas del agente)

### Archivos nuevos
- meta/spec_estrategia_v1.2.md
- meta/plan_estrategia_v1.2.md
- agent-context/premisa_respuesta.md
- agent-context/herramientas.md
- worklog_protocolo.md
- meta/Metodologia Agentica.pdf (v1)
- meta/Metodologia Mejorada_ Agentic CI_CD Loop v2.pdf (v2)

### Archivos modificados
- agent-context/dcepi.md (reescrito: R12-R17)
- agent-context/contrato.md (premisa, excepcion NH8, NH -> capa, barrido de notacion)
- agent-context/comunicacion.md (frase de control, estandar de respuesta)
- agent-context/entorno.md (esquema de ramas, premisa en arranque)
- agent-context/proyecto.md (1 repo/2 ramas, accesos diferenciados)
- prompt_arranque.md (arranque 10 archivos, esquema de ramas)
- worklog_template.md (solo plantilla)
- agent-learn/anti_patrones.md (consolidacion)
- agent-learn/lecciones_aprendidas.md (consolidacion)
- agent-learn/patrones_recurrentes.md (barrido)
- update_estrategia.ps1 (1 repo/2 ramas, cabecera de ambito)
- tareas_inmediatas.md (unificado)
- meta/historial_versiones.md (esta entrada)

### Archivos eliminados
- agent-context/dcpa.md
- agent-learn/errores_comunes.md (fundido en anti_patrones.md)
- agent-learn/experiencias.md (fundido en lecciones_aprendidas.md)
- tareas_inmediatas.md (copia duplicada, se unifica en una sola)

---

## v1.1 (2025-10-11)

### Novedades
1. **R8: Protocolo de Arranque** -- LEER (9 archivos) -> DECLARAR -> ACTUAR obligatorio al inicio
2. **R9: Agente EP** -- Reglas EP-1 a EP-6 para acceso, persistencia y distribucion
3. **R10: REGLA ABSOLUTA DE ENTREGA** -- /download/ exclusivo, nunca /upload/
4. **R11: prompt_arranque.md** -- Punto de entrada unico y fallback
5. **B1-B6: Brechas CZAI corregidas** -- 6 problemas operativos identificados y corregidos
6. **update_estrategia.ps1 mejorado** -- ASCII-only, auto-deteccion de .zip, 3 modos de operacion
7. **lecciones_aprendidas.md** -- Nuevo archivo de lecciones
8. **patrones_recurrentes.md** -- Nuevo archivo de patrones
9. **anti_patrones.md** -- Nuevo archivo de anti-patrones

### Archivos modificados
- agent-context/contrato.md (agregado EP-1 a EP-6, referencia script)
- agent-context/entorno.md (agregado flujo de actualizacion, prompt_arranque.md)
- agent-context/comunicacion.md (agregado P5 protocolo de actualizacion)
- agent-context/identidad.md (actualizado PERSISTIR)
- agent-context/proyecto.md (actualizado flujo EP sandbox)
- agent-context/dcepi.md (renombrado de dcpa.md, metodologia DCEPI)
- worklog_template.md (actualizado protocolo de arranque)
- tareas_inmediatas.md (actualizado estado de completitud)

### Archivos nuevos
- meta/spec_estrategia_v1.1.md
- meta/plan_estrategia_v1.1.md
- meta/historial_versiones.md
- meta/tareas_inmediatas.md
- meta/director-only/informe_estrategia_v1.1.md
- meta/director-only/prompt_inicio_sesion.txt
- meta/director-only/prompt_templates.md
- agent-learn/lecciones_aprendidas.md
- agent-learn/patrones_recurrentes.md
- agent-learn/anti_patrones.md
- prompt_arranque.md
- update_estrategia.ps1

### Brechas corregidas
| Brecha | Correccion |
|---|---|
| B1 | Clon/pull obligatorio al inicio de sesion |
| B2 | /download/ exclusivo + update_estrategia.ps1 en .zip |
| B3 | EP-2: lectura de meta/ permitida |
| B4 | R8: Protocolo de Arranque obligatorio |
| B5 | EP-6: versionado con mensajes descriptivos |
| B6 | B1-B6 documentados y verificados |

---

## v1.0 (2025-07-10)

### Novedades
1. R1: Identidad del agente
2. R2: Contexto de actuacion (6 archivos)
3. R3: Aprendizaje persistente (3 archivos)
4. R4: Worklog estructurado
5. R5: Repositorio operativo en GitHub
6. R6: 2-repo structure (operativo + completo)
7. R7: Compatibilidad cruzada

### Archivos iniciales
- agent-context/identidad.md
- agent-context/contrato.md
- agent-context/comunicacion.md
- agent-context/dcepi.md
- agent-context/entorno.md
- agent-context/proyecto.md
- agent-learn/errores_comunes.md
- agent-learn/preferencias_director.md
- agent-learn/experiencias.md
- worklog_template.md
- tareas_inmediatas.md
