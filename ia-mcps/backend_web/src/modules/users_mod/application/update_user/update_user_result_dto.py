from dataclasses import dataclass
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class UpdateUserResultDto:
    """Salida de la edición: cómo queda el usuario.

    `is_password_changed` dice si se tocó la contraseña, pero NO cuál es ni si
    ahora tiene o no: el hash no sale del módulo.
    """

    user_id: int
    user_uuid: str
    user_tg_id: str
    user_name: str
    user_role_id: int
    is_enabled: bool
    is_password_changed: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            user_id=int(primitives.get("user_id", 0)),
            user_uuid=str(primitives.get("user_uuid", "")),
            user_tg_id=str(primitives.get("user_tg_id", "")),
            user_name=str(primitives.get("user_name", "")),
            user_role_id=int(primitives.get("user_role_id", 0)),
            is_enabled=bool(primitives.get("is_enabled", True)),
            is_password_changed=bool(primitives.get("is_password_changed", False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "user_id": self.user_id,
            "user_uuid": self.user_uuid,
            "user_tg_id": self.user_tg_id,
            "user_name": self.user_name,
            "user_role_id": self.user_role_id,
            "is_enabled": self.is_enabled,
            "is_password_changed": self.is_password_changed,
        }
