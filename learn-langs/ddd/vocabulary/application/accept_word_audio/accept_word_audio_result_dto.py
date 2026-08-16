"""DTO de resultado para AcceptWordAudioService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class AcceptWordAudioResultDto:
    """DTO de resultado al aceptar la propuesta temporal de audio."""

    audio_path: str = ""
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            audio_path=str(primitives.get("audio_path", "")),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def ok(cls, audio_path: str) -> Self:
        return cls.from_primitives({
            "audio_path": audio_path,
        })

    # @deuda: el caso de uso devuelve este ResultDto de error en vez de lanzar
    # VocabularyException para que el controller la capture (migrar a raise + catch).
    @classmethod
    def error(cls, message: str) -> Self:
        return cls.from_primitives({
            "error_message": message,
        })

    @property
    def success(self) -> bool:
        return self.error_message is None
