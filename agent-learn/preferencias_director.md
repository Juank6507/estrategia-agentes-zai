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

---
### Método — Baremo con datos reales del chat antes de implementar
- **Observación:** El Director fijó el baremo de la v1.2 con datos reales del chat (S21) y exigió el mismo patrón en la v1.3 ("usando este chat con sus datos reales...", S46); invalidó la primera I de la v1.3 por ejecutarse sin él (S45)
- **Regla derivada:** Toda E cierra con su baremo conciliado (qué se verificará y con qué datos reales); sin baremo fijado en C no se entra en I, aunque exista orden de implementación

---
### Verificación — El Director revisa cada entrega con evidencia propia
- **Observación:** El Director verifica por sí mismo: pidió verificación externa del push en GitHub (v1.2), aplicó el baremo con los datos del chat (S46) y adjuntó el informe DIFF_ENTREGA generado por su script para que el agente lo revisara (S49)
- **Regla derivada:** Cada entrega incluye evidencia autoverificable (manifiesto SHA256, diff, veredictos JSON) y el agente conserva las verificaciones en disco; cualquier informe que el Director adjunte se revisa y se concilia antes de continuar

---
### Comunicación — El panel de checkmarks en su lenguaje
- **Observación:** El Director corrigió los paneles de la v1.3 (S50): los checkmarks con lenguaje técnico "dificultan el entendimiento de cada subelemento tocado durante el abordaje del método DCEPI"; lo reiteró al constatar que el aprendizaje I.3d no recogía la lección (S51)
- **Regla derivada:** Todo checkmark se redacta en sus términos (qué se hizo, qué falta, qué debe decidir); el detalle técnico queda en el worklog y se amplía solo a petición expresa

---
### Calidad — Cero errores conocidos en el meta-proyecto
- **Observación:** Ante el defecto de codificación del informe de actualización, detectado en S49 y repetido en la segunda pasada (S52), el Director ordenó: "No pueden haber errores por lo tanto se corrige y se vuelve a actualizar el repo" (S53); en la misma orden encargó corregir los worklogs del resto de los proyectos y entregarlos en un zip adicional si es necesario
- **Regla derivada:** Todo defecto conocido se corrige en la entrega siguiente a su autorización, antes de cualquier otro trabajo; los pendientes de decisión se re-presentan en cada panel hasta que el Director decide
