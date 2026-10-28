from typing import Any, Self, final

from src.modules.shared.infrastructure.repositories.abstract_sqlite_repository import AbstractSqliteRepository


@final
class ListsReaderSqliteRepository(AbstractSqliteRepository):
    """Lectura de listas.

    REGLAS DE UN REPOSITORIO, que se cumplen todas aqui:

    1. **Cero try/except.** Si la consulta falla, el error sube. Un repositorio que
       captura y devuelve None convierte un fallo de infraestructura en "no hay
       datos", que es la peor forma de enterarse de un problema.
    2. **Cero reglas de negocio.** Aqui no se decide si algo es valido: se lee y
       se devuelve. Decidir es del service.
    3. **Devuelve primitivos** (dict, list, int, bool), nunca objetos de dominio ni
       filas de SQLite. Asi el service no se acopla al driver.
    4. **Siempre `?` para los parametros**, nunca interpolacion de cadenas. Meter
       un valor con f-string en un SQL es como se crea una inyeccion SQL.
    5. **Todas las consultas filtran `delete_date IS NULL`**, porque el borrado es
       logico: sin ese filtro verias las listas borradas.
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_by_id(self, list_id: int) -> dict[str, Any] | None:
        cursor = self._get_connection().cursor()
        cursor.execute(
            """
            SELECT id, name, color, position, insert_date, update_date
            FROM app_lists
            WHERE id = ? AND delete_date IS NULL
            LIMIT 1
            """,
            (list_id,),
        )
        row = cursor.fetchone()
        return dict(row) if row else None

    def get_all(self, name_contains: str) -> list[dict[str, Any]]:
        """Todas las listas vivas, opcionalmente filtradas por nombre.

        El truco del `WHERE 1 = 1`: permite anadir condiciones con `AND ...` sin
        tener que averiguar cual es la primera. Es un patron habitual cuando el
        filtro es opcional.

        Cuando `name_contains` viene vacio, el parametro es "%%", que casa con
        todo: una sola consulta sirve para los dos casos.
        """
        cursor = self._get_connection().cursor()
        cursor.execute(
            """
            SELECT id, name, color, position, insert_date, update_date
            FROM app_lists
            WHERE 1 = 1
              AND delete_date IS NULL
              AND lower(name) LIKE lower(?)
            ORDER BY position ASC, id ASC
            """,
            (f"%{name_contains}%",),
        )
        return [dict(row) for row in cursor.fetchall()]

    def has_name_taken(self, name: str, excluded_list_id: int) -> bool:
        """¿Hay ya otra lista viva con ese nombre?

        `excluded_list_id` sirve para el caso de editar: al renombrar la lista 3 a
        "Compra", no debe chocar consigo misma. Al crear se pasa 0, que no casa con
        ningun id.
        """
        cursor = self._get_connection().cursor()
        cursor.execute(
            """
            SELECT id
            FROM app_lists
            WHERE lower(name) = lower(?)
              AND id != ?
              AND delete_date IS NULL
            LIMIT 1
            """,
            (name, excluded_list_id),
        )
        return cursor.fetchone() is not None
