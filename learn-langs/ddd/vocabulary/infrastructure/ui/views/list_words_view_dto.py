"""DTO de vista para listado de palabras."""

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


@dataclass(frozen=True, slots=True)
class ListWordsViewDto:
    """DTO inmutable que el Controller pasa a la Vista."""

    words: tuple[WordListItemViewDto, ...] = field(default_factory=tuple)
    total_count: int = 0
    has_more: bool = False
    page: int = 0
    page_size: int = 100
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
            page=int(primitives.get("page", 0)),
            page_size=int(primitives.get("page_size", 100)),
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
        page: int = 0,
        page_size: int = 100,
    ) -> Self:
        """DTO de exito."""
        return cls.from_primitives({
            "words": words,
            "total_count": total_count,
            "has_more": has_more,
            "page": page,
            "page_size": page_size,
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

    @property
    def total_pages(self) -> int:
        """Número total de páginas (mínimo 1)."""
        if self.page_size <= 0:
            return 1
        return max(1, (self.total_count + self.page_size - 1) // self.page_size)

    @property
    def has_prev(self) -> bool:
        """Indica si hay página anterior."""
        return self.page > 0

    @property
    def has_next(self) -> bool:
        """Indica si hay página siguiente."""
        return self.has_more

    @property
    def page_label(self) -> str:
        """Texto 'Página X de Y'."""
        return f"Página {self.page + 1} de {self.total_pages}"
