from typing import final, Self

from ddd.sharepoint.application.delete_file.delete_file_dto import DeleteFileDto
from ddd.sharepoint.application.delete_file.delete_file_result_dto import DeleteFileResultDto
from ddd.sharepoint.infrastructure.repositories.sharepoint_files_repository import (
    SharePointFilesRepository,
)


@final
class DeleteFileService:
    """Service for deleting files from SharePoint."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, delete_file_dto: DeleteFileDto) -> DeleteFileResultDto:
        """Delete a file from SharePoint.

        Args:
            delete_file_dto: Input DTO with file path.

        Returns:
            DeleteFileResultDto with deletion result.

        Raises:
            SharePointException: If deletion fails.
        """
        repository = SharePointFilesRepository.get_instance(
            site_id=delete_file_dto.site_id
        )

        deleted = await repository.delete_file(
            file_path=delete_file_dto.file_path
        )

        return DeleteFileResultDto.from_primitives({
            "file_path": delete_file_dto.file_path,
            "deleted": deleted,
        })
