"""DTO de resultado de actualizar una palabra."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class UpdateWordResultDto:
    """Output DTO con los detalles de la palabra actualizada."""

    id: int
    text: str
    word_type: str
    notes: str = ""
    updated_at: str = ""
    tags: list[str] = field(default_factory=list)
    translations: dict[str, str] = field(default_factory=dict)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            text=str(primitives.get("text", "")).strip(),
            word_type=str(primitives.get("word_type", "WORD")),
            notes=str(primitives.get("notes", "") or ""),
            updated_at=str(primitives.get("updated_at", "") or ""),
            tags=list(primitives.get("tags", []) or []),
            translations=dict(primitives.get("translations", {}) or {}),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "text": self.text,
            "word_type": self.word_type,
            "notes": self.notes,
            "updated_at": self.updated_at,
            "tags": self.tags,
            "translations": self.translations,
        }
