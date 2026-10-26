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
