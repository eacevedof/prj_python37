from dataclasses import dataclass
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class DeleteFavoriteStopDto:
    """Entrada del borrado: qué parada se saca de favoritos y de quién."""

    user_tg_id: str
    stop_nr: str
    password: str = ""
    target_user_tg_id: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            user_tg_id=str(primitives.get("user_tg_id", "")).strip(),
            stop_nr=str(primitives.get("stop_nr", "")).strip(),
            password=str(primitives.get("password", "")),
            target_user_tg_id=str(primitives.get("target_user_tg_id", "")).strip(),
        )
