"""DTO de entrada para eliminar una palabra."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DeleteWordDto:
    """Input DTO para eliminar una palabra."""

    word_id: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            word_id=int(primitives.get("word_id", 0)),
        )

    def validate(self) -> list[str]:
        """Valida el DTO y retorna lista de errores."""
        errors: list[str] = []

        if self.word_id <= 0:
            errors.append("'word_id' must be a positive integer")

        return errors
