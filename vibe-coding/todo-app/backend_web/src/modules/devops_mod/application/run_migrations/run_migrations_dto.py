from dataclasses import dataclass
from pathlib import Path
from typing import Any, Self, final

from src.modules.devops_mod.domain.enums.migration_result_enum import MigrationResultEnum


@final
@dataclass(frozen=True, slots=True)
class RunMigrationsDto:
    """Entrada del caso de uso RunMigrations.

    Un DTO de entrada es una foto inmutable de lo que pidio el cliente:

      frozen=True  -> no se puede modificar despues de crearlo. Nadie puede
                      cambiarte los datos a medio caso de uso.
      slots=True   -> no se le pueden anadir campos sobre la marcha; un typo al
                      asignar (`dto.pathh = ...`) revienta en vez de crear un
                      campo nuevo en silencio.

    `from_primitives` es el UNICO constructor. Recibe el diccionario tal cual llega
    de fuera y hace la conversion de tipos. Ese es su trabajo: convertir, no
    validar. La validacion es del service (`_fail_if_wrong_input`), porque validar
    es una decision de negocio y un DTO no toma decisiones.
    """

    migrations_path: Path

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(migrations_path=Path(primitives[MigrationResultEnum.MIGRATIONS_PATH]))
