"""DTO de entrada para GetWordForEditService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetWordForEditDto:
    """DTO de entrada con el ID de la palabra."""

    word_id: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            word_id=int(primitives.get("word_id", 0)),
        )
