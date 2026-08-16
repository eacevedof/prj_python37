from dataclasses import dataclass
from typing import Self, Any


@dataclass(slots=True)
class WordMetricEntity:
    """Entidad: métricas SM-2 por palabra+idioma."""

    id: int
    word_es_id: int
    lang_code: str
    repetitions: int = 0
    easiness_factor: float = 2.5
    interval_days: int = 1
    next_review_at: str = ""
    last_reviewed_at: str = ""
    total_attempts: int = 0
    total_score: float = 0.0
    created_at: str = ""
    updated_at: str = ""

    @property
    def average_score(self) -> float:
        """Calcula el score promedio histórico."""
        if self.total_attempts == 0:
            return 0.0
        return round(self.total_score / self.total_attempts, 2)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            word_es_id=int(primitives.get("word_es_id", 0)),
            lang_code=str(primitives.get("lang_code", "")).strip(),
            repetitions=int(primitives.get("repetitions", 0)),
            easiness_factor=float(primitives.get("easiness_factor", 2.5)),
            interval_days=int(primitives.get("interval_days", 1)),
            next_review_at=str(primitives.get("next_review_at", "") or ""),
            last_reviewed_at=str(primitives.get("last_reviewed_at", "") or ""),
            total_attempts=int(primitives.get("total_attempts", 0)),
            total_score=float(primitives.get("total_score", 0.0)),
            created_at=str(primitives.get("created_at", "") or ""),
            updated_at=str(primitives.get("updated_at", "") or ""),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "word_es_id": self.word_es_id,
            "lang_code": self.lang_code,
            "repetitions": self.repetitions,
            "easiness_factor": self.easiness_factor,
            "interval_days": self.interval_days,
            "next_review_at": self.next_review_at,
            "last_reviewed_at": self.last_reviewed_at,
            "total_attempts": self.total_attempts,
            "total_score": self.total_score,
            "average_score": self.average_score,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
        }
