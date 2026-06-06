from enum import StrEnum
from typing import final


@final
class OpenaiTtsVoiceEnum(StrEnum):
    """Available voices for TTS with OpenAI."""

    ALLOY = "alloy"
    ECHO = "echo"
    FABLE = "fable"
    ONYX = "onyx"
    NOVA = "nova"
    SHIMMER = "shimmer"
