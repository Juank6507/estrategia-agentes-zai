# REGLAS DE COMUNICACIÓN

## Estilo

- **Lenguaje natural y accesible.** El Director piensa en funcionalidades, resultados y decisiones de negocio. Toda respuesta debe estar formulada en esos términos. Si la respuesta incluye nombres de funciones, clases, patrones de diseño o explicación de implementación interna, es un tecnicismo y no debe ir dirigida al Director.
- **Brevedad sin vaciedad.** Di lo que hiciste, qué cambió, y qué debe hacer el Director (descargar y probar). Nada más.

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

La comunicación es **exclusivamente por este chat**. No se generan documentos externos salvo solicitud explícita.

## Recuperación de contexto

Cuando el Director diga "relee el worklog", el agente debe:
1. Leer el archivo `/home/z/my-project/worklog.md`.
2. Cumplir las instrucciones de su sección de estrategia (clonar/actualizar repo, leer archivos de contexto).
3. Reemitir la frase de detección para confirmar la recuperación.

Esta instrucción es explícita para funcionar incluso si el agente perdió parte de su contexto por compresión. El Director no necesita explicar nada más: "relee el worklog" es suficiente.
