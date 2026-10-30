from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.voice_mod.domain.enums import VoiceResultKeyEnum


@final
@dataclass(frozen=True, slots=True)
class RunVoiceTurnResultDto:
    """Salida: la siguiente instrucción para Claude (vacía = no hay) y si se ha
    dicho «fin voz»."""

    prompt_text: str = ""
    is_voice_mode_stopped: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            prompt_text=str(primitives.get(VoiceResultKeyEnum.PROMPT_TEXT, "")).strip(),
            is_voice_mode_stopped=bool(primitives.get(VoiceResultKeyEnum.IS_VOICE_MODE_STOPPED, False)),
        )
