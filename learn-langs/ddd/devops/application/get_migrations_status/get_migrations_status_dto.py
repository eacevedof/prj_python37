from dataclasses import dataclass
from pathlib import Path
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class GetMigrationsStatusDto:
    """DTO de entrada para consultar el estado de las migraciones."""

    migrations_path: Path
    db_path: Path | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        migrations_path = primitives.get("migrations_path")
        if isinstance(migrations_path, str):
            migrations_path = Path(migrations_path)
        elif migrations_path is None:
            migrations_path = Path(".")

        db_path = primitives.get("db_path")
        if isinstance(db_path, str):
            db_path = Path(db_path)

        return cls(migrations_path=migrations_path, db_path=db_path)
