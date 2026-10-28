"""DTO de entrada para CreateWordGroupService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class CreateWordGroupDto:
    """DTO de entrada para crear un grupo de palabras."""

    title: str = ""
    description: str = ""
    source: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            title=str(primitives.get("title", "")).strip(),
            description=str(primitives.get("description", "") or "").strip(),
            source=str(primitives.get("source", "") or "").strip(),
        )

    def validate(self) -> list[str]:
        """Valida el DTO."""
        errors = []

        if not self.title:
            errors.append("Title is required")

        if len(self.title) > 100:
            errors.append("Title must be 100 characters or less")

        return errors
