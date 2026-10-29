from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.voice_mod.domain.enums import VoiceResultKeyEnum


@final
@dataclass(frozen=True, slots=True)
class ListenUserPromptResultDto:
    """Salida: lo que dijiste, en texto. Vacío = no pulsaste la tecla o no se entendió."""

    prompt_text: str = ""
    recorded_seconds: float = 0.0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            prompt_text=str(primitives.get(VoiceResultKeyEnum.PROMPT_TEXT, "")),
            recorded_seconds=float(primitives.get(VoiceResultKeyEnum.RECORDED_SECONDS, 0.0)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            VoiceResultKeyEnum.PROMPT_TEXT: self.prompt_text,
            VoiceResultKeyEnum.RECORDED_SECONDS: self.recorded_seconds,
        }
