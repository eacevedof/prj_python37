# ia-mcps

Servidores MCP por HTTP (EMT, Media, PDF, Memory, File Checker) + `voice_mod` (Claude Code por voz).
Python 3.14 · FastAPI · DDD modular `<x>_mod` (core) + `<x>_mcp` (fachada) · solo local. Gemelo
público del repo privado `prj-mcp-tools`: los cambios se copian a mano, por módulo.

**Documentación completa (Obsidian)**: `C:\projects\temper\ai\obsidian\projects\mcp-tools\mcp-tools-index.md`

- Lo propio de este repo (ficha, diferencias, arranque, `.env`, alta en Claude Code): `mcp-tools-ia-mcps.md`
- `voice_mod`: `mcp-tools-voice.md` · Arquitectura DDD: `mcp-tools-code.md` · Contratos: `mcp-tools-schema.md`
- Deuda: `mcp-tools-tech-debt.md` · En curso: `mcp-tools-doing.md` · Backlog: `mcp-tools-to-do.md`
- Norma DDD Python: `C:\projects\temper\ai\obsidian\dev-ops\_base\ddd-architecture\`

**Comandos**: `make help` · `make dev` (host, 127.0.0.1:8010) · `make test` · `make lint`

**Reglas**: nunca `git commit` ni `git push` desde Claude (los gestiona Eduardo).
