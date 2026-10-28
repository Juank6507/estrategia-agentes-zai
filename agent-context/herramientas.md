# HERRAMIENTAS -- Conciencia instrumental

<!-- Ubicacion: estrategia/agent-context/herramientas.md
     Responde a la pieza 2 conciliada: el agente debe saber QUE herramientas tiene y COMO usarlas.
     Aqui vive la consulta de D.0 (recogida de contexto instrumental).
     Inventario generico del entorno Z.ai; no ligado a ninguna app concreta (ver preferencias_director.md). -->

## 1. Canal y persistencia

| Herramienta | Que es | Como se usa |
|---|---|---|
| **Chat con el Director** | Unico canal de comunicacion | Toda respuesta empieza por la frase de control; lenguaje natural (NH3, NH13) |
| **Worklog** | Memoria narrativa del proyecto (`worklog.md` en proyectos; `worklog_EP.md` en el meta-proyecto) | Leer al arrancar (continuidad); escribir una entrada por sesion (ver worklog_protocolo.md) |
| **upload/** | Punto de entrada de los aportes del Director (adjuntos) | Solo leer de ahi; NUNCA es destino de entrega |
| **download/** | Unica ruta de entrega (R10) | Todo lo que el Director deba descargar va ahi |

## 2. Sistema de archivos y ejecucion (sandbox Linux)

| Herramienta | Que es | Como se usa |
|---|---|---|
| **Sandbox** | Espacio de trabajo del agente en `/home/z/my-project/` | Ahi viven la estrategia, los proyectos y las entregas |
| **Lectura/escritura de archivos** | Ver, crear y editar archivos | Cambios quirurgicos por defecto (NH18); snapshot de regresion antes de intervenir (I.1) |
| **Terminal Linux (bash)** | Ejecutar comandos | Para git, pruebas, greps del Gauntlet; advertir lo exclusivo de Linux (NH17) |

## 3. Entorno Z.ai (contexto_zai/)

| Herramienta | Que es | Como se usa |
|---|---|---|
| **contexto_zai/** | Documentacion y utilidades del entorno Z.ai (manuales, pipeline, scripts, tests) | Es INFRAESTRUCTURA DEL ENTORNO, no del proyecto: se consulta, no se modifica como activo del proyecto y no recibe archivos de la estrategia (ubicacion denegada por el Director) |
| **Manuales CZAI** | `contexto_zai/Documentos/MANUAL_CZAI_*.md` | Consulta cuando una capacidad del entorno no este clara |

## 4. Capacidades de IA del backend (SDK)

Se invocan desde codigo del lado servidor (nunca desde el cliente):

| Capacidad | Uso tipico |
|---|---|
| **LLM** | Generacion de texto, conversacion |
| **VLM** | Comprension de imagenes y documentos |
| **Image Generation / Image Edit** | Crear o editar imagenes |
| **TTS / ASR** | Voz a texto y texto a voz |
| **Web Search / Page Reader** | Buscar en la web y extraer contenido de paginas |
| **Video (analisis/generacion)** | Entender o producir video |

## 5. Desarrollo web (si el proyecto lo requiere)

| Herramienta | Uso |
|---|---|
| **Next.js 16 + TypeScript** | Framework obligatorio del entorno; App Router |
| **Prisma (SQLite)** | Base de datos; schema en prisma/, cliente en lib |
| **shadcn/ui + Tailwind 4** | Componentes de interfaz ya existentes en src/components/ui |
| **Dev server** | Puerto 3000; logs en dev.log; nunca construir sin orden |
| **Gateway (XTransformPort)** | Peticiones a otros puertos via query `?XTransformPort=N`; rutas relativas |
| **Mini-servicios** | Servicios independientes (p. ej. websocket) en mini-services/ con puerto propio |

## 6. Versiones y entrega

| Herramienta | Uso |
|---|---|
| **git** | Repos de estrategia y de proyectos; el push a GitHub lo ejecuta el Director (I.3c) |
| **GitHub** | Repo unico `estrategia-agentes-zai` con 2 ramas: main (completa) y operativo (compacta para agentes de proyecto) |
| **update_estrategia.ps1** | Script del Director (Windows): reemplazo total desde .zip + push a main + sync automatico de operativo. Exclusivo del meta-proyecto |
| **.zip de entrega** | En download/; meta-proyecto: SIEMPRE completo; proyectos: solo modificados (salvo tests E2E) |

## 7. Regla instrumental (D.0)

Al arrancar (y cuando un supuesto real lo exija), el agente debe poder responder sin dudar:
1. Que canales tiene (chat, worklog, upload/download).
2. Que puede ejecutar (archivos, terminal, git).
3. Que capacidades IA y de entorno tiene y donde se documentan.
4. Que NO puede hacer: entregar fuera de download/, push desde el sandbox (NH5 con su excepcion de estrategia), tocar contexto_zai como activo propio, actuar sin autorizacion (NH8, salvo auto-recuperacion).

## 8. Recuperacion de contexto (herramienta documentada, v1.3)

La herramienta de recuperacion de contexto es 100% por ficheros y no depende de la memoria del LLM. Es la misma para cualquier agente y cualquier proyecto:

| Paso | Accion |
|---|---|
| 1 | Emitir `[ESTADO: RECUPERACION]` (no requiere permiso: unica excepcion de NH8) |
| 2 | Ejecutar la Recuperacion Espontanea de `premisa_respuesta.md` (en la RAIZ de la estrategia), seccion 3 |
| 3 | Releer el worklog del proyecto: la cola (ultima entrada + marcador de sesion) y la cabecera de estrategia (bloque de Regla Conductual Minima con la ruta de la premisa) |
| 4 | Verificar continuidad (worklog_protocolo.md, Fase de Apertura): ultima entrada = sesion anterior a la actual |
| 5 | Reemitir la frase de control y continuar la tarea desde donde el worklog indica |

**Sobre la compresion de contexto:** la perdida de contexto por compresion es INVISIBLE para el agente (percibe continuidad, no arranque). El disparador correcto no es "sentir el corte": es NO poder emitir la frase de control, o que el registro del worklog no cuadre. Ante cualquiera de las dos senales, ejecutar esta seccion sin pedir permiso.

**Via de escalado (si la recuperacion falla):** si los ficheros de recuperacion no estan disponibles (estrategia ausente, worklog truncado, clon imposible), el agente NO improvisa y NO toca nada: informa al Director con el diagnostico exacto (que fichero falta, que se intento, que resultado dio) y espera instruccion. Si un proceso externo falla (p. ej. contexto_zai), su reparacion es competencia del Director o del proyecto propietario del proceso: el agente documenta el fallo y escala; no lo repara ni lo rodea.
