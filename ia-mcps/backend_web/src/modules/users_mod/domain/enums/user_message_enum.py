from typing import final


@final
class UserMessageEnum:
    """Mensajes que `users_mod` le devuelve al agente.

    Deliberadamente GENÉRICOS: un tg_id que no existe y uno que existe pero no
    puede se responden igual, para no convertir el error en un oráculo que
    confirme qué usuarios hay dados de alta. Aquí no se nombra ni una tabla ni
    una columna.
    """

    USER_NOT_AUTHORIZED = "usuario no autorizado"
    USER_DISABLED = "cuenta deshabilitada"
    USER_TG_ID_REQUIRED = "user_tg_id es obligatorio"
    USER_NAME_REQUIRED = "user_name es obligatorio"
    UNKNOWN_ROLE = "rol desconocido"

    PASSWORD_REQUIRED = (
        "se requiere la contraseña: han pasado más de 7 días desde la última validación"
    )
    PASSWORD_WRONG = "contraseña incorrecta"

    ADMIN_ONLY = "solo un administrador puede hacer eso"
    # Solo la ve un admin (nadie más llega a esa rama), así que aquí sí se puede
    # ser concreto sin convertir el error en un oráculo.
    TARGET_USER_NOT_FOUND = "no hay ningún usuario con ese identificador de telegram"
    USER_ALREADY_EXISTS = "ya hay un usuario con ese identificador de telegram"
