import time
from typing import final, Self

import aiohttp

from ddd.shared.infrastructure.repositories.environment_reader_env_repository import (
    EnvironmentReaderEnvRepository,
)
from ddd.shared.domain.exceptions.graph_auth_exception import GraphAuthException

TOKEN_URL_TEMPLATE = "https://login.microsoftonline.com/{tenant_id}/oauth2/v2.0/token"
DEFAULT_SCOPE = "https://graph.microsoft.com/.default"
REFRESH_BUFFER_SECONDS = 60
DEFAULT_EXPIRES_IN = 3600


@final
class AccessTokenReaderGraphRepository:
    """Repository for Microsoft Graph API OAuth2 authentication.

    Uses client_credentials flow with Azure AD App Registration.
    Caches access token until expiration.
    """

    _instance: "AccessTokenReaderGraphRepository | None" = None
    _access_token: str | None = None
    _token_expires_at: float = 0

    def __init__(self) -> None:
        env = EnvironmentReaderEnvRepository.get_instance()
        self._tenant_id = env.get_sharepoint_tenant_id()
        self._client_id = env.get_sharepoint_client_id()
        self._client_secret = env.get_sharepoint_client_secret()
        self._token_url = TOKEN_URL_TEMPLATE.format(
            tenant_id=self._tenant_id
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
            GraphAuthException: If authentication fails.
        """
        if self._is_token_valid():
            return self._access_token  # type: ignore[return-value]

        await self._refresh_token()
        return self._access_token  # type: ignore[return-value]

    def _is_token_valid(self) -> bool:
        """Check if current token is still valid (with 60s buffer)."""
        if self._access_token is None:
            return False
        return time.time() < (
            self._token_expires_at - REFRESH_BUFFER_SECONDS
        )

    async def _refresh_token(self) -> None:
        """Request a new access token from Azure AD.

        Raises:
            GraphAuthException: If token request fails.
        """
        payload = {
            "client_id": self._client_id,
            "client_secret": self._client_secret,
            "scope": DEFAULT_SCOPE,
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
                    raise GraphAuthException.authentication_failed(error_text)

                data = await response.json()
                self._access_token = data["access_token"]
                expires_in = int(
                    data.get("expires_in", DEFAULT_EXPIRES_IN)
                )
                self._token_expires_at = time.time() + expires_in

    def invalidate_token(self) -> None:
        """Force token refresh on next request."""
        self._access_token = None
        self._token_expires_at = 0
