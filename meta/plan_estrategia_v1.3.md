# Plan Estrategia Z.ai v1.3

## Version

- **Version:** 1.3
- **Fecha:** 2026-10-28
- **Estado:** Aprobado (el Director no valida el plan; solo prioriza el orden) - ejecutado en S48
- **Documento hermano:** spec_estrategia_v1.3.md (elemento E)

## Reglas de este plan

- El plan responde a la spec; la autorizacion de ejecucion la dio el Director al ordenar la I (S48: "pasamos a la implementacion de la v1.3 mejorada con baremo y checkmark de cada subelemento del metodo DCEPI").
- Cada fase se ejecuta bajo I.1 (precondiciones) e I.2 (ACCL v2: Orquestador -> Actor -> Critico con Gauntlet de 6 pasos en orden obligatorio, veredicto JSON, 3 capas, MAX_ITER = 5).
- Parte A (ya conciliada en S41/S42/S43): R22-R28 + DESVIACION 1. Parte B (conciliada en S46/S47): R29 protocolo checkmark + precondicion de reset del clon.
- Regla de cierre v1.2: los aprendizajes se poblarian DENTRO de la I (I.3d) con autorizacion previa del Director; propuesta presentada al cierre; si autoriza antes del push, el zip se regenera.

## Fases de implementacion (ejecutadas en S48)

### Fase 0: I.1 Precondiciones
- [x] Evidencia del trabajo invalidado preservada ANTES de tocar nada: snapshots/estrategia_v1.3_invalidada_evidencia/ (11 ficheros) + zip invalidado renombrado a evidencia + snapshot pre-I13 intacto.
- [x] Reset del clon a f7cc61d (Parte B conciliada: el trabajo invalidado no aplica): HEAD = f7cc61d, arbol limpio, read-back verificado.
- [x] Golden master verificado: diff -r snapshot pre-I13 vs clon reseteado = CERO.
- [x] Tabla de alcance: 11 modificados + 2 nuevos; protegidos declarados (identidad, contrato, comunicacion, proyecto, agent-learn/, director-only/, PDFs, spec/plan v1.1 y v1.2).

### Fase 1 (F1): Reubicacion de la premisa (R22)
- [x] git mv agent-context/premisa_respuesta.md -> premisa_respuesta.md (rename preservado por git).
- [x] prompt_arranque.md: premisa #1 leida desde la raiz (raiz(1) + agent-context(7)); titulo v1.3.

### Fase 2 (F2): Recuperacion como herramienta + escalado (R24, R26)
- [x] premisa_respuesta.md: 3 ampliada a 6 pasos (paso 3 -> herramientas.md); auto-referencia a la raiz; 2.4 panel R29; nota de panel en tabla de mapeo (5).
- [x] herramientas.md: seccion 8 "Recuperacion de contexto" (procedimiento por ficheros, senal de compresion invisible, via de escalado).

### Fase 3 (F3): Re-anclaje + transferencia + agente nuevo + linea checkmark (R23, R27, R28, R29)
- [x] worklog_protocolo.md: Apertura paso 0 (agente/proyecto nuevo), seccion "Transferencia entre agentes", ruta de la premisa en Deteccion.
- [x] worklog_template.md: cabecera v1.3 con REGLA CONDUCTUAL MINIMA (5 puntos, incluido panel R29) + regla de copia.
- [x] Cabecera del worklog canonico local: punto 5 (panel R29) anadido al bloque conductual existente.

### Fase 4 (F4): Metodo + entorno (R25, R26, R29)
- [x] dcepi.md: titulo v1.3, ruta de la premisa en raiz, bloque "Escalado por fallo de herramienta o proceso" en I.2, I.3e re-clonado final, seccion "Protocolo del panel de checkmarks (R29)" en el elemento E.
- [x] entorno.md: excepcion de re-lectura obligatoria tras perdida de contexto.

### Fase 5 (F5): Versionado + barridos + Gauntlet
- [x] meta/spec_estrategia_v1.3.md creado (E versionada; este documento).
- [x] meta/plan_estrategia_v1.3.md creado (P versionada).
- [x] meta/historial_versiones.md: entrada v1.3 (con nota de re-implementacion).
- [x] meta/tareas_inmediatas.md: pendientes/hechas v1.3.
- [x] update_estrategia.ps1: DESVIACION 1 (REQUIRED_FILES + OPERATIVO_KEEP con la premisa en raiz); ASCII puro verificado.
- [x] MANIFIESTO_ENTREGA.txt regenerado (hash SHA256 de todos los ficheros de la entrega).
- [x] Barridos: 0 coincidencias de la ruta antigua de la premisa en operativos; ASCII ps1 = 0.
- [x] Gauntlet de 14 criterios de aceptacion (CA1-CA10 + CA-B1..B4) con veredicto JSON del Critico.

### Fase 6 (I.3): Entrega y cierre
- [x] I.3a: entrega completa en /download/estrategia_v1.3.zip (zip invalidado previo renombrado a evidencia); diff -r zip<->clon = CERO; manifiesto interno 100% OK.
- [x] I.3b: sentencias de validacion Windows + flujo de 2 acciones en /download/sentencias_actualizacion_v1.3.txt.
- [ ] I.3c: sentencias GitHub - las ejecuta el Director (push main + sync operativo via script).
- [ ] I.3d: aprendizajes - propuesta presentada; se escriben con autorizacion previa del Director (si autoriza antes del push, se regenera el zip).
- [ ] I.3e: re-clonado final - se ejecuta cuando el Director confirme el push completado (R25).

## Impacto esperado

- El guardrails deja cero margen de interpretacion: cada punto y subpunto del metodo y de los guardrails es un checkmark exigible y visible en cada respuesta (R29).
- El re-anclaje vive embebido en el worklog, la premisa en la raiz y la recuperacion documentada como herramienta: la perdida de contexto tiene cadena de disparadores redundantes y salida escrita.
- El ciclo cierra por construccion (I.3e): disco == GitHub == entrega.
- El baremo estrategico queda fijado EN C (leccion de dos ciclos consecutivos saltandolo) y aplicado con datos reales del chat.
