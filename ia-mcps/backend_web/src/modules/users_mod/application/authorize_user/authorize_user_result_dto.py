from dataclasses import dataclass
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class AuthorizeUserResultDto:
    """Salida del guardarraíl.

    Los campos `user_*` son de QUIEN LLAMA (ya autenticado) y los `owner_*` de
    aquel cuyos datos se van a tocar: coinciden salvo que un admin haya pedido
    operar sobre otro. Aquí no viaja el hash de la contraseña ni nada que
    describa el almacenamiento.
    """

    user_id: int
    user_uuid: str
    user_tg_id: str
    user_name: str
    user_role_id: int
    is_admin: bool
    owner_user_id: int
    owner_user_tg_id: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            user_id=int(primitives.get("user_id", 0)),
            user_uuid=str(primitives.get("user_uuid", "")),
            user_tg_id=str(primitives.get("user_tg_id", "")),
            user_name=str(primitives.get("user_name", "")),
            user_role_id=int(primitives.get("user_role_id", 0)),
            is_admin=bool(primitives.get("is_admin", False)),
            owner_user_id=int(primitives.get("owner_user_id", 0)),
            owner_user_tg_id=str(primitives.get("owner_user_tg_id", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "user_id": self.user_id,
            "user_uuid": self.user_uuid,
            "user_tg_id": self.user_tg_id,
            "user_name": self.user_name,
            "user_role_id": self.user_role_id,
            "is_admin": self.is_admin,
            "owner_user_id": self.owner_user_id,
            "owner_user_tg_id": self.owner_user_tg_id,
        }
