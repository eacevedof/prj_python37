from enum import StrEnum
from typing import final


@final
class OpenaiImageModelEnum(StrEnum):
    """OpenAI models for image generation."""

    GPT_IMAGE_1 = "gpt-image-1"
    GPT_IMAGE_1_MINI = "gpt-image-1-mini"
    GPT_IMAGE_2 = "gpt-image-2"
    GPT_IMAGE_1_5 = "gpt-image-1.5"
    CHATGPT_IMAGE_LATEST = "chatgpt-image-latest"
    DALL_E_3 = "dall-e-3"
    DALL_E_2 = "dall-e-2"
