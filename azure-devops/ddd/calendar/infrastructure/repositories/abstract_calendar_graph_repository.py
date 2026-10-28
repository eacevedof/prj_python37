from abc import ABC
from typing import Any

import aiohttp

from ddd.shared.infrastructure.repositories.access_token_reader_graph_repository import (
    AccessTokenReaderGraphRepository,
)
from ddd.calendar.domain.enums.graph_api_enum import GraphApiEnum
from ddd.calendar.domain.enums.http_status_enum import HttpStatusEnum
from ddd.calendar.domain.exceptions.calendar_exception import CalendarException


class AbstractCalendarGraphRepository(ABC):
    """Base repository for Microsoft Graph Calendar event operations.

    Supports CRUD operations on user calendars using Microsoft Graph API.
    Reuses OAuth authentication from the shared AccessTokenReaderGraphRepository.
    """

    _graph_base_url: str = GraphApiEnum.BASE_URL.value

    def __init__(self) -> None:
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
    ) -> dict[str, Any] | None:
        """Make an authenticated request to Microsoft Graph API.

        Args:
            method: HTTP method (GET, POST, PATCH, DELETE).
            url: Full URL to request.
            json_data: JSON body for the request.

        Returns:
            JSON response dict or None for 204.

        Raises:
            CalendarException: If the API request fails.
        """
        headers = await self._get_headers()

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
                    raise CalendarException.api_error(response.status, error_text)

                content_type_header = response.headers.get("Content-Type", "")
                if "application/json" in content_type_header:
                    return await response.json()

                return None
