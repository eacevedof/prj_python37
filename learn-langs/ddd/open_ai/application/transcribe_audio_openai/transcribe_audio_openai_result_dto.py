"""Result DTO for audio transcription with OpenAI Whisper API."""

from dataclasses import dataclass
from typing import Self


@dataclass(frozen=True, slots=True)
class TranscribeAudioOpenaiResultDto:
    """Result DTO containing transcribed text from Whisper API."""

    transcribed_text: str
    audio_file_path: str
    model: str
    response_format: str
    language: str | None

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        return cls(
            transcribed_text=str(primitives.get("transcribed_text", "")),
            audio_file_path=str(primitives.get("audio_file_path", "")),
            model=str(primitives.get("model", "whisper-1")),
            response_format=str(primitives.get("response_format", "text")),
            language=primitives.get("language"),
        )
