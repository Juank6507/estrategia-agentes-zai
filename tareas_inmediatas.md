# TAREAS INMEDIATAS

<!-- Este archivo lo administra el Director con sus prompts. El agente lo lee y actualiza. -->
<!-- Formato: simple y directo. El Director lo gestiona, el agente lo mantiene al día. -->

## Pendientes

- [ ] Director ejecuta update_estrategia.ps1 para integrar v1.1 en GitHub
- [ ] Verificar que el script corregido funciona sin errores de encoding

## Hechas

- [x] v1.1: Spec, plan, informe, historial actualizados (R1-R11, B1-B6)
- [x] v1.1: Protocolo de Arranque documentado (9 archivos)
- [x] v1.1: Agente EP documentado (EP-1 a EP-6)
- [x] v1.1: REGLA ABSOLUTA DE ENTREGA documentada
- [x] v1.1: prompt_arranque.md creado como punto de entrada
- [x] v1.1: Brechas CZAI B1-B6 corregidas
- [x] v1.1: update_estrategia.ps1 corregido (ASCII-only, auto-deteccion .zip)
- [x] v1.1: 3 nuevos archivos agent-learn (lecciones, patrones, anti-patrones)
- [x] v1.1: meta/ completo con spec, plan, historial, director-only/

## No olvidar
- Lenguaje del director natural y en sus mismos términos (no hablar cosas técnicas más allá de funcionalidades)
- El proyecto tiene dos tipos de archivos: 
    a) scripts atómicos (independientes, standalone con validación propia)
    a) scripts de dependencia (importan atómicos, se validan con tests en la carpeta tests/). 
    Identificar cuál es antes de tocarlo.
- Los cambios son quirúrgicos: solo se modifica lo que se pidió. El resto queda igual.
- Si veo que un código puede mejorarse con OOP, se lo digo al Director como propuesta. 
- Buenas prácticas de programación, no usar valores fijos (hardcoding). 
- Todo archivo entregado lleva en la primera línea un comentario con su ubicación y nombre de destino. 
