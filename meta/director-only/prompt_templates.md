# Prompt Templates — Z.ai v1.1

## Propósito
Templates reutilizables para interacciones con agentes Z.ai.

---

## Template: Inicio de Sesión

```
Lee los archivos de estrategia del repo [OPERATIVO|COMPLETO]:
- agent-context/contrato.md
- agent-context/dcepi.md
- agent-context/comunicacion.md
- agent-context/identidad.md
- agent-context/proyecto.md
- agent-context/entorno.md

Internaliza invariantes, reglas, DCEPI, protocolos y sentencia de control.
Lee el worklog del proyecto.
Emite: [FASE: D | Estrategia: activa]
Comienza con DIAGNÓSTICO.
```

**Repo operativo** (APA, MB, CZAI): `https://github.com/Juank6507/estrategia-agentes-zai`
**Repo completo** (Estrategia): `C:\Python\Proyectos\estrategia`

---

## Template: Nueva Tarea

```
[FASE: D | Estrategia: activa]

Nueva tarea: [DESCRIPCIÓN]

DIAGNÓSTICO:
- Qué se pide: [ ]
- Contexto del proyecto: [ ]
- Estado actual: [ ]
- Comprensión declarada: [ ]
```

---

## Template: Reporte de Progreso

```
[FASE: X | Estrategia: activa]
STATUS — [Agente] → [Director]

Progreso: [resumen de avance]
Próximo paso: [qué sigue]
Blockers: [ninguno | descripción]
```

---

## Template: Solicitud de Decisión

```
[FASE: X | Estrategia: activa]
DECISION — [Agente] → [Director]

Decisión necesaria: [descripción]
Opciones:
  A) [opción A] — [trade-offs]
  B) [opción B] — [trade-offs]
Recomendación: [A|B] — [justificación]
```

---

## Template: Activación de Protocolo de Recuperación

```
[Director indica pérdida de contexto]

Ejecutando Protocolo de Recuperación de Estrategia:
1. ✓ Leído worklog
2. ✓ Leídos archivos de estrategia
3. ✓ Re-internalizados invariantes I1–I7
4. ✓ Re-internalizada sentencia de control
5. ✓ Confirmación: Protocolo de recuperación completado. Estrategia re-activada. Sentencia de control restaurada.
6. Continuando con sentencia de control...

[FASE: X | Estrategia: activa]
```

---

## Template: Cierre de Tarea

```
[FASE: I | Estrategia: activa]

Tarea completada: [descripción]
Artifacts producidos: [lista]
Validación del Director: [pendiente|aprobada]
Worklog actualizado: ✓
```

---

## Fuente
Estos templates son parte del sistema de estrategia Z.ai v1.1.
