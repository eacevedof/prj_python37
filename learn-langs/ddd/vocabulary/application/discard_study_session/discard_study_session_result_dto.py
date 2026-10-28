"""Output DTO para DiscardStudySessionService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DiscardStudySessionResultDto:
    """Resultado de descartar la sesión (borrada = True si existía)."""

    session_id: int = 0
    is_discarded: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            session_id=int(primitives.get("session_id", 0)),
            is_discarded=bool(primitives.get("is_discarded", False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "session_id": self.session_id,
            "is_discarded": self.is_discarded,
        }
