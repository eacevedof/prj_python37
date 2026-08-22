from dataclasses import dataclass
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class DeleteFavoriteStopResultDto:
    """Salida del borrado: qué parada se ha quitado y de qué lista."""

    stop_nr: str
    owner_user_tg_id: str
    is_other_user: bool = False

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            stop_nr=str(primitives.get("stop_nr", "")),
            owner_user_tg_id=str(primitives.get("owner_user_tg_id", "")),
            is_other_user=bool(primitives.get("is_other_user", False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "stop_nr": self.stop_nr,
            "owner_user_tg_id": self.owner_user_tg_id,
            "is_other_user": self.is_other_user,
        }
