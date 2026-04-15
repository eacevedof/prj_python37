from dataclasses import dataclass, field
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class MigrationResultDto:
    """Resultado de una migración individual."""

    filename: str
    version: str
    status: str  # "applied", "skipped", "failed"
    error: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            filename=str(primitives.get("filename", "")),
            version=str(primitives.get("version", "")),
            status=str(primitives.get("status", "failed")),
            error=primitives.get("error"),
        )


@dataclass(frozen=True, slots=True)
class RunMigrationsResultDto:
    """DTO de resultado del servicio de migraciones."""

    total_migrations: int
    applied_count: int
    skipped_count: int
    failed_count: int
    migrations: tuple[MigrationResultDto, ...] = field(default_factory=tuple)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        migrations_data = primitives.get("migrations", [])
        migrations = tuple(
            MigrationResultDto.from_primitives(m) if isinstance(m, dict) else m
            for m in migrations_data
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
