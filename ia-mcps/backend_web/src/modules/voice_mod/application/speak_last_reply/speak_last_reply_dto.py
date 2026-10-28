from dataclasses import dataclass
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class SpeakLastReplyDto:
    """Entrada: la ruta del transcript que manda el hook `Stop` de Claude Code."""

    transcript_path: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(transcript_path=str(primitives.get("transcript_path", "")).strip())
