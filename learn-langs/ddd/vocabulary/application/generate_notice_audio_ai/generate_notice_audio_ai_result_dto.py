"""DTO de resultado para GenerateNoticeAudioAiService."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GenerateNoticeAudioAiResultDto:
    """DTO de resultado al generar el audio de un aviso hablado."""

    audio_path: str = ""
    voice_used: str = ""
    model_used: str = ""
    text_generated: str = ""
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            audio_path=str(primitives.get("audio_path", "")),
            voice_used=str(primitives.get("voice_used", "")),
            model_used=str(primitives.get("model_used", "")),
            text_generated=str(primitives.get("text_generated", "")),
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def ok(
        cls,
        audio_path: str,
        voice_used: str,
        model_used: str,
        text_generated: str,
    ) -> Self:
        return cls.from_primitives({
            "audio_path": audio_path,
            "voice_used": voice_used,
            "model_used": model_used,
            "text_generated": text_generated,
        })

    # @deuda: mismo patrón que GenerateTextAudioAiResultDto — el caso de uso
    # devuelve un ResultDto de error en vez de lanzar VocabularyException.
    @classmethod
    def error(cls, message: str) -> Self:
        return cls.from_primitives({
            "error_message": message,
        })

    @property
    def success(self) -> bool:
        return self.error_message is None
