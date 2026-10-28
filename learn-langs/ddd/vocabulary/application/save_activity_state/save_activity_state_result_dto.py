"""DTO de resultado para SaveActivityStateService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class SaveActivityStateResultDto:
    """DTO de resultado al guardar el estado de una actividad (retomar sesión)."""

    activity: str = ""
    is_saved: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            activity=str(primitives.get("activity", "")),
            is_saved=bool(primitives.get("is_saved", False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "activity": self.activity,
            "is_saved": self.is_saved,
        }
