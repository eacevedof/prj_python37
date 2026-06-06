from enum import StrEnum
from typing import final


@final
class OpenaiImageModelEnum(StrEnum):
    """Modelos de OpenAI para generación de imágenes."""

    GPT_IMAGE_1_5 = "gpt-image-1.5"
    DALL_E_3 = "dall-e-3"
    DALL_E_2 = "dall-e-2"
