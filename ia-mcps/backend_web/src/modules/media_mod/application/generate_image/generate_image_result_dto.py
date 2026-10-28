from dataclasses import dataclass, field
from typing import Any, Self, final

from src.modules.media_mod.domain.enums.media_result_key_enum import MediaResultKeyEnum


@final
@dataclass(frozen=True, slots=True)
class GenerateImageResultDto:
    """Salida del caso de uso: las rutas escritas y con qué parámetros."""

    model: str = ""
    size: str = ""
    quality: str = ""
    file_paths: list[str] = field(default_factory=list)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            model=str(primitives.get(MediaResultKeyEnum.MODEL, "")),
            size=str(primitives.get(MediaResultKeyEnum.SIZE, "")),
            quality=str(primitives.get(MediaResultKeyEnum.QUALITY, "")),
            file_paths=list(primitives.get(MediaResultKeyEnum.FILES, [])),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            MediaResultKeyEnum.FILES: self.file_paths,
            MediaResultKeyEnum.MODEL: self.model,
            MediaResultKeyEnum.SIZE: self.size,
            MediaResultKeyEnum.QUALITY: self.quality,
        }
