from dataclasses import dataclass
from typing import List

@dataclass(frozen=True)
class TalkToGpt35DTO:
    question: str
