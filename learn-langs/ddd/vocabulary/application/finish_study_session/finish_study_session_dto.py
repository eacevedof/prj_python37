"""DTO de entrada para FinishStudySessionService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class FinishStudySessionDto:
    """DTO de entrada para finalizar sesion de estudio."""

    session_id: int = 0
    lang_code: str = ""
    study_mode: str = "TYPING"

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            session_id=int(primitives.get("session_id", 0)),
            lang_code=str(primitives.get("lang_code", "")),
            study_mode=str(primitives.get("study_mode", "TYPING")),
        )
