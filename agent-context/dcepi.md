<!-- Ubicacion: estrategia/agent-context/dcepi.md (v1.5)
     Sede canonica del metodo DCEPI. Descripcion integra: que es, que problemas corrige,
     sus elementos y subelementos, como se usa, se valora e implementa cada uno y como
     influye cada pieza en la solucion. Las reglas NH viven en contrato.md; la premisa, en
     premisa_respuesta.md (raiz). -->

# PROTOCOLO DCEPI v1.5

## 1. Definición y propósito

**D**iagnóstico → **C**onciliación → **E**specificación → **P**lan → **I**mplementación.

Todo trabajo que implique modificar código, corregir un bug o cambiar la arquitectura sigue este protocolo. Los elementos son SOLO estos cinco: D, C, E, P, I.

**Qué problemas corrige el método:** cada elemento existe para cerrar un modo de fallo concreto y verificado en la práctica del proyecto:

| Modo de fallo que corrige | Elemento que lo cierra |
|---|---|
| Actuar sin entender el problema (parches a ciegas) | **D** — nada se toca sin los 13 factores respondidos |
| Decidir sin consenso o sin criterio de verificación | **C** — nada se ejecuta sin conciliación punto por punto y baremo fijado |
| Implementar sin alcance ni criterios de aceptación | **E** — archivos tocables y verificaciones definidos antes del plan |
| Trabajo desordenado o incompleto | **P** — fases obligatorias en orden, sin saltarse subelementos |
| Entregas rotas, incompletas o no verificadas | **I** — Gauntlet, veredicto JSON, umbral cero y entrega completa |
| Perder el hilo por pérdida de contexto | Premisa transversal + worklog (ver §2) |

**Barrido permanente (0 coincidencias literales en archivos operativos):** queda PROHIBIDA toda descomposición del método distinta de la oficial (D → C → E → P → I), así como su protocolo predecesor y la taxonomía retirada de dieciocho aspectos del SDD de proyectos completos. Ningún archivo operativo los enseña ni los usa; los nombres exactos de lo retirado y el registro histórico viven solo en meta/ (spec, plan, historial). Notación abreviada abolida: siempre palabras completas PRESCRIPTIVA / GUARDRAIL, que no son elementos del método.

### 1.1 Modo de ejecución (v1.6, D6 — descrito UNA sola vez, en el flujo común de los cinco elementos)

Cada elemento se ejecuta con el MISMO modo; este bloque vive aquí y los cinco elementos remiten a él (sus Gauntlet lo nombran):

1. **Prompt único** del agente con la conciliación vigente y los guardrails.
2. **UN SOLO subagente lanzado** — el **ACTUADOR** — que lo ejecuta (metodología Agentic CI/CD Loop v2 en vigor, I.2; SIN doble implementación: la doble ejecución en paralelo queda RETIRADA por decisión del Director, D6).
3. **UNA respuesta/especificación completa** del Actuador.
4. **Valoración del agente-CRÍTICO** contra los guardrails y los sub-elementos del elemento.
5. **Clasificación** del resultado: conforme / divergente / mejorable sobre lo conciliado — NADA seleccionado por el agente.
6. Lo mejorable sobre lo conciliado se explica y **SE RE-CONCILIA** con el Director antes de implementar (C1).
7. **Solo lo conciliado se implementa**; evidencia en worklog y panel de checkmarks.

## 2. Premisa de respuesta (transversal a los cinco elementos)

Antes de responder CUALQUIER mensaje se ejecuta `premisa_respuesta.md` (raíz de la estrategia):

- Primera línea de toda respuesta: frase de control `[FASE: X | Estrategia: activa]` (X = elemento vigente) + panel de checkmarks del elemento, antes de cualquier otro contenido. Emitirla correctamente = autoverificación; no poder emitirla = pérdida de contexto → `[ESTADO: RECUPERACION]` y protocolo de recuperación espontánea (única excepción de guardrail). Su omisión detiene el proceso y/o invalida la respuesta.
- La respuesta corresponde a los subelementos del elemento vigente (tabla de mapeo en la premisa).
- Estructura de producción de la respuesta (v1.5): corto → narrativa → resumen, con el resumen abarcador (toca cada aspecto sin omitir ninguno); simple y precisa, sin relleno; solo se amplía a petición del Director. Norma y ejecución: `premisa_respuesta.md` (sede, §2.3).

