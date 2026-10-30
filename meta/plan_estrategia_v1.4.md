<!-- Ubicacion: estrategia/meta/plan_estrategia_v1.4.md
     Plan (P) de la version 1.4. Responde a la spec_estrategia_v1.4.md. Orden priorizado por
     el Director; la autorizacion de ejecucion se recibio al cerrar la C (V1-V8 + aprendizajes). -->

# PLAN — Estrategia Z.ai v1.4

## Fases (orden de ejecución)

| # | Fase | Contenido | Verificación de cierre |
|---|---|---|---|
| 1 | **Preparación** | Respaldo del estado v1.3.1 (snapshot íntegro del clon), tabla de alcance (spec §3), montaje: HEAD 99cf6fb, árbol limpio | Snapshot verificable; git status limpio |
| 2 | **Revisión integral** | Los 32 ficheros contra las decisiones conciliadas; divergencias V1-V7 informadas sin corregir y V8 derivada; informe en meta/ | informe_revision_integral_v1.4.md cubre TODOS los archivos |
| 3 | **Núcleo documental** | proyecto.md (catálogo + identidad) → entorno.md (íntegro) → dcepi.md (íntegro) → comunicacion.md → guardrails (contrato/premisa/prompt_arranque) → plantilla/protocolo de worklog; remisiones en herramientas.md e identidad.md | Búsqueda umbral cero de vestigios; sedes canónicas respetadas |
| 4 | **Script** | update_estrategia.ps1 v4.0 (preguntas con predeterminados, dos repos, hereda integridad/UTF-8/modos) + sentencia única | Validación estática (ASCII, balance, funciones); validación final en Windows del Director (I.3b) |
| 5 | **meta/** | spec v1.4, plan v1.4, historial (entrada v1.4), informe de revisión integral, tareas_inmediatas | Los 3 nuevos archivos presentes en la entrega |
| 6 | **Aprendizajes** | Las 5 entradas aprobadas (2 lecciones, 2 anti-patrones, 1 preferencia) + P10 actualizado al flujo v4.0 | agent-learn coherente con el método vigente |
| 7 | **Worklog del repo** | Cabecera v1.4 sincronizada con la plantilla (V5, por orden expresa) + entradas 26-55 incorporadas del worklog canónico + backup sincronizado | Marcadores de sesión íntegros; cabecera == plantilla |
| 8 | **Entrega y cierre** | MANIFIESTO_ENTREGA.txt regenerado (SHA256 umbral cero), zip estrategia_v1.4.zip en download/ con diff zip↔clon CERO, sentencias_actualizacion_v1.4.txt con la sentencia única, worklog canónico (S56+) y 00_estado_actual.md actualizados | Manifiesto 100% OK; diff CERO; re-clonado final I.3e pendiente del push del Director |

## Criterios técnicos aplicados

- Cambios quirúrgicos donde el archivo era sano (contrato, premisa, protocolo, herramientas, identidad); reescritura donde la E lo ordena (proyecto, entorno, dcepi, prompt_arranque, plantilla, script).
- Sin hardcoding: URLs y rutas con predeterminados parametrizables (-ZipPath, -RepoDir, -CompletoUrl, -OperativoUrl).
- Compatibilidad: script ASCII-only, PowerShell 5.1 compatible, sin CRLF; advertencias de plataforma en la entrega.
- Un dato, un dueño: cada dato tiene sede canónica y las repeticiones apoyan una regla expresa (triple redacción, remisiones).
