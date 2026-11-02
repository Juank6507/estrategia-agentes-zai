<!-- Ubicacion: estrategia/meta/spec_estrategia_v1.5.md
     Especificacion (E) de la version 1.5 de la estrategia. Conciliada en C con el Director
     (ciclo v1.5: retorno por via repositorios; estructura de respuesta corto -> narrativa ->
     resumen con resumen abarcador; escalera de 3 validaciones + baremo de datos reales;
     estandar del script de entrega en cada implementacion con 5 intentos y escalado). -->

# ESPECIFICACIÓN — Estrategia Z.ai v1.5

## 1. Origen

Orden del Director de abrir el DCEPI de la v1.5 tras cerrarse el ciclo v1.4.2, para enmendar los problemas que planteó: la falta de una vía estandarizada de retorno de información del agente a la estrategia, la codificación incorrecta de la estructura de respuesta en la premisa, la ausencia de verificación de funcionamiento (no solo integridad) en las entregas y de un estándar de entrega para los proyectos de aplicación, y las pruebas que pasan con mocks/fallbacks que encubren errores reales. Conciliado en C punto por punto con el Director; la E y la P se emiten juntas por su orden expresa ("Vamos con elemento E y P directamente; una vez conciliada la E reviso también la P").

## 2. Los 13 factores de la especificación

