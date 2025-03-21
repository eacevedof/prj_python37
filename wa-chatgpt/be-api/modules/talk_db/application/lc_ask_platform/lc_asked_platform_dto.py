from dataclasses import dataclass
from typing import final

@final
@dataclass(frozen=True)
class LcAskedPlatformDTO:
    chat_response: str

    def __dict__(self):
        return {
            "chat_response": self.chat_response
        }