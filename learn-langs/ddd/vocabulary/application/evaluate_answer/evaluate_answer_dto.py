"""Input DTO para EvaluateAnswerService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class EvaluateAnswerDto:
    """Respuesta a evaluar (sin persistir)."""

    expected_text: str
    user_input: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            expected_text=str(primitives.get("expected_text", "")),
            user_input=str(primitives.get("user_input", "") or ""),
        )
