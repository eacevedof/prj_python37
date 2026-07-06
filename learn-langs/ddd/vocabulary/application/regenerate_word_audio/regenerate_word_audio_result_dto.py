"""DTO de resultado para RegenerateWordAudioService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class RegenerateWordAudioResultDto:
    """DTO de resultado al regenerar el audio de una palabra+idioma."""

    temp_audio_path: str = ""
    voice_used: str = ""
    model_used: str = ""
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            temp_audio_path=str(primitives.get("temp_audio_path", "")),
            voice_used=str(primitives.get("voice_used", "")),
            model_used=str(primitives.get("model_used", "")),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def ok(cls, temp_audio_path: str, voice_used: str, model_used: str) -> Self:
        return cls.from_primitives({
            "temp_audio_path": temp_audio_path,
            "voice_used": voice_used,
            "model_used": model_used,
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
