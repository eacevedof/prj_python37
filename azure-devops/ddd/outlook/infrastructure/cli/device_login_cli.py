"""Interactive device-code login for the Outlook MCP.

Run it once in a terminal (not through the MCP server):

    .venv-win\\Scripts\\python.exe -m ddd.outlook.infrastructure.cli.device_login_cli

After signing in, the token cache is persisted and the MCP server renews
tokens silently until the refresh token expires or is revoked.
"""

from ddd.shared.infrastructure.repositories.access_token_reader_device_graph_repository import (
    AccessTokenReaderDeviceGraphRepository,
)


def main() -> None:
    repository = AccessTokenReaderDeviceGraphRepository.get_instance()

    flow = repository.initiate_device_flow()
    print()
    print(flow["message"])
    print()
    print("waiting for you to complete the login in the browser...")

    username = repository.complete_device_flow(flow)
    print(f"login ok: {username}")
    print("token cache saved - the outlook mcp can now read your mailbox")


if __name__ == "__main__":
    main()
