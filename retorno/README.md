<!-- Ubicacion: estrategia/retorno/README.md (v1.5, orden del Director 2026-11-02)
     Contrato de la carpeta retorno/ (R1, NH26). Este README viaja en el paquete operativo
     para que todo agente conozca el lugar determinado del retorno. -->

# retorno/ — lugar determinado del retorno (v1.5)

La vía de retorno agente → estrategia es la **vía repositorios en 2 momentos** (R1, NH26):

- **En cada repo de proyecto (M1):** aquí vive `documento_consolidado.md`, el documento único
  de retorno generado desde `plantillas/plantilla_documento_consolidado.md` cuando el Director
  aprueba las fichas en el elemento C del proyecto. Ese es el lugar determinado: la carpeta se
  llama `retorno/` y el archivo, `documento_consolidado.md`.
- **En este meta-proyecto (M2):** aquí aterrizan las copias de cosecha que el agente EP lee de
  los repos de los proyectos al actualizar la estrategia, con el nombre
  `<PROYECTO>_documento_consolidado.md` (p. ej. `APA_documento_consolidado.md`).

Reglas:

1. Solo entra información **aprobada expresamente por el Director** (elemento C del proyecto).
2. Lo **general** viaja en el documento consolidado; lo **particular y específico** permanece
   en el worklog del proyecto.
3. No existe otra vía de retorno (NH26): sin push directo, sin vías laterales, sin fichas sueltas.
4. Norma completa: `agent-context/dcepi.md` (I.3c/I.3d) y `agent-context/proyecto.md` (§6).

*Carpeta abierta por orden del Director (2026-11-02) junto a `plantillas/` en la raíz de la
estrategia operativa. Sin copias de cosecha todavía: la primera cosecha M2 ocurrirá con la
próxima actualización de la estrategia.*
