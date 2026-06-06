from enum import StrEnum
from typing import final


@final
class OpenaiImageQualityEnum(StrEnum):
    """Calidad de imagen para generación con OpenAI."""

    LOW = "low"
    HIGH = "high"
