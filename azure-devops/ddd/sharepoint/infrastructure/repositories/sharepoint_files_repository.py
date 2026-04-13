from typing import final, Self, Any

import aiohttp

from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)
from ddd.sharepoint.infrastructure.repositories.graph_api_auth_repository import (
    GraphApiAuthRepository,
)
from ddd.sharepoint.domain.exceptions.sharepoint_exception import SharePointException


@final
class SharePointFilesRepository:
    """Repository for SharePoint file operations using Microsoft Graph API.

    Supports CRUD operations on SharePoint document libraries.
    """

    _graph_base_url: str = "https://graph.microsoft.com/v1.0"

    def __init__(self, site_id: str) -> None:
        self._site_id = site_id
        self._auth_repository = GraphApiAuthRepository.get_instance()

    @classmethod
    def get_instance(cls, site_id: str | None = None) -> Self:
        if site_id is None:
            site_id = EnvironmentReaderRawRepository.get_instance().get_sharepoint_site_id()
        return cls(site_id=site_id)

    async def _get_headers(self) -> dict[str, str]:
        """Get authorization headers with valid access token."""
        token = await self._auth_repository.get_access_token()
        return {
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json",
        }

    async def _request(
        self,
        method: str,
        url: str,
        json_data: dict[str, Any] | None = None,
        data: bytes | None = None,
        content_type: str | None = None,
    ) -> dict[str, Any] | bytes | None:
        """Make an authenticated request to Microsoft Graph API.

        Args:
            method: HTTP method (GET, POST, PUT, DELETE).
            url: Full URL to request.
            json_data: JSON body for the request.
            data: Raw bytes for file upload.
            content_type: Content-Type header override.

        Returns:
            JSON response dict, raw bytes for downloads, or None for 204.

        Raises:
            SharePointException: If the API request fails.
        """
        headers = await self._get_headers()
        if content_type:
            headers["Content-Type"] = content_type

        async with aiohttp.ClientSession() as session:
            kwargs: dict[str, Any] = {"headers": headers}
            if json_data is not None:
                kwargs["json"] = json_data
            if data is not None:
                kwargs["data"] = data

            async with session.request(method, url, **kwargs) as response:
                if response.status == 204:
                    return None

                if response.status == 404:
                    return None

                if response.status >= 400:
                    error_text = await response.text()
                    raise SharePointException.api_error(response.status, error_text)

                content_type_header = response.headers.get("Content-Type", "")
                if "application/json" in content_type_header:
                    return await response.json()

                return await response.read()

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
