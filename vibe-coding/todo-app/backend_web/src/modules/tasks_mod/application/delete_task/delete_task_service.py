from typing import Self, final

from src.modules.tasks_mod.application.delete_task.delete_task_dto import DeleteTaskDto
from src.modules.tasks_mod.application.delete_task.delete_task_result_dto import DeleteTaskResultDto
from src.modules.tasks_mod.domain.enums.task_field_enum import TaskFieldEnum
from src.modules.tasks_mod.domain.exceptions.tasks_exception import TasksException
from src.modules.tasks_mod.infrastructure.repositories.tasks_writer_sqlite_repository import (
    TasksWriterSqliteRepository,
)


@final
class DeleteTaskService:
    """Caso de uso: borrar una tarea (borrado logico).

    A diferencia de borrar una lista, aqui no hay nada que comprobar: una tarea no
    tiene dependencias colgando. Por eso este service es el mas corto del proyecto,
    y aun asi tiene exactamente la misma forma que los demas.
    """

    _delete_task_dto: DeleteTaskDto
    _tasks_writer_sqlite_repository: TasksWriterSqliteRepository

    def __init__(self) -> None:
        self._tasks_writer_sqlite_repository = TasksWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, delete_task_dto: DeleteTaskDto) -> DeleteTaskResultDto:
        """Ejecuta el caso de uso.

        Returns:
            DeleteTaskResultDto: el id borrado.

        Raises:
            TasksException: 400 si falta el id, 404 si la tarea no existe.
        """
        self._delete_task_dto = delete_task_dto
        self._fail_if_wrong_input()

        is_deleted = self._tasks_writer_sqlite_repository.soft_delete(self._delete_task_dto.task_id)
        if not is_deleted:
            TasksException.not_found_custom(f"no existe la tarea {self._delete_task_dto.task_id}")

        return DeleteTaskResultDto.from_primitives(
            {
                TaskFieldEnum.TASK_ID: self._delete_task_dto.task_id,
                TaskFieldEnum.IS_DELETED: True,
            }
        )

    def _fail_if_wrong_input(self) -> None:
        if self._delete_task_dto.task_id <= 0:
            TasksException.bad_request_custom("task_id tiene que ser un entero positivo")
