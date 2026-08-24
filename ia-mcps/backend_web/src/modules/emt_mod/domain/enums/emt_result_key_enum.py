from typing import final


@final
class EmtResultKeyEnum:
    """Claves de los `to_dict()` que devuelven los casos de uso de emt_mod.

    Las claves del `to_dict()`, que es lo que serializaría un `api_controller`.
    La fachada MCP ya no las usa: desde que llama al caso de uso directamente,
    lee los campos del ResultDto.
    """

    STOP_ID = "stop_id"
    STOP_NAME = "stop_name"
    ADDRESS = "address"
    POSTAL_CODE = "postal_code"
    LATITUDE = "latitude"
    LONGITUDE = "longitude"
    RADIUS = "radius"
    WIFI = "wifi"
    TOTAL = "total"

    ARRIVALS = "arrivals"
    LINE = "line"
    DESTINATION = "destination"
    TIME_LEFT_MINUTES = "time_left_minutes"
    TIME_LEFT_SECONDS = "time_left_seconds"
    DISTANCE_METERS = "distance_meters"
    IS_HEAD = "is_head"
    DEVIATION = "deviation"

    LINES = "lines"
    LABEL = "label"
    NAME_A = "name_a"
    NAME_B = "name_b"
    GROUP = "group"
    START_DATE = "start_date"
    END_DATE = "end_date"

    STOPS = "stops"
