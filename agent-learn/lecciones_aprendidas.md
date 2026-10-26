# LECCIONES APRENDIDAS

<!-- Criterio de inclusion: solo lecciones que el agente aprendio y que son aplicables a sesiones futuras.
     Consolidacion v1.2: experiencias.md fue fundido en este archivo (6 -> 4 archivos). -->

---
### L001 -- Repo de estrategia puede estar desactualizado
- **Sesion:** Multiple
- **Contexto:** Al iniciar sesion, el repo puede tener archivos de versiones anteriores
- **Leccion:** Siempre hacer git pull al inicio. Verificar que los archivos corresponden a la version actual (check de version en spec)
- **Aplica cuando:** Inicio de sesion

---
### L002 -- Entrega de archivos siempre por /download/
- **Sesion:** Multiple
- **Contexto:** Se intento usar otras rutas o metodos de entrega
- **Leccion:** /download/ es la UNICA ruta de entrega. REGLA ABSOLUTA. No usar /upload/ ni ninguna otra ruta
- **Aplica cuando:** Cualquier entrega de archivos al Director

---
### L003 -- EP trabaja en sandbox sin acceso a repo privado
- **Sesion:** Multiple
- **Contexto:** El agente intento acceder a repositorios privados o con credenciales
- **Leccion:** El repo operativo es publico (GitHub). Los archivos sensibles van en meta/ del repo completo (local del Director). EP-1: solo repo operativo
- **Aplica cuando:** Acceso a repositorios o distribucion de cambios

---
### L004 -- Protocolo de Arranque previene sesiones desactualizadas
- **Sesion:** v1.1
- **Contexto:** Agente comenzo a trabajar sin leer los archivos de estrategia
- **Leccion:** LEER los 10 archivos al inicio es obligatorio (premisa de respuesta como #1). Previene trabajar con contexto stale y violar reglas desconocidas
- **Aplica cuando:** Inicio de cada sesion, sin excepciones

---
### L005 -- Scripts PowerShell requieren ASCII puro en Windows
- **Sesion:** v1.1
- **Contexto:** update_estrategia.ps1 tenia em-dash y smart quotes que causaron errores de parsing en Windows PowerShell
- **Leccion:** Para scripts .ps1 que se ejecutan en Windows: solo ASCII. Reemplazar em-dash (--) con doble guion (--), evitar comillas tipograficas, usar UTF-8 sin BOM
- **Aplica cuando:** Crear o modificar scripts .ps1 para el Director

---
### L006 -- El worklog puede ser truncado externamente
- **Sesion:** v1.2 (meta-proyecto)
- **Contexto:** El worklog del sandbox fue truncado entre escrituras propias; la copia de respaldo local tambien fue eliminada
- **Leccion:** Verificar continuidad del worklog en cada arranque (premisa). Las copias locales no son proteccion duradera: la proteccion duradera es el repo GitHub y la entrega completa que siempre incluye el worklog. Restaurar verbatim desde el contexto de sesion y documentar lo no recuperable
- **Aplica cuando:** Inicio de sesion y cualquier discrepancia de registros

---
### L007 -- Automatizacion del Director: minimas acciones, cero preguntas
- **Sesion:** v1.2 (meta-proyecto)
- **Contexto:** El Director corrigio el script v2.0 (interactivo, con purga ELIMINADOS) definiendo el flujo exacto: "yo solo tengo que extraer del zip el update_estrategia.ps1 y ejecutarlo"
- **Leccion:** Los scripts para el Director se disenian SIN preguntas y con las minimas acciones humanas posibles; su orden literal define el flujo. La purga quirurgica de eliminados se sustituye por borrado total (salvo .git) + descompresion integra del zip
- **Aplica cuando:** Diseniar o modificar automatizaciones para el Director

---
### L008 -- Verificacion externa en ambos entornos cierra la entrega
- **Sesion:** v1.2 (meta-proyecto)
- **Contexto:** Tras ejecutar el script en su Windows, el Director pidio verificar el repo de GitHub desde el sandbox
- **Leccion:** Clonar el repo GitHub y verificar (diff -r contra el zip, manifest hash a hash, blobs operativo vs main) cierra I.3c con evidencia en los dos entornos. Criterio diff cero de entrega: local == GitHub == entrega zip
- **Aplica cuando:** Cierre de entregas que publican a GitHub

---
### L009 -- Los aprendizajes se actualizan DENTRO de la implementacion
- **Sesion:** v1.2 (meta-proyecto)
- **Contexto:** Orden del Director en I.3d: la actualizacion de los ficheros de aprendizaje debe producirse dentro de la implementacion y por tanto ANTES de la actualizacion de los repositorios, para que quede dentro del ciclo DCEPI completo
- **Leccion:** El llenado de agent-learn (I.3d) es parte de la I y viaja en la entrega zip: se escribe antes de que el Director actualice los repos con el script. Nunca se pospone fuera del metodo; asi el ciclo DCEPI cierra completo con los aprendizajes ya poblados
- **Aplica cuando:** Cierre de toda implementacion (I.3d, antes de I.3c del Director)
