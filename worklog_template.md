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
