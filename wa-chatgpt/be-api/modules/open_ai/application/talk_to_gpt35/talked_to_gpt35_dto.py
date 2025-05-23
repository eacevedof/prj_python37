from dataclasses import dataclass
from typing import final

@final
@dataclass(frozen=True)
class TalkedToGpt35DTO:
    chat_response: str

    def __dict__(self):
        return {
            "chat_response": self.chat_response
        }