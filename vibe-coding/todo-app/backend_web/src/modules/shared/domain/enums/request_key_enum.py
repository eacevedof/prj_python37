from typing import final


@final
class RequestKeyEnum:
    """Claves que el front controller usa al armar la respuesta de /health-check.

    Pequeno, pero mismo motivo que ResponseKeyEnum: son cadenas que forman parte
    del contrato con el cliente, y un contrato no se escribe a mano en linea.
    """

    VERSION = "version"
    ENVIRONMENT = "environment"
