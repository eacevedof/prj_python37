"""Result DTO for chat completion with OpenAI Chat API."""

from dataclasses import dataclass
from typing import Self


@dataclass(frozen=True, slots=True)
class ChatCompletionOpenaiResultDto:
    """Result DTO containing chat completion response."""

    response_text: str
    model: str
    temperature: float
    max_tokens: int

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        return cls(
            response_text=str(primitives.get("response_text", "")),
            model=str(primitives.get("model", "gpt-4o")),
            temperature=float(primitives.get("temperature", 1.0)),
            max_tokens=int(primitives.get("max_tokens", 1000)),
        )
