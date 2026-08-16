from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class RecordAnswerDto:
    """Input DTO para registrar una respuesta."""

    session_id: int
    word_es_id: int
    user_input: str
    expected_text: str
    response_time_ms: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            session_id=int(primitives.get("session_id", 0)),
            word_es_id=int(primitives.get("word_es_id", 0)),
            user_input=str(primitives.get("user_input", "") or ""),
            expected_text=str(primitives.get("expected_text", "")),
            response_time_ms=int(primitives.get("response_time_ms", 0) or 0),
        )

    def validate(self) -> list[str]:
        """Valida el DTO y retorna lista de errores."""
        errors: list[str] = []

        if self.session_id <= 0:
            errors.append("'session_id' is required")

        if self.word_es_id <= 0:
            errors.append("'word_es_id' is required")

        if not self.expected_text:
            errors.append("'expected_text' is required")

        return errors
