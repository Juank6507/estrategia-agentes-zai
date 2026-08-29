# ENTORNO DE TRABAJO

## Espacios

| Espacio | Ubicación | Plataforma |
|---|---|---|
| **Agente** | `/home/z/my-project/` | Linux |
| **Estrategia (repo)** | `/home/z/my-project/estrategia/` | Clonado de GitHub al inicio de sesión |
| **Entrega** | `/home/z/my-project/download/` | — |
| **Director** | Su PC | Windows |

## Repositorio de estrategia

- **URL:** `https://github.com/Juank6507/estrategia-agentes-zai.git`
- **Ruta local:** `/home/z/my-project/estrategia/`
- **Clonado al inicio** de cada sesión (git clone o git pull).
- **Público** — el agente trabaja en un sandbox sin credenciales, no puede acceder a repositorios privados.
- Contiene los archivos `agent-context/`, `agent-learn/` y `worklog_template.md`.

## Reglas de entrega

- Los archivos de entrega **siempre** van en `/home/z/my-project/download/`.
- Si no es posible, se explica al Director el motivo y la solución alternativa.
- Cada archivo entregable incluye en la primera línea un comentario con su ubicación y nombre de destino.
- Al entregar, incluir tabla que mapee cada archivo entregado a su ubicación en el proyecto.

## Compatibilidad cruzada

- El entorno del agente es **Linux**.
- El entorno del Director es **Windows**.
- Los cambios sensibles a la plataforma (gestión de archivos, rutas, encoding, subprocess) requieren advertencia explícita al entregar.
- Usar `os.path`, `pathlib`, `tempfile` para compatibilidad cruzada.
- No usar rutas ni comandos exclusivos de Linux sin advertir.
- Si algo no se puede probar en Linux, se indica para que el Director lo verifique en su entorno.

## Naturaleza del código del proyecto

El proyecto se compone de dos tipos de archivos:

**1. Scripts atómicos (standalone)**
- Independientes, autocontenidos.
- Siempre incluyen su propia validación de cada funcionalidad que tocan en su lógica.
- No dependen de otros scripts del proyecto.

**2. Scripts de dependencia**
- Importan varios scripts atómicos.
- Conforman funcionalidades completas.
- Se validan mediante tests independientes que se ejecutan desde la carpeta `tests/` del proyecto.

El agente debe identificar qué tipo de archivo está modificando y aplicar las reglas correspondientes.

## Consumo de contexto

- Copiar solo los ficheros necesarios según la tarea.
- No llenar la ventana de contexto con código que no se va a modificar.
- Los archivos de estrategia se leen al inicio de sesión y no necesitan releerse a menos que el protocolo DCPA lo indique o el Director lo pida.

## Proxy LLM (OBLIGATORIO al inicio de sesión)

El sandbox de Z.ai expone un proxy que permite a APA usar el LLM real (glm-4-plus) desde la PC del Director. **Este proxy se pierde cada vez que el sandbox se reinicia.**

### Acción requerida al iniciar sesión

El agente **debe** ejecutar estas acciones **antes de cualquier otra tarea**:

1. Verificar si `/home/z/my-project/setup-proxy.sh` existe.
2. Si existe, ejecutarlo: `bash /home/z/my-project/setup-proxy.sh`
3. Si no existe, crear los 8 archivos del proxy manualmente (ver abajo).

### Qué archivos crea el proxy

| Archivo | Ruta | Función |
|---|---|---|
| `_lib.ts` | `src/app/api/zai-proxy/_lib.ts` | Lee credenciales de `/etc/.z-ai-config` y reenvía peticiones a `internal-api.z.ai` |
| `chat/completions/route.ts` | `src/app/api/zai-proxy/v1/chat/completions/route.ts` | Endpoint de chat |
| `vision/route.ts` | `src/app/api/zai-proxy/v1/vision/route.ts` | Endpoint de visión |
| `tts/route.ts` | `src/app/api/zai-proxy/v1/tts/route.ts` | Endpoint de texto a voz |
| `asr/route.ts` | `src/app/api/zai-proxy/v1/asr/route.ts` | Endpoint de voz a texto |
| `images/generations/route.ts` | `src/app/api/zai-proxy/v1/images/generations/route.ts` | Endpoint de generación de imágenes |
| `async-result/route.ts` | `src/app/api/zai-proxy/v1/async-result/route.ts` | Endpoint de resultados asíncronos |
| `functions/invoke/route.ts` | `src/app/api/zai-proxy/v1/functions/invoke/route.ts` | Endpoint de invocación de funciones |

### Contenido de `_lib.ts`

```typescript
import { readFileSync } from 'fs';

const TARGET_BASE = 'https://internal-api.z.ai/v1';

function getConfig() {
  try {
    return JSON.parse(readFileSync('/etc/.z-ai-config', 'utf-8'));
  } catch {
    return null;
  }
}

function buildHeaders(config: any): Record<string, string> {
  const h: Record<string, string> = {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${config.apiKey}`,
    'X-Z-AI-From': 'Z',
  };
  if (config.chatId) h['X-Chat-Id'] = config.chatId;
  if (config.userId) h['X-User-Id'] = config.userId;
  if (config.token) h['X-Token'] = config.token;
  return h;
}

export async function proxyRequest(targetPath: string, request: Request) {
  const config = getConfig();
  if (!config) {
    return new Response(
      JSON.stringify({ error: 'Proxy config not found' }),
      { status: 503, headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' } }
    );
  }

  const targetUrl = `${TARGET_BASE}/${targetPath}`;
  const headers = buildHeaders(config);
  const body = await request.text();

  try {
    const resp = await fetch(targetUrl, {
      method: request.method,
      headers,
      body: request.method !== 'GET' ? body : undefined,
    });

    const respHeaders = new Headers({
      'Access-Control-Allow-Origin': '*',
      'Content-Type': resp.headers.get('Content-Type') || 'application/json',
    });

    if (resp.body) {
      return new Response(resp.body, { status: resp.status, headers: respHeaders });
    }
    return new Response(await resp.text(), { status: resp.status, headers: respHeaders });
  } catch (err: any) {
    return new Response(
      JSON.stringify({ error: 'Proxy failed', detail: err.message }),
      { status: 502, headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' } }
    );
  }
}

export function optionsResponse() {
  return new Response(null, {
    status: 204,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Chat-Id, X-User-Id',
      'Access-Control-Max-Age': '86400',
    },
  });
}
```

### Patrón de cada `route.ts`

```typescript
import { proxyRequest, optionsResponse } from '@/app/api/zai-proxy/_lib';
import { NextRequest } from 'next/server';

export async function POST(request: NextRequest) {
  return proxyRequest('TARGET_PATH', request);
}

export async function OPTIONS() { return optionsResponse(); }
```

| Archivo | TARGET_PATH |
|---|---|
| `chat/completions/route.ts` | `chat/completions` |
| `vision/route.ts` | `vision` |
| `tts/route.ts` | `tts` |
| `asr/route.ts` | `asr` |
| `images/generations/route.ts` | `images/generations` |
| `async-result/route.ts` | `async-result` |
| `functions/invoke/route.ts` | `functions/invoke` |

### Síntoma de que falta el proxy

Si MB Sandbox (en la PC del Director) responde con `[Modo sandbox] Recibí tu mensaje...` en vez de una respuesta real del LLM, el proxy no está activo en el sandbox.
