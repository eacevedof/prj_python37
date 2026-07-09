from pathlib import Path
from typing import final, Self, Any

from ddd.shared.infrastructure.components.encoder import Encoder
from ddd.shared.infrastructure.components.slugger import Slugger
from ddd.shared.infrastructure.repositories.environment_reader_env_repository import (
    EnvironmentReaderEnvRepository,
)
from ddd.outlook.application.archive_message.archive_message_dto import (
    ArchiveMessageDto,
)
from ddd.outlook.application.archive_message.archive_message_result_dto import (
    ArchiveMessageResultDto,
)
from ddd.outlook.application.get_message.get_message_dto import GetMessageDto
from ddd.outlook.application.get_message.get_message_result_dto import (
    GetMessageResultDto,
)
from ddd.outlook.application.get_message.get_message_service import GetMessageService
from ddd.outlook.infrastructure.repositories.messages_reader_graph_repository import (
    MessagesReaderGraphRepository,
)

FORBIDDEN_FILENAME_CHARS = '<>:"|?*'
EMAIL_FILENAME = "email.txt"
FOLDER_SLUG_MAX_LENGTH = 60


@final
class ArchiveMessageService:
    """Service that archives a message to disk: one folder per email holding
    the message as email.txt and every attachment alongside it."""

    _messages_reader_graph_repository: MessagesReaderGraphRepository
    _encoder: Encoder
    _slugger: Slugger

    def __init__(self) -> None:
        self._messages_reader_graph_repository = (
            MessagesReaderGraphRepository.get_instance()
        )
        self._encoder = Encoder.get_instance()
        self._slugger = Slugger.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, archive_message_dto: ArchiveMessageDto
    ) -> ArchiveMessageResultDto:
        mailbox = (
            archive_message_dto.mailbox
            or EnvironmentReaderEnvRepository.get_instance().get_outlook_default_mailbox()
        )
        message = await GetMessageService.get_instance()(
            GetMessageDto.from_primitives(
                {"mailbox": mailbox, "message_id": archive_message_dto.message_id}
            )
        )

        base_dir = Path(
            archive_message_dto.target_dir
            or EnvironmentReaderEnvRepository.get_instance().get_outlook_archive_path()
        )
        folder_path = self.__get_available_dir(
            base_dir, self.__get_folder_name(message.received, message.subject)
        )
        folder_path.mkdir(parents=True)

        email_file_path = folder_path / EMAIL_FILENAME
        email_file_path.write_text(self.__get_email_text(message), encoding="utf-8")

        attachments: list[dict[str, Any]] = []
        total_attachments = 0
        if message.has_attachments:
            attachments, total_attachments = await self.__save_attachments(
                mailbox, archive_message_dto.message_id, folder_path
            )

        return ArchiveMessageResultDto.from_primitives(
            {
                "subject": message.subject,
                "from": message.from_address,
                "received": message.received,
                "folder_path": str(folder_path),
                "email_file_path": str(email_file_path),
                "attachments": attachments,
                "total_attachments": total_attachments,
            }
        )

    async def __save_attachments(
        self, mailbox: str, message_id: str, folder_path: Path
    ) -> tuple[list[dict[str, Any]], int]:
        """Save every file attachment; item attachments (no bytes) are skipped."""
        attachments_metadata = (
            await self._messages_reader_graph_repository.list_attachments(
                mailbox=mailbox, message_id=message_id
            )
        )

        saved: list[dict[str, Any]] = []
        for metadata in attachments_metadata:
            attachment = await self._messages_reader_graph_repository.get_attachment(
                mailbox=mailbox,
                message_id=message_id,
                attachment_id=metadata.get("id", ""),
            )
            content_bytes_b64 = (attachment or {}).get("contentBytes")
            if not attachment or not content_bytes_b64:
                continue

            file_bytes = self._encoder.get_bytes_from_base64(content_bytes_b64)
            target_path = self.__get_available_path(
                folder_path, self.__get_safe_filename(attachment.get("name", ""))
            )
            target_path.write_bytes(file_bytes)
            saved.append(
                {
                    "name": attachment.get("name", ""),
                    "saved_path": str(target_path),
                    "size": len(file_bytes),
                }
            )

        return saved, len(attachments_metadata)

    def __get_email_text(self, message: GetMessageResultDto) -> str:
        return (
            f"subject: {message.subject}\n"
            f"from: {message.from_address}\n"
            f"to: {', '.join(message.to)}\n"
            f"received: {message.received}\n"
            f"message_id: {message.id}\n"
            f"\n"
            f"{message.body_text}\n"
        )

    def __get_folder_name(self, received: str, subject: str) -> str:
        """Build 'YYYYMMDD-<subject-slug>' from the received date and subject."""
        date_prefix = received[:10].replace("-", "") or "00000000"
        slug = self._slugger.get_slugged_text(subject)
        slug = slug[:FOLDER_SLUG_MAX_LENGTH].rstrip("-")
        return f"{date_prefix}-{slug or 'email'}"

    def __get_safe_filename(self, name: str) -> str:
        """Keep only the base name and strip characters invalid on Windows."""
        clean = Path(name.replace("\\", "/")).name
        for char in FORBIDDEN_FILENAME_CHARS:
            clean = clean.replace(char, "_")
        return clean or "attachment.bin"

    def __get_available_path(self, target_dir: Path, filename: str) -> Path:
        """Avoid overwriting: append -1, -2, ... if the file already exists."""
        candidate = target_dir / filename
        stem = candidate.stem
        suffix = candidate.suffix
        counter = 1
        while candidate.exists():
            candidate = target_dir / f"{stem}-{counter}{suffix}"
            counter += 1
        return candidate

    def __get_available_dir(self, base_dir: Path, folder_name: str) -> Path:
        """Avoid mixing archives: append -1, -2, ... if the folder already exists."""
        candidate = base_dir / folder_name
        counter = 1
        while candidate.exists():
            candidate = base_dir / f"{folder_name}-{counter}"
            counter += 1
        return candidate