---

## 3. D — DIAGNÓSTICO

**Qué es:** la fase de entrada; describe el problema antes de tocar nada.

**Qué problema corrige:** elimina el actuar a ciegas; obliga a observar, reproducir e hipotetizar antes de cambiar.

**Cómo se usa:**

### D.0 Recogida de contexto (se responde UNA vez por sesión; solo se re-ejecuta completa cuando la recuperación de contexto la invalida)
1. Leer worklog (continuidad de sesiones) y tareas_inmediatas.
2. Consultar `herramientas.md` (conciencia instrumental).
3. Identificar proyecto, repos y estado del código afectado (arranque por identidad: `proyecto.md`).

### D.1–D.13 Los 13 factores del diagnóstico (se responden en CADA diagnóstico)

| Tipo | Factores |
|---|---|
| **Imprescindibles (5)** | 1. Qué se observa · 2. Dónde se observa · 3. Cómo se reproduce · 4. Qué cambió recientemente · 5. Hipótesis de causa |
| **Necesarios (5)** | 6. Causa raíz confirmada · 7. Alcance del impacto · 8. Gravedad y urgencia · 9. Estado del código afectado · 10. Historial del problema |
| **Prescindibles (3)** | 11. Evidencia técnica · 12. Entorno de ocurrencia · 13. Patrones relacionados |

Respuesta coherente y abarcadora pero simple y precisa (ampliable solo a petición del Director). **Factor 6 (protección):** los grafos y el algoritmo de un script existente NO se tocan fuera de su intervención quirúrgica concreta.

**Cómo se valora:** el Director lee el diagnóstico y decide si pasa a conciliación; el panel de checkmarks muestra los 13 factores respondidos. **Gauntlet de este elemento (v1.6, NH27):** antes de darse por terminado rebasa su Gauntlet (cuerpo común en §1.1): se evalúa la entrega del elemento — el diagnóstico — contra los 13 factores (D.0 + D.1-D.13) y los guardrails.

**Cómo influye en la solución:** alimenta la E — el factor 6 (causa raíz) alimenta el factor 2 de E (por qué falla); el factor 5 (hipótesis de causa) se convierte en precondición en E.

---

## 4. C — CONCILIACIÓN

**Qué es:** el acuerdo punto por punto con el Director sobre qué se hace y cómo se verificará.

**Qué problema corrige:** elimina las decisiones unilaterales y las implementaciones sin criterio de aceptación; aquí se fija el baremo (el estándar con el que se juzgará el resultado, con datos reales del chat).

**Cómo se usa:**
- Conciliación **punto por punto** hasta cierre explícito (nada queda "sobrentendido").
- Aquí el Director fija el **baremo estratégico** (estándar de respuesta para el error) y de él se deriva el **táctico** del ciclo. El estratégico vive y viaja en la ESTRATEGIA — `plantillas/plantilla_baremo_estrategico.md` —, NO en el DTI del proyecto (D5/P2, v1.6).
- Acuerdo de alcance: qué entra, qué no entra, qué queda retirado.
- Las divergencias detectadas se concilian aquí: cada una con su explicación, sus salidas posibles y la salida elegida por el Director.

**Cómo se valora:** cierre explícito del Director, punto por punto (panel de checkmarks con `[x]`/`[?]`); sin puntos abiertos no se pasa a E. **Gauntlet de este elemento (v1.6, NH27):** antes de darse por terminado rebasa su Gauntlet (cuerpo común en §1.1): se evalúa la entrega del elemento — la conciliación — punto por punto, sin puntos abiertos y con el baremo estratégico fijado por el Director.

**Cómo influye en la solución:** su salida (decisiones + baremo) es la materia prima de la E y la condición para validar la I; sin baremo fijado, la I es vicio de procedimiento y se invalida (precedente S45/S46).

---

## 5. E — ESPECIFICACIÓN

**Qué es:** la traducción técnica del acuerdo: qué cambia, dónde, con qué criterios de aceptación.

**Qué problema corrige:** elimina los alcances difusos y las implementaciones sin verificación posible; define el perímetro exacto del trabajo.

**Cómo se usa:**

### E.1–E.3 Los 13 factores de la especificación

