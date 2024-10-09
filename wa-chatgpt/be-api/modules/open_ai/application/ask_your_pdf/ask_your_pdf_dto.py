from dataclasses import dataclass

@dataclass(frozen=True)
class AskYourPdfDto:
    question: str

    @staticmethod
    def from_primitives(primitives: dict) -> 'AskYourPdfDto':
        return AskYourPdfDto(
            question = str(primitives.get("question", "")).strip()
        )