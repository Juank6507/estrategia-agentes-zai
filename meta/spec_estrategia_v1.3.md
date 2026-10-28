# Spec Estrategia Z.ai v1.3

## Version

- **Version:** 1.3
- **Fecha:** 2026-10-28
- **Estado:** Aprobada por el Director (C cerrada en S47; E y P aprobadas; I ordenada en S48) - implementada con baremo fijado y protocolo checkmark
- **Documento hermano:** plan_estrategia_v1.3.md (elemento P)
- **Nota de procedimiento:** la primera implementacion de esta spec fue INVALIDADA por el Director (S45: vicio de procedimiento - se ejecuto la I sin baremo estrategico fijado en C). Re-implementada (S48) con el baremo fijado (S46) y el protocolo checkmark (R29) conciliados dentro del ciclo. Evidencia de la implementacion invalidada preservada (snapshot + zip de evidencia).

## Novedades v1.3 (resumen)

1. R22: Reubicacion de la premisa de respuesta a la RAIZ de la estrategia (puerta del guardrails la encuentra sin profundidad)
2. R23: Re-anclaje embebido en el worklog (bloque de Regla Conductual Minima en cabecera del canonicos y de la plantilla; la compresion de contexto es INVISIBLE para el agente)
3. R24: Recuperacion documentada como herramienta (premisa 3 con 6 pasos; herramientas.md seccion 8 "Recuperacion de contexto")
4. R25: I.3e re-clonado final (el ciclo termina con re-clonado fresco desde GitHub tras el push del Director; disco == GitHub == entrega por construccion)
5. R26: Via de escalado (fallo de herramienta/proceso externo -> documentar y escalar; el agente no repara procesos externos)
6. R27: Transferencia de worklog entre agentes (protocolo de toma de posesion)
7. R28: Regla de agente/proyecto nuevo (worklog_template.md se copia como worklog de sesion y rige desde el minuto 1)
8. R29: Protocolo del panel de checkmarks (orden del Director tras la incidencia S45: cero interpretacion del LLM en guardrails, metodo y subelementos; checklist exigible y visible en cada respuesta)
9. Baremo estrategico v1.3 FIJADO por el Director (S46, verbatim; precedente v1.2/S21)
10. DESVIACION 1 ratificada por el Director (S44: REQUIRED_FILES y OPERATIVO_KEEP de update_estrategia.ps1 ajustados a la reubicacion de la premisa)

## Requisitos nuevos (R22-R29)

### R22 -- Reubicacion de la premisa
- premisa_respuesta.md pasa de agent-context/ a la RAIZ de la estrategia (git mv, historia preservada).
- Motivo: la puerta del guardrails (el worklog) la encuentra sin profundidad; el arranque la lee como archivo #1.
- Todas las referencias actualizadas; barrido: 0 coincidencias de la ruta antigua en archivos operativos.

### R23 -- Re-anclaje embebido en el worklog
- Bloque de REGLA CONDUCTUAL MINIMA (5 puntos: frase de control, premisa, recuperacion, verificacion read-back, panel de checkmarks R29) en la cabecera del worklog canonico y de worklog_template.md.
- Leccion empirica: la compresion de contexto es invisible y el resumen automatico mata conductas; el agente en crisis solo re-lee worklog y disco; el re-anclaje DEBE vivir embebido en el worklog.
- Cabecera del canonico: Paso 4 corregido (referencias a ficheros retirados en v1.2) y Paso 12 con nota de deprecacion (flujo .bat retirado).

### R24 -- Recuperacion documentada como herramienta
- premisa_respuesta.md 3 (Recuperacion Espontanea) ampliada a 6 pasos: el paso 3 ordena leer la seccion "Recuperacion de contexto" de agent-context/herramientas.md.
- herramientas.md nueva seccion 8: procedimiento de recuperacion por ficheros, senal de compresion invisible y via de escalado si la recuperacion falla.

### R25 -- I.3e re-clonado final
- Nuevo paso final obligatorio del ciclo: tras el push del Director (I.3c), el sandbox elimina su carpeta estrategia/ y re-clona fresco desde GitHub (rama main).
- Garantia por construccion: lo que hay en disco == lo que hay en GitHub == lo que se entrego. Ejecutar solo con el push confirmado.

### R26 -- Via de escalado
- Si una herramienta o proceso externo falla y bloquea la tarea: documentar (que se intento, error exacto, evidencia) y escalar al Director. El agente NO repara ni rodea procesos externos.
- Codificado en dcepi.md (I.2) y en la seccion 8 de herramientas.md.

### R27 -- Transferencia de worklog entre agentes
- worklog_protocolo.md nueva seccion: el worklog sobrevive al cambio de agente; el saliente cierra sesion (entrada + marcador + read-back); el entrante aplica la Fase de Apertura sobre el MISMO worklog y continua la numeracion (ultima + 1); nunca renumerar; si la continuidad no cuadra -> Proteccion.

### R28 -- Regla de agente/proyecto nuevo
- Si NO existe worklog del proyecto: worklog_template.md se COPIA como worklog de la sesion (nunca editar la plantilla in situ); la copia nace con la Regla Conductual Minima dentro y rige como guardrails desde el minuto 1.
- Codificado en worklog_protocolo.md (Fase 1, Apertura paso 0) y en la cabecera de worklog_template.md.

