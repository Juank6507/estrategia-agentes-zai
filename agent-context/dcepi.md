<!-- Ubicacion: estrategia/agent-context/dcepi.md (v1.4)
     Sede canonica del metodo DCEPI. Descripcion integra: que es, que problemas corrige,
     sus elementos y subelementos, como se usa, se valora e implementa cada uno y como
     influye cada pieza en la solucion. Las reglas NH viven en contrato.md; la premisa, en
     premisa_respuesta.md (raiz). -->

# PROTOCOLO DCEPI v1.4

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

## 2. Premisa de respuesta (transversal a los cinco elementos)

Antes de responder CUALQUIER mensaje se ejecuta `premisa_respuesta.md` (raíz de la estrategia):

- Primera línea de toda respuesta: frase de control `[FASE: X | Estrategia: activa]` (X = elemento vigente) + panel de checkmarks del elemento, antes de cualquier otro contenido. Emitirla correctamente = autoverificación; no poder emitirla = pérdida de contexto → `[ESTADO: RECUPERACION]` y protocolo de recuperación espontánea (única excepción de guardrail). Su omisión detiene el proceso y/o invalida la respuesta.
- La respuesta corresponde a los subelementos del elemento vigente (tabla de mapeo en la premisa).
- Estándar: simple y precisa; solo se amplía a petición del Director.

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

**Cómo se valora:** el Director lee el diagnóstico y decide si pasa a conciliación; el panel de checkmarks muestra los 13 factores respondidos.

**Cómo influye en la solución:** alimenta la E — el factor 6 (causa raíz) alimenta el factor 2 de E (por qué falla); el factor 5 (hipótesis de causa) se convierte en precondición en E.

---

## 4. C — CONCILIACIÓN

**Qué es:** el acuerdo punto por punto con el Director sobre qué se hace y cómo se verificará.

**Qué problema corrige:** elimina las decisiones unilaterales y las implementaciones sin criterio de aceptación; aquí se fija el baremo (el estándar con el que se juzgará el resultado, con datos reales del chat).

**Cómo se usa:**
- Conciliación **punto por punto** hasta cierre explícito (nada queda "sobrentendido").
- Aquí el Director fija el **baremo estratégico** (estándar de respuesta para el error). Se registra en el **DTI del proyecto**.
- Acuerdo de alcance: qué entra, qué no entra, qué queda retirado.
- Las divergencias detectadas se concilian aquí: cada una con su explicación, sus salidas posibles y la salida elegida por el Director.

**Cómo se valora:** cierre explícito del Director, punto por punto (panel de checkmarks con `[x]`/`[?]`); sin puntos abiertos no se pasa a E.

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

**Cómo se valora:** el Director **valida la E** (no el plan). La E puede emitirse junto con la P en el mismo prompt si el Director lo pide.

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

**Cómo se valora:** el Director prioriza/ordena las fases; el plan se registra en meta/ y su cumplimiento se verifica fase a fase en I (veredictos).

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
6. Cierre autónomo: golden master actualizado + commit local autogenerado (el push a GitHub es del Director, I.3c)

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

### I.3 Entregas y cierre

**I.3a — Entrega (DOS regímenes, aprobados por el Director):**
- **Regla general (proyectos de aplicación):** solo los archivos modificados en `.zip` (en `/download/`), con sus tests y sentencias de prueba y de actualización; salvo los tests E2E, que cubren todo el proyecto.
- **Meta-proyecto (este):** entrega SIEMPRE COMPLETA de todos los archivos, modificados o no, en `.zip` en `/download/` con reemplazo total en la PC del Director. Incluye siempre `update_estrategia.ps1`, el worklog y la **sentencia de PowerShell** que extrae el script del zip y lo ejecuta (v1.4).

**I.3b — Baremo de doble entorno (sandbox Linux → Windows del Director):** cada archivo modificado se entrega con validación interna + evidencia de superación en el sandbox + sentencias para que el Director valide igual en su entorno Windows + superación de tests E2E del proyecto. Si no supera → vuelve al DCEPI.

