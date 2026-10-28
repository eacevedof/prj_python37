"""Input DTO para borrar el estado de una actividad (sesión completada)."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ClearActivityStateDto:
    """Input DTO para borrar el estado guardado de una actividad."""

    activity: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            activity=str(primitives.get("activity", "")).strip(),
        )

    def validate(self) -> list[str]:
        """Valida el DTO y retorna lista de errores."""
        errors: list[str] = []

        if not self.activity:
            errors.append("'activity' is required")

        return errors
