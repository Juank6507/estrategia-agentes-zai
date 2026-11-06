<!-- Ubicacion: estrategia/plantillas/plantilla_baremo_estrategico.md (NUEVO, P2 del Director, S81;
     contenido APROBADO punto por punto en S83). Sede del BAREMO ESTRATEGICO: vive y viaja en la
     ESTRATEGIA (D5, S81), no en el DTI del proyecto. La parte fija (punto 2) NO se rellena nunca;
     la tabla (punto 3) la rellena el agente en cada Conciliacion y el Director la ve al validar la
     especificacion del ciclo. La plantilla vacia vive y viaja en la estrategia (paquete operativo);
     la tabla rellenada vive en los documentos del ciclo y viaja con la entrega (triple igualdad).
     Procedimiento: agent-context/dcepi.md §8. -->

# PLANTILLA DEL BAREMO ESTRATÉGICO (v1.6)

## 1. Cabecera de identidad (se rellena en cada ciclo)

- **Proyecto:** `<<proyecto>>`
- **Versión del ciclo:** `<<version>>`
- **Fecha:** `<<fecha>>`
- **Fijado por el Director en la Conciliación de este ciclo.**

## 2. Parte fija — NO rellenable (el baremo estratégico permanente, 4 principios)

La misma para todos los proyectos y ciclos:

- **(a) Todo lo conciliado se verifica con el chat y sus datos reales** — el cumplimiento de CADA aspecto conciliado se comprueba contra los datos reales del proyecto, nunca se da por bueno (precedente S46).
- **(b) REAL (R4, excepción exactada por el Director en S84):** datos reales si existen; si no es posible, lo más real posible, DECLARADO en la evidencia; **prohibido apoyar veredictos en simulaciones A MENOS QUE NO EXISTAN datos reales**. Los fallbacks y mocks encubren errores: jamás sostienen un veredicto.
- **(c) Nada terminado sin su examen:** el Gauntlet se exige en sus DOS niveles — por elemento y de terminación (NH27); sin Gauntlet no hay terminación ni entrega.
- **(d) Umbral cero con evidencia guardada en disco:** o pasa o no pasa, y la prueba queda señalada (el fichero, la salida del comando, la comparación).

## 3. Tabla de derivación (parte variable — UNA FILA POR ASPECTO CONCILIADO)

Filas = aspectos conciliados: ni recortes ni relleno. Se rellena en la Conciliación del ciclo:

| Aspecto conciliado | Qué se exige | Cómo se verifica con datos reales | Qué evidencia lo acredita | Resultado (verde/rojo) |
|---|---|---|---|---|
| `<<aspecto conciliado del ciclo>>` | `<<la exigencia exacta>>` | `<<prueba con datos reales: fichero, comando, salida>>` | `<<fichero/registro en disco que lo acredita>>` | `<<verde/rojo>>` |

## 4. Las 5 reglas de derivación (norma del rellenado, X4)

1. **CADA CRITERIO NACE DE UN ASPECTO CONCILIADO** — nada se verifica sin conciliar (no se inventan criterios) y nada conciliado queda sin verificar (no hay huecos): la tabla es el espejo exacto de la Conciliación.
2. **REAL** — se verifica con los datos reales del proyecto (ficheros reales, salidas reales, números reales); si un aspecto no tiene datos reales, se usa lo más real posible Y SE DECLARA en la evidencia; las simulaciones no sostienen un veredicto salvo que no existan datos reales.
3. **OBJETIVO** — cada criterio debe poder decidirse sin opiniones: o pasa o no pasa, y la prueba debe quedar en disco (el fichero, la salida del comando, la comparación); si no se puede señalar la evidencia en disco, el criterio está mal escrito.
4. **ALINEADO** — cada criterio mide lo que persigue la implementación del ciclo (la mejora conciliada), nada lateral: el Gauntlet examina la mejora, no otros asuntos.
5. **TABLA COMPLETA ANTES DEL VEREDICTO** — todas las filas rellenas antes del veredicto global; una tabla incompleta no puede dar verde: impide pasar con criterios sin verificar.

Las cinco juntas hacen la derivación fácil y guiada: el agente no inventa nada (rellena obedeciendo las reglas) y el Director puede auditar cualquier criterio hasta su conciliación, sus datos reales y su evidencia.

## 5. Cierre con veredicto

- **Veredicto del Gauntlet de terminación criterio a criterio** (la columna de resultado de la tabla) y **veredicto global**.
- **Con rojo:** iteración autónoma del agente, máximo 5 intentos (MAX_ITER), sin intervención del Director; el bucle de cada intento (D7): revisar las fallas respecto a lo conciliado en la spec → modificar el prompt corrigiendo esa falla → re-entregarlo al Actuador para que modifique el script → re-valorar y re-probar contra el baremo como Crítico/supervisor. Agotados los 5, informe al Director con las cuatro preguntas por iteración: qué falló → qué se diagnosticó → cómo se corrigió → qué se implementó (A1).
