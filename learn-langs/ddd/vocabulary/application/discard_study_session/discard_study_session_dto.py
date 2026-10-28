"""Input DTO para DiscardStudySessionService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DiscardStudySessionDto:
    """Sesión a descartar (borrar) al abortar el examen."""

    session_id: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(session_id=int(primitives.get("session_id", 0)))
