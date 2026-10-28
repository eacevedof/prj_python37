"""DTO de una palabra a presentar en el slider (origen ES + traducción)."""

from dataclasses import dataclass
from typing import Self, Any

from ddd.vocabulary.domain.enums import WordTypeEnum


@dataclass(frozen=True, slots=True)
class SliderWordDto:
    """Palabra a presentar en el slider (origen ES + traducción)."""

    word_es_id: int
    text_es: str
    text_lang: str
    word_type: str
    pronunciation: str = ""

    # Ejemplos de uso en el idioma destino (words_lang.notes)
    examples_lang: str = ""

    # Reglas de uso / ayuda gramatical (words_es.rules_help)
    rules_help: str = ""

    # Imagen principal (opcional)
    image_file_path: str = ""
    image_mime_type: str = ""
    image_caption: str = ""

    # Palabra madre si esta entrada es una frase de ejemplo (relación EXAMPLE)
    parent_word_es_id: int | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        parent_raw = primitives.get("parent_word_es_id")

        return cls(
            word_es_id=int(primitives.get("word_es_id", 0)),
            text_es=str(primitives.get("text_es", "")),
            text_lang=str(primitives.get("text_lang", "")),
            word_type=str(primitives.get("word_type", WordTypeEnum.WORD.value)),
            pronunciation=str(primitives.get("pronunciation", "") or ""),
            examples_lang=str(primitives.get("examples_lang", "") or ""),
            rules_help=str(primitives.get("rules_help", "") or ""),
            image_file_path=str(primitives.get("image_file_path", "") or ""),
            image_mime_type=str(primitives.get("image_mime_type", "") or ""),
            image_caption=str(primitives.get("image_caption", "") or ""),
            parent_word_es_id=int(parent_raw) if parent_raw is not None else None,
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "word_es_id": self.word_es_id,
            "text_es": self.text_es,
            "text_lang": self.text_lang,
            "word_type": self.word_type,
            "pronunciation": self.pronunciation,
            "examples_lang": self.examples_lang,
            "rules_help": self.rules_help,
            "image_file_path": self.image_file_path,
            "image_mime_type": self.image_mime_type,
            "image_caption": self.image_caption,
            "parent_word_es_id": self.parent_word_es_id,
        }
