from typing import final, Self

from ddd.calendar.application.delete_event.delete_event_dto import DeleteEventDto
from ddd.calendar.application.delete_event.delete_event_result_dto import (
    DeleteEventResultDto,
)
from ddd.calendar.infrastructure.repositories.calendar_events_repository import (
    CalendarEventsRepository,
)


@final
class DeleteEventService:
    """Service for deleting calendar events."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, delete_event_dto: DeleteEventDto) -> DeleteEventResultDto:
        """Delete a calendar event.

        Args:
            delete_event_dto: Input DTO with user ID and event ID.

        Returns:
            DeleteEventResultDto with deletion result.

        Raises:
            CalendarException: If deletion fails.
        """
        repository = CalendarEventsRepository.get_instance()

        deleted = await repository.delete_event(
            user_id=delete_event_dto.user_id,
            event_id=delete_event_dto.event_id,
        )

        return DeleteEventResultDto.from_primitives(
            {
                "event_id": delete_event_dto.event_id,
                "deleted": deleted,
            }
        )
