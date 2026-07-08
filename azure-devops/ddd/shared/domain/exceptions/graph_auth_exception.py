from typing import final

from ddd.shared.domain.exceptions.domain_exception import DomainException


@final
class GraphAuthException(DomainException):
    """Exception for Microsoft Graph API authentication operations."""

    def __init__(self, message: str) -> None:
        self.message = message
        super().__init__(self.message)

    @classmethod
    def authentication_failed(cls, detail: str = "") -> "GraphAuthException":
        msg = "SharePoint authentication failed"
        if detail:
            msg = f"{msg}: {detail}"
        return cls(msg)

    @classmethod
    def device_login_required(cls) -> "GraphAuthException":
        return cls(
            "Outlook delegated login required: run "
            "'python -m ddd.outlook.infrastructure.cli.device_login_cli' "
            "in a terminal and sign in with your corporate account"
        )

    @classmethod
    def device_flow_failed(cls, detail: str = "") -> "GraphAuthException":
        msg = "Device code flow failed"
        if detail:
            msg = f"{msg}: {detail}"
        return cls(msg)
