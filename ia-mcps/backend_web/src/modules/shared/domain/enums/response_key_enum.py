from typing import final


@final
class ResponseKeyEnum:
    """Claves del sobre de respuesta HTTP del front-controller."""

    STATUS = "status"
    DATA = "data"
    ERROR = "error"
