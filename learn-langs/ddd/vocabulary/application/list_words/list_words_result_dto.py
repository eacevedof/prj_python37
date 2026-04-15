"""DTO de resultado de listar palabras."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class WordItemDto:
    """DTO para un item de palabra en la lista."""

    id: int
    text: str
    word_type: str
    notes: str = ""
    created_at: str = ""
    updated_at: str = ""
    image_count: int = 0
    tags: list[str] = field(default_factory=list)
    translations: dict[str, str] = field(default_factory=dict)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            text=str(primitives.get("text", "")),
            word_type=str(primitives.get("word_type", "WORD")),
            notes=str(primitives.get("notes", "") or ""),
            created_at=str(primitives.get("created_at", "") or ""),
            updated_at=str(primitives.get("updated_at", "") or ""),
            image_count=int(primitives.get("image_count", 0)),
            tags=list(primitives.get("tags", []) or []),
            translations=dict(primitives.get("translations", {}) or {}),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "text": self.text,
            "word_type": self.word_type,
            "notes": self.notes,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
            "image_count": self.image_count,
            "tags": self.tags,
            "translations": self.translations,
        }


@dataclass(frozen=True, slots=True)
class ListWordsResultDto:
    """Output DTO con la lista de palabras."""

    words: list[WordItemDto] = field(default_factory=list)
    total_count: int = 0
    has_more: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        words_data = primitives.get("words", []) or []
        words = [WordItemDto.from_primitives(w) for w in words_data]

        return cls(
            words=words,
            total_count=int(primitives.get("total_count", len(words))),
            has_more=bool(primitives.get("has_more", False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "words": [w.to_dict() for w in self.words],
            "total_count": self.total_count,
            "has_more": self.has_more,
        }
