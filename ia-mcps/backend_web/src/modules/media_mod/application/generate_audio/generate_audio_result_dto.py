from dataclasses import dataclass, field
from typing import Any, Self, final

from src.modules.media_mod.domain.enums.media_result_key_enum import MediaResultKeyEnum


@final
@dataclass(frozen=True, slots=True)
class GenerateAudioResultDto:
    """Salida del caso de uso: la ruta escrita y con qué parámetros."""

    model: str = ""
    voice: str = ""
    speed: float = 1.0
    audio_format: str = ""
    file_paths: list[str] = field(default_factory=list)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            model=str(primitives.get(MediaResultKeyEnum.MODEL, "")),
            voice=str(primitives.get(MediaResultKeyEnum.VOICE, "")),
            speed=float(primitives.get(MediaResultKeyEnum.SPEED, 1.0)),
            audio_format=str(primitives.get(MediaResultKeyEnum.FORMAT, "")),
            file_paths=list(primitives.get(MediaResultKeyEnum.FILES, [])),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            MediaResultKeyEnum.FILES: self.file_paths,
            MediaResultKeyEnum.MODEL: self.model,
            MediaResultKeyEnum.VOICE: self.voice,
            MediaResultKeyEnum.SPEED: self.speed,
            MediaResultKeyEnum.FORMAT: self.audio_format,
        }
