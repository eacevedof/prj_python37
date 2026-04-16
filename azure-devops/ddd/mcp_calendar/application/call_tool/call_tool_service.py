from typing import final, Self, Any

from mcp.types import TextContent

from ddd.shared.infrastructure.components.logger import Logger
from ddd.mcp_calendar.domain.enums import ToolNameEnum
from ddd.mcp_calendar.application.call_tool.call_tool_dto import CallToolDto
from ddd.mcp_calendar.application.call_tool.call_tool_result_dto import (
    CallToolResultDto,
)
from ddd.calendar.application import (
    ListEventsDto,
    ListEventsService,
    GetEventDto,
    GetEventService,
    CreateEventDto,
    CreateEventService,
    UpdateEventDto,
    UpdateEventService,
    DeleteEventDto,
    DeleteEventService,
    AddHolidayDto,
    AddHolidayService,
)


@final
class CallToolService:
    """Service that routes MCP tool calls to Calendar operations."""

    _logger: Logger
    _payload_dict: dict[str, Any]

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._payload_dict = {}

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, call_tool_dto: CallToolDto) -> CallToolResultDto:
        self._payload_dict = call_tool_dto.payload_dict

        try:
            if call_tool_dto.event_name == ToolNameEnum.LIST_CAL_EVENTS.value:
                text_contents = await self.__get_list_events_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.GET_CAL_EVENT.value:
                text_contents = await self.__get_get_event_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.CREATE_CAL_EVENT.value:
                text_contents = await self.__get_create_event_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.UPDATE_CAL_EVENT.value:
                text_contents = await self.__get_update_event_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.DELETE_CAL_EVENT.value:
                text_contents = await self.__get_delete_event_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.ADD_CAL_HOLIDAY.value:
                text_contents = await self.__get_add_holiday_text_content()

            else:
                text_contents = [
                    TextContent(
                        type="text", text=f"unknown tool: {call_tool_dto.event_name}"
                    )
                ]

        except Exception as e:
            self._logger.write_error(
                module="CallToolService.__call__",
                message=str(e),
                context={
                    "tool": call_tool_dto.event_name,
                    "payload": self._payload_dict,
                },
            )
            text_contents = [TextContent(type="text", text=f"error: {str(e)}")]

        return CallToolResultDto.from_primitives({"contents": text_contents})

    async def __get_list_events_text_content(self) -> list[TextContent]:
        result = await ListEventsService.get_instance()(
            ListEventsDto.from_primitives(self._payload_dict)
        )

        if not result.items:
            return [
                TextContent(
                    type="text", text=f"no events found for user: {result.user_id}"
                )
            ]

        lines = [f"calendar events for {result.user_id} ({result.total} events):\n"]
        for item in result.items:
            all_day = " [all-day]" if item.is_all_day else ""
            location = f" @ {item.location}" if item.location else ""
            lines.append(
                f"- {item.subject}{all_day}\n"
                f"  start: {item.start_datetime}\n"
                f"  end: {item.end_datetime}\n"
                f"  id: {item.id}{location}"
            )

        return [TextContent(type="text", text="\n".join(lines))]

    async def __get_get_event_text_content(self) -> list[TextContent]:
        result = await GetEventService.get_instance()(
            GetEventDto.from_primitives(self._payload_dict)
        )

        attendees_str = ", ".join(result.attendees) if result.attendees else "none"
        body_preview = (
            result.body[:200] + "..." if len(result.body) > 200 else result.body
        )

        return [
            TextContent(
                type="text",
                text=(
                    f"event details:\n"
                    f"- id: {result.id}\n"
                    f"- subject: {result.subject}\n"
                    f"- start: {result.start_datetime}\n"
                    f"- end: {result.end_datetime}\n"
                    f"- timezone: {result.time_zone}\n"
                    f"- location: {result.location or 'none'}\n"
                    f"- organizer: {result.organizer}\n"
                    f"- attendees: {attendees_str}\n"
                    f"- all-day: {result.is_all_day}\n"
                    f"- sensitivity: {result.sensitivity}\n"
                    f"- body: {body_preview}\n"
                    f"- web link: {result.web_link}"
                ),
            )
        ]

    async def __get_create_event_text_content(self) -> list[TextContent]:
        result = await CreateEventService.get_instance()(
            CreateEventDto.from_primitives(self._payload_dict)
        )

        return [
            TextContent(
                type="text",
                text=(
                    f"event created:\n"
                    f"- id: {result.id}\n"
                    f"- subject: {result.subject}\n"
                    f"- start: {result.start_datetime}\n"
                    f"- end: {result.end_datetime}\n"
                    f"- web link: {result.web_link}"
                ),
            )
        ]

    async def __get_update_event_text_content(self) -> list[TextContent]:
        result = await UpdateEventService.get_instance()(
            UpdateEventDto.from_primitives(self._payload_dict)
        )

        return [
            TextContent(
                type="text",
                text=(
                    f"event updated:\n"
                    f"- id: {result.id}\n"
                    f"- subject: {result.subject}\n"
                    f"- start: {result.start_datetime}\n"
                    f"- end: {result.end_datetime}\n"
                    f"- web link: {result.web_link}"
                ),
            )
        ]

    async def __get_delete_event_text_content(self) -> list[TextContent]:
        result = await DeleteEventService.get_instance()(
            DeleteEventDto.from_primitives(self._payload_dict)
        )

        status = "deleted successfully" if result.deleted else "deletion failed"
        return [TextContent(type="text", text=f"event {result.event_id}: {status}")]

    async def __get_add_holiday_text_content(self) -> list[TextContent]:
        result = await AddHolidayService.get_instance()(
            AddHolidayDto.from_primitives(self._payload_dict)
        )

        return [
            TextContent(
                type="text",
                text=(
                    f"holiday added:\n"
                    f"- id: {result.id}\n"
                    f"- title: {result.title}\n"
                    f"- date: {result.date}\n"
                    f"- calendar: {result.calendar_name}"
                ),
            )
        ]
