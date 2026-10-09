# Comunicación de Agentes Z.ai

## Propósito
Define los protocolos de comunicación entre agentes y entre agente-Director.

---

## Formato estándar de comunicación

### Estructura de mensaje:
```
[FASE: X | Estrategia: activa]
<Tipo>: <Destino>

<Contenido>

<Evidencia/Referencia>
```

### Tipos de mensaje:
- **INFO**: Información sin acción requerida
- **TASK**: Tarea a realizar
- **DECISION**: Decisión que requiere validación del Director
- **BLOCKER**: Impedimento que requiere intervención
- **STATUS**: Reporte de progreso
- **ALERT**: Condición que requiere atención inmediata

---

## Protocolos

### P1 — Solicitud de tarea
1. Director describe necesidad
2. Agente ejecuta DIAGNÓSTICO (DCEPI Fase 1)
3. Agente presenta diagnóstico al Director
4. Director confirma o corrige
5. Agente procede con DCEPI

### P2 — Reporte de progreso
1. Al completar cada paso del plan → STATUS al Director
2. Al encontrar blocker → BLOCKER al Director inmediatamente
3. Al alcanzar checkpoint → DECISION al Director

### P3 — Solicitud de decisión
1. Agente identifica decisión necesaria
2. Agente presenta opciones con trade-offs
3. Agente recomienda una opción (con justificación)
4. Director decide
5. Agente registra decisión en worklog

### P4 — Handoff entre agentes
1. Agente A completa su parte
2. Agente A documenta estado en worklog
3. Agente A notifica al Director
4. Director asigna a Agente B
5. Agente B lee worklog y continúa

---

## Protocolo de Recuperación de Contexto

Cuando el Director detecta que un agente ha perdido cumplimiento de la estrategia (identificado por: ausencia de sentencia de control, comportamiento inconsistente con la estrategia, respuestas que ignoran invariantes, o cualquier otra indicación), se activa el siguiente protocolo:

### Paso 1: Leer worklog
- Revisar `/agent-ctx/worklog.md` completo
- **Significado**: Reconstruir la memoria de lo que se estaba haciendo — qué tarea, qué fase DCEPI, qué pasos completados, qué pendiente

### Paso 2: Leer archivos de estrategia
- Leer todos los archivos del repo operativo: `contrato.md`, `dcepi.md`, `comunicacion.md`, `identidad.md`, `proyecto.md`, `entorno.md`
- **Significado**: Restaurar el marco de referencia completo — reglas, metodología, protocolos, identidad

### Paso 3: Re-internalizar invariantes
- Reafirmar I1–I7 como reglas activas y obligatorias
- Declarar cada invariante como vigente
- **Significado**: Restaurar las reglas no negociables que gobiernan todo comportamiento del agente

### Paso 4: Re-internalizar sentencia de control
- Reafirmar que toda respuesta debe iniciar con `[FASE: X | Estrategia: activa]`
- Comprender que su ausencia señala pérdida de contexto
- **Significado**: Restaurar el mecanismo de detección que permite al Director verificar cumplimiento de estrategia en tiempo real

### Paso 5: Emitir confirmación de recuperación
- Declarar explícitamente: "Protocolo de recuperación completado. Estrategia re-activada. Sentencia de control restaurada."
- **Significado**: Dar al Director confirmación verificable de que el protocolo se completó exitosamente y el agente vuelve a operar bajo estrategia

### Paso 6: Continuar con sentencia de control
- Retomar el trabajo actual (desde donde lo dejó, según worklog)
- Emitir `[FASE: X | Estrategia: activa]` al inicio de toda respuesta subsiguiente
- **Significado**: Volver a operación normal bajo estrategia con el mecanismo de detección activo

### Fallback
Si el protocolo de recuperación no logra restaurar contexto coherente (el agente no puede reconstruir su estado a partir del worklog y los archivos de estrategia), el Director **reinicia la sesión** usando `prompt_inicio_sesion.txt`.

**Nota importante**: No se requiere una frase mágica o comando específico para activar este protocolo. Cualquier indicación del Director — una observación, una corrección, una pregunta sobre comportamiento, un "te perdiste" — activa el protocolo. El agente debe reconocer la señal y ejecutar los 6 pasos.

---

## Canales de comunicación

| Canal | Uso | Participantes |
|-------|-----|---------------|
| Directo | Instrucción y respuesta | Director ↔ Agente |
| Worklog | Registro de progreso | Agente → Todos |
| Estrategia repo | Referencia de reglas | Todos (lectura) |

---

## Formato de sentencia de control

**Obligatorio al inicio de CADA respuesta del agente:**

```
[FASE: X | Estrategia: activa]
```

Donde `X` es la fase DCEPI actual: D, C, E, P, o I.

**Si la sentencia no aparece**: El Director asume pérdida de contexto y activa el protocolo de recuperación.

---

## Fuente
Este protocolo es parte del sistema de estrategia Z.ai v1.1.
Repo operativo: `estrategia-agentes-zai`
