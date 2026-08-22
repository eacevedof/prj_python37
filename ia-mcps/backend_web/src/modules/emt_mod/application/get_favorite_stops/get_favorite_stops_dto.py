from dataclasses import dataclass
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class GetFavoriteStopsDto:
    """Entrada del listado de favoritos: quién pregunta y por quién."""

    user_tg_id: str
    password: str = ""
    target_user_tg_id: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            user_tg_id=str(primitives.get("user_tg_id", "")).strip(),
            password=str(primitives.get("password", "")),
            target_user_tg_id=str(primitives.get("target_user_tg_id", "")).strip(),
        )
