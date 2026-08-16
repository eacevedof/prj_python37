"""DTO de resultado de listar palabras."""

from dataclasses import dataclass, field
from typing import Self, Any

from ddd.vocabulary.application.list_words.word_item_dto import WordItemDto


@dataclass(frozen=True, slots=True)
class ListWordsResultDto:
    """Output DTO con la lista de palabras.

    `words` contiene solo primitivos (list[dict]); quien necesite acceso tipado
    rehidrata con WordItemDto.from_primitives(w).
    """

    words: list[dict] = field(default_factory=list)
    total_count: int = 0
    has_more: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        words_data = primitives.get("words", []) or []
        words = [WordItemDto.from_primitives(w).to_dict() for w in words_data]

        return cls(
            words=words,
            total_count=int(primitives.get("total_count", len(words))),
            has_more=bool(primitives.get("has_more", False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "words": [dict(w) for w in self.words],
            "total_count": self.total_count,
            "has_more": self.has_more,
        }
