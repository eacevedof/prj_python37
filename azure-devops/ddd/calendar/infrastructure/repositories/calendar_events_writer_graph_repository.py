from typing import final, Self, Any

from ddd.calendar.infrastructure.repositories.abstract_calendar_graph_repository import (
    AbstractCalendarGraphRepository,
)
from ddd.calendar.domain.enums.sensitivity_enum import SensitivityEnum
from ddd.calendar.domain.exceptions.calendar_exception import CalendarException


@final
class CalendarEventsWriterGraphRepository(AbstractCalendarGraphRepository):
    """Repository for creating, updating and deleting Microsoft Graph Calendar events."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create_event(
        self,
        user_id: str,
        subject: str,
        start_datetime: str,
        end_datetime: str,
        time_zone: str = "UTC",
        body: str | None = None,
        location: str | None = None,
        attendees: list[str] | None = None,
        is_all_day: bool = False,
        sensitivity: str = SensitivityEnum.NORMAL.value,
    ) -> dict[str, Any]:
        """Create a new calendar event.

        Args:
            user_id: User ID or email (UPN).
            subject: Event subject/title.
            start_datetime: ISO 8601 start datetime.
            end_datetime: ISO 8601 end datetime.
            time_zone: Timezone for the event (default: UTC).
            body: Event body/description (HTML supported).
            location: Event location display name.
            attendees: List of attendee email addresses.
            is_all_day: Whether this is an all-day event.
            sensitivity: Event sensitivity (normal, personal, private, confidential).

        Returns:
            Created event dictionary.

        Raises:
            CalendarException: If creation fails.
        """
        url = f"{self._graph_base_url}/users/{user_id}/calendar/events"

        event_data: dict[str, Any] = {
            "subject": subject,
            "start": {
                "dateTime": start_datetime,
                "timeZone": time_zone,
            },
            "end": {
                "dateTime": end_datetime,
                "timeZone": time_zone,
            },
            "isAllDay": is_all_day,
            "sensitivity": sensitivity,
        }

        if body:
            event_data["body"] = {
                "contentType": "HTML",
                "content": body,
            }

        if location:
            event_data["location"] = {
                "displayName": location,
            }

        if attendees:
            event_data["attendees"] = [
                {
                    "emailAddress": {"address": email},
                    "type": "required",
                }
                for email in attendees
            ]

        result = await self._request("POST", url, json_data=event_data)
        if result is None:
            raise CalendarException.create_failed("No response from API")

        if isinstance(result, dict):
            return result

        raise CalendarException.create_failed("Unexpected response format")

    async def update_event(
        self,
        user_id: str,
        event_id: str,
        subject: str | None = None,
        start_datetime: str | None = None,
        end_datetime: str | None = None,
        time_zone: str | None = None,
        body: str | None = None,
        location: str | None = None,
        attendees: list[str] | None = None,
        is_all_day: bool | None = None,
        sensitivity: str | None = None,
    ) -> dict[str, Any]:
        """Update an existing calendar event.

        Args:
            user_id: User ID or email (UPN).
            event_id: Event ID to update.
            subject: New event subject/title.
            start_datetime: New ISO 8601 start datetime.
            end_datetime: New ISO 8601 end datetime.
            time_zone: New timezone for the event.
            body: New event body/description (HTML supported).
            location: New event location display name.
            attendees: New list of attendee email addresses.
            is_all_day: Whether this is an all-day event.
            sensitivity: Event sensitivity (normal, personal, private, confidential).

        Returns:
            Updated event dictionary.

        Raises:
            CalendarException: If update fails.
        """
        url = f"{self._graph_base_url}/users/{user_id}/calendar/events/{event_id}"

        event_data: dict[str, Any] = {}

        if subject is not None:
            event_data["subject"] = subject

        if start_datetime is not None:
            event_data["start"] = {
                "dateTime": start_datetime,
                "timeZone": time_zone or "UTC",
            }

        if end_datetime is not None:
            event_data["end"] = {
                "dateTime": end_datetime,
                "timeZone": time_zone or "UTC",
            }

        if body is not None:
            event_data["body"] = {
                "contentType": "HTML",
                "content": body,
            }

        if location is not None:
            event_data["location"] = {
                "displayName": location,
            }

        if attendees is not None:
            event_data["attendees"] = [
                {
                    "emailAddress": {"address": email},
                    "type": "required",
                }
                for email in attendees
            ]

        if is_all_day is not None:
            event_data["isAllDay"] = is_all_day

        if sensitivity is not None:
            event_data["sensitivity"] = sensitivity

        result = await self._request("PATCH", url, json_data=event_data)
        if result is None:
            raise CalendarException.update_failed(event_id, "No response from API")

        if isinstance(result, dict):
            return result

        raise CalendarException.update_failed(event_id, "Unexpected response format")

    async def delete_event(self, user_id: str, event_id: str) -> bool:
        """Delete a calendar event.

        Args:
            user_id: User ID or email (UPN).
            event_id: Event ID to delete.

        Returns:
            True if deleted successfully.

        Raises:
            CalendarException: If deletion fails.
        """
        url = f"{self._graph_base_url}/users/{user_id}/calendar/events/{event_id}"

        result = await self._request("DELETE", url)

        if result is None:
            return True

        raise CalendarException.delete_failed(event_id)

    async def create_event_in_calendar(
        self,
        user_id: str,
        calendar_id: str,
        subject: str,
        start_datetime: str,
        end_datetime: str,
        time_zone: str = "UTC",
        body: str | None = None,
        is_all_day: bool = False,
        show_as: str = "free",
    ) -> dict[str, Any]:
        """Create an event in a specific calendar.

        Args:
            user_id: User ID or email (UPN).
            calendar_id: ID of the calendar to create event in.
            subject: Event subject/title.
            start_datetime: ISO 8601 start datetime (date only for all-day).
            end_datetime: ISO 8601 end datetime (date only for all-day).
            time_zone: Timezone for the event (default: UTC).
            body: Event body/description (HTML supported).
            is_all_day: Whether this is an all-day event.
            show_as: How to show time: free, busy, tentative, oof, workingElsewhere.

        Returns:
            Created event dictionary.

        Raises:
            CalendarException: If creation fails.
        """
        url = f"{self._graph_base_url}/users/{user_id}/calendars/{calendar_id}/events"

        event_data: dict[str, Any] = {
            "subject": subject,
            "start": {
                "dateTime": start_datetime,
                "timeZone": time_zone,
            },
            "end": {
                "dateTime": end_datetime,
                "timeZone": time_zone,
            },
            "isAllDay": is_all_day,
            "showAs": show_as,
        }

        if body:
            event_data["body"] = {
                "contentType": "HTML",
                "content": body,
            }

        result = await self._request("POST", url, json_data=event_data)
        if result is None:
            raise CalendarException.create_failed("No response from API")

        if isinstance(result, dict):
            return result

        raise CalendarException.create_failed("Unexpected response format")
