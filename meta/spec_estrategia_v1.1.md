# Spec Estrategia Z.ai v1.1

## Identificación
- **Versión**: 1.1
- **Fecha**: 2025
- **Basada en**: v1.0
- **Tipo**: Minor (mejoras, no breaking changes)

---

## Objetivo

Evolutionar el sistema de estrategia Z.ai desde v1.0 para resolver dos problemas operativos críticos y una necesidad estructural:

1. **Detección de pérdida silenciosa de contexto** — Cuando un agente pierde contexto por compresión, lo hace sin avisar. El Director no se entera hasta que el comportamiento diverge significativamente.

2. **Recuperación de cumplimiento de estrategia** — No existía un procedimiento formal para que un agente que perdió contexto retome la estrategia. La única opción era reiniciar la sesión.

3. **Estructura de repos** — Se necesita un repo público compacto (para agentes de proyecto) y un repo local completo (para el agente Estrategia y el Director), sin duplicación de archivos.

---

## Requisitos

### R1: Sentencia de control
- **Descripción**: Marcador obligatorio al inicio de cada respuesta del agente
- **Formato**: `[FASE: X | Estrategia: activa]` donde X ∈ {D, C, E, P, I}
- **Función**: Su presencia confirma estrategia activa. Su ausencia señala pérdida de contexto.
- **Obligación**: En CADA respuesta, sin excepción
- **Archivos afectados**: contrato.md, dcepi.md, comunicacion.md, identidad.md, worklog_template.md

### R2: Protocolo de recuperación de estrategia
- **Descripción**: Procedimiento de 6 pasos para restaurar cumplimiento de estrategia
- **Activación**: Cualquier indicación del Director (no frase mágica)
- **Pasos**:
  1. Leer worklog → Reconstruir memoria de trabajo
  2. Leer archivos de estrategia → Restaurar marco de referencia
  3. Re-internalizar invariantes → Restaurar reglas I1–I7
  4. Re-internalizar sentencia de control → Restaurar mecanismo de detección
  5. Emitir confirmación → Verificar recuperación exitosa
  6. Continuar con sentencia de control → Volver a operación normal
- **Fallback**: Reiniciar sesión con prompt_inicio_sesion.txt
- **Archivos afectados**: contrato.md, dcepi.md, comunicacion.md

### R3: DIAGNÓSTICO-first explícito
- **Descripción**: Fortificar R1 como obligación explícita en contrato
- **Regla**: "Ante cualquier pedido, SIEMPRE comenzar por DIAGNÓSTICO. No proponer solución sin diagnosticar."
- **Archivos afectados**: contrato.md, worklog_template.md

### R4: Estructura de repos dual
- **Descripción**: Repo operativo (público, compacto) + repo completo (local, con meta/)
- **Sin duplicación**: Una sola carpeta en PC local
- **Repo operativo**: estrategia-agentes-zai (GitHub, público)
- **Repo completo**: estrategia (local en C:\Python\Proyectos\estrategia)
- **Archivos afectados**: proyecto.md, entorno.md, worklog_template.md

### R5: Script de actualización automatizada
- **Descripción**: PowerShell script interactivo para actualizar desde .zip
- **Rutas predeterminadas**:
  - Local: C:\Python\Proyectos\estrategia
  - ZIP: C:\Users\juanc\Downloads\estrategia.zip
  - Repo: https://github.com/Juank6507/estrategia-agentes-zai.git
  - Temp: C:\Python\Proyectos\tmp_operativo
- **Operaciones**: zip (reemplazo + push), push (solo push), sync (clonar + copiar)
- **Archivo nuevo**: update_estrategia.ps1

### R6: Actualización de director-only
- **Descripción**: Actualizar prompts, templates e informe a v1.1
- **Archivos afectados**: prompt_inicio_sesion.txt, prompt_templates.md, informe_estrategia_v1.1.md

### R7: Actualización de meta
- **Descripción**: Crear spec y plan v1.1, actualizar historial y tareas
- **Archivos nuevos**: spec_estrategia_v1.1.md, plan_estrategia_v1.1.md
- **Archivos actualizados**: historial_versiones.md, tareas_inmediatas.md

---

## Criterios de aceptación

1. Todo agente emite `[FASE: X | Estrategia: activa]` al inicio de cada respuesta
2. La ausencia de la sentencia es detectable por el Director
3. El protocolo de recuperación tiene 6 pasos explícitos con significado
4. El protocolo no depende de frase mágica
5. El fallback (reiniciar sesión) está documentado
6. DIAGNÓSTICO-first es obligación explícita en contrato
7. Repo operativo contiene solo archivos operatives (agent-context/, agent-learn/, worklog_template.md)
8. Repo completo contiene todo + meta/
9. No hay duplicación de archivos (una carpeta local)
10. update_estrategia.ps1 automatiza delete + unzip + push
11. Todos los archivos v1.0 actualizados a v1.1
12. historial_versiones.md registra v1.1
13. .zip entregado con todos los archivos

---

## Restricciones

- No se modifican los invariantes I1–I7 (se agregan mecanismos, no reglas)
- No se agrega carpeta proyectos/ (cada proyecto tiene lo suyo en su propio repo)
- director-only/ va dentro de meta/ en el repo completo
- proxy-llm-setup.md se mueve a APA_apa/docs/ (fuera de estrategia)
- No se usan symlinks (rompen al clonar)
- No se usan branches (merge trae todo, más complejo)

---

## Fuente
Esta spec es parte del sistema de estrategia Z.ai v1.1.
