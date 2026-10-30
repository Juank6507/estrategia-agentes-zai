<!-- Ubicacion: estrategia/agent-context/entorno.md (v1.4)
     Descripcion integra del entorno de trabajo del agente: donde trabaja, con que guardrails,
     con que metodo y con que herramientas. Las normas completas viven en sus archivos sede;
     este archivo las describe y remite (un dato, un dueño). -->

# ENTORNO DE TRABAJO (v1.4)

## 1. Espacios

| Espacio | Ubicación | Plataforma |
|---|---|---|
| **Agente** | `/home/z/my-project/` | Linux (sandbox) |
| **Estrategia (repo local del agente)** | `/home/z/my-project/estrategia/` | Clonado al inicio de sesión |
| **Entrega** | `/home/z/my-project/download/` | — |
| **Aportes del Director** | `/home/z/my-project/upload/` | Solo entrada, nunca destino |
| **Director** | Su PC | Windows |

## 2. Repositorio de la estrategia (2 repos públicos, 1 repo local)

Un único contenido local en la PC del Director se publica en **dos repos públicos de GitHub** (URLs y reglas en `proyecto.md`, sección 2 — sede canónica):

- **Completo** (`estrategia-agentes-zai`): todo el contenido; lo clona el agente del meta-proyecto EP.
- **Operativo** (`estrategia-agentes-zai-operativo`): paquete de seis elementos (`agent-context/`, `agent-learn/`, `worklog_template.md`, `worklog_protocolo.md`, `prompt_arranque.md`, `premisa_respuesta.md`); lo clonan los agentes de proyecto.
- Sin credenciales de por medio: lo que un agente no debe ver no existe en su repo.
- El clon local se refresca al inicio de cada sesión (clone o pull) y al cierre del ciclo se re-clona fresco desde GitHub (dcepi.md I.3e).

## 3. Guardrails del agente (descripción)

El comportamiento del agente está cercado por cuatro piezas que se refuerzan entre sí (normas completas en sus archivos sede):

| Guardrail | Qué es | Dónde vive |
|---|---|---|
| **Premisa de respuesta** | Se ejecuta en TODA respuesta: frase de control `[FASE: X | Estrategia: activa]` + panel de checkmarks como primera línea, antes de cualquier otro contenido; recuperación espontánea si falla; tabla de mapeo por elemento. Su omisión detiene el proceso y/o invalida la respuesta | `premisa_respuesta.md` (raíz de la estrategia; triple redacción con contrato y prompt de arranque) |
| **Contrato de actuación** | Lo que siempre se hace y lo que nunca (códigos NH); clasificación por capas de verificación | `agent-context/contrato.md` |
| **Worklog conductual** | Regla Conductual Mínima en la cabecera de todo worklog: frase de control, premisa, recuperación, read-back y panel | `worklog_template.md` (plantilla) y cabecera de cada worklog |
| **Panel de checkmarks (R29)** | Cada punto del método se ejecuta como checklist visible: pregunta + `[x]`/`[?]`, en lenguaje natural; solo se reabre lo desconocido | dcepi.md (elemento E) + premisa §2.4 |

## 4. Método de trabajo (descripción del DCEPI)

El agente trabaja con el protocolo **DCEPI**: Diagnóstico → Conciliación → Especificación → Plan → Implementación. Todo cambio de código o documentación sigue sus cinco elementos, cada uno con sus subelementos y su forma de validación (descripción íntegra en `agent-context/dcepi.md`, sede canónica):

- **D (Diagnóstico):** recoge contexto (D.0) y responde los 13 factores; no toca nada.
- **C (Conciliación):** el Director concilia punto por punto y fija el baremo; nada se ejecuta sin consenso.
- **E (Especificación):** 13 factores + alcance por archivos + criterios verificables; la valida el Director.
- **P (Plan):** fases ordenadas que responden a la spec; el Director prioriza el orden.
- **I (Implementación):** intervenciones quirúrgicas con Gauntlet de verificación, veredicto JSON y entregas con verificación a umbral cero.

En la I, los aprendizajes se proponen al cerrar la conciliación de la E (antes del plan) y se implementan junto a todo lo demás (dcepi.md I.3d, regla v1.4).

## 5. Herramientas con que cuenta el agente

