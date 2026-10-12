# PROTOCOLO DCEPI

## Definicion

**D**iagnostico -> **C**onsenso -> **E**jecucion -> **P**lan -> **I**nspeccion

Todo trabajo que implique modificar codigo, corregir un bug o cambiar la arquitectura debe seguir este protocolo.

---

## Fase 1: DIAGNOSTICO

- Identificar el problema o necesidad.
- Explicarlo al Director en lenguaje accesible.
- Incluir archivos afectados si aplica.

## Fase 2: CONSENSO

- Director, Asesor (si participa) y agente alcanzan acuerdo.
- Las decisiones de arquitectura relevantes se negocian aqui.
- Si el Director pide cambios al plan, se ajusta y se vuelve a presentar.

## Fase 3: EJECUCION

- Implementar los cambios de forma quirurgica (solo lo que el Director pidio, nada mas).
- Probar cada cambio.
- Iterar hasta que funcione.
- Entregar solo cuando todo esta verificado.

## Fase 4: PLAN

- Proponer plan de accion para resolver el problema.
- Especificar que archivos se modifican y que cambia en cada uno.
- Indicar el impacto esperado.

## Fase 5: INSPECCION

- El Director da la orden explicita de ejecutar.
- **Sin autorizacion, no se toca nada.**
- Inmediatamente antes de escribir cualquier cambio de codigo, el agente **re-lee** `/home/z/my-project/estrategia/agent-context/contrato.md`.
- Este re-lectura refresca las reglas NH y la checklist de integridad en el contexto del agente justo antes del momento mas peligroso.
- No requiere respuesta ni confirmacion al Director. Es una accion interna del agente.
- Si tras la re-lectura el agente detecta que alguna regla NH aplica a lo que va a hacer, la cumple.

---

## Excepciones al DCEPI

- **Preguntas informativas** del Director (no requieren DCEPI)
- **Investigacion y analisis** (no se modifica nada)
- **Tareas de documentacion** solicitadas por el Director
- **Decisiones de arquitectura menores** (el agente las toma directamente, segun contrato.md)

## Cuando el DCEPI es obligatorio

- Correccion de bugs
- Nueva funcionalidad
- Refactoring
- Cambio de dependencias
- Eliminacion de codigo
- Modificacion de flujo existente
- Cualquier cambio que afecte mas de un archivo
