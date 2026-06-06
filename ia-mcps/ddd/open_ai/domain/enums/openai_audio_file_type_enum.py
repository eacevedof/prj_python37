from enum import StrEnum
from typing import final


@final
class OpenaiAudioFileTypeEnum(StrEnum):
    """OpenAI supported audio file types for transcription and translation."""

    FLAC = "flac"
    MP3 = "mp3"
    MP4 = "mp4"
    MPEG = "mpeg"
    MPGA = "mpga"
    M4A = "m4a"
    OGG = "ogg"
    WAV = "wav"
    WEBM = "webm"
