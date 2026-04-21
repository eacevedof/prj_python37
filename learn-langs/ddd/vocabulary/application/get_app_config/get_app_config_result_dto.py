"""Output DTO con la configuracion de la aplicacion."""

from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetAppConfigResultDto:
    """DTO con toda la configuracion de la aplicacion."""

    # UI
    app_title: str
    window_width: int
    window_height: int
    window_min_width: int
    window_min_height: int

    # Database
    migrations_path: str
    db_path: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            app_title=str(primitives.get("app_title", "Learn Languages")),
            window_width=int(primitives.get("window_width", 900)),
            window_height=int(primitives.get("window_height", 700)),
            window_min_width=int(primitives.get("window_min_width", 600)),
            window_min_height=int(primitives.get("window_min_height", 500)),
            migrations_path=str(primitives.get("migrations_path", "")),
            db_path=str(primitives.get("db_path", "")),
        )
