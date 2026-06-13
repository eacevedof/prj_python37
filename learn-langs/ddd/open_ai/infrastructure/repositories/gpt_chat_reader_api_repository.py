"""Repository for chat completions with OpenAI Chat API."""

from typing import final, Self, Generator

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
        model: str = "gpt-4o",
        temperature: float = 1.0,
        max_tokens: int = 1000,
    ) -> str:
        """
        Gets a chat completion from OpenAI (non-streaming).

        Args:
            messages: List of message dicts with 'role' and 'content' keys
            model: Model to use (gpt-4o, gpt-4o-mini, etc.)
            temperature: Sampling temperature (0.0 to 2.0)
            max_tokens: Maximum tokens in response

        Returns:
            str: Assistant's response text

        Raises:
            OpenAIException: If chat completion fails
        """
        if not messages:
            raise OpenAIException.unexpected_custom(
                "GptChatReaderApiRepository: messages cannot be empty"
            )

        response = self._open_ai_client.chat.completions.create(
            model=model,
            messages=messages,
            temperature=temperature,
            max_tokens=max_tokens,
            stream=False,
        )

        # Extract text from response
        if not response.choices:
            raise OpenAIException.unexpected_custom(
                "GptChatReaderApiRepository: No choices in API response"
            )

        content = response.choices[0].message.content
        if content is None:
            raise OpenAIException.unexpected_custom(
                "GptChatReaderApiRepository: No content in response message"
            )

        return content


    def get_chat_completion_stream(
        self,
        messages: list[dict[str, str]],
        model: str = "gpt-4o",
        temperature: float = 1.0,
        max_tokens: int = 1000,
    ) -> Generator[str, None, None]:
        """
        Gets a chat completion from OpenAI with streaming.

        Args:
            messages: List of message dicts with 'role' and 'content' keys
            model: Model to use (gpt-4o, gpt-4o-mini, etc.)
            temperature: Sampling temperature (0.0 to 2.0)
            max_tokens: Maximum tokens in response

        Yields:
            str: Chunks of assistant's response text as they arrive

        Raises:
            OpenAIException: If chat completion fails
        """
        if not messages:
            raise OpenAIException.unexpected_custom(
                "GptChatReaderApiRepository: messages cannot be empty"
            )

        try:
            stream = self._open_ai_client.chat.completions.create(
                model=model,
                messages=messages,
                temperature=temperature,
                max_tokens=max_tokens,
                stream=True,
            )

            # Yield chunks as they arrive
            for chunk in stream:
                if chunk.choices:
                    delta = chunk.choices[0].delta
                    if delta.content:
                        yield delta.content

        except Exception as e:
            raise OpenAIException.unexpected_custom(
                f"GptChatReaderApiRepository: Streaming chat completion failed: {str(e)}"
            )
