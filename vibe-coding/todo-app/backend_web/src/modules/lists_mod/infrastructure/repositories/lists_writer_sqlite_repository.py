from typing import Self, final

from src.modules.shared.infrastructure.repositories.abstract_sqlite_repository import AbstractSqliteRepository


@final
class ListsWriterSqliteRepository(AbstractSqliteRepository):
    """Escritura de listas.

    Lectura y escritura van en clases SEPARADAS (Reader / Writer). No es
    ceremonia: al abrir un fichero sabes de entrada si lo que estas mirando puede
    modificar datos, y es trivial ver quien escribe en una tabla.

    El `commit()` lo hace este repositorio, no el service: el service no deberia
    saber que existe el concepto de transaccion de una base de datos.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def create(self, name: str, color: str | None, position: int) -> int:
        """Inserta y devuelve el id nuevo.

        `cursor.lastrowid` es el id que SQLite acaba de asignar. Se usa esto en
        vez de `RETURNING id` porque funciona en cualquier version de SQLite,
        incluida la que traiga el Python del contenedor.
        """
        connection = self._get_connection()
        cursor = connection.cursor()
        cursor.execute(
            """
            INSERT INTO app_lists (name, color, position)
            VALUES (?, ?, ?)
            """,
            (name, color, position),
        )
        new_list_id = int(cursor.lastrowid or 0)
        connection.commit()
        return new_list_id

    def update(self, list_id: int, name: str, color: str | None, position: int) -> bool:
        """Devuelve True si modifico alguna fila.

        `rowcount` a 0 significa que la lista no existe o ya estaba borrada. El
        service lo traduce a un 404.
        """
        connection = self._get_connection()
        cursor = connection.cursor()
        cursor.execute(
            """
            UPDATE app_lists
            SET name = ?, color = ?, position = ?, update_date = CURRENT_TIMESTAMP
            WHERE id = ? AND delete_date IS NULL
            """,
            (name, color, position, list_id),
        )
        connection.commit()
        return cursor.rowcount > 0

    def soft_delete(self, list_id: int) -> bool:
        """Borrado LOGICO: marca la fecha, no elimina la fila.

        La fila sigue en la tabla, asi que las tareas que la referencian no se
        quedan apuntando al vacio y la clave ajena no se rompe. Para la aplicacion,
        una lista con `delete_date` no existe.
        """
        connection = self._get_connection()
        cursor = connection.cursor()
        cursor.execute(
            """
            UPDATE app_lists
            SET delete_date = CURRENT_TIMESTAMP
            WHERE id = ? AND delete_date IS NULL
            """,
            (list_id,),
        )
        connection.commit()
        return cursor.rowcount > 0