### R29 -- Protocolo del panel de checkmarks (incidencia S45)
- Principio del Director: no queda nada a la imaginacion o entendimiento del LLM en lo que refiere al guardrails, el metodo y cada uno de sus subelementos; desde ahora es un checkmark de cada punto y subpunto; el LLM solo valida si estan cumplidos y si le falta informacion.
- Norma en el elemento E de dcepi.md; ejecucion en premisa_respuesta.md (2.4 y 5); linea conductual en la Regla Conductual Minima del worklog (plantilla y canonico).
- 7 puntos: panel por respuesta bajo la frase de control; estados [x] cumplido con evidencia / [?] sin respuesta conocida (se pregunta al Director, nunca se suple); solo se reabre lo desconocido; subsubelementos a criterio del agente; registro integral de la checklist con evidencias al cierre de cada elemento; triple redaccion de la regla; lenguaje natural del panel (punto 7).
- Enmienda del Director (S50, antes de la segunda pasada): punto 7 -- los checkmarks del panel se redactan en lenguaje natural, en los terminos del Director (que se hizo, que falta, que debe decidir), sin jerga tecnica; el detalle tecnico queda en el worklog como evidencia y se amplia solo a peticion expresa. Motivo: los paneles usaban lenguaje tecnico (identificadores de commit, comandos, hashes) y eso dificultaba al Director validar cada subelemento tocado, incumpliendo la norma de comunicacion (NH3, comunicacion.md). Codificada en la triple redaccion (dcepi.md elemento E, premisa 2.4, Regla Conductual Minima de plantilla y canonico).

## Baremo estrategico v1.3 (fijado por el Director en S46)

Verbatim: "usando este chat con sus datos reales vamos a verificar el cumplimiento de cada uno de los aspectos conciliados previamente en la spec de la v1.3 (parecido a lo mismo que se realizo en la v1.2 con su baremo estrategico)".
- Registro: worklog canonico S46 (y tareas_inmediatas); el DTI queda como hogar canonico a futuro (decision aparte pendiente).
- Aplicacion: panel de verificacion aspecto por aspecto presentado al Director en S46 con datos reales del chat (10 aspectos conciliados [x]; materializaciones de la I invalidada [ ]; unico [?] resuelto en S47).
- Borrador de 6 puntos de S44 queda como referencia; su punto 6 (veredicto del Director como unico cierre) rige.

## DESVIACION 1 (ratificada por el Director en S44)

- update_estrategia.ps1: REQUIRED_FILES y OPERATIVO_KEEP ajustados a la nueva ubicacion de la premisa (raiz). Sin el ajuste, el zip abortaria en la maquina del Director (REQUIRED_FILES) y la rama operativo perderia la premisa (OPERATIVO_KEEP poda todo lo no listado).
- Desviacion declarada + quirurgica + a ratificacion = "Correcta" (estandar de respuesta para el error, precedentemente fijado en v1.2/S21).

## Requisitos vigentes sin cambios

R1-R5, R7, R9-R21 con la lectura de v1.2; R8 sigue en 10 archivos (la premisa #1 ahora se lee en la raiz).

## Criterios de aceptacion v1.3

1. CA1: premisa_respuesta.md existe en la RAIZ de estrategia/ (test -f) y es el archivo #1 del Protocolo de Arranque.
2. CA2: 0 coincidencias de la ruta antigua agent-context/premisa_respuesta.md en los archivos operativos (barrido).
3. CA3: premisa 3 (Recuperacion Espontanea) contiene el paso que ordena leer herramientas.md.
4. CA4: herramientas.md contiene la seccion 8 "Recuperacion de contexto" con via de escalado.
5. CA5: worklog_protocolo.md contiene Apertura paso 0 (agente/proyecto nuevo) y seccion "Transferencia entre agentes".
6. CA6: worklog_template.md con cabecera v1.3 (Regla Conductual Minima de 5 puntos) y regla de copia para agente nuevo.
7. CA7: dcepi.md con I.3e (re-clonado final), via de escalado (I.2) y elemento E con el protocolo R29.
8. CA8: entorno.md con la excepcion de re-lectura obligatoria tras perdida de contexto.
9. CA9: protegidos sin diff (identidad, contrato, comunicacion, proyecto, agent-learn/, director-only/, PDFs, spec/plan v1.1 y v1.2).
10. CA10: git diff --name-only vs f7cc61d = EXACTAMENTE la tabla de alcance (11 modificados + 2 nuevos; premisa como rename).
11. CA-B1 (R29): dcepi.md elemento E contiene los 6 puntos del protocolo checkmark.
12. CA-B2 (R29): premisa_respuesta.md contiene el mandato del panel por respuesta (2.4) y la nota de panel en la tabla de mapeo (5).
13. CA-B3 (R29): Regla Conductual Minima con 5 puntos (incluido el panel R29) en worklog_template.md.
14. CA-B4 (R29, en vivo): toda respuesta del agente desde S45 abre con frase de control + panel de checkmarks (verificable en el chat).
15. CA11: update_estrategia.ps1 ASCII puro (0 bytes no-ASCII) con DESVIACION 1 aplicada.
16. CA12: MANIFIESTO_ENTREGA.txt regenerado con hash de TODOS los ficheros de la entrega; verificacion interna 100% OK.
17. CA13: entrega I.3a completa en /download/ con reemplazo total; diff -r zip<->clon = CERO.
18. CA14: Gauntlet completo superado; veredicto JSON del Critico sin items_fallados; diff cero en I.3d.
