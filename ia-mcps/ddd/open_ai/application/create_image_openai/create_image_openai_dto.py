"""DTO para crear imágenes con OpenAI Images API."""

from dataclasses import dataclass
from typing import Self

from ddd.open_ai.domain.enums import (
    OpenaiImageModelEnum,
    OpenaiImageQualityEnum,
    OpenaiImageSizeEnum,
)


@dataclass(frozen=True, slots=True)
class CreateImageOpenaiDto:
    """DTO para parametrizar la generación de imágenes con OpenAI."""

    prompt: str
    openai_model: str = OpenaiImageModelEnum.GPT_IMAGE_1_5.value
    size: str = OpenaiImageSizeEnum.SIZE_1024.value
    quality: str = OpenaiImageQualityEnum.LOW.value
    style: str | None = None
    number_of_images: int = 1

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        prompt = str(primitives.get("prompt", "")).strip()
        image_model = str(primitives.get("image_model", OpenaiImageModelEnum.GPT_IMAGE_1_5.value))
        size = str(primitives.get("size", OpenaiImageSizeEnum.SIZE_1024.value))
        quality = str(primitives.get("quality", OpenaiImageQualityEnum.LOW.value))
        style = str(primitives["style"]) if primitives.get("style") else None
        number_of_images = int(primitives.get("number_of_images", 1))

        return cls(
            prompt=prompt,
            openai_model=image_model,
            size=size,
            quality=quality,
            style=style,
            number_of_images=number_of_images,
        )

