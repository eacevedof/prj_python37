from typing import final, Self

from ddd.outlook.application.list_attachments.list_attachments_dto import (
    ListAttachmentsDto,
)
from ddd.outlook.application.list_attachments.list_attachments_result_dto import (
    ListAttachmentsResultDto,
)
from ddd.outlook.infrastructure.repositories.messages_reader_graph_repository import (
    MessagesReaderGraphRepository,
)


@final
class ListAttachmentsService:
    """Service for listing attachments of a message."""

    _messages_reader_graph_repository: MessagesReaderGraphRepository

    def __init__(self) -> None:
        self._messages_reader_graph_repository = (
            MessagesReaderGraphRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, list_attachments_dto: ListAttachmentsDto
    ) -> ListAttachmentsResultDto:
        attachments = await self._messages_reader_graph_repository.list_attachments(
            mailbox=list_attachments_dto.mailbox,
            message_id=list_attachments_dto.message_id,
        )

        return ListAttachmentsResultDto.from_primitives({
            "attachments": attachments,
            "total": len(attachments),
        })
