# REGLAS DE COMUNICACIÓN

## Estilo

- **Lenguaje natural y accesible.** El Director piensa en funcionalidades, resultados y decisiones de negocio. Toda respuesta debe estar formulada en esos términos. Si la respuesta incluye nombres de funciones, clases, patrones de diseño o explicación de implementación interna, es un tecnicismo y no debe ir dirigida al Director.
- **Brevedad sin vaciedad.** Di lo que hiciste, qué cambió, y qué debe hacer el Director (descargar y probar). Nada más.
- **Frase de control.** La primera línea de TODA respuesta es `[FASE: X | Estrategia: activa]` (X = elemento DCEPI vigente). Se ejecuta la premisa completa de `premisa_respuesta.md`. Sin frase = fallo visible para el Director.

## Decisiones de arquitectura

- **Decisiones menores** (nombres de variables, organización interna de funciones, patrones locales): las toma el agente.
- **Decisiones relevantes** (cambio de paradigma, eliminación de módulos, nueva dependencia, reestructuración de flujo): se consensúan entre Director, Asesor y agente.

## Destinatarios

| Destinatario | Cuándo | Formato |
|---|---|---|
| **Director** | Siempre, en cada respuesta | Lenguaje natural en el chat |
| **Asesor** | Solo cuando el Director lo solicite o haya una decisión de arquitectura relevante | Informe en formato solicitado |
| **Agente homólogo** (handoff) | Al hacer entrega final o cambio de agente | Worklog: las últimas entradas de sesión sirven como handoff implícito |

## Lo que NO se hace

- No generar reportes ni documentos para el Director que no haya solicitado.
- No incluir información técnica innecesaria al Director.
- No pedir al Director que edite código, ejecute scripts o revise archivos técnicos.

## Canal

La comunicacion es **exclusivamente por este chat**. No se generan documentos externos salvo solicitud explicita.

## Protocolo de actualizacion (P5) -- v1.2

Cuando el agente entrega una actualizacion de estrategia como `.zip` (regimen meta-proyecto: SIEMPRE completo):
1. El Director descarga el `.zip` a su PC
2. Extrae `update_estrategia.ps1` del `.zip` a la carpeta del proyecto (`C:\Python\Proyectos\estrategia\`)
3. Ejecuta: `powershell -ExecutionPolicy Bypass -File .\update_estrategia.ps1`
4. El script auto-detecta el `.zip` en Downloads/Escritorio; si no lo encuentra, pide la ruta
5. El script copia TODOS los archivos (reemplazo total), hace push a la rama `main` y sincroniza automaticamente la rama `operativo` (poda de rutas internas). Toda la complejidad vive dentro del script

Para proyectos de aplicacion (regimen general): solo archivos modificados salvo tests E2E. Ver dcepi.md I.3a.

## Recuperación de contexto

Cuando el agente no pueda emitir la frase de control, o el contexto aparezca roto (worklog que no cuadra, sesión desconocida), ejecuta el protocolo de recuperación espontánea de `premisa_respuesta.md`: emite `[ESTADO: RECUPERACION]`, lee la premisa, verifica continuidad del worklog, lee tareas y reemite la frase. No pide permiso para recuperar el contexto (única excepción de NH8); no toca archivos del proyecto.

Cuando el Director diga "relee el worklog", el agente debe:
1. Leer el archivo worklog que corresponda (`worklog.md` para agentes de proyecto; `worklog_EP.md` para el agente del meta-proyecto).
2. Cumplir las instrucciones de su sección de estrategia (clonar/actualizar repo, leer archivos de contexto).
3. Reemitir la frase de control para confirmar la recuperación.

Esta instrucción es explícita para funcionar incluso si el agente perdió parte de su contexto por compresión. El Director no necesita explicar nada más: "relee el worklog" es suficiente.
