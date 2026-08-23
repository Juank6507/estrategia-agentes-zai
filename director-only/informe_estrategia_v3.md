# INFORME: ESTRATEGIA DE TRABAJO CON AGENTES EN Z.AI

**Versión:** 3.0
**Fecha:** 2025-07-11
**Autor:** Director

---

## 1. El problema que resuelve esta estrategia

Cuando trabajás con un agente de IA en Z.ai, hay un problema fundamental: **el agente no recuerda nada de sesiones anteriores.** Cada vez que abrís un agente nuevo, empieza de cero. No sabe quién sos, qué reglas seguir, ni en qué punto quedó el proyecto.

Para empeorar las cosas, Z.ai tiene limitaciones importantes:

- No podés configurar un System Prompt personalizado que se recargue solo
- No hay forma de cargar archivos automáticos al abrir un agente
- No hay persistencia del worklog entre agentes (cada agente nuevo empieza con el worklog vacío)
- No hay Skills configurables ni servidores MCP

Sin una estrategia, cada sesión es como empezar un proyecto nuevo con un programador que no conoce nada del trabajo anterior. Perdés tiempo explicando contexto, repitiendo instrucciones y corrigiendo comportamientos que ya habías alineado.

Esta estrategia resuelve eso. Convierte cada agente nuevo en un colaborador que ya sabe cómo trabajar con vos, qué reglas seguir, y qué se hizo antes.

---

## 2. La idea central

La estrategia se basa en un mecanismo muy simple:

**Z.ai obliga a cada agente a leer un archivo llamado `worklog.md` al iniciar.** Es la única cosa que se garantiza que el agente lea automáticamente, porque está programado en el System Prompt de la plataforma.

Si vos, como Director, asegurás que ese archivo contiene las instrucciones de estrategia arriba del todo, el agente las leerá sin que nadie se lo pida.

Es como si pudieras escribir en la pizarra antes de que entre el empleado. Cuando entra, lo primero que hace es leer la pizarra, y ahí están las reglas.

La única acción que necesitás hacer al abrir un agente nuevo es **pegar el worklog** del agente anterior (o el template si es la primera vez) en el worklog del nuevo agente. Eso es todo. Un copia y pega, y el agente se autoconfigura.

---

## 3. Cómo funciona en la práctica

### Lo que hacés al abrir un nuevo agente

1. **Pegás el worklog** — Copiás el contenido del worklog de la sesión anterior (o el template si es la primera vez) y lo pegás en el worklog del nuevo agente. Es la única acción que hacés.

2. **Esperás la frase de detección** — El agente, al leer el worklog, encuentra las instrucciones de estrategia y ejecuta una cadena automática de acciones. Al terminar, escribe una frase específica que te confirma que todo salió bien.

3. **Verificás (opcional)** — Si querés estar seguro, pegás una pregunta de verificación de una línea. El agente te responde confirmando qué archivos leyó.

4. **Dás la tarea** — Listo. El agente ya sabe quién sos, cómo trabajar con vos, y tiene el contexto del proyecto.

### Lo que hace el agente automáticamente

Cuando el agente lee el worklog, encuentra una serie de pasos que ejecuta en orden:

**Paso 1: Clona el repositorio de estrategia**

El agente clona (o actualiza si ya existe) un repositorio **público** de GitHub que contiene todos los archivos de configuración. Este repositorio es pequeño — solo tiene dos carpetas con instrucciones.

> **Importante:** El repositorio debe ser público. El agente trabaja en un sandbox sin credenciales de GitHub, por lo que no puede clonar repositorios privados.

**Paso 2: Lee workspace.md y obtiene el proyecto**

El agente lee un archivo que le dice dónde está el repositorio del proyecto en el que va a trabajar (por ejemplo, Model Broker). Si ese repositorio no está clonado localmente, lo clona.

**Paso 3: Lee los archivos de contexto**

El agente lee una serie de archivos cortos que definen su comportamiento:

