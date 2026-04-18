from enum import Enum
from typing import final


@final
class ToolNameEnum(str, Enum):
    """MCP tool names exposed by the EMT server."""

    GET_STOP_ARRIVALS = "emt_get_stop_arrivals"
    GET_LINES_INFO = "emt_get_lines_info"
    GET_STOPS_AROUND = "emt_get_stops_around"
    GET_STOP_DETAIL = "emt_get_stop_detail"
