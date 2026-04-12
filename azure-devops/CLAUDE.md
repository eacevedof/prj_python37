# Azure DevOps MCP Server

MCP Server para integrar Claude Code con Azure DevOps. Implementado con FastAPI y arquitectura DDD.

## Stack Tecnológico

- Python 3.12+ con FastAPI 0.135+
- Arquitectura DDD (Domain-Driven Design)
- Async/await patterns
- Type hints estrictos (mypy)

## Estructura del Proyecto

```
ddd/
├── mcp/           # MCP Server (ListTools, CallTool)
├── workitems/     # Gestión de Work Items (Epic, Task)
└── shared/        # Componentes compartidos (Logger, Curler, etc.)
```

## Skills Obligatorias

Al escribir o modificar código en este proyecto, SIEMPRE sigue estas guías:

@.claude/skills/python-code-style-skill.md
@.claude/skills/python-error-handling-skill.md
@.claude/skills/python-type-safety-skill.md
@.claude/skills/async-python-patterns-skill.md
@.claude/skills/workitems-conventions-skill.md

## Agentes Especializados

Para tareas complejas, usa estos agentes como referencia:

- @.claude/agents/python-pro-ag.md - Desarrollo Python avanzado
- @.claude/agents/fastapi-pro-ag.md - Endpoints y APIs con FastAPI
- @.claude/agents/azure-devops-workitems-ag.md - Gestión de work items con Azure CLI

## Herramientas MCP Disponibles

Este proyecto expone las siguientes herramientas via MCP:

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
