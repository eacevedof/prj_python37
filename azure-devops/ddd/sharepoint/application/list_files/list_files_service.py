from typing import final, Self

from ddd.sharepoint.application.list_files.list_files_dto import ListFilesDto
from ddd.sharepoint.application.list_files.list_files_result_dto import ListFilesResultDto
from ddd.sharepoint.infrastructure.repositories.sharepoint_files_repository import (
    SharePointFilesRepository,
)


@final
class ListFilesService:
    """Service for listing files in a SharePoint folder."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, list_files_dto: ListFilesDto) -> ListFilesResultDto:
        """List files and folders in a SharePoint folder.

        Args:
            list_files_dto: Input DTO with folder path and optional site ID.

        Returns:
            ListFilesResultDto with file/folder items.

        Raises:
            SharePointException: If listing fails.
        """
        repository = SharePointFilesRepository.get_instance(
            site_id=list_files_dto.site_id
        )

        items = await repository.list_files(folder_path=list_files_dto.folder_path)

        return ListFilesResultDto.from_primitives({
            "items": items,
            "folder_path": list_files_dto.folder_path,
            "total": len(items),
        })
