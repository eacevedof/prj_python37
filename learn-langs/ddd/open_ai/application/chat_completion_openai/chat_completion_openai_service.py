"""Service for chat completion with OpenAI Chat API."""

from typing import Self, final, Generator

from ddd.open_ai.application.chat_completion_openai.chat_completion_openai_dto import ChatCompletionOpenaiDto
from ddd.open_ai.application.chat_completion_openai.chat_completion_openai_result_dto import ChatCompletionOpenaiResultDto
from ddd.open_ai.domain.enums import (
    OpenaiChatConstraintsEnum,
    OpenaiChatModelEnum,
    OpenaiChatRoleEnum,
)
from ddd.open_ai.domain.exceptions.open_ai_exception import OpenAIException
from ddd.open_ai.infrastructure.repositories.gpt_chat_reader_api_repository import GptChatReaderApiRepository


@final
class ChatCompletionOpenaiService:
    """Use case to get chat completions with OpenAI Chat API."""

    _chat_completion_openai_dto: ChatCompletionOpenaiDto
    _chat_repository: GptChatReaderApiRepository

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __init__(self) -> None:
        self._chat_repository = GptChatReaderApiRepository.get_instance()

    def __call__(
        self,
        chat_completion_openai_dto: ChatCompletionOpenaiDto
    ) -> ChatCompletionOpenaiResultDto:
        """
        Gets chat completion from OpenAI according to DTO parameters.

        Returns:
            ChatCompletionOpenaiResultDto: Result DTO with response text

        Raises:
            OpenAIException: If parameter validation or chat completion fails
        """
        self._chat_completion_openai_dto = chat_completion_openai_dto

        self._fail_if_wrong_input()

        # Use non-streaming method
        response_text = self._chat_repository.get_chat_completion(
            messages=self._chat_completion_openai_dto.messages,
            model=self._chat_completion_openai_dto.model,
            temperature=self._chat_completion_openai_dto.temperature,
            max_tokens=self._chat_completion_openai_dto.max_tokens,
        )

        return ChatCompletionOpenaiResultDto.from_primitives({
            "response_text": response_text,
            "model": self._chat_completion_openai_dto.model,
            "temperature": self._chat_completion_openai_dto.temperature,
            "max_tokens": self._chat_completion_openai_dto.max_tokens,
        })

    def stream(
        self,
        chat_completion_openai_dto: ChatCompletionOpenaiDto
    ) -> Generator[str, None, None]:
        """
        Gets chat completion from OpenAI with streaming.

        Yields:
            str: Chunks of response text as they arrive

        Raises:
            OpenAIException: If parameter validation or chat completion fails
        """
        self._chat_completion_openai_dto = chat_completion_openai_dto

        self._fail_if_wrong_input()

        # Use streaming method
        yield from self._chat_repository.get_chat_completion_stream(
            messages=self._chat_completion_openai_dto.messages,
            model=self._chat_completion_openai_dto.model,
            temperature=self._chat_completion_openai_dto.temperature,
            max_tokens=self._chat_completion_openai_dto.max_tokens,
        )

    def _fail_if_wrong_input(self) -> None:
        """Validates input parameters."""
        # Validate model
        valid_models = list(OpenaiChatModelEnum)
        if self._chat_completion_openai_dto.model not in valid_models:
            raise OpenAIException.unexpected_custom(
                f"Invalid model: {self._chat_completion_openai_dto.model}. "
                f"Allowed values: {', '.join(valid_models)}"
            )

        # Validate temperature
        min_temp = OpenaiChatConstraintsEnum.MIN_TEMPERATURE
        max_temp = OpenaiChatConstraintsEnum.MAX_TEMPERATURE
        if not min_temp <= self._chat_completion_openai_dto.temperature <= max_temp:
            raise OpenAIException.unexpected_custom(
                f"Temperature must be between {min_temp} and {max_temp}"
            )

        # Validate max_tokens
        max_tokens_limit = OpenaiChatConstraintsEnum.MAX_TOKENS_LIMIT
        if self._chat_completion_openai_dto.max_tokens > max_tokens_limit:
            raise OpenAIException.unexpected_custom(
                f"max_tokens cannot exceed {max_tokens_limit}"
            )

        # Validate messages structure
        valid_roles = list(OpenaiChatRoleEnum)
        for msg in self._chat_completion_openai_dto.messages:
            role = msg.get("role", "")
            if role not in valid_roles:
                raise OpenAIException.unexpected_custom(
                    f"Invalid role '{role}'. Allowed values: {', '.join(valid_roles)}"
                )

            content = msg.get("content", "")
            if not content or not str(content).strip():
                raise OpenAIException.unexpected_custom(
                    "Message content cannot be empty"
                )
