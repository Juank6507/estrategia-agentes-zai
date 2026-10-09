# Informe de Estrategia Z.ai — v1.1

## Resumen Ejecutivo

La versión 1.1 del sistema de estrategia Z.ai introduce tres mejoras fundamentales sobre v1.0:

1. **Sentencia de control** — Mecanismo de detección de pérdida silenciosa de contexto
2. **Protocolo de recuperación de estrategia** — Procedimiento de 6 pasos para restaurar cumplimiento
3. **Estructura de repos dual** — Repo operativo (público, compacto) + repo completo (local, con meta/)

---

## Novedades v1.1

### 1. Sentencia de Control

**Formato**: `[FASE: X | Estrategia: activa]`

**Problema resuelto**: En v1.0, cuando un agente perdía contexto por compresión, lo hacía silenciosamente. Ni el agente ni el Director se enteraban hasta que el comportamiento divergía significativamente.

**Solución**: La sentencia de control es un marcador obligatorio al inicio de cada respuesta del agente. Su presencia confirma que la estrategia está activa. Su ausencia es señal inequívoca de pérdida de contexto.

**Archivos afectados**: contrato.md, dcepi.md, comunicacion.md, identidad.md, worklog_template.md

### 2. Protocolo de Recuperación de Estrategia

**6 pasos explícitos**:
1. Leer worklog → Reconstruir memoria
2. Leer archivos de estrategia → Restaurar marco de referencia
3. Re-internalizar invariantes → Restaurar reglas no negociables
4. Re-internalizar sentencia de control → Restaurar mecanismo de detección
5. Emitir confirmación → Verificar recuperación exitosa
6. Continuar con sentencia de control → Volver a operación normal

**Fallback**: Si la recuperación falla, el Director reinicia la sesión con `prompt_inicio_sesion.txt`.

**Principio de diseño**: No depende de una frase mágica. Cualquier indicación del Director activa el protocolo.

**Archivos afectados**: contrato.md, dcepi.md, comunicacion.md

### 3. Estructura de Repos Dual

| Aspecto | Repo Operativo | Repo Completo |
|---------|---------------|---------------|
| Nombre | `estrategia-agentes-zai` | `estrategia` |
| Visibilidad | Público | Privado (local) |
| Contenido | Solo archivos operatives | Todo + meta/ |
| Consumidores | Agentes APA, MB, CZAI | Agente Estrategia, Director |

**Principio**: Sin duplicación. Una sola carpeta en PC local (`C:\Python\Proyectos\estrategia`). El repo operativo es un subconjunto del completo.

**Archivos afectados**: proyecto.md, entorno.md, worklog_template.md

### 4. Script de Actualización Automatizada

**Archivo**: `update_estrategia.ps1`

**Función**: Script PowerShell interactivo que automatiza el flujo completo de actualización:
- Reemplazo de archivos desde .zip (preservando .git)
- Commit y push al repo operativo
- Sincronización del repo completo

### 5. DIAGNÓSTICO-first como regla explícita

**Regla R1 fortificada**: "Ante cualquier pedido, SIEMPRE comenzar por DIAGNÓSTICO. No proponer solución sin diagnosticar."

Esta regla existía en v1.0 como R1 pero ahora se fortifica como obligación explícita en contrato.md y se refuerza en worklog_template.md.

---

## Invariantes (sin cambios desde v1.0)

I1–I7 permanecen inalterados. La sentencia de control y el protocolo de recuperación son mecanismos que aseguran el cumplimiento de los invariantes, no nuevos invariantes en sí mismos.

---

## Compatibilidad v1.0 → v1.1

Todos los archivos de v1.0 se actualizan en v1.1. No hay archivos eliminados. Los archivos nuevos son:
- `update_estrategia.ps1`
- `meta/spec_estrategia_v1.1.md`
- `meta/plan_estrategia_v1.1.md`

Los archivos de `agent-learn/` se actualizan con nuevas lecciones y antipatrones relacionados con v1.1.

---

## Estructura de archivos v1.1

### Repo operativo (público):
```
estrategia-agentes-zai/
├── agent-context/
│   ├── contrato.md
│   ├── dcepi.md
│   ├── comunicacion.md
│   ├── identidad.md
│   ├── proyecto.md
│   └── entorno.md
├── agent-learn/
│   ├── lecciones_aprendidas.md
│   ├── patrones_recurrentes.md
│   └── anti_patrones.md
└── worklog_template.md
```

### Repo completo (local):
```
estrategia/
├── [todo lo del operativo]
├── meta/
│   ├── director-only/
│   │   ├── prompt_inicio_sesion.txt
│   │   ├── prompt_templates.md
│   │   └── informe_estrategia_v1.1.md
│   ├── spec_estrategia_v1.1.md
│   ├── plan_estrategia_v1.1.md
│   ├── historial_versiones.md
│   └── tareas_inmediatas.md
└── update_estrategia.ps1
```

---

## Fecha de versión
v1.1 — 2025

---

## Fuente
Este informe es parte del sistema de estrategia Z.ai v1.1.
Repo completo: `estrategia` (local)
