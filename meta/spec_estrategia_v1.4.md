<!-- Ubicacion: estrategia/meta/spec_estrategia_v1.4.md
     Especificacion (E) de la version 1.4 de la estrategia. Conciliada en C con el Director
     (ciclo v1.4; divergencias V1-V8 de la revision integral S55/S56 y decisiones posteriores). -->

# ESPECIFICACIÓN — Estrategia Z.ai v1.4

## 1. Origen

Orden del Director tras la auditoría de coherencia del ciclo v1.4 (revisión de los 32 ficheros, informe de 7 vestigios V1-V7 sin corregir) y la conciliación posterior en C de esas divergencias y de las nuevas decisiones (dos repos públicos, arranque por identidad, script con preguntas, paquete de seis elementos, baremo v1.4, factor 6 reformulado, guardrail reforzado, vía única de aprendizajes).

## 2. Los 13 factores de la especificación

| # | Factor | Respuesta |
|---|---|---|
| 1 | Qué falla | Los documentos de la estrategia describen un esquema de repos, un script y un paquete operativo que ya no son los vigentes; hay afirmaciones falsas ("protección física"), datos repetidos sin dueño, instrucciones divergentes y dos vías de salida de aprendizajes |
| 2 | Por qué falla | Decisiones posteriores (R18: 1 repo/2 ramas; reubicación de la premisa; script v3.0/v3.1) no se propagaron a todos los archivos; el mismo dato vivía repetido en varios archivos sin regla expresa de sede única |
| 3 | Dónde falla | proyecto.md, entorno.md, dcepi.md, comunicacion.md, prompt_arranque.md, contrato.md (NH5/NH20), herramientas.md, identidad.md, worklog_template.md, worklog_protocolo.md, worklog_EP.md (cabecera + entradas 26-55), update_estrategia.ps1, agent-learn (P10) |
| 4 | Cómo reproducirlo | Cualquier agente de proyecto que arranque hoy: proyecto.md le dice "PROYECTO ACTUAL: APA", le manda clonar la rama `operativo` (que no refleja el modelo conciliado) y no recibe la premisa en el paquete; el Director recibe tres instrucciones distintas para extraer el script |
| 5 | Qué debe pasar después | Dos repos públicos (completo/operativo) documentados como tal; arranque por identidad; proyecto.md con catálogo de los 4 proyectos; script v4.0 con preguntas y sentencia única; paquete de seis elementos; método DCEPI descrito íntegro; entorno descrito íntegro; aprendizajes con vía única |
| 6 | Qué no se toca | Historia de entradas de los worklogs (correcciones como notas); PDFs de la metodología (referencia externa); meta/ versionado histórico (spec/plan v1.1-v1.3 y director-only/ quedan como registro histórico por diseño) |
| 7 | Precondiciones | C cerrada (V1-V8 conciliadas, nombres de repos validados, aprendizajes aprobados); clon limpio en 99cf6fb con respaldo |
| 8 | Invariantes | Entrega completa del meta-proyecto (I.3a); umbral cero en integridad (manifiesto) y en búsquedas de retirados; triple redacción del guardrail; NH completas; marcadores de sesión de los worklogs intactos |
| 9 | Impacto colateral | Los worklogs adaptados v1.3 de los otros chats quedan desfasados en su cabecera hasta la próxima adaptación (pendiente ya registrado del Director) |
| 10 | Severidad | Alta: el paquete operativo entregado a los agentes de proyecto no contiene la premisa (archivo #1) y el modelo de acceso documentado es falso |
| 11 | Evidencia | Auditoría S55 (7 vestigios con acceso anónimo verificado) + verificación en disco de esta E (rutas y líneas citadas) |
| 12 | Antecedentes | R6 (2 repos v1.0) → R18 (1 repo/2 ramas v1.2) → v1.4 (2 repos públicos); DESVIACIÓN 1 (v1.3, REQUIRED_FILES/OPERATIVO_KEEP) |
| 13 | Alternativas descartadas | Repo completo privado (rompe el sandbox sin credenciales); mantener 1 repo/2 ramas documentado como convenio (deja la afirmación falsa sin corregir); un proyecto.md por proyecto (multiplica archivos); push directo de aprendizajes (rompe la triple igualdad entrega==GitHub==clon) |

## 3. Alcance por archivos

- **Nuevos (3):** `meta/spec_estrategia_v1.4.md`, `meta/plan_estrategia_v1.4.md`, `meta/informe_revision_integral_v1.4.md`.
- **Modificados (20):** premisa_respuesta.md; prompt_arranque.md; agent-context/proyecto.md; agent-context/entorno.md; agent-context/dcepi.md; agent-context/comunicacion.md; agent-context/contrato.md; agent-context/herramientas.md; agent-context/identidad.md; worklog_template.md; worklog_protocolo.md; worklog_EP.md (cabecera + entradas 26-55, por orden expresa del Director — V5); worklog_EP.backup.md; update_estrategia.ps1 (v4.0); MANIFIESTO_ENTREGA.txt (regenerado); meta/historial_versiones.md; meta/tareas_inmediatas.md; agent-learn/lecciones_aprendidas.md; agent-learn/anti_patrones.md; agent-learn/preferencias_director.md.
- **Eliminados:** ninguno.

## 4. Decisiones conciliadas que materializa (V1-V8)

1. **V1 — Dos repos públicos, un repo local:** un solo repo local del Director se publica en dos repos públicos de GitHub: completo (`estrategia-agentes-zai`, lo clona EP) y operativo (`estrategia-agentes-zai-operativo`, lo clonan los agentes de proyecto). Sin credenciales: la separación de contenido es la separación entre repos. Cero vestigios del esquema de ramas y de la "protección física".
2. **V2 — Arranque por identidad:** el worklog identifica agente y proyecto; proyecto.md cataloga los 4 proyectos (EP, APA, MB, CZAI) con URLs y regla de aviso; proyecto.md dice qué repo clonar.
3. **V3 — entorno.md íntegro:** describe el entorno de trabajo con sus guardrails, su método DCEPI y sus herramientas (contexto_zai), remitiendo a las sedes canónicas.
4. **V4 — dcepi.md íntegro:** describe el método con todos sus elementos y subelementos, cómo se usa, se valora e implementa cada uno y cómo influye en la solución de los problemas que corrige; sentencias de cierre para los dos repos y re-clonado por identidad.
5. **V5 — Cabecera del worklog del repo:** actualizada por orden expresa del Director, sincronizada con la plantilla; NH20 reformulada en dos capas (cabecera de estrategia vs. historia intocable); entradas 26-55 incorporadas.
6. **V6 — Script v4.0 + sentencia única:** el script pregunta (Enter = predeterminado) carpeta del zip (Descargas; el `estrategia_v#.#.zip` más reciente), carpeta local (borra y reemplaza) y los dos repos a publicar; conserva verificación umbral cero, informe DIFF con UTF-8 correcto y modos auxiliares. El Director ya no extrae el script a mano: la entrega trae una sentencia de PowerShell que lo extrae y lo ejecuta (una sola, canónica).
7. **V7 — Aprendizajes:** se proponen tras conciliar la E y antes del plan; se implementan junto a todo lo demás y viajan dentro de la entrega; sin push directo (NH5).
8. **V8 — Paquete operativo de seis elementos** con la premisa como #1 (repo operativo).

## 5. Criterios de aceptación (verificables, baremo v1.4)

1. **Búsqueda umbral cero** de vestigios: `1 repo`, `dos ramas`, `-b operativo`, `físicamente no pueden`, `protección física`, `errores_comunes`, `experiencias`, `Extrae del .zip SOLO`, `git add, commit, push` (en archivos operativos) → 0 coincidencias (los históricos versionados de meta/ y el worklog conservan su historia).
2. **proyecto.md** contiene los 4 proyectos con URLs, la regla de aviso y qué repo clona cada identidad.
3. **El paquete operativo** aparece en todas las menciones como seis elementos con la premisa #1.
4. **Script v4.0** validado estáticamente (ASCII, balance, funciones) y con la sentencia única redactada; verificación final en el Windows del Director (baremo de doble entorno, I.3b).
5. **Guardrail en triple redacción** (premisa, contrato, prompt_arranque): frase + panel como primera línea, antes de cualquier pensamiento o comentario; omisión detiene el proceso y/o invalida la respuesta.
6. **Sentencias y cierre** referidas a los dos repos con re-clonado por identidad (EP: completo; agentes de proyecto: operativo).
7. **Integridad umbral cero** del manifiesto regenerado y comparación zip↔clon sin diferencias.
8. **Informe de revisión integral** que cubre TODOS los archivos con su resolución registrada.
9. **Ningún dato repetido sin regla expresa:** sedes canónicas declaradas (proyecto.md: identidad/URLs; entorno.md: flujo del script; dcepi.md: método; premisa/contrato/prompt: guardrail por triple redacción).
