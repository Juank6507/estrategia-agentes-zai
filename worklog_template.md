# WORKLOG

<!-- ╔══════════════════════════════════════════════════════════════╗ -->
<!-- ║  SECCIÓN DE ESTRATEGIA — PROHIBIDO MODIFICAR             ║ -->
<!-- ║  Todo lo que está por encima de "--- ENTRADAS ---" es de    ║ -->
<!-- ║  solo lectura. Los agentes NO deben tocar esta sección.    ║ -->
<!-- ╚══════════════════════════════════════════════════════════════╝ -->

Al iniciar sesión, Z.ai te indicó que leyeras este archivo. Eso ya lo has hecho. Ahora sigue estas instrucciones en orden. No saltes pasos. No adelantes pasos. Cada paso depende del anterior.

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

**Paso 3 — Verificar que el dev server esté corriendo (puerto 3000)**

Esto es lo primero que debes verificar, porque todo lo demás depende de que el puerto 3000 responda:
```bash
curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/
```
- `200` → correcto. Continúa al Paso 4.
- Si no responde o da otro código → revisa `/home/z/my-project/dev.log`. Si el dev server no está corriendo, revisa el log y reinicia si es necesario. No continúes hasta que el puerto 3000 responda `200`.

**Paso 4 — Cargar el proceso contexto_zai (CZAI)**

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

3. **Reporta la versión del proceso al Director:**
   ```bash
   cd /home/z/my-project/contexto_zai/ && git log --oneline -1
   ```
   Incluye el commit y el mensaje en tu frase de detección (Paso 11). Esto permite al Director verificar que el proceso está actualizado.

**Paso 5 — Verificar los endpoints CZAI**

La página del sandbox (`/`) tiene el bridge del JWT. Verifica que responde:
```bash
curl -s http://localhost:3000/api/czai/jwt-status | python3 -c "import sys,json; print(json.load(sys.stdin).get('needs_jwt', 'sin respuesta'))"
```
- Si responde `true` o `false`: el sandbox ya tiene los endpoints CZAI. Continúa al Paso 6.
- Si no responde o da error: el sandbox no tiene los endpoints. Ejecuta el setup:
  ```bash
  bash /home/z/my-project/contexto_zai/setup-czai.sh
  ```
  Esto crea los endpoints, el componente y la página en el sandbox Next.js.

**Paso 6 — Verificar el proxy Z.ai**

El proceso necesita el proxy Z.ai para enriquecer bloques de contexto:
```bash
curl -s -o /dev/null -w "%{http_code}" -X POST http://localhost:3000/api/zai-proxy/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"glm-4-flash","messages":[{"role":"user","content":"ping"}],"max_tokens":3}'
```
- `200` → el proxy Z.ai está activo. Continúa al Paso 7.
- `404` → el proxy Z.ai no está instalado en el sandbox. Instálalo:
  ```bash
  cp -r /home/z/my-project/contexto_zai/sandbox-src/api/zai-proxy /home/z/my-project/src/app/api/
  ```
  Espera unos segundos y vuelve a verificar.
- `429` → el proxy Z.ai está activo pero con rate limit temporal. No es un error, el proceso lo maneja automáticamente. Continúa al Paso 7.
- Otro código → revisa `/home/z/my-project/dev.log` y reporta al Director.

**Paso 7 — Arrancar el Worker Bun (servicio de enriquecimiento)**

El Worker Bun es un servicio que enriquece los bloques de contexto automáticamente. Arráncalo ahora, antes de continuar:
```bash
cd /home/z/my-project/contexto_zai/mini-services/worker-cascade && bun run cli.ts run &
```
Esto deja el Worker Bun procesando bloques en background. No necesitas interactuar con él — el proceso lo coordina automáticamente.

**Paso 8 — Pedir al Director que ejecute el bookmarklet para obtener el JWT**

El proceso necesita el JWT del Director para acceder a la API de Z.ai. Verifica si ya hay JWT disponible:
```python
from contexto_zai.client.credential_manager import CredentialManager
cm = CredentialManager()
if cm.get_jwt():
    print("JWT disponible")
else:
    print("JWT no disponible")
```

Si no hay JWT, pídele al Director que lo conecte:
- Dile al Director: "Necesito conectar tu sesión de Z.ai con este sandbox. Ve a la página del sandbox (la que se abre en el Preview Panel), descarga el instalador (.bat), haz doble clic, y luego haz clic en el favorito 'Conectar CZAI' desde cualquier chat de chat.z.ai."
- El Director descarga `czai-installer.bat` del sandbox.
- El Director hace doble clic en el .bat. El instalador agrega el favorito "Conectar CZAI" en su navegador.
- El Director va a chat.z.ai, abre cualquier chat, y hace clic en el favorito "Conectar CZAI".
- El bookmarklet lee la sesión del Director y envía el JWT al sandbox. El sandbox lo guarda en `~/.czai/credentials.json`.

