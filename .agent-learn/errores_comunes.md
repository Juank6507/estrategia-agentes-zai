# ERRORES COMUNES — Lo que hay que evitar

<!-- Este archivo lo actualiza el AGENTE al final de sesiones donde cometió o detectó errores -->
<!-- Formato: una entrada por error -->

---
### [Código] — [Título breve]
- **Cuándo ocurre:** [En qué situación aparece]
- **El error:** [Qué se hizo mal]
- **La corrección:** [Qué debería haberse hecho]
- **Cómo evitarlo:** [Regla para no repetirlo]

<!-- Ejemplo:
---
### E001 — Rutas hardcodeadas con /
- **Cuándo ocurre:** Al crear paths para archivos
- **El error:** Usar `/ruta/archivo` directamente
- **La corrección:** Usar `os.path.join()` o `pathlib.Path()`
- **Cómo evitarlo:** NH17: nunca usar rutas exclusivas de Linux sin advertir
-->