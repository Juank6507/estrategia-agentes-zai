# PROYECTO ACTUAL

## Nombre

APA

## Descripción

Proyecto compuesto por dos subproyectos que se desarrollan de forma coordinada:
- **apa** — aplicación principal
- **model_broker** — servicio de modelos

## Repositorios por agente

Cada agente trabaja con su propio repositorio independiente:

| Agente | Repositorio | Ruta local |
|---|---|---|
| **APA** | `https://github.com/Juank6507/APA_apa.git` | `/home/z/my-project/APA_apa/` |
| **MB** | `https://github.com/Juank6507/APA_model_broker.git` | `/home/z/my-project/APA_model_broker/` |

- **Rama:** `main` (ambos)
- El agente identifica su repositorio a partir del worklog adjunto en el prompt de inicio de sesión.

## Agentes

| Agente | Subproyecto | Repositorio |
---|---|---|
| **APA** | apa | https://github.com/Juank6507/APA_apa.git |
| **MB** | model_broker | https://github.com/Juank6507/APA_model_broker.git |

## Nota

Este archivo es el único que cambia al cambiar de proyecto. El Director actualiza la URL, rama y agentes según corresponda. Los demás archivos de `agent-context/` son genéricos y no se modifican.
