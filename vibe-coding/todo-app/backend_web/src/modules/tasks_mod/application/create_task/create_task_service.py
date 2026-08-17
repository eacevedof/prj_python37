from typing import Self, final

from src.modules.lists_mod.infrastructure.adapters.lists_reader_adapter import ListsReaderAdapter
from src.modules.tasks_mod.application.create_task.create_task_dto import CreateTaskDto
from src.modules.tasks_mod.application.create_task.create_task_result_dto import CreateTaskResultDto
from src.modules.tasks_mod.domain.enums.task_done_enum import TaskDoneEnum
from src.modules.tasks_mod.domain.enums.task_field_enum import TaskFieldEnum
from src.modules.tasks_mod.domain.enums.task_limit_enum import TaskLimitEnum
from src.modules.tasks_mod.domain.exceptions.tasks_exception import TasksException
from src.modules.tasks_mod.domain.ports.lists_reader import ListsReader
from src.modules.tasks_mod.domain.services.due_date import DueDate
from src.modules.tasks_mod.infrastructure.repositories.tasks_writer_sqlite_repository import (
    TasksWriterSqliteRepository,
)


@final
class CreateTaskService:
    """Caso de uso: crear una tarea dentro de una lista.

    Es el mejor ejemplo del proyecto para entender los puertos, porque tiene la
    regla que los justifica: **una tarea no puede existir sin lista**.

    Esa regla se defiende en dos capas distintas, y hacen falta las dos:

      - Aqui, preguntando al puerto antes de escribir. Sirve para devolver un 404
        con un mensaje que se entiende.
      - En la base de datos, con la clave ajena. Sirve por si alguien escribe
        directamente en la tabla saltandose la aplicacion.

    Confiar solo en la base daria un error de integridad convertido en 500, que no
    le dice nada a quien llama. Confiar solo en esto dejaria la puerta abierta a
    cualquier otro camino de escritura.
    """

    _create_task_dto: CreateTaskDto
    _due_date: DueDate
    _lists_reader: ListsReader
    _tasks_writer_sqlite_repository: TasksWriterSqliteRepository

    def __init__(self) -> None:
        self._due_date = DueDate.get_instance()
        # UNICA linea de este fichero que menciona algo del modulo de listas. A
        # partir de aqui el service solo habla con `self._lists_reader`, el puerto.
        self._lists_reader = ListsReaderAdapter.get_instance()
        self._tasks_writer_sqlite_repository = TasksWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, create_task_dto: CreateTaskDto) -> CreateTaskResultDto:
        """Ejecuta el caso de uso.

        Returns:
            CreateTaskResultDto: la tarea creada, con su id nuevo.

        Raises:
            TasksException: 400 si la entrada es invalida, 404 si la lista no existe.
        """
        self._create_task_dto = create_task_dto
        self._fail_if_wrong_input()
        self.__fail_if_list_not_found()

        new_task_id = self._tasks_writer_sqlite_repository.create(
            self._create_task_dto.id_list,
            self._create_task_dto.title,
            self._create_task_dto.description,
            self._create_task_dto.due_date,
            self._create_task_dto.position,
        )

        return CreateTaskResultDto.from_primitives(
            {
                TaskFieldEnum.TASK_ID: new_task_id,
                TaskFieldEnum.ID_LIST: self._create_task_dto.id_list,
                TaskFieldEnum.TITLE: self._create_task_dto.title,
                TaskFieldEnum.DESCRIPTION: self._create_task_dto.description,
                TaskFieldEnum.IS_DONE: TaskDoneEnum.PENDING,
                TaskFieldEnum.DUE_DATE: self._create_task_dto.due_date,
                TaskFieldEnum.POSITION: self._create_task_dto.position,
            }
        )

    def _fail_if_wrong_input(self) -> None:
        if self._create_task_dto.id_list <= 0:
            TasksException.bad_request_custom("id_list es obligatorio")
        if not self._create_task_dto.title:
            TasksException.bad_request_custom("title es obligatorio")
        if len(self._create_task_dto.title) > TaskLimitEnum.TITLE_MAX_LENGTH:
            TasksException.bad_request_custom(f"title no puede pasar de {TaskLimitEnum.TITLE_MAX_LENGTH} caracteres")
        self.__fail_if_wrong_due_date()

    def __fail_if_wrong_due_date(self) -> None:
        if self._create_task_dto.due_date is None:
            return
        if not self._due_date.is_valid(self._create_task_dto.due_date):
            TasksException.bad_request_custom(f"due_date tiene que tener el formato {TaskLimitEnum.DUE_DATE_HINT}")

    def __fail_if_list_not_found(self) -> None:
        if not self._lists_reader.has_list(self._create_task_dto.id_list):
            TasksException.not_found_custom(f"no existe la lista {self._create_task_dto.id_list}")
