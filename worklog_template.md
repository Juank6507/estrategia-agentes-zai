# WORKLOG

<!-- ╔══════════════════════════════════════════════════════════════╗ -->
<!-- ║  PLANTILLA DE WORKLOG (v1.4)                                 ║ -->
<!-- ║  AGENTE NUEVO O PROYECTO NUEVO SIN WORKLOG: este archivo ES  ║ -->
<!-- ║  tu worklog de sesión. Cópialo como worklog.md en el proyecto║ -->
<!-- ║  (NUNCA lo edites in situ) y rige por él desde el minuto 1.  ║ -->
<!-- ║  El protocolo completo vive en worklog_protocolo.md.         ║ -->
<!-- ╚══════════════════════════════════════════════════════════════╝ -->

## REGLA CONDUCTUAL MÍNIMA (se ejecuta en TODA respuesta)

1. **Frase de control:** la primera línea de toda respuesta es `[FASE: X | Estrategia: activa]` (X = elemento DCEPI vigente: D, C, E, P o I), seguida de su panel de checkmarks, antes de cualquier pensamiento o comentario. Su omisión detiene el proceso y/o invalida la respuesta. Si no puedes emitirla = pérdida de contexto → aplica la Recuperación (punto 3) sin pedir permiso.
2. **Premisa de respuesta:** la regla única de conducta vive en `premisa_respuesta.md`, en la RAÍZ de la estrategia (`premisa_respuesta.md`). Ante cualquier duda de cómo responder, léela.
3. **Recuperación de contexto:** si pierdes el hilo (sesión desconocida, worklog que no cuadra), ejecuta la Recuperación Espontánea de `premisa_respuesta.md` (§3) y la sección "Recuperación de contexto" de `agent-context/herramientas.md`. No requiere permiso.
4. **Verificación:** tras cada escritura en disco, read-back (número de líneas + marcador + cola). Nada se da por escrito sin evidencia.
5. **Panel de checkmarks (R29):** toda respuesta muestra, bajo la frase de control, el panel del elemento vigente: cada punto precedido de su pregunta, con `[x]` cumplido (con evidencia en disco) o `[?]` sin respuesta conocida (se pregunta al Director, nunca se suple). Sólo se reabre lo que no tiene respuesta conocida. Los subsubelementos se colocan como checkmark a criterio del agente. Al cierre de cada elemento, la checklist íntegra con evidencias se registra en el worklog. Cada checkmark se redacta en lenguaje natural comprensible para el Director, sin jerga técnica (R29, punto 7); el detalle técnico queda en el worklog como evidencia.

Al iniciar sesión, Z.ai te indicó que leyeras este archivo. Procede así:

1. **Identidad:** este worklog te identifica (agente y proyecto). Con esa identidad consulta `agent-context/proyecto.md`: si tu proyecto no figura en su catálogo, avisa al Director; si figura, él te dice qué repositorio de la estrategia clonar (completo = meta-proyecto EP; operativo = agentes de proyecto) y qué repos de proyecto usar. Si la carpeta de la estrategia no existe, clona TU repo; si existe, actualízala (git pull).
2. **Protocolo:** lee `worklog_protocolo.md` (fase de apertura: continuidad, número de sesión; fase de cierre: formato verbatim de la entrada).
3. **Arranque:** sigue el Protocolo de Arranque de `prompt_arranque.md` (10 archivos, premisa de respuesta #1).
4. **Protección de este archivo (NH20, dos capas):** la cabecera de estrategia (todo lo anterior a `--- ENTRADAS ---`) solo se actualiza por orden expresa del Director, sincronizada con esta plantilla en cada versión de la estrategia. Las entradas/historia (debajo de `--- ENTRADAS ---`) son intocables: añade tu entrada SOLO por debajo del marcador, con el formato de worklog_protocolo.md; nunca reescribir ni borrar entradas.
5. **Aprendizaje:** los aprendizajes se proponen tras conciliar la E y antes del plan, y se implementan junto a todo lo demás, viajando dentro de la entrega (sin push directo desde el sandbox, regla v1.4).

--- ENTRADAS ---

(Cada entrada de sesión usa el formato verbatim de worklog_protocolo.md:
### [YYYY-MM-DD] — Sesión N — [Agente]
- **Tarea:** lo que se pidió
- **Qué se hizo:** resumen ejecutivo
- **Archivos modificados:** lista
- **Pendiente:** lo que quedó abierto (si hay)

Al final de cada entrada, incluir siempre: `<!-- sesión: N -->`)
<!-- sesión: 0 -->
