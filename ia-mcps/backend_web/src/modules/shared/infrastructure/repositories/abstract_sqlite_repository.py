import sqlite3
from abc import ABC, abstractmethod
from pathlib import Path
from typing import final

from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)

# Espera de bloqueo antes de rendirse: SQLite serializa las escrituras y aquí
# hay un único proceso, así que con cinco segundos sobra de largo.
_LOCK_TIMEOUT_SECONDS = 5.0


class AbstractSqliteRepository(ABC):
    """Base de los repositorios SQLite, uno por cada par reader/writer.

    Centraliza lo que es idéntico en todos —resolver el fichero de la base de
    datos y abrir la conexión ya configurada— para que cada concreto solo aporte
    su esquema y sus consultas.

    El esquema se asegura en cada conexión (`CREATE TABLE IF NOT EXISTS`): para
    tablas de este tamaño sale más barato que orquestar migraciones, con la
    contrapartida de que **solo sirve para crear**, no para alterar una tabla que
    ya tenga filas.

    La ruta se resuelve **en cada llamada**, no en el `__init__`: así un cambio
    de `SQLITE_DB_PATH` (los tests lo mueven a un temporal) surte efecto sin
    depender de cuándo se construyó el repositorio.
    """

    _environment_reader_raw_repository: EnvironmentReaderRawRepository

    def __init__(self) -> None:
        self._environment_reader_raw_repository = EnvironmentReaderRawRepository.get_instance()

    @abstractmethod
    def get_schema_statements(self) -> list[str]:
        """DDL de las tablas que usa el repositorio (idempotente)."""

    def _get_connection(self) -> sqlite3.Connection:
        database_path = Path(self._get_database_path())
        database_path.parent.mkdir(parents=True, exist_ok=True)

        connection = sqlite3.connect(database_path, timeout=_LOCK_TIMEOUT_SECONDS)
        connection.row_factory = sqlite3.Row
        for schema_statement in self.get_schema_statements():
            connection.execute(schema_statement)
        return connection

    @final
    def _get_database_path(self) -> str:
        # .../backend_web/src/modules/shared/infrastructure/repositories/x.py
        #      parents[5] = backend_web
        #
        # `storage/sqlite` es una carpeta de DATOS: no cuelga de `storage/cache` a
        # propósito, porque una carpeta que se llama cache invita a borrarla y aquí
        # no hay nada que se pueda regenerar.
        default_path = str(
            Path(__file__).resolve().parents[5] / "storage" / "sqlite" / "db_ia_mcps.sqlite"
        )
        return self._environment_reader_raw_repository.get_sqlite_db_path(default_path)
