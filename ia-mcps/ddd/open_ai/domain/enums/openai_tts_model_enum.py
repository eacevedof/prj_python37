from enum import StrEnum
from typing import final


@final
class OpenaiTtsModelEnum(StrEnum):
    """OpenAI models for TTS audio generation."""

    TTS_1 = "tts-1"
    TTS_1_HD = "tts-1-hd"
