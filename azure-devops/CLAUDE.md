# Azure DevOps MCP Server

MCP Server para integrar Claude Code con Azure DevOps. Implementado con FastAPI y arquitectura DDD.

---

## Skills (centralizadas en dev-ops)

**Path**: `C:/projects/temper/ai/obsidian/dev-ops/skills`

| Categoria | Skills |
|-----------|--------|
| Base | `_base/commits/`, `_base/ddd-architecture/`, `_base/karpathy-guidelines/` |
| Python | `python/clean-code/`, `python/python-pro/`, `python/fastapi-pro/`, `python/async-patterns/`, `python/type-safety/`, `python/error-handling/` |

## Skills locales (específicas del proyecto)

| Skill | Descripción |
|-------|-------------|
| `.claude/skills/workitems-conventions-skill.md` | Convenciones para crear work items en Azure DevOps |
| `.claude/agents/azure-devops-workitems-ag.md` | Agente especializado en gestión de work items |

---

## Stack Tecnológico

- Python 3.12+ con FastAPI 0.135+
- Arquitectura DDD (Domain-Driven Design)
- Async/await patterns
- Type hints estrictos (mypy)

## Estructura del Proyecto

```
azure-devops/
├── CLAUDE.md
├── .claude/
│   ├── settings.local.json
│   ├── skills/
│   │   └── workitems-conventions-skill.md    ← Específico del proyecto
│   └── agents/
│       └── azure-devops-workitems-ag.md      ← Específico del proyecto
│
└── ddd/
    ├── mcp/           # MCP Server (ListTools, CallTool)
    ├── workitems/     # Gestión de Work Items (Epic, Task)
    └── shared/        # Componentes compartidos (Logger, Curler, etc.)
```

## Herramientas MCP Disponibles

| Tool | Descripción |
|------|-------------|
| `create_epic` | Crear épicas en Azure DevOps |
| `create_task` | Crear tareas vinculadas a épicas |
| `get_tasks` | Listar tareas con filtros |
| `update_task` | Actualizar estado/asignación de tareas |

## Comandos de Desarrollo

```bash
# Activar entorno virtual (Windows)
.venv-win\Scripts\activate

# Ejecutar servidor
uvicorn ddd.shared.infrastructure.fastapi_app:app --reload --port 8303

# Linting y formateo
ruff check --fix .
ruff format .

# Type checking
mypy ddd/

# Tests
pytest
```

## Variables de Entorno

Configurar en `.env`:
- `AZURE_ORGANIZATION_NAME` - Organización de Azure DevOps
- `AZURE_PAT` - Personal Access Token
- `AZURE_API_VERSION` - Versión de la API (default: 7.1)
