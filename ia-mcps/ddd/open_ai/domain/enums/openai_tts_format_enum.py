from enum import StrEnum
from typing import final


@final
class OpenaiTtsFormatEnum(StrEnum):
    """Formatos de audio disponibles para TTS con OpenAI."""

    MP3 = "mp3"
    OPUS = "opus"
    AAC = "aac"
    FLAC = "flac"
    WAV = "wav"
    PCM = "pcm"
