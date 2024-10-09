from dataclasses import dataclass

@dataclass(frozen=True)
class AskYourPdfDto:
    question: str

    @staticmethod
    def from_primitives(question: str) -> 'AskYourPdfDto':
        question = str(question).strip()
        return AskYourPdfDto(
            question = question
        )