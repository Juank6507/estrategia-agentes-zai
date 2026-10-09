# Antipatrones — Z.ai

## Propósito
Documenta antipatrones (errores recurrentes que deben evitarse). Cada entrada describe qué NO hacer y por qué.

---

## Antipatrones de Proceso

### AP1 — Solucionar sin diagnosticar
**Descripción**: Proponer o implementar solución sin Fase D de DCEPI.  
**Consecuencia**: Resolver el problema equivocado. Rework garantizado.  
**Alternativa**: SIEMPRE Diagnosticar primero (R1).  
**Detección**: Propuesta de solución sin sentencia `[FASE: D | Estrategia: activa]` previa.

### AP2 — Asumir consenso
**Descripción**: Avanzar sin confirmación explícita del Director.  
**Consecuencia**: Trabajar en dirección no validada.  
**Alternativa**: Conciliación explícita con declaración de consenso.  
**Detección**: Fase C saltada o sin "Conciliación alcanzada".

### AP3 — Improvisar formato
**Descripción**: Usar formato ad-hoc en lugar de los protocolos definidos.  
**Consecuencia**: Comunicación inconsistente, pérdida de información.  
**Alternativa**: Seguir `comunicacion.md`.  
**Detección**: Mensajes sin estructura estándar.

### AP4 — Silenciar errores
**Descripción**: No reportar errores o blockers.  
**Consecuencia**: Problemas se acumulan y explotan después.  
**Alternativa**: Fail-fast (R10), BLOCKER inmediato al Director.  
**Detección**: Worklog sin mención de error cuando debería haberla.

### AP5 — Contexto implícito
**Descripción**: Asumir que el Director o otro agente "sabe" algo sin explicitarlo.  
**Consecuencia**: Malentendidos, trabajo en direcciones opuestas.  
**Alternativa**: I5 — Contexto explícito siempre.  
**Detección**: Decisiones basadas en información no declarada.

---

## Antipatrones de Estrategia

### AP6 — Ignorar sentencia de control
**Descripción**: No emitir `[FASE: X | Estrategia: activa]` al inicio de respuestas.  
**Consecuencia**: El Director no puede detectar pérdida de contexto. El agente opera sin estrategia sin que nadie lo note.  
**Alternativa**: Emitir sentencia de control en CADA respuesta.  
**Detección**: Ausencia de la sentencia en cualquier respuesta del agente.

### AP7 — Phrase mágica para recuperación
**Descripción**: Requerir que el Director use una frase exacta para activar el protocolo de recuperación.  
**Consecuencia**: El Director puede no recordar la frase exacta, o el agente puede no reconocerla si perdió contexto.  
**Alternativa**: Cualquier indicación del Director activa el protocolo.  
**Detección**: Protocolo que depende de string matching exacto.

### AP8 — Duplicar archivos entre repos
**Descripción**: Mantener copias independientes del mismo archivo en repo operativo y completo.  
**Consecuencia**: Divergencia — se actualiza un lado y no el otro.  
**Alternativa**: Una sola carpeta local, repo operativo como subconjunto.  
**Detección**: Diferencias entre archivos con el mismo nombre en diferentes ubicaciones.

---

## Fuente
Este registro es parte del sistema de estrategia Z.ai v1.1.
