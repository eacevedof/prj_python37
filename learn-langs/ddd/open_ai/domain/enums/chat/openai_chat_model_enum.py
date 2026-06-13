"""Enum for OpenAI Chat Completion models."""

from enum import StrEnum
from typing import final


@final
class OpenaiChatModelEnum(StrEnum):
    """Available models for OpenAI Chat Completions API."""

    GPT_4O = "gpt-4o"
    GPT_4O_MINI = "gpt-4o-mini"
    GPT_4_TURBO = "gpt-4-turbo"
    GPT_3_5_TURBO = "gpt-3.5-turbo"
