"""Configuracion compartida de los tests.

LA DECISION IMPORTANTE DE ESTE FICHERO: los tests usan una base de datos SQLite
DE VERDAD, en memoria, sobre la que se aplican las migraciones reales.

Es tentador escribir un "doble" de la base de datos que devuelva datos falsos. No
se hace, por tres razones:

  1. SQLite en memoria arranca en milisegundos y no deja rastro. La razon habitual
     para falsear una base de datos -que es lenta o hay que instalarla- aqui no
     existe.
  2. Un doble solo sabe responder a lo que has previsto. Si tu SQL tiene un error
     de sintaxis, el doble no se entera y el test pasa igual. Con SQLite de verdad,
     un SQL malo revienta en el test, que es donde quieres enterarte.
  3. Las migraciones se ejecutan de verdad, asi que tambien se prueban ellas.

La conexion se inyecta por `AbstractSqliteRepository.set_connection()`, que es
EXACTAMENTE la misma puerta que usa la aplicacion al arrancar. Probar por una
puerta distinta de la que usa produccion es probar otra cosa.
"""

import sqlite3
import sys
from pathlib import Path
from typing import Iterator

import pytest
from fastapi.testclient import TestClient

# backend_web/ al path: permite `from src...` y `from public...` igual que en
# produccion, donde uvicorn se lanza desde esa carpeta.
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from public.main import app  # noqa: E402
from src.modules.shared.domain.enums.sqlite_pragma_enum import SqlitePragmaEnum  # noqa: E402
from src.modules.shared.infrastructure.repositories.abstract_sqlite_repository import (  # noqa: E402
    AbstractSqliteRepository,
)


def _get_migrations_path() -> Path:
    return Path(__file__).resolve().parents[1] / "database" / "migrations"


@pytest.fixture()
def sqlite_connection() -> Iterator[sqlite3.Connection]:
    """Una base de datos limpia por test, con las migraciones ya aplicadas.

    Se crea y se destruye en cada test: ningun test puede depender de lo que dejo
    otro, ni romperse por su culpa. Es lo que permite lanzarlos en cualquier orden.
    """
    connection = sqlite3.connect(":memory:", check_same_thread=False)
    connection.row_factory = sqlite3.Row
    for sqlite_pragma in SqlitePragmaEnum:
        # journal_mode = WAL no aplica a una base en memoria; SQLite lo ignora sin
        # quejarse, asi que se emiten todos igual y no hay que mantener dos listas.
        connection.execute(sqlite_pragma.value)

    for migration_file in sorted(_get_migrations_path().glob("*.sql")):
        connection.executescript(migration_file.read_text(encoding="utf-8"))
    connection.commit()

    AbstractSqliteRepository.set_connection(connection)
    yield connection
    connection.close()


@pytest.fixture()
def _app_environment(
    sqlite_connection: sqlite3.Connection, monkeypatch: pytest.MonkeyPatch
) -> Iterator[None]:
    """Deja la app lista para recibir peticiones en un test.

    Hace dos cosas:

    1. **Fija la apikey** con monkeypatch en vez de leer el `.env` de la maquina.
       Un test no puede depender de como tenga cada uno su configuracion, ni
       fallar en el portatil de otra persona por eso.

    2. **Anula `init_db`**. Al entrar en el contexto de TestClient se ejecuta el
       `lifespan` real, que abriria la base de datos EN FICHERO y pisaria la que
       este fichero acaba de crear en memoria. Se anula solo esa funcion.

       Fijate en que `_run_migrations` NO se anula: se deja correr contra la base
       en memoria, donde encuentra las migraciones ya aplicadas y las salta. Asi
       cada test comprueba de propina que el migrador es idempotente.

       Se parchea `public.main.init_db` y no `src.core.config.database.init_db`
       porque main.py la importo a su propio espacio de nombres: parchear el
       original no cambiaria la referencia que main ya tiene.
    """
    monkeypatch.setenv("API_KEY", "test-api-key")
    monkeypatch.setattr("public.main.init_db", lambda: None)
    yield


@pytest.fixture()
def client(_app_environment: None) -> Iterator[TestClient]:
    """Cliente HTTP con la credencial puesta.

    `raise_server_exceptions=False` hace que un fallo no capturado se convierta en
    un 500 de verdad, como en produccion, en vez de propagarse al test. Asi se
    puede comprobar que el `except Exception` del controller hace su trabajo.
    """
    with TestClient(app, headers={"X-Api-Key": "test-api-key"}, raise_server_exceptions=False) as test_client:
        yield test_client


@pytest.fixture()
def anonymous_client(_app_environment: None) -> Iterator[TestClient]:
    """Cliente SIN credencial, para probar el borde de autenticacion."""
    with TestClient(app, raise_server_exceptions=False) as test_client:
        yield test_client
