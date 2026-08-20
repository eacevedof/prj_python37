from enum import IntEnum
from typing import final


@final
class OpenaiImageNumberEnum(IntEnum):
    """Available request limit for image generation with OpenAI."""

    MIN_NUMBER_OF_IMAGES = 1
    MAX_NUMBER_OF_IMAGES = 10
