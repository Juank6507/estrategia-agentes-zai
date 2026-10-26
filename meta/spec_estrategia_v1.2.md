# Spec Estrategia Z.ai v1.2

## Version

- **Version:** 1.2
- **Fecha:** 2026-10-24
- **Estado:** Aprobada por el Director (elementos C y E cerrados) - pendiente de implementacion
- **Documento hermano:** plan_estrategia_v1.2.md (elemento P)

## Novedades v1.2 (resumen)

1. DCEPI refinado con 5 elementos (D, C, E, P, I) y subelementos conciliados punto por punto
2. Premisa de respuesta obligatoria en cada respuesta (premisa_respuesta.md, nuevo)
3. Conciencia instrumental del agente (herramientas.md, nuevo)
4. Baremos estrategico y tactico con propietario, momento y archivo definidos
5. I.1 precondiciones obligatorias antes de tocar codigo
6. I.2 ACCL v2: Orquestador -> Actor -> Critico con Gauntlet de 6 pasos y 3 capas de verificacion
7. I.3 entregas en 4 subfases con DOS regimenes (proyectos generales y meta-proyecto)
8. Repositorio unico con 2 ramas (main + operativo): sustituye a la estructura 2-repos de R6
9. agent-learn consolidado de 6 a 4 archivos
10. Protocolo de worklog migrado a worklog_protocolo.md con proteccion ante truncados
11. Documentacion de la estrategia: PDFs ACCL v1 y v2 viven en estrategia/meta/

## Requisitos nuevos (R12-R21)

### R12 -- DCEPI refinado
- Descomposicion oficial: Diagnostico -> Conciliacion -> Especificacion -> Plan -> Implementacion.
- Quedan prohibidos y sujetos a barrido global (0 coincidencias): la descomposicion antigua "Consenso -> Ejecucion -> Plan -> Inspeccion", el DCPA y la taxonomia de 18 aspectos del SDD de proyectos completos. E tiene solo 13 subelementos.
- **D**: D.0 recogida de contexto (incluye las dos piezas heredadas: recuperacion espontanea de contexto y conciencia instrumental) + 13 factores de diagnostico (5 imprescindibles: que se observa / donde se observa / como se reproduce / que cambio recientemente / hipotesis de causa; 5 necesarios: causa raiz confirmada / alcance del impacto / gravedad y urgencia / estado del codigo afectado / historial del problema; 3 prescindibles: evidencia tecnica / entorno de ocurrencia / patrones relacionados). D.0 se responde una vez desde el arranque; solo se re-ejecuta completo cuando la recuperacion de contexto lo invalida.
- **C**: conciliacion con el Director; ahi queda fijado el baremo estrategico (estandar de respuesta del Director para el error); guard NH8/NH14 con una unica excepcion: la auto-recuperacion de contexto.
- **E**: 13 factores de especificacion (5 imprescindibles: que falla / por que falla / donde falla / como reproducirlo / que debe pasar despues; 5 necesarios: que no se toca / precondiciones / invariantes / impacto colateral / severidad; 3 prescindibles: evidencia / antecedentes / alternativas descartadas). Conexion D->E: el factor 6 causa raiz alimenta el factor 2 por que falla; el factor 5 hipotesis se convierte en precondicion en E.
- **P**: fase tecnica del agente; el plan responde a la spec; el Director valida la E, NO el plan; en P solo prioriza el orden segun su estrategia de trabajo; la autorizacion de ejecucion ocurre al entrar a I. Criterios tecnicos permanentes del Director: buenas practicas, OOP, prohibicion de hardcoding, mocks/fallbacks solo cuando no exista posibilidad de datos reales explicitos o implicitos. El Director puede pedir E+P juntos en el mismo prompt.
- **I**: I.1 precondiciones, I.2 ACCL, I.3 entregas (ver R15, R16, R17).
- Proteccion explicita (factor 6): los grafos y el algoritmo del script existente NO se tocan fuera de su intervencion quirurgica.
- Guardrails: los usa el agente en cada momento y orientan la respuesta en cada situacion; no son texto decorativo. Notacion abreviada [P]/[G] abolida: siempre palabras completas PRESCRIPTIVA / GUARDRAIL, definidas una sola vez, con advertencia de que no son elementos del metodo (los elementos son solo D, C, E, P, I).

