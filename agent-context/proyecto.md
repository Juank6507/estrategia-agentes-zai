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
|---|---|---|
| **APA** | apa | https://github.com/Juank6507/APA_apa.git |
| **MB** | model_broker | https://github.com/Juank6507/APA_model_broker.git |

## Acceso de los agentes de proyecto al repo de estrategia (1 repo / 2 ramas)

- Los agentes de proyecto (APA, MB y futuros) acceden al repo de estrategia **solo por la rama `operativo`**: `git clone -b operativo https://github.com/Juank6507/estrategia-agentes-zai.git`
- La rama `operativo` contiene únicamente: `agent-context/`, `agent-learn/`, `worklog_template.md`, `worklog_protocolo.md` y `prompt_arranque.md`.
- Los agentes de proyecto **físicamente no pueden ver** `meta/`, `director-only/`, los PDFs de la metodología ni el worklog del meta-proyecto (no existen en su rama).
- El agente del meta-proyecto clona `main` (rama completa).
- La rama `operativo` se sincroniza automáticamente desde `main` por `update_estrategia.ps1` tras cada actualización.

## Nota

Este archivo es el único que cambia al cambiar de proyecto. El Director actualiza la URL, rama y agentes según corresponda. Los demás archivos de `agent-context/` son genéricos y no se modifican.
