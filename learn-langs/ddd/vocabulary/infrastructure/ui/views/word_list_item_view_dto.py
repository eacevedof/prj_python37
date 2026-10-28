"""DTO de vista para un item de palabra en el listado."""

from dataclasses import dataclass, field
from typing import Self, Any

from ddd.vocabulary.domain.enums import LanguageCodeEnum, WordTypeEnum


@dataclass(frozen=True, slots=True)
class WordListItemViewDto:
    """DTO para un item de palabra en la lista de la vista."""

    id: int = 0
    text: str = ""
    word_type: str = WordTypeEnum.WORD.value
    notes: str = ""
    created_at: str = ""
    image_count: int = 0
    last_image_path: str = ""
    tags: tuple[str, ...] = field(default_factory=tuple)
    groups: tuple[str, ...] = field(default_factory=tuple)
    translation_nl: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        translations = primitives.get("translations", {}) or {}
        tags_list = primitives.get("tags", []) or []
        groups_list = primitives.get("groups", []) or []

        # Filtrar grupos, excluyendo "generic"
        non_generic_groups = [
            g for g in groups_list
            if isinstance(g, str) and g.lower() != "generic"
        ]

        return cls(
            id=int(primitives.get("id", 0)),
            text=str(primitives.get("text", "")),
            word_type=str(primitives.get("word_type", WordTypeEnum.WORD.value)),
            notes=str(primitives.get("notes", "") or ""),
            created_at=str(primitives.get("created_at", "") or "")[:10],
            image_count=int(primitives.get("image_count", 0)),
            last_image_path=str(primitives.get("last_image_path", "") or ""),
            tags=tuple(tags_list),
            groups=tuple(non_generic_groups),
            translation_nl=translations.get(LanguageCodeEnum.NL_NL.value, ""),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "text": self.text,
            "word_type": self.word_type,
            "notes": self.notes,
            "created_at": self.created_at,
            "image_count": self.image_count,
            "last_image_path": self.last_image_path,
            "tags": list(self.tags),
            "groups": list(self.groups),
            # translations reconstruido para que from_primitives sea reversible
            "translations": {LanguageCodeEnum.NL_NL.value: self.translation_nl}
            if self.translation_nl
            else {},
        }
