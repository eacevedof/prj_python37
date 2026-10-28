from typing import final, Self, Any

from ddd.calendar.infrastructure.repositories.abstract_calendar_graph_repository import (
    AbstractCalendarGraphRepository,
)
from ddd.calendar.domain.exceptions.calendar_exception import CalendarException


@final
class CalendarEventsReaderGraphRepository(AbstractCalendarGraphRepository):
    """Repository for reading Microsoft Graph Calendar events and calendars."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

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
