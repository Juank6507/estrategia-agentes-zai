# ENTORNO DE TRABAJO

## Espacios

| Espacio | Ubicación | Plataforma |
|---|---|---|
| **Agente** | `/home/z/my-project/` | Linux |
| **Estrategia (repo)** | `/home/z/my-project/estrategia/` | Clonado de GitHub al inicio de sesión |
| **Proyecto (repo)** | `/home/z/my-project/APA_repo/` | Clonado del repositorio del proyecto |
| **Entrega** | `/home/z/my-project/download/` | — |
| **Director** | Su PC | Windows |

## Repositorio de estrategia

- **URL:** `https://github.com/Juank6507/estrategia-agentes-zai.git`
- **Ruta local:** `/home/z/my-project/estrategia/`
- **Clonado al inicio** de cada sesión (git clone o git pull)
- Contiene los archivos `.agent-context/` y `.agent-learn/`

## Repositorio del proyecto

- **URL:** `https://github.com/Juank6507/APA.git`
- **Rama principal:** `main`
- **Clonado en:** `/home/z/my-project/APA_repo/` (o la ruta que indique el Director)
- Actualizar con `git pull` antes de trabajar si es necesario
- **El Director actualiza esta URL y rama al cambiar de proyecto**

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

## Consumo de contexto

- Copiar solo los ficheros necesarios según la tarea.
- No llenar la ventana de contexto con código que no se va a modificar.
- Los archivos de estrategia se leen al inicio de sesión y no necesitan releerse a menos que se pierda contexto.