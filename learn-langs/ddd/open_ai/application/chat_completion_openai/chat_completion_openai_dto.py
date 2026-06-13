"""DTO for chat completion with OpenAI Chat API."""

from dataclasses import dataclass
from typing import Self

from ddd.open_ai.domain.enums import OpenaiChatModelEnum


@dataclass(frozen=True, slots=True)
class ChatCompletionOpenaiDto:
    """DTO for parameterizing chat completion with OpenAI."""

    messages: list[dict[str, str]]
    model: str = OpenaiChatModelEnum.GPT_4O
    temperature: float = 1.0
    max_tokens: int = 1000
    stream: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict) -> Self:
        messages = primitives.get("messages", [])
        model = str(primitives.get("model", OpenaiChatModelEnum.GPT_4O))
        temperature = float(primitives.get("temperature", 1.0))
        max_tokens = int(primitives.get("max_tokens", 1000))
        stream = bool(primitives.get("stream", False))

        return cls(
            messages=messages,
            model=model,
            temperature=temperature,
            max_tokens=max_tokens,
            stream=stream,
        )

    def __post_init__(self) -> None:
        if not self.messages:
            raise ValueError("ChatCompletionOpenaiDto: messages cannot be empty")

        for msg in self.messages:
            if "role" not in msg or "content" not in msg:
                raise ValueError(
                    "ChatCompletionOpenaiDto: each message must have 'role' and 'content' keys"
                )
