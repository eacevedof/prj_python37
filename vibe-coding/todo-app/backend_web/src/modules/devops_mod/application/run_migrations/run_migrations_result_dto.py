from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.devops_mod.domain.enums.migration_result_enum import MigrationResultEnum


@final
@dataclass(frozen=True, slots=True)
class RunMigrationsResultDto:
    """Salida del caso de uso RunMigrations.

    Todo caso de uso devuelve un ResultDto, nunca un diccionario suelto ni una
    fila de base de datos. Asi el contrato de salida esta escrito en un sitio y se
    puede cambiar la consulta de dentro sin romper a quien lo consume.

    Ademas del `from_primitives` que tienen todos los DTO, los de resultado llevan
    `to_dict()`: es lo que el controller mete en la clave `data` de la respuesta.
    """

    total_migrations: int
    applied_count: int
    skipped_count: int
    failed_count: int
    migrations: list[dict[str, str]]

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            total_migrations=int(primitives.get(MigrationResultEnum.TOTAL_MIGRATIONS, 0)),
            applied_count=int(primitives.get(MigrationResultEnum.APPLIED_COUNT, 0)),
            skipped_count=int(primitives.get(MigrationResultEnum.SKIPPED_COUNT, 0)),
            failed_count=int(primitives.get(MigrationResultEnum.FAILED_COUNT, 0)),
            migrations=list(primitives.get(MigrationResultEnum.MIGRATIONS, [])),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            MigrationResultEnum.TOTAL_MIGRATIONS: self.total_migrations,
            MigrationResultEnum.APPLIED_COUNT: self.applied_count,
            MigrationResultEnum.SKIPPED_COUNT: self.skipped_count,
            MigrationResultEnum.FAILED_COUNT: self.failed_count,
            MigrationResultEnum.MIGRATIONS: self.migrations,
        }

    def has_failures(self) -> bool:
        return self.failed_count > 0