### R13 -- Premisa de respuesta
- Nuevo archivo `agent-context/premisa_respuesta.md`; PRIMER archivo del protocolo de arranque, que pasa de 9 a 10 archivos.
- Se ejecuta en cada respuesta como primera y principal premisa.
- Frase de control `[FASE: X | Estrategia: activa]`: emitirla correctamente equivale a autoverificacion; no poder emitirla = deteccion de perdida de contexto.
- Recuperacion espontanea: emitir `[ESTADO: RECUPERACION]` -> leer premisa_respuesta.md -> verificar continuidad del worklog -> revisar tareas -> reemitir la frase. Unica excepcion de guardrail admitida.
- Triple redaccion de la regla: prompt_arranque.md (premisa como #1), contrato.md, premisa_respuesta.md.
- Verificabilidad externa: sin frase de control, el fallo es visible para el Director.
- Limite honesto declarado: un LLM no ofrece garantia absoluta; lo garantizado son multiples disparadores + visibilidad externa + procedimiento de recuperacion escrito + trazas auditables.
- Tabla de mapeo por elemento (5 filas D/C/E/P/I: consulta obligatoria / reglas activas / forma de salida) codificada en premisa_respuesta.md.

### R14 -- Baremos
- **Estrategico**: lo fija el Director en C (estandar de respuesta para el error); se registra en el DTI del proyecto.
- **Tactico**: lo deriva el agente en P junto al plan; se aplica en I.2 (umbral cero del Critico; umbrales de perimetro de lineas fijados por intervencion; deletions = 0 por defecto solo en intervenciones puramente aditivas).
- dcepi.md contiene solo el PROCEDIMIENTO; el contenido estrategico vive en el DTI del proyecto.
- Regla de ubicacion: transversal -> estrategia; especifico -> DTI/proyecto.

### R15 -- I.1 Precondiciones
- Snapshot de regresion (golden master) antes de tocar codigo.
- Repositorio montado y en estado conocido.
- Tabla de alcance: lista de archivos tocables.
- Grafos y algoritmo protegidos identificados.
- Sin precondiciones completas no se empieza.

### R16 -- I.2 ACCL v2
- **Roles**: Orquestador (no escribe codigo ni opina; descompone en intervenciones quirurgicas de una sola), Actor (ejecuta solo lo listado y propone diff), Critico (executor de comandos con umbral cero; no lee codigo para opinar; el fuzzing se deriva de la spec, factor 5 que debe pasar despues).
- **7 fases**: 0 precondiciones (golden master, respaldo, perimetro, entorno); 1 descomposicion quirurgica; 2 Actor propone diff; 3 Gauntlet determinista; 4 veredicto JSON; 5 auto-correccion del Actor con feedback estructurado; 6 cierre autonomo (golden master actualizado + commit local autogenerado; el push a GitHub sigue siendo del Director via I.3c).
- **Gauntlet en orden obligatorio**: regresion (vs snapshot) -> perimetro_archivos -> perimetro_lineas -> estatica -> dinamica -> logica (con fuzzing).
- **Veredicto JSON del Critico** (schema fijo): {"aprobado", "items_fallados", "motivo", "vuelve_a", "comandos_fallidos" con esperado/obtenido/evidencia}.
- **3 capas**: (1) consulta de reglas escritas en la premisa (NH1, NH2, NH6, NH8, NH14, NH18, NH23); (2) veredicto JSON; (3) verificacion programatica con umbral cero (git diff --name-only, grep de residuos = 0, exit 0); con fallo, la salida no sale del sandbox.
- **MAX_ITER = 5** por defecto, ajustable por el Director; superado el limite -> escalado al Director.
- Metodologia de referencia: PDFs ACCL v1 y v2 en estrategia/meta/ (R21). Notas de incorporacion: commit autogenerado = local del sandbox; umbrales de perimetro los fija el Orquestador por intervencion; fuzzing derivado de la spec.

### R17 -- I.3 Entregas
- **I.3a DOS regimenes** (aprobados en P13): (a) regla general, proyectos de aplicacion: entrega solo de archivos modificados (.zip), con tests y sentencias de prueba y de actualizacion sobre los archivos modificados, salvo tests E2E que cubren todo el proyecto; (b) meta-proyecto (este): entrega SIEMPRE completa de todos los archivos, modificados o no, via .zip en /download/ con reemplazo total en la PC del Director.
- **I.3b doble entorno**: los archivos deben pasar antes el baremo del sandbox Linux; cada archivo modificado se entrega con validacion interna + evidencia de superacion en el entorno Windows del Director (sentencias para que valide igual) + superacion de tests E2E del proyecto; si no supera -> vuelve al DCEPI.
- **I.3c sentencias de GitHub**: con el repo local actualizado y probado, el agente entrega las sentencias git/GitHub para que el Director ejecute la actualizacion con garantias; adaptadas al esquema 1 repo/2 ramas (R18).
- **I.3d cierre del metodo**: diff entre cada archivo intervenido (workspace del agente vs repositorio) = CERO diferencias -> actualizar worklog + tareas inmediatas + aprendizajes. Aprendizajes genericos -> agent-learn/ (accesibles a todos los agentes); especificos -> DTI del proyecto; worklog queda narrativo. El llenado ocurre en I.3d con autorizacion previa del Director y criterio de utilidad en el momento preciso.

### R18 -- Repositorio unico con 2 ramas (sustituye a R6)
- UNA carpeta local = UN repo (C:\Python\Proyectos\estrategia) conectado a UN solo repo GitHub (estrategia-agentes-zai).
- **Rama main**: completa (incluye meta/, director-only/, worklog_EP, contexto_recuperacion/, contexto_zai/, scripts y todo lo demas).
- **Rama operativo**: compacta (agent-context/, agent-learn/, worklog_template.md, prompt_arranque.md). Los agentes de proyecto clonan con -b operativo y fisicamente no pueden ver meta/, director-only/ ni carpetas internas. Unica forma nativa de acceso diferenciado real dentro de UN repo (GitHub no tiene permisos por carpeta).
- El agente del meta-proyecto clona main.
- **update_estrategia.ps1**: para el Director una sola operacion (reemplazo total desde .zip + ejecutar el script); internamente hace commit+push a main y sincroniza automaticamente la rama operativo (checkout, poda de rutas internas, commit, push, vuelta a main). Toda la complejidad vive dentro del script. Incluye cabecera de ambito: exclusivo del meta-proyecto.
- La estructura 2-repos de R6 queda formalmente sustituida; se preserva su intencion de acceso diferenciado con 1 repo.

### R19 -- agent-learn consolidado 6 -> 4
- Consolidacion aprobada por el Director: errores_comunes.md + anti_patrones.md -> anti_patrones.md; experiencias.md + lecciones_aprendidas.md -> lecciones_aprendidas.md.
- Resultado (4 archivos): anti_patrones.md, lecciones_aprendidas.md, patrones_recurrentes.md, preferencias_director.md.
- El llenado ocurre en I.3d con autorizacion previa del Director y criterio de utilidad en el momento preciso.

### R20 -- Worklog y proteccion de continuidad
- Protocolo del worklog migrado a worklog_protocolo.md (dos fases; formato verbatim de apertura y cierre de sesion). worklog_template.md conserva solo la plantilla.
- Proteccion ante truncados externos: copia de respaldo + restauracion verbatim desde el contexto de sesion. Leccion registrada: las copias locales NO son proteccion duradera (el sandbox se limpia externamente); la proteccion duradera es el repo GitHub (I.3c) y la entrega completa del meta-proyecto, que siempre incluye el worklog.

### R21 -- Documentacion de la estrategia
- Ambos PDF de la metodologia (v1 "Metodologia Agentica" y v2 "Metodologia Mejorada_ Agentic CI_CD Loop") viven en **estrategia/meta/**: son archivos de este proyecto aportados por el Director y forman parte de la documentacion de la estrategia. Ambos incluidos en la entrega (I.3a regimen meta-proyecto).
- contexto_zai/ NO pertenece a este proyecto (es infraestructura del entorno): DENEGADA cualquier ubicacion de activos del proyecto en su interior.
- upload/ es solo punto de entrada de los aportes del Director, nunca destino final. Entregas via /download/ (R10 vigente).

## Requisitos vigentes sin cambios
R1-R5, R7, R9, R10, R11, con estos ajustes de lectura: R8 pasa a 10 archivos (premisa_respuesta.md como #1); R6 queda sustituido por R18.

## Criterios de aceptacion v1.2
1. premisa_respuesta.md existe en agent-context/ y es el archivo #1 del protocolo de arranque (10 archivos).
2. herramientas.md existe en agent-context/ (conciencia instrumental).
3. dcepi.md reescrito con los 5 elementos y sus subelementos; barrido global = 0 coincidencias de "Consenso -> Ejecucion -> Plan -> Inspeccion", DCPA y la taxonomia de 18 aspectos en todo el repo.
4. Barrido global = 0 coincidencias de la notacion [P]/[G]; solo palabras completas PRESCRIPTIVA / GUARDRAIL.
5. dcpa.md eliminado.
6. agent-learn con exactamente 4 archivos.
7. worklog_protocolo.md existe; worklog_template.md sin protocolo duplicado.
8. update_estrategia.ps1 con 1 repo/2 ramas, sincronizacion automatica de operativo y cabecera de ambito.
9. proyecto.md, entorno.md y prompt_arranque.md documentan el esquema de ramas.
10. Ambos PDF presentes en estrategia/meta/.
11. tareas_inmediatas unificado en una sola copia.
12. Gauntlet completo superado sobre el conjunto y diff cero en I.3d.
13. Entrega completa I.3a del meta-proyecto en /download/ con todos los archivos.