| # | Factor | Respuesta |
|---|---|---|
| 1 | Qué falla | (a) El retorno agente→estrategia no tiene vía: lecciones_aprendidas, anti_patrones y demás información inversa no tienen lugar ni protocolo de cosecha; (b) la premisa codifica el tercer elemento de la respuesta como "respuesta estructurada", cuando lo conciliado es el resumen, y sin la obligación de abarcar cada aspecto; (c) las entregas de los proyectos de aplicación no tienen script ni checklist de verificación (el update_estrategia.ps1 es exclusivo del meta-proyecto) y la mitad Windows del baremo de doble entorno (I.3b) depende de sentencias manuales; el script v4.0.2 verifica integridad, no funcionamiento; (d) no hay baremo que impida dar por válida una prueba apoyada en fallbacks/mocks |
| 2 | Por qué falla | La v1.4 resolvió la distribución (estrategia→agentes) y no la recolección (agentes→estrategia); la estructura de respuesta se codificó sin conciliación expresa de su tercer elemento; el ámbito del script v4.0.2 quedó limitado al meta-proyecto y su algoritmo cubre integridad (SHA256) y no funcionamiento; el gauntlet I.2 valida el código pero no la calidad de los datos con que se valida |
| 3 | Dónde falla | premisa_respuesta.md (estructura de la respuesta); dcepi.md (I.2 fases, I.3a regímenes, I.3b, I.3c/d, §8 baremos); contrato.md (NH vigentes); proyecto.md (catálogo sin repos GitHub explícitos por proyecto ni protocolo de cosecha); herramientas.md (remisiones); inexistencia de las plantillas: script de entrega de proyecto y documento consolidado de retorno |
| 4 | Cómo reproducirlo | (a) Preguntar a un agente de proyecto dónde deposita una lección aprendida aprobada → no hay lugar definido ni segunda fase de cosecha; (b) examinar una entrega de proyecto → no trae script, manifiesto ni checklist; (c) leer la sección de estructura de la premisa → tercer elemento "respuesta estructurada"; (d) revisar un test de proyecto que usa mocks → pasa sin datos reales y puede encubrir un error real |
| 5 | Qué debe pasar después | (a) Toda ficha conciliada aterriza en el documento consolidado del repo del proyecto y llega al meta-proyecto cuando el EP actualiza la estrategia; (b) toda respuesta se produce corto → narrativa → resumen, con resumen abarcador; (c) toda implementación de cualquier agente viaja con su script de entrega que verifica contenido y funcionamiento en Windows con umbral cero, sin intervención del Director donde sea posible; (d) todo script se valida en 3 niveles y con datos reales |
| 6 | Qué no se toca | El algoritmo del update_estrategia.ps1 v4.0.2 fuera de su intervención quirúrgica concreta (listas OPERATIVO_KEEP/REQUIRED_FILES si el paquete operativo crece, cabecera de versión y menciones vigentes); historia de los worklogs; PDFs (referencia externa); meta/ versionado histórico (spec/plan v1.1–v1.4 y director-only/); el proceso contexto_zai (regla Sesión 29: no modificar ni rodear); los proyectos APA/MB/CZAI (solo reciben plantillas en su próximo ciclo) |
| 7 | Precondiciones | C cerrada con los puntos conciliados (retorno, estructura, validaciones, baremo, estándar del script); repo en estado v1.4.2 verificado; snapshot de regresión del área a intervenir (I.1) |
| 8 | Invariantes | Guardrail + Panel como primera línea de toda respuesta; umbral cero en verificaciones y búsquedas de retirados; historia del worklog intocable; paquete operativo de seis elementos (salvo crecimiento conciliado); MAX_ITER = 5 (I.2); la única vía de salida es la entrega verificada (NH5); toda regla nueva en triple redacción |
| 9 | Impacto colateral | Los agentes de proyecto reciben normas nuevas que aplican en su próximo ciclo (sus worklogs y cabeceras se adaptan por su propio DCEPI, no en este); el paquete operativo puede crecer con las plantillas (el manifiesto se regenera en I); menciones vigentes al flujo de entrega se actualizan (herramientas.md §6, dcepi.md I.3c) |
| 10 | Severidad | Media-alta: la v1.4.2 funciona en producción, pero cada ciclo sin retorno estandarizado acumula aprendizajes perdidos, y las entregas de proyecto sin verificación de funcionamiento en Windows reproducen la clase de incidencias S57/S58 |
| 11 | Evidencia | Lecturas verificadas en disco de esta E: dcepi.md §7 (I.1–I.3e), update_estrategia.ps1 v4.0.2 (835 líneas; 16 REQUIRED_FILES; operativo de 6 elementos), MANIFIESTO_ENTREGA.txt (34 archivos, VERSION 1.4.2), premisa_respuesta.md, worklogs canónico y del repo (S56–S58) |
| 12 | Antecedentes | v1.2 (recuperación de contexto), v1.3 (re-clonado final I.3e), v1.4 (dos repos, script v4.0, paquete de seis), v1.4.1/v1.4.2 (erratas de producción: delimitación ${VAR}, selección de zip por versión); Sesiones 56–58; incidencia S45 (R29) |
| 13 | Alternativas descartadas | Push directo desde el sandbox (prohíbe NH5 y rompe la triple igualdad entrega==GitHub==clon); fichas dispersas por proyecto sin documento consolidado (fragmenta la cosecha); validar Windows solo a mano (no escala ni deja evidencia); un script de entrega distinto por agente sin plantilla común (rompe el estándar); exigir el estándar solo al meta-proyecto (deja fuera las entregas de proyecto, origen de la clase de incidencia) |

## 3. Alcance por archivos

- **Nuevos (4):** `meta/spec_estrategia_v1.5.md` (esta E); `meta/plan_estrategia_v1.5.md` (la P); `plantillas/plantilla_script_entrega_proyecto.ps1` (plantilla del script de entrega para proyectos de aplicación, con checklist de portabilidad y validación embebida, manifiesto, sentencia y veredicto umbral cero); `plantillas/plantilla_documento_consolidado.md` (plantilla del documento único de retorno proyecto→estrategia).
- **Modificados (9):** premisa_respuesta.md (estructura corto → narrativa → resumen con resumen abarcador); agent-context/dcepi.md (escalera de validación en I.2; baremo de datos reales en §8; script de entrega obligatorio en I.3a; mitad Windows de I.3b automatizada; segundo momento de cosecha en I.3c/d); agent-context/contrato.md (NH24–NH26 en triple redacción); agent-context/proyecto.md (fichero de entornos: repos GitHub explícitos por proyecto + protocolo de cosecha del EP + lugar determinado del documento consolidado); agent-context/herramientas.md (remisiones: script de entrega por proyecto, documento consolidado); update_estrategia.ps1 (intervención quirúrgica: listas del paquete operativo si crece + cabecera de versión); meta/historial_versiones.md (entrada v1.5); meta/tareas_inmediatas.md (pendientes actualizados); MANIFIESTO_ENTREGA.txt (regenerado en I).
- **Eliminados:** ninguno.

