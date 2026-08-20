from enum import Enum
from typing import final


@final
class OpenaiTtsConstraintsEnum(Enum):
    """Constraints and limits for OpenAI TTS API."""

    MAX_TEXT_LENGTH = 4096  # Maximum characters allowed in input text
    MIN_SPEED = 0.25  # Minimum speech speed multiplier
    MAX_SPEED = 4.0  # Maximum speech speed multiplier
