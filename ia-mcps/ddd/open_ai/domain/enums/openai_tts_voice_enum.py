from enum import StrEnum
from typing import final


@final
class OpenaiTtsVoiceEnum(StrEnum):
    """Voces disponibles para TTS con OpenAI."""

    ALLOY = "alloy"
    ECHO = "echo"
    FABLE = "fable"
    ONYX = "onyx"
    NOVA = "nova"
    SHIMMER = "shimmer"
