from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class StudyWordDto:
    """Palabra para estudiar en la sesión."""

    word_es_id: int
    text_es: str
    text_lang: str
    word_type: str
    pronunciation: str = ""
    repetitions: int = 0
    easiness_factor: float = 2.5

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            word_es_id=int(primitives.get("word_es_id", 0)),
            text_es=str(primitives.get("text_es", "")),
            text_lang=str(primitives.get("text_lang", "")),
            word_type=str(primitives.get("word_type", "WORD")),
            pronunciation=str(primitives.get("pronunciation", "") or ""),
            repetitions=int(primitives.get("repetitions", 0)),
            easiness_factor=float(primitives.get("easiness_factor", 2.5)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "word_es_id": self.word_es_id,
            "text_es": self.text_es,
            "text_lang": self.text_lang,
            "word_type": self.word_type,
            "pronunciation": self.pronunciation,
            "repetitions": self.repetitions,
            "easiness_factor": self.easiness_factor,
        }


@dataclass(frozen=True, slots=True)
class StartStudySessionResultDto:
    """Output DTO con la sesión creada y palabras a estudiar."""

    session_id: int
    lang_code: str
    study_mode: str
    started_at: str
    total_words: int
    words: list[StudyWordDto] = field(default_factory=list)
    tags_filter: list[str] = field(default_factory=list)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        words_raw = primitives.get("words", [])
        words = [StudyWordDto.from_primitives(w) for w in words_raw]

        return cls(
            session_id=int(primitives.get("session_id", 0)),
            lang_code=str(primitives.get("lang_code", "")),
            study_mode=str(primitives.get("study_mode", "TYPING")),
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
            "words": [w.to_dict() for w in self.words],
            "tags_filter": self.tags_filter,
        }
