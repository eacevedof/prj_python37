from typing import final, Self

from ddd.sharepoint.application.download_file.download_file_dto import DownloadFileDto
from ddd.sharepoint.application.download_file.download_file_result_dto import (
    DownloadFileResultDto,
)
from ddd.sharepoint.infrastructure.repositories.sharepoint_files_repository import (
    SharePointFilesRepository,
)


@final
class DownloadFileService:
    """Service for downloading files from SharePoint."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, download_file_dto: DownloadFileDto) -> DownloadFileResultDto:
        """Download a file from SharePoint.

        Args:
            download_file_dto: Input DTO with file path.

        Returns:
            DownloadFileResultDto with file content in base64.

        Raises:
            SharePointException: If download fails.
        """
        repository = SharePointFilesRepository.get_instance(
            site_id=download_file_dto.site_id
        )

        content = await repository.download_file(
            file_path=download_file_dto.file_path
        )

        return DownloadFileResultDto.from_primitives({
            "file_path": download_file_dto.file_path,
            "content": content,
        })
