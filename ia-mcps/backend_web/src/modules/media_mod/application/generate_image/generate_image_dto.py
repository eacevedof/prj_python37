from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.media_mod.domain.enums import (
    OpenaiImageModelEnum,
    OpenaiImageQualityEnum,
    OpenaiImageSizeEnum,
)


@final
@dataclass(frozen=True, slots=True)
class GenerateImageDto:
    """Entrada del caso de uso: generar imágenes y dejarlas en disco."""

    prompt: str
    image_model: str = OpenaiImageModelEnum.GPT_IMAGE_1_5
    size: str = OpenaiImageSizeEnum.SIZE_1024
    quality: str = OpenaiImageQualityEnum.STANDARD
    number_of_images: int = 1
    file_name: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            prompt=str(primitives.get("prompt", "")).strip(),
            image_model=str(primitives.get("model", OpenaiImageModelEnum.GPT_IMAGE_1_5)),
            size=str(primitives.get("size", OpenaiImageSizeEnum.SIZE_1024)),
            quality=str(primitives.get("quality", OpenaiImageQualityEnum.STANDARD)),
            number_of_images=int(primitives.get("n", 1)),
            file_name=str(primitives.get("filename", "")).strip(),
        )
