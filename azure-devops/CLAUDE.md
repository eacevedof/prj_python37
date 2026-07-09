# Azure DevOps MCP Server

Coleccion de MCP Servers (Python 3.12+, arquitectura DDD) para integrar Claude Code con Azure DevOps, Outlook (Microsoft Graph), Git, SharePoint, Calendar, MySQL local y herramientas de desarrollo local. Infraestructura de la pipeline de automatizacion Lazarus↔Enova.

---

## 📚 Documentación centralizada (Obsidian)

**Ficha completa del proyecto** (estructura, MCPs + registro, env vars, auth Outlook, comandos):
```
C:\projects\temper\ai\obsidian\projects\azure-devops\azure-devops.md
```

**Patrones de código** (DDD, DTOs, services, handlers MCP, componentes shared, reglas de calidad):
```
C:\projects\temper\ai\obsidian\projects\azure-devops\azure-devops-code.md
```

**Backlog del repo**:
```
C:\projects\temper\ai\obsidian\projects\azure-devops\azure-devops-to-do.md
```

**Pipeline de automatización** (contexto de negocio, estado, roadmap):
```
C:\projects\temper\ai\obsidian\projects\automation\automation.md
```

**Skill de análisis de solicitudes** (el "cerebro" de la pipeline):
```
C:\projects\temper\ai\obsidian\projects\automation\workitem-analysis-skill.md
```

**Catálogo de proyectos** (proyecto → tech → repo → git):
```
C:\projects\temper\ai\obsidian\projects\_catalog.md
```

## 🛠️ Skills

- **Centralizadas** (base + python): `C:/projects/temper/ai/obsidian/dev-ops/skills`
- **Locales del repo**: `.claude/skills/workitems-conventions-skill.md` · `.claude/agents/azure-devops-workitems-ag.md`

## ⚡ Arranque rápido

```bash
.venv-win\Scripts\activate
python -m ddd                                                # servidor MCP (stdio)
python -m ddd.outlook.infrastructure.cli.device_login_cli    # login Outlook (una vez)
make gitpush m="mensaje"
```

## Path Mapping

```
WSL: /mnt/c/projects/prj_python37/azure-devops -> Windows: C:\projects\prj_python37\azure-devops
```
