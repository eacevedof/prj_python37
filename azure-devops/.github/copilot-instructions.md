# Copilot Instructions

## Build, test, and lint commands

Use the project virtual environment before running commands.

### Windows setup

```powershell
python -m venv .venv-win
.\.venv-win\Scripts\activate
.\.venv-win\Scripts\python.exe -m pip install --upgrade pip
.\.venv-win\Scripts\python.exe -m pip install -r .\requirements.txt
```

### Linux/WSL setup

```bash
python3 -m venv .venv-wsl
source .venv-wsl/bin/activate
.venv-wsl/bin/python -m pip install --upgrade pip
.venv-wsl/bin/python -m pip install -r requirements.txt
```

### Run the HTTP API

```bash
uvicorn ddd.shared.infrastructure.azure_devops:fast_api --reload --host 0.0.0.0 --port 8303
```

### Run the MCP stdio server

```bash
python -m ddd.mcp_work_items.infrastructure.controllers.mcp_work_items_controller
```

### Lint, format, type-check, and test

```bash
ruff check --fix .
ruff format .
mypy ddd
pytest
```

### Run a single test

```bash
pytest path/to/test_file.py::test_name
```

or

```bash
pytest path/to/test_file.py -k "test_name"
```

Required environment variables live in `.env`: `AZURE_ORGANIZATION_NAME`, `AZURE_PAT`, `AZURE_API_VERSION`, `APP_DEFAULT_PROJECT`, and optionally `APP_LOG_PATH`.

## High-level architecture

This repository has two public entry surfaces:

1. `ddd.shared.infrastructure.azure_devops` builds the FastAPI application, registers global exception handlers, includes the `/workitems` router, and exposes `/health`.
2. `ddd.mcp_work_items.infrastructure.controllers.mcp_work_items_controller` runs a separate MCP server over stdio.

The HTTP flow is:

`routes -> infrastructure controllers -> application DTOs/services -> infrastructure repositories -> Azure DevOps Work Item APIs`

The MCP flow reuses the same application services:

`McpServerController -> ListToolsService / CallToolService -> work item application services -> repositories -> Azure DevOps APIs`

The main business capabilities live under `ddd.workitems.application`:

- `create_wi_epic`
- `create_wi_task`
- `get_wi_tasks`
- `update_wi_task`
- `search_work_items`
- `get_wi_detail`

Repository classes in `ddd.workitems.infrastructure.repositories` are the only layer that should build WIQL, JSON Patch payloads, Azure DevOps URLs, and authenticated `aiohttp` requests.

## Key conventions

- Keep the DDD split intact: FastAPI/Pydantic request handling stays in controllers, orchestration stays in application services, and Azure DevOps HTTP details stay in repositories.
- Input and result objects are usually `@dataclass(frozen=True, slots=True)` DTOs with `from_primitives()` constructors. Controllers and MCP handlers should convert raw payloads into DTOs early.
- Controllers return the repository-wide response envelope through `ResponseDto`, `SuccessResponseDto`, or `ErrorResponseDto`, so HTTP responses should keep the `{code, status, message, data}` shape.
- The codebase consistently uses `get_instance()` factory methods for controllers, services, repositories, and shared components instead of wiring long-lived singletons manually.
- Most DTOs accept an empty `project` and then resolve it from `APP_DEFAULT_PROJECT` via `EnvironmentReaderRawRepository`. Preserve that fallback when adding new work-item use cases.
- Azure DevOps work item calls are async and use JSON Patch operations. For create/update behavior, follow the existing repository pattern instead of building raw requests in services.
- Task due dates are inferred from a title suffix in `YYYY-MM-DD` format and then mapped to `Microsoft.VSTS.Scheduling.TargetDate`.
- The MCP tool names currently exposed by code are `create_wi_epic`, `create_wi_task`, `get_tasks`, `update_task`, `search_work_items`, and `get_work_item_detail`.
- Logging is file-based through `ddd.shared.infrastructure.components.logger.Logger` and writes under `logs/` or `APP_LOG_PATH`; use that logger instead of ad hoc prints for runtime diagnostics.
- `CLAUDE.md` is relevant for this repo: Python changes should stay fully typed, use async/await patterns already present in the codebase, and preserve the existing DDD structure around `ddd.shared`, `ddd.workitems`, and `ddd.mcp_work_items`.
