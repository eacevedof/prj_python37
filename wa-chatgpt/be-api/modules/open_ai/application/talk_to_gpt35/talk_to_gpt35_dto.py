from dataclasses import dataclass
from typing import final

@final
@dataclass(frozen=True)
class TalkToGpt35DTO:
    question: str
