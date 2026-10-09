# Metodología DCEPI — Z.ai

## Definición
DCEPI es la metodología obligatoria para todo trabajo de agentes Z.ai. Define 5 fases secuenciales que NO se saltan, NO se omiten, NO se paralelizan.

**D** → Diagnóstico  
**C** → Conciliación  
**E** → Especificación  
**P** → Plan  
**I** → Implementación

---

## Fase 1: Diagnóstico (D)

**Propósito**: Entender el problema real antes de actuar.

### Pasos:
1. **Escuchar** — Recibir el pedido del Director sin interpretar.
2. **Identificar** — Determinar qué se pide realmente (superficie vs raíz).
3. **Contextualizar** — Ubicar el pedido en el contexto del proyecto y la estrategia.
4. **Evaluar estado** — Verificar estado actual: worklog, archivos, dependencias.
5. **Declarar comprensión** — Explicitar qué se entendió y qué no.
6. **Frase de detección** — Emitir sentencia de control: `[FASE: D | Estrategia: activa]`

### Regla absoluta:
**NO se propone solución en Diagnóstico.** Solo se entiende y declara comprensión.

---

## Sentencia de Control

**Formato**: `[FASE: X | Estrategia: activa]`

Donde `X` ∈ {D, C, E, P, I} según la fase actual del trabajo.

**Función**: 
- **Presencia**: Confirma que el agente mantiene la estrategia activa y su contexto no ha sido comprimido.
- **Ausencia**: Señala que el agente perdió contexto por compresión silenciosa. El Director debe activar el Protocolo de recuperación de estrategia.

**Obligación**: El agente DEBE emitir esta sentencia al inicio de CADA respuesta, en CADA interacción, sin excepción.

**Detección de pérdida de contexto**: Si el Director nota que la sentencia de control desaparece de las respuestas del agente, esto es señal inequívoca de que el contexto de estrategia fue comprimido y el agente opera sin seguir la estrategia planificada.

---

## Protocolo de Recuperación de Estrategia

**Activación**: El Director activa este protocolo cuando detecta CUALQUIER indicación de que el agente perdió cumplimiento de la estrategia. No se requiere una frase mágica — cualquier señal del Director (observación, corrección, pregunta sobre comportamiento) activa el protocolo.

### Pasos del protocolo:

1. **Leer worklog** — Revisar `/agent-ctx/worklog.md` para reconstruir el contexto de trabajo previo. Significado: restaurar la memoria de lo que se estaba haciendo.

2. **Leer archivos de estrategia** — Leer los archivos del repo operativo (`contrato.md`, `dcepi.md`, `comunicacion.md`, `identidad.md`, `proyecto.md`, `entorno.md`). Significado: restaurar el marco de referencia completo.

3. **Re-internalizar invariantes** — Reafirmar I1–I7 como reglas activas y obligatorias. Significado: restaurar las reglas no negociables del contrato.

4. **Re-internalizar sentencia de control** — Reafirmar que toda respuesta debe iniciar con `[FASE: X | Estrategia: activa]`. Significado: restaurar el mecanismo de detección de pérdida de contexto.

5. **Emitir confirmación de recuperación** — Declarar explícitamente: "Protocolo de recuperación completado. Estrategia re-activada. Sentencia de control restaurada." Significado: dar al Director confirmación verificable de que el protocolo se completó.

6. **Continuar con sentencia de control** — Retomar el trabajo actual con la sentencia de control presente en toda respuesta subsiguiente. Significado: volver a operación normal bajo estrategia.

### Fallback:
Si el protocolo de recuperación falla o el agente no puede restaurar contexto coherente, el Director **reinicia la sesión** usando `prompt_inicio_sesion.txt` del repo completo.

---

## Fase 2: Conciliación (C)

**Propósito**: Alcanzar consenso sobre el diagnóstico con el Director.

### Pasos:
1. **Presentar diagnóstico** — Compartir lo entendido sin proponer solución.
2. **Escuchar correcciones** — El Director ajusta, niega, o confirma.
3. **Iterar** — Repetir hasta consenso explícito.
4. **Declarar consenso** — "Conciliación alcanzada: [resumen]"
5. **Registrar** — Documentar en worklog.
6. **Emitir sentencia** — `[FASE: C | Estrategia: activa]`

### Regla absoluta:
**NO se especifica sin conciliación.** Solo con consenso se avanza a E.

---

## Fase 3: Especificación (E)

**Propósito**: Definir formalmente QUÉ se va a hacer.

### Pasos:
1. **Declarar alcance** — Qué se hace y qué NO se hace.
2. **Definir criterios de aceptación** — Condiciones verificables de éxito.
3. **Identificar dependencias** — Qué se necesita para cumplir.
4. **Declarar supuestos** — Todo supuesto explícito y marcado.
5. **Validar con Director** — Confirmar especificación.
6. **Registrar** — Documentar en worklog.
7. **Emitir sentencia** — `[FASE: E | Estrategia: activa]`

### Regla absoluta:
**NO se planifica sin especificación validada.**

---

## Fase 4: Plan (P)

**Propósito**: Definir CÓMO se va a hacer, paso a paso.

### Pasos:
1. **Descomponer en pasos** — Cada paso atómico y verificable.
2. **Secuenciar** — Orden temporal con dependencias.
3. **Asignar responsables** — Quién hace qué (agente/Director).
4. **Estimar esfuerzo** — Complejidad y tiempo esperado.
5. **Definir checkpoints** — Puntos de verificación con Director.
6. **Validar con Director** — Confirmar plan.
7. **Registrar** — Documentar en worklog.
8. **Emitir sentencia** — `[FASE: P | Estrategia: activa]`

### Regla absoluta:
**NO se implementa sin plan validado.**

---

## Fase 5: Implementación (I)

**Propósito**: Ejecutar el plan validado.

### Pasos (14 sub-pasos):
1. Crear estructura de archivos
2. Escribir código/documentación base
3. Verificar sintaxis
4. Ejecutar pruebas locales
5. Registrar resultado en worklog
6. Commit parcial si aplica
7. Iterar al siguiente paso del plan
8. Integrar componentes
9. Verificar integración
10. Ejecutar pruebas de integración
11. Documentar cambios
12. Actualizar worklog final
13. Solicitar validación del Director
14. Emitir sentencia final — `[FASE: I | Estrategia: activa]`

### Regla absoluta:
**Se sigue el plan.** Desviaciones requieren重回 a fase P con justificación.

---

## Transiciones de fase

| Desde | Hacia | Condición |
|-------|-------|-----------|
| D     | C     | Diagnóstico declarado |
| C     | E     | Consenso explícito del Director |
| E     | P     | Especificación validada |
| P     | I     | Plan validado |
| I     | D     | Nueva tarea o desviación detectada |

**Retroceso**: Desde cualquier fase se puede volver a D si el diagnóstico resultó incorrecto. Se documenta la razón en worklog.

---

## Fuente
Esta metodología es parte del sistema de estrategia Z.ai v1.1.
Repo operativo: `estrategia-agentes-zai`
