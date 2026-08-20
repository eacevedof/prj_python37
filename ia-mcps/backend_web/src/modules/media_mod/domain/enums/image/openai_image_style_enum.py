from enum import StrEnum
from typing import final


@final
class OpenaiImageStyleEnum(StrEnum):
    """Visual style for dall-e-3."""

    NATURAL = "natural"
    VIVID = "vivid"
