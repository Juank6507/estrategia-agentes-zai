# Historial de Versiones -- Estrategia Z.ai

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
