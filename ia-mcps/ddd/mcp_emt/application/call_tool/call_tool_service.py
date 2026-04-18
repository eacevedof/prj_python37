from typing import final, Self, Any

from mcp.types import TextContent

from ddd.shared.infrastructure.components.logger import Logger
from ddd.mcp_emt.domain.enums import ToolNameEnum
from ddd.mcp_emt.application.call_tool.call_tool_dto import CallToolDto
from ddd.mcp_emt.application.call_tool.call_tool_result_dto import CallToolResultDto
from ddd.emt.application import (
    GetStopArrivalsDto,
    GetStopArrivalsService,
    GetLinesInfoDto,
    GetLinesInfoService,
    GetStopsAroundDto,
    GetStopsAroundService,
    GetStopDetailDto,
    GetStopDetailService,
)


@final
class CallToolService:
    """Service that routes MCP tool calls to EMT operations."""

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
            if call_tool_dto.event_name == ToolNameEnum.GET_STOP_ARRIVALS.value:
                text_contents = await self.__get_stop_arrivals_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.GET_LINES_INFO.value:
                text_contents = await self.__get_lines_info_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.GET_STOPS_AROUND.value:
                text_contents = await self.__get_stops_around_text_content()

            elif call_tool_dto.event_name == ToolNameEnum.GET_STOP_DETAIL.value:
                text_contents = await self.__get_stop_detail_text_content()

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

    async def __get_stop_arrivals_text_content(self) -> list[TextContent]:
        result = await GetStopArrivalsService.get_instance()(
            GetStopArrivalsDto.from_primitives(self._payload_dict)
        )

        if not result.arrivals:
            return [
                TextContent(
                    type="text",
                    text=f"no arrivals found for stop {result.stop_id} ({result.stop_name})",
                )
            ]

        lines = [
            f"bus arrivals for stop {result.stop_id} - {result.stop_name} ({result.total} buses):\n"
        ]
        for arr in result.arrivals:
            head_marker = " [en cabecera]" if arr.is_head else ""
            lines.append(
                f"- line {arr.line} -> {arr.destination}{head_marker}\n"
                f"  arrives in: {arr.time_left_minutes} min ({arr.time_left_seconds}s)\n"
                f"  distance: {arr.distance_meters}m"
            )

        return [TextContent(type="text", text="\n".join(lines))]

    async def __get_lines_info_text_content(self) -> list[TextContent]:
        result = await GetLinesInfoService.get_instance()(
            GetLinesInfoDto.from_primitives(self._payload_dict)
        )

        if not result.lines:
            return [TextContent(type="text", text="no bus lines found")]

        lines = [f"EMT Madrid bus lines ({result.total} lines):\n"]
        for line in result.lines[:50]:
            lines.append(
                f"- {line.label}: {line.name_a} <-> {line.name_b} (group: {line.group})"
            )

        if result.total > 50:
            lines.append(f"\n... and {result.total - 50} more lines")

        return [TextContent(type="text", text="\n".join(lines))]

    async def __get_stops_around_text_content(self) -> list[TextContent]:
        result = await GetStopsAroundService.get_instance()(
            GetStopsAroundDto.from_primitives(self._payload_dict)
        )

        if not result.stops:
            return [
                TextContent(
                    type="text",
                    text=f"no stops found within {result.radius}m of ({result.latitude}, {result.longitude})",
                )
            ]

        lines = [
            f"bus stops within {result.radius}m of ({result.latitude}, {result.longitude}) ({result.total} stops):\n"
        ]
        for stop in result.stops:
            stop_lines = ", ".join(stop.lines) if stop.lines else "no lines"
            lines.append(
                f"- [{stop.stop_id}] {stop.stop_name}\n"
                f"  address: {stop.address}\n"
                f"  lines: {stop_lines}"
            )

        return [TextContent(type="text", text="\n".join(lines))]

    async def __get_stop_detail_text_content(self) -> list[TextContent]:
        result = await GetStopDetailService.get_instance()(
            GetStopDetailDto.from_primitives(self._payload_dict)
        )

        stop_lines = ", ".join(result.lines) if result.lines else "no lines"
        wifi_status = "yes" if result.wifi else "no"

        return [
            TextContent(
                type="text",
                text=(
                    f"stop details:\n"
                    f"- id: {result.stop_id}\n"
                    f"- name: {result.stop_name}\n"
                    f"- address: {result.address}\n"
                    f"- postal code: {result.postal_code}\n"
                    f"- coordinates: ({result.latitude}, {result.longitude})\n"
                    f"- lines: {stop_lines}\n"
                    f"- wifi: {wifi_status}"
                ),
            )
        ]
