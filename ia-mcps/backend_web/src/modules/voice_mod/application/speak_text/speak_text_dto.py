from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.voice_mod.domain.enums import VoiceConstraintsEnum, VoiceResultKeyEnum


@final
@dataclass(frozen=True, slots=True)
class SpeakTextDto:
    """Entrada: el texto a leer en alto. Modelo y voz vacíos = los del `.env`."""

    text: str
    model: str = ""
    reference_id: str = ""
    max_chars: int = VoiceConstraintsEnum.MAX_SPEECH_CHARS

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            text=str(primitives.get(VoiceResultKeyEnum.TEXT, "")).strip(),
            model=str(primitives.get(VoiceResultKeyEnum.MODEL, "")).strip(),
            reference_id=str(primitives.get(VoiceResultKeyEnum.REFERENCE_ID, "")).strip(),
            max_chars=int(primitives.get(VoiceResultKeyEnum.MAX_CHARS, VoiceConstraintsEnum.MAX_SPEECH_CHARS)),
        )
