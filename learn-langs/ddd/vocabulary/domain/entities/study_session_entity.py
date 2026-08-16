from dataclasses import dataclass, field
from typing import Self, Any

from ddd.vocabulary.domain.enums import StudyModeEnum


@dataclass(slots=True)
class StudySessionEntity:
    """Entidad: sesión de estudio/repaso."""

    id: int
    lang_code: str
    study_mode: StudyModeEnum
    started_at: str = ""
    finished_at: str = ""
    total_words: int = 0
    total_score: float = 0.0
    average_score: float = 0.0
    tags_filter: list[str] = field(default_factory=list)

    @property
    def is_finished(self) -> bool:
        return bool(self.finished_at)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        study_mode = StudyModeEnum.coerce(primitives.get("study_mode", "TYPING"))

        # tags_filter llega ya como lista: la frontera de persistencia
        # (SessionsReaderSqliteRepository) deserializa la columna JSON.
        tags_filter = list(primitives.get("tags_filter", []) or [])

        return cls(
            id=int(primitives.get("id", 0)),
            lang_code=str(primitives.get("lang_code", "")).strip(),
            study_mode=study_mode,
            started_at=str(primitives.get("started_at", "") or ""),
            finished_at=str(primitives.get("finished_at", "") or ""),
            total_words=int(primitives.get("total_words", 0)),
            total_score=float(primitives.get("total_score", 0.0)),
            average_score=float(primitives.get("average_score", 0.0)),
            tags_filter=tags_filter,
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "lang_code": self.lang_code,
            "study_mode": self.study_mode.value,
            "started_at": self.started_at,
            "finished_at": self.finished_at,
            "total_words": self.total_words,
            "total_score": self.total_score,
            "average_score": self.average_score,
            "tags_filter": self.tags_filter,
            "is_finished": self.is_finished,
        }
