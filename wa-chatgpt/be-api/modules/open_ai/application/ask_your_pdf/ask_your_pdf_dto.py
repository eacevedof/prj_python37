from dataclasses import dataclass

@dataclass(frozen=True)
class AskYourPdfDto:
    question: str
