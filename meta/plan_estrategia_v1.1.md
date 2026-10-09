# Plan Estrategia Z.ai v1.1

## Identificación
- **Versión**: 1.1
- **Basada en**: spec_estrategia_v1.1.md
- **Metodología**: DCEPI (este plan es resultado de las fases D, C, E)
- **Estado**: Listo para Implementación (fase I)

---

## Fases del Plan

### Fase 1: Sentencia de control + DIAGNÓSTICO-first (R1, R3)

| Paso | Archivo | Acción |
|------|---------|--------|
| 1.1 | contrato.md | Agregar sentencia de control a "Siempre, en toda interacción": `[FASE: X \| Estrategia: activa]` al inicio de cada respuesta |
| 1.2 | contrato.md | Agregar regla "DIAGNÓSTICO primero" como obligación explícita |
| 1.3 | contrato.md | Agregar referencia al protocolo de recuperación |
| 1.4 | dcepi.md | Fase 1 Paso 6: frase de detección incluye sentencia de control |
| 1.5 | dcepi.md | Agregar sección "Sentencia de Control" después de Fase 1 |
| 1.6 | identidad.md | Fases declarables: `[FASE: X]` → `[FASE: X \| Estrategia: activa]` |

### Fase 2: Protocolo de recuperación (R2)

| Paso | Archivo | Acción |
|------|---------|--------|
| 2.1 | dcepi.md | Agregar sección "Protocolo de Recuperación de Estrategia" con 6 pasos + fallback |
| 2.2 | comunicacion.md | Reemplazar "Recuperación de contexto" con protocolo completo (6 pasos con significado) |
| 2.3 | contrato.md | Agregar sección "Protocolo de recuperación de estrategia" con referencia a dcepi.md y comunicacion.md |

### Fase 3: Estructura de repos + worklog (R4)

| Paso | Archivo | Acción |
|------|---------|--------|
| 3.1 | proyecto.md | Agregar columna "Repo de estrategia": operativo/completo por agente |
| 3.2 | proyecto.md | Agregar sección "Repositorios de Estrategia" con descripción de ambos repos |
| 3.3 | proyecto.md | Agregar sección "Flujo de actualización" |
| 3.4 | entorno.md | Agregar tabla de 2 repos + descripción de estructura |
| 3.5 | entorno.md | Agregar sección "Flujo de Actualización por .zip" |
| 3.6 | worklog_template.md | Paso 1: especificar repo según agente (operativo vs completo) |
| 3.7 | worklog_template.md | Paso 7: emitir sentencia de control |

### Fase 4: Director-only + Script (R5, R6)

| Paso | Archivo | Acción |
|------|---------|--------|
| 4.1 | prompt_inicio_sesion.txt | Actualizar con 4 proyectos, repos específicos, sentencia de control |
| 4.2 | prompt_templates.md | Actualizar templates con repos y sentencia de control |
| 4.3 | informe_estrategia_v1.1.md | Crear con novedades v1.1, estructura, compatibilidad |
| 4.4 | update_estrategia.ps1 | Crear script interactivo con rutas predeterminadas y 3 operaciones |

### Fase 5: Spec, Plan, Historial, Tareas (R7)

| Paso | Archivo | Acción |
|------|---------|--------|
| 5.1 | spec_estrategia_v1.1.md | Crear con requisitos R1–R7, criterios de aceptación, restricciones |
| 5.2 | plan_estrategia_v1.1.md | Crear con fases 1–5, pasos 5.1–5.7, validación |
| 5.3 | historial_versiones.md | Crear/actualizar con entrada v1.1 |
| 5.4 | tareas_inmediatas.md | Crear/actualizar con tareas pendientes post-implementación |

---

## Validación

### Checklist post-implementación:
- [ ] contrato.md tiene sentencia de control en "Siempre, en toda interacción"
- [ ] contrato.md tiene DIAGNÓSTICO-first explícito
- [ ] contrato.md tiene referencia al protocolo de recuperación
- [ ] dcepi.md tiene sección "Sentencia de Control"
- [ ] dcepi.md tiene sección "Protocolo de Recuperación de Estrategia" con 6 pasos
- [ ] dcepi.md Fase 1 Paso 6 emite sentencia de control
- [ ] comunicacion.md tiene protocolo de recuperación con 6 pasos y significado
- [ ] identidad.md usa `[FASE: X | Estrategia: activa]`
- [ ] proyecto.md tiene columna "Repo de estrategia"
- [ ] entorno.md tiene tabla de repos y flujo de actualización
- [ ] worklog_template.md especifica repo por agente y sentencia de control en Paso 7
- [ ] prompt_inicio_sesion.txt actualizado a v1.1
- [ ] prompt_templates.md actualizado con protocolo de recuperación
- [ ] informe_estrategia_v1.1.md creado
- [ ] update_estrategia.ps1 creado con 3 operaciones y rutas predeterminadas
- [ ] spec_estrategia_v1.1.md creado
- [ ] plan_estrategia_v1.1.md creado
- [ ] historial_versiones.md tiene entrada v1.1
- [ ] tareas_inmediatas.md actualizado

---

## Entregables

1. **Archivo .zip** con todos los archivos de la estructura v1.1
2. **Instrucciones** para actualizar los repos de GitHub

---

## Fuente
Este plan es parte del sistema de estrategia Z.ai v1.1.
