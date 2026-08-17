from typing import Any, Self, final

from src.modules.shared.infrastructure.repositories.abstract_sqlite_repository import AbstractSqliteRepository
from src.modules.tasks_mod.domain.enums.task_done_enum import TaskDoneEnum


@final
class TasksReaderSqliteRepository(AbstractSqliteRepository):
    """Lectura de tareas."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_by_id(self, task_id: int) -> dict[str, Any] | None:
        cursor = self._get_connection().cursor()
        cursor.execute(
            """
            SELECT id, id_list, title, description, is_done, due_date, position,
                   insert_date, update_date
            FROM app_tasks
            WHERE id = ? AND delete_date IS NULL
            LIMIT 1
            """,
            (task_id,),
        )
        row = cursor.fetchone()
        return dict(row) if row else None

    def get_filtered(self, id_list: int, is_done: int | None) -> list[dict[str, Any]]:
        """Tareas vivas, filtrando por lista y/o por estado.

        Los dos filtros son opcionales y se resuelven con el mismo truco:
        `(? = 0 OR id_list = ?)`. Cuando el filtro no viene, se pasa 0 y la primera
        mitad de la condicion es verdadera, asi que la segunda no descarta nada.

        Es una sola consulta para cuatro combinaciones de filtros. La alternativa
        -ir concatenando trozos de SQL segun los filtros que vengan- es como se
        acaba con consultas construidas a mano y, tarde o temprano, con inyeccion
        SQL.
        """
        cursor = self._get_connection().cursor()
        # -1 nunca casa con is_done (que solo es 0 o 1), asi que sirve de "sin filtro".
        is_done_filter = -1 if is_done is None else is_done
        cursor.execute(
            """
            SELECT id, id_list, title, description, is_done, due_date, position,
                   insert_date, update_date
            FROM app_tasks
            WHERE 1 = 1
              AND delete_date IS NULL
              AND (? = 0  OR id_list = ?)
              AND (? = -1 OR is_done = ?)
            ORDER BY is_done ASC, position ASC, id ASC
            """,
            (id_list, id_list, is_done_filter, is_done_filter),
        )
        return [dict(row) for row in cursor.fetchall()]

    def get_open_count_by_list(self, list_id: int) -> int:
        """Cuantas tareas vivas y sin terminar tiene una lista.

        Lo consume `TasksCounterAdapter`, que cumple el puerto que declara el
        modulo de listas.
        """
        cursor = self._get_connection().cursor()
        cursor.execute(
            """
            SELECT COUNT(*) AS open_count
            FROM app_tasks
            WHERE id_list = ?
              AND is_done = ?
              AND delete_date IS NULL
            """,
            (list_id, TaskDoneEnum.PENDING),
        )
        row = cursor.fetchone()
        return int(row["open_count"]) if row else 0
