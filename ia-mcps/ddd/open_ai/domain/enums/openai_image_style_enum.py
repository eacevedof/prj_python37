from enum import StrEnum
from typing import final


@final
class OpenaiImageStyleEnum(StrEnum):
    """Estilo visual para dall-e-3."""

    NATURAL = "natural"
    VIVID = "vivid"
