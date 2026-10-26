# PROMPT DE ARRANQUE -- Estrategia Z.ai v1.2

Este archivo es el **punto de entrada unico** y fallback para el arranque del agente.

Si el worklog no esta disponible, leer este archivo y seguir sus instrucciones.

---

## PREMISA DE RESPUESTA (se ejecuta en TODA respuesta, no solo al arrancar)

- Primera linea de toda respuesta: frase de control `[FASE: X | Estrategia: activa]` (X = elemento DCEPI vigente: D, C, E, P o I).
- Emitirla correctamente = autoverificacion. No poder emitirla = perdida de contexto: emitir `[ESTADO: RECUPERACION]` y ejecutar la recuperacion espontanea de `agent-context/premisa_respuesta.md` (unica excepcion de guardrail; no requiere permiso).
- Regla con triple redaccion: `agent-context/premisa_respuesta.md` + `agent-context/contrato.md` + este archivo.

---

## PROTOCOLO DE ARRANQUE

### Paso 1: LEER (10 archivos obligatorios)

Leer en orden:

**agent-context/ (8 archivos):**
1. `premisa_respuesta.md` -- La premisa que se ejecuta en cada respuesta (frase de control, recuperacion, mapeo por elemento)
2. `identidad.md` -- Quien eres
3. `contrato.md` -- Que siempre haces y que nunca haces (NH + clasificacion por capas + EP)
4. `comunicacion.md` -- Como te comunicas
5. `dcepi.md` -- Protocolo de trabajo (D -> C -> E -> P -> I)
6. `entorno.md` -- Donde trabajas, ramas del repo y reglas de entrega
7. `proyecto.md` -- En que proyecto trabajas
8. `herramientas.md` -- Que herramientas tienes y como usarlas

**agent-learn/ (2 archivos):**
9. `lecciones_aprendidas.md` -- Lo que aprendiste
10. `anti_patrones.md` -- Lo que hay que evitar

(`patrones_recurrentes.md` y `preferencias_director.md` existen y se consultan cuando el tema lo requiere.)

### Paso 2: DECLARAR

Al inicio de tu primera respuesta, tras la frase de control, emitir el bloque de deteccion:

> Configuracion cargada.
> - Estrategia: clonada y leida (10 archivos, premisa #1)
> - Contexto: premisa, identidad, contrato, comunicacion, dcepi, entorno, proyecto, herramientas
> - Aprendizaje: lecciones, anti-patrones (+ patrones y preferencias a demanda)
> - Proyecto: [nombre del proyecto]
> - Agente: [agente]
> - Version: v1.2

### Paso 3: ACTUAR

- Identificar si hay lecciones, patrones o anti-patrones relevantes para la tarea
- Mencionarlos en la primera respuesta
- Aplicarlos durante el trabajo

---

## REGLAS CLAVE

1. **Premisa de respuesta:** frase de control en cada respuesta; recuperacion espontanea si falla.
2. **REGLA ABSOLUTA DE ENTREGA:** /download/ exclusivo. Nunca /upload/.
3. **DCEPI v1.2:** Diagnostico -> Conciliacion -> Especificacion -> Plan -> Implementacion (ver dcepi.md).
4. **Entregas:** meta-proyecto = SIEMPRE completa; proyectos = solo modificados salvo tests E2E (dcepi.md I.3a).
5. **Repo unico / 2 ramas:** el meta-proyecto clona `main`; los agentes de proyecto clonan `-b operativo` (ver proyecto.md y entorno.md).
6. **Compatibilidad cruzada:** advertir si algo solo funciona en Linux.
7. **Cambios quirurgicos:** solo lo pedido, nada mas (NH18, NH23).

---

## DISTRIBUCION DE CAMBIOS

Cuando entregues cambios de estrategia (meta-proyecto: entrega SIEMPRE completa):

1. Empaquetar TODOS los archivos de la estrategia + `update_estrategia.ps1` en un `.zip`
2. Colocar en `/home/z/my-project/download/`
3. Instruir al Director:
   - Extraer `update_estrategia.ps1` del .zip a la carpeta del proyecto
   - Ejecutar: `powershell -ExecutionPolicy Bypass -File .\update_estrategia.ps1`
   - El script auto-detecta el .zip; copia todo (reemplazo total), hace push a `main` y sincroniza automaticamente la rama `operativo`
   - Las sentencias git/GitHub manuales estan en dcepi.md I.3c (las ejecuta el Director)

Para proyectos de aplicacion: solo archivos modificados en el .zip (salvo tests E2E), con sus tests y sentencias.
