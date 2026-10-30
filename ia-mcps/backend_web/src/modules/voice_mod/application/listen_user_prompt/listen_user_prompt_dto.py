from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.voice_mod.domain.enums import VoiceConstraintsEnum, VoiceResultKeyEnum


@final
@dataclass(frozen=True, slots=True)
class ListenUserPromptDto:
    """Entrada: cuánto esperar a la tecla y el tope de la frase, en segundos."""

    wait_seconds: int = VoiceConstraintsEnum.LISTEN_WAIT_SECONDS
    max_record_seconds: int = VoiceConstraintsEnum.MAX_RECORD_SECONDS

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            wait_seconds=int(primitives.get(VoiceResultKeyEnum.WAIT_SECONDS, VoiceConstraintsEnum.LISTEN_WAIT_SECONDS)),
            max_record_seconds=int(
                primitives.get(VoiceResultKeyEnum.MAX_RECORD_SECONDS, VoiceConstraintsEnum.MAX_RECORD_SECONDS)
            ),
        )