## 4. Decisiones conciliadas que materializa (P1–P6)

1. **P1 — Retorno por vía repositorios (2 momentos):** la información que viaja del agente a la estrategia (lecciones_aprendidas, anti_patrones y cualquier información inversa) sigue la vía repositorios: M1, en el elemento C del método del proyecto el agente propone, el Director aprueba, el agente actualiza el archivo de estrategia correspondiente en su espacio y genera el documento único consolidado en el lugar determinado del repo del proyecto; M2, al actualizar la estrategia el agente EP lee los archivos de todos los proyectos del fichero de entornos (repos GitHub explícitos), actualiza los archivos del meta-proyecto y el script .ps1 actualiza el repo de la estrategia de cada agente. Lo general viaja en el documento consolidado; lo particular y específico permanece en el worklog del proyecto.
2. **P2 — Estructura de producción de la respuesta:** corto → narrativa → resumen; el resumen es abarcador (toca cada aspecto de la respuesta, sin omitir ninguno); la estructura es el modo de producción, no un elemento adicional; guardrail y Panel quedan como envoltura fija; entra en la premisa con la v1.5.
3. **P3 — Escalera de validación de scripts:** todo script se valida en 3 niveles, en orden: individual (cada aspecto que toca, por separado) → funcional (lo que intenta resolver, probando la interacción con los módulos/scripts de los que depende, o aislado si no depende) → e2e (demostrar que funciona correctamente dentro del proyecto real en marcha).
4. **P4 — Baremo estratégico de datos reales:** las validaciones se ejecutan siempre con datos reales si existen; si no es posible, sobre datos lo más reales posibles; prohibido apoyar el veredicto en fallbacks y mocks (encubren errores reales); aplica a todos los proyectos que se hacen con el método DCEPI.
5. **P5 — Estándar del script de entrega:** cada implementación de cualquier agente contiene su script de entrega — hermano del v4.0.2 — que cubre de forma automática, sin intervención del Director donde sea posible y con la calidad y garantía de una implementación completa: contenido de la entrega según su régimen (I.3a), funcionamiento en Windows de lo entregado con las sentencias de prueba y tests e2e que viajan con ella (I.3b), condiciones previas (I.3c) y cierre por construcción con veredicto umbral cero asentado que condiciona el re-clonado (I.3e). Lo no automatizable queda señalado y escala.
6. **P6 — Generación por el agente de proyecto:** el agente recibe la indicación clara y precisa (plantilla + norma en dcepi.md I.3a); el script se genera como parte de la implementación y pasa el gauntlet de I.2 como cualquier otro archivo; si no supera el estándar, efectúa las correcciones oportunas y lo reintenta; tiene 5 intentos (MAX_ITER, I.2); agotados, escala al Director el problema exacto que se lo impide — qué ítem falla, evidencia y diagnóstico — sin rodearlo ni reparar procesos ajenos.

## 5. Triple redacción de las reglas

