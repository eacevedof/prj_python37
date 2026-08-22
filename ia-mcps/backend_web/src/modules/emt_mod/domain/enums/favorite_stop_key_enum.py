from typing import final


@final
class FavoriteStopKeyEnum:
    """Claves de los primitivos de las paradas favoritas.

    Contrato que cruza el puerto `FavoriteStopsPort` hacia `emt_mcp` (y, en la
    entrada, las claves que publica el `inputSchema` de cada tool). Se escriben
    una sola vez y a los dos lados se leen de aquí.
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
