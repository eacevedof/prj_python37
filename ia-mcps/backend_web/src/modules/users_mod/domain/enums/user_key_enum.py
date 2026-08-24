from typing import final


@final
class UserKeyEnum:
    """Vocabulario de los primitivos de `users_mod`.

    Los repositorios renombran las columnas a estas claves
    (`SELECT id AS user_id`), así que el nombre de la columna no se escapa del
    repositorio, y los casos de uso las usan para armar sus ResultDto.
    """

    USER_ID = "user_id"
    USER_UUID = "user_uuid"
    USER_TG_ID = "user_tg_id"
    USER_NAME = "user_name"
    USER_ROLE_ID = "user_role_id"
    IS_ENABLED = "is_enabled"
    IS_ADMIN = "is_admin"
    AUTHENTICATED_AT = "authenticated_at"
    CREATED_AT = "created_at"
    UPDATED_AT = "updated_at"

    # Entrada y salida de los casos de uso.
    IS_PASSWORD_CHANGED = "is_password_changed"
    PASSWORD = "password"
    TARGET_USER_TG_ID = "target_user_tg_id"

    # Sobre QUIÉN se opera: coincide con el autenticado salvo que un admin haya
    # pasado `target_user_tg_id`.
    OWNER_USER_ID = "owner_user_id"
    OWNER_USER_TG_ID = "owner_user_tg_id"

    # Listado (solo admin).
    USERS = "users"
    TOTAL = "total"

    # ⚠️ Estas dos NUNCA salen del módulo: solo circulan entre el repositorio de
    # lectura y `AuthenticateUserService`, dentro del módulo. Ningún ResultDto
    # las lleva, y por eso el hash de la contraseña no puede acabar en un texto
    # para el agente.
    USER_PWD = "user_pwd"
    IS_PASSWORD_FRESH = "is_password_fresh"
