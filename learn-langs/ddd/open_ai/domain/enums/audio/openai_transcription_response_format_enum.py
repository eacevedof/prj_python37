"""Enum for OpenAI Whisper API transcription response formats."""

from enum import StrEnum
from typing import final


@final
class OpenaiTranscriptionResponseFormatEnum(StrEnum):
    """Response format options for OpenAI Whisper transcription API."""

    TEXT = "text"
    JSON = "json"
    VERBOSE_JSON = "verbose_json"
    SRT = "srt"
    VTT = "vtt"
