from typing import final


@final
class EmtResultKeyEnum:
    """Claves de los `to_dict()` que devuelven los casos de uso de emt_mod.

    Son el contrato que cruza el puerto `EmtQueryPort` hacia `emt_mcp`: si aquí se
    renombra algo, la fachada deja de encontrarlo. Por eso el nombre se escribe
    una sola vez, y a los dos lados se lee de aquí.
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

    LINES = "lines"
    LABEL = "label"
    NAME_A = "name_a"
    NAME_B = "name_b"
    GROUP = "group"

    STOPS = "stops"
