from enum import StrEnum
from typing import final


@final
class OpenaiTtsModelEnum(StrEnum):
    """Modelos de OpenAI para generación de audio TTS."""

    TTS_1 = "tts-1"
    TTS_1_HD = "tts-1-hd"
