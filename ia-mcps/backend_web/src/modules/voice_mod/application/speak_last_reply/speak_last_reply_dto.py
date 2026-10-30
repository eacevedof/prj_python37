from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.voice_mod.domain.enums import VoiceResultKeyEnum


@final
@dataclass(frozen=True, slots=True)
class SpeakLastReplyDto:
    """Entrada: la ruta del transcript que manda el hook `Stop` de Claude Code."""

    transcript_path: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(transcript_path=str(primitives.get(VoiceResultKeyEnum.TRANSCRIPT_PATH, "")).strip())
