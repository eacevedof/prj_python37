"""Result DTO for audio generation with OpenAI."""

from dataclasses import dataclass
from typing import Self


@dataclass(frozen=True, slots=True)
class CreateMp3OpenaiResultDto:
    """Result DTO for audio generation with OpenAI."""

    audio_b64: str
    mime_type: str
    text: str
    model: str
    voice: str
    speed: float
    format: str

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        audio_b64 = str(primitives.get("audio_b64", ""))
        mime_type = str(primitives.get("mime_type", ""))
        text = str(primitives.get("text", ""))
        model = str(primitives.get("model", ""))
        voice = str(primitives.get("voice", ""))
        speed = float(primitives.get("speed", 1.0))
        format_value = str(primitives.get("format", ""))

        return cls(
            audio_b64=audio_b64,
            mime_type=mime_type,
            text=text,
            model=model,
            voice=voice,
            speed=speed,
            format=format_value,
        )
