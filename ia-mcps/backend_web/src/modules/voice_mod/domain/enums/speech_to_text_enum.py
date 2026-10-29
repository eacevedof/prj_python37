from typing import final


@final
class SpeechToTextEnum:
    """Configuración de faster-whisper (medido en la RTX 4060: ~0,9 s por 6,6 s de audio)."""

    MODEL = "large-v3-turbo"
    DEVICE = "cuda"
    COMPUTE_TYPE = "float16"
    LANGUAGE = "es"
    # Vocabulario del proyecto: sin él, «voice_mod» sale como «voice mod» o «boys mod».
    INITIAL_PROMPT = (
        "Proyecto ia-mcps: voice_mod, voice_mcp, Claude Code, MCP, hook, tests, Obsidian, "
        "FastAPI, ruff, mypy, make dev."
    )
