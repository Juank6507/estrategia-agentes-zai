# Prompt Templates -- Director

## Template: Protocolo de Arranque

Al inicio de cada sesion, el agente EP debe:

1. **LEER** los 9 archivos de estrategia (6 agent-context/ + 3 agent-learn/)
2. **DECLARAR** la frase de deteccion al inicio de su primera respuesta
3. **ACTUAR** segun lo aprendido (identificar lecciones, patrones y anti-patrones relevantes)

## Template: EP Entrega Cambios

Cuando el agente EP entrega cambios de estrategia:

1. Empaquetar todos los archivos modificados + `update_estrategia.ps1` en un `.zip`
2. Colocar el `.zip` en `/home/z/my-project/download/`
3. Informar al Director con tabla de archivos y ubicaciones
4. Instrucciones para el Director:
   - Extraer `update_estrategia.ps1` del .zip a la carpeta del proyecto
   - Ejecutar: `powershell -ExecutionPolicy Bypass -File .\update_estrategia.ps1`
   - El script auto-detecta el .zip; si no lo encuentra, pide la ruta

## Template: Informe de Sesion

Al finalizar la sesion:

1. Resumen de lo realizado
2. Archivos modificados (con ubicaciones)
3. Lecciones aprendidas (agregar a agent-learn/lecciones_aprendidas.md)
4. Patrones detectados (agregar a agent-learn/patrones_recurrentes.md)
5. Anti-patrones detectados (agregar a agent-learn/anti_patrones.md)
6. Pendientes (actualizar tareas_inmediatas.md)

## Instrucciones para el Director

- Para actualizar la estrategia: descargar el .zip, extraer `update_estrategia.ps1`, ejecutarlo
- Para revisar el spec: leer `meta/spec_estrategia_v1.1.md`
- Para revisar el plan: leer `meta/plan_estrategia_v1.1.md`
- Para revisar el historial: leer `meta/historial_versiones.md`
- Para personalizar el prompt de inicio: editar `meta/director-only/prompt_inicio_sesion.txt`
