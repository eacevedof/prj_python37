from enum import Enum


class ToolNameEnum(str, Enum):
    """Tools que publica el servidor MCP de EMT Madrid."""

    GET_STOP_ARRIVALS = "emt_get_stop_arrivals"
    GET_LINES_INFO = "emt_get_lines_info"
    GET_STOPS_AROUND = "emt_get_stops_around"
    GET_STOP_DETAIL = "emt_get_stop_detail"
