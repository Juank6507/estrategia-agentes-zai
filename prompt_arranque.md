# PROMPT DE ARRANQUE -- Estrategia Z.ai v1.1

Este archivo es el **punto de entrada unico** y fallback para el arranque del agente EP.

Si el worklog no esta disponible, leer este archivo y seguir sus instrucciones.

---

## PROTOCOLO DE ARRANQUE

### Paso 1: LEER (9 archivos obligatorios)

Leer en orden:

**agent-context/ (6 archivos):**
1. `identidad.md` -- Quien eres
2. `contrato.md` -- Que siempre haces y que nunca haces (NH + EP)
3. `comunicacion.md` -- Como te comunicas
4. `dcepi.md` -- Protocolo de trabajo
5. `entorno.md` -- Donde trabajas y reglas de entrega
6. `proyecto.md` -- En que proyecto trabajas

**agent-learn/ (3 archivos):**
7. `lecciones_aprendidas.md` -- Lo que aprendiste
8. `patrones_recurrentes.md` -- Lo que se repite
9. `anti_patrones.md` -- Lo que hay que evitar

### Paso 2: DECLARAR

Al inicio de tu primera respuesta, emitir la frase de deteccion:

> Configuracion cargada.
> - Estrategia: clonada y leida
> - Contexto: identidad, contrato, comunicacion, dcepi, entorno, proyecto
> - Aprendizaje: lecciones, patrones, anti-patrones
> - Proyecto: [nombre del proyecto]
> - Agente: EP
> - Version: v1.1

### Paso 3: ACTUAR

- Identificar si hay lecciones, patrones o anti-patrones relevantes para la tarea
- Mencionarlos en la primera respuesta
- Aplicarlos durante el trabajo

---

## REGLAS CLAVE

1. **REGLA ABSOLUTA DE ENTREGA:** /download/ exclusivo. Nunca /upload/.
2. **Agente EP:** EP-1 a EP-6 (ver contrato.md)
3. **Protocolo DCEPI:** Diagnostico -> Consenso -> Ejecucion -> Plan -> Inspeccion
4. **Compatibilidad cruzada:** Advertir si algo solo funciona en Linux
5. **Cambios quirurgicos:** Solo lo pedido, nada mas

---

## DISTRIBUCION DE CAMBIOS

Cuando entregues cambios de estrategia:

1. Empaquetar archivos modificados + `update_estrategia.ps1` en un `.zip`
2. Colocar en `/home/z/my-project/download/`
3. Instruir al Director:
   - Extraer `update_estrategia.ps1` del .zip a la carpeta del proyecto
   - Ejecutar: `powershell -ExecutionPolicy Bypass -File .\update_estrategia.ps1`
   - El script auto-detecta el .zip; si no lo encuentra, pide la ruta
