from enum import StrEnum
from typing import final


@final
class OpenaiTranscriptionModelEnum(StrEnum):
    """
    OpenAI models for audio transcription.
    models only for audio to text
    """

    WHISPER_1 = "whisper-1"
    GPT_4O_TRANSCRIBE = "gpt-4o-transcribe"
    GPT_4O_MINI_TRANSCRIBE = "gpt-4o-mini-transcribe"
    GPT_4O_MINI_TRANSCRIBE_2025_12_15 = "gpt-4o-mini-transcribe-2025-12-15"
    GPT_4O_TRANSCRIBE_DIARIZE = "gpt-4o-transcribe-diarize"
