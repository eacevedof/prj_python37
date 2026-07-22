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
    img_ia_context: str = ""  # contexto manual para la imagen IA (si hay, manda)
    rules_help: str = ""  # reglas de uso (ayuda gramatical mostrada en el Aprendizaje)
    created_at: str = ""
    updated_at: str = ""
    tags: list[str] = field(default_factory=list)
    translations: dict[str, str] = field(default_factory=dict)  # lang_code -> text

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        word_type = WordTypeEnum.coerce(primitives.get("word_type", "WORD"))

        return cls(
            id=int(primitives.get("id", 0)),
            text=str(primitives.get("text", "")).strip(),
            word_type=word_type,
            image_path=str(primitives.get("image_path", "") or "").strip(),
            notes=str(primitives.get("notes", "") or "").strip(),
            img_ia_context=str(primitives.get("img_ia_context", "") or "").strip(),
            rules_help=str(primitives.get("rules_help", "") or "").strip(),
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
            "img_ia_context": self.img_ia_context,
            "rules_help": self.rules_help,
            "created_at": self.created_at,
            "updated_at": self.updated_at,
            "tags": self.tags,
            "translations": self.translations,
        }
