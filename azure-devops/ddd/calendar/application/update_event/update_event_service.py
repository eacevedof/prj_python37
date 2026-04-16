from typing import final, Self

from ddd.calendar.application.update_event.update_event_dto import UpdateEventDto
from ddd.calendar.application.update_event.update_event_result_dto import (
    UpdateEventResultDto,
)
from ddd.calendar.infrastructure.repositories.calendar_events_repository import (
    CalendarEventsRepository,
)


@final
class UpdateEventService:
    """Service for updating calendar events."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, update_event_dto: UpdateEventDto) -> UpdateEventResultDto:
        """Update an existing calendar event.

        Args:
            update_event_dto: Input DTO with event ID and fields to update.

        Returns:
            UpdateEventResultDto with updated event info.

        Raises:
            CalendarException: If update fails.
        """
        repository = CalendarEventsRepository.get_instance()

        event = await repository.update_event(
            user_id=update_event_dto.user_id,
            event_id=update_event_dto.event_id,
            subject=update_event_dto.subject,
            start_datetime=update_event_dto.start_datetime,
            end_datetime=update_event_dto.end_datetime,
            time_zone=update_event_dto.time_zone,
            body=update_event_dto.body,
            location=update_event_dto.location,
            attendees=update_event_dto.attendees,
            is_all_day=update_event_dto.is_all_day,
            sensitivity=update_event_dto.sensitivity,
        )

        return UpdateEventResultDto.from_primitives(event)
