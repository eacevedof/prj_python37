"""DTO de resultado para FinishStudySessionService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class FinishStudySessionResultDto:
    """DTO de resultado al finalizar sesion."""

    session_id: int = 0
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            session_id=int(primitives.get("session_id", 0)),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def ok(cls, session_id: int) -> Self:
        return cls.from_primitives({"session_id": session_id})

    @classmethod
    def error(cls, message: str) -> Self:
        return cls.from_primitives({"error_message": message})

    @property
    def success(self) -> bool:
        return self.error_message is None
