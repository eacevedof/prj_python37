from dataclasses import dataclass

@dataclass(frozen=True)
class AskedYourPdfDto:
    chat_response: str

    def __dict__(self):
        return {
            "chat_response": self.chat_response
        }