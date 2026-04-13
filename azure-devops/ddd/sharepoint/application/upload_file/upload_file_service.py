from typing import final, Self

from ddd.sharepoint.application.upload_file.upload_file_dto import UploadFileDto
from ddd.sharepoint.application.upload_file.upload_file_result_dto import UploadFileResultDto
from ddd.sharepoint.infrastructure.repositories.sharepoint_files_repository import (
    SharePointFilesRepository,
)


@final
class UploadFileService:
    """Service for uploading files to SharePoint."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, upload_file_dto: UploadFileDto) -> UploadFileResultDto:
        """Upload a file to SharePoint.

        Args:
            upload_file_dto: Input DTO with file path and base64 content.

        Returns:
            UploadFileResultDto with uploaded file metadata.

        Raises:
            SharePointException: If upload fails.
        """
        repository = SharePointFilesRepository.get_instance(
            site_id=upload_file_dto.site_id
        )

        content_bytes = upload_file_dto.get_content_bytes()

        result = await repository.upload_file(
            file_path=upload_file_dto.file_path,
            content=content_bytes,
        )

        return UploadFileResultDto.from_primitives(result)
