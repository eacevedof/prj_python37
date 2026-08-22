from enum import Enum


class ToolNameEnum(str, Enum):
    """Tools que publica el servidor MCP de EMT Madrid.

    Las cuatro primeras consultan la API de EMT y no necesitan usuario; las
    cinco de abajo tocan datos de alguien y exigen `user_tg_id` (el cliente
    natural es un bot de Telegram, que es quien conoce ese id).
    """

    GET_STOP_ARRIVALS = "emt_get_stop_arrivals"
    GET_LINES_INFO = "emt_get_lines_info"
    GET_STOPS_AROUND = "emt_get_stops_around"
    GET_STOP_DETAIL = "emt_get_stop_detail"

    ADD_FAVORITE_STOP = "emt_add_favorite_stop"
    GET_FAVORITE_STOPS = "emt_get_favorite_stops"
    UPDATE_FAVORITE_STOP = "emt_update_favorite_stop"
    DELETE_FAVORITE_STOP = "emt_delete_favorite_stop"
    GET_USERS = "emt_get_users"
