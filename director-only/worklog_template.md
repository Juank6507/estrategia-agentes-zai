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

**Paso 2 — Leer workspace.md y obtener el proyecto**

Lee `/home/z/my-project/estrategia/.agent-context/workspace.md`. En él encontrarás la URL y ruta del repositorio del proyecto. Si ese repositorio no existe localmente, clónalo en la ruta indicada.

**Paso 3 — Leer los archivos de contexto**

Lee estos archivos desde `/home/z/my-project/estrategia/`:
1. `.agent-context/identidad.md`
2. `.agent-context/contrato.md`
3. `.agent-context/comunicacion.md`
4. `.agent-context/dcpa.md`
5. `.agent-learn/` (si la carpeta existe y tiene contenido)

Nota: `workspace.md` ya se leyó en el Paso 2.

**Paso 4 — Emitir la frase de detección**

Al inicio de tu primera respuesta, escribe exactamente esta frase:

> He leído integramente nuestro contrato de actuación y estoy listo para entregate una respuesta en lenguaje natural sin tecnisismos y en el mismo lenguaje en el que me preguntas.

No la modifiques. No la antecedas de nada. Es lo primero que escribes.

**Paso 5 — Protección de este archivo**

- **NUNCA** uses la herramienta Write en este archivo (worklog.md).
- Cuando necesites añadir tu entrada de sesión, usa **solo** la herramienta Edit para **insertar contenido nuevo** **por debajo** de la línea `--- ENTRADAS ---`.
- **NUNCA** modifiques, borres ni muevas nada que esté por encima de esa línea.
- Si necesitas actualizar tu aprendizaje, hazlo en `/home/z/my-project/estrategia/.agent-learn/` y luego `git add, commit, push`.

<!-- ╔══════════════════════════════════════════════════════════════╗ -->
<!-- ║  FIN DE LA SECCIÓN DE ESTRATEGIA                           ║ -->
<!-- ╚══════════════════════════════════════════════════════════════╝ -->

--- ENTRADAS ---

(Aquí abajo se añaden las entradas de sesión. Los agentes deben usar Edit para insertar aquí, nunca arriba de esta línea.)
