"""DTO de entrada para DeleteWordGroupService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DeleteWordGroupDto:
    """DTO para eliminar un grupo de palabras."""

    group_id: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            group_id=int(primitives.get("group_id", 0)),
        )

    def validate(self) -> list[str]:
        """Valida los datos del DTO."""
        errors: list[str] = []

        if not self.group_id or self.group_id <= 0:
            errors.append("group_id es requerido y debe ser mayor a 0")

        return errors
