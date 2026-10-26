# PREFERENCIAS DEL DIRECTOR

<!-- Criterio de inclusión: solo patrones observados en al menos 2 sesiones distintas. No preferencias de una sola vez. -->

---
### [Categoría] — [Preferencia]
- **Observación:** [Qué dijo o hizo el Director que indica esta preferencia]
- **Regla derivada:** [Cómo adaptar el comportamiento del agente]

<!-- Ejemplo:
---
### Comunicación — Explicar qué, no cómo
- **Observación:** El Director pidió "dime qué cambiaste" no "dime cómo lo implementaste"
- **Regla derivada:** En las entregas, describir el efecto visible del cambio, no la implementación interna
-->

---
### Comunicación — No ligar metodología con herramientas específicas
- **Observación:** El Director corrigió que la explicación de recuperación de contexto no debía ligarse con Claude Code ni con la app web específica
- **Regla derivada:** Las explicaciones metodológicas deben ser genéricas y aplicables a cualquier entorno Z.ai. No hacer contraste con otras herramientas a menos que el Director lo pida explícitamente.

---
### Automatización — Sin preguntas, mínimas acciones
- **Observación:** El Director corrigió el script v2.0 definiendo los 4 pasos exactos (buscar el zip más reciente en Downloads, descomprimir íntegro, sentencias GitHub, diff) y redujo su papel a 2 acciones: extraer del zip el update_estrategia.ps1 y ejecutarlo
- **Regla derivada:** Toda automatización para el Director se diseña por defecto sin interacción y con el mínimo de acciones humanas; su orden literal define el flujo exacto

---
### Método — Los aprendizajes se cierran dentro de la implementación
- **Observación:** El Director ordenó en I.3d que la actualización de los ficheros de aprendizaje debe producirse dentro de la implementación y por tanto antes de la actualización de los repositorios
- **Regla derivada:** Al cerrar una I, proponer y (autorizados) escribir los aprendizajes ANTES de regenerar el .zip de entrega; el zip lleva agent-learn ya poblado y los repos reciben los aprendizajes con la propia entrega
