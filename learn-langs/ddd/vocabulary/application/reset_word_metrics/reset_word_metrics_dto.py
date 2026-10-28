"""Input DTO para reiniciar el progreso de estudio (SM-2) de una palabra."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ResetWordMetricsDto:
    """Input DTO para reiniciar las métricas SM-2 de una palabra en un idioma."""

    word_es_id: int
    lang_code: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            word_es_id=int(primitives.get("word_es_id", 0)),
            lang_code=str(primitives.get("lang_code", "")).strip(),
        )

    def validate(self) -> list[str]:
        """Valida el DTO y retorna lista de errores."""
        errors: list[str] = []

        if self.word_es_id <= 0:
            errors.append("'word_es_id' is required")

        if not self.lang_code:
            errors.append("'lang_code' is required")

        return errors
