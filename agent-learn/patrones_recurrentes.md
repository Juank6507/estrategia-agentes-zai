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
