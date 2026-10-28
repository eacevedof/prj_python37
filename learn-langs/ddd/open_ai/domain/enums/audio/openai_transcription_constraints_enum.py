from enum import IntEnum
from typing import final


@final
class OpenaiTranscriptionConstraintsEnum(IntEnum):
    """Constraints and limits for OpenAI transcription (Whisper) API."""

    MAX_FILE_SIZE_MB = 25  # OpenAI API file size limit for audio files
    MAX_FILE_SIZE_BYTES = 25 * 1024 * 1024
