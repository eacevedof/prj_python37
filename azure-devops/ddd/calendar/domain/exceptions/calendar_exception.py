from typing import final


@final
class CalendarException(Exception):
    """Exception for Calendar operations."""

    def __init__(self, message: str) -> None:
        self.message = message
        super().__init__(self.message)

    @classmethod
    def authentication_failed(cls, detail: str = "") -> "CalendarException":
        msg = "Calendar authentication failed"
        if detail:
            msg = f"{msg}: {detail}"
        return cls(msg)

    @classmethod
    def event_not_found(cls, event_id: str) -> "CalendarException":
        return cls(f"Event not found: {event_id}")

    @classmethod
    def user_not_found(cls, user_id: str) -> "CalendarException":
        return cls(f"User not found: {user_id}")

    @classmethod
    def create_failed(cls, detail: str = "") -> "CalendarException":
        msg = "Failed to create calendar event"
        if detail:
            msg = f"{msg}: {detail}"
        return cls(msg)

    @classmethod
    def update_failed(cls, event_id: str, detail: str = "") -> "CalendarException":
        msg = f"Failed to update event: {event_id}"
        if detail:
            msg = f"{msg} - {detail}"
        return cls(msg)

    @classmethod
    def delete_failed(cls, event_id: str, detail: str = "") -> "CalendarException":
        msg = f"Failed to delete event: {event_id}"
        if detail:
            msg = f"{msg} - {detail}"
        return cls(msg)

    @classmethod
    def api_error(cls, status_code: int, detail: str = "") -> "CalendarException":
        msg = f"Calendar API error (HTTP {status_code})"
        if detail:
            msg = f"{msg}: {detail}"
        return cls(msg)

    @classmethod
    def invalid_date_range(cls, start: str, end: str) -> "CalendarException":
        return cls(f"Invalid date range: start={start}, end={end}")
