from typing import final


@final
class FavoriteStopKeyEnum:
    """Claves de los primitivos de las paradas favoritas.

    Las claves del `to_dict()` y las que publica el `inputSchema` de cada tool.
    La fachada las sigue necesitando para las paradas de un listado, que viajan
    como dicts dentro del ResultDto (regla de DTOs planos).
    """

    # entrada
    USER_TG_ID = "user_tg_id"
    PASSWORD = "password"
    TARGET_USER_TG_ID = "target_user_tg_id"
    STOP_NR = "stop_nr"
    STOP_DESCRIPTION = "stop_description"

    # salida
    FAVORITE_STOPS = "favorite_stops"
    TOTAL = "total"
    OWNER_USER_TG_ID = "owner_user_tg_id"
    IS_OTHER_USER = "is_other_user"
    CREATED_AT = "created_at"
    UPDATED_AT = "updated_at"
