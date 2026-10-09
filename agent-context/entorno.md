# Entorno Z.ai

## Propósito
Describe el entorno técnico y los recursos disponibles para los agentes Z.ai.

---

## Estructura de Repositorios de Estrategia

### Dos repositorios, una carpeta local

| Aspecto | Repo Operativo | Repo Completo |
|---------|---------------|---------------|
| **Nombre GitHub** | `estrategia-agentes-zai` | `estrategia` |
| **Visibilidad** | Público | Privado (local) |
| **Ubicación local** | `C:\Python\Proyectos\estrategia` | `C:\Python\Proyectos\estrategia` (misma carpeta) |
| **Contenido** | Solo archivos operatives | Todo operativo + `meta/` |
| **Consumidores** | Agentes APA, MB, CZAI | Agente Estrategia, Director |
| **URL GitHub** | `https://github.com/Juank6507/estrategia-agentes-zai` | N/A (local) |

### Estructura del repo operativo (público):
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

### Estructura del repo completo (local):
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

### Principio: Sin duplicación
- Una sola carpeta en PC local: `C:\Python\Proyectos\estrategia`
- El repo operativo es un subconjunto del repo completo
- No hay archivos duplicados — el .git del operativo maneja su propio tracking

---

## Flujo de Actualización por .zip

Cuando se entrega una nueva versión de la estrategia como `.zip`:

1. **Script automatizado** (`update_estrategia.ps1`) ejecuta:
   - Elimina archivos previos (preservando `.git`):  
     `Get-ChildItem -Path . -Exclude .git | Remove-Item -Recurse -Force`
   - Desempaqueta `.zip` en la ubicación del proyecto:  
     `Expand-Archive -Path '<ruta_zip>' -DestinationPath '.' -Force`
2. **Commit y push** al repo operativo (`estrategia-agentes-zai`)
3. **Agentes** pullan del repo operativo para obtener la versión actualizada

### Rutas predeterminadas:
- **Carpeta local del proyecto**: `C:\Python\Proyectos\estrategia`
- **Ruta del .zip**: `C:\Users\juanc\Downloads\estrategia.zip`
- **Repo operativo GitHub**: `https://github.com/Juank6507/estrategia-agentes-zai.git`
- **Carpeta temporal operativo**: `C:\Python\Proyectos\tmp_operativo`

---

## Entorno Técnico

### Plataforma de agentes
- **Sistema**: Z.ai (plataforma de agentes con contexto)
- **Lenguaje**: Natural (español) con marcado estructurado
- **Metodología**: DCEPI (5 fases, 19+ pasos)
- **Control de versión**: Git/GitHub

### Herramientas del Director
- **OS**: Windows (PowerShell)
- **Editor**: A elección del Director
- **PDF**: Generación del libro de estrategia
- **Script**: `update_estrategia.ps1` para actualización automatizada

---

## Convenciones

### Formato de archivos
- Markdown (.md) para toda documentación
- UTF-8 encoding
- Líneas: LF (Unix) o CRLF (Windows)

### Nomencatura
- Archivos: `snake_case.md`
- Directorios: `snake_case/`
- Versiones: `vX.Y` (major.minor)

---

## Fuente
Este entorno es parte del sistema de estrategia Z.ai v1.1.
Repo operativo: `estrategia-agentes-zai`
