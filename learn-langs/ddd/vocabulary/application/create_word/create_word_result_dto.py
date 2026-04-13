from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class CreateWordResultDto:
    """Output DTO con los detalles de la palabra creada."""

    id: int
    text: str
    word_type: str
    image_path: str = ""
    notes: str = ""
    created_at: str = ""
    tags: list[str] = field(default_factory=list)
    translations: dict[str, str] = field(default_factory=dict)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            text=str(primitives.get("text", "")).strip(),
            word_type=str(primitives.get("word_type", "WORD")),
            image_path=str(primitives.get("image_path", "") or ""),
            notes=str(primitives.get("notes", "") or ""),
            created_at=str(primitives.get("created_at", "") or ""),
            tags=list(primitives.get("tags", []) or []),
            translations=dict(primitives.get("translations", {}) or {}),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "text": self.text,
            "word_type": self.word_type,
            "image_path": self.image_path,
            "notes": self.notes,
            "created_at": self.created_at,
            "tags": self.tags,
            "translations": self.translations,
        }