| Tipo | Factores |
|---|---|
| **Imprescindibles (5)** | 1. Qué falla · 2. Por qué falla · 3. Dónde falla · 4. Cómo reproducirlo · 5. Qué debe pasar después |
| **Necesarios (5)** | 6. Qué no se toca · 7. Precondiciones · 8. Invariantes · 9. Impacto colateral · 10. Severidad |
| **Prescindibles (3)** | 11. Evidencia · 12. Antecedentes · 13. Alternativas descartadas |

### Reglas de la E
- **Factor 6 (protección):** los grafos y el algoritmo de un script existente NO se tocan fuera de su intervención quirúrgica concreta.
- El alcance por archivos se emite con la E (archivos nuevos, modificados, eliminados).
- Los criterios de aceptación de la E deben ser **verificables** (greps, tests, diffs con umbral cero).
- Barrido anti-retirados: la E declara qué notaciones/taxonomías retiradas deben quedar en 0 coincidencias.
- **La revisión integral no deja nada fuera (v1.4):** todos los archivos del repo se revisan; solo los worklogs (historia: las correcciones van como notas) y los PDFs (referencia externa) no se reescriben por naturaleza.

### Protocolo del panel de checkmarks (R29, v1.3 — orden del Director tras la incidencia S45)

Cero interpretación del LLM en el guardrails, el método y cada uno de sus subelementos: cada punto y subpunto de cada elemento se ejecuta como checklist exigible y visible.

1. **Panel por respuesta:** toda respuesta muestra, bajo la frase de control, el panel del elemento vigente con CADA punto precedido de su pregunta correspondiente.
2. **Estados:** `[x]` cumplido (con evidencia en disco) / `[?]` sin respuesta conocida (se pregunta al Director, nunca se suple). El agente recopila información hasta dar por conciliado o respondido cada punto, y toda respuesta hace referencia a cada punto y su estado.
3. **Reapertura mínima:** sólo se reabre lo que no tiene respuesta conocida hasta ese momento.
4. **Subsubelementos:** quedan a decisión del agente colocarlos como checkmark (ejemplo: los 13 subelementos del D se muestran como panel; dentro de ellos, el agente puede abrir subsubelementos marcados).
5. **Registro:** al cierre de cada elemento, la checklist íntegra con evidencias se copia al worklog (trazabilidad).
6. **Ejecución de la norma:** la regla vive en triple redacción — este elemento E (norma), premisa_respuesta.md §2.4 y §5 (ejecución por respuesta) y la Regla Conductual Mínima del worklog (cabecera de plantilla y canónico).
7. **Lenguaje del panel (enmienda del Director, S50):** cada checkmark se redacta en lenguaje natural, en los términos del Director: qué se hizo, qué falta y qué debe decidir. La jerga técnica (identificadores de commit, comandos, hashes, diffs, rutas) NO es el idioma del panel: queda en el worklog como evidencia (trazabilidad) y se amplía solo a petición expresa. Un punto técnicamente cierto pero redactado en jerga se considera NO conforme (incumple NH3 y comunicacion.md).
8. **Regla de evidencia del panel (v1.6):** la evidencia de cada checkmark es la valoración del Crítico sobre la respuesta del Actuador + el veredicto del Gauntlet; lo del Director, sus mensajes. Espejo en `premisa_respuesta.md` §2.4 y en el punto 5 de la Regla Conductual Mínima del worklog (ambas cabeceras), misma redacción — sincronía NH20 capa 1.

**Cómo se valora:** el Director **valida la E** (no el plan). La E puede emitirse junto con la P en el mismo prompt si el Director lo pide. **Gauntlet de este elemento (v1.6, NH27):** antes de darse por terminado rebasa su Gauntlet (cuerpo común en §1.1): se evalúa la entrega del elemento — la especificación — contra los 13 factores y sus reglas, y el panel según R29.

**Cómo influye en la solución:** define el perímetro (tabla de alcance de I.1), los criterios de aceptación del Gauntlet y las precondiciones; es el contrato contra el que el Crítico emite veredicto.

---

## 6. P — PLAN

**Qué es:** el orden de ejecución que responde a la especificación.

**Qué problema corrige:** elimina el trabajo desordenado y los subelementos saltados; cada fase nace con su verificación.

