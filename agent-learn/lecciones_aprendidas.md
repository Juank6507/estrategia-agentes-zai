# LECCIONES APRENDIDAS

<!-- Criterio de inclusion: solo lecciones que el agente aprendio y que son aplicables a sesiones futuras. -->

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
- **Leccion:** LEER los 9 archivos al inicio es obligatorio. Previene trabajar con contexto stale y violar reglas desconocidas
- **Aplica cuando:** Inicio de cada sesion, sin excepciones

---
### L005 -- Scripts PowerShell requieren ASCII puro en Windows
- **Sesion:** v1.1
- **Contexto:** update_estrategia.ps1 tenia em-dash y smart quotes que causaron errores de parsing en Windows PowerShell
- **Leccion:** Para scripts .ps1 que se ejecutan en Windows: solo ASCII. Reemplazar em-dash (--) con doble guion (--), evitar comillas tipograficas, usar UTF-8 sin BOM
- **Aplica cuando:** Crear o modificar scripts .ps1 para el Director
