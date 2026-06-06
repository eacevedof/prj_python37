from enum import StrEnum
from typing import final


@final
class OpenaiTtsFormatEnum(StrEnum):
    """Available audio formats for TTS with OpenAI."""

    MP3 = "mp3"
    OPUS = "opus"
    AAC = "aac"
    FLAC = "flac"
    WAV = "wav"
    PCM = "pcm"