**I.3c — Actualización de los dos repos (la ejecuta el Director con la sentencia):** con la entrega descargada, el Director pega la sentencia de PowerShell que extrae `update_estrategia.ps1` del `.zip` y lo ejecuta. El script (v4.0.2, exclusivo del meta-proyecto), preguntando con valores predeterminados (Enter acepta):
1. Carpeta del zip (predeterminada: `%USERPROFILE%\Downloads`; toma el `estrategia_v*.zip` de MAYOR VERSIÓN del nombre — empate: el más reciente por fecha; la sentencia de cada entrega fija el NOMBRE EXACTO y `-ZipPath` lo fuerza; si el nombre no cuadra con la VERSION del manifiesto, avisa y Enter aborta).
2. Carpeta del repo local (predeterminada `C:\Python\Proyectos\estrategia`; `-RepoDir` la fuerza): verifica la integridad SHA256 de cada archivo contra `MANIFIESTO_ENTREGA.txt` (umbral cero: aborta sin tocar nada si algo no cuadra), BORRA TODO el contenido (conserva solo `.git`) y descomprime el `.zip` íntegro — al ser reemplazo total no hace falta purga de retirados.
3. Los dos repos GitHub a publicar (predeterminados: completo `estrategia-agentes-zai` y operativo `estrategia-agentes-zai-operativo`): commit + push del contenido completo al repo **completo** y publicación del **paquete operativo de seis elementos** en el repo **operativo** (remite a proyecto.md, sección 2).
4. DIFF entre GitHub (tras actualizar) y la carpeta local: verifica DIFF CERO y guarda SIEMPRE el informe con acentos correctos en Downloads (`DIFF_ENTREGA_estrategia_v<version>.txt`), también cuando el repo local no cambia.
5. Modos auxiliares: `-DryRun` (simulación), `-NoPush` (solo repo local).

Sentencias manuales equivalentes (solo si el script no pudiera ejecutarse):

```powershell
cd C:\Python\Proyectos\estrategia
git checkout main; git add -A; git commit -m "v1.4: <descripcion>"
git pull --rebase origin main; git push -u origin main
# Repo operativo: rama local 'operativo' con los seis elementos, push a su remoto
# (el script la construye y la publica automaticamente)
```

**I.3d — Aprendizajes y cierre del método (diff cero):** diff entre cada archivo intervenido (workspace del agente vs repositorio) = **CERO diferencias** → actualizar worklog + tareas inmediatas + aprendizajes. Aprendizajes **genéricos** → `agent-learn/` (accesibles a todos los agentes en el paquete operativo); **específicos** → DTI del proyecto; el worklog queda narrativo.

**Regla de aprendizajes (v1.4, conciliada):** los aprendizajes **se proponen al cerrar la conciliación de la E y antes de trazar el plan**, y se **implementan junto a todo lo demás** dentro de la I, viajando en la entrega (`.zip` con verificación de integridad) a los dos repos. No existe la vía de push directo desde el sandbox (NH5): la única salida de los aprendizajes es la entrega verificada. El Director autoriza las propuestas; sin autorización, no se escriben.

**I.3e — Re-clonado final (cierre por construcción, v1.3/v1.4):** tras el push del Director (I.3c), cada agente elimina su carpeta local de la estrategia y la re-clona fresca desde **su repo** (por identidad, `proyecto.md` §2): el agente EP desde el repo **completo**; los agentes de proyecto desde el repo **operativo**. El entorno del agente queda garantizado por construcción: lo que hay en disco == lo que hay en GitHub == lo que se entregó. Es el paso final obligatorio del ciclo; sin él, el clon local puede divergir del repo. Ejecutarlo solo cuando el Director confirme el push completado.

**Cómo se valora la I:** veredicto JSON sin items_fallados, diff cero contra el repo, manifiesto íntegro (umbral cero), DIFF zip↔clon↔GitHub CERO y panel de checkmarks completo; el Director valida el resultado con el baremo estratégico fijado en C.

**Cómo influye en la solución:** produce el único resultado que el método acepta: un cambio verificado, entregado por completo y publicable tal cual en los dos repos.

---

## 8. Baremos (procedimiento)

| Baremo | Propietario | Momento | Registro | Aplicación |
|---|---|---|---|---|
| **Estratégico** | Director | C (estándar de respuesta para el error) | DTI del proyecto | Valida el resultado de I |
| **Táctico** | Agente | P (derivado del estratégico) | Junto al plan | Umbral cero del Crítico en I.2; umbrales de perímetro de líneas por intervención (deletions = 0 por defecto solo en intervenciones puramente aditivas) |

`dcepi.md` contiene solo el PROCEDIMIENTO; el contenido estratégico vive en el DTI del proyecto. Regla de ubicación: transversal → estrategia; específico → DTI/proyecto.

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
