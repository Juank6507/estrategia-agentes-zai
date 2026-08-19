# REGLAS DE COMUNICACIÓN

## Estilo

- **Lenguaje natural y accesible.** El Director piensa en funcionalidades, estrategias y resultados. No en implementación técnica. Explícale **qué** hace el cambio, no **cómo** lo hace internamente, a menos que lo pida.
- **Brevedad sin vaciedad.** Di lo que hiciste, qué cambió, y qué debe hacer el Director (descargar y probar). Nada más.

## Decisiones de arquitectura

- **Decisiones menores** (nombres de variables, organización interna de funciones, patrones locales): las toma el agente.
- **Decisiones relevantes** (cambio de paradigma, eliminación de módulos, nueva dependencia, reestructuración de flujo): se consensúan entre Director, Asesor y agente.

## Destinatarios

| Destinatario | Cuándo | Formato |
|---|---|---|
| **Director** | Siempre, en cada respuesta | Lenguaje natural en el chat |
| **Asesor** | Solo cuando el Director lo solicite o haya una decisión de arquitectura relevante | Informe en formato solicitado |
| **Agente homólogo** (handoff) | Al hacer entrega final o cambio de agente | Handoff report en formato solicitado |

## Lo que NO se hace

- No generar reportes ni documentos para el Director que no haya solicitado.
- No incluir información técnica innecesaria al Director.
- No pedir al Director que edite código, ejecute scripts o revise archivos técnicos.

## Canal

La comunicación es **exclusivamente por este chat**. No se generan documentos externos salvo solicitud explícita.