from dataclasses import dataclass, field
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class GetFavoriteStopsResultDto:
    """Salida del listado: SOLO las paradas del dueño resuelto.

    `favorite_stops` es una lista de dicts de primitivos (no de DTOs), y en cada
    uno no hay ni ids internos ni el id del usuario: lo que sale de aquí es lo
    que el agente puede leer en voz alta.
    """

    owner_user_tg_id: str = ""
    favorite_stops: list[dict[str, Any]] = field(default_factory=list)
    total: int = 0
    is_other_user: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        favorite_stops = primitives.get("favorite_stops", [])
        return cls(
            owner_user_tg_id=str(primitives.get("owner_user_tg_id", "")),
            favorite_stops=favorite_stops if isinstance(favorite_stops, list) else [],
            total=int(primitives.get("total", 0)),
            is_other_user=bool(primitives.get("is_other_user", False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "owner_user_tg_id": self.owner_user_tg_id,
            "favorite_stops": self.favorite_stops,
            "total": self.total,
            "is_other_user": self.is_other_user,
        }
