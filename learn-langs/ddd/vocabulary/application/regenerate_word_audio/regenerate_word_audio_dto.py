"""DTO de entrada para RegenerateWordAudioService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class RegenerateWordAudioDto:
    """DTO de entrada para regenerar el audio de una palabra+idioma.

    Borra el mp3 definitivo y crea una propuesta temporal que el usuario
    debe aceptar (pasa a definitivo) o descartar.
    """

    word_id: int = 0
    lang_code: str = ""
    text: str = ""
    voice: str | None = None
    speed: float = 1.0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            word_id=int(primitives.get("word_id", 0)),
            lang_code=str(primitives.get("lang_code", "")).strip(),
            text=str(primitives.get("text", "")).strip(),
            voice=primitives.get("voice"),
            speed=float(primitives.get("speed", 1.0)),
        )
