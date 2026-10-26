# Historial de Versiones -- Estrategia Z.ai

## v1.2 (2026-10-24)

### Novedades
1. **R12: DCEPI refinado** -- 5 elementos (Diagnostico -> Conciliacion -> Especificacion -> Plan -> Implementacion) con subelementos conciliados; barrido de la descomposicion antigua, DCPA y la taxonomia de 18 aspectos
2. **R13: Premisa de respuesta** -- premisa_respuesta.md nuevo, #1 del arranque (10 archivos); frase de control, recuperacion espontanea, triple redaccion, verificabilidad externa, limite honesto, tabla de mapeo por elemento
3. **R14: Baremos** -- estrategico (Director, en C, registrado en el DTI del proyecto) y tactico (agente, en P, aplicado en I.2); dcepi.md solo procedimiento
4. **R15: I.1 Precondiciones** -- snapshot de regresion, repo montado, tabla de alcance, grafos/algoritmo protegidos
5. **R16: I.2 ACCL v2** -- Orquestador/Actor/Critico, 7 fases, Gauntlet de 6 pasos en orden obligatorio, veredicto JSON, 3 capas, MAX_ITER=5
6. **R17: I.3 Entregas en 4 subfases** -- I.3a DOS regimenes (proyectos: solo modificados salvo E2E; meta-proyecto: siempre completa), I.3b doble entorno, I.3c sentencias GitHub, I.3d diff cero
7. **R18: 1 repo/2 ramas** -- main completa + operativo compacta; sustituye a la estructura 2-repos de R6; update_estrategia.ps1 sincroniza la rama operativo automaticamente
8. **R19: agent-learn 6 -> 4** -- errores_comunes fundido en anti_patrones; experiencias fundido en lecciones_aprendidas
9. **R20: Worklog** -- protocolo migrado a worklog_protocolo.md; proteccion ante truncados externos
10. **R21: Documentacion** -- PDFs ACCL v1 y v2 en estrategia/meta/; contexto_zai/ fuera del alcance del proyecto
11. **Conciencia instrumental** -- herramientas.md nuevo (inventario de herramientas del agente)

### Archivos nuevos
- meta/spec_estrategia_v1.2.md
- meta/plan_estrategia_v1.2.md
- agent-context/premisa_respuesta.md
- agent-context/herramientas.md
- worklog_protocolo.md
- meta/Metodologia Agentica.pdf (v1)
- meta/Metodologia Mejorada_ Agentic CI_CD Loop v2.pdf (v2)

### Archivos modificados
- agent-context/dcepi.md (reescrito: R12-R17)
- agent-context/contrato.md (premisa, excepcion NH8, NH -> capa, barrido de notacion)
- agent-context/comunicacion.md (frase de control, estandar de respuesta)
- agent-context/entorno.md (esquema de ramas, premisa en arranque)
- agent-context/proyecto.md (1 repo/2 ramas, accesos diferenciados)
- prompt_arranque.md (arranque 10 archivos, esquema de ramas)
- worklog_template.md (solo plantilla)
- agent-learn/anti_patrones.md (consolidacion)
- agent-learn/lecciones_aprendidas.md (consolidacion)
- agent-learn/patrones_recurrentes.md (barrido)
- update_estrategia.ps1 (1 repo/2 ramas, cabecera de ambito)
- tareas_inmediatas.md (unificado)
- meta/historial_versiones.md (esta entrada)

### Archivos eliminados
- agent-context/dcpa.md
- agent-learn/errores_comunes.md (fundido en anti_patrones.md)
- agent-learn/experiencias.md (fundido en lecciones_aprendidas.md)
- tareas_inmediatas.md (copia duplicada, se unifica en una sola)

---

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
- agent-context/dcepi.md (renombrado de dcpa.md, metodologia DCEPI)
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
- agent-context/dcepi.md
- agent-context/entorno.md
- agent-context/proyecto.md
- agent-learn/errores_comunes.md
- agent-learn/preferencias_director.md
- agent-learn/experiencias.md
- worklog_template.md
- tareas_inmediatas.md
