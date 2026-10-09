# Lecciones Aprendidas — Z.ai

## Propósito
Registro de lecciones aprendidas durante el desarrollo de proyectos Z.ai. Cada entrada es una observación verificable extraída de experiencia real.

---

## Formato de entrada

```
### [FECHA] — [TÍTULO]
**Contexto**: [proyecto/situación]
**Lección**: [qué se aprendió]
**Aplicación**: [cómo se aplica en el futuro]
```

---

## Lecciones

### [2024] — Pérdida silenciosa de contexto
**Contexto**: Agentes Z.ai en sesiones largas
**Lección**: La compresión de contexto es silenciosa — el agente no avisa que perdió contexto, simplemente deja de seguir la estrategia.
**Aplicación**: Se implementó la sentencia de control `[FASE: X | Estrategia: activa]` como mecanismo de detección. Si desaparece, el Director activa el protocolo de recuperación.

### [2024] — Diagnóstico antes de solución
**Contexto**: Múltiples proyectos
**Lección**: Saltar el diagnóstico lleva a resolver el problema equivocado. El 80% del valor está en entender el problema real.
**Aplicación**: Regla R1 fortificada como primer paso obligatorio de toda interacción.

### [2024] — Duplicación de archivos genera inconsistencia
**Contexto**: Estructura de repos de estrategia
**Lección**: Mantener la misma información en dos lugares genera divergencia. Los archivos se actualizan en un lugar y no en el otro.
**Aplicación**: Una sola carpeta local, repo operativo como subconjunto del completo, sin duplicación.

### [2024] — Especificaciones ambiguas producen rework
**Contexto**: Procesos de desarrollo
**Lección**: Sin especificación clara, cada iteración redefine el objetivo. El tiempo ahorrado en E se paga multiplicado en I.
**Aplicación**: Fase E de DCEPI es obligatoria y requiere validación del Director.

---

## Fuente
Este registro es parte del sistema de estrategia Z.ai v1.1.
