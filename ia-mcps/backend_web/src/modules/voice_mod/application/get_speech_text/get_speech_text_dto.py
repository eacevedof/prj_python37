from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.voice_mod.domain.enums import VoiceConstraintsEnum, VoiceResultKeyEnum


@final
@dataclass(frozen=True, slots=True)
class GetSpeechTextDto:
    """Entrada: el markdown de una respuesta y cuánto se puede leer de él."""

    text: str
    max_chars: int = VoiceConstraintsEnum.MAX_SPEECH_CHARS

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            text=str(primitives.get(VoiceResultKeyEnum.TEXT, "")).strip(),
            max_chars=int(primitives.get(VoiceResultKeyEnum.MAX_CHARS, VoiceConstraintsEnum.MAX_SPEECH_CHARS)),
        )
