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

**Paso 2a — Cargar el proceso contexto_zai (CZAI)**

El proceso de recuperación de contexto es la herramienta del agente. Debe estar cargado antes de continuar. Sigue estos pasos:

1. **Verifica si el proceso ya está cargado:**
   ```bash
   ls /home/z/my-project/contexto_zai/__init__.py 2>/dev/null && echo "CZAI presente" || echo "CZAI no presente"
   ```

2. **Si no está presente, clona el repositorio:**
   ```
   git clone https://github.com/Juank6507/contexto_zai.git /home/z/my-project/contexto_zai/
   ```
   Si ya existe, actualízalo:
   ```
   cd /home/z/my-project/contexto_zai/ && git pull
   ```

3. **Verifica que el sandbox tenga los endpoints CZAI** (la página `/` con el bridge del JWT):
   ```bash
   curl -s http://localhost:3000/api/czai/jwt-status | python3 -c "import sys,json; print(json.load(sys.stdin).get('needs_jwt', 'sin respuesta'))"
   ```
   - Si responde `true` o `false`: el sandbox ya tiene los endpoints CZAI. Continúa al Paso 2b.
   - Si no responde o da error: el sandbox no tiene los endpoints. Ejecuta el setup:
     ```bash
     bash /home/z/my-project/contexto_zai/setup-czai.sh
     ```
     Esto crea los endpoints, el componente y la página en el sandbox Next.js.

4. **Verifica que el dev server esté corriendo** (puerto 3000):
   ```bash
   curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/
   ```
   - `200` → correcto.
   - Si no responde, revisa `/home/z/my-project/dev.log` y reinicia si es necesario.

**Paso 2b — Obtener el JWT del Director (v4.2)**

El agente necesita el JWT del Director para acceder a la API de Z.ai. Sigue estos pasos:

1. **Verifica si ya hay JWT disponible:**
   ```python
   from contexto_zai.client.credential_manager import CredentialManager
   cm = CredentialManager()
   if cm.get_jwt():
       print("JWT disponible")
   else:
       print("JWT no disponible")
   ```

2. **Si no hay JWT, pídele al Director que instale el bookmarklet y lo ejecute:**
   - Dile al Director: "Necesito conectar tu sesión de Z.ai con este sandbox. Ve a la página del sandbox (la que se abre en el Preview Panel), descarga el instalador (.bat), haz doble clic, y luego haz clic en el favorito 'Conectar CZAI' desde cualquier chat de chat.z.ai."
   - El Director descarga `czai-installer.bat` del sandbox.
   - El Director hace doble clic en el .bat. El instalador agrega el favorito "Conectar CZAI" en su navegador.
   - El Director va a chat.z.ai, abre cualquier chat, y hace clic en el favorito "Conectar CZAI".
   - El bookmarklet lee la sesión del Director y envía el JWT al sandbox. El sandbox lo guarda en `~/.czai/credentials.json`.

3. **Verifica que el JWT llegó:**
   ```python
   from contexto_zai.client.credential_manager import CredentialManager
   cm = CredentialManager()
   jwt = cm.get_jwt()
   if jwt:
       print(f"JWT recibido: {jwt[:20]}...")
   else:
       print("JWT no disponible todavía. Pídele al Director que ejecute el bookmarklet.")
   ```

4. **Cuando el JWT esté en `~/.czai/credentials.json`, continúa con el Paso 2c.** El JWT no expira, así que esto se hace una sola vez en la vida del proyecto.

**Paso 2c — Cómo usar el proceso (IMPORTANTE: no confundir las funciones)**

El proceso contexto_zai tiene varias funciones. Es crítico que uses la correcta según lo que necesites:

**1. `pipeline.run()` — Recuperar el contexto del chat de Z.ai**

Esto extrae los mensajes del chat de Z.ai (usando el JWT del Director), los clasifica por temas, y genera los archivos de recuperación. Úsalo cuando:
- Pierdes contexto (la plataforma comprimió tu ventana).
- El Director dice "relee el worklog", "perdiste contexto", "ya te dije".
- Necesitas saber dónde quedaste y qué sigue.

