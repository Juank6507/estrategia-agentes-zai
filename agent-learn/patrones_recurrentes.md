# PATRONES RECURRENTES

<!-- Criterio de inclusion: patrones que se repiten en al menos 2 sesiones. -->

---
### P1 -- Comunicacion en lenguaje natural
- **Patron:** El Director prefiere explicaciones en terminos de funcionalidades y resultados, no tecnicismos
- **Frecuencia:** Cada sesion
- **Regla:** Contrato NH3 + comunicacion.md estilo

---
### P2 -- Cambios quirurgicos
- **Patron:** Modificar solo lo pedido, nothing else
- **Frecuencia:** Cada sesion
- **Regla:** Contrato NH18 + NH23

---
### P3 -- Entrega en /download/ con tabla
- **Patron:** Cada archivo entregado va en /download/ con su ubicacion documentada
- **Frecuencia:** Cada entrega
- **Regla:** Entorno.md reglas de entrega + contrato NH6 + NH12

---
### P4 -- Verificacion antes de entregar
- **Patron:** Probar cada cambio antes de entregarlo
- **Frecuencia:** Cada entrega
- **Regla:** Contrato NH2 + checklist de integridad

---
### P5 -- DCEPI para cambios relevantes
- **Patron:** Seguir Diagnostico -> Conciliacion -> Especificacion -> Plan -> Implementacion
- **Frecuencia:** Cambios de codigo, bugs, arquitectura
- **Regla:** dcepi.md v1.2

---
### P6 -- Compatibilidad cruzada
- **Patron:** Advertir cuando algo solo funciona en Linux
- **Frecuencia:** Cuando se crean scripts o rutas
- **Regla:** Entorno.md compatibilidad + contrato NH17

---
### P7 -- Protocolo de Arranque al inicio
- **Patron:** Leer los 10 archivos de estrategia al inicio de cada sesion (premisa de respuesta como #1)
- **Frecuencia:** Cada sesion
- **Regla:** prompt_arranque.md v1.2

---
### P8 -- Entrega de estrategia via /download/ + .zip
- **Patron:** Empaquetar cambios de estrategia en .zip con update_estrategia.ps1
- **Frecuencia:** Actualizaciones de estrategia
- **Regla:** R10 REGLA ABSOLUTA DE ENTREGA + EP-4

---
### P9 -- Repo desactualizado al inicio
- **Patron:** El repo puede tener version stale; siempre hacer git pull
- **Frecuencia:** Cada sesion
- **Regla:** B1 + EP-5

---
### P10 -- Flujo de actualizacion del meta-proyecto (2 acciones)
- **Patron:** Descargar zip -> extraer solo update_estrategia.ps1 -> ejecutarlo; el script hace borrado total + zip integro + push main + sync operativo + diff GitHub-local
- **Frecuencia:** Cada version de la estrategia
- **Regla:** dcepi.md I.3c + entorno.md flujo v3.0 + L009 (aprendizajes dentro de la implementacion, antes de la actualizacion de repos)

---
### P11 -- Panel de checkmarks R29 en toda respuesta, en el lenguaje del Director
- **Patron:** Toda respuesta abre con la frase de control y el panel del elemento vigente: cada punto precedido de su pregunta, con [x] (cumplido, con evidencia en disco) o [?] (sin respuesta conocida: se pregunta al Director, nunca se suple); solo se reabre lo desconocido; la checklist integra con evidencias va al worklog al cierre de cada elemento. Cada checkmark se redacta en lenguaje natural (que se hizo, que falta, que debe decidir), sin jerga tecnica: el detalle tecnico queda en el worklog como evidencia (enmienda S50, L013)
- **Frecuencia:** Cada respuesta (desde S45; lenguaje natural desde S50)
- **Regla:** R29 puntos 1-7 (dcepi.md elemento E) + premisa_respuesta.md 2.4 y 5 + punto 5 de la Regla Conductual Minima del worklog
