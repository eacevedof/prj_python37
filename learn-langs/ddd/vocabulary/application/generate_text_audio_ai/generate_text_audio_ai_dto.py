"""DTO de entrada para GenerateTextAudioAiService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GenerateTextAudioAiDto:
    """DTO de entrada para generar audio de un texto arbitrario con IA.

    A diferencia de GenerateWordAudioAiDto (acoplado a word_lang_id en BD),
    este DTO solo necesita texto + idioma + una clave de cache. Permite
    generar audio del origen español (que no tiene fila en words_lang).
    """

    text: str = ""
    lang_code: str = ""
    cache_key: str = ""
    voice: str | None = None
    speed: float = 1.0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            text=str(primitives.get("text", "")).strip(),
            lang_code=str(primitives.get("lang_code", "")).strip(),
            cache_key=str(primitives.get("cache_key", "")).strip(),
            voice=primitives.get("voice"),
            speed=float(primitives.get("speed", 1.0)),
        )
