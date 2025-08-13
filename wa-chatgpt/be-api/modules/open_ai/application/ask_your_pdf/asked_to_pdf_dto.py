from typing import final
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class AskedYourPdfDto:
    chat_response: str

    @staticmethod
    def from_primitives(chat_response: str) -> "AskedYourPdfDto":
        return AskedYourPdfDto(chat_response)

    def __dict__(self):
        return {
            "chat_response": self.chat_response
        }