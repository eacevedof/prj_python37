"""DTO de resultado para ResetWordMetricsService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ResetWordMetricsResultDto:
    """DTO de resultado al reiniciar las métricas SM-2 de una palabra."""

    word_es_id: int = 0
    lang_code: str = ""
    is_reset: bool = False  # False: no tenía métricas (ya estaba como nueva)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            word_es_id=int(primitives.get("word_es_id", 0)),
            lang_code=str(primitives.get("lang_code", "")),
            is_reset=bool(primitives.get("is_reset", False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "word_es_id": self.word_es_id,
            "lang_code": self.lang_code,
            "is_reset": self.is_reset,
        }
