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
    shared/               kernel: enums, logger, apikey, Hasher, AbstractMcpController
    <x>_mod/              CORE: casos de uso (service + DTOs), dominio y repositorios
    <x>_mcp/              BOCA para agentes: catálogo de tools, validación y respuesta
    users_mod/            identidad y acceso (app_users), SIN fachada propia: lo consumen
                          emt_mod y emt_mcp por puerto + adaptador
  storage/logs|cache|sqlite/   cache/chroma = memory_mod (la memoria semántica NO se borra)
                               sqlite/db_ia_mcps.sqlite = app_users + app_mcp_stops
docker/                   Dockerfile + compose local (host:8011)
```

Regla: **`<x>_mod` es el core y `<x>_mcp` una boca más**. La flecha va siempre de la boca al core:
el `_mcp` **importa el service y el DTO** del caso de uso, igual que haría un `api_controller` o un
`command`. Primero se hace el CRUD en `_mod` con sus tests; después se le pone la boca. La fachada
no tiene lógica de negocio: valida el payload, llama al caso de uso y redacta el texto.

Solo hay **puerto + adaptador** cuando hay que invertir una dependencia hacia otro bounded context
(hoy: `emt_mod`/`emt_mcp` -> `users_mod`). Entre boca y core no hay puertos.

Endpoints (todos con `X-Api-Key`; alta en `src/core/routes/mcp_routes.py`):
`/mcp/emt` · `/mcp/media` · `/mcp/pdf` · `/mcp/memory` · `/mcp/file-checker`

`/mcp/emt` publica además el CRUD de **paradas favoritas** y `emt_get_users` (admin). Toda tool con
dueño lleva `user_tg_id` (+ `password` si toca, + `target_user_tg_id` solo admin) y pasa por el
guardarraíl de `users_mod`: `is_enabled`, rol y contraseña con ventana de **7 días**. El alta de
usuarios NO es una tool: `make user-add tg=<id> name=<nombre> [admin=1]`. Contratos y reglas en
`ia-mcps-schema.md`.

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
· `make test` · `make lint` · `make venv` · `make user-add`

**Reglas**: git lo gestiona Eduardo; nunca `commit`/`push` desde Claude.
