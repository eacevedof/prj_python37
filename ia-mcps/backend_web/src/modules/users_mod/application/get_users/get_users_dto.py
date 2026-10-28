from dataclasses import dataclass
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class GetUsersDto:
    """Entrada del listado de usuarios: quién lo pide (y su contraseña si toca)."""

    user_tg_id: str
    password: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            user_tg_id=str(primitives.get("user_tg_id", "")).strip(),
            password=str(primitives.get("password", "")),
        )
