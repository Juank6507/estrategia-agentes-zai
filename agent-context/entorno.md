# ENTORNO DE TRABAJO

## Espacios

| Espacio | Ubicación | Plataforma |
|---|---|---|
| **Agente** (sandbox Z.ai) | `/home/z/my-project/` | Linux |
| **Estrategia (repo)** | `/home/z/my-project/estrategia/` | Clonado de GitHub al inicio de sesión |
| **Entrega** | `/home/z/my-project/download/` | — |
| **Director** | Su PC | Windows |

## Repositorio de estrategia

- **URL:** `https://github.com/Juank6507/estrategia-agentes-zai.git`
- **Ruta local:** `/home/z/my-project/estrategia/`
- **Clonado al inicio** de cada sesión (git clone o git pull).
- **Público** — el agente trabaja en un sandbox sin credenciales, no puede acceder a repositorios privados.
- Contiene los archivos `agent-context/`, `agent-learn/` y `worklog_template.md`.

## Tarea inicial: verificar el proxy LLM

El agente está dentro de un sandbox Z.ai que ya tiene un proyecto Next.js corriendo en el puerto 3000. Ese proyecto expone rutas en `/api/zai-proxy/` que actúan como proxy hacia el LLM de Z.ai. APA necesita este proxy para funcionar.

**Pasos:**

1. **Regenerar los archivos del proxy** (por si algo cambió en la sesión):
   ```
   bash /home/z/my-project/setup-proxy.sh
   ```
2. **Comprobar que el proxy responde:**
   ```
   curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/api/zai-proxy/v1/chat/completions
   ```
   - `405` → correcto (la ruta existe y rechaza GET).
   - `000` → el servidor no responde; informar al Director.
3. **Si falla**, diagnosticar con: `/home/z/my-project/estrategia/agent-context/proxy-llm-setup.md`

> **Nota:** Esta tarea es un prerrequisito. No proseguir hasta que el proxy esté operativo.

## Reglas de entrega

- Los archivos de entrega **siempre** van en `/home/z/my-project/download/`.
- Si no es posible, se explica al Director el motivo y la solución alternativa.
- Cada archivo entregable incluye en la primera línea un comentario con su ubicación y nombre de destino.
- Al entregar, incluir tabla que mapee cada archivo entregado a su ubicación en el proyecto.

## Compatibilidad cruzada

- El entorno del agente es **Linux**.
- El entorno del Director es **Windows**.
- Los cambios sensibles a la plataforma (gestión de archivos, rutas, encoding, subprocess) requieren advertencia explícita al entregar.
- Usar `os.path`, `pathlib`, `tempfile` para compatibilidad cruzada.
- No usar rutas ni comandos exclusivos de Linux sin advertir.
- Si algo no se puede probar en Linux, se indica para que el Director lo verifique en su entorno.

## Naturaleza del código del proyecto

El proyecto se compone de dos tipos de archivos:

**1. Scripts atómicos (standalone)**
- Independientes, autocontenidos.
- Siempre incluyen su propia validación de cada funcionalidad que tocan en su lógica.
- No dependen de otros scripts del proyecto.

**2. Scripts de dependencia**
- Importan varios scripts atómicos.
- Conforman funcionalidades completas.
- Se validan mediante tests independientes que se ejecutan desde la carpeta `tests/` del proyecto.

El agente debe identificar qué tipo de archivo está modificando y aplicar las reglas correspondientes.

## Consumo de contexto

- Copiar solo los ficheros necesarios según la tarea.
- No llenar la ventana de contexto con código que no se va a modificar.
- Los archivos de estrategia se leen al inicio de sesión y no necesitan releerse a menos que el protocolo DCPA lo indique o el Director lo pida.
