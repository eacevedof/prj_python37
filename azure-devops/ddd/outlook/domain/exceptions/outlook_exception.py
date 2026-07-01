from typing import final

from ddd.shared.domain.exceptions.domain_exception import DomainException


@final
class OutlookException(DomainException):
    """Exception for Outlook (Microsoft Graph Mail) operations."""

    def __init__(self, message: str) -> None:
        self.message = message
        super().__init__(self.message)

    @classmethod
    def api_error(cls, status_code: int, detail: str = "") -> "OutlookException":
        msg = f"Graph API error {status_code}"
        if detail:
            msg = f"{msg}: {detail}"
        return cls(msg)

    @classmethod
    def message_not_found(cls, message_id: str) -> "OutlookException":
        return cls(f"Message not found: {message_id}")

    @classmethod
    def attachment_not_found(cls, attachment_id: str) -> "OutlookException":
        return cls(f"Attachment {attachment_id} not found")

    @classmethod
    def not_a_pdf(cls, name: str) -> "OutlookException":
        return cls(f"Attachment '{name}' is not a PDF")

    @classmethod
    def attachment_has_no_content(cls, name: str) -> "OutlookException":
        return cls(f"Attachment '{name}' has no inline content")
