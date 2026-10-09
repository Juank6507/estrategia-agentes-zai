# Patrones Recurrentes — Z.ai

## Propósito
Documenta patrones que se repiten en el desarrollo de proyectos Z.ai. Reconocerlos permite actuar proactivamente.

---

## Patrones de Comportamiento

### P1 — Salto de fases DCEPI
**Síntoma**: El agente propone solución sin diagnóstico o especificación sin conciliación.  
**Causa**: Presión por entregar rápido o contexto insuficiente.  
**Prevención**: Checklist de fases antes de avanzar.  
**Detección**: Respuesta sin sentencia de control o sin fase declarada.

### P2 — Solapamiento de responsabilidades
**Síntoma**: Un agente hace trabajo de otro agente.  
**Causa**: Ambigüedad en roles o límites mal definidos.  
**Prevención**: Identidad clara por agente (ver `identidad.md`).  
**Detección**: Worklog muestra trabajo fuera de rol.

### P3 — Worklog incompleto
**Síntoma**: Pasos sin registrar, decisiones sin documentar.  
**Causa**: El agente no sigue I2 (worklog obligatorio).  
**Prevención**: Registro como paso explícito en cada fase.  
**Detección**: Gap temporal en worklog.

### P4 — Supuestos implícitos
**Síntoma**: El trabajo depende de algo que nunca se declaró.  
**Causa**: No se sigue R3 (explicitar supuestos).  
**Prevención**: Cada supuesto se marca `[SUPUESTO: ...]`.  
**Detección**: Error por supuesto incorrecto.

---

## Patrones Técnicos

### P5 — Actualización de estrategia por .zip
**Contexto**: El meta-proyecto es pequeño, las actualizaciones suelen ser completas.  
**Patrón**: Entregar .zip con todos los archivos → script automatizado reemplaza → push a GitHub.  
**Ventaja**: Simple, predecible, no requiere merge.

### P6 — Dos repos, una carpeta local
**Contexto**: Necesidad de repo público compacto + repo local completo.  
**Patrón**: Repo operativo (público, para agentes) + repo completo (local, con meta/). Misma carpeta en PC.  
**Ventaja**: Sin duplicación, agentes descargan solo lo necesario.

---

## Fuente
Este registro es parte del sistema de estrategia Z.ai v1.1.
