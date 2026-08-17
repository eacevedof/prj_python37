from typing import Self, final

from src.modules.lists_mod.infrastructure.adapters.lists_reader_adapter import ListsReaderAdapter
from src.modules.tasks_mod.application.update_task.update_task_dto import UpdateTaskDto
from src.modules.tasks_mod.application.update_task.update_task_result_dto import UpdateTaskResultDto
from src.modules.tasks_mod.domain.enums.task_field_enum import TaskFieldEnum
from src.modules.tasks_mod.domain.enums.task_limit_enum import TaskLimitEnum
from src.modules.tasks_mod.domain.exceptions.tasks_exception import TasksException
from src.modules.tasks_mod.domain.ports.lists_reader import ListsReader
from src.modules.tasks_mod.domain.services.due_date import DueDate
from src.modules.tasks_mod.infrastructure.repositories.tasks_reader_sqlite_repository import (
    TasksReaderSqliteRepository,
)
from src.modules.tasks_mod.infrastructure.repositories.tasks_writer_sqlite_repository import (
    TasksWriterSqliteRepository,
)


@final
class UpdateTaskService:
    """Caso de uso: modificar una tarea (incluido moverla de lista)."""

    _update_task_dto: UpdateTaskDto
    _due_date: DueDate
    _lists_reader: ListsReader
    _tasks_reader_sqlite_repository: TasksReaderSqliteRepository
    _tasks_writer_sqlite_repository: TasksWriterSqliteRepository

    def __init__(self) -> None:
        self._due_date = DueDate.get_instance()
        self._lists_reader = ListsReaderAdapter.get_instance()
        self._tasks_reader_sqlite_repository = TasksReaderSqliteRepository.get_instance()
        self._tasks_writer_sqlite_repository = TasksWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, update_task_dto: UpdateTaskDto) -> UpdateTaskResultDto:
        """Ejecuta el caso de uso.

        Returns:
            UpdateTaskResultDto: la tarea como ha quedado.

        Raises:
            TasksException: 400 entrada invalida, 404 si no existe la tarea o la lista.
        """
        self._update_task_dto = update_task_dto
        self._fail_if_wrong_input()
        self.__fail_if_list_not_found()

        is_updated = self._tasks_writer_sqlite_repository.update(
            self._update_task_dto.task_id,
            self._update_task_dto.id_list,
            self._update_task_dto.title,
            self._update_task_dto.description,
            self._update_task_dto.due_date,
            self._update_task_dto.position,
        )
        if not is_updated:
            TasksException.not_found_custom(f"no existe la tarea {self._update_task_dto.task_id}")

        # Se relee para devolver el estado real, incluido `is_done`, que este caso
        # de uso no toca (para eso esta SetTaskDone). Devolver lo que se acaba de
        # escribir mentiria sobre los campos que no se han modificado.
        task_row = self._tasks_reader_sqlite_repository.get_by_id(self._update_task_dto.task_id)
        if task_row is None:
            TasksException.not_found_custom(f"no existe la tarea {self._update_task_dto.task_id}")

        return UpdateTaskResultDto.from_primitives(
            {
                **task_row,
                TaskFieldEnum.IS_DONE: int(task_row[TaskFieldEnum.IS_DONE]),
            }
        )

    def _fail_if_wrong_input(self) -> None:
        if self._update_task_dto.task_id <= 0:
            TasksException.bad_request_custom("task_id tiene que ser un entero positivo")
        if self._update_task_dto.id_list <= 0:
            TasksException.bad_request_custom("id_list es obligatorio")
        if not self._update_task_dto.title:
            TasksException.bad_request_custom("title es obligatorio")
        if len(self._update_task_dto.title) > TaskLimitEnum.TITLE_MAX_LENGTH:
            TasksException.bad_request_custom(f"title no puede pasar de {TaskLimitEnum.TITLE_MAX_LENGTH} caracteres")
        self.__fail_if_wrong_due_date()

    def __fail_if_wrong_due_date(self) -> None:
        if self._update_task_dto.due_date is None:
            return
        if not self._due_date.is_valid(self._update_task_dto.due_date):
            TasksException.bad_request_custom(f"due_date tiene que tener el formato {TaskLimitEnum.DUE_DATE_HINT}")

    def __fail_if_list_not_found(self) -> None:
        # Se comprueba tambien al editar, no solo al crear: este caso de uso puede
        # mover la tarea a otra lista, y esa lista destino tiene que existir.
        if not self._lists_reader.has_list(self._update_task_dto.id_list):
            TasksException.not_found_custom(f"no existe la lista {self._update_task_dto.id_list}")