Inventario completo y modo de uso en `agent-context/herramientas.md` (sede canónica). Resumen:

- **Canal y persistencia:** chat con el Director (único canal), worklog (memoria narrativa), `upload/` (entrada) y `download/` (única ruta de entrega).
- **Sistema de archivos y terminal Linux:** lectura/escritura quirúrgica de archivos, bash para git, pruebas y verificaciones.
- **contexto_zai:** proceso de recuperación de contexto del entorno Z.ai (documentación, pipeline, utilidades y manuales en `contexto_zai/Documentos/`). Es **infraestructura del entorno, no del proyecto**: se consulta, no se modifica como activo propio y no recibe archivos de la estrategia. Es competencia del agente CZAI; si el proceso falla, se documenta el fallo y se escala al Director (dcepi.md I.2).
- **Capacidades de IA del backend** (si el proyecto las requiere): LLM, VLM, generación/edición de imágenes, TTS/ASR, búsqueda web, lectura de páginas, video.
- **Desarrollo web** (si el proyecto lo requiere): Next.js 16 + TypeScript, Prisma (SQLite), shadcn/ui + Tailwind 4, dev server en puerto 3000, gateway XTransformPort, mini-servicios.
- **Git y GitHub:** los push a GitHub los ejecuta el Director (I.3c) o su script; el agente no hace push del proyecto (NH5).

## 6. Flujo de actualización de la estrategia (Director en Windows)

1. El agente entrega en `download/` el `.zip` completo de la versión (p. ej. `estrategia_v1.4.zip`) y **una sentencia de PowerShell** que extrae el script del zip y lo ejecuta.
2. El Director descarga el zip y pega la sentencia en PowerShell (no extrae nada a mano).
3. El script (`update_estrategia.ps1`) hace el resto en una pasada, **preguntando con valores predeterminados** (Enter acepta):
   - Carpeta del zip (predeterminada: Descargas; toma el `estrategia_v#.#.zip` más reciente).
   - Carpeta del repo local (predeterminada `C:\Python\Proyectos\estrategia`): la borra y la reemplaza con el contenido íntegro del zip.
   - Repos GitHub a publicar (predeterminados: el completo y el operativo).
4. Antes de tocar nada, verifica la integridad SHA256 de cada archivo contra `MANIFIESTO_ENTREGA.txt` (umbral cero: si algo no cuadra, aborta sin cambios).
5. Publica los dos repos (completo: todo; operativo: los seis elementos) y genera el informe DIFF con acentos correctos en Descargas.

## 7. Reglas de entrega

- Todo lo entregable va en `/home/z/my-project/download/` (nunca en `upload/`; NH6).
- **Dos regímenes (dcepi.md I.3a):** meta-proyecto = SIEMPRE completo (todos los archivos); proyectos de aplicación = solo modificados, salvo tests E2E.
- Cada script entregado lleva en su primera línea un comentario con ubicación y nombre de destino (NH15).
- La entrega incluye la tabla que mapea cada archivo a su destino y la sentencia de PowerShell de actualización.

## 8. Compatibilidad cruzada

- El agente trabaja en Linux; el Director en Windows.
- Lo sensible a plataforma (rutas, encoding, comandos) se advierte al entregar (NH17).
- Si algo no puede probarse en el sandbox, se indica para que el Director lo valide en su entorno (baremo I.3b).

## 9. Naturaleza del código del proyecto

- **Scripts atómicos (standalone):** autocontenidos, con validación propia de cada funcionalidad que tocan.
- **Scripts de dependencia:** importan atómicos, conforman funcionalidades completas y se validan con tests en `tests/`.
- El agente identifica el tipo antes de tocar (regla del Director).

## 10. Consumo de contexto

- Copiar solo los ficheros necesarios según la tarea; no llenar la ventana con código que no se va a tocar.
- Los archivos de estrategia se leen al inicio (Protocolo de Arranque, 10 archivos con la premisa #1) y no se releen salvo que el método lo indique o el Director lo pida. **EXCEPCIÓN:** tras una pérdida de contexto, la re-lectura es OBLIGATORIA — Recuperación Espontánea de `premisa_respuesta.md` (§3) + sección "Recuperación de contexto" de `agent-context/herramientas.md`.
