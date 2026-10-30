# ANTI-PATRONES

<!-- Criterio de inclusion: comportamientos que causaron problemas y que hay que evitar.
     Consolidacion v1.2: errores_comunes.md fue fundido en este archivo (6 -> 4 archivos). -->

---
### AP1 -- Explicar implementacion tecnica al Director
- **El problema:** El Director no necesita saber como se implemento, solo que se hizo y que cambio
- **La solucion:** Comunicar en lenguaje natural: que se hizo, que cambio, que debe verificar el Director
- **Referencia:** NH3, comunicacion.md estilo

---
### AP2 -- Reescribir archivos completos
- **El problema:** Reescribir todo el archivo cuando solo se necesitan cambios parciales. Riesgo de perder funcionalidad existente
- **La solucion:** Cambios quirurgicos (Edit/diff). Solo reescribir si el Director lo pide explicitamente
- **Referencia:** NH18

---
### AP3 -- Entregar sin probar
- **El problema:** Entregar codigo que no se ha verificado
- **La solucion:** Probar cada cambio antes de entregarlo. Incluir bloque de validacion
- **Referencia:** NH2

---
### AP4 -- Olvidar archivos en la entrega
- **El problema:** Modificar 5 archivos pero solo entregar 3
- **La solucion:** Checklist: verificar que todos los archivos modificados estan en la entrega
- **Referencia:** NH12

---
### AP5 -- Usar rutas Linux sin advertir
- **El problema:** Crear rutas o comandos que solo funcionan en Linux
- **La solucion:** Usar os.path/pathlib. Advertir incompatibilidad con Windows
- **Referencia:** NH17

---
### AP6 -- Actuar sin autorizacion
- **El problema:** Ejecutar cambios sin que el Director los autorice
- **La solucion:** Seguir DCEPI. Sin autorizacion, no se toca nada. Unica excepcion: la auto-recuperacion de contexto (premisa_respuesta.md)
- **Referencia:** NH8, dcepi.md elemento I

---
### AP7 -- Hardcoding de valores
- **El problema:** Valores fijos que deberian ser configurables
- **La solucion:** Usar constantes, variables de entorno o archivos de configuracion
- **Referencia:** NH21

---
### AP8 -- Refactoring no autorizado
- **El problema:** Mejorar codigo que no fue pedido
- **La solucion:** Solo tocar lo que el Director pide. Si se ve algo mejorable, proponerlo pero no modificarlo
- **Referencia:** NH23

---
### AP9 -- Actuar sin Protocolo de Arranque
- **El problema:** Empezar a trabajar sin leer los 10 archivos de estrategia al inicio
- **La solucion:** Siempre LEER -> DECLARAR -> ACTUAR. Sin excepciones. La premisa de respuesta es el archivo #1
- **Referencia:** prompt_arranque.md v1.2

---
### AP10 -- Entrega fuera de /download/
- **El problema:** Intentar entregar archivos de estrategia por /upload/ u otra ruta
- **La solucion:** /download/ es EXCLUSIVO. REGLA ABSOLUTA DE ENTREGA
- **Referencia:** R10

---
### AP11 -- Trabajar con repo desactualizado
- **El problema:** El repo local tiene archivos de una version anterior
- **La solucion:** Siempre git pull al inicio. Verificar version en spec
- **Referencia:** B1, EP-5

---
### AP12 -- Purgas quirurgicas en entregas de reemplazo total
- **El problema:** Mantener listas de archivos eliminados (seccion ELIMINADOS) y purgarlas es redundante y fragil cuando la entrega reemplaza todo el contenido
- **La solucion:** Borrar todo el contenido del destino (conservando .git) y descomprimir la entrega integra; los retirados desaparecen solos
- **Referencia:** update_estrategia.ps1 v3.0, orden del Director

---
### AP13 -- Scripts de actualizacion interactivos
- **El problema:** El v2.0 preguntaba zip/repo/commit (Enter-Enter-Enter); el flujo real del Director es extraer y ejecutar, sin mas
- **La solucion:** Por defecto automatico (deteccion del .zip mas reciente + valores por defecto); parametros solo como modos auxiliares (-ZipPath, -RepoDir, -DryRun, -NoPush)
- **Referencia:** Sesion 23, orden del Director

---
### AP14 -- Saltarse subelementos prescritos del metodo
- **El problema:** Ejecutar la I saltandose subelementos prescritos (p. ej. entrar sin la precondicion I.1 o sin el baremo fijado en C) aunque el trabajo tecnico sea correcto
- **La solucion:** El orden del plan es obligatorio (fases con veredicto JSON, MAX_ITER); si un subelemento no puede ejecutarse, se documenta y se escala al Director; nunca se omite en silencio
- **Referencia:** S45 (invalidacion v1.3), dcepi.md I.2, NH8

---
### AP15 -- Jerga tecnica en el panel de checkmarks
- **El problema:** Redactar los checkmarks con lenguaje tecnico (identificadores de commit, comandos, hashes, "diff CERO", "read-back"); el punto es tecnicamente cierto pero el Director no puede entender cada subelemento tocado, incumpliendo las normas de comunicacion (S50) y dejando incompleto el aprendizaje I.3d (S51)
- **La solucion:** Cada checkmark en lenguaje natural: que se hizo, que falta, que debe decidir. La jerga y el detalle tecnico van solo al worklog como evidencia; un punto correcto pero en jerga se considera NO conforme
- **Referencia:** R29 punto 7 (dcepi.md elemento E), NH3, comunicacion.md, L013

---
### AP16 -- Proteccion declarada sin comprobar
- **El problema:** Los documentos afirmaban que los agentes de proyecto "fisicamente no podian ver" el contenido de la otra rama; la auditoria verifico con acceso anonimo que el repo es publico y cualquiera puede clonarlo completo: la supuesta proteccion fisica era un convenio de contenido mal descrito
- **La solucion:** Ninguna proteccion, restriccion o acceso se documenta sin verificarlo contra la realidad del entorno; lo que es convenio se describe como convenio (honestidad del limite: premisa 4)
- **Referencia:** Revision integral v1.4 (V1), verificabilidad externa de la premisa

---
### AP17 -- El mismo paso, tres maneras
- **El problema:** El paso "extraer y ejecutar el script" estaba descrito de tres formas distintas (entorno.md: en Descargas; comunicacion.md y prompt_arranque.md: en la carpeta del proyecto); la variante entre archivos provoco confusiones operativas reales
- **La solucion:** Las instrucciones operativas para el Director son canonicas y unicas (una sentencia de PowerShell que extrae y ejecuta); lo demas remite a la sede; una variante nueva es un defecto, no flexibilidad
- **Referencia:** V6 (v1.4), L015, comunicacion.md P5
