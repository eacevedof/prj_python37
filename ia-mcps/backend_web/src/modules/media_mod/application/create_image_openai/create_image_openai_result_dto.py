"""Result DTO for image generation with OpenAI."""

from dataclasses import dataclass
from typing import Self


@dataclass(frozen=True, slots=True)
class CreateImageOpenaiResultDto:
    """Result DTO for image generation with OpenAI."""

    images: list[dict]
    prompt_used: str
    model: str
    size: str
    quality: str
    number_of_images: int

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        images = list(primitives.get("images", []))
        prompt_used = str(primitives.get("prompt_used", ""))
        model = str(primitives.get("model", ""))
        size = str(primitives.get("size", ""))
        quality = str(primitives.get("quality", ""))
        number_of_images = int(primitives.get("number_of_images", 1))

        return cls(
            images=images,
            prompt_used=prompt_used,
            model=model,
            size=size,
            quality=quality,
            number_of_images=number_of_images,
        )
