import time
from typing import final, Self

import aiohttp

from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)
from ddd.sharepoint.domain.exceptions.sharepoint_exception import SharePointException


@final
class GraphApiAuthRepository:
    """Repository for Microsoft Graph API OAuth2 authentication.

    Uses client_credentials flow with Azure AD App Registration.
    Caches access token until expiration.
    """

    _instance: "GraphApiAuthRepository | None" = None
    _access_token: str | None = None
    _token_expires_at: float = 0

    def __init__(self) -> None:
        env = EnvironmentReaderRawRepository.get_instance()
        self._tenant_id = env.get_sharepoint_tenant_id()
        self._client_id = env.get_sharepoint_client_id()
        self._client_secret = env.get_sharepoint_client_secret()
        self._token_url = (
            f"https://login.microsoftonline.com/{self._tenant_id}/oauth2/v2.0/token"
        )

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def get_access_token(self) -> str:
        """Get a valid access token, refreshing if necessary.

        Returns:
            Valid access token for Microsoft Graph API.

        Raises:
            SharePointException: If authentication fails.
        """
        if self._is_token_valid():
            return self._access_token  # type: ignore[return-value]

        await self._refresh_token()
        return self._access_token  # type: ignore[return-value]

    def _is_token_valid(self) -> bool:
        """Check if current token is still valid (with 60s buffer)."""
        if self._access_token is None:
            return False
        return time.time() < (self._token_expires_at - 60)

    async def _refresh_token(self) -> None:
        """Request a new access token from Azure AD.

        Raises:
            SharePointException: If token request fails.
        """
        payload = {
            "client_id": self._client_id,
            "client_secret": self._client_secret,
            "scope": "https://graph.microsoft.com/.default",
            "grant_type": "client_credentials",
        }

        async with aiohttp.ClientSession() as session:
            async with session.post(
                self._token_url,
                data=payload,
                headers={"Content-Type": "application/x-www-form-urlencoded"},
            ) as response:
                if response.status != 200:
                    error_text = await response.text()
                    raise SharePointException.authentication_failed(error_text)

                data = await response.json()
                self._access_token = data["access_token"]
                expires_in = int(data.get("expires_in", 3600))
                self._token_expires_at = time.time() + expires_in

    def invalidate_token(self) -> None:
        """Force token refresh on next request."""
        self._access_token = None
        self._token_expires_at = 0
