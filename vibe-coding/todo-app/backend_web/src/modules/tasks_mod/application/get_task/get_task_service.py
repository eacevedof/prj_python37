from typing import Self, final

from src.modules.tasks_mod.application.get_task.get_task_dto import GetTaskDto
from src.modules.tasks_mod.application.get_task.get_task_result_dto import GetTaskResultDto
from src.modules.tasks_mod.domain.exceptions.tasks_exception import TasksException
from src.modules.tasks_mod.infrastructure.repositories.tasks_reader_sqlite_repository import (
    TasksReaderSqliteRepository,
)


@final
class GetTaskService:
    """Caso de uso: obtener una tarea por su id."""

    _get_task_dto: GetTaskDto
    _tasks_reader_sqlite_repository: TasksReaderSqliteRepository

    def __init__(self) -> None:
        self._tasks_reader_sqlite_repository = TasksReaderSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, get_task_dto: GetTaskDto) -> GetTaskResultDto:
        """Ejecuta el caso de uso.

        Returns:
            GetTaskResultDto: la tarea.

        Raises:
            TasksException: 400 si falta el id, 404 si la tarea no existe.
        """
        self._get_task_dto = get_task_dto
        self._fail_if_wrong_input()

        task_row = self._tasks_reader_sqlite_repository.get_by_id(self._get_task_dto.task_id)
        if task_row is None:
            TasksException.not_found_custom(f"no existe la tarea {self._get_task_dto.task_id}")

        return GetTaskResultDto.from_primitives(task_row)

    def _fail_if_wrong_input(self) -> None:
        if self._get_task_dto.task_id <= 0:
            TasksException.bad_request_custom("task_id tiene que ser un entero positivo")
