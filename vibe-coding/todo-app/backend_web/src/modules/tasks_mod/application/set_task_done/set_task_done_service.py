from typing import Self, final

from src.modules.tasks_mod.application.set_task_done.set_task_done_dto import SetTaskDoneDto
from src.modules.tasks_mod.application.set_task_done.set_task_done_result_dto import SetTaskDoneResultDto
from src.modules.tasks_mod.domain.enums.task_done_enum import TaskDoneEnum
from src.modules.tasks_mod.domain.enums.task_field_enum import TaskFieldEnum
from src.modules.tasks_mod.domain.exceptions.tasks_exception import TasksException
from src.modules.tasks_mod.infrastructure.repositories.tasks_writer_sqlite_repository import (
    TasksWriterSqliteRepository,
)


@final
class SetTaskDoneService:
    """Caso de uso: marcar una tarea como hecha o pendiente.

    Es un caso de uso propio y no un campo mas de UpdateTask porque es la accion
    que mas se usa de toda la aplicacion, y porque tiene su propia ruta
    (`PATCH /api/tasks/{id}/done`). Un cliente que solo quiere tachar una tarea no
    deberia tener que mandarle el titulo y la descripcion enteros.
    """

    _set_task_done_dto: SetTaskDoneDto
    _tasks_writer_sqlite_repository: TasksWriterSqliteRepository

    def __init__(self) -> None:
        self._tasks_writer_sqlite_repository = TasksWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, set_task_done_dto: SetTaskDoneDto) -> SetTaskDoneResultDto:
        """Ejecuta el caso de uso.

        Returns:
            SetTaskDoneResultDto: el id y el estado en que ha quedado.

        Raises:
            TasksException: 400 si falta el id, 404 si la tarea no existe.
        """
        self._set_task_done_dto = set_task_done_dto
        self._fail_if_wrong_input()

        is_updated = self._tasks_writer_sqlite_repository.set_done(
            self._set_task_done_dto.task_id,
            int(TaskDoneEnum.DONE if self._set_task_done_dto.is_done else TaskDoneEnum.PENDING),
        )
        if not is_updated:
            TasksException.not_found_custom(f"no existe la tarea {self._set_task_done_dto.task_id}")

        return SetTaskDoneResultDto.from_primitives({
            TaskFieldEnum.TASK_ID: self._set_task_done_dto.task_id,
            TaskFieldEnum.IS_DONE: self._set_task_done_dto.is_done,
        })

    def _fail_if_wrong_input(self) -> None:
        if self._set_task_done_dto.task_id <= 0:
            TasksException.bad_request_custom("task_id tiene que ser un entero positivo")
