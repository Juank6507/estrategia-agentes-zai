# Worklog Template — Z.ai

## Propósito
Template para el worklog de cada proyecto. Todo agente DEBE usar este formato para registrar su trabajo.

---

## Formato

```markdown
# Worklog — [NOMBRE PROYECTO]

---
Task ID: [ID]
Agent: [nombre agente]
Task: [descripción de la tarea]

Work Log:
- [paso 1: qué se hizo, qué se decidió]
- [paso 2: qué se hizo, qué se decidió]
- ...

Stage Summary:
- [resultado clave]
- [decisión importante]
- [artefacto producido]
```

---

## Instrucciones de uso

### Paso 1: Inicio de sesión
1. Leer este worklog template
2. Clonar/pullar el repo de estrategia correspondiente:
   - Agentes APA, MB, CZAI → `git clone https://github.com/Juank6507/estrategia-agentes-zai.git`
   - Agente Estrategia → trabajar en `C:\Python\Proyectos\estrategia` (repo completo local)
3. Leer los archivos de estrategia: `contrato.md`, `dcepi.md`, `comunicacion.md`, `identidad.md`
4. Emitir sentencia de control: `[FASE: D | Estrategia: activa]`

### Paso 2: Cada tarea
1. Crear entrada de worklog con Task ID único
2. Documentar cada paso en "Work Log"
3. Al completar, llenar "Stage Summary"

### Paso 3: Diagnóstico (obligatorio)
1. SIEMPRE comenzar por DIAGNÓSTICO (Fase D de DCEPI)
2. No proponer solución sin diagnosticar
3. Documentar diagnóstico en worklog

### Paso 4: Avance por DCEPI
1. Seguir fases D → C → E → P → I sin saltar
2. En cada fase, emitir sentencia de control
3. Documentar transiciones de fase

### Paso 5: Checkpoints
1. Al alcanzar checkpoint, solicitar validación del Director
2. Registrar validación en worklog

### Paso 6: Blockers
1. Al encontrar impedimento, reportar BLOCKER inmediatamente
2. No continuar hasta resolver
3. Registrar resolución en worklog

### Paso 7: Cierre
1. Completar Stage Summary
2. Emitir sentencia de control final: `[FASE: I | Estrategia: activa]`
3. Solicitar validación de cierre del Director

---

## Detección de pérdida de contexto

Si el agente nota que no puede producir worklog coherente o no recuerda la tarea actual, DEBE:
1. Revisar este worklog para reconstruir contexto
2. Si no puede reconstruir, reportar al Director
3. El Director activa el Protocolo de recuperación de estrategia

---

## Fuente
Este template es parte del sistema de estrategia Z.ai v1.1.
Repo operativo: `estrategia-agentes-zai`
