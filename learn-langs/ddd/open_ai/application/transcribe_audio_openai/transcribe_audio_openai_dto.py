"""DTO for transcribing audio with OpenAI Whisper API."""

from dataclasses import dataclass
from typing import Self


@dataclass(frozen=True, slots=True)
class TranscribeAudioOpenaiDto:
    """DTO for parameterizing audio transcription with OpenAI Whisper."""

    audio_file_path: str
    model: str = "whisper-1"
    response_format: str = "text"
    language: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        audio_file_path = str(primitives.get("audio_file_path", "")).strip()
        model = str(primitives.get("model", "whisper-1"))
        response_format = str(primitives.get("response_format", "text"))
        language = primitives.get("language")

        return cls(
            audio_file_path=audio_file_path,
            model=model,
            response_format=response_format,
            language=str(language) if language else None,
        )

    def __post_init__(self) -> None:
        if not self.audio_file_path or not self.audio_file_path.strip():
            raise ValueError("TranscribeAudioOpenaiDto: audio_file_path cannot be empty")