```python
from contexto_zai.pipeline import run
from contexto_zai.models import DetectionTrigger
result = run(
    chat_id="<chat_id_del_gateway>",  # viene en los metadatos del gateway
    jwt="<jwt_del_director>",          # está en ~/.czai/credentials.json
    trigger=DetectionTrigger.EXPLICITO,
    reason="Recuperación de contexto",
)
# Si result.pending_tasks no está vacío, lanza los subagentes con el Task tool
# usando los prompts de result.pending_tasks, y después llama a collect_responses().
if result.pending_tasks:
    from contexto_zai.pipeline import collect_responses
    # Lanzar subagentes con Task tool (uno por tarea, o en paralelo)
    # Cada subagente escribe su respuesta en _responses/{task_id}.txt (o .json, o texto plano)
    # Después:
    applied = collect_responses()
```

**2. `ampliar_contexto()` — Ampliar el contexto desde una fuente externa**

Esto procesa un documento o URL que el Director te entrega (un PDF, un archivo de texto, una URL pública) y lo incorpora al contexto como nuevos bloques. Úsalo cuando:
- El Director te da un link o un archivo para que lo incorpores al contexto.
- El Director dice "actualiza el contexto desde este documento" o "amplía el contexto desde aquí".

```python
from contexto_zai.pipeline import ampliar_contexto
result = ampliar_contexto(
    source_type="url",           # o "file"
    source_path="https://...",   # la URL o ruta al archivo
    workspace_dir="/home/z/my-project/contexto_recuperacion",
)
# Si el archivo es pequeño: result["needs_agent_read"] = True (lo lees tú directo)
# Si es grande: result["pending_tasks"] (lanzas subagentes y llamas collect_responses())
```

**NOTAS IMPORTANTES:**
- `pipeline.run()` extrae del **chat de Z.ai**. Necesita el `chat_id` y el JWT.
- `ampliar_contexto()` procesa una **fuente externa** (URL o archivo). No necesita el chat_id.
- **No las confundas.** Si el Director te da un link externo, usa `ampliar_contexto()`. Si perdiste contexto del chat, usa `pipeline.run()`.
- Si el Director te da un Google Doc privado, `ampliar_contexto()` fallará con 401. Pídele que lo haga público (Compartir → Cualquiera con el enlace) o que lo descargue como archivo (.docx o .pdf) y lo suba al sandbox en `/home/z/my-project/upload/`. Después usa `ampliar_contexto(source_type="file", source_path="/home/z/my-project/upload/archivo")`.

**3. `query_context()` — Consultar el contexto recuperado**

Cuando ya tienes el contexto recuperado y necesitas detalle de un tema específico sin gastar tu ventana de contexto:

```python
from contexto_zai.pipeline import query_context
result = query_context(
    question="¿Qué se decidió sobre JWT?",
    workspace_dir="/home/z/my-project/contexto_recuperacion",
)
# result["prompts"] contiene los prompts para lanzar subagentes que leerán los bloques
# Lanza los subagentes con Task tool, y llama a collect_responses() para recibir la respuesta.
```

**4. `collect_responses()` — Recoger las respuestas de los subagentes**

Después de lanzar subagentes con el Task tool (para D4, decisiones, nombres, consultas, o ampliación), los subagentes escriben sus respuestas en archivos dentro de `_responses/`. Llama a esta función para que el proceso las lea, las integre a los archivos de recuperación, y te devuelva el resultado estructurado:

```python
from contexto_zai.pipeline import collect_responses
result = collect_responses()
# result["total_aplicadas"] = número de respuestas integradas
# Los archivos 00_estado_actual.md, 02_decisiones_clave.md, _metadata.json se actualizan.
```

Los subagentes pueden escribir en cualquier formato: `.txt`, `.json`, o texto plano. El proceso los reconoce automáticamente. Cada subagente debe escribir su respuesta en un archivo llamado `_responses/{task_id}.txt` (o `.json`), donde `task_id` es el identificador de la tarea que viene en `pending_tasks`.

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
> - Proceso CZAI: cargado en /home/z/my-project/contexto_zai/ (endpoints activos, JWT [disponible|pendiente])
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
