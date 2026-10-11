# Historial de Versiones -- Estrategia Z.ai

## v1.1 (2025-10-11)

### Novedades
1. **R8: Protocolo de Arranque** -- LEER (9 archivos) -> DECLARAR -> ACTUAR obligatorio al inicio
2. **R9: Agente EP** -- Reglas EP-1 a EP-6 para acceso, persistencia y distribucion
3. **R10: REGLA ABSOLUTA DE ENTREGA** -- /download/ exclusivo, nunca /upload/
4. **R11: prompt_arranque.md** -- Punto de entrada unico y fallback
5. **B1-B6: Brechas CZAI corregidas** -- 6 problemas operativos identificados y corregidos
6. **update_estrategia.ps1 mejorado** -- ASCII-only, auto-deteccion de .zip, 3 modos de operacion
7. **lecciones_aprendidas.md** -- Nuevo archivo de lecciones
8. **patrones_recurrentes.md** -- Nuevo archivo de patrones
9. **anti_patrones.md** -- Nuevo archivo de anti-patrones

### Archivos modificados
- agent-context/contrato.md (agregado EP-1 a EP-6, referencia script)
- agent-context/entorno.md (agregado flujo de actualizacion, prompt_arranque.md)
- agent-context/comunicacion.md (agregado P5 protocolo de actualizacion)
- agent-context/identidad.md (actualizado PERSISTIR)
- agent-context/proyecto.md (actualizado flujo EP sandbox)
- agent-context/dcpa.md (sin cambios funcionales)
- worklog_template.md (actualizado protocolo de arranque)
- tareas_inmediatas.md (actualizado estado de completitud)

### Archivos nuevos
- meta/spec_estrategia_v1.1.md
- meta/plan_estrategia_v1.1.md
- meta/historial_versiones.md
- meta/tareas_inmediatas.md
- meta/director-only/informe_estrategia_v1.1.md
- meta/director-only/prompt_inicio_sesion.txt
- meta/director-only/prompt_templates.md
- agent-learn/lecciones_aprendidas.md
- agent-learn/patrones_recurrentes.md
- agent-learn/anti_patrones.md
- prompt_arranque.md
- update_estrategia.ps1

### Brechas corregidas
| Brecha | Correccion |
|---|---|
| B1 | Clon/pull obligatorio al inicio de sesion |
| B2 | /download/ exclusivo + update_estrategia.ps1 en .zip |
| B3 | EP-2: lectura de meta/ permitida |
| B4 | R8: Protocolo de Arranque obligatorio |
| B5 | EP-6: versionado con mensajes descriptivos |
| B6 | B1-B6 documentados y verificados |

---

## v1.0 (2025-07-10)

### Novedades
1. R1: Identidad del agente
2. R2: Contexto de actuacion (6 archivos)
3. R3: Aprendizaje persistente (3 archivos)
4. R4: Worklog estructurado
5. R5: Repositorio operativo en GitHub
6. R6: 2-repo structure (operativo + completo)
7. R7: Compatibilidad cruzada

### Archivos iniciales
- agent-context/identidad.md
- agent-context/contrato.md
- agent-context/comunicacion.md
- agent-context/dcpa.md
- agent-context/entorno.md
- agent-context/proyecto.md
- agent-learn/errores_comunes.md
- agent-learn/preferencias_director.md
- agent-learn/experiencias.md
- worklog_template.md
- tareas_inmediatas.md
