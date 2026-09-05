# WORKLOG

<!-- ╔══════════════════════════════════════════════════════════════╗ -->
<!-- ║  SECCIÓN DE ESTRATEGIA — PROHIBIDO MODIFICAR             ║ -->
<!-- ║  Todo lo que está por encima de "--- ENTRADAS ---" es de    ║ -->
<!-- ║  solo lectura. Los agentes NO deben tocar esta sección.    ║ -->
<!-- ╚══════════════════════════════════════════════════════════════╝ -->

Al iniciar sesión, Z.ai te indicó que leyeras este archivo. Eso ya lo has hecho. Ahora sigue estas instrucciones:

**Paso 1 — Obtener los archivos de estrategia**

Si `/home/z/my-project/estrategia/` no existe, clona el repositorio:
```
git clone https://github.com/Juank6507/estrategia-agentes-zai.git /home/z/my-project/estrategia/
```
Si ya existe, actualízalo:
```
cd /home/z/my-project/estrategia/ && git pull
```

**Paso 2 — Leer los archivos de entorno y proyecto**

Lee desde `/home/z/my-project/estrategia/agent-context/`:
1. `entorno.md` — rutas, reglas de entrega, compatibilidad, naturaleza del código.
2. `proyecto.md` — URL del repositorio del proyecto, ramas, agentes. Si el repositorio del proyecto no existe localmente, clónalo en la ruta indicada.

**Paso 2b — Instalar y activar el proceso de recuperación de contexto**

El proceso de recuperación de contexto permite al agente recuperar la memoria de sesiones largas cuando la plataforma comprime su ventana de contexto. Debe instalarse en la primera sesión del proyecto y mantenerse activo durante toda la vida del proyecto.

**Instalación (si no existe):**

Si `/home/z/my-project/contexto_zai/` no existe, clona el repositorio:
```
git clone https://github.com/Juank6507/contexto_zai.git /home/z/my-project/contexto_zai/
```

Si ya existe, actualízalo:
```
cd /home/z/my-project/contexto_zai/ && git pull
```

**Verificación de que el proceso funciona:**

Ejecuta los tests del proceso:
```
cd /home/z/my-project && python tests/run_all_tests.py
```
Si todos los tests pasan, el proceso está listo.

**Activación del proceso:**

El proceso se activa cuando el agente detecta pérdida de contexto o cuando el Director lo indica explícitamente. Para activarlo:

1. El `chat_id` viene en los metadatos del gateway (campo `chat_id` en el JSON de IM Chat Context de cada mensaje).
2. El JWT del Director se obtiene una sola vez siguiendo la metodología documentada en `/home/z/my-project/contexto_zai/metodologia_descubrimiento_jwt.md` (o en el repositorio del proyecto).
3. El proceso se activa con:
   ```python
   from contexto_zai.pipeline import run
   from contexto_zai.models import DetectionTrigger
   result = run(
       chat_id="<chat_id_del_gateway>",
       jwt="<jwt_del_director>",
       trigger=DetectionTrigger.EXPLICITO,
       reason="Activación del proceso",
   )
   ```

**Archivos generados:**

El proceso genera los siguientes archivos en `/home/z/my-project/contexto_recuperacion/`:
- `00_estado_actual.md` — contexto completo del tema activo (8 secciones D1-D4 + A1-A4).
- `01_indice_recuperacion.md` — mapa de temas y en qué bloque está cada uno.
- `02_decisiones_clave.md` — decisiones reales tomadas por el Director con contexto.
- `bloque_01.md` a `bloque_NN.md` — bloques temáticos con el contenido del chat.
- `_metadata.json` — metadata del proceso (chat_id, share_id, ultimo_timestamp, temas).

Copia idéntica en `/home/z/my-project/download/contexto_recuperacion/` para que el Director pueda descargar los archivos.

**Disparadores de activación:**

El proceso se activa cuando:
- El Director dice "relee el worklog", "perdiste contexto", o cualquier reclamo de incoherencia.
- El agente detecta frases del Director como "ya te dije", "no repitas", "estás olvidando".
- El agente estima que ha consumido el 90% de su capacidad de contexto.
- El agente no puede responder a las auto-preguntas tras una entrega relevante.
- El Director lo activa explícitamente.

**Después de la activación:**

Si el proceso ya estaba instalado en una sesión anterior, los archivos de recuperación ya existen en `/home/z/my-project/contexto_recuperacion/`. En ese caso:
1. Lee `00_estado_actual.md` para saber dónde quedaste.
2. Lee `01_indice_recuperacion.md` para saber qué temas hay y en qué bloque están.
3. Si necesitas detalle de un tema, lanza un subagente con `Task` que lea el bloque y responda una pregunta concreta. No leas los bloques directamente (gastan tu memoria).

**Paso 3 — Leer los archivos de contexto**

Lee estos archivos desde `/home/z/my-project/estrategia/agent-context/`:
1. `identidad.md`
2. `contrato.md`
3. `comunicacion.md`
4. `dcpa.md`

**Paso 4 — Leer los archivos de aprendizaje**

Lee todos los archivos de `/home/z/my-project/estrategia/agent-learn/` si la carpeta existe y tiene contenido.

**Paso 5 — Identificar tu identidad y sesión**

Lee `proyecto.md` para identificar qué agente eres (APA o MB). Lee la última entrada de sesión en este worklog (debajo de `--- ENTRADAS ---`) para obtener el número de sesión anterior. Tu sesión es esa + 1.

**Paso 6 — Internalizar el aprendizaje**

Revisa los archivos de `agent-learn/`. Si hay alguna entrada relevante para el tipo de tarea que vas a realizar, menciónala en tu primera respuesta al Director. No es un formulario: es procesar la experiencia previa para aplicarla.

**Paso 7 — Emitir la frase de detección**

Al inicio de tu primera respuesta, escribe exactamente este bloque:

> Configuración cargada.
> - Estrategia: clonada y leída
> - Contexto: identidad, contrato, comunicación, dcpa, entorno, proyecto
> - Aprendizaje: errores, experiencias, preferencias
> - Proyecto: clonado en [ruta del proyecto]
> - Sesión: [número]
> - Agente: [APA o MB]
> - Modo de comunicación: lenguaje natural sin tecnicismos

No modifiques este formato. No lo antecedas de nada. Es lo primero que escribes.

**Paso 8 — Protección de este archivo**

- **NUNCA** uses la herramienta Write en este archivo (worklog.md).
- Cuando necesites añadir tu entrada de sesión, usa **solo** la herramienta Edit para **insertar contenido nuevo** **por debajo** de la línea `--- ENTRADAS ---`.
- **NUNCA** modifiques, borres ni muevas nada que esté por encima de esa línea.
- Si necesitas actualizar tu aprendizaje, hazlo en `/home/z/my-project/estrategia/agent-learn/` y luego `git add, commit, push`.

<!-- ╔══════════════════════════════════════════════════════════════╗ -->
<!-- ║  FIN DE LA SECCIÓN DE ESTRATEGIA                           ║ -->
<!-- ╚══════════════════════════════════════════════════════════════╝ -->

--- ENTRADAS ---

(Cada entrada de sesión usa este formato:
### [YYYY-MM-DD] — Sesión N — [Agente]
- **Tarea:** lo que se pidió
- **Qué se hizo:** resumen ejecutivo
- **Archivos modificados:** lista
- **Pendiente:** lo que quedó abierto (si hay)

Al final de cada entrada, incluir siempre: `<!-- sesión: N -->`)
<!-- sesión: 0 -->
