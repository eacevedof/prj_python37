# CLAUDE.md - ia-mcps

MCP servers con arquitectura DDD en Python 3.12+.

---

## Stack

- **Python 3.12+**, aiohttp
- **MCP SDK** para servidores MCP
- **Linting**: ruff, mypy
- **Testing**: pytest, pytest-asyncio, pytest-cov

## Arquitectura

Proyecto organizado en **DDD** (Domain-Driven Design):

```
ddd/
├── emt/                   # Dominio EMT Madrid (lógica de negocio)
│   ├── application/       # Casos de uso (get_stop_arrivals, get_lines_info, etc.)
│   ├── domain/            # Enums, exceptions
│   └── infrastructure/    # Repository API EMT
├── mcp_emt/               # MCP Server EMT
│   ├── application/       # list_tools, call_tool
│   ├── domain/            # ToolNameEnum
│   └── infrastructure/
│       ├── controllers/   # McpEmtController
│       └── repositories/  # ToolsSchemaRepository
└── shared/                # Shared kernel
    ├── domain/enums/      # EnvvarsKeysEnum
    └── infrastructure/
        └── components/    # Logger
```

## Variables de entorno

```bash
# Application (opcional)
APP_LOG_PATH=./logs

# EMT Madrid API (https://mobilitylabs.emtmadrid.es)
EMT_CLIENT_ID=your-client-id
EMT_PASSKEY=your-passkey
```

## Comandos

```bash
# Linting
ruff check .
mypy .

# Tests
pytest --cov

# Run MCP EMT
python -m ddd.mcp_emt
```

## MCP Tools (mcp_emt)

| Tool | Descripción |
|------|-------------|
| `emt_get_stop_arrivals` | Llegadas en tiempo real a una parada |
| `emt_get_lines_info` | Información de todas las líneas |
| `emt_get_stops_around` | Paradas cercanas a coordenadas |
| `emt_get_stop_detail` | Detalle de una parada específica |

---

## Skills (dev-ops)

Cargar skills desde `C:/projects/temper/ai/obsidian/dev-ops/skills/` según la tarea:

| Skill | Path | Usar cuando |
|-------|------|-------------|
| Global Preferences | `_base/global-preferences/` | Cualquier tarea |
| Karpathy Guidelines | `_base/karpathy-guidelines/` | Cualquier tarea (simplicidad) |
| Commits | `_base/commits/` | Preparando commits |
| DDD Architecture | `_base/ddd-architecture/` | Diseño de módulos, servicios, DTOs |
| Git Flow | `_base/git-flow/` | Branching, PRs, merges |
| Python Pro | `python/python-pro/` | Desarrollo Python 3.12+ |
| Clean Code | `python/clean-code/` | Refactoring, code review |
| Async Patterns | `python/async-patterns/` | asyncio, concurrencia |
| Type Safety | `python/type-safety/` | Type hints, mypy, generics |
| Error Handling | `python/error-handling/` | Excepciones, validación |
| Code Style | `python/code-style/` | Formato, docstrings, ruff |
