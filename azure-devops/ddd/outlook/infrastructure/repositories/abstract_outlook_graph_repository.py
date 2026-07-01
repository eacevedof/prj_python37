from abc import ABC
from typing import Any

import aiohttp

from ddd.shared.infrastructure.repositories.access_token_reader_graph_repository import (
    AccessTokenReaderGraphRepository,
)
from ddd.outlook.domain.enums.graph_api_enum import GraphApiEnum
from ddd.outlook.domain.enums.http_status_enum import HttpStatusEnum
from ddd.outlook.domain.exceptions.outlook_exception import OutlookException


class AbstractOutlookGraphRepository(ABC):
    """Base repository for Outlook mail operations using Microsoft Graph API.

    Read-focused (GET) access to a user's mailbox messages and attachments.
    """

    _graph_base_url: str = GraphApiEnum.BASE_URL.value

    def __init__(self) -> None:
        self._access_token_reader_graph_repository = (
            AccessTokenReaderGraphRepository.get_instance()
        )

    async def _get_headers(self) -> dict[str, str]:
        """Get authorization headers with valid access token."""
        token = await self._access_token_reader_graph_repository.get_access_token()
        return {
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json",
        }

    async def _request(
        self,
        method: str,
        url: str,
        json_data: dict[str, Any] | None = None,
        extra_headers: dict[str, str] | None = None,
    ) -> dict[str, Any] | None:
        """Make an authenticated request to Microsoft Graph API.

        Args:
            method: HTTP method (GET, POST, ...).
            url: Full URL to request.
            json_data: JSON body for the request.
            extra_headers: Additional headers to merge (e.g. ConsistencyLevel).

        Returns:
            JSON response dict, or None for 204/404.

        Raises:
            OutlookException: If the API request fails (status >= 400).
        """
        headers = await self._get_headers()
        if extra_headers:
            headers.update(extra_headers)

        async with aiohttp.ClientSession() as session:
            kwargs: dict[str, Any] = {"headers": headers}
            if json_data is not None:
                kwargs["json"] = json_data

            async with session.request(method, url, **kwargs) as response:
                if response.status == HttpStatusEnum.NO_CONTENT:
                    return None

                if response.status == HttpStatusEnum.NOT_FOUND:
                    return None

                if response.status >= HttpStatusEnum.BAD_REQUEST:
                    error_text = await response.text()
                    raise OutlookException.api_error(response.status, error_text)

                return await response.json()
