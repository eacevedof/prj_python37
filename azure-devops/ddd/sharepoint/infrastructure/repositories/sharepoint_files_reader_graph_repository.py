from typing import final, Self, Any

from ddd.shared.infrastructure.repositories.environment_reader_env_repository import (
    EnvironmentReaderEnvRepository,
)
from ddd.sharepoint.infrastructure.repositories.abstract_sharepoint_graph_repository import (
    AbstractSharepointGraphRepository,
)
from ddd.sharepoint.domain.exceptions.sharepoint_exception import SharePointException


@final
class SharepointFilesReaderGraphRepository(AbstractSharepointGraphRepository):
    """Repository for reading SharePoint files using Microsoft Graph API."""

    @classmethod
    def get_instance(cls, site_id: str | None = None) -> Self:
        if site_id is None:
            site_id = EnvironmentReaderEnvRepository.get_instance().get_sharepoint_site_id()
        return cls(site_id=site_id)

    async def list_files(
        self, folder_path: str = "/"
    ) -> list[dict[str, Any]]:
        """List files and folders in a SharePoint folder.

        Args:
            folder_path: Path relative to document library root.
                         Use "/" for root, "/folder/subfolder" for nested.

        Returns:
            List of file/folder metadata dictionaries.

        Raises:
            SharePointException: If listing fails.
        """
        folder_path = folder_path.strip()
        if not folder_path or folder_path == "/":
            url = f"{self._graph_base_url}/sites/{self._site_id}/drive/root/children"
        else:
            clean_path = folder_path.strip("/")
            url = f"{self._graph_base_url}/sites/{self._site_id}/drive/root:/{clean_path}:/children"

        result = await self._request("GET", url)
        if result is None:
            raise SharePointException.folder_not_found(folder_path)

        if isinstance(result, dict):
            return result.get("value", [])
        return []

    async def download_file(self, file_path: str) -> bytes:
        """Download a file from SharePoint.

        Args:
            file_path: Path to the file (e.g., "/docs/file.pdf").

        Returns:
            File content as bytes.

        Raises:
            SharePointException: If download fails or file not found.
        """
        if not file_path:
            raise SharePointException.invalid_path(file_path)

        clean_path = file_path.strip("/")
        url = f"{self._graph_base_url}/sites/{self._site_id}/drive/root:/{clean_path}:/content"

        result = await self._request("GET", url)

        if result is None:
            raise SharePointException.file_not_found(file_path)

        if isinstance(result, bytes):
            return result

        raise SharePointException.download_failed(
            file_path, "Unexpected response format"
        )

    async def download_file_by_id(self, item_id: str) -> bytes:
        """Download a file by its SharePoint item ID.

        Args:
            item_id: SharePoint drive item ID.

        Returns:
            File content as bytes.

        Raises:
            SharePointException: If download fails.
        """
        url = f"{self._graph_base_url}/sites/{self._site_id}/drive/items/{item_id}/content"

        result = await self._request("GET", url)

        if result is None:
            raise SharePointException.file_not_found(f"item_id={item_id}")

        if isinstance(result, bytes):
            return result

        raise SharePointException.download_failed(
            f"item_id={item_id}", "Unexpected response format"
        )

    async def get_file_metadata(self, file_path: str) -> dict[str, Any] | None:
        """Get metadata for a file or folder.

        Args:
            file_path: Path to the file or folder.

        Returns:
            File/folder metadata dict or None if not found.
        """
        if not file_path:
            return None

        clean_path = file_path.strip("/")
        url = f"{self._graph_base_url}/sites/{self._site_id}/drive/root:/{clean_path}"

        result = await self._request("GET", url)

        if isinstance(result, dict):
            return result
        return None
