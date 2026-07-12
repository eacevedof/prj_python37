"""DTO de resultado para GetLastActivityStateService."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetLastActivityStateResultDto:
    """Último estado de actividad guardado (para el botón Continuar del Home)."""

    activity: str = ""
    lang_code: str = ""
    tags: list[str] = field(default_factory=list)
    group_id: int | None = None
    word_es_id: int = 0
    word_index: int = 0
    total_words: int = 0
    is_random_order: bool = False
    updated_at: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        group_id_raw = primitives.get("group_id")

        return cls(
            activity=str(primitives.get("activity", "")),
            lang_code=str(primitives.get("lang_code", "")),
            tags=list(primitives.get("tags", []) or []),
            group_id=int(group_id_raw) if group_id_raw is not None else None,
            word_es_id=int(primitives.get("word_es_id", 0)),
            word_index=int(primitives.get("word_index", 0)),
            total_words=int(primitives.get("total_words", 0)),
            is_random_order=bool(primitives.get("is_random_order", False)),
            updated_at=str(primitives.get("updated_at", "") or ""),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "activity": self.activity,
            "lang_code": self.lang_code,
            "tags": self.tags,
            "group_id": self.group_id,
            "word_es_id": self.word_es_id,
            "word_index": self.word_index,
            "total_words": self.total_words,
            "is_random_order": self.is_random_order,
            "updated_at": self.updated_at,
        }
