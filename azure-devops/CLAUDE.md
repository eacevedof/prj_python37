# Azure DevOps MCP Server

Coleccion de MCP Servers para integrar Claude Code con Azure DevOps, SharePoint, Calendar y herramientas de desarrollo local. Implementado con FastAPI y arquitectura DDD.

---

## Skills (centralizadas en dev-ops)

**Path**: `C:/projects/temper/ai/obsidian/dev-ops/skills`

| Categoria | Skills |
|-----------|--------|
| Base | `_base/commits/`, `_base/ddd-architecture/`, `_base/karpathy-guidelines/`, `_base/global-preferences/` |
| Python | `python/clean-code/`, `python/python-pro/`, `python/fastapi-pro/`, `python/async-patterns/`, `python/type-safety/`, `python/error-handling/` |

## Skills locales (especificas del proyecto)

| Skill | Descripcion |
|-------|-------------|
| `.claude/skills/workitems-conventions-skill.md` | Convenciones para crear work items en Azure DevOps |
| `.claude/agents/azure-devops-workitems-ag.md` | Agente especializado en gestion de work items |

---

## Stack Tecnologico

- Python 3.12+
- FastAPI 0.135+
- aiohttp (async HTTP client)
- MCP SDK
- Arquitectura DDD (Domain-Driven Design)
- Async/await patterns
- Type hints estrictos (mypy)
- Ruff (linting + formatting)
- Pytest (testing)

## Estructura del Proyecto

```
azure-devops/
├── CLAUDE.md
├── makefile
├── requirements.txt
├── .env / .env.example
├── .claude/
│   ├── settings.local.json
│   ├── skills/
│   │   └── workitems-conventions-skill.md
│   └── agents/
│       └── azure-devops-workitems-ag.md
│
└── ddd/
    ├── __init__.py           # Entry point MCP servers
    │
    ├── mcp_work_items/       # MCP: Azure DevOps Work Items
    ├── mcp_calendar/         # MCP: Calendar/Events
    ├── mcp_sharepoint/       # MCP: SharePoint
    ├── mcp_local_devops/     # MCP: Local Dev Setup
    ├── mcp_hashed_pwd/       # MCP: Password Hashing
    ├── mcp_anubis/           # MCP: Anubis Integration
    │
    ├── workitems/            # Domain: Work Items (Epic, Task)
    ├── calendar/             # Domain: Calendar Events
    ├── sharepoint/           # Domain: SharePoint
    ├── devops/               # Domain: DevOps Tools
    │
    └── shared/               # Componentes compartidos
        ├── components/       # Logger, Curler, etc.
        ├── enums/
        ├── exceptions/
        └── infrastructure/   # FastAPI app
```

## MCP Servers Disponibles

| MCP Server | Tools | Descripcion |
|------------|-------|-------------|
| `mcp_work_items` | create_epic, create_task, get_tasks, update_task, search_work_items | Gestion de work items Azure DevOps |
| `mcp_calendar` | create_event, list_events, get_event, update_event, delete_event, add_holiday | Gestion de calendario |
| `mcp_sharepoint` | - | Integracion SharePoint |
| `mcp_local_devops` | local_setup_project, local_get_next_port | Setup de proyectos PHP locales |
| `mcp_hashed_pwd` | get_hashed_passwords | Generacion de passwords hasheados |
| `mcp_anubis` | request_anubis | Consultas a Anubis |

## Comandos de Desarrollo

```bash
# Activar entorno virtual (Windows)
.venv-win\Scripts\activate

# Ejecutar servidor MCP (stdio)
python -m ddd

# Linting y formateo
ruff check --fix .
ruff format .

# Type checking
mypy ddd/

# Tests
pytest
pytest --cov=ddd

# Git
make gitpush m="mensaje"
make gp-def  # commit con mensaje default
```

## Variables de Entorno

Configurar en `.env`:

```bash
# Azure DevOps
AZURE_ORGANIZATION_NAME=mi-org
AZURE_PAT=xxxx
AZURE_API_VERSION=7.1

# SharePoint
SHAREPOINT_TENANT_ID=xxxx
SHAREPOINT_CLIENT_ID=xxxx
SHAREPOINT_CLIENT_SECRET=xxxx

# Local DevOps
DOCKER_LAMP_PATH=C:/projects/prj_docker_lamp
```

## Arquitectura DDD por Modulo

```
{modulo}/
├── application/              # Casos de uso
│   └── {use_case}/
│       ├── __init__.py
│       ├── {use_case}_dto.py
│       ├── {use_case}_service.py
│       └── {use_case}_result_dto.py
├── domain/
│   ├── enums/
│   └── exceptions/
└── infrastructure/
    └── repositories/
```

## Patrones de Codigo

### DTO (Data Transfer Object)
```python
@dataclass(frozen=True)
class CreateTaskDto:
    project: str
    title: str
    epic_id: int
    assigned_to: str = ""

    @classmethod
    def from_primitives(cls, data: dict[str, Any]) -> "CreateTaskDto":
        return cls(
            project=str(data.get("project", "")),
            title=str(data.get("title", "")),
            epic_id=int(data.get("epic_id", 0)),
            assigned_to=str(data.get("assigned_to", "")),
        )
```

### Service
```python
class CreateTaskService:
    def __init__(self) -> None:
        self._repository = WorkItemsRepository()

    async def __call__(self, dto: CreateTaskDto) -> CreateTaskResultDto:
        # Validaciones
        if not dto.title:
            raise WorkItemsException("Title is required")

        # Logica de negocio
        result = await self._repository.create_task(...)

        return CreateTaskResultDto.from_primitives(result)
```

### MCP Tool Handler
```python
@mcp_server.call_tool()
async def handle_call_tool(name: str, arguments: dict) -> list[TextContent]:
    match name:
        case "create_task":
            dto = CreateTaskDto.from_primitives(arguments)
            result = await CreateTaskService()(dto)
            return [TextContent(type="text", text=result.to_json())]
        case _:
            raise ValueError(f"Unknown tool: {name}")
```

## Ramas Git

- `master` - Produccion
- `develop` - Desarrollo

## Path Mapping

```
WSL: /mnt/c/projects/prj_python37/azure-devops -> Windows: C:\projects\prj_python37\azure-devops
```