**No continúes hasta que el Director confirme que ejecutó el bookmarklet.** Una vez que lo haga, verifica que el JWT llegó:
```python
from contexto_zai.client.credential_manager import CredentialManager
cm = CredentialManager()
jwt = cm.get_jwt()
if jwt:
    print(f"JWT recibido: {jwt[:20]}...")
else:
    print("JWT no disponible todavía. Pídele al Director que ejecute el bookmarklet.")
```

El JWT no expira, así que esto se hace una sola vez en la vida del proyecto.

**Paso 9 — Leer los archivos de contexto**

Lee estos archivos desde `/home/z/my-project/estrategia/agent-context/`:
1. `identidad.md`
2. `contrato.md`
3. `comunicacion.md`
4. `dcpa.md`

**Paso 10 — Leer los archivos de aprendizaje**

Lee todos los archivos de `/home/z/my-project/estrategia/agent-learn/` si la carpeta existe y tiene contenido.

**Paso 11 — Identificar tu identidad y sesión**

Lee `proyecto.md` para identificar qué agente eres (APA o MB). Lee la última entrada de sesión en este worklog (debajo de `--- ENTRADAS ---`) para obtener el número de sesión anterior. Tu sesión es esa + 1.

**Paso 12 — Internalizar el aprendizaje**

Revisa los archivos de `agent-learn/`. Si hay alguna entrada relevante para el tipo de tarea que vas a realizar, menciónala en tu primera respuesta al Director. No es un formulario: es procesar la experiencia previa para aplicarla.

**Paso 13 — Emitir la frase de detección**

Al inicio de tu primera respuesta, escribe exactamente este bloque:

> Configuración cargada.
> - Estrategia: clonada y leída
> - Contexto: identidad, contrato, comunicación, dcpa, entorno, proyecto
> - Aprendizaje: errores, experiencias, preferencias
> - Proyecto: clonado en [ruta del proyecto]
> - Proceso CZAI: cargado en /home/z/my-project/contexto_zai/ (versión: [commit del git log], endpoints activos, proxy Z.ai [activo|inactivo], JWT [disponible|pendiente], Worker Bun [arrancado|pendiente])
> - Sesión: [número]
> - Agente: [APA o MB]
> - Modo de comunicación: lenguaje natural sin tecnicismos

No modifiques este formato. No lo antecedas de nada. Es lo primero que escribes.

**Paso 14 — Protección de este archivo**

- **NUNCA** uses la herramienta Write en este archivo (worklog.md).
- Cuando necesites añadir tu entrada de sesión, usa **solo** la herramienta Edit para **insertar contenido nuevo** **por debajo** de la línea `--- ENTRADAS ---`.
- **NUNCA** modifiques, borres ni muevas nada que esté por encima de esa línea.
- Si necesitas actualizar tu aprendizaje, hazlo en `/home/z/my-project/estrategia/agent-learn/` y luego `git add, commit, push`.

**Cómo usar el proceso durante la sesión**

El proceso contexto_zai es tu herramienta de recuperación de contexto. Está a tu disposición en todo momento. Úsalo cuando pierdas contexto, cuando el Director te pregunte algo que ya se discutió, o cuando necesites saber dónde quedaste.

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
```

El proceso devuelve un `result` con todo lo que necesitas. Si el proceso necesita que ejecutes tareas adicionales, te lo dirá en `result.pending_tasks`. Ejecuta cada tarea lanzando un subagente con el Task tool usando el `prompt` que viene en cada tarea (no modifiques el prompt, úsalo tal como viene). Después llama a `collect_responses()`.

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

Después de lanzar subagentes con el Task tool, los subagentes escriben sus respuestas en archivos dentro de `_responses/`. Llama a esta función para que el proceso las lea, las integre a los archivos de recuperación, y te devuelva el resultado estructurado:

```python
from contexto_zai.pipeline import collect_responses
result = collect_responses()
# result["total_aplicadas"] = número de respuestas integradas
# Los archivos 00_estado_actual.md, 02_decisiones_clave.md, _metadata.json se actualizan.
```

Los subagentes pueden escribir en cualquier formato: `.txt`, `.json`, o texto plano. El proceso los reconoce automáticamente. Cada subagente debe escribir su respuesta en un archivo llamado `_responses/{task_id}.txt` (o `.json`), donde `task_id` es el identificador de la tarea que viene en `pending_tasks`.

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
