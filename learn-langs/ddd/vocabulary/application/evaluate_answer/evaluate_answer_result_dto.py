"""Output DTO para EvaluateAnswerService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class EvaluateAnswerResultDto:
    """Resultado de evaluar una respuesta (sin persistir)."""

    score: float = 0.0
    is_correct: bool = False
    is_partial: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        score = float(primitives.get("score", 0.0))
        return cls(
            score=score,
            is_correct=score >= 1.0,
            is_partial=0.0 < score < 1.0,
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "score": self.score,
            "is_correct": self.is_correct,
            "is_partial": self.is_partial,
        }
