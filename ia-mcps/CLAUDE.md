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
├── mcp_media/             # MCP Server Media (images and audio)
│   ├── application/       # list_tools, call_tool
│   ├── domain/            # ToolNameEnum
│   └── infrastructure/
│       ├── controllers/   # McpMediaController
│       └── repositories/  # ToolsSchemaRepository
├── open_ai/                      # Dominio OpenAI (imágenes y audio)
│   ├── application/              # Casos de uso por proveedor
│   │   ├── create_image_openai/  # CreateImageOpenaiDto, CreateImageOpenaiService
│   │   └── create_mp3_openai/    # CreateMp3OpenaiDto, CreateMp3OpenaiService
│   ├── domain/                   # Exceptions (OpenAIException)
│   └── infrastructure/           # Repositories (Image, TTS)
│       └── repositories/         # GptImage1, GptTts1, AbstractOpenAIApi
└── shared/                # Shared kernel
    ├── domain/enums/      # EnvvarsKeysEnum, ResponseCodeEnum
    └── infrastructure/
        ├── components/    # Logger, Slugger
        └── repositories/  # EnvironmentReaderRawRepository
```

## Variables de entorno

```bash
# Application (opcional)
APP_LOG_PATH=./logs

# EMT Madrid API (https://mobilitylabs.emtmadrid.es)
EMT_CLIENT_ID=your-client-id
EMT_PASSKEY=your-passkey

# OpenAI API (https://platform.openai.com/api-keys)
OPENAI_API_KEY=your-openai-api-key

# Media output directory for generated images and audio
MEDIA_OUTPUT_DIR=C:\projects\tmp
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

# Run MCP Media
python -m ddd.mcp_media
```
## spec más importante y se aplica siempre
cargar este espec `C:/projects/temper/ai/obsidian/dev-ops/skills/_base/eskylet-claude.md`


## OpenAI Services (open_ai)

Casos de uso genéricos para generación de imágenes y audio con OpenAI API.

### CreateImageOpenaiService

Genera imágenes con modelos de OpenAI totalmente parametrizados.

**DTO**: `CreateImageOpenaiDto`
- `prompt`: Descripción completa de la imagen
- `model`: "gpt-image-1.5" | "dall-e-3" | "dall-e-2"
- `size`: "256x256" | "512x512" | "1024x1024" | "1024x1792" | "1792x1024"
- `quality`: "low" | "high"
- `style`: "natural" | "vivid" (solo dall-e-3)
- `n`: 1-10 (número de imágenes)

**Ejemplo**:
```python
from ddd.open_ai.application import CreateImageOpenaiDto, CreateImageOpenaiService

dto = CreateImageOpenaiDto(
    prompt="A futuristic city with flying cars at sunset",
    model="gpt-image-1.5",
    size="1024x1024",
    quality="low",
    n=1
)

result = CreateImageOpenaiService.get_instance()(dto)
# result["images"][0]["b64_json"] - Imagen en base64
```

### CreateMp3OpenaiService

Genera audio TTS con modelos de OpenAI totalmente parametrizados.

**DTO**: `CreateMp3OpenaiDto`
- `text`: Texto a convertir (máx 4096 caracteres)
- `voice`: "alloy" | "echo" | "fable" | "onyx" | "nova" | "shimmer"
- `model`: "tts-1" | "tts-1-hd"
- `speed`: 0.25 - 4.0
- `response_format`: "mp3" | "opus" | "aac" | "flac" | "wav" | "pcm"

**Ejemplo**:
```python
from ddd.open_ai.application import CreateMp3OpenaiDto, CreateMp3OpenaiService

dto = CreateMp3OpenaiDto(
    text="Hello, this is a test of text to speech",
    voice="nova",
    model="tts-1",
    speed=1.0,
    response_format="mp3"
)

result = CreateMp3OpenaiService.get_instance()(dto)
# result["audio_b64"] - Audio en base64
```

**Ver ejemplos completos**: `ddd/open_ai/USAGE_EXAMPLES.md`

---

## MCP Tools

### mcp_emt

| Tool | Descripción |
|------|-------------|
| `emt_get_stop_arrivals` | Llegadas en tiempo real a una parada |
| `emt_get_lines_info` | Información de todas las líneas |
| `emt_get_stops_around` | Paradas cercanas a coordenadas |
| `emt_get_stop_detail` | Detalle de una parada específica |

### mcp_media

| Tool | Descripción |
|------|-------------|
| `media_create_image` | Genera imágenes desde un prompt y las guarda en disco |
| `media_create_audio` | Genera audio TTS desde texto y lo guarda en disco |

**Características**:
- Auto-genera nombres de archivo usando los primeros 25 caracteres del prompt en formato slug + timestamp (yyyymmdd-hhmmss)
- Soporta nombres de archivo personalizados (opcional)
- Guarda archivos en el directorio configurado en `MEDIA_OUTPUT_DIR`
- Soporta múltiples imágenes con sufijos numerados
- Retorna las rutas de los archivos generados

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
