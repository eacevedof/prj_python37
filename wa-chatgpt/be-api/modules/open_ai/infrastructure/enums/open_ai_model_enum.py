from typing import final
from dataclasses import dataclass
from enum import Enum


@final
@dataclass(frozen=True)
class OpenAiModelEnum(Enum):
    GPT_3_5_TURBO = "gpt-3.5-turbo"
