from pathlib import Path
from typing import Self, final

from src.modules.devops_mod.domain.enums.migration_file_enum import MigrationFileEnum


@final
class MigrationFilesReaderFileRepository:
    """Lee los ficheros .sql del disco (datasource: file).

    El segmento `File` del nombre dice de donde saca los datos, igual que
    `Sqlite` o `Api` en otros repositorios. Un repositorio no es solo "cosas de
    base de datos": es cualquier acceso a datos de fuera de la app.

    Como todo repositorio: **sin try/except**. Si la carpeta no existe o un
    fichero no se puede leer, el error sube. Quien decide que hacer con el es el
    service (validando antes) o el runner (capturando por fichero).
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def has_path(self, path: Path) -> bool:
        return path.exists()

    def is_directory(self, path: Path) -> bool:
        return path.is_dir()

    def get_sorted_sql_files(self, migrations_path: Path) -> list[Path]:
        """Los .sql de la carpeta, en orden alfabetico.

        Alfabetico = cronologico, porque el nombre empieza por YYYYMMDDHHMMSS.
        """
        return sorted(migrations_path.glob(f"*{MigrationFileEnum.EXTENSION}"))

    def get_sql_content(self, migration_file: Path) -> str:
        return migration_file.read_text(encoding="utf-8")

    def get_version(self, file_name: str) -> str:
        """Extrae la marca de tiempo del nombre, o "" si el nombre no cumple.

        Devolver "" en vez de lanzar es lo que permite al service reportar
        "este fichero esta mal nombrado" sin abortar el resto del lote.
        """
        version = file_name[: MigrationFileEnum.VERSION_LENGTH]
        if not version.isdigit() or len(version) != MigrationFileEnum.VERSION_LENGTH:
            return ""
        return version
