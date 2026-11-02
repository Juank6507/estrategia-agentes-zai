<!-- Ubicacion: estrategia/plantillas/plantilla_documento_consolidado.md (plantilla, v1.5)
     Destino instanciado en cada proyecto (NH15): <RAIZ_DEL_REPO_DEL_PROYECTO>/retorno/documento_consolidado.md
     Regla: NH26 y dcepi.md I.3d (M1); proyecto.md §6. Lo general viaja aqui; lo particular
     y especifico permanece en el worklog del proyecto. Este archivo NUNCA se edita in situ:
     el agente copia la plantilla a su destino y la instancia con datos reales. -->

# DOCUMENTO CONSOLIDADO DE RETORNO — <<NOMBRE_PROYECTO>>

| Campo | Valor |
|---|---|
| Proyecto | <<NOMBRE_PROYECTO>> |
| Agente | <<NOMBRE_AGENTE>> |
| Última actualización | <<FECHA_ULTIMA_ACTUALIZACION>> |
| Origen | Elemento C (Conciliación) del método del proyecto; fichas aprobadas expresamente por el Director |
| Estado | <<VIGENTE / COSECHADO por el agente EP el <<FECHA>> en la actualización v<<VERSION>> de la estrategia>> |

## 1. Información general

<<Resumen general del retorno: qué periodo abarca, qué ciclos DCEPI han cerrado desde la
última actualización del documento y qué versión de la estrategia usa el proyecto.>>

## 2. Lecciones aprendidas (aprobadas)

| # | Lección | Cómo se aplica | Origen (sesión/ciclo) |
|---|---|---|---|
| <<N>> | <<Lección en una frase>> | <<Regla o práctica concreta que adopta el proyecto>> | <<Sesión y ciclo>> |

## 3. Anti-patrones detectados (aprobados)

| # | Anti-patrón | Señal de alerta | Corrección acordada | Origen |
|---|---|---|---|---|
| <<N>> | <<Patrón a no repetir>> | <<Cómo se reconoce>> | <<Qué se hace en su lugar>> | <<Sesión y ciclo>> |

## 4. Decisiones generales aprobadas (aplicables a la estrategia)

| # | Decisión | Alimenta qué archivo de estrategia | Origen |
|---|---|---|---|
| <<N>> | <<Decisión general (no particular del proyecto)>> | <<p. ej. agent-learn/lecciones_aprendidas.md, dcepi.md>> | <<Sesión y ciclo>> |

## 5. Pendientes de cosecha

<<Lista de fichas nuevas desde la última cosecha M2 que el agente EP aún no ha volcado
en la estrategia. Si no hay pendientes, indicarlo expresamente: "Sin pendientes".>>

---

Reglas del documento (NH26): (1) solo entra aquí información aprobada expresamente por el
Director en el elemento C del proyecto; (2) lo general (aplicable a la estrategia) viaja en
este documento; lo particular y específico queda en el worklog del proyecto; (3) el agente EP
lo cosecha en M2 (dcepi.md I.3c) citando proyecto y documento de origen; (4) la vía de retorno
es única: repositorios. No existe push directo ni vía lateral.
