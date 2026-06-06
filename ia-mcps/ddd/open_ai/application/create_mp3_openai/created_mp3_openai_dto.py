"""Result DTO for created audio with OpenAI."""

from dataclasses import dataclass


@dataclass(frozen=True, slots=True)
class CreatedMp3OpenaiDto:
    """Result DTO for audio generation with OpenAI."""

    audio_b64: str
    mime_type: str
    text: str
    model: str
    voice: str
    speed: float
    format: str
