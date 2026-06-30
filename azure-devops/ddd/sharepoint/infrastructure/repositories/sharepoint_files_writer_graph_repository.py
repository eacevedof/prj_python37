from typing import final, Self, Any

from ddd.shared.infrastructure.repositories.environment_reader_env_repository import (
    EnvironmentReaderEnvRepository,
)
from ddd.sharepoint.infrastructure.repositories.abstract_sharepoint_graph_repository import (
    AbstractSharepointGraphRepository,
)
from ddd.sharepoint.domain.exceptions.sharepoint_exception import SharePointException


@final
class SharepointFilesWriterGraphRepository(AbstractSharepointGraphRepository):
    """Repository for uploading and deleting SharePoint files using Microsoft Graph API."""

    @classmethod
    def get_instance(cls, site_id: str | None = None) -> Self:
        if site_id is None:
            site_id = EnvironmentReaderEnvRepository.get_instance().get_sharepoint_site_id()
        return cls(site_id=site_id)

    async def upload_file(
        self, file_path: str, content: bytes
    ) -> dict[str, Any]:
        """Upload a file to SharePoint.

        Args:
            file_path: Destination path including filename (e.g., "/docs/file.pdf").
            content: File content as bytes.

        Returns:
            Uploaded file metadata.

        Raises:
            SharePointException: If upload fails.
        """
        if not file_path:
            raise SharePointException.invalid_path(file_path)

        clean_path = file_path.strip("/")
        url = f"{self._graph_base_url}/sites/{self._site_id}/drive/root:/{clean_path}:/content"

        result = await self._request(
            "PUT",
            url,
            data=content,
            content_type="application/octet-stream",
        )

        if result is None:
            raise SharePointException.upload_failed(file_path)

        if isinstance(result, dict):
            return result

        raise SharePointException.upload_failed(file_path, "Unexpected response format")

    async def delete_file(self, file_path: str) -> bool:
        """Delete a file from SharePoint.

        Args:
            file_path: Path to the file (e.g., "/docs/file.pdf").

        Returns:
            True if deleted successfully.

        Raises:
            SharePointException: If deletion fails.
        """
        if not file_path:
            raise SharePointException.invalid_path(file_path)

        clean_path = file_path.strip("/")
        url = f"{self._graph_base_url}/sites/{self._site_id}/drive/root:/{clean_path}"

        result = await self._request("DELETE", url)

        if result is None:
            return True

        raise SharePointException.delete_failed(file_path)

    async def delete_file_by_id(self, item_id: str) -> bool:
        """Delete a file by its SharePoint item ID.

        Args:
            item_id: SharePoint drive item ID.

        Returns:
            True if deleted successfully.

        Raises:
            SharePointException: If deletion fails.
        """
        url = f"{self._graph_base_url}/sites/{self._site_id}/drive/items/{item_id}"

        result = await self._request("DELETE", url)

        if result is None:
            return True

        raise SharePointException.delete_failed(f"item_id={item_id}")
