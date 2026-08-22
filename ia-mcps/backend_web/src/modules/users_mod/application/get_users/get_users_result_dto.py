from dataclasses import dataclass, field
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class GetUsersResultDto:
    """Salida del listado: los usuarios dados de alta, sin su contraseña.

    `users` es una lista de dicts de primitivos (no de DTOs) por la regla de
    DTOs planos.
    """

    users: list[dict[str, Any]] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        users = primitives.get("users", [])
        return cls(
            users=users if isinstance(users, list) else [],
            total=int(primitives.get("total", 0)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {"users": self.users, "total": self.total}
