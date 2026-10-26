# Plan Estrategia Z.ai v1.2

## Version

- **Version:** 1.2
- **Fecha:** 2026-10-24
- **Estado:** Aprobado - pendiente de implementacion
- **Documento hermano:** spec_estrategia_v1.2.md (elemento E)

## Reglas de este plan

- El plan responde a la spec; el Director valida la E, NO el plan; en P solo prioriza el orden segun su estrategia de trabajo. Orden fijado por el Director: versionado de E y P primero; el resto, fases tecnicas en secuencia logica.
- La autorizacion de ejecucion ocurre al entrar a I (sin autorizacion, no se toca nada).
- Cada intervencion se ejecuta bajo I.1 (precondiciones) e I.2 (ACCL v2: Orquestador -> Actor -> Critico con Gauntlet y 3 capas).
- Criterios tecnicos permanentes: buenas practicas, OOP, prohibicion de hardcoding, mocks/fallbacks solo cuando no exista posibilidad de datos reales explicitos o implicitos.
- Grafos y algoritmo del script existente protegidos (factor 6): solo se tocan en su intervencion quirurgica especifica.

## Fases de implementacion

### Fase 0: I.1 Precondiciones
- [ ] Snapshot de regresion (golden master) del repo estrategia/
- [ ] Tabla de alcance: lista de archivos tocables (piezas de la E)
- [ ] Grafos/algoritmo protegidos identificados y excluidos
- Sin precondiciones completas no se empieza.

### Fase 1: Versionado E + P (orden del Director; en curso)
- [x] Escribir meta/spec_estrategia_v1.2.md (elemento E versionado)
- [x] Escribir meta/plan_estrategia_v1.2.md (elemento P versionado)
- [x] Registrar entrada v1.2 en meta/historial_versiones.md

### Fase 2: agent-context/
- [ ] Crear premisa_respuesta.md (R13: frase de control, recuperacion espontanea, triple redaccion, verificabilidad externa, limite honesto, tabla de mapeo D/C/E/P/I)
- [ ] Crear herramientas.md (conciencia instrumental: inventario de herramientas del agente y como usarlas; viviendas de D.0)
- [ ] Reescribir dcepi.md (R12-R17: 5 elementos con subelementos, 13+13 factores, baremos como procedimiento, I.1/I.2/I.3 completos, sentencias GitHub 1 repo/2 ramas en I.3c)
- [ ] Actualizar contrato.md (premisa como primera regla, excepcion de auto-recuperacion NH8, clasificacion NH -> capa, barrido de notacion [P]/[G])
- [ ] Actualizar comunicacion.md (frase de control, estandar de respuesta simple y precisa)
- [ ] Actualizar entorno.md (esquema de ramas, flujo de actualizacion, premisa en arranque)
- [ ] Actualizar proyecto.md (1 repo/2 ramas, accesos diferenciados)
- [ ] Eliminar dcpa.md

### Fase 3: Raiz de estrategia/
- [ ] Actualizar prompt_arranque.md (arranque 10 archivos con premisa como #1; esquema de ramas; barrido anti-descomposicion-antigua)
- [ ] Migrar protocolo del worklog a worklog_protocolo.md (dos fases, formato verbatim de apertura y cierre)
- [ ] Ajustar worklog_template.md (solo plantilla; referencia a worklog_protocolo.md)

### Fase 4: agent-learn/
- [ ] Consolidar errores_comunes.md dentro de anti_patrones.md y eliminar errores_comunes.md
- [ ] Consolidar experiencias.md dentro de lecciones_aprendidas.md y eliminar experiencias.md
- [ ] Barrido de patrones_recurrentes.md (anti descomposicion antigua, anti-DCPA, anti-18-aspectos)

### Fase 5: Script y documentacion
- [ ] Actualizar update_estrategia.ps1 (R18: commit+push a main y sincronizacion automatica de la rama operativo; cabecera de ambito del meta-proyecto)
- [ ] Unificar tareas_inmediatas.md en una sola copia
- [ ] Copiar ambos PDF (v1 y v2) a estrategia/meta/ desde su punto de entrada en upload/
- [ ] meta/spec_estrategia_v1.2.md y meta/plan_estrategia_v1.2.md ya creados en Fase 1

### Fase 6: I.2 Verificacion del conjunto (Gauntlet + 3 capas)
- [ ] Regresion vs snapshot
- [ ] Perimetro de archivos (solo las piezas de la tabla de alcance)
- [ ] Perimetro de lineas (umbrales fijados por intervencion)
- [ ] Estatica / dinamica / logica, con barridos grep de los criterios de aceptacion de la spec v1.2
- [ ] Veredictos JSON del Critico; MAX_ITER = 5; escalado al Director si se supera

### Fase 7: I.3 Entrega
- [ ] I.3a entrega completa del meta-proyecto: .zip con TODOS los archivos en /download/
- [ ] I.3b sentencias de validacion para el entorno Windows del Director (por archivo modificado) + tests E2E
- [ ] I.3c sentencias git/GitHub para el Director (1 repo/2 ramas: push a main + sync de operativo via script)
- [ ] I.3d diff cero -> worklog + tareas inmediatas + aprendizajes (genericos a agent-learn/, especificos al DTI del proyecto; con autorizacion previa del Director)

## Impacto esperado

- El metodo DCEPI queda codificado y ejecutable (no texto muerto): cada subelemento con archivo, mecanismo y forma de salida.
- Cada respuesta del agente queda anclada por la premisa (frase de control + recuperacion espontanea), con verificacion externa visible para el Director.
- El repo unico con 2 ramas da accesos diferenciados reales a los agentes de proyecto sin segundo repositorio ni symlinks.
- La entrega del meta-proyecto queda definida de forma estable: siempre completa.
- agent-learn reduce la superficie de arranque (4 archivos) sin perder contenido.
- La documentacion de la estrategia queda completa: PDFs v1 y v2 junto a spec, plan e historial en meta/.

## Checklist de validacion

Identico a los criterios de aceptacion de la spec_estrategia_v1.2.md (13 items). Ningun item se cierra sin Gauntlet superado y diff cero en I.3d.
