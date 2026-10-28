from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.media_mod.domain.enums import (
    OpenaiTtsFormatEnum,
    OpenaiTtsModelEnum,
    OpenaiTtsVoiceEnum,
)


@final
@dataclass(frozen=True, slots=True)
class GenerateAudioDto:
    """Entrada del caso de uso: generar audio TTS y dejarlo en disco."""

    text: str
    voice: str = OpenaiTtsVoiceEnum.ALLOY
    tts_model: str = OpenaiTtsModelEnum.TTS_1
    speed: float = 1.0
    response_format: str = OpenaiTtsFormatEnum.MP3
    file_name: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            text=str(primitives.get("text", "")).strip(),
            voice=str(primitives.get("voice", OpenaiTtsVoiceEnum.ALLOY)),
            tts_model=str(primitives.get("model", OpenaiTtsModelEnum.TTS_1)),
            speed=float(primitives.get("speed", 1.0)),
            response_format=str(primitives.get("response_format", OpenaiTtsFormatEnum.MP3)),
            file_name=str(primitives.get("filename", "")).strip(),
        )
