"""Output DTO para sesión de slider."""

from dataclasses import dataclass, field
from typing import Self, Any

from ddd.vocabulary.application.start_word_slider_session.slider_word_dto import (
    SliderWordDto,
)


@dataclass(frozen=True, slots=True)
class StartWordSliderSessionResultDto:
    """Output DTO con la sesión de slider creada y palabras a presentar.

    `words` contiene solo primitivos (list[dict]); quien necesite acceso tipado
    rehidrata con SliderWordDto.from_primitives(w).
    """

    session_id: int
    lang_code: str
    study_mode: str
    started_at: str
    total_words: int
    words: list[dict] = field(default_factory=list)
    tags_filter: list[str] = field(default_factory=list)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        words_raw = primitives.get("words", []) or []
        words = [SliderWordDto.from_primitives(w).to_dict() for w in words_raw]

        return cls(
            session_id=int(primitives.get("session_id", 0)),
            lang_code=str(primitives.get("lang_code", "")),
            study_mode=str(primitives.get("study_mode", "SLIDER")),
            started_at=str(primitives.get("started_at", "")),
            total_words=len(words),
            words=words,
            tags_filter=list(primitives.get("tags_filter", []) or []),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "session_id": self.session_id,
            "lang_code": self.lang_code,
            "study_mode": self.study_mode,
            "started_at": self.started_at,
            "total_words": self.total_words,
            "words": [dict(w) for w in self.words],
            "tags_filter": self.tags_filter,
        }
