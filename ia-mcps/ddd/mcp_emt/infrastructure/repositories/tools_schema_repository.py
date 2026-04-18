from typing import final, Self

from mcp.types import Tool

from ddd.mcp_emt.domain.enums import ToolNameEnum


@final
class ToolsSchemaRepository:
    """Repository for EMT MCP tool schemas."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_all_emt_tools(self) -> list[Tool]:
        return [
            self._get_stop_arrivals_schema(),
            self._get_lines_info_schema(),
            self._get_stops_around_schema(),
            self._get_stop_detail_schema(),
        ]

    def _get_stop_arrivals_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.GET_STOP_ARRIVALS.value,
            description="get real-time bus arrivals for an EMT Madrid bus stop",
            inputSchema={
                "type": "object",
                "properties": {
                    "stop_id": {
                        "type": "string",
                        "description": "the bus stop ID (e.g., '72', '1234')",
                    },
                    "line_ids": {
                        "type": "string",
                        "description": "comma-separated list of line IDs to filter (optional, e.g., '001,002,C1')",
                    },
                },
                "required": ["stop_id"],
            },
        )

    def _get_lines_info_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.GET_LINES_INFO.value,
            description="get information about all EMT Madrid bus lines",
            inputSchema={
                "type": "object",
                "properties": {
                    "date": {
                        "type": "string",
                        "description": "date in YYYYMMDD format to get lines for that date (optional)",
                    },
                },
                "required": [],
            },
        )

    def _get_stops_around_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.GET_STOPS_AROUND.value,
            description="find EMT Madrid bus stops around a geographic location",
            inputSchema={
                "type": "object",
                "properties": {
                    "latitude": {
                        "type": "number",
                        "description": "latitude coordinate (e.g., 40.4168)",
                    },
                    "longitude": {
                        "type": "number",
                        "description": "longitude coordinate (e.g., -3.7038)",
                    },
                    "radius": {
                        "type": "integer",
                        "description": "search radius in meters (default: 500, max: 1000)",
                        "default": 500,
                    },
                },
                "required": ["latitude", "longitude"],
            },
        )

    def _get_stop_detail_schema(self) -> Tool:
        return Tool(
            name=ToolNameEnum.GET_STOP_DETAIL.value,
            description="get detailed information about a specific EMT Madrid bus stop",
            inputSchema={
                "type": "object",
                "properties": {
                    "stop_id": {
                        "type": "string",
                        "description": "the bus stop ID (e.g., '72', '1234')",
                    },
                },
                "required": ["stop_id"],
            },
        )
