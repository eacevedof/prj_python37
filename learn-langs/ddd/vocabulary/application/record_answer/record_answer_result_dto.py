from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class RecordAnswerResultDto:
    """Output DTO con el resultado de registrar una respuesta."""

    answer_id: int
    session_id: int
    word_es_id: int
    user_input: str
    expected_text: str
    score: float
    is_correct: bool
    is_partial: bool
    response_time_ms: int

    # Métricas actualizadas
    new_repetitions: int
    new_easiness_factor: float
    new_interval_days: int
    next_review_at: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        score = float(primitives.get("score", 0.0))

        return cls(
            answer_id=int(primitives.get("answer_id", 0)),
            session_id=int(primitives.get("session_id", 0)),
            word_es_id=int(primitives.get("word_es_id", 0)),
            user_input=str(primitives.get("user_input", "") or ""),
            expected_text=str(primitives.get("expected_text", "")),
            score=score,
            is_correct=score >= 1.0,
            is_partial=0.0 < score < 1.0,
            response_time_ms=int(primitives.get("response_time_ms", 0) or 0),
            new_repetitions=int(primitives.get("new_repetitions", 0)),
            new_easiness_factor=float(primitives.get("new_easiness_factor", 2.5)),
            new_interval_days=int(primitives.get("new_interval_days", 1)),
            next_review_at=str(primitives.get("next_review_at", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "answer_id": self.answer_id,
            "session_id": self.session_id,
            "word_es_id": self.word_es_id,
            "user_input": self.user_input,
            "expected_text": self.expected_text,
            "score": self.score,
            "is_correct": self.is_correct,
            "is_partial": self.is_partial,
            "response_time_ms": self.response_time_ms,
            "new_repetitions": self.new_repetitions,
            "new_easiness_factor": self.new_easiness_factor,
            "new_interval_days": self.new_interval_days,
            "next_review_at": self.next_review_at,
        }
