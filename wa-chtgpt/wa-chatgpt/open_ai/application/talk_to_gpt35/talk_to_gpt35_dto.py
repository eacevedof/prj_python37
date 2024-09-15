from dataclasses import dataclass
from typing import List

@dataclass(frozen=True)
class TalkToGpt35DTO:
    prompt: str
    max_tokens: int
    n: int
    stop: List[str]
    temperature: float