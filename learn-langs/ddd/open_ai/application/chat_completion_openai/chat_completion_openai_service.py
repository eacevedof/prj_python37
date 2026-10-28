"""Service for chat completion with OpenAI Chat API."""

from typing import Self, final

from ddd.open_ai.domain.services import ChatCompletionInputValidatorService
from ddd.open_ai.infrastructure.repositories.gpt_chat_reader_api_repository import GptChatReaderApiRepository
from ddd.open_ai.application.chat_completion_openai.chat_completion_openai_dto import ChatCompletionOpenaiDto
from ddd.open_ai.application.chat_completion_openai.chat_completion_openai_result_dto import ChatCompletionOpenaiResultDto


@final
class ChatCompletionOpenaiService:
    """Use case to get chat completions with OpenAI Chat API."""

    _gpt_chat_reader_api_repository: GptChatReaderApiRepository

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __init__(self) -> None:
        self._gpt_chat_reader_api_repository = GptChatReaderApiRepository.get_instance()

    def __call__(
        self,
        chat_completion_openai_dto: ChatCompletionOpenaiDto,
    ) -> ChatCompletionOpenaiResultDto:
        ChatCompletionInputValidatorService.fail_if_wrong_input(
            messages=chat_completion_openai_dto.messages,
            model=chat_completion_openai_dto.model,
            temperature=chat_completion_openai_dto.temperature,
            max_tokens=chat_completion_openai_dto.max_tokens,
        )

        response_text = self._gpt_chat_reader_api_repository.get_chat_completion(
            messages=chat_completion_openai_dto.messages,
            model=chat_completion_openai_dto.model,
            temperature=chat_completion_openai_dto.temperature,
            max_tokens=chat_completion_openai_dto.max_tokens,
        )

        return ChatCompletionOpenaiResultDto.from_primitives({
            "response_text": response_text,
            "model": chat_completion_openai_dto.model,
            "temperature": chat_completion_openai_dto.temperature,
            "max_tokens": chat_completion_openai_dto.max_tokens,
        })
