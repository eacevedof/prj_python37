from typing import final


@final
class ListLimitEnum:
    """Limites y formatos que definen que es una lista VALIDA.

    Esto es dominio puro: son las reglas del negocio, no detalles tecnicos. Que el
    nombre no pueda pasar de 80 caracteres no lo decide SQLite (que no impone
    limite), lo decides tu. Por eso vive aqui y lo aplica el service, no la base
    de datos.

    Tenerlo en un enum en vez de en linea dentro de la validacion permite que el
    mensaje de error diga el numero exacto sin repetirlo:
        f"name no puede pasar de {ListLimitEnum.NAME_MAX_LENGTH} caracteres"
    """

    NAME_MAX_LENGTH = 80
    COLOR_PATTERN = r"^#[0-9A-Fa-f]{6}$"
    COLOR_LENGTH = 7
    DEFAULT_POSITION = 0
