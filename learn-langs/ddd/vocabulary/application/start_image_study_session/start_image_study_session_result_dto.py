"""Output DTO para sesión de estudio con imágenes."""

from dataclasses import dataclass, field
from typing import Self, Any

from ddd.vocabulary.domain.enums import WordTypeEnum


@dataclass(frozen=True, slots=True)
class ImageStudyWordDto:
    """Palabra con imagen para estudiar en la sesión."""

    word_es_id: int
    text_es: str
    text_lang: str
    word_type: str
    pronunciation: str = ""
    repetitions: int = 0
    easiness_factor: float = 2.5

    # Campos de imagen
    image_file_path: str = ""
    image_mime_type: str = ""
    image_caption: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            word_es_id=int(primitives.get("word_es_id", 0)),
            text_es=str(primitives.get("text_es", "")),
            text_lang=str(primitives.get("text_lang", "")),
            word_type=str(primitives.get("word_type", WordTypeEnum.WORD.value)),
            pronunciation=str(primitives.get("pronunciation", "") or ""),
            repetitions=int(primitives.get("repetitions", 0)),
            easiness_factor=float(primitives.get("easiness_factor", 2.5)),
            image_file_path=str(primitives.get("image_file_path", "")),
            image_mime_type=str(primitives.get("image_mime_type", "")),
            image_caption=str(primitives.get("image_caption", "") or ""),
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
            "image_file_path": self.image_file_path,
            "image_mime_type": self.image_mime_type,
            "image_caption": self.image_caption,
        }


@dataclass(frozen=True, slots=True)
class StartImageStudySessionResultDto:
    """Output DTO con la sesión de imágenes creada y palabras a estudiar."""

    session_id: int
    lang_code: str
    study_mode: str
    started_at: str
    total_words: int
    words: list[ImageStudyWordDto] = field(default_factory=list)
    tags_filter: list[str] = field(default_factory=list)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        words_raw = primitives.get("words", [])
        words = [ImageStudyWordDto.from_primitives(w) for w in words_raw]

        return cls(
            session_id=int(primitives.get("session_id", 0)),
            lang_code=str(primitives.get("lang_code", "")),
            study_mode=str(primitives.get("study_mode", "IMAGE_TYPING")),
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
