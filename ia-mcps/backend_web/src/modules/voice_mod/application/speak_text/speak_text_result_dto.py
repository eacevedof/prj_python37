from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.voice_mod.domain.enums import VoiceResultKeyEnum


@final
@dataclass(frozen=True, slots=True)
class SpeakTextResultDto:
    """Salida: qué se ha leído y con qué modelo y voz."""

    model: str = ""
    reference_id: str = ""
    speech_text: str = ""
    spoken_chars: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            model=str(primitives.get(VoiceResultKeyEnum.MODEL, "")).strip(),
            reference_id=str(primitives.get(VoiceResultKeyEnum.REFERENCE_ID, "")).strip(),
            speech_text=str(primitives.get(VoiceResultKeyEnum.SPEECH_TEXT, "")).strip(),
            spoken_chars=int(primitives.get(VoiceResultKeyEnum.SPOKEN_CHARS, 0)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            VoiceResultKeyEnum.MODEL: self.model,
            VoiceResultKeyEnum.REFERENCE_ID: self.reference_id,
            VoiceResultKeyEnum.SPEECH_TEXT: self.speech_text,
            VoiceResultKeyEnum.SPOKEN_CHARS: self.spoken_chars,
        }
