from typing import final


@final
class ResponseKeyEnum:
    """Claves del sobre de respuesta que arma cada controller.

    Todas las respuestas de la API tienen la misma forma:

        exito -> {"status": 200, "data": {...}}
        error -> {"status": 404, "error": "list 7 not found"}

    El front controller lee `status` para traducirlo al codigo HTTP, asi que el
    nombre de esa clave no puede escribirse a mano en cada controller: se
    escribiria mal una vez y el fallo seria dificil de ver.

    Es una clase de constantes y no un Enum porque estas cadenas se usan como
    claves de diccionario. Con un `str, Enum` habria que escribir `.value` en cada
    uso y el codigo quedaria mas ruidoso sin ganar nada.
    """

    STATUS = "status"
    DATA = "data"
    ERROR = "error"
