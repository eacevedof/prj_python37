# CLAUDE.md - ia-mcps

MCP servers con arquitectura DDD en Python 3.12+ / FastAPI.

---

## Stack

- **Python 3.12+**, FastAPI, uvicorn, aiohttp
- **MCP SDK** para servidores MCP
- **Linting**: ruff, mypy
- **Testing**: pytest, pytest-asyncio, pytest-cov

## Arquitectura

Proyecto organizado en **DDD** (Domain-Driven Design):

```
ddd/
├── calendar/              # Dominio Calendar
│   ├── application/
│   ├── domain/
│   └── infrastructure/
├── mcp_calendar/          # MCP Server Calendar
│   ├── application/
│   ├── domain/
│   └── infrastructure/
│       ├── controllers/
│       └── repositories/
└── shared/                # Shared kernel
    ├── domain/
    └── infrastructure/
```

## Comandos

```bash
# Linting
ruff check .
mypy .

# Tests
pytest --cov

# Run MCP Calendar
python -m ddd.mcp_calendar
```

## API (Azure DevOps Work Items)

- Base: `http://localhost:8303`
- Endpoints: `/workitems/tasks`, `/workitems/epics`

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
| FastAPI Pro | `python/fastapi-pro/` | APIs con FastAPI |
| Clean Code | `python/clean-code/` | Refactoring, code review |
| Async Patterns | `python/async-patterns/` | asyncio, concurrencia |
| Type Safety | `python/type-safety/` | Type hints, mypy, generics |
| Error Handling | `python/error-handling/` | Excepciones, validación |
| Code Style | `python/code-style/` | Formato, docstrings, ruff |
