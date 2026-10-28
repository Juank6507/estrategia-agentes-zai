# PROTOCOLO DCEPI v1.3

## Definición

**D**iagnóstico → **C**onciliación → **E**specificación → **P**lan → **I**mplementación

Todo trabajo que implique modificar código, corregir un bug o cambiar la arquitectura sigue este protocolo. Los elementos son SOLO estos cinco: D, C, E, P, I.

**Barrido permanente (0 coincidencias literales en archivos operativos):** queda PROHIBIDA toda descomposición del método distinta de la oficial (D → C → E → P → I), así como su protocolo predecesor y la taxonomía retirada de dieciocho aspectos del SDD de proyectos completos. Ningún archivo operativo los enseña ni los usa; los nombres exactos de lo retirado y el registro histórico viven solo en meta/ (spec, plan, historial). Notación abreviada abolida: siempre palabras completas PRESCRIPTIVA / GUARDRAIL, que no son elementos del método.

---

## Premisa de respuesta (transversal)

Antes de responder CUALQUIER mensaje, se ejecuta `premisa_respuesta.md` (RAIZ de la estrategia desde v1.3):

- Primera línea de toda respuesta: frase de control `[FASE: X | Estrategia: activa]` (X = elemento vigente). Emitirla correctamente = autoverificación; no poder emitirla = pérdida de contexto → `[ESTADO: RECUPERACION]` y protocolo de recuperación espontánea (única excepción de guardrail).
- La respuesta corresponde a los subelementos del elemento vigente (tabla de mapeo en la premisa).
- Estándar: simple y precisa; solo se amplía a petición del Director.

---

## Fase de entrada: D — DIAGNÓSTICO

### D.0 Recogida de contexto (se responde UNA vez por sesión; solo se re-ejecuta completa cuando la recuperación de contexto la invalida)

1. Leer worklog (continuidad de sesiones) y tareas_inmediatas.
2. Consultar `herramientas.md` (conciencia instrumental: qué herramientas hay y cómo usarlas).
3. Identificar proyecto, repo, rama y estado del código afectado.

### D.1–D.13 Los 13 factores del diagnóstico (se responden en CADA diagnóstico)

| Tipo | Factores |
|---|---|
| **Imprescindibles (5)** | 1. Qué se observa · 2. Dónde se observa · 3. Cómo se reproduce · 4. Qué cambió recientemente · 5. Hipótesis de causa |
| **Necesarios (5)** | 6. Causa raíz confirmada · 7. Alcance del impacto · 8. Gravedad y urgencia · 9. Estado del código afectado · 10. Historial del problema |
| **Prescindibles (3)** | 11. Evidencia técnica · 12. Entorno de ocurrencia · 13. Patrones relacionados |

Respuesta coherente y abarcadora pero simple y precisa (ampliable solo a petición del Director).

**Conexión D→E:** el factor 6 (causa raíz) alimenta el factor 2 de E (por qué falla); el factor 5 (hipótesis de causa) se convierte en precondición en E.

---

## Elemento C — CONCILIACIÓN

- Conciliación **punto por punto** con el Director hasta cierre explícito.
- Aquí el Director fija el **baremo estratégico** (estándar de respuesta para el error). Se registra en el **DTI del proyecto**.
- Acuerdo de alcance: qué entra, qué no entra, qué queda retirado.
- Guard NH8/NH14: nada se ejecuta ni decisión de arquitectura relevante se toma sin consenso; **única excepción: la auto-recuperación de contexto** (premisa_respuesta.md).

---

## Elemento E — ESPECIFICACIÓN

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
- El Director **valida la E** (no el plan). La E puede emitirse junto con la P en el mismo prompt si el Director lo pide.

### Protocolo del panel de checkmarks (R29, v1.3 — orden del Director tras la incidencia S45)

Cero interpretación del LLM en el guardrails, el método y cada uno de sus subelementos: cada punto y subpunto de cada elemento se ejecuta como checklist exigible y visible.

1. **Panel por respuesta:** toda respuesta muestra, bajo la frase de control, el panel del elemento vigente con CADA punto precedido de su pregunta correspondiente.
2. **Estados:** `[x]` cumplido (con evidencia en disco) / `[?]` sin respuesta conocida (se pregunta al Director, nunca se suple). El agente recopila información hasta dar por conciliado o respondido cada punto, y toda respuesta hace referencia a cada punto y su estado.
3. **Reapertura mínima:** sólo se reabre lo que no tiene respuesta conocida hasta ese momento.
4. **Subsubelementos:** quedan a decisión del agente colocarlos como checkmark (ejemplo: los 13 subelementos del D se muestran como panel; dentro de ellos, el agente puede abrir subsubelementos marcados).
5. **Registro:** al cierre de cada elemento, la checklist íntegra con evidencias se copia al worklog (trazabilidad).
6. **Ejecución de la norma:** la regla vive en triple redacción — este elemento E (norma), premisa_respuesta.md §2.4 y §5 (ejecución por respuesta) y la Regla Conductual Mínima del worklog (cabecera de plantilla y canónico).

---

## Elemento P — PLAN

- Fase **técnica del agente**: el plan responde a la spec.
- El Director NO valida el plan; en P **solo prioriza el orden** según su estrategia de trabajo.
- La **autorización de ejecución ocurre al entrar a I** (sin autorización, no se toca nada).
- Criterios técnicos permanentes del Director: buenas prácticas, OOP, prohibición de hardcoding, mocks/fallbacks solo cuando no exista posibilidad de datos reales explícitos o implícitos.

