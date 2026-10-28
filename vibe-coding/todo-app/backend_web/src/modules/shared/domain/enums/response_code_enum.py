from enum import IntEnum


class ResponseCodeEnum(IntEnum):
    """Codigos HTTP que devuelve la API.

    Es IntEnum y no una clase de constantes porque estos valores viajan al codigo
    de estado HTTP: al ser int de verdad, `int(ResponseCodeEnum.OK)` y las
    comparaciones numericas funcionan sin conversiones por el camino.

    Solo estan los que la API usa. Si necesitas otro, anadelo aqui: no escribas un
    404 suelto en un controller.
    """

    OK = 200
    CREATED = 201
    BAD_REQUEST = 400
    UNAUTHORIZED = 401
    NOT_FOUND = 404
    CONFLICT = 409
    INTERNAL_SERVER_ERROR = 500
