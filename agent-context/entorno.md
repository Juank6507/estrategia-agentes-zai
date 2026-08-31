# ENTORNO DE TRABAJO

## Espacios

| Espacio | Ubicación | Plataforma |
|---|---|---|
| **Agente** | `/home/z/my-project/` | Linux |
| **Estrategia (repo)** | `/home/z/my-project/estrategia/` | Clonado de GitHub al inicio de sesión |
| **Entrega** | `/home/z/my-project/download/` | — |
| **Director** | Su PC | Windows |

## Repositorio de estrategia

- **URL:** `https://github.com/Juank6507/estrategia-agentes-zai.git`
- **Ruta local:** `/home/z/my-project/estrategia/`
- **Clonado al inicio** de cada sesión (git clone o git pull).
- **Público** — el agente trabaja en un sandbox sin credenciales, no puede acceder a repositorios privados.
- Contiene los archivos `agent-context/`, `agent-learn/` y `worklog_template.md`.

## Tarea inicial: configurar el proxy LLM

Al inicio de cada sesión, el agente **debe** ejecutar y comprobar la cadena proxy LLM. Esta es la base sobre la que opera APA.

**Pasos:**

1. **Ejecutar `setup-proxy.sh`** para regenerar los 9 archivos del proxy en el sandbox:
   ```
   bash /home/z/my-project/setup-proxy.sh
   ```
2. **Comprobar que existen** los 9 archivos proxy:
   - `src/app/api/zai-proxy/_lib.ts`
   - `src/app/api/zai-proxy/v1/chat/completions/route.ts`
   - `src/app/api/zai-proxy/v1/chat/completions/stream/route.ts`
   - `src/app/api/zai-proxy/v1/chat/vision/route.ts`
   - `src/app/api/zai-proxy/v1/audio/tts/route.ts`
   - `src/app/api/zai-proxy/v1/audio/asr/route.ts`
   - `src/app/api/zai-proxy/v1/images/generations/route.ts`
   - `src/app/api/zai-proxy/v1/async-result/route.ts`
   - `src/app/api/zai-proxy/v1/functions/invoke/route.ts`
3. **Ejecutar el test de comprobación** del proxy:
   ```
   curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/api/zai-proxy/v1/chat/completions
   ```
   - Si devuelve `405` (Method Not Allowed) → el proxy está levantado y responde.
   - Si devuelve `000` o timeout → el proxy no está operativo.
4. **Si el test falla**, leer la documentación de referencia para diagnosticar:
   - **Ruta:** `/home/z/my-project/estrategia/agent-context/proxy-llm-setup.md`
   - Revisar los puntos de fallo documentados (`.z-ai-config`, encoding, chatId, rutas estáticas, etc.).
   - Corregir y re-ejecutar el test.

> **Nota:** Esta tarea es un prerrequisito. No proseguir con otras tareas del Director hasta que el proxy esté operativo.

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