### R1 — Retorno por vía repositorios (2 momentos) [P1]
- **Normativa:** toda información que viaja del agente a la estrategia sigue la vía repositorios en 2 momentos según P1. La vía única de salida de los proyectos sigue siendo la entrega verificada (NH5); no existe push directo.
- **Operativa:** en proyecto, al cierre del elemento C: proponer fichas → con aprobación, actualizar el archivo de estrategia local y el documento consolidado → depositarlo en el lugar determinado del repo del proyecto. En el meta-proyecto, al preparar una actualización de estrategia: leer el fichero de entornos → cosechar los documentos consolidados de cada repo → volcar lo general en agent-learn y archivos correspondientes → distribuir por el .ps1.
- **Verificación:** proyecto.md contiene el fichero de entornos con repo GitHub explícito por proyecto; el documento consolidado existe en el lugar determinado de cada repo de proyecto; los aprendizajes nuevos del meta-proyecto citan proyecto y documento de origen; 0 menciones a vías laterales de retorno.

### R2 — Estructura de producción de la respuesta [P2]
- **Normativa:** toda respuesta se produce en la estructura corto → narrativa → resumen: (1) corto, 2-3 frases; (2) narrativa, con los términos del Director y todos los números; (3) resumen, abarcador: toca cada aspecto de la respuesta sin omitir ninguno y cierra lo decidido y lo pendiente. La estructura es el modo de producción de la respuesta; el guardrail y el Panel permanecen como envoltura fija.
- **Operativa:** antes de emitir, componer las 3 partes en orden; el resumen repasa cada aspecto tratado (cada decisión, cada número, cada pendiente).
- **Verificación:** toda respuesta contiene las 3 partes en orden; el resumen cubre cada aspecto de la narrativa; la premisa codifica "resumen" como tercer elemento y el barrido de "respuesta estructurada" en operativos da 0 coincidencias.

### R3 — Escalera de validación de scripts (3 niveles) [P3]
- **Normativa:** todo script (y todo elemento) se valida en 3 niveles, en orden: individual, funcional y e2e según P3. No se pasa al siguiente nivel con el anterior en fallo.
- **Operativa:** el agente ejecuta los 3 niveles dentro de su verificación (I.2); asienta el resultado de cada nivel en la evidencia; la interacción se prueba contra los módulos reales del proyecto, no contra sustitutos.
- **Verificación:** la evidencia de validación muestra los 3 niveles con resultado; el veredicto registra el nivel alcanzado; 0 scripts dados por validados con niveles saltados.

### R4 — Baremo estratégico de datos reales [P4]
- **Normativa:** las validaciones se ejecutan siempre con datos reales si existen; si no es posible, sobre datos lo más reales posibles, declarándolo. Prohibido apoyar el veredicto en fallbacks y mocks. Baremo estratégico de todos los proyectos DCEPI.
- **Operativa:** antes de validar, identificar la fuente de datos reales del proyecto (su base, sus repos, sus documentos); mocks/fallbacks solo durante el desarrollo interno, nunca como soporte del veredicto; sin datos reales posibles, documentarlo y usar los más próximos declarándolo en la evidencia.
- **Verificación:** cada veredicto declara su fuente de datos; 0 veredictos apoyados en mocks en la evidencia; los mocks presentes quedan marcados como desarrollo, no como validación.

### R5 — Estándar del script de entrega en cada implementación [P5]
- **Normativa:** cada implementación de cualquier agente contiene su script de entrega — hermano del update_estrategia.ps1 v4.0.2 — que cubre de forma automática, sin intervención del Director donde sea posible y con la calidad y garantía de una implementación completa, los 4 aspectos: contenido (I.3a), funcionamiento en Windows (I.3b), condiciones previas (I.3c) y cierre por construcción (I.3e), con manifiesto, sentencia y checklist embebida, veredicto umbral cero asentado. Lo no automatizable queda señalado y escala.
- **Operativa:** el script + manifiesto + sentencia + checklist viajan dentro de la entrega; quien la recibe ejecuta la sentencia y obtiene veredicto; si un ítem falla, la entrega no se aplica y el elemento vuelve al DCEPI; el veredicto se asienta en el worklog.
- **Verificación:** toda entrega contiene sus 4 elementos; la ejecución produce veredicto asentado en el worklog; 0 entregas de proyecto sin script a partir de la v1.5.

