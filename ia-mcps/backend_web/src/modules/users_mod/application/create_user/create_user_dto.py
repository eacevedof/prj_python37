from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.users_mod.domain.enums.user_role_enum import UserRoleEnum


@final
@dataclass(frozen=True, slots=True)
class CreateUserDto:
    """Entrada del alta de usuario.

    `plain_password` viaja en claro SOLO hasta el service, que lo cambia por su
    hash antes de que llegue al repositorio. Vacío = usuario sin contraseña, al
    que nunca se le pedirá.
    """

    user_tg_id: str
    user_name: str
    plain_password: str = ""
    user_role_id: int = int(UserRoleEnum.USER)
    is_enabled: bool = True

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            user_tg_id=str(primitives.get("user_tg_id", "")).strip(),
            user_name=str(primitives.get("user_name", "")).strip(),
            plain_password=str(primitives.get("plain_password", "")),
            user_role_id=int(primitives.get("user_role_id", int(UserRoleEnum.USER))),
            is_enabled=bool(primitives.get("is_enabled", True)),
        )
