from typing import final


@final
class ResponseMessageEnum:
    """Mensajes que la API devuelve al cliente.

    UNEXPECTED_ERROR es deliberadamente vago: cuando algo revienta de forma no
    prevista, el detalle va al log (con su traza) y al cliente le llega una frase
    generica. Un mensaje de excepcion en crudo puede filtrar rutas del servidor,
    nombres de tabla o trozos de SQL.

    Los errores ESPERADOS (validacion, no encontrado, conflicto) si llevan mensaje
    concreto, porque los escribes tu en el service y sabes que dicen.
    """

    UNEXPECTED_ERROR = "An unexpected error has occurred"
    UNAUTHORIZED = "Invalid or missing X-Api-Key"
    HEALTH_OK = "ok"
