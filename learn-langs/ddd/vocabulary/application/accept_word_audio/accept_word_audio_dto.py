"""DTO de entrada para AcceptWordAudioService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class AcceptWordAudioDto:
    """DTO de entrada para aceptar la propuesta temporal de audio."""

    word_id: int = 0
    lang_code: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            word_id=int(primitives.get("word_id", 0)),
            lang_code=str(primitives.get("lang_code", "")).strip(),
        )
