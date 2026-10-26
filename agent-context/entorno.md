# ENTORNO DE TRABAJO

## Espacios

| Espacio | Ubicación | Plataforma |
|---|---|---|
| **Agente** | `/home/z/my-project/` | Linux |
| **Estrategia (repo)** | `/home/z/my-project/estrategia/` | Clonado de GitHub al inicio de sesión |
| **Entrega** | `/home/z/my-project/download/` | — |
| **Director** | Su PC | Windows |

## Repositorio de estrategia (1 repo / 2 ramas)

- **URL:** `https://github.com/Juank6507/estrategia-agentes-zai.git`
- **Ruta local (meta-proyecto):** `/home/z/my-project/estrategia/`
- **Clonado al inicio** de cada sesión (git clone o git pull).
- **Público** -- el agente trabaja en un sandbox sin credenciales, no puede acceder a repositorios privados.
- **Esquema de ramas (acceso diferenciado dentro de UN solo repo):**
  - **`main`** -- rama COMPLETA: todo (incluye `meta/`, PDFs de la metodología, worklog del meta-proyecto, `contexto_recuperacion/`...). La clona el agente del meta-proyecto.
  - **`operativo`** -- rama COMPACTA: solo `agent-context/`, `agent-learn/`, `worklog_template.md`, `worklog_protocolo.md` y `prompt_arranque.md`. Los agentes de proyecto clonan con `-b operativo` y físicamente no pueden ver `meta/`, `director-only/` ni carpetas internas (GitHub no tiene permisos por carpeta; esta es la única forma nativa de acceso diferenciado en un repo).
  - La sincronización de `operativo` desde `main` es automática: la ejecuta `update_estrategia.ps1` tras cada actualización.

## Flujo de actualizacion (Director en Windows) -- script v3.0

Cuando el agente entrega un `.zip` con la estrategia actualizada (entrega SIEMPRE completa, régimen meta-proyecto), el Director solo hace DOS acciones:
1. Descarga el `.zip` en `C:\Users\juanc\Downloads\` (p. ej. `estrategia_v1.2.zip`).
2. Extrae del `.zip` SOLO el archivo `update_estrategia.ps1` y lo ejecuta desde donde lo tenga (p. ej. Downloads, junto al .zip): `powershell -ExecutionPolicy Bypass -File .\update_estrategia.ps1`. Sin preguntas: acepta por defecto el `.zip` más reciente y el repo local estándar.

El script hace el resto en una sola pasada:
3. Localiza el `.zip` más reciente `estrategia*.zip` en `C:\Users\juanc\Downloads\` (genérico: `%USERPROFILE%\Downloads`; forzable con `-ZipPath`) y usa el repo local por defecto `C:\Python\Proyectos\estrategia` (parametrizable con `-RepoDir`).
4. Verifica la integridad SHA256 de cada archivo contra `MANIFIESTO_ENTREGA.txt` (umbral cero: si algo no cuadra, aborta sin tocar nada), BORRA TODO el contenido de la carpeta `estrategia` del repo local (conserva solo `.git`) y descomprime el `.zip` de forma ÍNTEGRA. Al ser reemplazo total NO hace falta purga de archivos retirados: el borrado los elimina todos.
5. Ejecuta las sentencias de actualización de GitHub (dcepi.md I.3c): commit + push a `main` y sincronización automática de la rama `operativo` (1 repo / 2 ramas).
6. Ejecuta el DIFF entre el repo de GitHub (tras actualizar) y la carpeta local modificada por la implementación: verifica DIFF CERO y guarda el diff de la entrega en `%USERPROFILE%\Downloads\DIFF_ENTREGA_estrategia_v<version>.txt`.
7. Modos auxiliares: `-DryRun` (simulación sin cambios), `-NoPush` (solo repo local).

## Recursos del entorno Z.ai

- `contexto_zai/` es INFRAESTRUCTURA DEL ENTORNO (documentación, pipeline, utilidades): se consulta, no se modifica como activo del proyecto y NO recibe archivos de la estrategia.
- `upload/` es punto de entrada de los aportes del Director, nunca destino.
- La documentación de la metodología (PDFs ACCL v1 y v2) vive en `estrategia/meta/`.

## Reglas de entrega

- Los archivos de entrega **siempre** van en `/home/z/my-project/download/`.
- **DOS regímenes (dcepi.md I.3a):** meta-proyecto = SIEMPRE completa (todos los archivos); proyectos de aplicación = solo modificados, salvo tests E2E.
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
- Los archivos de estrategia se leen al inicio de sesión (Protocolo de Arranque, 10 archivos con la premisa de respuesta como #1) y no necesitan releerse a menos que el protocolo DCEPI lo indique o el Director lo pida.
