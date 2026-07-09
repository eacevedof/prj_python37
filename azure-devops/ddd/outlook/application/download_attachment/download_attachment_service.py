from pathlib import Path
from typing import final, Self

from ddd.shared.infrastructure.components.encoder import Encoder
from ddd.shared.infrastructure.repositories.environment_reader_env_repository import (
    EnvironmentReaderEnvRepository,
)
from ddd.outlook.application.download_attachment.download_attachment_dto import (
    DownloadAttachmentDto,
)
from ddd.outlook.application.download_attachment.download_attachment_result_dto import (
    DownloadAttachmentResultDto,
)
from ddd.outlook.domain.exceptions.outlook_exception import OutlookException
from ddd.outlook.infrastructure.repositories.messages_reader_graph_repository import (
    MessagesReaderGraphRepository,
)

FORBIDDEN_FILENAME_CHARS = '<>:"|?*'


@final
class DownloadAttachmentService:
    """Service for downloading a message attachment and saving it to disk."""

    _messages_reader_graph_repository: MessagesReaderGraphRepository
    _encoder: Encoder

    def __init__(self) -> None:
        self._messages_reader_graph_repository = (
            MessagesReaderGraphRepository.get_instance()
        )
        self._encoder = Encoder.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, download_attachment_dto: DownloadAttachmentDto
    ) -> DownloadAttachmentResultDto:
        mailbox = (
            download_attachment_dto.mailbox
            or EnvironmentReaderEnvRepository.get_instance().get_outlook_default_mailbox()
        )
        attachment = await self._messages_reader_graph_repository.get_attachment(
            mailbox=mailbox,
            message_id=download_attachment_dto.message_id,
            attachment_id=download_attachment_dto.attachment_id,
        )

        if attachment is None:
            raise OutlookException.attachment_not_found(
                download_attachment_dto.attachment_id
            )

        name = attachment.get("name", "")
        content_bytes_b64 = attachment.get("contentBytes")
        if not content_bytes_b64:
            raise OutlookException.attachment_has_no_content(name)

        file_bytes = self._encoder.get_bytes_from_base64(content_bytes_b64)

        target_dir = Path(
            download_attachment_dto.target_dir
            or EnvironmentReaderEnvRepository.get_instance().get_outlook_downloads_path()
        )
        target_dir.mkdir(parents=True, exist_ok=True)

        target_path = self.__get_available_path(
            target_dir, self.__get_safe_filename(name)
        )
        target_path.write_bytes(file_bytes)

        return DownloadAttachmentResultDto.from_primitives(
            {
                "name": name,
                "content_type": attachment.get("contentType", ""),
                "size": len(file_bytes),
                "saved_path": str(target_path),
            }
        )

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
