from dataclasses import dataclass
from typing import Self, Any


@dataclass(slots=True)
class SessionAnswerEntity:
    """Entidad: respuesta individual en una sesión de estudio."""

    id: int
    session_id: int
    word_es_id: int
    user_input: str = ""
    expected_text: str = ""
    score: float = 0.0
    response_time_ms: int = 0
    answered_at: str = ""

    @property
    def is_correct(self) -> bool:
        return self.score >= 1.0

    @property
    def is_partial(self) -> bool:
        return 0.0 < self.score < 1.0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            session_id=int(primitives.get("session_id", 0)),
            word_es_id=int(primitives.get("word_es_id", 0)),
            user_input=str(primitives.get("user_input", "") or ""),
            expected_text=str(primitives.get("expected_text", "")).strip(),
            score=float(primitives.get("score", 0.0)),
            response_time_ms=int(primitives.get("response_time_ms", 0) or 0),
            answered_at=str(primitives.get("answered_at", "") or ""),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "session_id": self.session_id,
            "word_es_id": self.word_es_id,
            "user_input": self.user_input,
            "expected_text": self.expected_text,
            "score": self.score,
            "response_time_ms": self.response_time_ms,
            "answered_at": self.answered_at,
            "is_correct": self.is_correct,
            "is_partial": self.is_partial,
        }
