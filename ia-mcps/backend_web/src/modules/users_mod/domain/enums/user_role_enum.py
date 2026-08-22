from enum import IntEnum
from typing import final


@final
class UserRoleEnum(IntEnum):
    """Rol de un usuario de los servidores MCP.

    ADMIN tiene vía libre sobre los datos de cualquiera; USER solo ve y toca lo
    suyo. El valor es el que se guarda en `user_role_id`.
    """

    ADMIN = 1
    USER = 2
