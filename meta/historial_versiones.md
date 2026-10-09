# Historial de Versiones — Estrategia Z.ai

## Propósito
Registro de todas las versiones del sistema de estrategia Z.ai con cambios y fecha.

---

## Versiones

### v1.1 — 2025
**Tipo**: Minor (mejoras, no breaking changes)

**Novedades**:
1. **Sentencia de control** — `[FASE: X | Estrategia: activa]` como marcador obligatorio en cada respuesta del agente para detectar pérdida silenciosa de contexto.
2. **Protocolo de recuperación de estrategia** — 6 pasos explícitos para restaurar cumplimiento de estrategia cuando el agente pierde contexto. No depende de frase mágica. Fallback: reiniciar sesión.
3. **DIAGNÓSTICO-first explícito** — Regla R1 fortificada como obligación: "Ante cualquier pedido, SIEMPRE comenzar por DIAGNÓSTICO."
4. **Estructura de repos dual** — Repo operativo (público, compacto para agentes de proyecto) + repo completo (local, con meta/ para Estrategia y Director). Sin duplicación de archivos.
5. **Script de actualización** — `update_estrategia.ps1` para automatizar actualización desde .zip + push a GitHub.
6. **Actualización de director-only** — prompt_inicio_sesion.txt, prompt_templates.md, informe_estrategia_v1.1.md actualizados.

**Archivos modificados**:
- agent-context/contrato.md
- agent-context/dcepi.md
- agent-context/comunicacion.md
- agent-context/identidad.md
- agent-context/proyecto.md
- agent-context/entorno.md
- agent-learn/lecciones_aprendidas.md
- agent-learn/patrones_recurrentes.md
- agent-learn/anti_patrones.md
- worklog_template.md
- meta/director-only/prompt_inicio_sesion.txt
- meta/director-only/prompt_templates.md

**Archivos nuevos**:
- meta/director-only/informe_estrategia_v1.1.md
- meta/spec_estrategia_v1.1.md
- meta/plan_estrategia_v1.1.md
- update_estrategia.ps1

**Archivos eliminados**: Ninguno

---

### v1.0 — 2024
**Tipo**: Major (versión inicial)

**Contenido fundacional**:
1. 7 Invariantes absolutos (I1–I7)
2. 16 Reglas Preferidas (R1–R16)
3. Metodología DCEPI (5 fases, 19+ pasos)
4. Protocolos de comunicación (P1–P4)
5. Identidad de agentes (Director, APA, MB, CZAI, Estrategia)
6. Mapa de proyectos
7. Entorno técnico
8. Worklog template
9. Agent-learn (lecciones, patrones, antipatrones)
10. Director-only (prompts, templates, informe)
11. Spec, plan, historial, tareas

---

## Convención de versionado

- **Major** (X.0): Cambios breaking, restructuración fundamental
- **Minor** (1.X): Nuevas funcionalidades, mejoras, sin breaking changes
- **Patch** (1.X.Y): Correcciones, typos, ajustes menores

---

## Fuente
Este historial es parte del sistema de estrategia Z.ai v1.1.
