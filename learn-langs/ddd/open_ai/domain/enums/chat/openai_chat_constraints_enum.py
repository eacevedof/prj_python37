"""Enum for OpenAI Chat API constraints and defaults."""

from enum import IntEnum
from typing import final


@final
class OpenaiChatConstraintsEnum(IntEnum):
    """Constraints and default values for OpenAI Chat Completions API."""

    MAX_TOKENS_DEFAULT = 1000
    MAX_TOKENS_LIMIT = 4096
    MIN_TEMPERATURE = 0
    MAX_TEMPERATURE = 2
