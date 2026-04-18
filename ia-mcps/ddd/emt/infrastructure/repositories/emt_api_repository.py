import os
from typing import final, Self, Any

import aiohttp

from ddd.emt.domain.enums import EnvvarsKeysEnum
from ddd.emt.domain.exceptions import EmtException


@final
class EmtApiRepository:
    """Repository for EMT Madrid API operations.

    Handles authentication and bus arrival data retrieval from EMT OpenAPI.
    API docs: https://apidocs.emtmadrid.es/
    """

    _api_base_url: str = "https://openapi.emtmadrid.es/v2"
    _access_token: str | None = None

    def __init__(self) -> None:
        self._client_id = os.getenv(EnvvarsKeysEnum.EMT_CLIENT_ID.value, "")
        self._passkey = os.getenv(EnvvarsKeysEnum.EMT_PASSKEY.value, "")

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def _login(self) -> str:
        """Authenticate with EMT API and get access token.

        Returns:
            Access token string.

        Raises:
            EmtException: If authentication fails.
        """
        if not self._client_id or not self._passkey:
            raise EmtException.missing_credentials()

        url = f"{self._api_base_url}/mobilitylabs/user/login/"
        headers = {
            "X-ClientId": self._client_id,
            "passKey": self._passkey,
            "Content-Type": "application/json",
        }

        async with aiohttp.ClientSession() as session:
            async with session.get(url, headers=headers) as response:
                if response.status != 200:
                    error_text = await response.text()
                    raise EmtException.authentication_failed(error_text)

                data = await response.json()

                if data.get("code") != "00":
                    raise EmtException.authentication_failed(
                        data.get("description", "Unknown error")
                    )

                access_token = data.get("data", [{}])[0].get("accessToken")
                if not access_token:
                    raise EmtException.authentication_failed("No access token in response")

                self._access_token = access_token
                return access_token

    async def _get_headers(self) -> dict[str, str]:
        """Get authorization headers with valid access token."""
        if not self._access_token:
            await self._login()

        return {
            "accessToken": self._access_token or "",
            "Content-Type": "application/json",
        }

    async def _request(
        self,
        method: str,
        url: str,
        json_data: dict[str, Any] | None = None,
        retry_on_auth_error: bool = True,
    ) -> dict[str, Any]:
        """Make an authenticated request to EMT API.

        Args:
            method: HTTP method (GET, POST).
            url: Full URL to request.
            json_data: JSON body for the request.
            retry_on_auth_error: Whether to retry on auth failure.

        Returns:
            JSON response dict.

        Raises:
            EmtException: If the API request fails.
        """
        headers = await self._get_headers()

        async with aiohttp.ClientSession() as session:
            kwargs: dict[str, Any] = {"headers": headers}
            if json_data is not None:
                kwargs["json"] = json_data

            async with session.request(method, url, **kwargs) as response:
                if response.status == 401 and retry_on_auth_error:
                    self._access_token = None
                    return await self._request(
                        method, url, json_data, retry_on_auth_error=False
                    )

                if response.status >= 400:
                    error_text = await response.text()
                    raise EmtException.api_error(response.status, error_text)

                data = await response.json()

                if data.get("code") not in ("00", "01", "80"):
                    raise EmtException.api_error(
                        response.status,
                        data.get("description", "Unknown error"),
                    )

                return data

    async def get_stop_arrivals(
        self,
        stop_id: str,
        line_ids: list[str] | None = None,
    ) -> dict[str, Any]:
        """Get real-time bus arrivals for a stop.

        Args:
            stop_id: The bus stop ID.
            line_ids: Optional list of line IDs to filter.

        Returns:
            Dict with arrival information.

        Raises:
            EmtException: If the request fails.
        """
        url = f"{self._api_base_url}/transport/busemtmad/stops/{stop_id}/arrives/"

        body: dict[str, Any] = {
            "cultureInfo": "ES",
            "Text_StopRequired_YN": "Y",
            "Text_EstimationsRequired_YN": "Y",
            "Text_IncidencesRequired_YN": "N",
        }

        if line_ids:
            body["statistics"] = "N"
            body["lines"] = line_ids

        return await self._request("POST", url, json_data=body)

    async def get_lines_info(
        self,
        date: str | None = None,
    ) -> dict[str, Any]:
        """Get information about bus lines.

        Args:
            date: Optional date in YYYYMMDD format.

        Returns:
            Dict with lines information.

        Raises:
            EmtException: If the request fails.
        """
        url = f"{self._api_base_url}/transport/busemtmad/lines/info/"

        body: dict[str, Any] = {}
        if date:
            body["date"] = date

        return await self._request("POST", url, json_data=body)

    async def get_line_detail(
        self,
        line_id: str,
        direction: str = "1",
        date: str | None = None,
    ) -> dict[str, Any]:
        """Get detailed information about a specific line.

        Args:
            line_id: The line ID (e.g., "001", "C1").
            direction: Direction (1 or 2).
            date: Optional date in YYYYMMDD format.

        Returns:
            Dict with line detail information.

        Raises:
            EmtException: If the request fails.
        """
        url = f"{self._api_base_url}/transport/busemtmad/lines/{line_id}/stops/{direction}/"

        body: dict[str, Any] = {}
        if date:
            body["date"] = date

        return await self._request("POST", url, json_data=body)

    async def get_stops_around(
        self,
        latitude: float,
        longitude: float,
        radius: int = 500,
    ) -> dict[str, Any]:
        """Get bus stops around a geographic point.

        Args:
            latitude: Latitude coordinate.
            longitude: Longitude coordinate.
            radius: Search radius in meters (default: 500).

        Returns:
            Dict with stops information.

        Raises:
            EmtException: If the request fails.
        """
        url = f"{self._api_base_url}/transport/busemtmad/stops/arroundxy/{longitude}/{latitude}/{radius}/"

        return await self._request("GET", url)

    async def get_stop_detail(
        self,
        stop_id: str,
    ) -> dict[str, Any]:
        """Get detailed information about a specific stop.

        Args:
            stop_id: The bus stop ID.

        Returns:
            Dict with stop detail information.

        Raises:
            EmtException: If the request fails.
        """
        url = f"{self._api_base_url}/transport/busemtmad/stops/{stop_id}/detail/"

        return await self._request("GET", url)
