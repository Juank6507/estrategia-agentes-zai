# TAREAS INMEDIATAS (meta -- unificado)

<!-- Este archivo lo administra el Director con sus prompts. El agente lo lee y actualiza. -->
<!-- Ubicacion unica: estrategia/meta/tareas_inmediatas.md (la copia duplicada en la raiz fue retirada en v1.2). -->

## Pendientes

- [ ] Director (SEGUNDA PASADA, aprendizajes poblados en S49 y completados con el lenguaje en S51): descargar el zip REGENERADO download/estrategia_v1.3.zip, extraer de él SOLO update_estrategia.ps1 y ejecutarlo (push con agent-learn poblado + tareas/historial/manifest actualizados). Tras el push, avisar al agente para el re-clonado final (I.3e, cierre por construcción)
- [ ] Director: decidir si se regeneran los worklogs adaptados (czai/mb/apa) con cabecera v1.3 + punto 5 R29 (recomendado: sí)
- [ ] Director (propuesta S49, sin autorizar): corregir en update_estrategia.ps1 la codificación con la que se guarda el informe DIFF_ENTREGA (PowerShell 5.1 decodifica la salida de git con la codepage OEM/CP850 y el informe sale con mojibake; el repo queda intacto — verificado en S49 revirtiendo la doble codificación)
- [ ] Agente (próximo ciclo, a orden del Director): sincronizar al repo las sesiones 26-51 del worklog canónico (worklog_EP.md del repo está en S25)

## Hechas

