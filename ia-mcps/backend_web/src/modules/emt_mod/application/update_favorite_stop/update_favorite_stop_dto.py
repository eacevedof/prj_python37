from dataclasses import dataclass
from typing import Any, Self, final


@final
@dataclass(frozen=True, slots=True)
class UpdateFavoriteStopDto:
    """Entrada de la edición: qué parada y con qué descripción se queda."""

    user_tg_id: str
    stop_nr: str
    stop_description: str = ""
    password: str = ""
    target_user_tg_id: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            user_tg_id=str(primitives.get("user_tg_id", "")).strip(),
            stop_nr=str(primitives.get("stop_nr", "")).strip(),
            stop_description=str(primitives.get("stop_description", "")).strip(),
            password=str(primitives.get("password", "")),
            target_user_tg_id=str(primitives.get("target_user_tg_id", "")).strip(),
        )
