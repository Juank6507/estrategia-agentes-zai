# PROTOCOLO DPCA

## Definición

**D**iagnóstico → **P**lan → **C**onsenso → **A**utorización → **V**erificación previa → **E**jecución

Todo trabajo que implique modificar código, corregir un bug o cambiar la arquitectura debe seguir este protocolo.

---

## Fase 1: DIAGNÓSTICO

- Identificar el problema o necesidad.
- Explicarlo al Director en lenguaje accesible.
- Incluir archivos afectados si aplica.

## Fase 2: PLAN

- Proponer plan de acción para resolver el problema.
- Especificar qué archivos se modifican y qué cambia en cada uno.
- Indicar el impacto esperado.

## Fase 3: CONSENSO

- Director, Asesor (si participa) y agente alcanzan acuerdo.
- Las decisiones de arquitectura relevantes se negocian aquí.
- Si el Director pide cambios al plan, se ajusta y se vuelve a presentar.

## Fase 4: AUTORIZACIÓN

- El Director da la orden explícita de ejecutar.
- **Sin autorización, no se toca nada.**

## Fase 4.5: VERIFICACIÓN PREVIA

- Inmediatamente antes de escribir cualquier cambio de código, el agente **re-lee** `/home/z/my-project/estrategia/agent-context/contrato.md`.
- Este re-lectura refresca las reglas NH y la checklist de integridad en el contexto del agente justo antes del momento más peligroso.
- No requiere respuesta ni confirmación al Director. Es una acción interna del agente.
- Si tras la re-lectura el agente detecta que alguna regla NH aplica a lo que va a hacer, la cumple.

## Fase 5: EJECUCIÓN

- Implementar los cambios de forma quirúrgica (solo lo que el Director pidió, nada más).
- Probar cada cambio.
- Iterar hasta que funcione.
- Entregar solo cuando todo está verificado.

---

## Excepciones al DCPA

- **Preguntas informativas** del Director (no requieren DCPA)
- **Investigación y análisis** (no se modifica nada)
- **Tareas de documentación** solicitadas por el Director
- **Decisiones de arquitectura menores** (el agente las toma directamente, según contrato.md)

## Cuando el DCPA es obligatorio

- Corrección de bugs
- Nueva funcionalidad
- Refactoring
- Cambio de dependencias
- Eliminación de código
- Modificación de flujo existente
- Cualquier cambio que afecte más de un archivo
