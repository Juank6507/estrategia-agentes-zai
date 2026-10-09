# Tareas Inmediatas — Estrategia Z.ai v1.1

## Propósito
Lista de tareas pendientes posterior a la implementación de v1.1.

---

## Tareas Pendientes

### Prioridad Alta

1. **Actualizar repo operativo en GitHub**
   - Push de los archivos operatives (agent-context/, agent-learn/, worklog_template.md) al repo `estrategia-agentes-zai`
   - Usar `update_estrategia.ps1` con operación "zip" o "push"

2. **Verificar sentencia de control en agentes activos**
   - Confirmar que cada agente (APA, MB, CZAI) emite `[FASE: X | Estrategia: activa]` al inicio de sus respuestas
   - Si no lo hacen, indicarles que lean la estrategia actualizada del repo operativo

3. **Probar protocolo de recuperación**
   - Simular pérdida de contexto en un agente
   - Ejecutar los 6 pasos del protocolo
   - Verificar que la recuperación es exitosa

### Prioridad Media

4. **Regenerar libro de estrategia (PDF)**
   - Generar `libro_estrategia_agentes_zai.pdf` con el contenido actualizado de v1.1
   - Incluir sección de sentencia de control y protocolo de recuperación
   - Colocar en meta/director-only/

5. **Actualizar agentes de proyecto**
   - Indicar a cada agente que pulleen la última versión del repo operativo
   - Verificar que aplican la sentencia de control

6. **Documentar experiencia de recuperación**
   - Cuando se use el protocolo de recuperación por primera vez, documentar la experiencia en agent-learn/lecciones_aprendidas.md

### Prioridad Baja

7. **Explorar automatización de detección**
   - Evaluar si es posible detectar automáticamente la ausencia de sentencia de control
   - Script o herramienta que monitoree respuestas del agente

8. **Evaluar v1.2**
   - Recopilar feedback de v1.1 en producción
   - Identificar mejoras adicionales
   - Posibles candidatos: más granularidad en sentencia de control, métricas de cumplimiento

---

## Completadas v1.1

- [x] Implementar sentencia de control en contrato.md, dcepi.md, comunicacion.md, identidad.md
- [x] Implementar protocolo de recuperación en dcepi.md, comunicacion.md, contrato.md
- [x] Fortificar DIAGNÓSTICO-first en contrato.md
- [x] Actualizar proyecto.md con estructura de repos
- [x] Actualizar entorno.md con tabla de repos y flujo de actualización
- [x] Actualizar worklog_template.md con repo por agente y sentencia de control
- [x] Actualizar prompt_inicio_sesion.txt a v1.1
- [x] Actualizar prompt_templates.md con protocolo de recuperación
- [x] Crear informe_estrategia_v1.1.md
- [x] Crear update_estrategia.ps1 con 3 operaciones
- [x] Crear spec_estrategia_v1.1.md
- [x] Crear plan_estrategia_v1.1.md
- [x] Actualizar historial_versiones.md con entrada v1.1
- [x] Actualizar tareas_inmediatas.md

---

## Fuente
Este archivo es parte del sistema de estrategia Z.ai v1.1.
