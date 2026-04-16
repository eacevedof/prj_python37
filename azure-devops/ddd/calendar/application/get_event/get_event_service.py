from typing import final, Self

from ddd.calendar.application.get_event.get_event_dto import GetEventDto
from ddd.calendar.application.get_event.get_event_result_dto import GetEventResultDto
from ddd.calendar.infrastructure.repositories.calendar_events_repository import (
    CalendarEventsRepository,
)


@final
class GetEventService:
    """Service for getting a specific calendar event."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, get_event_dto: GetEventDto) -> GetEventResultDto:
        """Get a specific calendar event by ID.

        Args:
            get_event_dto: Input DTO with user ID and event ID.

        Returns:
            GetEventResultDto with event details.

        Raises:
            CalendarException: If event not found.
        """
        repository = CalendarEventsRepository.get_instance()

        event = await repository.get_event(
            user_id=get_event_dto.user_id,
            event_id=get_event_dto.event_id,
        )

        return GetEventResultDto.from_primitives(event)
