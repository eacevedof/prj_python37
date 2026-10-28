"""DTO de vista para listado de palabras."""

from dataclasses import dataclass, field
from typing import Self, Any

from ddd.vocabulary.infrastructure.ui.views.word_list_item_view_dto import (
    WordListItemViewDto,
)


@dataclass(frozen=True, slots=True)
class ListWordsViewDto:
    """DTO inmutable que el Controller pasa a la Vista.

    `words` contiene solo primitivos (tuple[dict]); la vista rehidrata con
    WordListItemViewDto.from_primitives(w) para renderizar cada item.
    """

    words: tuple[dict, ...] = field(default_factory=tuple)
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
            w.to_dict() if isinstance(w, WordListItemViewDto)
            else WordListItemViewDto.from_primitives(w).to_dict()
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
        words: list[dict],
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
