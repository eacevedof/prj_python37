import sqlite3
from pathlib import Path

from src.modules.shared.domain.enums.sqlite_pragma_enum import SqlitePragmaEnum
from src.modules.shared.infrastructure.repositories.abstract_sqlite_repository import AbstractSqliteRepository
from src.modules.shared.infrastructure.repositories.configuration.environment_reader_raw_repository import (
    EnvironmentReaderRawRepository,
)


def get_database_path() -> Path:
    """Ruta absoluta del fichero .db, creando su carpeta si no existe.

    DB_PATH es RELATIVO a backend_web/ a proposito: el mismo `.env` vale corriendo
    en tu maquina y dentro del contenedor, donde el codigo esta en otra ruta.
    """
    # parents[3]: config -> core -> src -> backend_web
    backend_web_path = Path(__file__).resolve().parents[3]
    database_path = backend_web_path / EnvironmentReaderRawRepository.get_instance().get_db_path()
    database_path.parent.mkdir(parents=True, exist_ok=True)
    return database_path


def create_connection() -> sqlite3.Connection:
    """Abre la conexion a SQLite y la deja configurada.

    Dos decisiones que parecen detalles y no lo son:

    `check_same_thread=False`
        Sin esto la app no arranca. La conexion se CREA en un hilo (el arranque) y
        se USA en otro (uvicorn atiende las peticiones en un pool de hilos), y
        SQLite lo prohibe por defecto. No es una relajacion de seguridad: Python
        serializa los accesos a la conexion por debajo.

    `isolation_level` por defecto
        Se deja el modo clasico: los SELECT no abren transaccion y los INSERT /
        UPDATE / DELETE abren una que cierra `commit()`. Es lo que hace que
        `commit()` y `rollback()` signifiquen lo que esperas. Poner
        `isolation_level=None` (autocommit) dejaria `rollback()` sin efecto y
        romperia el migrador.
    """
    connection = sqlite3.connect(str(get_database_path()), check_same_thread=False)

    # row_factory: hace que una fila se comporte como un diccionario, de forma que
    # los repositorios puedan devolver `dict(row)` en vez de indexar por posicion.
    # Sin esto, anadir una columna a un SELECT descolocaria todos los indices.
    connection.row_factory = sqlite3.Row

    for sqlite_pragma in SqlitePragmaEnum:
        connection.execute(sqlite_pragma.value)

    return connection


def init_db() -> None:
    """Abre la conexion y la deja disponible para todos los repositorios.

    Lo llama el `lifespan` de public/main.py antes de servir la primera peticion.
    """
    AbstractSqliteRepository.set_connection(create_connection())
