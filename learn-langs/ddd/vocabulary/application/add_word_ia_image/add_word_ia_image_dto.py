"""DTO de entrada para AddWordIaImageService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class AddWordIaImageDto:
    """DTO de entrada para agregar imagen generada con IA a palabra."""

    word_id: int = 0
    lang_code: str = "nl_NL"

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            word_id=int(primitives.get("word_id", 0)),
            lang_code=str(primitives.get("lang_code", "nl_NL")),
        )
