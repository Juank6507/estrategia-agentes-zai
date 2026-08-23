# PLANTILLAS DE PROMPT

Estas plantillas guían al Director sobre qué información incluir en su prompt según el tipo de tarea. Son **guías**, no textos obligatorios. El Director adapta el contenido a cada situación.

---

## QUÉ ARCHIVOS DE CONTEXTO LEE EL AGENTE

Los archivos ya se leyeron al inicio de la sesión (cuando el agente clonó el repositorio de estrategia y leyó workspace.md). **No es necesario volver a clonar ni releer para dar una tarea.** El agente ya tiene el contexto cargado.

Archivos cargados al inicio (desde `/home/z/my-project/estrategia/`):
- `.agent-context/identidad.md`
- `.agent-context/contrato.md`
- `.agent-context/comunicacion.md`
- `.agent-context/dcpa.md`
- `.agent-context/workspace.md`
- `.agent-learn/` (si existe)

El estado del proyecto lo obtiene el agente de las entradas del worklog.

---

## PLANTILLA 1: DESARROLLO DE NUEVA FUNCIONALIDAD

```
Necesito implementar: [descripción de la funcionalidad]

Contexto:
- Archivos afectados: [lista si se conocen]
- Restricciones: [alguna limitación o requisito específico]
- Referencia: [doc, URL, o ejemplo si aplica]

Revisa las entradas del worklog para entender el estado actual del proyecto antes de proponer plan.
```

**El agente debe:** Ejecutar DPCA completo antes de implementar.

---

## PLANTILLA 2: CORRECCIÓN DE BUG

```
Tengo un bug:

Qué ocurre: [descripción del comportamiento incorrecto]
Qué debería ocurrir: [comportamiento esperado]
Cuándo ocurre: [condiciones que lo reproducen]
Archivos que creo que están involucrados: [si se conocen]
```

**El agente debe:** Ejecutar DPCA (diagnóstico → plan → consenso → autorización → corrección).

---

## PLANTILLA 3: REFACTORING

```
Quiero refactorizar: [qué se va a refactorizar]

Motivo: [por qué es necesario]
Restricciones: [qué NO debe cambiar, qué debe seguir funcionando igual]
```

**El agente debe:** Ejecutar DPCA completo. Aplicar cambios quirúrgicos, nunca reescritura completa.

---

## PLANTILLA 4: INVESTIGACIÓN / ANÁLISIS

```
Necesito que investigues: [qué investigar]

Alcance: [qué necesito saber, qué no]
Profundidad: [resumen breve / análisis detallado / informe completo]
Entrega: [en el chat / documento en /download/]
```

**El agente debe:** Investigar y entregar el resultado. No requiere DPCA (no se modifica nada).

---

## PLANTILLA 5: DOCUMENTACIÓN

```
Necesito documentación sobre: [qué documentar]

Tipo: [overview / estado actual / informe / manual]
Formato: [markdown / texto en chat / archivo]
Para quién: [Director / Asesor / otro agente]
```

**El agente debe:** Generar la documentación solicitada. No requiere DPCA.

---

## PLANTILLA 6: HANDOFF ENTRE AGENTES

```
Preparar handoff para el próximo agente que trabajará en [proyecto/tarea].

Incluye:
- Estado actual de lo que se ha hecho
- Qué queda pendiente
- Decisiones tomadas
- Archivos clave y su estado
- Errores conocidos
- Qué debe saber el próximo agente

Entrega en /download/.
```

**El agente debe:** Generar un handoff report completo. Z.ai gestionará el worklog automáticamente.