from dataclasses import dataclass
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class UpdateUserDto:
    """Entrada de la edición de un usuario. Actualización PARCIAL.

    `None` significa "no lo toques", y por eso los campos son opcionales en vez
    de llevar un centinela raro: el que no llega, no se escribe.

    `plain_password` tiene tres estados, que es justo lo que hace falta:

    - `None`  -> la contraseña se queda como está,
    - `""`    -> se le QUITA la contraseña (entrará solo con su id de telegram),
    - `"..."` -> se le pone esa, y se le obliga a validarla en la próxima llamada.
    """

    user_tg_id: str
    user_name: str | None = None
    user_role_id: int | None = None
    is_enabled: bool | None = None
    plain_password: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        user_name = primitives.get("user_name")
        user_role_id = primitives.get("user_role_id")
        is_enabled = primitives.get("is_enabled")
        plain_password = primitives.get("plain_password")

        return cls(
            user_tg_id=str(primitives.get("user_tg_id", "")).strip(),
            user_name=None if user_name is None else str(user_name).strip(),
            user_role_id=None if user_role_id is None else int(user_role_id),
            is_enabled=None if is_enabled is None else bool(is_enabled),
            plain_password=None if plain_password is None else str(plain_password),
        )
