from typing import final


@final
class BooleanInputEnum:
    """Que cadenas cuentan como "verdadero" cuando llegan de fuera.

    Un `.env` no tiene tipos: `APP_DEBUG=1` es la cadena "1", y `bool("0")` es
    True (toda cadena no vacia lo es). Sin esta lista, `APP_DEBUG=0` activaria el
    modo debug — un fallo silencioso de los que cuesta ver.

    Vive en un enum y no en linea porque el mismo criterio hace falta en cualquier
    sitio que reciba un booleano desde el exterior: el `.env`, una query string
    (`?is_done=1`) o un cuerpo JSON mal tipado.
    """

    TRUTHY_VALUES = ("1", "true", "True", "yes", "on")
