"""Repository for chat completions with OpenAI Chat API."""

from typing import final, Self, Generator

from ddd.open_ai.domain.enums import OpenaiChatModelEnum
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.abstract_open_ai_api_repository import AbstractOpenAIApiRepository


@final
class GptChatReaderApiRepository(AbstractOpenAIApiRepository):
    """Repository for chat completions using GPT models."""

    _instance: "GptChatReaderApiRepository | None" = None

    @classmethod
    def get_instance(cls) -> Self:
        """Returns the singleton instance."""
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    def get_chat_completion(
        self,
        messages: list[dict[str, str]],
        model: str = OpenaiChatModelEnum.GPT_4O,
        temperature: float = 1.0,
        max_tokens: int = 1000,
    ) -> str:
        """Gets a chat completion from OpenAI (non-streaming). Input is validated upstream."""
        response = self._open_ai_client.chat.completions.create(
            model=model,
            messages=messages,
            temperature=temperature,
            max_tokens=max_tokens,
            stream=False,
        )

        if not response.choices:
            OpenAIException.unexpected_custom(
                "GptChatReaderApiRepository: No choices in API response"
            )

        content = response.choices[0].message.content
        if content is None:
            OpenAIException.unexpected_custom(
                "GptChatReaderApiRepository: No content in response message"
            )

        return content

    def get_chat_completion_stream(
        self,
        messages: list[dict[str, str]],
        model: str = OpenaiChatModelEnum.GPT_4O,
        temperature: float = 1.0,
        max_tokens: int = 1000,
    ) -> Generator[str, None, None]:
        """Gets a chat completion from OpenAI with streaming. Input is validated upstream."""
        stream = self._open_ai_client.chat.completions.create(
            model=model,
            messages=messages,
            temperature=temperature,
            max_tokens=max_tokens,
            stream=True,
        )

        for chunk in stream:
            if chunk.choices:
                delta = chunk.choices[0].delta
                if delta.content:
                    yield delta.content
