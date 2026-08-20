# ia-mcps

Colección de **servidores MCP** (Python 3.12+, DDD modular) expuestos por **HTTP** con FastAPI:
EMT Madrid (buses), Media (imagen/audio OpenAI), Memory (memoria semántica ChromaDB), File Checker
(hash/firma de ficheros) y PDF (Markdown→PDF); + `video_mod` (librería, sin fachada MCP). NO
contiene el "cerebro" de análisis de workitems Lazarus.

Repo dentro del monorepo **público** `eacevedof/prj_python37`. Comparte arquitectura, versiones y
estructura con el repo privado `eacevedof/prj-mcp-tools` (patrón `ocr-documents`) **a propósito**:
son la misma app, así que un cambio se hace una vez y se copia. Diferencias vivas:
`prj-mcp-tools` añade `favorites_mod`/`favorites_mcp` y el despliegue en el VPS; aquí todo es
**local**.

## Estructura (patrón ocr-documents / mcp-tools)

```
backend_web/
  public/main.py          front controller: /health-check + endpoints /mcp/*
  src/core/               boot (.env) y tabla de rutas MCP
  src/modules/
    shared/               kernel: enums, logger, apikey, AbstractMcpController
    <x>_mod/              NEGOCIO puro (+ infrastructure/adapters = cumple el puerto del _mcp)
    <x>_mcp/              FACHADA MCP: puerto, catálogo de tools, validación y respuesta
  storage/logs|cache|sqlite/   cache/chroma = memory_mod (la memoria semántica NO se borra)
docker/                   Dockerfile + compose local (host:8011)
```

Regla: **`<x>_mcp` depende de `<x>_mod`, nunca al revés**. El `_mcp` declara un **puerto**
(`domain/ports/`, un `Protocol` async) y el `_mod` lo cumple con un **adaptador**
(`infrastructure/adapters/`); cruzan primitivos, no DTOs. La fachada no tiene lógica de negocio.

Endpoints (todos con `X-Api-Key`; alta en `src/core/routes/mcp_routes.py`):
`/mcp/emt` · `/mcp/media` · `/mcp/pdf` · `/mcp/memory` · `/mcp/file-checker`

⚠️ El proceso es **local**: `memory` y `file-checker` operan sobre el disco de la máquina donde
corre, así que se usan con `make dev` (host), no dentro del contenedor. Sus operaciones de lectura
arbitraria (`MEMORY_ALLOW_STORE_FILE`, `FILE_CHECKER_ALLOW_URL_DOWNLOAD`) vienen **encendidas** en
el `.env.example` de este repo —al contrario que en mcp-tools— porque el disco y la red que
alcanzan son los tuyos.

**Documentación completa (Obsidian)**: `C:\projects\temper\ai\obsidian\projects\ia-mcps\ia-mcps.md`

- Índice + ficha rápida: `ia-mcps.md`
- Contratos (tools MCP + DTOs): `ia-mcps-schema.md` · Arquitectura DDD: `ia-mcps-code.md`
- Terceros (EMT/OpenAI/ChromaDB): `ia-mcps-vendor-services.md` · Deploy y alta en Claude Code:
  `ia-mcps-deploy.md`
- Deuda: `ia-mcps-tech-debt.md` · En curso: `ia-mcps-doing.md` · Backlog: `ia-mcps-to-do.md`
- Repo gemelo: `...\projects\mcp-tools\mcp-tools-code.md` · Patrón base:
  `...\projects\ocr-documents\ocr-documents-code.md`
- Tareas Lazarus (el "cerebro" NO está aquí): `...\projects\automation\workitem-analysis-skill.md`

**Comandos**: `make help` · `make dev` (host, 127.0.0.1:8010) · `make up` (contenedor, host:8011)
· `make test` · `make lint` · `make venv`

**Reglas**: git lo gestiona Eduardo; nunca `commit`/`push` desde Claude.
