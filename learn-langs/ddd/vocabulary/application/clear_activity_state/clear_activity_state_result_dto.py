"""DTO de resultado para ClearActivityStateService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ClearActivityStateResultDto:
    """DTO de resultado al borrar el estado de una actividad (sesión completada)."""

    activity: str = ""
    is_cleared: bool = False  # False: no había estado guardado que borrar

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            activity=str(primitives.get("activity", "")),
            is_cleared=bool(primitives.get("is_cleared", False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "activity": self.activity,
            "is_cleared": self.is_cleared,
        }
