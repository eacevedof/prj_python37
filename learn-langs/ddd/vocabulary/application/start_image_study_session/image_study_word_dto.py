"""DTO de una palabra con imagen para la sesión de estudio."""

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
