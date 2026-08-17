import sqlite3


class AbstractSqliteRepository:
    """Base de todos los repositorios que hablan con SQLite.

    Su unico trabajo es guardar la conexion en un sitio al que lleguen todos los
    repositorios. La conexion la crea `src/core/config/database.py` y la inyecta
    aqui una sola vez, al arrancar la app.

    **Esta clase no sabe crear conexiones**, y es a proposito: asi los tests
    inyectan una base de datos en memoria por esta MISMA puerta que usa
    produccion. Si el kernel de tests entrase por otro sitio, estarias probando un
    camino que nadie ejecuta de verdad.

    La conexion es un atributo de CLASE (`_connection`), no de instancia: cada
    repositorio se construye con `get_instance()` una y otra vez, pero todos
    comparten la misma conexion, que es lo que quieres con SQLite.
    """

    _connection: sqlite3.Connection | None = None

    @classmethod
    def _get_connection(cls) -> sqlite3.Connection:
        if cls._connection is None:
            raise RuntimeError(
                "No hay conexion SQLite. Se abre en el arranque (init_db) y en los tests"
                " la inyecta conftest.py. Si ves esto, algo llamo a un repositorio antes"
                " de tiempo."
            )
        return cls._connection

    @classmethod
    def set_connection(cls, connection: sqlite3.Connection) -> None:
        # Se asigna sobre AbstractSqliteRepository (la clase base), asi que la ven
        # todas las subclases. Lo llaman init_db() en produccion y conftest.py en
        # los tests.
        AbstractSqliteRepository._connection = connection
