from typing import final, Self, Any

from ddd.shared.infrastructure.components.texter import Texter
from ddd.outlook.domain.exceptions.outlook_exception import OutlookException
from ddd.outlook.application.get_message.get_message_dto import GetMessageDto
from ddd.outlook.application.get_message.get_message_result_dto import (
    GetMessageResultDto,
)
from ddd.outlook.infrastructure.repositories.messages_reader_graph_repository import (
    MessagesReaderGraphRepository,
)


@final
class GetMessageService:
    """Service for retrieving a single message with a flattened plain-text body."""

    _messages_reader_graph_repository: MessagesReaderGraphRepository
    _texter: Texter

    def __init__(self) -> None:
        self._messages_reader_graph_repository = (
            MessagesReaderGraphRepository.get_instance()
        )
        self._texter = Texter.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, get_message_dto: GetMessageDto) -> GetMessageResultDto:
        message = await self._messages_reader_graph_repository.get_message(
            mailbox=get_message_dto.mailbox,
            message_id=get_message_dto.message_id,
        )
        if message is None:
            raise OutlookException.message_not_found(get_message_dto.message_id)

        return GetMessageResultDto.from_primitives(self._to_primitives(message))

    def _to_primitives(self, message: dict[str, Any]) -> dict[str, Any]:
        from_field = message.get("from", {}) or {}
        from_address = (from_field.get("emailAddress", {}) or {}).get("address", "")

        to_recipients = message.get("toRecipients", []) or []
        to_addresses = [
            (recipient.get("emailAddress", {}) or {}).get("address", "")
            for recipient in to_recipients
        ]

        body = message.get("body", {}) or {}
        body_content = body.get("content", "")
        if body.get("contentType", "") == "html":
            body_text = self._texter.get_no_html_text(body_content)
        else:
            body_text = body_content

        return {
            "id": message.get("id", ""),
            "subject": message.get("subject", ""),
            "from": from_address,
            "to": to_addresses,
            "received": message.get("receivedDateTime", ""),
            "has_attachments": message.get("hasAttachments", False),
            "body_text": body_text,
        }
