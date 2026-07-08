import asyncio
from pathlib import Path
from typing import final, Any, Self

import msal  # type: ignore[import-untyped]

import ddd
from ddd.shared.infrastructure.repositories.environment_reader_env_repository import (
    EnvironmentReaderEnvRepository,
)
from ddd.shared.domain.exceptions.graph_auth_exception import GraphAuthException

AUTHORITY_URL_TEMPLATE = "https://login.microsoftonline.com/{tenant_id}"
GRAPH_SCOPES = ["https://graph.microsoft.com/Mail.Read"]
TOKEN_CACHE_FILENAME = ".outlook-token-cache.json"


@final
class AccessTokenReaderDeviceGraphRepository:
    """Repository for Microsoft Graph API delegated authentication.

    Uses device code flow with a public client app (no client secret).
    The token cache (including the refresh token) is persisted to a local
    file, so after one interactive login the MCP server renews tokens
    silently. The issued tokens only grant access to the mailbox of the
    signed-in user (delegated Mail.Read).
    """

    _instance: "AccessTokenReaderDeviceGraphRepository | None" = None

    def __init__(self) -> None:
        env = EnvironmentReaderEnvRepository.get_instance()
        self._tenant_id = env.get_outlook_tenant_id()
        self._client_id = env.get_outlook_client_id()
        self._token_cache_path = (
            Path(ddd.__file__).resolve().parent.parent / TOKEN_CACHE_FILENAME
        )
        self._token_cache = msal.SerializableTokenCache()
        if self._token_cache_path.exists():
            self._token_cache.deserialize(
                self._token_cache_path.read_text(encoding="utf-8")
            )
        self._msal_app = msal.PublicClientApplication(
            client_id=self._client_id,
            authority=AUTHORITY_URL_TEMPLATE.format(tenant_id=self._tenant_id),
            token_cache=self._token_cache,
        )

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance  # type: ignore[return-value]

    async def get_access_token(self) -> str:
        """Get a valid delegated access token, renewing silently from cache.

        Returns:
            Valid access token for Microsoft Graph API.

        Raises:
            GraphAuthException: If there is no cached session (device login
                pending) or the silent renewal fails.
        """
        return await asyncio.to_thread(self.__acquire_token_silent_or_fail)

    def initiate_device_flow(self) -> dict[str, Any]:
        """Start the device code flow (CLI use only).

        Returns:
            MSAL flow dict; its 'message' key holds the user instructions
            (URL + code) to complete the login in a browser.

        Raises:
            GraphAuthException: If the flow could not be initiated.
        """
        flow: dict[str, Any] = self._msal_app.initiate_device_flow(scopes=GRAPH_SCOPES)
        if "user_code" not in flow:
            raise GraphAuthException.device_flow_failed(str(flow))
        return flow

    def complete_device_flow(self, flow: dict[str, Any]) -> str:
        """Block until the user completes the login in the browser (CLI use only).

        Args:
            flow: The flow dict returned by initiate_device_flow.

        Returns:
            The username (UPN) of the signed-in account.

        Raises:
            GraphAuthException: If the login fails or is not completed.
        """
        result: dict[str, Any] = self._msal_app.acquire_token_by_device_flow(flow)
        self.__save_cache_if_changed()

        if "access_token" not in result:
            detail = result.get("error_description", str(result))
            raise GraphAuthException.device_flow_failed(detail)

        claims: dict[str, Any] = result.get("id_token_claims", {})
        return str(claims.get("preferred_username", "unknown-account"))

    def invalidate_cache(self) -> None:
        """Remove the persisted token cache (forces a new device login)."""
        if self._token_cache_path.exists():
            self._token_cache_path.unlink()
        self._token_cache = msal.SerializableTokenCache()

    def __acquire_token_silent_or_fail(self) -> str:
        accounts = self._msal_app.get_accounts()
        if not accounts:
            raise GraphAuthException.device_login_required()

        result = self._msal_app.acquire_token_silent(GRAPH_SCOPES, account=accounts[0])
        self.__save_cache_if_changed()

        if not result or "access_token" not in result:
            raise GraphAuthException.device_login_required()

        return str(result["access_token"])

    def __save_cache_if_changed(self) -> None:
        if not self._token_cache.has_state_changed:
            return
        self._token_cache_path.write_text(
            self._token_cache.serialize(), encoding="utf-8"
        )
