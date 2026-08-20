from typing import final


@final
class AsgiKeyEnum:
    """Claves del scope/mensajes ASGI que lee el front-controller.

    El borde de auth de /mcp/* trabaja con el scope pelado (no hay `Request` de
    Starlette ahí), así que estas claves se escriben una sola vez.
    """

    HEADERS = "headers"
    TYPE = "type"
    BODY = "body"
    MORE_BODY = "more_body"
    HTTP_REQUEST = "http.request"
    HTTP_DISCONNECT = "http.disconnect"
