from dataclasses import dataclass
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class GetSpeechTextResultDto:
    """Salida: el texto listo para el TTS (vacío si no queda nada que leer)."""

    speech_text: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(speech_text=str(primitives.get("speech_text", "")))
