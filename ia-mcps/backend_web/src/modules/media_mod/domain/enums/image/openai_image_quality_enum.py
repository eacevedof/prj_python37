from enum import StrEnum
from typing import final


@final
class OpenaiImageQualityEnum(StrEnum):
    """Image quality for generation with OpenAI."""

    STANDARD = "standard"
    HD = "hd"
