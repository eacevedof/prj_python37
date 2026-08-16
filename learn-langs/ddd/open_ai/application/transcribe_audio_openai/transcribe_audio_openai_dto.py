"""DTO for transcribing audio with OpenAI Whisper API."""

from dataclasses import dataclass
from typing import Self

from ddd.open_ai.domain.enums import (
    OpenaiTranscriptionModelEnum,
    OpenaiTranscriptionResponseFormatEnum,
)


@dataclass(frozen=True, slots=True)
class TranscribeAudioOpenaiDto:
    """DTO for parameterizing audio transcription with OpenAI Whisper."""

    audio_file_path: str
    model: str = OpenaiTranscriptionModelEnum.WHISPER_1
    response_format: str = OpenaiTranscriptionResponseFormatEnum.TEXT
    language: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        language = primitives.get("language")

        return cls(
            audio_file_path=str(primitives.get("audio_file_path", "")).strip(),
            model=str(primitives.get("model", OpenaiTranscriptionModelEnum.WHISPER_1)),
            response_format=str(
                primitives.get("response_format", OpenaiTranscriptionResponseFormatEnum.TEXT)
            ),
            language=str(language) if language else None,
        )