**Cómo se usa:**
- Fase **técnica del agente**: el plan responde a la spec, fase por fase.
- El Director NO valida el plan; en P **solo prioriza el orden** según su estrategia de trabajo.
- La **autorización de ejecución ocurre al entrar a I** (sin autorización, no se toca nada).
- Criterios técnicos permanentes del Director: buenas prácticas, OOP, prohibición de hardcoding, mocks/fallbacks solo cuando no exista posibilidad de datos reales explícitos o implícitos.

**Cómo se valora:** el Director prioriza/ordena las fases; el plan se registra en meta/ y su cumplimiento se verifica fase a fase en I (veredictos). **Gauntlet de este elemento (v1.6, NH27):** antes de darse por terminado rebasa su Gauntlet (cuerpo común en §1.1): se evalúa la entrega del elemento — el plan — completo, priorizado por el Director y verificable fase a fase.

**Cómo influye en la solución:** convierte la spec en secuencia ejecutable con verificaciones intermedias; es lo que el panel de checkmarks va marcando durante la I.

---

## 7. I — IMPLEMENTACIÓN

**Qué es:** la ejecución quirúrgica y verificada del plan.

**Qué problema corrige:** elimina las entregas rotas o incompletas y los cambios colaterales no pedidos.

**Cómo se usa:**

### I.1 Precondiciones (sin ellas no se empieza)
1. **Snapshot de regresión** (golden master) del área a intervenir.
2. **Repositorio montado** y en estado conocido.
3. **Tabla de alcance**: lista de archivos tocables.
4. **Grafos/algoritmo protegidos** identificados y excluidos.

### I.2 ACCL v2 (Agentic CI/CD Loop — metodología de referencia: PDFs en estrategia/meta/)

**Roles:**
- **Orquestador**: no escribe código ni opina; descompone en **intervenciones quirúrgicas** de una sola.
- **Actor**: ejecuta solo lo listado y propone el diff.
- **Crítico**: executor de comandos con umbral cero; NO lee el código para opinar; el fuzzing se deriva de la spec (factor 5: qué debe pasar después).

**7 fases:**
0. Precondiciones (golden master, respaldo, perímetro, entorno) ≙ I.1
1. Descomposición quirúrgica en intervenciones
2. El Actor propone el diff
3. **Gauntlet determinista**, en orden OBLIGATORIO: regresión (vs snapshot) → perímetro_archivos → perímetro_líneas → estática → dinámica → lógica (con fuzzing)
4. **Veredicto JSON** del Crítico
5. Auto-corrección del Actor con feedback estructurado
6. Cierre autónomo: golden master actualizado + commit local autogenerado (el push a GitHub es del Director, I.3.c)

**Veredicto JSON (schema fijo):**

```json
{
  "aprobado": true,
  "items_fallados": [],
  "motivo": "",
  "vuelve_a": "",
  "comandos_fallidos": [{"comando": "", "esperado": "", "obtenido": "", "evidencia": ""}]
}
```

**MAX_ITER = 5** por defecto (ajustable por el Director). Superado el límite → **escalado al Director** con el historial de veredictos.

**Escalado por fallo de herramienta o proceso (v1.3):** si una herramienta o un proceso externo (p. ej. contexto_zai) falla y bloquea la tarea, el agente NO lo repara ni lo rodea: documenta el fallo (qué se intentó, error exacto, evidencia) y escala al Director con el diagnóstico. La reparación de procesos externos es competencia del Director o del proyecto propietario del proceso.

**Las 3 capas de verificación:**

| Capa | Mecanismo | Umbral |
|---|---|---|
| 1. Consulta en la premisa | Reglas escritas: NH1, NH2, NH6, NH8, NH14, NH18, NH23 | 100% consultadas |
| 2. Veredicto JSON | El Crítico emite el schema fijo | Sin items_fallados |
| 3. Programática | `git diff --name-only` (solo archivos de la tabla de alcance), grep de residuos = 0, exit 0 | Cero diferencias; con fallo, no sale del sandbox |

**Escalera de validación de scripts (v1.5, R3):** todo script (y todo elemento) se valida en 3 niveles, en orden, y NO se pasa al siguiente con el anterior en fallo: **individual** (cada aspecto que toca, por separado) → **funcional** (la funcionalidad que intenta resolver, probando la interacción con los módulos/scripts de los que depende, o aislado si no depende de otros) → **e2e** (demostrar que funciona correctamente dentro del proyecto real en marcha). La evidencia asienta el resultado de cada nivel; el veredicto registra el nivel alcanzado; la interacción se prueba contra los módulos reales del proyecto, no contra sustitutos. 0 scripts dados por validados con niveles saltados.

