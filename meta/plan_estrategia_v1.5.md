<!-- Ubicacion: estrategia/meta/plan_estrategia_v1.5.md
     Plan (P) de la version 1.5 de la estrategia. Responde a meta/spec_estrategia_v1.5.md.
     El Director revisa/prioriza el orden tras conciliar la E; la autorizacion de ejecucion
     ocurre al entrar a I (sin autorizacion, no se toca nada). -->

# PLAN — Estrategia Z.ai v1.5

Responde a `meta/spec_estrategia_v1.5.md`, fase por fase. Cada fase nace con su verificación (read-back tras cada escritura; umbral cero donde aplica). El Director prioriza el orden; la autorización de ejecución ocurre al entrar a I.

## Fases

- **F1 — Respaldo y precondiciones (I.1):** snapshot de regresión del repo v1.4.2 en `snapshots/estrategia_v1.4.2_pre_v1.5_<fecha>`; verificación del clon (estado conocido); tabla de alcance de la spec emitida como lista de archivos tocables. *Verificación:* snapshot completo y legible; clon limpio.
- **F2 — premisa_respuesta.md (P2):** nueva estructura de producción corto → narrativa → resumen, con el resumen abarcador (toca cada aspecto); retiro de "respuesta estructurada" como tercer elemento; remisión de la triple redacción. *Verificación:* criterio 1 de la spec (barrido anti-retirados 0 coincidencias en operativos).
- **F3 — dcepi.md (P1, P3, P4, P5):** escalera de 3 niveles en I.2; baremo de datos reales en §8; script de entrega obligatorio y su indicación de generación en I.3a; mitad Windows de I.3b automatizada (checklist por script); cosecha en 2 momentos en I.3c/d; remisión a las plantillas. *Verificación:* criterio 2 de la spec.
- **F4 — contrato.md (P1, P4, P5):** NH24 (script de entrega obligatorio), NH25 (datos reales, no mocks en el veredicto), NH26 (retorno por vía repositorios), en triple redacción y numeración continua. *Verificación:* criterio 4 de la spec.
- **F5 — proyecto.md + herramientas.md (P1):** fichero de entornos con los repos GitHub explícitos de EP/APA/MB/CZAI; protocolo de cosecha del EP en 2 momentos; lugar determinado del documento consolidado (según se concilie en la pregunta abierta 2); remisiones en herramientas.md (§6 y sección de entregas). *Verificación:* criterio 5 de la spec.
- **F6 — Plantillas (P5, P6):** `plantillas/plantilla_script_entrega_proyecto.ps1` (checklist de portabilidad y validación embebida, manifiesto, sentencia de lanzamiento, veredicto umbral cero, registro de intentos) y `plantillas/plantilla_documento_consolidado.md` (aprendizajes, anti_patrones, información general; origen y estado). Verificación estática de la plantilla .ps1 (ASCII puro, sintaxis, balance, checklist presente). *Verificación:* criterio 3 de la spec.
- **F7 — update_estrategia.ps1 (intervención quirúrgica) + meta/ (P5):** según se concilie la pregunta abierta 1: OPERATIVO_KEEP y/o REQUIRED_FILES para incluir las plantillas; cabecera y banner a la nueva versión del script; meta/historial_versiones.md (entrada v1.5) y meta/tareas_inmediatas.md (pendientes actualizados). *Verificación:* criterio 6 de la spec (diff limitado a la intervención; resto byte-idéntico).
- **F8 — Verificación y empaquetado:** barrido anti-retirados completo (criterio 1); checklist de los criterios 1–8; worklog canónico (checklist íntegra con evidencias); aprendizajes propuestos al Director; MANIFIESTO_ENTREGA.txt regenerado desde disco (verificación 100%); `download/estrategia_v1.5.zip` con diff zip↔disco CERO y `download/sentencias_actualizacion_v1.5.txt` (nombre exacto del zip fijado con -ZipPath, precedente v1.4.2). *Verificación:* criterios 1 y 8 de la spec.

## Orden propuesto (a priorización del Director)

F1 → F2 → F3 → F4 → F5 → F6 → F7 → F8.

Las fases F2–F6 son independientes entre sí una vez emitida la spec (pueden reordenarse sin riesgo); F7 depende de la conciliación de la pregunta abierta 1; F8 cierra siempre último.

## Criterios técnicos permanentes del Director (vigentes en toda la I)

Buenas prácticas, OOP, prohibición de hardcoding, mocks/fallbacks solo cuando no exista posibilidad de datos reales explícitos o implícitos (coherente con la NH25 nueva), y el estándar R5 aplicado también a esta propia entrega: la v1.5 viaja con su manifiesto, sentencia y verificación de funcionamiento en Windows (I.3b) ejecutada por el Director con la sentencia v1.5.