---

## Elemento I — IMPLEMENTACIÓN

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
- **Meta-proyecto (este):** entrega SIEMPRE COMPLETA de todos los archivos, modificados o no, en `.zip` en `/download/` con reemplazo total en la PC del Director. Incluye siempre `update_estrategia.ps1` y el worklog.

**I.3b — Baremo de doble entorno (sandbox Linux → Windows del Director):** cada archivo modificado se entrega con validación interna + evidencia de superación en el sandbox + sentencias para que el Director valide igual en su entorno Windows + superación de tests E2E del proyecto. Si no supera → vuelve al DCEPI.

**I.3c — Sentencias de GitHub (las ejecuta el Director):** con el repo local actualizado y probado, el agente entrega las sentencias para actualizar el repo único (1 repo/2 ramas):

```powershell
# Repo unico: rama main (completa) + rama operativo (compacta)
cd C:\Python\Proyectos\estrategia
git checkout main
git add -A
git commit -m "v1.2: <descripcion>"
git pull --rebase origin main
git push -u origin main
# Sincronizar la rama operativo (o simplemente ejecutar update_estrategia.ps1, que lo hace automatico)
```

`update_estrategia.ps1` v3.0 (exclusivo del meta-proyecto) automatiza la actualización completa en UNA pasada y SIN preguntas. El Director solo extrae el script del `.zip` y lo ejecuta. El script: localiza el `.zip` más reciente `estrategia*.zip` en la carpeta de descargas del Director (`-ZipPath` lo fuerza), verifica la integridad SHA256 de cada archivo contra `MANIFIESTO_ENTREGA.txt` (umbral cero: aborta sin tocar nada si algo no cuadra), BORRA TODO el contenido de la carpeta del repo local por defecto `C:\Python\Proyectos\estrategia` (`-RepoDir`; conserva solo `.git`) y descomprime el `.zip` de forma íntegra — al ser reemplazo total no hace falta purga de retirados: el borrado los cubre —, hace commit/push a `main`, sincroniza automáticamente la rama `operativo` y ejecuta el DIFF entre GitHub (tras actualizar) y la carpeta local modificada (verifica DIFF CERO y guarda el diff de la entrega en Downloads). Modos auxiliares: `-DryRun`, `-NoPush`.

**I.3d — Cierre del método (diff cero):** diff entre cada archivo intervenido (workspace del agente vs repositorio) = **CERO diferencias** → actualizar worklog + tareas inmediatas + aprendizajes. Aprendizajes **genéricos** → `agent-learn/` (accesibles a todos los agentes); **específicos** → DTI del proyecto; el worklog queda narrativo. El llenado de aprendizajes se hace **con autorización previa del Director** y criterio de utilidad en el momento preciso.

**Regla de cierre (orden del Director, v1.2):** la actualización de aprendizajes **forma parte de la implementación** y por tanto se produce **ANTES de la actualización de los repositorios**: el agente propone en I.3d y, con autorización, escribe las entradas en `agent-learn/` y regenera el `.zip` de entrega, de modo que ambos repositorios reciben los aprendizajes ya poblados con la propia entrega y el ciclo DCEPI queda completo. No se pospone a sesiones futuras fuera del método.

**I.3e — Re-clonado final (cierre por construcción, v1.3):** tras el push del Director (I.3c), el sandbox elimina su carpeta `estrategia/` y la re-clona fresca desde GitHub (git clone de main). El entorno del agente queda garantizado por construcción: lo que hay en disco == lo que hay en GitHub == lo que se entregó. Es el paso final obligatorio del ciclo; sin él, el clon local puede divergir del repo. Ejecutarlo solo cuando el Director confirme el push completado.

---

## Baremos (procedimiento)

| Baremo | Propietario | Momento | Registro | Aplicación |
|---|---|---|---|---|
| **Estratégico** | Director | C (estándar de respuesta para el error) | DTI del proyecto | Valida el resultado de I |
| **Táctico** | Agente | P (derivado del estratégico) | Junto al plan | Umbral cero del Crítico en I.2; umbrales de perímetro de líneas por intervención (deletions = 0 por defecto solo en intervenciones puramente aditivas) |

`dcepi.md` contiene solo el PROCEDIMIENTO; el contenido estratégico vive en el DTI del proyecto. Regla de ubicación: transversal → estrategia; específico → DTI/proyecto.

---

## Excepciones al DCEPI

- Preguntas informativas del Director (no requieren DCEPI)
- Investigación y análisis (no se modifica nada)
- Tareas de documentación solicitadas por el Director
- Decisiones de arquitectura menores (las toma el agente, según contrato.md)

## Cuando el DCEPI es obligatorio

- Corrección de bugs
- Nueva funcionalidad
- Refactoring
- Cambio de dependencias
- Eliminación de código

---

## Verificación previa (guardrail de máxima exposición)

Inmediatamente antes de escribir cualquier cambio de código, el agente **re-lee** `agent-context/contrato.md` para refrescar las reglas NH justo antes del momento más peligroso. No requiere respuesta al Director. Si alguna regla NH aplica a lo que va a hacer, la cumple.