**Baremo de datos reales (v1.5, R4):** las validaciones se ejecutan siempre con datos reales si existen; si no es posible, sobre datos lo más reales posibles, declarándolo en la evidencia. Prohibido apoyar un veredicto en fallbacks y mocks (encubren errores reales); los mocks presentes quedan marcados como desarrollo, nunca como validación. Antes de validar se identifica la fuente de datos reales del proyecto (su base, sus repos, sus documentos). Baremo estratégico de todos los proyectos DCEPI (procedimiento en §8).

**Gauntlet de terminación (v1.6, NH27):** al terminar la I — tras actualizar los ficheros de la mejora y ANTES del empaquetado (I.3.a) — se prueba con DATOS REALES (NH25) que las mejoras satisfacen el baremo táctico fijado en la Conciliación (C) del ciclo: aquí debe funcionar 100% correcto. Evidencia en worklog + panel de checkmarks; **empaquetado bloqueado hasta veredicto verde**. Si falla: iteración AUTÓNOMA, máximo 5 intentos (MAX_ITER), SIN intervención del Director. El bucle de cada intento (D7): revisar las fallas existentes respecto a lo CONCILIADO en la spec → modificar el prompt corrigiendo esa falla → re-entregarlo al Actuador para que modifique el script → el agente, como Crítico/supervisor, re-valorar y re-probar contra el baremo. Solo agotados los 5: escalado al Director con informe de TODAS las iteraciones una a una (qué falló → qué se diagnosticó → cómo se corrigió → qué se implementó; A1). **En Windows (I.3.b, A1):** tras ajustes de rutas y cosas menores SE VUELVE A PASAR el baremo, con la misma iteración autónoma y el mismo informe si no pasa; ante diferencias IRRECONCILIABLES entre entornos manda el Linux del agente, donde vive y trabaja el proceso contexto_zai.

### I.3 Entregas y cierre

**I.3.a — Entrega (DOS regímenes, aprobados por el Director):**
- **Regla general (proyectos de aplicación):** solo los archivos modificados en `.zip` (en `/download/`), con sus tests y sentencias de prueba y de actualización; salvo los tests E2E, que cubren todo el proyecto.
- **Meta-proyecto (este):** entrega SIEMPRE COMPLETA de todos los archivos, modificados o no, en `.zip` en `/download/` con reemplazo total en la PC del Director. Incluye siempre `update_estrategia.ps1`, el worklog y la **sentencia de PowerShell** que extrae el script del zip y lo ejecuta (v1.4).
- **Script de entrega obligatorio en toda implementación (v1.5, R5/R6):** cada implementación de cualquier agente viaja con su script de entrega — hermano del `update_estrategia.ps1` — generado por el agente desde `plantillas/plantilla_script_entrega_proyecto.ps1` (la indicación clara y precisa es esta norma + la plantilla). El script cubre de forma automática, sin intervención del Director donde sea posible y con calidad y garantía de implementación completa, los 4 aspectos del cruce: (a) contenido de la entrega según su régimen (este I.3.a); (b) funcionamiento en Windows de lo entregado, con las sentencias de prueba y los tests e2e que viajan con ella (I.3.b); (c) condiciones previas consumidas (I.3.c); (d) cierre por construcción con veredicto umbral cero asentado que condiciona el re-clonado (I.3.e). Incluye manifiesto, sentencia de lanzamiento y checklist embebida; lo no automatizable queda señalado y escala. El script se genera como parte de la implementación, pasa el Gauntlet de I.2 como cualquier otro archivo y se valida con la escalera R3; si no supera el estándar: correcciones oportunas y reintento con **5 intentos (MAX_ITER, I.2)**; agotados, escalado al Director con el problema exacto (qué ítem falla, evidencia, diagnóstico), sin rodearlo ni reparar procesos ajenos. 0 entregas de proyecto sin script a partir de la v1.5.
**Invocación obligatoria de la plantilla durante la implementación — elemento I del DCEPI (v1.5.3, orden del Director; corrige la reducción formulada en la v1.5.2; ampliación en v1.5.4):** la plantilla `plantillas/plantilla_script_entrega_proyecto.ps1` **no se reduce ni se altera sin orden expresa del Director**: su interfaz `param()`, sus funciones, su manifiesto, su checklist embebida, su sentencia de lanzamiento y su informe se mantienen, y **no se reduce a los cuatro subelementos de abajo ni se redefine por ellos**: son la plantilla y el elemento I los que la invocan, no al revés. Por orden del Director (v1.5.4) la plantilla se **AMPLÍA a v1.1** con sus **12 pasos del script de entrega** — 8 funciones nuevas que se AÑADEN sin quitar ni reducir nada de lo existente (contrato completo en el párrafo siguiente). Lo que ordena el Director es su **invocación obligatoria durante la implementación, como parte del elemento I del DCEPI ENTERO** — no como un caso suelto ni como un conjunto cerrado de cuatro puntos. Dentro de ese elemento I, el Director fija cuatro **subelementos de entrega** donde la invocación se hace explícita y verificable: **(1) entrega** — el script de la implementación se instancia desde la plantilla, sin excepción (mecanismo en este I.3.a); **(2) validación de los scripts en el entorno Windows del Director** — la validación viaja dentro del script instanciado y se ejecuta con su sentencia de lanzamiento (mecanismo en I.3.b); **(3) actualización del repositorio del proyecto** — la cadena de actualización (commit y push) se ejecuta tras el veredicto APROBADO del script, que la condiciona; sin veredicto aprobado, umbral cero, no se toca el repositorio; **(4) generación del diff de comprobación** — el diff entre el repositorio actualizado y la entrega se genera y archiva como evidencia del cierre, junto al veredicto asentado. La instancia respeta el contrato de la plantilla: sustitución de los marcadores `<<...>>` y nada más — sin añadir ni quitar parámetros, sin alterar funciones — y la sentencia de lanzamiento exacta queda documentada en la entrega. La implementación que omita la plantilla donde el elemento I la ordena no sale del elemento I.

