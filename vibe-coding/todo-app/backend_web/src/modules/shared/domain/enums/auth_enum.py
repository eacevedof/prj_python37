from enum import Enum


class AuthEnum(str, Enum):
    """Constantes del borde de autenticacion.

    APIKEY_HEADER va en MINUSCULAS a proposito. Starlette normaliza los nombres de
    cabecera a minusculas al recibirlos, asi que `request.headers.get("x-api-key")`
    encuentra la cabecera venga como venga del cliente: `X-Api-Key`, `x-api-key` o
    `X-API-KEY`. Si aqui pusieras "X-Api-Key" con mayusculas, la busqueda fallaria
    siempre y la API rechazaria todo con 401.

    API_PREFIX lleva la barra final para que `/apitrampa` no cuele como si fuera
    parte de la API.
    """

    APIKEY_HEADER = "x-api-key"
    HEALTH_PATH = "/health-check"
    API_PREFIX = "/api/"
