from typing import final, Self, Any

import aiohttp

from ddd.sharepoint.infrastructure.repositories.graph_api_auth_repository import (
    GraphApiAuthRepository,
)
from ddd.calendar.domain.exceptions.calendar_exception import CalendarException


@final
class CalendarEventsRepository:
    """Repository for Microsoft Graph Calendar event operations.

    Supports CRUD operations on user calendars using Microsoft Graph API.
    Reuses OAuth authentication from SharePoint GraphApiAuthRepository.
    """

    _graph_base_url: str = "https://graph.microsoft.com/v1.0"

    def __init__(self) -> None:
        self._auth_repository = GraphApiAuthRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def _get_headers(self) -> dict[str, str]:
        """Get authorization headers with valid access token."""
        token = await self._auth_repository.get_access_token()
        return {
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json",
        }

    async def _request(
        self,
        method: str,
        url: str,
        json_data: dict[str, Any] | None = None,
    ) -> dict[str, Any] | None:
        """Make an authenticated request to Microsoft Graph API.

        Args:
            method: HTTP method (GET, POST, PATCH, DELETE).
            url: Full URL to request.
            json_data: JSON body for the request.

        Returns:
            JSON response dict or None for 204.

        Raises:
            CalendarException: If the API request fails.
        """
        headers = await self._get_headers()

        async with aiohttp.ClientSession() as session:
            kwargs: dict[str, Any] = {"headers": headers}
            if json_data is not None:
                kwargs["json"] = json_data

            async with session.request(method, url, **kwargs) as response:
                if response.status == 204:
                    return None

                if response.status == 404:
                    return None

                if response.status >= 400:
                    error_text = await response.text()
                    raise CalendarException.api_error(response.status, error_text)

                content_type_header = response.headers.get("Content-Type", "")
                if "application/json" in content_type_header:
                    return await response.json()

                return None

    async def list_events(
        self,
        user_id: str,
        start_datetime: str | None = None,
        end_datetime: str | None = None,
        top: int = 50,
    ) -> list[dict[str, Any]]:
        """List calendar events for a user.

        Args:
            user_id: User ID or email (UPN).
            start_datetime: ISO 8601 start datetime for calendarView (optional).
            end_datetime: ISO 8601 end datetime for calendarView (optional).
            top: Maximum number of events to return.

        Returns:
            List of event dictionaries.

        Raises:
            CalendarException: If listing fails.
        """
        if start_datetime and end_datetime:
            url = (
                f"{self._graph_base_url}/users/{user_id}/calendarView"
                f"?startDateTime={start_datetime}&endDateTime={end_datetime}"
                f"&$top={top}&$orderby=start/dateTime"
            )
        else:
            url = (
                f"{self._graph_base_url}/users/{user_id}/calendar/events"
                f"?$top={top}&$orderby=start/dateTime"
            )

        result = await self._request("GET", url)
        if result is None:
            raise CalendarException.user_not_found(user_id)

        if isinstance(result, dict):
            return result.get("value", [])
        return []

    async def get_event(self, user_id: str, event_id: str) -> dict[str, Any]:
        """Get a specific calendar event.

        Args:
            user_id: User ID or email (UPN).
            event_id: Event ID.

        Returns:
            Event dictionary.

        Raises:
            CalendarException: If event not found.
        """
        url = f"{self._graph_base_url}/users/{user_id}/calendar/events/{event_id}"

        result = await self._request("GET", url)
        if result is None:
            raise CalendarException.event_not_found(event_id)

        if isinstance(result, dict):
            return result

        raise CalendarException.event_not_found(event_id)

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
        sensitivity: str = "normal",
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

    async def list_calendars(self, user_id: str) -> list[dict[str, Any]]:
        """List all calendars for a user.

        Args:
            user_id: User ID or email (UPN).

        Returns:
            List of calendar dictionaries.

        Raises:
            CalendarException: If listing fails.
        """
        url = f"{self._graph_base_url}/users/{user_id}/calendars"

        result = await self._request("GET", url)
        if result is None:
            raise CalendarException.user_not_found(user_id)

        if isinstance(result, dict):
            return result.get("value", [])
        return []

    async def get_calendar_id_by_name(
        self, user_id: str, calendar_name: str
    ) -> str | None:
        """Find a calendar ID by its name.

        Args:
            user_id: User ID or email (UPN).
            calendar_name: Name of the calendar to find.

        Returns:
            Calendar ID if found, None otherwise.
        """
        calendars = await self.list_calendars(user_id)
        for calendar in calendars:
            if calendar.get("name", "").lower() == calendar_name.lower():
                return calendar.get("id")
        return None

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