**Contrato de la plantilla v1.1 — los 12 pasos del script de entrega (v1.5.4, orden del Director; informe de CZAI conciliado como opción A):** el Director fijó los 12 pasos que todo script de entrega de proyecto debe cumplir: (1) el Director descarga el .zip del proyecto en Descargas de Windows; (2) el script busca el .zip de mayor versión del proyecto; (3) localiza el repositorio local del proyecto; (4) asume rutas y .zip detectados como predeterminados; (5) pregunta si son correctos y ejecuta (Enter = aceptar, escribir ruta = sobreescribir); (6) elimina el contenido del repo local conservando .git; (7) descomprime el .zip en el repo local; (8) valida según la secuencia sandbox Linux → Windows del Director (C1-C7); (9) si no pasa al 100%, entrega un .txt legible con el problema y NO aplica la entrega; (10) re-limpieza y re-descompresión tras la validación (el repo queda EXACTO al .zip); (11) actualiza el repositorio del proyecto en GitHub (commit + push); (12) genera el diff de triple igualdad .zip ↔ repo local ↔ GitHub y emite SIEMPRE el informe en Descargas. La plantilla v1.1 los cubre por construcción con las 8 funciones nuevas (Find-ZipInFolder, Find-RepoLocal, Confirm-Values, Remove-RepoLocal, Expand-Zip, Emit-TxtInforme, Re-CleanAndExpand, Invoke-GitCommit/Invoke-GitPush/Invoke-DiffCheck) manteniendo íntegras sus 8 funciones originales, su interfaz `param()` y su contrato de instancia (sustitución de marcadores `<<...>>` y nada más). Los pasos (11) y (12) ejecutan por construcción los subelementos (3) actualización del repositorio y (4) generación del diff del elemento I; el paso (9) materializa el umbral cero del subelemento (2) validación en Windows. La plantilla es competencia del EP (vive en la estrategia) y su ampliación precede a la instanciación de cualquier proyecto que la espere.

