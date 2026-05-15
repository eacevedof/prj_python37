"""Entidad de dominio para grupos de palabras."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass
class WordGroupEntity:
    """Entidad que representa un grupo de palabras."""

    id: int
    title: str
    description: str = ""
    created_at: str = ""
    updated_at: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        """Crea una instancia desde datos primitivos."""
        return cls(
            id=int(primitives.get("id", 0)),
            title=str(primitives.get("title", "")).strip(),
            description=str(primitives.get("description", "") or "").strip(),
            created_at=str(primitives.get("created_at", "")),
            updated_at=str(primitives.get("updated_at", "")),
        )

    def to_primitives(self) -> dict[str, Any]:
        """Convierte la entidad a diccionario de primitivos."""
        return {
            "id": self.id,
            "title": self.title,
            "description": self.description,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
        }

    def validate(self) -> list[str]:
        """Valida la entidad y retorna lista de errores."""
        errors = []

        if not self.title or len(self.title.strip()) == 0:
            errors.append("Title is required")

        if len(self.title) > 100:
            errors.append("Title must be 100 characters or less")

        # Validar que el título solo contenga caracteres válidos (inglés)
        if not self.title.replace(" ", "").replace("-", "").replace("_", "").isalnum():
            errors.append("Title must contain only alphanumeric characters, spaces, hyphens, and underscores")

        return errors
