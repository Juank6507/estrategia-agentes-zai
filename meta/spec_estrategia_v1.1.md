# Spec Estrategia Z.ai v1.1

## Version

- **Version:** 1.1
- **Fecha:** 2025-10-11
- **Estado:** Implementacion completa

## Requisitos (R1-R11)

### R1 -- Identidad del agente
El agente tiene identidad definida en `identidad.md`: nombre, rol, reporta a, objeto.

### R2 -- Contexto de actuacion
6 archivos en `agent-context/` definen como actua el agente: identidad, contrato, comunicacion, dcpa, entorno, proyecto.

### R3 -- Aprendizaje persistente
3+ archivos en `agent-learn/` acumulan experiencia entre sesiones: errores_comunes, preferencias_director, experiencias, lecciones_aprendidas, patrones_recurrentes, anti_patrones.

### R4 -- Worklog
`worklog_template.md` estructura el registro de sesiones y contiene el protocolo de arranque.

### R5 -- Repositorio operativo
Repo publico en GitHub (`estrategia-agentes-zai`) con los archivos de contexto y aprendizaje. El agente clona/pull al inicio de cada sesion.

### R6 -- 2-repo structure
- **operativo** (GitHub, publico): agent-context/, agent-learn/, worklog_template.md, prompt_arranque.md, tareas_inmediatas.md
- **completo** (local, con meta/): todo lo anterior + meta/ (spec, plan, historial, director-only/)

### R7 -- Compatibilidad cruzada
El entorno del agente es Linux, el del Director es Windows. Los cambios sensibles a plataforma requieren advertencia explicita.

### R8 -- Protocolo de Arranque (v1.1)
Obligatorio al inicio de cada sesion. Secuencia: LEER (9 archivos) -> DECLARAR -> ACTUAR.
Los 9 archivos obligatorios:
1. agent-context/identidad.md
2. agent-context/contrato.md
3. agent-context/comunicacion.md
4. agent-context/dcpa.md
5. agent-context/entorno.md
6. agent-context/proyecto.md
7. agent-learn/lecciones_aprendidas.md
8. agent-learn/patrones_recurrentes.md
9. agent-learn/anti_patrones.md

### R9 -- Agente EP (v1.1)
Reglas EP-1 a EP-6:
- EP-1: Solo accede al repo operativo (GitHub), no al completo
- EP-2: Puede leer meta/ del repo completo para contexto adicional
- EP-3: Persiste cambios en agent-learn/ via git add/commit/push
- EP-4: Distribuye cambios via .zip en /download/ (nunca /upload/)
- EP-5: Sincroniza con repo operativo al inicio y fin de sesion
- EP-6: Versiona cambios con mensajes descriptivos

### R10 -- REGLA ABSOLUTA DE ENTREGA (v1.1)
Toda entrega de cambios de estrategia se realiza EXCLUSIVAMENTE via `/download/`. Nunca se usa `/upload/` para recibir archivos de estrategia. El `.zip` de entrega incluye `update_estrategia.ps1` para que el Director actualice su repo local.

### R11 -- prompt_arranque.md (v1.1)
Unico punto de entrada y fallback para el arranque del agente. Contiene el Protocolo de Arranque simplificado. Si el worklog no esta disponible, el agente lee prompt_arranque.md.

## Brechas CZAI corregidas (B1-B6)

| Brecha | Descripcion | Correccion |
|---|---|---|
| B1 | Repo desactualizado entre sesiones | Clon/pull obligatorio al inicio de sesion |
| B2 | Entrega de archivos sin mecanismo estandar | /download/ exclusivo + update_estrategia.ps1 en .zip |
| B3 | Agente sin acceso a meta/ | EP-2: lectura permitida, escritura solo via EP-4 |
| B4 | Sin protocolo de arranque | R8: Protocolo de Arranque obligatorio (9 archivos) |
| B5 | Sin versionado de cambios | EP-6: mensajes descriptivos + historial_versiones.md |
| B6 | Sin registro de brechas | B1-B6 documentados y verificados |

## Criterios de aceptacion (21)

1. Los 6 archivos de agent-context/ existen y estan actualizados
2. Los 3+ archivos de agent-learn/ existen y estan actualizados
3. worklog_template.md existe y contiene el protocolo de arranque
4. prompt_arranque.md existe y es el punto de entrada
5. El repo operativo tiene todos los archivos requeridos
6. meta/ existe con spec, plan, historial, director-only/
7. El Protocolo de Arranque lista exactamente 9 archivos
8. EP-1 a EP-6 estan documentados en contrato.md
9. La REGLA ABSOLUTA DE ENTREGA esta en entorno.md
10. /download/ es la unica ruta de entrega
11. Nunca se usa /upload/ para archivos de estrategia
12. update_estrategia.ps1 esta en el .zip de entrega
13. El script usa solo caracteres ASCII (sin em-dash, sin smart quotes)
14. El script auto-detecta el .zip en Downloads/Escritorio
15. El script pide la ruta manualmente si no encuentra el .zip
16. El flujo documentado coincide con el procedimiento real
17. B1-B6 estan documentados y verificados
18. historial_versiones.md registra la entrada v1.1
19. El mensaje de commit es descriptivo
20. Todos los archivos tienen encoding UTF-8 sin BOM
21. El .zip se regenera con el script corregido
