from dataclasses import dataclass, field
from typing import Self, Any

from ddd.vocabulary.domain.enums import WordTypeEnum


@dataclass(slots=True)
class WordEsEntity:
    """Entidad principal: palabra en español."""

    id: int
    text: str
    word_type: WordTypeEnum
    image_path: str = ""
    notes: str = ""
    created_at: str = ""
    updated_at: str = ""
    tags: list[str] = field(default_factory=list)
    translations: dict[str, str] = field(default_factory=dict)  # lang_code -> text

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        word_type_str = str(primitives.get("word_type", "WORD")).upper()
        try:
            word_type = WordTypeEnum(word_type_str)
        except ValueError:
            word_type = WordTypeEnum.WORD

        return cls(
            id=int(primitives.get("id", 0)),
            text=str(primitives.get("text", "")).strip(),
            word_type=word_type,
            image_path=str(primitives.get("image_path", "") or "").strip(),
            notes=str(primitives.get("notes", "") or "").strip(),
            created_at=str(primitives.get("created_at", "") or ""),
            updated_at=str(primitives.get("updated_at", "") or ""),
            tags=list(primitives.get("tags", []) or []),
            translations=dict(primitives.get("translations", {}) or {}),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "text": self.text,
            "word_type": self.word_type.value,
            "image_path": self.image_path,
            "notes": self.notes,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
            "tags": self.tags,
            "translations": self.translations,
        }
