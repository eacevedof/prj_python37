"""DTO for creating MP3 audio with OpenAI Audio API."""

from dataclasses import dataclass
from typing import Self

from ddd.open_ai.domain.enums import (
    OpenaiTtsFormatEnum,
    OpenaiTtsModelEnum,
    OpenaiTtsVoiceEnum,
)


@dataclass(frozen=True, slots=True)
class CreateMp3OpenaiDto:
    """DTO for parameterizing TTS audio generation with OpenAI."""

    text: str
    voice: str = OpenaiTtsVoiceEnum.ALLOY
    tts_model: str = OpenaiTtsModelEnum.TTS_1
    speed: float = 1.0
    response_format: str = OpenaiTtsFormatEnum.MP3

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        text = str(primitives.get("text", "")).strip()
        voice = str(primitives.get("voice", OpenaiTtsVoiceEnum.ALLOY))
        tts_model = str(primitives.get("tts_model", OpenaiTtsModelEnum.TTS_1))
        speed = float(primitives.get("speed", 1.0))
        response_format = str(primitives.get("response_format", OpenaiTtsFormatEnum.MP3))

        return cls(
            text=text,
            voice=voice,
            tts_model=tts_model,
            speed=speed,
            response_format=response_format,
        )

    def __post_init__(self) -> None:
        if not self.text or not self.text.strip():
            raise ValueError("CreateMp3OpenaiDto: text cannot be empty")