**I.3.b — Baremo de doble entorno (sandbox Linux → Windows del Director):** cada archivo modificado se entrega con validación interna + evidencia de superación en el sandbox + sentencias para que el Director valide igual en su entorno Windows + superación de tests E2E del proyecto. Si no supera → vuelve al DCEPI. **Mitad Windows automatizada (v1.5, R5):** el checklist de validación en Windows viaja DENTRO del script de entrega de la implementación: quien recibe la entrega ejecuta la sentencia y obtiene veredicto de contenido + funcionamiento (con los datos reales del proyecto, R4), asentado en el worklog; si un ítem falla, la entrega no se aplica y el elemento vuelve al DCEPI.

**I.3.c — Actualización de los dos repos (la ejecuta el Director con la sentencia):** con la entrega descargada, el Director pega la sentencia de PowerShell que extrae `update_estrategia.ps1` del `.zip` y lo ejecuta. El script (v4.1.0, exclusivo del meta-proyecto), preguntando con valores predeterminados (Enter acepta):

**Paso previo del agente EP — cosecha del retorno (M2, v1.5, R1):** antes de preparar la entrega, el agente EP lee los documentos consolidados de retorno de todos los proyectos del fichero de entornos (`proyecto.md`, secciones 3 y 6: repos GitHub explícitos), vuelca lo general en `agent-learn/` y en los archivos de estrategia correspondientes citando proyecto y documento de origen, y lo particular y específico permanece en el worklog de cada proyecto; la estrategia actualizada se redistribuye a todos los agentes con el propio script (repo operativo).
1. Carpeta del zip (predeterminada: `%USERPROFILE%\Downloads`; toma el `estrategia_v*.zip` de MAYOR VERSIÓN del nombre — empate: el más reciente por fecha; la sentencia de cada entrega fija el NOMBRE EXACTO y `-ZipPath` lo fuerza; si el nombre no cuadra con la VERSION del manifiesto, avisa y Enter aborta).
2. Carpeta del repo local (predeterminada `C:\Python\Proyectos\estrategia`; `-RepoDir` la fuerza): verifica la integridad SHA256 de cada archivo contra `MANIFIESTO_ENTREGA.txt` (umbral cero: aborta sin tocar nada si algo no cuadra), BORRA TODO el contenido (conserva solo `.git`) y descomprime el `.zip` íntegro — al ser reemplazo total no hace falta purga de retirados.
3. Los dos repos GitHub a publicar (predeterminados: completo `estrategia-agentes-zai` y operativo `estrategia-agentes-zai-operativo`): commit + push del contenido completo al repo **completo** y publicación del **paquete operativo de siete elementos** en el repo **operativo** (remite a proyecto.md, secciones 2 y 6).
4. DIFF entre GitHub (tras actualizar) y la carpeta local: verifica DIFF CERO y guarda SIEMPRE el informe con acentos correctos en Downloads (`DIFF_ENTREGA_estrategia_v<version>.txt`), también cuando el repo local no cambia.
5. Modos auxiliares: `-DryRun` (simulación), `-NoPush` (solo repo local).

Sentencias manuales equivalentes (solo si el script no pudiera ejecutarse):

```powershell
cd C:\Python\Proyectos\estrategia
git checkout main; git add -A; git commit -m "v1.4: <descripcion>"
git pull --rebase origin main; git push -u origin main
# Repo operativo: rama local 'operativo' con los siete elementos, push a su remoto
# (el script la construye y la publica automaticamente)
```

**I.3.d — Aprendizajes y cierre del método (diff cero):** diff entre cada archivo intervenido (workspace del agente vs repositorio) = **CERO diferencias** → actualizar worklog + tareas inmediatas + aprendizajes. Aprendizajes **genéricos** → `agent-learn/` (accesibles a todos los agentes en el paquete operativo); **específicos** → DTI del proyecto; el worklog queda narrativo.

**Regla de aprendizajes (v1.4, conciliada):** los aprendizajes **se proponen al cerrar la conciliación de la E y antes de trazar el plan**, y se **implementan junto a todo lo demás** dentro de la I, viajando en la entrega (`.zip` con verificación de integridad) a los dos repos. No existe la vía de push directo desde el sandbox (NH5): la única salida de los aprendizajes es la entrega verificada. El Director autoriza las propuestas; sin autorización, no se escriben.

