from typing import final


@final
class EmtException(Exception):
    """Exception for EMT API operations."""

    def __init__(self, message: str) -> None:
        self.message = message
        super().__init__(self.message)

    @classmethod
    def authentication_failed(cls, detail: str = "") -> "EmtException":
        msg = "EMT authentication failed"
        if detail:
            msg = f"{msg}: {detail}"
        return cls(msg)

    @classmethod
    def stop_not_found(cls, stop_id: str) -> "EmtException":
        return cls(f"Stop not found: {stop_id}")

    @classmethod
    def line_not_found(cls, line_id: str) -> "EmtException":
        return cls(f"Line not found: {line_id}")

    @classmethod
    def no_arrivals(cls, stop_id: str) -> "EmtException":
        return cls(f"No arrivals data for stop: {stop_id}")

    @classmethod
    def api_error(cls, status_code: int, detail: str = "") -> "EmtException":
        msg = f"EMT API error (HTTP {status_code})"
        if detail:
            msg = f"{msg}: {detail}"
        return cls(msg)

    @classmethod
    def token_expired(cls) -> "EmtException":
        return cls("EMT access token expired")

    @classmethod
    def missing_credentials(cls) -> "EmtException":
        return cls("EMT credentials not configured (EMT_CLIENT_ID, EMT_PASSKEY)")
