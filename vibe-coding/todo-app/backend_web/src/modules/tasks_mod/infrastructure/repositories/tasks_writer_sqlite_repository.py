from typing import Self, final

from src.modules.shared.infrastructure.repositories.abstract_sqlite_repository import AbstractSqliteRepository


@final
class TasksWriterSqliteRepository(AbstractSqliteRepository):
    """Escritura de tareas."""

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def create(
        self,
        id_list: int,
        title: str,
        description: str | None,
        due_date: str | None,
        position: int,
    ) -> int:
        connection = self._get_connection()
        cursor = connection.cursor()
        cursor.execute(
            """
            INSERT INTO app_tasks (id_list, title, description, due_date, position)
            VALUES (?, ?, ?, ?, ?)
            """,
            (id_list, title, description, due_date, position),
        )
        new_task_id = int(cursor.lastrowid or 0)
        connection.commit()
        return new_task_id

    def update(
        self,
        task_id: int,
        id_list: int,
        title: str,
        description: str | None,
        due_date: str | None,
        position: int,
    ) -> bool:
        connection = self._get_connection()
        cursor = connection.cursor()
        cursor.execute(
            """
            UPDATE app_tasks
            SET id_list = ?, title = ?, description = ?, due_date = ?, position = ?,
                update_date = CURRENT_TIMESTAMP
            WHERE id = ? AND delete_date IS NULL
            """,
            (id_list, title, description, due_date, position, task_id),
        )
        connection.commit()
        return cursor.rowcount > 0

    def set_done(self, task_id: int, is_done: int) -> bool:
        """Marca la tarea como hecha o pendiente.

        Recibe el estado que debe quedar, no "lo contrario de lo que hay". Por eso
        el endpoint es idempotente: llamarlo dos veces con `is_done=true` deja la
        tarea hecha, no la devuelve a pendiente. Un interruptor que alterna se
        vuelve impredecible en cuanto dos pestanas del navegador lo pulsan a la vez.
        """
        connection = self._get_connection()
        cursor = connection.cursor()
        cursor.execute(
            """
            UPDATE app_tasks
            SET is_done = ?, update_date = CURRENT_TIMESTAMP
            WHERE id = ? AND delete_date IS NULL
            """,
            (is_done, task_id),
        )
        connection.commit()
        return cursor.rowcount > 0

    def soft_delete(self, task_id: int) -> bool:
        connection = self._get_connection()
        cursor = connection.cursor()
        cursor.execute(
            """
            UPDATE app_tasks
            SET delete_date = CURRENT_TIMESTAMP
            WHERE id = ? AND delete_date IS NULL
            """,
            (task_id,),
        )
        connection.commit()
        return cursor.rowcount > 0