**Regla de retorno (v1.5, R1):** la información que viaja del agente a la estrategia (lecciones_aprendidas, anti_patrones y cualquier información inversa) sigue la **vía repositorios en 2 momentos**. **M1** (elemento C del método de cada proyecto): el agente propone la ficha, el Director la aprueba, el agente actualiza el archivo de estrategia correspondiente en su espacio y genera el documento único consolidado desde `plantillas/plantilla_documento_consolidado.md`, depositado en el lugar determinado del repo del proyecto: `retorno/documento_consolidado.md`. **M2** (al actualizar la estrategia): el agente EP cosecha desde el fichero de entornos y el script redistribuye (I.3.c, paso previo). Lo general viaja en el documento consolidado; lo particular y específico permanece en el worklog del proyecto. No existe otra vía de retorno (NH26).

**I.3.e — Re-clonado final (cierre por construcción, v1.3/v1.4):** tras el push del Director (I.3.c), cada agente elimina su carpeta local de la estrategia y la re-clona fresca desde **su repo** (por identidad, `proyecto.md` §2): el agente EP desde el repo **completo**; los agentes de proyecto desde el repo **operativo**. El entorno del agente queda garantizado por construcción: lo que hay en disco == lo que hay en GitHub == lo que se entregó. Es el paso final obligatorio del ciclo; sin él, el clon local puede divergir del repo. Ejecutarlo solo cuando el Director confirme el push completado.

**Cómo se valora la I:** veredicto JSON sin items_fallados, diff cero contra el repo, manifiesto íntegro (umbral cero), DIFF zip↔clon↔GitHub CERO y panel de checkmarks completo; el Director valida el resultado con el baremo estratégico fijado en C. **Gauntlet de este elemento (v1.6, NH27) — el más fuerte de los cinco:** el Gauntlet de terminación con datos reales contra el baremo fijado en C (norma completa al final de I.2).

**Cómo influye en la solución:** produce el único resultado que el método acepta: un cambio verificado, entregado por completo y publicable tal cual en los dos repos.

---

## 8. Baremos (procedimiento)

| Baremo | Propietario | Momento | Registro | Aplicación |
|---|---|---|---|---|
| **Estratégico** | Director | C (estándar de respuesta para el error) | La ESTRATEGIA: `plantillas/plantilla_baremo_estrategico.md` (D5/P2, v1.6; NO en el DTI del proyecto) | Valida el resultado de I |
| **Táctico** | Agente | P (derivado del estratégico) | Junto al plan | Umbral cero del Crítico en I.2; umbrales de perímetro de líneas por intervención (deletions = 0 por defecto solo en intervenciones puramente aditivas) |

**Derivación del táctico desde la plantilla (v1.6, P2):** en cada ciclo, el baremo táctico se deriva en la Conciliación desde `plantillas/plantilla_baremo_estrategico.md`, criterio a criterio y con las 5 reglas de la plantilla: qué se exige → cómo se verifica con datos reales → qué evidencia lo acredita → resultado verde/rojo, razonable y basado en los datos reales del proyecto en cuestión (R4). El contenido específico P17+P18 permanece en CZAI.

`dcepi.md` contiene solo el PROCEDIMIENTO; el contenido estratégico vive en el DTI del proyecto, SALVO el baremo estratégico, que vive y viaja en la ESTRATEGIA (D5/P2, v1.6). Regla de ubicación: transversal → estrategia; específico → DTI/proyecto.

**Baremo de datos reales (v1.5, R4):** toda validación declara su fuente de datos: reales si existen; lo más reales posibles, declarado, si no es posible; prohibido apoyar el veredicto en fallbacks y mocks (norma completa en I.2). Aplica a todos los proyectos DCEPI.

## 9. Excepciones al DCEPI

- Preguntas informativas del Director (no requieren DCEPI)
- Investigación y análisis (no se modifica nada)
- Tareas de documentación solicitadas por el Director
- Decisiones de arquitectura menores (las toma el agente, según contrato.md)

## 10. Cuando el DCEPI es obligatorio

- Corrección de bugs
- Nueva funcionalidad
- Refactoring
- Cambio de dependencias
- Eliminación de código

## 11. Verificación previa (guardrail de máxima exposición)

Inmediatamente antes de escribir cualquier cambio de código, el agente **re-lee** `agent-context/contrato.md` para refrescar las reglas NH justo antes del momento más peligroso. No requiere respuesta al Director. Si alguna regla NH aplica a lo que va a hacer, la cumple.
