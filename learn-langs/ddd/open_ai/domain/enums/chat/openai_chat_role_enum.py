"""Enum for OpenAI Chat message roles."""

from enum import StrEnum
from typing import final


@final
class OpenaiChatRoleEnum(StrEnum):
    """Message roles for OpenAI Chat Completions API."""

    SYSTEM = "system"
    USER = "user"
    ASSISTANT = "assistant"
