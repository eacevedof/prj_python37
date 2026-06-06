from enum import StrEnum
from typing import final


@final
class OpenaiImageSizeEnum(StrEnum):
    """Tamaños disponibles para generación de imágenes con OpenAI."""

    SIZE_256 = "256x256"
    SIZE_512 = "512x512"
    SIZE_1024 = "1024x1024"
    SIZE_1024_1792 = "1024x1792"
    SIZE_1792_1024 = "1792x1024"