- [x] v1.3: I.3c PRIMERA PASADA VERIFICADA desde el sandbox (S49): origin/main = 49c7d6a (hijo de f7cc61d), diff clon↔GitHub CERO, zip↔clon CERO. El Director adjuntó el informe DIFF_ENTREGA de su script y fue revisado: contenido idéntico byte a byte tras revertir la codificación; único defecto = codificación del informe (cosmético), no del repo
- [x] v1.3: I.3d AUTORIZADO por el Director ("Aprendizaje Ok", S49) y poblado en segunda pasada: lecciones_aprendidas +L010/L011/L012, anti_patrones +AP14, patrones_recurrentes +P11, preferencias_director +2; manifest regenerado y zip re-entregado con agent-learn poblado (precedente: cierre v1.2)
- [x] v1.3: Enmienda R29 punto 7 (S50, orden del Director): los checkmarks de todo panel se redactan en lenguaje natural comprensible (qué se hizo, qué falta, qué debe decidir), sin jerga técnica; el detalle técnico queda en el worklog como evidencia. Codificada en la triple redacción (dcepi.md elemento E + premisa 2.4 + Regla Conductual Mínima punto 5) y viaja en la misma segunda pasada
- [x] v1.3: I.3d COMPLETADO con la parte del lenguaje (S51, constatación del Director: "Al Aprendizajes v1.3 (I.3d) le falta esta parte referente al lenguaje"): lecciones_aprendidas +L013 (el panel de checkmarks se redacta en el lenguaje del Director; jerga = NO conforme; releer aprendizajes al cierre de cada sesión), patrones_recurrentes P11 ampliada (lenguaje natural, R29 puntos 1-7), anti_patrones +AP15 (jerga técnica en el panel), preferencias_director +1 (Comunicación — checkmarks en su lenguaje); manifiesto y zip regenerados antes de la segunda pasada
- [x] v1.3: RE-IMPLEMENTADA (S48) con baremo estratégico FIJADO en C por el Director (S46, verbatim; aplicado con datos reales del chat) y protocolo checkmark R29 conciliado (S46/S47: norma en el elemento E de dcepi.md, ejecución en premisa 2.4+5, línea conductual en worklog). Primera implementación INVALIDADA (S45, vicio de procedimiento: I sin baremo fijado); evidencia preservada fuera del repo (snapshot + zip de evidencia)
- [x] v1.3: spec_estrategia_v1.3.md y plan_estrategia_v1.3.md versionados en meta/ (C cerrada S47; E+P aprobadas; I ordenada S48)
- [x] v1.3: DESVIACIÓN 1 ratificada por el Director (S44: "Correcta") — REQUIRED_FILES y OPERATIVO_KEEP de update_estrategia.ps1 ajustados a la reubicación de la premisa
- [x] v1.3: manifest regenerado (SHA256 de toda la entrega, verificación interna 100%) y zip I.3a completo en /download/ con diff zip↔clon CERO
- [x] v1.2: 7. I.3d — aprendizajes poblados DENTRO de la implementación y ANTES de la actualización de repos (orden del Director): lecciones_aprendidas.md +L007/L008/L009, anti_patrones.md +AP12/AP13, patrones_recurrentes.md +P10, preferencias_director.md +2 preferencias, dcepi.md I.3d + Regla de cierre (los aprendizajes viajan en el .zip de entrega; no se posponen fuera del método)
- [x] v1.2: update_estrategia.ps1 v3.0 (orden del Director: flujo de 2 acciones; localiza el .zip más reciente en Downloads; BORRADO TOTAL del repo local salvo .git que sustituye a la purga ELIMINADOS; descompresión íntegra del zip; sentencias GitHub I.3c: push main + sync operativo; DIFF GitHub<->local con verificación DIFF CERO e informe en Downloads; sin preguntas; -DryRun/-NoPush auxiliares)
- [x] v1.2: MANIFIESTO_ENTREGA.txt generado (SHA256 por archivo + ELIMINADOS) incluido en el zip y en el repo
- [x] v1.2: script probado con PowerShell real (pwsh 7.4.6 en sandbox): DryRun, entrega corrupta aborta sin cambios, ejecución completa con push main + sync operativo, idempotencia y flujo por defectos
- [x] v1.2: C y E cerrados; spec_estrategia_v1.2.md y plan_estrategia_v1.2.md versionados en meta/
- [x] v1.2: historial_versiones.md actualizado con la entrada v1.2
- [x] v1.2: agent-context/ completo (premisa_respuesta.md y herramientas.md nuevos; dcepi.md reescrito; contrato, comunicacion, entorno y proyecto actualizados; dcpa.md eliminado)
- [x] v1.2: Protocolo de Arranque v1.2 (10 archivos, premisa #1) en prompt_arranque.md
- [x] v1.2: worklog_protocolo.md creado; worklog_template.md reducido a plantilla
- [x] v1.2: agent-learn consolidado 6 -> 4 (errores_comunes fundido en anti_patrones; experiencias fundido en lecciones_aprendidas)
- [x] v1.2: update_estrategia.ps1 con 1 repo/2 ramas y cabecera de ambito
- [x] v1.2: PDFs de la metodologia (v1 y v2) ubicados en meta/
- [x] v1.2: tareas_inmediatas unificado en meta/ (copia de raiz retirada)

## No olvidar
- Lenguaje del director natural y en sus mismos terminos (no hablar cosas tecnicas mas alla de funcionalidades)
- El proyecto tiene dos tipos de archivos:
    a) scripts atomicos (independientes, standalone con validacion propia)
    b) scripts de dependencia (importan atomicos, se validan con tests en la carpeta tests/).
    Identificar cual es antes de tocarlo.
- Los cambios son quirurgicos: solo se modifica lo que se pidio. El resto queda igual.
- Si veo que un codigo puede mejorarse con OOP, se lo digo al Director como propuesta.
- Buenas practicas de programacion, no usar valores fijos (hardcoding).
- Todo archivo entregado lleva en la primera linea un comentario con su ubicacion y nombre de destino.
- La frase de control [FASE: X | Estrategia: activa] abre toda respuesta (premisa_respuesta.md).
- El panel de checkmarks R29 acompaña a la frase de control en TODA respuesta: cada punto precedido de su pregunta, [x] con evidencia / [?] se pregunta al Director (nunca se suple); sólo se reabre lo desconocido (dcepi.md elemento E).
