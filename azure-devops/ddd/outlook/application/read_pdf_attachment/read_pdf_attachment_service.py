from typing import final, Self

from ddd.shared.infrastructure.components.encoder import Encoder
from ddd.shared.infrastructure.components.pdfer import Pdfer
from ddd.outlook.application.read_pdf_attachment.read_pdf_attachment_dto import (
    ReadPdfAttachmentDto,
)
from ddd.outlook.application.read_pdf_attachment.read_pdf_attachment_result_dto import (
    ReadPdfAttachmentResultDto,
)
from ddd.outlook.domain.exceptions.outlook_exception import OutlookException
from ddd.outlook.infrastructure.repositories.messages_reader_graph_repository import (
    MessagesReaderGraphRepository,
)


@final
class ReadPdfAttachmentService:
    """Service for downloading a message's PDF attachment and extracting its text."""

    _messages_reader_graph_repository: MessagesReaderGraphRepository
    _encoder: Encoder
    _pdfer: Pdfer

    def __init__(self) -> None:
        self._messages_reader_graph_repository = (
            MessagesReaderGraphRepository.get_instance()
        )
        self._encoder = Encoder.get_instance()
        self._pdfer = Pdfer.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, read_pdf_attachment_dto: ReadPdfAttachmentDto
    ) -> ReadPdfAttachmentResultDto:
        attachment = await self._messages_reader_graph_repository.get_attachment(
            mailbox=read_pdf_attachment_dto.mailbox,
            message_id=read_pdf_attachment_dto.message_id,
            attachment_id=read_pdf_attachment_dto.attachment_id,
        )

        if attachment is None:
            raise OutlookException.attachment_not_found(
                read_pdf_attachment_dto.attachment_id
            )

        name = attachment.get("name", "")
        content_type = attachment.get("contentType", "")

        is_pdf = content_type == "application/pdf" or name.lower().endswith(".pdf")
        if not is_pdf:
            raise OutlookException.not_a_pdf(name)

        content_bytes_b64 = attachment.get("contentBytes")
        if not content_bytes_b64:
            raise OutlookException.attachment_has_no_content(name)

        pdf_bytes = self._encoder.get_bytes_from_base64(content_bytes_b64)
        text = self._pdfer.get_text_from_bytes(pdf_bytes)

        return ReadPdfAttachmentResultDto.from_primitives({
            "name": name,
            "content_type": content_type,
            "size": int(attachment.get("size", 0)),
            "text": text,
        })
