from typing import final, Self

from ddd.outlook.application.list_messages.list_messages_dto import ListMessagesDto
from ddd.outlook.application.list_messages.list_messages_result_dto import (
    ListMessagesResultDto,
)
from ddd.outlook.infrastructure.repositories.messages_reader_graph_repository import (
    MessagesReaderGraphRepository,
)


@final
class ListMessagesService:
    """Service for listing messages in a mailbox."""

    _messages_reader_graph_repository: MessagesReaderGraphRepository

    def __init__(self) -> None:
        self._messages_reader_graph_repository = (
            MessagesReaderGraphRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, list_messages_dto: ListMessagesDto
    ) -> ListMessagesResultDto:
        messages = await self._messages_reader_graph_repository.list_messages(
            mailbox=list_messages_dto.mailbox,
            folder=list_messages_dto.folder,
            top=list_messages_dto.top,
            unread_only=list_messages_dto.unread_only,
            search=list_messages_dto.search,
        )

        return ListMessagesResultDto.from_primitives({
            "messages": messages,
            "total": len(messages),
        })
