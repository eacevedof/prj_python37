import re
from pathlib import Path
from typing import Self, final

from ddd.devops.domain.enums.migration_file_enum import MigrationFileEnum


@final
class MigrationFilesReaderFileRepository:
    """Lectura de los archivos de migración .sql del disco (datasource: file)."""

    _TIMESTAMP_PATTERN = re.compile(MigrationFileEnum.TIMESTAMP_REGEX)

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def path_exists(self, path: Path) -> bool:
        return path.exists()

    def is_directory(self, path: Path) -> bool:
        return path.is_dir()

    def get_sorted_sql_files(self, migrations_path: Path) -> list[Path]:
        sql_files = list(migrations_path.glob(MigrationFileEnum.SQL_GLOB))
        return sorted(sql_files, key=lambda sql_file: self.extract_version(sql_file.name))

    def extract_version(self, file_name: str) -> str:
        match = self._TIMESTAMP_PATTERN.match(file_name)
        return match.group(1) if match else ""

    def get_sql_content(self, migration_file: Path) -> str:
        return migration_file.read_text(encoding="utf-8")
