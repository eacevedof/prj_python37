"""DTO de vista para listado de palabras."""

from dataclasses import dataclass, field
from typing import Self, Any

from ddd.vocabulary.domain.enums import LanguageCodeEnum


@dataclass(frozen=True, slots=True)
class WordListItemViewDto:
    """DTO para un item de palabra en la lista de la vista."""

    id: int = 0
    text: str = ""
    word_type: str = "WORD"
    notes: str = ""
    created_at: str = ""
    image_count: int = 0
    tags: tuple[str, ...] = field(default_factory=tuple)
    translation_nl: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        translations = primitives.get("translations", {}) or {}
        tags_list = primitives.get("tags", []) or []
        return cls(
            id=int(primitives.get("id", 0)),
            text=str(primitives.get("text", "")),
            word_type=str(primitives.get("word_type", "WORD")),
            notes=str(primitives.get("notes", "") or ""),
            created_at=str(primitives.get("created_at", "") or "")[:10],
            image_count=int(primitives.get("image_count", 0)),
            tags=tuple(tags_list),
            translation_nl=translations.get(LanguageCodeEnum.NL_NL.value, ""),
        )


@dataclass(frozen=True, slots=True)
class ListWordsViewDto:
    """DTO inmutable que el Controller pasa a la Vista."""

    words: tuple[WordListItemViewDto, ...] = field(default_factory=tuple)
    total_count: int = 0
    has_more: bool = False
    is_loading: bool = False
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        words_raw = primitives.get("words", []) or []
        words = tuple(
            w if isinstance(w, WordListItemViewDto) else WordListItemViewDto.from_primitives(w)
            for w in words_raw
        )
        return cls(
            words=words,
            total_count=int(primitives.get("total_count", 0)),
            has_more=bool(primitives.get("has_more", False)),
            is_loading=bool(primitives.get("is_loading", False)),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def loading(cls) -> Self:
        """DTO estado cargando."""
        return cls.from_primitives({"is_loading": True})

    @classmethod
    def ok(
        cls,
        words: list[WordListItemViewDto],
        total_count: int,
        has_more: bool,
    ) -> Self:
        """DTO de exito."""
        return cls.from_primitives({
            "words": words,
            "total_count": total_count,
            "has_more": has_more,
            "is_loading": False,
        })

    @classmethod
    def error(cls, message: str) -> Self:
        """DTO de error."""
        return cls.from_primitives({
            "error_message": message,
            "is_loading": False,
        })

    @property
    def success(self) -> bool:
        """Indica si fue exitoso."""
        return self.error_message is None

    @property
    def is_empty(self) -> bool:
        """Indica si no hay palabras."""
        return len(self.words) == 0
