from typing import Self, final

from src.modules.lists_mod.application.get_list.get_list_dto import GetListDto
from src.modules.lists_mod.application.get_list.get_list_result_dto import GetListResultDto
from src.modules.lists_mod.domain.enums.list_field_enum import ListFieldEnum
from src.modules.lists_mod.domain.exceptions.lists_exception import ListsException
from src.modules.lists_mod.domain.ports.tasks_counter import TasksCounter
from src.modules.lists_mod.infrastructure.repositories.lists_reader_sqlite_repository import (
    ListsReaderSqliteRepository,
)
from src.modules.tasks_mod.infrastructure.adapters.tasks_counter_adapter import TasksCounterAdapter


@final
class GetListService:
    """Caso de uso: obtener una lista por su id.

    Es el primer service que usa un PUERTO. Fijate en dos detalles:

      - El atributo se declara con el tipo del PUERTO (`_tasks_counter: TasksCounter`),
        no con el del adaptador. El service depende de la capacidad, no de quien
        la implementa.
      - El atributo se llama como el puerto (`_tasks_counter`), no
        `_tasks_counter_adapter`. El nombre sigue al tipo de la anotacion.

    La UNICA linea de este fichero que menciona el adaptador es la del `__init__`.
    Ese es exactamente el punto: si manana el contador lo sirve otra cosa, se toca
    una linea.
    """

    _get_list_dto: GetListDto
    _tasks_counter: TasksCounter
    _lists_reader_sqlite_repository: ListsReaderSqliteRepository

    def __init__(self) -> None:
        self._tasks_counter = TasksCounterAdapter.get_instance()
        self._lists_reader_sqlite_repository = ListsReaderSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, get_list_dto: GetListDto) -> GetListResultDto:
        """Ejecuta el caso de uso.

        Returns:
            GetListResultDto: la lista, con su contador de tareas abiertas.

        Raises:
            ListsException: 400 si falta el id, 404 si la lista no existe.
        """
        self._get_list_dto = get_list_dto
        self._fail_if_wrong_input()

        list_row = self._lists_reader_sqlite_repository.get_by_id(self._get_list_dto.list_id)
        if list_row is None:
            ListsException.not_found_custom(f"no existe la lista {self._get_list_dto.list_id}")

        return GetListResultDto.from_primitives(
            {
                **list_row,
                ListFieldEnum.OPEN_TASKS_COUNT: self._tasks_counter.get_open_tasks_count(self._get_list_dto.list_id),
            }
        )

    def _fail_if_wrong_input(self) -> None:
        if self._get_list_dto.list_id <= 0:
            ListsException.bad_request_custom("list_id tiene que ser un entero positivo")
