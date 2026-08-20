from typing import final


@final
class RequestKeyEnum:
    """Claves con las que el front-controller arma sus respuestas de servicio."""

    VERSION = "version"
    ENVIRONMENT = "env"
