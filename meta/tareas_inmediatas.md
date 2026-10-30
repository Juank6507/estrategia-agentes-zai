# TAREAS INMEDIATAS (meta -- unificado)

<!-- Este archivo lo administra el Director con sus prompts. El agente lo lee y actualiza. -->
<!-- Ubicacion unica: estrategia/meta/tareas_inmediatas.md (la copia duplicada en la raiz fue retirada en v1.2). -->

## Pendientes

- [ ] Director (ENTREGA v1.4.2): descargar download/estrategia_v1.4.2.zip y pegar en PowerShell LA SENTENCIA v1.4.2 (fija el NOMBRE EXACTO `estrategia_v1.4.2.zip` en Descargas y se lo pasa al script con -ZipPath; pregunta repo local/repos con Enter; publica el repo COMPLETO y el OPERATIVO — crear antes en GitHub el repo `estrategia-agentes-zai-operativo` si aún no existe). Sustituye a la tarea de la v1.4.1: su sentencia tomó el zip VIEJO v1.3.1 ("más reciente por fecha") y la v1.4.1 NUNCA se aplicó (S58). Tras el push, avisar al agente para el re-clonado final (I.3e por identidad)
- [ ] Director: colocar los worklogs adaptados en los chats/sandboxes de czai, mb y apa (los adaptados v1.3 quedan desfasados en la regla de identidad; regenerables como v1.4 a orden)
- [ ] Agente (tras el push del Director): re-clonado final I.3e desde el repo COMPLETO y verificación triple igualdad (disco == GitHub == entrega)

## Hechas

- [x] v1.4.2 (S58, reporte del Director: banner "Version : 1.3.1" y diff txt sin entregar): la sentencia "toma el más reciente por fecha" ejecutó el zip VIEJO estrategia_v1.3.1.zip → su script antiguo re-aplicó contenido v1.3.1 (NO-OP inocuo: el repo ya estaba en v1.3.1) y la v1.4.1 NUNCA se aplicó. Script v4.0.1→v4.0.2: (1) selección del zip por MAYOR VERSION del nombre (empate: fecha); (2) guarda nombre↔VERSION del manifiesto (Enter aborta); (3) DIFF_ENTREGA txt SIEMPRE (también en "sin cambios"); sentencia v1.4.2 fija el nombre exacto con -ZipPath; manifiesto regenerado (34/34) y zip re-entregado
- [x] v1.4 (S56, orden del Director: "Todo esto se incorpora a la E y al P... se pasa a la implementación de la v1.4 y todo su plan incluido lo último conciliado"): IMPLEMENTACION COMPLETA del plan de 8 fases — (1) respaldo v1.3.1 en snapshots/; (2) revisión integral con informe en meta/; (3) núcleo documental: proyecto.md (catálogo 4 proyectos + 2 repos + identidad), entorno.md íntegro, dcepi.md íntegro (sentencias 2 repos + I.3e por identidad + regla de aprendizajes), comunicacion.md P5 sentencia única, contrato.md NH5/NH20, premisa reforzada, prompt_arranque v1.4, plantilla/protocolo worklog, herramientas.md e identidad.md remisiones; (4) script v4.0 (preguntas con predeterminados, dos repos, hereda integridad/UTF-8/modos; validación estática OK); (5) meta/: spec/plan/informe v1.4 + historial; (6) aprendizajes L015/L016, AP16/AP17, P10 actualizada, +1 preferencia; (7) worklog_EP.md del repo con cabecera v1.4 + entradas 26-56 (V5); (8) manifiesto regenerado, zip en download/, sentencias con la sentencia única
- [x] v1.4 (C del ciclo): conciliadas V1-V8 con el Director (dos repos públicos validados: estrategia-agentes-zai + estrategia-agentes-zai-operativo; identidad; script con preguntas + sentencia única; V5 correcta; V6 sentencia; V7 vía única de aprendizajes) y 5 aprendizajes aprobados ("Todo esto se incorpora")
- [x] v1.4 (D del ciclo, S55): auditoría de coherencia de los 32 ficheros; 7 vestigios informados SIN corregir (repo intacto en 99cf6fb); se conciliaron en C y se corrigieron en la I de la v1.4 (V1-V8, ver informe_revision_integral_v1.4.md)
- [x] v1.3.1 (S53, orden del Director "No pueden haber errores..."): update_estrategia.ps1 v3.0→v3.1 — el informe DIFF_ENTREGA se genera con la salida de git decodificada como UTF-8 (corrige el mojibake CP850 propuesto en S49 y reconfirmado en S52); manifiesto regenerado (VERSION: 1.3.1) y zip re-entregado (download/estrategia_v1.3.1.zip)
- [x] v1.3.1 (S53): worklogs adaptados del resto de los proyectos REGENERADOS con cabecera v1.3 (Regla Conductual Mínima de 5 puntos con panel R29 punto 7 + ruta de prompt_arranque corregida a la raíz); entradas byte-idénticas (czai/mb/apa: marcadores 8/24/1 intactos); entregados en download/worklogs_adaptados_v1.3.zip (zip adicional, fuera del repo)
- [x] v1.3.1 (S53): agent-learn completado ANTES de regenerar la entrega (regla L013): lecciones_aprendidas +L014 (cero errores conocidos), preferencias_director +1 (Calidad — cero errores conocidos)
- [x] v1.3 (S52, cierre del ciclo): segunda pasada del Director verificada (origin/main = be5ab841) e I.3e ejecutado (re-clonado fresco, triple igualdad disco == GitHub == entrega); informe DIFF_ENTREGA valorado (contenido correcto; único defecto = codificación del informe → corregida en v1.3.1)
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
