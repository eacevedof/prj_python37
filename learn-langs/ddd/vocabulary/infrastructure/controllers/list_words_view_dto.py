"""DTO de vista para listado de palabras."""

from dataclasses import dataclass, field
from typing import Self, Any

from ddd.vocabulary.domain.enums import LanguageCodeEnum


@dataclass(slots=True)
class WordListItemViewDto:
    """DTO para un item de palabra en la lista de la vista."""

    id: int
    text: str
    word_type: str
    notes: str = ""
    created_at: str = ""
    image_count: int = 0
    tags: list[str] = field(default_factory=list)
    translation_nl: str = ""  # Traduccion principal (holandes)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        translations = primitives.get("translations", {}) or {}
        return cls(
            id=int(primitives.get("id", 0)),
            text=str(primitives.get("text", "")),
            word_type=str(primitives.get("word_type", "WORD")),
            notes=str(primitives.get("notes", "") or ""),
            created_at=str(primitives.get("created_at", "") or "")[:10],
            image_count=int(primitives.get("image_count", 0)),
            tags=list(primitives.get("tags", []) or []),
            translation_nl=translations.get(LanguageCodeEnum.NL_NL.value, ""),
        )


@dataclass(slots=True)
class ListWordsViewDto:
    """DTO que el controlador pasa a la vista con el resultado."""

    success: bool
    words: list[WordListItemViewDto] = field(default_factory=list)
    total_count: int = 0
    has_more: bool = False
    error_message: str | None = None

    @classmethod
    def ok(
        cls,
        words: list[WordListItemViewDto],
        total_count: int,
        has_more: bool,
    ) -> Self:
        """Crea un DTO de exito."""
        return cls(
            success=True,
            words=words,
            total_count=total_count,
            has_more=has_more,
        )

    @classmethod
    def error(cls, message: str) -> Self:
        """Crea un DTO de error."""
        return cls(
            success=False,
            error_message=message,
        )

    @property
    def is_empty(self) -> bool:
        """Indica si no hay palabras."""
        return len(self.words) == 0
