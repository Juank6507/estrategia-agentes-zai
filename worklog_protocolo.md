# PROTOCOLO DEL WORKLOG

<!-- Ubicacion: estrategia/worklog_protocolo.md
     Protocolo migrado desde worklog_template.md (v1.2). Aplica a todo worklog:
     worklog.md (agentes de proyecto) y worklog_EP.md (agente del meta-proyecto).
     v1.3: regla de agente/proyecto nuevo (Apertura 0), transferencia entre agentes
     y ruta de la premisa de respuesta (RAIZ de la estrategia: premisa_respuesta.md). -->

## Proposito

El worklog es la memoria narrativa del proyecto y la garantia de continuidad entre sesiones y agentes. Se lee al arrancar (continuidad) y se escribe al cerrar (trazabilidad).

## Fase 1 -- Apertura (al iniciar sesion)

0. Si NO existe worklog del proyecto (agente nuevo o proyecto nuevo): copiar `worklog_template.md` como worklog de la sesion (p. ej. `worklog.md` en el proyecto), NUNCA editar la plantilla in situ. La copia nace con la Regla Conductual Minima dentro (v1.3) y rige como guardrails desde el primer minuto. Continuar con los pasos siguientes sobre esa copia.
1. Leer el worklog completo (o, si es muy largo, la seccion de estrategia y las ultimas entradas).
2. Verificar continuidad: la ultima entrada registrada debe corresponder a la sesion anterior a la actual. Si el registro no cuadra con lo escrito en sesiones previas (por ejemplo, el archivo termina en una sesion mucho mas antigua), hay truncado o perdida -> aplicar la Proteccion (seccion siguiente).
3. Obtener el numero de sesion: ultima entrada + 1.

## Fase 2 -- Cierre (al terminar la sesion, antes de responder al Director que se termino)

Anadir UNA entrada nueva por debajo de la linea `--- ENTRADAS ---`, con este formato verbatim:

```markdown
### [YYYY-MM-DD] — Sesión N — [Agente]
- **Tarea:** lo que se pidió
- **Qué se hizo:** resumen ejecutivo de los pasos concretos
- **Archivos modificados:** lista
- **Pendiente:** lo que quedó abierto (si hay)
```

Y al final de la entrada, siempre, el marcador: `<!-- sesión: N -->`

## Reglas de integridad

- La seccion de estrategia (todo lo anterior a `--- ENTRADAS ---`) es inalterable (NH20).
- Para añadir entradas usar SOLO ediciones que inserten contenido nuevo por debajo de `--- ENTRADAS ---` (append). Nunca reescribir el archivo completo.
- Nunca borrar ni mover entradas previas.
- La entrada se escribe al CERRAR la sesion, no antes (el contenido debe reflejar lo realmente hecho).

## Transferencia entre agentes (v1.3)

- El worklog vive en el proyecto y sobrevive al cambio de agente: es la memoria narrativa compartida, el unico punto de continuidad garantizado.
- El agente saliente cierra su sesion (Fase 2) antes de dar por terminado su turno: entrada + marcador + read-back verificado.
- El agente entrante aplica la Fase de Apertura sobre el MISMO worklog: lee, verifica continuidad (la ultima entrada debe ser la de la sesion anterior a la suya) y continua la numeracion (ultima + 1). Nunca renumerar sesiones.
- En las entregas (I.3a) el worklog viaja SIEMPRE incluido (regimen meta-proyecto: entrega completa).
- Si al tomar posesion la continuidad no cuadra: aplicar la Proteccion (seccion siguiente), no continuar como si nada. La verificacion de continuidad se apoya en la premisa de respuesta, que vive en la RAIZ de la estrategia: `premisa_respuesta.md`.

## Proteccion contra truncados y perdidas

1. **Copia de respaldo local:** mantener una copia sincronizada (p. ej. `worklog_EP.backup.md`) tras cada escritura. Leccion registrada: las copias locales NO son proteccion duradera (el sandbox se limpia externamente); son primera linea de defensa, no la ultima.
2. **Proteccion duradera:** el repo GitHub (I.3c, ejecutado por el Director) y la entrega completa del meta-proyecto (I.3a), que SIEMPRE incluye el worklog y su backup.
3. **Restauracion:** ante truncado, restaurar verbatim las entradas perdidas desde el contexto de la sesion; las no recuperables se documentan en una entrada de restauracion con referencias cruzadas. Nunca renumerar sesiones.
4. **Deteccion:** el disparador es la verificacion de continuidad de la premisa de respuesta (`premisa_respuesta.md`, en la RAIZ de la estrategia; ultima entrada vs sesion actual).
