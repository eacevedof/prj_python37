from typing import final, Self

from ddd.calendar.application.add_holiday.add_holiday_dto import AddHolidayDto
from ddd.calendar.application.add_holiday.add_holiday_result_dto import (
    AddHolidayResultDto,
)
from ddd.calendar.infrastructure.repositories.calendar_events_reader_graph_repository import (
    CalendarEventsReaderGraphRepository,
)
from ddd.calendar.infrastructure.repositories.calendar_events_writer_graph_repository import (
    CalendarEventsWriterGraphRepository,
)
from ddd.calendar.domain.exceptions.calendar_exception import CalendarException


@final
class AddHolidayService:
    """Service for adding holidays to a specific calendar."""

    _calendar_events_reader_graph_repository: CalendarEventsReaderGraphRepository
    _calendar_events_writer_graph_repository: CalendarEventsWriterGraphRepository

    def __init__(self) -> None:
        self._calendar_events_reader_graph_repository = CalendarEventsReaderGraphRepository.get_instance()
        self._calendar_events_writer_graph_repository = CalendarEventsWriterGraphRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, add_holiday_dto: AddHolidayDto) -> AddHolidayResultDto:
        """Add a holiday (all-day event) to a specific calendar.

        Args:
            add_holiday_dto: Input DTO with calendar name, date, and title.

        Returns:
            AddHolidayResultDto with created holiday info.

        Raises:
            CalendarException: If calendar not found or creation fails.
        """
        calendar_id = await self._calendar_events_reader_graph_repository.get_calendar_id_by_name(
            user_id=add_holiday_dto.user_id,
            calendar_name=add_holiday_dto.calendar_name,
        )

        if calendar_id is None:
            raise CalendarException.calendar_not_found(add_holiday_dto.calendar_name)

        event = await self._calendar_events_writer_graph_repository.create_event_in_calendar(
            user_id=add_holiday_dto.user_id,
            calendar_id=calendar_id,
            subject=add_holiday_dto.title,
            start_datetime=add_holiday_dto.get_start_date(),
            end_datetime=add_holiday_dto.get_end_date(),
            is_all_day=True,
            show_as="free",
        )

        event["calendar_name"] = add_holiday_dto.calendar_name
        return AddHolidayResultDto.from_primitives(event)
