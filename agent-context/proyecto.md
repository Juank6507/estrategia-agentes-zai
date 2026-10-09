# Proyecto Z.ai — Mapa de Proyectos

## Propósito
Define los proyectos activos del ecosistema Z.ai y su relación con los repositorios de estrategia.

---

## Proyectos Activos

| Proyecto | Agente | Repo Código | Repo Estrategia | Descripción |
|----------|--------|-------------|-----------------|-------------|
| APA | APA_apa | APA_apa | operativo (`estrategia-agentes-zai`) | Aplicación principal APA |
| Manuel Belgrano | ManuelBelgrano | ManuelBelgrano | operativo (`estrategia-agentes-zai`) | Proyecto Manuel Belgrano |
| CZAI | CZAI_zai | CZAI_zai | operativo (`estrategia-agentes-zai`) | Proyecto CZAI |
| Estrategia | Estrategia | estrategia | completo (`estrategia`) | Meta-proyecto de estrategia |

---

## Repositorios de Estrategia

### Repo Operativo: `estrategia-agentes-zai`
- **Visibilidad**: Público
- **Contenido**: Solo lo que los agentes de proyecto necesitan
  - `agent-context/` (6 archivos de reglas y protocolos)
  - `agent-learn/` (3 archivos de aprendizaje)
  - `worklog_template.md`
- **Consumidores**: Agentes APA, MB, CZAI
- **GitHub**: `https://github.com/Juank6507/estrategia-agentes-zai`

### Repo Completo: `estrategia`
- **Visibilidad**: Privado (local en PC del Director)
- **Contenido**: Todo el operativo + meta/
  - Todo lo del repo operativo
  - `meta/director-only/` (prompts, templates, informe)
  - `meta/spec_estrategia_vX.Y.md`
  - `meta/plan_estrategia_vX.Y.md`
  - `meta/historial_versiones.md`
  - `meta/tareas_inmediatas.md`
- **Consumidores**: Agente Estrategia, Director
- **GitHub**: No (repo local, se gestiona por .zip)

---

## Flujo de Actualización

1. Desarrollo de nueva versión → todos los archivos en carpeta local `C:\Python\Proyectos\estrategia`
2. Empaquetado → `.zip` con todos los archivos
3. Despliegue → `update_estrategia.ps1` reemplaza archivos locales y pushea al repo operativo
4. Agentes → clonan/pullan del repo operativo para obtener reglas actualizadas

---

## Relación Agente ↔ Repo Estrategia

| Agente | Lee | Escribe | Repo |
|--------|-----|---------|------|
| APA | agent-context/, agent-learn/ | worklog, proyecto | operativo |
| MB | agent-context/, agent-learn/ | worklog, proyecto | operativo |
| CZAI | agent-context/, agent-learn/ | worklog, proyecto | operativo |
| Estrategia | Todo (incluido meta/) | Todo | completo |
| Director | Todo | Todo | completo (local) |

---

## Fuente
Este mapa es parte del sistema de estrategia Z.ai v1.1.
