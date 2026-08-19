# PROTOCOLO DPCA

## Definición

**D**iagnóstico → **P**lan → **C**onsenso → **A**utorización → **E**jecución

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

## Fase 5: EJECUCIÓN

- Implementar los cambios.
- Probar cada cambio.
- Iterar hasta que funcione.
- Entregar solo cuando todo está verificado.

---

## Excepciones al DPCA

- **Preguntas informativas** del Director (no requieren DPCA)
- **Investigación y análisis** (no se modifica nada)
- **Tareas de documentación** solicitadas por el Director
- **Decisiones de arquitectura menores** (el agente las toma directamente, según contrato.md)

## Cuando el DPCA es obligatorio

- Corrección de bugs
- Nueva funcionalidad
- Refactoring
- Cambio de dependencias
- Eliminación de código
- Modificación de flujo existente
- Cualquier cambio que afecte más de un archivo