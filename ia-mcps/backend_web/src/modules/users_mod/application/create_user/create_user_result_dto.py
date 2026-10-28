from dataclasses import dataclass
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class CreateUserResultDto:
    """Salida del alta: el usuario creado, sin rastro de la contraseña."""

    user_id: int
    user_uuid: str
    user_tg_id: str
    user_name: str
    user_role_id: int
    is_enabled: bool

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            user_id=int(primitives.get("user_id", 0)),
            user_uuid=str(primitives.get("user_uuid", "")),
            user_tg_id=str(primitives.get("user_tg_id", "")),
            user_name=str(primitives.get("user_name", "")),
            user_role_id=int(primitives.get("user_role_id", 0)),
            is_enabled=bool(primitives.get("is_enabled", True)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "user_id": self.user_id,
            "user_uuid": self.user_uuid,
            "user_tg_id": self.user_tg_id,
            "user_name": self.user_name,
            "user_role_id": self.user_role_id,
            "is_enabled": self.is_enabled,
        }
