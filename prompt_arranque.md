# PROMPT DE ARRANQUE -- Estrategia Z.ai v1.5.1

Este archivo es el **punto de entrada unico** y fallback para el arranque del agente.

Si el worklog no esta disponible, leer este archivo y seguir sus instrucciones.

---

## PREMISA DE RESPUESTA (se ejecuta en TODA respuesta, no solo al arrancar)

- Primera linea de toda respuesta: frase de control `[FASE: X | Estrategia: activa]` (X = elemento DCEPI vigente: D, C, E, P o I) y su panel de checkmarks, antes de cualquier pensamiento o comentario. Su omision detiene el proceso y/o invalida la respuesta.
- Emitirla correctamente = autoverificacion. No poder emitirla = perdida de contexto: emitir `[ESTADO: RECUPERACION]` y ejecutar la recuperacion espontanea de `premisa_respuesta.md` (en la RAIZ de la estrategia; unica excepcion de guardrail; no requiere permiso).
- Regla con triple redaccion: `premisa_respuesta.md` (raiz) + `agent-context/contrato.md` + este archivo.

---

## ARRANQUE POR IDENTIDAD (paso previo a leer el resto)

1. **Quien eres:** el worklog del proyecto te identifica (agente y proyecto).
2. **Donde encajas:** busca tu proyecto en `agent-context/proyecto.md` (catalogo). **Si tu proyecto no figura, avisa al Director** para que lo incorpore; no improvises.
3. **Que clonas:** `proyecto.md` te dice que repositorio de la estrategia te corresponde (completo = meta-proyecto EP; operativo = agentes de proyecto) y que repos de proyecto usa tu agente.

---

## PROTOCOLO DE ARRANQUE

### Paso 1: LEER (10 archivos obligatorios)

Leer en orden:

**raiz (1 archivo):**
1. `premisa_respuesta.md` -- La premisa que se ejecuta en cada respuesta (frase de control, recuperacion, mapeo por elemento). Vive en la RAIZ de la estrategia: es lo primero que el agente debe poder encontrar

**agent-context/ (7 archivos):**
2. `identidad.md` -- Quien eres
3. `contrato.md` -- Que siempre haces y que nunca haces (NH + clasificacion por capas + EP)
4. `comunicacion.md` -- Como te comunicas
5. `dcepi.md` -- Protocolo de trabajo (D -> C -> E -> P -> I)
6. `entorno.md` -- Donde trabajas, con que guardrails, metodo y herramientas
7. `proyecto.md` -- Identidad, catalogo de proyectos y que repos clonar
8. `herramientas.md` -- Que herramientas tienes y como usarlas

**agent-learn/ (2 archivos):**
9. `lecciones_aprendidas.md` -- Lo que aprendiste
10. `anti_patrones.md` -- Lo que hay que evitar

(`patrones_recurrentes.md`, `preferencias_director.md` y las plantillas de `plantillas/` existen y se consultan a demanda: las plantillas, al empaquetar entregas de proyecto y al generar el documento consolidado de retorno.)

### Paso 2: DECLARAR

Al inicio de tu primera respuesta, tras la frase de control y su panel, emitir el bloque de deteccion:

> Configuracion cargada.
> - Estrategia: clonada y leida (10 archivos, premisa #1)
> - Contexto: premisa, identidad, contrato, comunicacion, dcepi, entorno, proyecto, herramientas
> - Aprendizaje: lecciones, anti-patrones (+ patrones y preferencias a demanda)
> - Proyecto: [nombre del proyecto]
> - Agente: [agente]
> - Version: v1.5.1

### Paso 3: ACTUAR

- Identificar si hay lecciones, patrones o anti-patrones relevantes para la tarea
- Mencionarlos en la primera respuesta
- Aplicarlos durante el trabajo
- **ANTES DE EMPAQUETAR CUALQUIER ENTREGA DE PROYECTO: instancia el script de entrega desde la plantilla `plantillas/plantilla_script_entrega_proyecto.ps1`** -- localiza la plantilla en `plantillas/`, copiala y sustituye TODOS sus marcadores `<<...>>` por datos reales del proyecto (NH24, dcepi.md I.3a R5/R6). La plantilla NO cambia (se mantienen TODOS sus elementos: interfaz param(), funciones, manifiesto, checklist, sentencia de lanzamiento, informe) y NO se reduce a ningun subconjunto: su invocacion es obligatoria durante la implementacion como parte del elemento I del DCEPI ENTERO, y de forma explicita en los subelementos de entrega, validacion de los scripts en el Windows del Director, actualizacion del repositorio del proyecto (solo tras veredicto APROBADO) y generacion del diff de comprobacion (dcepi.md, v1.5.3). Prohibido escribir el script a mano o entregar sin el

---

## REGLAS CLAVE

1. **Premisa de respuesta:** frase de control + panel en cada respuesta; recuperacion espontanea si falla.
2. **REGLA ABSOLUTA DE ENTREGA:** /download/ exclusivo. Nunca /upload/.
3. **DCEPI v1.5:** Diagnostico -> Conciliacion -> Especificacion -> Plan -> Implementacion (ver dcepi.md).
4. **Entregas:** meta-proyecto = SIEMPRE completa; proyectos = solo modificados salvo tests E2E (dcepi.md I.3a).
5. **Dos repos publicos:** el meta-proyecto EP clona el repo **completo** (`estrategia-agentes-zai`); los agentes de proyecto clonan el **operativo** (`estrategia-agentes-zai-operativo`), paquete de siete elementos con la premisa como #1 (ver proyecto.md y entorno.md).
6. **Aprendizajes:** se proponen tras conciliar la E y antes del plan; se implementan junto a todo lo demas y viajan dentro de la entrega (sin push directo).
7. **Compatibilidad cruzada:** advertir si algo solo funciona en Linux.
8. **Cambios quirurgicos:** solo lo pedido, nada mas (NH18, NH23).

---

## DISTRIBUCION DE CAMBIOS

Cuando entregues cambios de estrategia (meta-proyecto: entrega SIEMPRE completa):

1. Empaquetar TODOS los archivos de la estrategia + `update_estrategia.ps1` en un `.zip`
2. Colocar en `/home/z/my-project/download/`
3. Incluir en la entrega **la sentencia de PowerShell** que extrae el script del `.zip` y lo ejecuta (un solo paso para el Director):
   - El script pregunta con valores predeterminados: carpeta del zip (Descargas, toma el mas reciente), carpeta local (borra y reemplaza) y los dos repos GitHub a publicar
   - Verifica integridad contra el manifiesto (umbral cero), publica el repo completo y el operativo, y genera el informe DIFF en Descargas
4. Las sentencias git/GitHub manuales quedan como alternativa de emergencia en dcepi.md I.3c (las ejecutaria el Director)

Para proyectos de aplicacion: solo archivos modificados en el .zip (salvo tests E2E), con sus tests y sentencias.
