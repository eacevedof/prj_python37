# Learn Languages App

Aplicacion Flet de aprendizaje de idiomas con repeticion espaciada (SM-2): vocabulario español → multi-idioma (uso real: neerlandes), sesiones de estudio con metricas, y generacion de audio/imagenes con IA (OpenAI). Python 3.12+ · SQLite · DDD.

---

## 📚 Documentación centralizada (Obsidian)

**Ficha completa del proyecto** (stack, estructura real, casos de uso, comandos):
```
C:\projects\temper\ai\obsidian\projects\learn-langs\learn-langs.md
```

**Modelo de datos** (ER, idiomas, historial de migraciones):
```
C:\projects\temper\ai\obsidian\projects\learn-langs\learn-langs-schema.md
```

**Patrones de código y algoritmos** (DDD, score Levenshtein, SM-2, flujo de estudio, módulo open_ai):
```
C:\projects\temper\ai\obsidian\projects\learn-langs\learn-langs-code.md
```

## 🛠️ Skills

- **Centralizadas** (base + python + flet + sqlite): `C:/projects/temper/ai/obsidian/dev-ops/skills`
- **Spec que se aplica siempre**: `C:/projects/temper/ai/obsidian/dev-ops/skills/_base/eskylet-claude.md`

## ⚡ Arranque rápido

```bash
.venv-win\Scripts\activate
python front_controller.py        # ejecutar la app
ruff check --fix . && ruff format .
mypy ddd/
```

## Notas

- Los vocabularios se cargan por **migración SQL** (`ddd/vocabulary/infrastructure/persistence/migrations/`, naming `YYYYMMDDhhmmss-descripcion.sql`), no a mano.
- `.env` contiene `OPENAI_API_KEY` — no imprimirla nunca.

## Path Mapping

```
WSL: /mnt/c/projects/prj_python37/learn-langs -> Windows: C:\projects\prj_python37\learn-langs
```
