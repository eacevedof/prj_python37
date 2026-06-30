from abc import ABC
from typing import Any

import aiohttp

from ddd.shared.infrastructure.repositories.access_token_reader_graph_repository import (
    AccessTokenReaderGraphRepository,
)
from ddd.sharepoint.domain.enums.graph_api_enum import GraphApiEnum
from ddd.sharepoint.domain.enums.http_status_enum import HttpStatusEnum
from ddd.sharepoint.domain.exceptions.sharepoint_exception import SharePointException


class AbstractSharepointGraphRepository(ABC):
    """Base repository for SharePoint file operations using Microsoft Graph API.

    Supports CRUD operations on SharePoint document libraries.
    """

    _graph_base_url: str = GraphApiEnum.BASE_URL.value

    def __init__(self, site_id: str) -> None:
        self._site_id = site_id
        self._auth_repository = AccessTokenReaderGraphRepository.get_instance()

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
                if response.status == HttpStatusEnum.NO_CONTENT:
                    return None

                if response.status == HttpStatusEnum.NOT_FOUND:
                    return None

                if response.status >= HttpStatusEnum.BAD_REQUEST:
                    error_text = await response.text()
                    raise SharePointException.api_error(response.status, error_text)

                content_type_header = response.headers.get("Content-Type", "")
                if "application/json" in content_type_header:
                    return await response.json()

                return await response.read()
