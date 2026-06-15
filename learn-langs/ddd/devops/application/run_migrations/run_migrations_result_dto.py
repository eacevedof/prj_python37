from dataclasses import dataclass, field
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class RunMigrationsResultDto:
    """DTO de resultado del servicio de migraciones.

    Cada entrada de `migrations` es un dict de strings:
    {"filename", "version", "status", "error"}.
    """

    total_migrations: int
    applied_count: int
    skipped_count: int
    failed_count: int
    migrations: tuple[dict[str, str], ...] = field(default_factory=tuple)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        migrations = tuple(
            dict(migration) for migration in primitives.get("migrations", [])
        )

        return cls(
            total_migrations=int(primitives.get("total_migrations", 0)),
            applied_count=int(primitives.get("applied_count", 0)),
            skipped_count=int(primitives.get("skipped_count", 0)),
            failed_count=int(primitives.get("failed_count", 0)),
            migrations=migrations,
        )

    @property
    def success(self) -> bool:
        """Retorna True si no hubo errores."""
        return self.failed_count == 0
