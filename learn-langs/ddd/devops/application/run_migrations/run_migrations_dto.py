from dataclasses import dataclass
from pathlib import Path
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class RunMigrationsDto:
    """DTO de entrada para el servicio de migraciones."""

    migrations_path: Path
    db_path: Path | None = None
    force: bool = False  # True = drop + create + all migrations

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

        return cls(
            migrations_path=migrations_path,
            db_path=db_path,
            force=bool(primitives.get("force", False)),
        )

    def validate(self) -> list[str]:
        """Valida el DTO y retorna lista de errores."""
        errors: list[str] = []

        if not self.migrations_path.exists():
            errors.append(f"Migrations path does not exist: {self.migrations_path}")
        elif not self.migrations_path.is_dir():
            errors.append(f"Migrations path is not a directory: {self.migrations_path}")

        if self.db_path and not self.db_path.parent.exists():
            errors.append(f"Database directory does not exist: {self.db_path.parent}")

        return errors