### R6 — Generación del script por el agente de proyecto [P6]
- **Normativa:** el agente de proyecto genera el script de entrega desde la plantilla y la norma de dcepi.md I.3a (indicación clara y precisa); el script se genera como parte de la implementación, pasa el gauntlet de I.2 como cualquier otro archivo y debe superar el estándar R5. Si no lo supera: correcciones oportunas y reintento; 5 intentos (MAX_ITER, I.2); agotados, escalado al Director con el problema exacto (ítem, evidencia, diagnóstico), sin rodearlo ni reparar procesos ajenos.
- **Operativa:** en la I de cada implementación con entrega: instanciar la plantilla con el régimen del proyecto → someterla al gauntlet → ejecutar la escalera R3 sobre el script → entregar solo con el estándar superado.
- **Verificación:** la evidencia de I muestra los intentos y sus veredictos; 0 escalados sin los 5 intentos documentados; 0 scripts entregados fuera de la plantilla sin justificación conciliada.

## 5bis. Preguntas abiertas de la E (a conciliación del Director)

1. **Paquete operativo:** ¿las 2 plantillas nuevas viajan en el paquete operativo (crece de 6 a 7 elementos) o solo en el repo completo? Afecta a OPERATIVO_KEEP y REQUIRED_FILES del script (intervención quirúrgica F7).
   **RESPUESTA DEL DIRECTOR (2026-11-02, al aprobar E y P):** las dos carpetas nuevas (`retorno/` y `plantillas/`) se abren en la raíz de la **estrategia operativa**, con las dos plantillas dentro de `plantillas/` y `worklog_template.md` (que es una plantilla) reubicado allí desde la raíz. El paquete operativo queda en **siete elementos**: `agent-context/`, `agent-learn/`, `plantillas/`, `retorno/`, `worklog_protocolo.md`, `prompt_arranque.md`, `premisa_respuesta.md`.
2. **Lugar determinado del documento consolidado:** se propone fijarlo como `retorno/documento_consolidado.md` en la raíz de cada repo de proyecto (M1 de P1). Alternativa: otra ruta que el Director prefiera.
   **RESPUESTA DEL DIRECTOR (2026-11-02):** el lugar se llama `retorno/` (la misma carpeta se abre en la raíz de la estrategia del meta-proyecto como lugar de aterrizaje de la cosecha M2, con las copias `<PROYECTO>_documento_consolidado.md`).

## 6. Criterios de aceptación (verificables)

1. **Barrido anti-retirados** en archivos operativos: "respuesta estructurada" como tercer elemento → 0 coincidencias; "resumen" y "abarcador" presentes en la premisa (los históricos de meta/ y worklogs conservan su historia).
2. **dcepi.md** contiene la escalera de 3 niveles (I.2), el baremo de datos reales (§8), la obligación del script de entrega (I.3a) y la cosecha en 2 momentos (I.3c/d).
3. **Las 2 plantillas existen** y la .ps1 pasa verificación estática (ASCII puro, sintaxis, checklist embebida, umbral cero).
4. **contrato.md** contiene NH24–NH26 en triple redacción, numeración continua con las vigentes.
5. **proyecto.md** contiene el fichero de entornos (repos GitHub explícitos de EP/APA/MB/CZAI), el protocolo de cosecha y el lugar determinado.
6. **update_estrategia.ps1:** el diff queda limitado a su intervención quirúrgica (listas + cabecera + menciones); el resto del algoritmo byte-idéntico al v4.0.2.
7. **Triple redacción completa:** toda regla nueva R1–R6 con sus 3 redacciones en los archivos de destino.
8. **Manifiesto regenerado** con verificación 100% y diff zip↔disco CERO (en I), y sentencia v1.5 en download/.
