from typing import final
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class SendMessageDto:
    phone_number: str
    message: str

    @staticmethod
    def from_primitives(phone_number: str, message: str) -> 'SendMessageDto':
        phone_number = str(phone_number).strip()
        message = str(message).strip()

        return SendMessageDto(phone_number, message)

