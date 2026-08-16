from typing import final
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class SentMessageDto:
    result: str

    @staticmethod
    def get_instance(result: str) -> 'SentMessageDto':
        return SentMessageDto(result)