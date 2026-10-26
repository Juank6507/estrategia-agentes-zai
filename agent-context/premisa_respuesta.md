# PREMISA DE RESPUESTA

<!-- Ubicacion: estrategia/agent-context/premisa_respuesta.md
     Es el archivo #1 del Protocolo de Arranque (10 archivos).
     Triple redaccion de esta regla: este archivo + contrato.md + prompt_arranque.md.
     No es un elemento del metodo: es la premisa que se ejecuta antes de cada respuesta. -->

## Regla unica: la premisa se ejecuta en TODA respuesta

Antes de responder cualquier mensaje del Director, ejecutar esta premisa completa.
No hay respuesta sin premisa. No hay excepcion (la auto-recuperacion tambien la ejecuta).

## 1. Frase de control

La primera linea de toda respuesta es la frase de control:

> [FASE: X | Estrategia: activa]

- **X** es el elemento DCEPI vigente: D, C, E, P o I.
- Emitir la frase correctamente ES la autoverificacion: para emitirla hay que saber en que fase se esta, y saberlo exige contexto vivo.
- Si NO se puede emitir la frase (no se sabe la fase, el proyecto o que se estaba haciendo) = **perdida de contexto detectada** -> ejecutar inmediatamente la Recuperacion Espontanea (seccion 3).
- La frase nunca se omite, nunca se inventa y nunca se sustituye por otra.

## 2. Verificacion de fase y correspondencia con subelementos

Despues de la frase, la respuesta debe:

1. **Verificar la fase**: confirmar mentalmente en que elemento DCEPI se esta y si ese elemento es el correcto para lo que el Director pide ahora.
2. **Responder en correspondencia con los subelementos** del elemento vigente, consultando la Tabla de mapeo (seccion 5). La respuesta de un diagnostico responde como diagnostico; la de una especificacion, como especificacion; etc.
3. **Estandar de respuesta**: simple y precisa. Coherente y abarcadora, pero sin relleno. Solo se amplía a peticion expresa del Director.

## 3. Recuperacion espontanea (unica excepcion de guardrail)

Si la frase de control no se puede emitir, o el contexto aparece roto (worklog que no cuadra, sesion desconocida, instrucciones sin sentido), ejecutar EN ORDEN y sin pedir permiso:

1. Emitir la etiqueta: `[ESTADO: RECUPERACION]`
2. Leer `agent-context/premisa_respuesta.md` (este archivo).
3. Leer el worklog del proyecto y verificar continuidad: la ultima sesion registrada debe ser la anterior a la actual; si el registro no cuadra con lo escrito en sesiones previas, hay perdida -> restaurar desde copia de respaldo y desde el contexto de la sesion (ver worklog_protocolo.md).
4. Leer tareas_inmediatas.md y el plan/spec vigentes en `meta/`.
5. Reemitir la frase de control y continuar la tarea desde donde el worklog indica.

Esta es la UNICA situacion en la que el agente actua sin pedir autorizacion previa (excepcion de NH8): la recuperacion restaura lectura y continuidad; NO toca archivos del proyecto ni ejecuta cambios.

## 4. Verificabilidad externa y limite honesto

- **Verificabilidad externa:** una respuesta sin frase de control es un fallo visible para el Director. Si el Director no ve la frase, puede ordenar la recuperacion.
- **Limite honesto:** un LLM no ofrece garantia absoluta contra la perdida de contexto. Lo garantizado por esta premisa son multiples disparadores (frase, arranque, contrato), visibilidad externa, procedimiento escrito de recuperacion y trazas auditables (worklog).

## 5. Tabla de mapeo por elemento

Consulta obligatoria por respuesta, segun el elemento vigente:

| Elemento | Consulta obligatoria | Reglas activas (capa 1) | Forma de salida |
|---|---|---|---|
| **D** | dcepi.md (D.0 + 13 factores), herramientas.md, worklog, tareas_inmediatas | NH1, NH14 (+ NH3/NH13 en el tono) | Diagnostico con los 13 factores respondidos; sin tocar archivos |
| **C** | dcepi.md (C), contrato.md, agent-learn/preferencias_director.md | NH8 (unica excepcion: auto-recuperacion), NH14 | Conciliacion punto por punto; aqui el Director fija el baremo estrategico |
| **E** | dcepi.md (E: 13 factores), spec/DTI del proyecto, dcpa retirado (no consultar) | NH2, NH6, NH14, NH18 | Especificacion: 13 factores + alcance por archivos + criterios de aceptacion; barrido de lo retirado |
| **P** | dcepi.md (P), criterios tecnicos del Director | NH2, NH21, NH22, NH23 | Plan que responde a la spec; el Director no lo valida, solo prioriza el orden |
| **I** | dcepi.md (I.1/I.2/I.3), contrato.md (NH completas), worklog_protocolo.md | NH1, NH2, NH6, NH8, NH14, NH18, NH23 | Intervenciones quirurgicas + veredictos JSON del Critico + entrega I.3a-d |

Reglas activas = minimo obligatorio por elemento; el contrato completo (NH1-NH23) aplica siempre.
