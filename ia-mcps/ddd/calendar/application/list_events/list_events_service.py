from typing import final, Self

from ddd.calendar.application.list_events.list_events_dto import ListEventsDto
from ddd.calendar.application.list_events.list_events_result_dto import (
    ListEventsResultDto,
)
from ddd.calendar.infrastructure.repositories.calendar_events_repository import (
    CalendarEventsRepository,
)


@final
class ListEventsService:
    """Service for listing calendar events."""

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, list_events_dto: ListEventsDto) -> ListEventsResultDto:
        """List calendar events for a user.

        Args:
            list_events_dto: Input DTO with user ID and optional date range.

        Returns:
            ListEventsResultDto with event items.

        Raises:
            CalendarException: If listing fails.
        """
        repository = CalendarEventsRepository.get_instance()

        items = await repository.list_events(
            user_id=list_events_dto.user_id,
            start_datetime=list_events_dto.start_datetime,
            end_datetime=list_events_dto.end_datetime,
            top=list_events_dto.top,
        )

        return ListEventsResultDto.from_primitives(
            {
                "items": items,
                "user_id": list_events_dto.user_id,
                "total": len(items),
            }
        )
