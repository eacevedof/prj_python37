"""DTO de entrada para GenerateWordImageAiService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GenerateWordImageAiDto:
    """DTO de entrada para generar imagen con IA."""

    word_id: int = 0
    word_es: str = ""
    word_lang: str = ""
    lang_code: str = ""
    context: str | None = None
    style_prompt: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            word_id=int(primitives.get("word_id", 0)),
            word_es=str(primitives.get("word_es", "")),
            word_lang=str(primitives.get("word_lang", "")),
            lang_code=str(primitives.get("lang_code", "")),
            context=primitives.get("context"),
            style_prompt=primitives.get("style_prompt"),
        )
