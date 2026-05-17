"""DTO de entrada para UpdateWordGroupService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class UpdateWordGroupDto:
    """DTO para actualizar un grupo de palabras."""

    group_id: int
    title: str
    description: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            group_id=int(primitives.get("group_id", 0)),
            title=str(primitives.get("title", "")).strip(),
            description=str(primitives.get("description", "")).strip(),
        )

    def validate(self) -> list[str]:
        """Valida los datos del DTO."""
        errors: list[str] = []

        if not self.group_id or self.group_id <= 0:
            errors.append("group_id es requerido y debe ser mayor a 0")

        if not self.title or not self.title.strip():
            errors.append("title es requerido")

        if len(self.title) > 100:
            errors.append("title debe tener máximo 100 caracteres")

        if len(self.description) > 500:
            errors.append("description debe tener máximo 500 caracteres")

        return errors
