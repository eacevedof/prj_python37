from enum import StrEnum
from typing import final


@final
class OpenaiImageQualityEnum(StrEnum):
    """Image quality for generation with OpenAI."""

    LOW = "low"
    HIGH = "high"
