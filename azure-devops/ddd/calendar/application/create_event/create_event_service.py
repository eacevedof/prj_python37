from typing import final, Self

from ddd.calendar.application.create_event.create_event_dto import CreateEventDto
from ddd.calendar.application.create_event.create_event_result_dto import (
    CreateEventResultDto,
)
from ddd.calendar.infrastructure.repositories.calendar_events_repository import (
    CalendarEventsRepository,
)


@final
class CreateEventService:
    """Service for creating calendar events."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, create_event_dto: CreateEventDto) -> CreateEventResultDto:
        """Create a new calendar event.

        Args:
            create_event_dto: Input DTO with event details.

        Returns:
            CreateEventResultDto with created event info.

        Raises:
            CalendarException: If creation fails.
        """
        repository = CalendarEventsRepository.get_instance()

        event = await repository.create_event(
            user_id=create_event_dto.user_id,
            subject=create_event_dto.subject,
            start_datetime=create_event_dto.start_datetime,
            end_datetime=create_event_dto.end_datetime,
            time_zone=create_event_dto.time_zone,
            body=create_event_dto.body,
            location=create_event_dto.location,
            attendees=create_event_dto.attendees
            if create_event_dto.attendees
            else None,
            is_all_day=create_event_dto.is_all_day,
            sensitivity=create_event_dto.sensitivity,
        )

        return CreateEventResultDto.from_primitives(event)
