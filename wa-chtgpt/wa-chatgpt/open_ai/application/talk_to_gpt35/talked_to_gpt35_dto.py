from dataclasses import dataclass

@dataclass(frozen=True)
class TalkedToGpt35DTO:
    chat_response: str