- **identidad.md** — Quién es y para quién trabaja
- **contrato.md** — Las 20 reglas de lo que NUNCA debe hacer, lo que SIEMPRE hace, y la checklist de entrega
- **comunicacion.md** — Cómo hablarle (lenguaje natural, sin tecnicismos innecesarios)
- **dcpa.md** — El protocolo de trabajo: Diagnosticar, Planificar, Consensuar, Autorizar, Ejecutar
- **.agent-learn/** — Carpeta con lo que fue aprendiendo en sesiones anteriores (técnicas que funcionaron, errores comunes, tus preferencias)

**Paso 4: Emite la frase de detección**

Al iniciar su primera respuesta, el agente escribe exactamente:

> He leído integramente nuestro contrato de actuación y estoy listo para entregate una respuesta en lenguaje natural sin tecnisismos y en el mismo lenguaje en el que me preguntas.

Esta frase es tu semáforo. Si la escribe, todo funcionó. Si no la escribe o la escribe distinta, algo falló.

**Paso 5: Protege el worklog**

El agente sabe que la sección de estrategia del worklog es intocable. Solo puede escribir entradas nuevas por debajo de la línea `--- ENTRADAS ---`, usando la herramienta Edit (nunca Write).

### ¿Qué pasa si el agente pierde el contexto durante la sesión?

A medida que la conversación se alarga, Z.ai comprime los mensajes antiguos para hacer espacio. El agente puede "olvidar" las reglas que leyó al inicio. Lo notás cuando empieza a hablar con tecnicismos, se salta el protocolo, o no emite la frase.

La solución son tres palabras: **"relee el worklog"**.

El agente re-lee el worklog, re-ejecuta toda la cadena de arranque, y vuelve a estar alineado.

---

## 4. Los archivos explicados

La estrategia tiene dos grupos de archivos: los que usa el agente (viven en GitHub) y los tuyos como Director (viven en tu PC).

### Archivos del agente (en el repositorio de GitHub)

Estos son los que el agente lee al iniciar sesión. Los editás en tu PC y los subís con git push. El próximo agente los recibe con git pull.

| Archivo | Para qué sirve | Cuándo lo tocás |
|---|---|---|
| `.agent-context/identidad.md` | Define quién es el agente y que reporta a vos | Casi nunca — es genérico |
| `.agent-context/contrato.md` | Las 20 reglas NH, lo que siempre hace, la checklist de entrega | Cuando querás agregar o quitar una regla |
| `.agent-context/comunicacion.md` | Cómo debe hablarle al Director y a otros destinatarios | Rara vez — es genérico |
| `.agent-context/dcpa.md` | El protocolo de 5 fases para cualquier cambio de código | Nunca — es el protocolo estándar |
| `.agent-context/workspace.md` | Rutas, carpeta de entrega, URL del repo del proyecto | **Cuando cambies de proyecto** |
| `.agent-learn/experiencias.md` | Lo que el agente fue aprendiendo que funciona | No lo tocás vos — lo escribe el agente |
| `.agent-learn/errores_comunes.md` | Errores que el agente detectó y no quiere repetir | No lo tocás vos — lo escribe el agente |
| `.agent-learn/preferencias_director.md` | Tus preferencias que el agente fue observando | No lo tocás vos — lo escribe el agente |

Los archivos `.agent-learn/` son la memoria evolutiva. El agente los actualiza al final de cada sesión y hace git push. Así el próximo agente hereda lo que el anterior aprendió.

### Archivos del Director (en tu PC, NO suben a GitHub)

| Archivo | Para qué sirve |
|---|---|
| `worklog_template.md` | La plantilla del worklog con la sección de estrategia. Es lo que pegás en el worklog del nuevo agente la primera vez |
| `estrategia_trabajo_agentes_v3.md` | Documento técnico de referencia |
| `informe_estrategia_v3.md` | Este informe que estás leyendo |
| `prompt_templates.md` | Plantillas de prompt para dar tareas según el tipo |
| `prompt_inicio_sesion.txt` | La pregunta de verificación de una línea |

---

## 5. Las tres capas que gobiernan al agente

El comportamiento del agente está determinado por tres capas, en orden de prioridad:

**1. El System Prompt de Z.ai (la plataforma)**

Es lo que Z.ai inyecta automáticamente. Incluye instrucciones sobre herramientas, formato de código, y la orden de leer y escribir el worklog. Vos no controlás esto, pero lo aprovechás: sabés que el agente va a leer el worklog.

**2. Los archivos en disco (tu estrategia)**

Son los archivos del repositorio de estrategia que el agente clona y lee. Acá está tu contrato de trabajo, tus reglas, tu protocolo. Esto es lo que hace que cada agente trabaje como vos querés.

**3. El prompt del Director (la tarea)**

Es lo que escribís en el chat después de que el agente cargó el contexto. Acá das la tarea específica: corregí este bug, agregá esta funcionalidad, etc.

La clave es que las capas 1 y 2 se cargan solas. Vos solo operás en la capa 3.

---

## 6. El protocolo DPCA

Cualquier trabajo que implique modificar código sigue un protocolo de 5 fases. No es burocracia — es protección:

1. **Diagnóstico** — El agente identifica el problema y te lo explica en lenguaje claro. Te dice qué archivos están afectados.

2. **Plan** — El agente propone qué va a hacer, archivo por archivo, con el impacto esperado.

3. **Consenso** — Vos revisás el plan. Si algo no te gusta, lo ajustás. Si hay una decisión de arquitectura importante, se negocia.

4. **Autorización** — Vos das la orden explícita: "hacelo". Nada se toca sin tu permiso.

5. **Ejecución** — El agente implementa, prueba, y entrega. Solo entrega cuando todo funciona.

Hay excepciones: preguntas informativas, investigaciones y tareas de documentación no requieren DPCA porque no se modifica nada.

---

## 7. Las reglas NH (Nunca Hacer)

Son 20 reglas que el agente nunca puede violar. Las más importantes:

- **NH1:** No corregir un bug sin diagnóstico y consenso previo
- **NH2:** No entregar código que no fue probado
- **NH3:** No hablarte en lenguaje técnico innecesario
- **NH4:** No pedite que edites código o ejecutes scripts
- **NH5:** No hacer git push del código del proyecto (solo del .agent-learn/ de estrategia)
- **NH8:** No actuar sin tu autorización
- **NH18:** No reescribir un archivo completo cuando bastan cambios quirúrgicos
- **NH19:** No ejecutar cambios sin verificar que no se rompe algo existente
- **NH20:** No modificar la sección de estrategia del worklog

Cuando el agente viola una regla NH, le indicás el código (ejemplo: "NH3") y corrige sin explicación adicional.

---

## 8. La carpeta de entrega

Todo lo que el agente entrega va a `/home/z/my-project/download/`. Cada archivo incluye en la primera línea un comentario con su ubicación destino en el proyecto. Al entregar, el agente incluye una tabla que mapea cada archivo entregado a dónde va.

Vos descargás los archivos de esa carpeta y los colocás en tu proyecto.

---

## 9. La memoria de aprendizaje

La carpeta `.agent-learn/` es lo más valioso a largo plazo. Tiene tres archivos:

- **experiencias.md** — Técnicas que funcionaron bien. Por ejemplo: "Para refactoring, usar diff quirúrgico en lugar de reescribir el archivo completo."
- **errores_comunes.md** — Errores que el agente cometió o detectó. Por ejemplo: "No usar rutas con / directo, usar os.path.join()."
- **preferencias_director.md** — Patrones que el agente observó en tus decisiones. Por ejemplo: "El Director prefiere que le explique qué cambió, no cómo se implementó."

Estos archivos crecen sesión a sesión. El agente los actualiza y hace git push al final. El próximo agente los hereda. Con el tiempo, el agente se vuelve más alineado con tu forma de trabajar sin que tengas que repetir instrucciones.

---

## 10. Qué hacés cuando cambias de proyecto

Los archivos de estrategia (`.agent-context/`) son genéricos — sirven para cualquier proyecto. Lo único que cambia es:

1. **workspace.md** — Actualizás la URL del repositorio del proyecto, la rama, y la ruta de clonado
2. **.agent-learn/** — Limpiás las entradas que no apliquen al nuevo proyecto (o las dejás si son genéricas)
3. **El worklog** — El estado del proyecto anterior queda en las entradas. Cuando el worklog se ponga muy largo, podés empezar uno nuevo con solo la sección de estrategia y las entradas recientes

Git push, y listo. El próximo agente trabaja en el nuevo proyecto.

---

## 11. Cómo se recupera un agente desalineado

Hay tres niveles de recuperación:

**Nivel 1 — Pérdida de contexto en la sesión**

El agente empieza a hablar con tecnicismos o se salta el protocolo.
→ Decís: **"relee el worklog"**
→ El agente re-ejecuta la cadena de arranque y vuelve a estar alineado.

**Nivel 2 — El agente no emitió la frase de detección al inicio**
→ Decís: **"relee el worklog"**
→ Si responde con la frase correcta, se alineó. Si no, pasás al nivel 3.

**Nivel 3 — El worklog se corrompió**
→ Copiás el contenido de `worklog_template.md` y lo pegás en el worklog
→ Abrís un agente nuevo

---

---

# RESUMEN COMPLETO DE LA ESTRATEGIA DE ACTUACIÓN

## La regla de oro

**El worklog es el bootstrap. Los archivos en el repositorio SON el contrato. El prompt inicial es una verificación.**

## El antes y el después

| | Sin estrategia | Con estrategia v3.0 |
|---|---|---|
| **Inicio de sesión** | Pegás instrucciones largas | Pegás el worklog del agente anterior (1 copia y pega) |
| **Carga de contexto** | Manual, tediosa, incompleta | Automática: el agente clona, lee y se configura solo |
| **Reglas de comportamiento** | Se pierden cada sesión | Persisten en el repo de GitHub |
| **Estado del proyecto** | Lo explicás de nuevo | Está en las entradas del worklog |
| **Aprendizaje entre sesiones** | No existe | El agente aprende y lo persiste en .agent-learn/ |
| **Recuperación de contexto** | No hay mecanismo | "relee el worklog" (3 palabras) |

## Lo que hace el Director en cada sesión

| Momento | Acción |
|---|---|
| Abrir nuevo agente | Pegar el worklog (anterior o template) en el worklog del nuevo agente |
| Verificar (opcional) | Pegar la pregunta de verificación de 1 línea |
| Dar tarea | Escribir el prompt con lo que necesitás |
| Durante la sesión | Si el agente se desalinea, decir "relee el worklog" |
| Si hay un error NH | Indicar el código (ej: "NH3") y el agente corrige |
| Al cambiar de proyecto | Actualizar workspace.md con la nueva URL del repo y hacer git push |

## Lo que hace el agente en cada sesión

| Momento | Acción |
|---|---|
| Al iniciar | Lee el worklog (por instrucción del System Prompt de Z.ai) |
| Cadena de arranque | Clona repo estrategia → lee workspace.md → clona repo proyecto → lee .agent-context/* → lee .agent-learn/ |
| Primera respuesta | Escribe la frase de detección |
| Al recibir tarea | Ejecuta DPCA si implica modificar código |
| Al entregar | Deja archivos en /download/ con tabla de destino |
| Al finalizar | Si aprendió algo, actualiza .agent-learn/ y hace git push |
| Al cerrar | Escribe su entrada de sesión en el worklog (debajo de --- ENTRADAS ---) |

## Archivos que suben a GitHub (repo de estrategia)

```
estrategia-agentes-zai/
├── .agent-context/
│   ├── identidad.md          ← Quién es el agente (8 líneas)
│   ├── contrato.md           ← 20 reglas NH + siempre-hago + checklist (68 líneas)
│   ├── comunicacion.md       ← Cómo comunicarse (28 líneas)
│   ├── dcpa.md               ← Protocolo DPCA de 5 fases (58 líneas)
│   └── workspace.md          ← Entorno, rutas, repo del proyecto (44 líneas)
└── .agent-learn/
    ├── experiencias.md       ← Lo que funcionó (el agente escribe aquí)
    ├── errores_comunes.md    ← Lo que hay que evitar (el agente escribe aquí)
    └── preferencias_director.md  ← Tus preferencias (el agente escribe aquí)
```

## Archivos del Director (en tu PC, NO suben a GitHub)

```
director-only/
├── worklog_template.md               ← Plantilla para pegar en el worklog del nuevo agente
├── estrategia_trabajo_agentes_v3.md  ← Documento técnico de referencia
├── informe_estrategia_v3.md          ← Este informe
├── prompt_templates.md               ← Plantillas de prompt por tipo de tarea
└── prompt_inicio_sesion.txt          ← Pregunta de verificación (1 línea)
```

## Cadena de arranque completa

```
1.  Director abre nuevo agente en Z.ai
2.  Director pega el worklog (anterior o template)
3.  System Prompt de Z.ai indica al agente que lea el worklog
4.  Agente lee worklog → encuentra sección de estrategia
5.  Agente clona/actualiza repo de estrategia
6.  Agente lee workspace.md → clona/actualiza repo del proyecto
7.  Agente lee .agent-context/* y .agent-learn/*
8.  Agente emite frase de detección
9.  [Opcional] Director pega pregunta de verificación (1 línea)
10. Director verifica → contexto OK
11. Director da la tarea
12. Agente ejecuta DPCA si aplica
13. Agente trabaja, itera con el Director
14. Agente entrega en /download/
15. Agente actualiza .agent-learn/ si aprendió → git push
16. Agente escribe entrada de sesión en el worklog
17. Sesión termina
```

## Recuperación de contexto

```
Señal: el agente no emite la frase, o la emite alterada, o usa tecnicismos
    ↓
Director dice: "relee el worklog"
    ↓
Agente re-lee worklog → re-ejecuta cadena → contexto recuperado
```

## Las 3 capas de control

```
Capa 1: System Prompt de Z.ai (no controlás)  → garantiza que el agente lee el worklog
Capa 2: Archivos en disco (controlás vos)       → definen reglas, protocolo, comportamiento
Capa 3: Prompt del Director (controlás vos)     → la tarea específica de la sesión
```

## La triple protección del worklog

```
1. El propio worklog dice que la sección de arriba es inalterable
2. La regla NH20 en contrato.md prohíbe modificarla
3. El Paso 5 del worklog repite la prohibición
```

Si a pesar de todo el agente la pisa, el Director reemplaza el worklog desde el template.
