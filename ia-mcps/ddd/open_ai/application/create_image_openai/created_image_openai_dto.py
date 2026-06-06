"""Result DTO for created images with OpenAI."""

from dataclasses import dataclass


@dataclass(frozen=True, slots=True)
class ImageDataDto:
    """Single image data from OpenAI response."""

    b64_json: str
    revised_prompt: str | None


@dataclass(frozen=True, slots=True)
class CreatedImageOpenaiDto:
    """Result DTO for image generation with OpenAI."""

    images: list[ImageDataDto]
    prompt_used: str
    model: str
    size: str
    quality: str
    number_of_images: int
