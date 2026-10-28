"""DTO de entrada para GenerateWordAudioAiService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GenerateWordAudioAiDto:
    """DTO de entrada para generar audio con IA."""

    word_lang_id: int = 0
    text: str = ""
    lang_code: str = ""
    voice: str | None = None
    speed: float = 1.0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            word_lang_id=int(primitives.get("word_lang_id", 0)),
            text=str(primitives.get("text", "")),
            lang_code=str(primitives.get("lang_code", "")),
            voice=primitives.get("voice"),
            speed=float(primitives.get("speed", 1.0)),
        )
