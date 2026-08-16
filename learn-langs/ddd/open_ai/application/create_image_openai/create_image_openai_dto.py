"""DTO for creating images with OpenAI Images API."""

from dataclasses import dataclass
from typing import Self

from ddd.open_ai.domain.enums import (
    OpenaiImageModelEnum,
    OpenaiImageQualityEnum,
    OpenaiImageSizeEnum,
)


@dataclass(frozen=True, slots=True)
class CreateImageOpenaiDto:
    """DTO for parameterizing image generation with OpenAI."""

    prompt: str
    openai_model: str = OpenaiImageModelEnum.GPT_IMAGE_1_5
    size: str = OpenaiImageSizeEnum.SIZE_1024
    quality: str = OpenaiImageQualityEnum.STANDARD
    number_of_images: int = 1

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        prompt = str(primitives.get("prompt", "")).strip()
        image_model = str(primitives.get("image_model", OpenaiImageModelEnum.GPT_IMAGE_1_5))
        size = str(primitives.get("size", OpenaiImageSizeEnum.SIZE_1024))

        # Map old quality values to new ones for backward compatibility
        quality_raw = str(primitives.get("quality", OpenaiImageQualityEnum.STANDARD))
        quality_map = {
            "low": OpenaiImageQualityEnum.STANDARD,
            "high": OpenaiImageQualityEnum.HD,
        }
        quality = quality_map.get(quality_raw.lower(), quality_raw)

        number_of_images = int(primitives.get("number_of_images", 1))

        return cls(
            prompt=prompt,
            openai_model=image_model,
            size=size,
            quality=quality,
            number_of_images=number_of_images,
        )
