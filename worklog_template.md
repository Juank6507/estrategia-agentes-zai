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

El proceso contexto_zai es una herramienta de trabajo que te ayuda a recuperar y ampliar contexto. Debe estar cargado al inicio de cada sesión. Sigue estos pasos:

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

3. **Verifica que el sandbox tenga los endpoints CZAI:**
   ```bash
   curl -s http://localhost:3000/api/czai/jwt-status | python3 -c "import sys,json; print(json.load(sys.stdin).get('needs_jwt', 'sin respuesta'))"
   ```
   - Si responde `true` o `false`: el sandbox ya tiene los endpoints. Continúa al Paso 2b.
   - Si no responde o da error: ejecuta el setup:
     ```bash
     bash /home/z/my-project/contexto_zai/setup-czai.sh
     ```

4. **Verifica que el dev server esté corriendo** (puerto 3000):
   ```bash
   curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/
   ```
   - `200` → correcto. Si no responde, revisa `/home/z/my-project/dev.log`.

**Paso 2b — Obtener el JWT del Director**

El agente necesita el JWT del Director para acceder a la API de Z.ai. **Sin el JWT, el proceso contexto_zai no puede extraer mensajes del chat ni recuperar contexto.** El JWT se obtiene una sola vez en la vida del proyecto (no expira).

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
   - El Director descarga `czai-installer.bat` del sandbox, hace doble clic, va a chat.z.ai, y hace clic en el favorito "Conectar CZAI".
   - El bookmarklet envía el JWT al sandbox, que lo guarda en `~/.czai/credentials.json`.

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

**IMPORTANTE: El proceso se carga en dos tiempos.**
- **Tiempo 1 (Paso 2a):** Cargar el proceso (clonar, setup, endpoints). Esto se puede hacer sin el JWT.
- **Tiempo 2 (Paso 2b):** Obtener el JWT (bookmarklet). Hasta que el JWT no esté en `~/.czai/credentials.json`, el proceso no puede recuperar contexto del chat. Si el JWT no está disponible, el agente puede continuar con los Pasos 3-7 pero **no podrá usar `pipeline.run()` ni `ampliar_contexto()` con URLs de Z.ai** hasta que el JWT llegue.

**Paso 2c — Cuándo y cómo usar el proceso**

El proceso es tu herramienta de trabajo. Úsalo en estos casos:

**Si pierdes contexto** (la plataforma comprimió tu ventana, el Director dice "relee el worklog", "perdiste contexto", "ya te dije"):
```python
from contexto_zai.pipeline import run
from contexto_zai.models import DetectionTrigger
from contexto_zai.client.credential_manager import CredentialManager

jwt = CredentialManager().get_jwt()
result = run(
    chat_id="<chat_id_del_gateway>",  # viene en los metadatos del gateway
    jwt=jwt,
    trigger=DetectionTrigger.EXPLICITO,
    reason="Recuperación de contexto",
)
# Si result.pending_tasks no está vacío, lanza los subagentes con el Task tool
# y después llama a collect_responses():
if result.pending_tasks:
    from contexto_zai.pipeline import collect_responses
    # Lanzar subagentes con Task tool usando los prompts de result.pending_tasks
    # Cada subagente escribe su respuesta en _responses/{task_id}.txt (o .json, o texto plano)
    applied = collect_responses()
# Lee 00_estado_actual.md, 01_indice_recuperacion.md, 02_decisiones_clave.md para retomar el hilo.
```

**Si el Director te da un link o archivo para incorporar al contexto:**
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

**Si necesitas detalle de un tema específico sin gastar tu contexto:**
```python
from contexto_zai.pipeline import query_context
result = query_context(
    question="¿Qué se decidió sobre X?",
    workspace_dir="/home/z/my-project/contexto_recuperacion",
)
# Lanza los subagentes con Task tool y llama a collect_responses() para recibir la respuesta.
```

**NOTAS IMPORTANTES:**
- `pipeline.run()` recupera el contexto del **chat de Z.ai**. Úsalo cuando pierdes contexto.
- `ampliar_contexto()` incorpora una **fuente externa** (URL o archivo). Úsalo cuando el Director te da un documento.
- **No las confundas.** Si el Director da un link externo, usa `ampliar_contexto()`. Si perdiste contexto, usa `pipeline.run()`.
- Si el Director da un Google Doc privado, `ampliar_contexto()` fallará con 401. Pídele que lo haga público (Compartir → Cualquiera con el enlace) o que lo descargue como archivo (.docx o .pdf) y lo suba a `/home/z/my-project/upload/`. Después usa `ampliar_contexto(source_type="file", source_path="/home/z/my-project/upload/archivo")`.
- Los subagentes pueden escribir en cualquier formato (.txt, .json, texto plano). El proceso los reconoce automáticamente. Cada subagente debe escribir su respuesta en un archivo llamado `_responses/{task_id}.txt` (o `.json`), donde `task_id` es el identificador de la tarea que viene en `pending_tasks`.

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
