"""Service for streaming chat completion with OpenAI Chat API."""

from typing import Self, final, Generator

from ddd.open_ai.domain.services import ChatCompletionInputValidatorService
from ddd.open_ai.infrastructure.repositories.gpt_chat_reader_api_repository import GptChatReaderApiRepository
from ddd.open_ai.application.chat_completion_openai.chat_completion_openai_dto import ChatCompletionOpenaiDto


@final
class StreamChatCompletionOpenaiService:
    """Use case to stream chat completions with OpenAI Chat API."""

    _gpt_chat_reader_api_repository: GptChatReaderApiRepository

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __init__(self) -> None:
        self._gpt_chat_reader_api_repository = GptChatReaderApiRepository.get_instance()

    def __call__(
        self,
        chat_completion_openai_dto: ChatCompletionOpenaiDto,
    ) -> Generator[str, None, None]:
        ChatCompletionInputValidatorService.fail_if_wrong_input(
            messages=chat_completion_openai_dto.messages,
            model=chat_completion_openai_dto.model,
            temperature=chat_completion_openai_dto.temperature,
            max_tokens=chat_completion_openai_dto.max_tokens,
        )

        yield from self._gpt_chat_reader_api_repository.get_chat_completion_stream(
            messages=chat_completion_openai_dto.messages,
            model=chat_completion_openai_dto.model,
            temperature=chat_completion_openai_dto.temperature,
            max_tokens=chat_completion_openai_dto.max_tokens,
        )
