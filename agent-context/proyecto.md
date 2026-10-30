<!-- Ubicacion: estrategia/agent-context/proyecto.md (v1.4)
     Unico archivo del paquete operativo que describe los proyectos y los repos de la estrategia.
     Sede canonica: identidad de arranque (paso 1), repos de la estrategia y repos de los proyectos. -->

# PROYECTO — Catálogo e identidad (v1.4)

## 1. Arranque por identidad (se ejecuta en este orden)

1. **Quién eres:** el worklog del proyecto te identifica (su cabecera y sus entradas llevan el nombre del agente y del proyecto; p. ej. `worklog_EP.md` → agente EP, meta-proyecto).
2. **Dónde encajas:** con esa identidad busca tu proyecto en el catálogo de la sección 3. **Si tu proyecto no figura en este archivo, avisa al Director** para que lo incorpore al catálogo; no improvises ni asumas otro proyecto.
3. **Qué clonas:** este archivo te dice qué repositorio de la estrategia te corresponde (sección 2) y qué repositorio de proyecto usa tu agente (sección 3). Clona o actualiza solo esos.

## 2. Repositorios de la estrategia (2 repos públicos, 1 repo local)

Un único contenido local (la carpeta del repo en la PC del Director) se publica en **dos repositorios públicos de GitHub**. No hay credenciales de por medio: la separación de contenido es la separación entre los dos repos.

| Repo | URL | Contenido | Quién lo clona |
|---|---|---|---|
| **Completo** | `https://github.com/Juank6507/estrategia-agentes-zai.git` | Todo: `agent-context/`, `agent-learn/`, worklogs, `meta/`, PDFs de la metodología, manifiesto y script | El agente del meta-proyecto **EP** |
| **Operativo** | `https://github.com/Juank6507/estrategia-agentes-zai-operativo.git` | Paquete operativo de seis elementos: `agent-context/`, `agent-learn/`, `worklog_template.md`, `worklog_protocolo.md`, `prompt_arranque.md` y `premisa_respuesta.md` (la premisa, primero) | Los agentes de proyecto (APA, MB, CZAI y futuros) |

- Ambos repos se publican desde el repo local del Director con `update_estrategia.ps1` en una sola pasada (ver `entorno.md`).
- Los agentes de proyecto **no** reciben `meta/`, PDFs de la metodología ni worklogs ajenos: sencillamente no existen en su repo operativo.
- Este agente EP trabaja el meta-proyecto desde el repo completo; su ruta local es `/home/z/my-project/estrategia/`.

## 3. Catálogo de proyectos que usan esta estrategia

| Proyecto | Qué es | Worklog del agente | Repo(s) del proyecto | Ruta local |
|---|---|---|---|---|
| **EP** | Meta-proyecto: esta misma estrategia (su desarrollo, versiones y entrega) | `worklog_EP.md` | Repo completo de la estrategia (sección 2) | `/home/z/my-project/estrategia/` |
| **APA** | Aplicación principal del proyecto APA | `worklog_apa.md` | `https://github.com/Juank6507/APA_apa.git` (rama `main`) | `/home/z/my-project/APA_apa/` |
| **MB** | Servicio de modelos del proyecto APA | `worklog_mb.md` | `https://github.com/Juank6507/APA_model_broker.git` (rama `main`) | `/home/z/my-project/APA_model_broker/` |
| **CZAI** | Proceso de recuperación de contexto (infraestructura del entorno) | `worklog_czai.md` | `https://github.com/Juank6507/contexto_zai.git` | `/home/z/my-project/contexto_zai/` |

Notas del catálogo:
- Cada agente trabaja **solo** con su proyecto y sus repos; los demás proyectos del catálogo existen para que el arranque por identidad funcione, no para tocarlos.
- CZAI es competencia del agente CZAI: el resto de agentes solo actúa sobre él cuando el proceso lo pida (manos fuera; ver `entorno.md`).

## 4. Regla de aviso

Si el worklog te identifica como agente de un proyecto que **no figura** arriba (o si el repo de tu proyecto no existe localmente y su URL no está en el catálogo), **detente y avisa al Director**: él actualiza este archivo. Ningún agente se auto-asigna un proyecto ni inventa URLs.

## 5. Mantenimiento

Este archivo es el punto único de verdad para identidad, catálogo y URLs. Cuando entre un proyecto nuevo o cambie una URL, se actualiza aquí y solo aquí; los demás archivos remiten a esta sección.
