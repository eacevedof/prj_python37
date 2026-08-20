from typing import final


@final
class ResponseMessageEnum:
    """Mensajes genéricos hacia el cliente.

    El 500 NUNCA devuelve el mensaje de la excepción (filtraría interioridades):
    va este texto y el detalle queda en el log.
    """

    UNEXPECTED_ERROR = "an unexpected error has occurred"
    UNAUTHORIZED = "Invalid or missing X-Api-Key"
    HEALTH_OK = "ok"
