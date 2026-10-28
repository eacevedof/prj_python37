"""DTO de resultado para DiscardWordAudioService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DiscardWordAudioResultDto:
    """DTO de resultado al descartar la propuesta temporal de audio."""

    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def ok(cls) -> Self:
        return cls.from_primitives({})

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
