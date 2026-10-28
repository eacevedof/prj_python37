from typing import Any, Self, final

from src.modules.lists_mod.application.search_lists.search_lists_dto import SearchListsDto
from src.modules.lists_mod.application.search_lists.search_lists_result_dto import SearchListsResultDto
from src.modules.lists_mod.domain.enums.list_field_enum import ListFieldEnum
from src.modules.lists_mod.domain.ports.tasks_counter import TasksCounter
from src.modules.lists_mod.infrastructure.repositories.lists_reader_sqlite_repository import (
    ListsReaderSqliteRepository,
)
from src.modules.tasks_mod.infrastructure.adapters.tasks_counter_adapter import TasksCounterAdapter


@final
class SearchListsService:
    """Caso de uso: listar las listas, con su contador de tareas abiertas."""

    _tasks_counter: TasksCounter
    _lists_reader_sqlite_repository: ListsReaderSqliteRepository
    _search_lists_dto: SearchListsDto

    def __init__(self) -> None:
        self._tasks_counter = TasksCounterAdapter.get_instance()
        self._lists_reader_sqlite_repository = ListsReaderSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, search_lists_dto: SearchListsDto) -> SearchListsResultDto:
        """Ejecuta el caso de uso.

        Returns:
            SearchListsResultDto: las listas vivas que casan con el filtro.
        """
        self._search_lists_dto = search_lists_dto
        self._fail_if_wrong_input()

        list_rows = self._lists_reader_sqlite_repository.get_all(self._search_lists_dto.name_contains)
        return SearchListsResultDto.from_primitives(
            {ListFieldEnum.ITEMS: [self.__get_item_with_counter(list_row) for list_row in list_rows]}
        )

    def _fail_if_wrong_input(self) -> None:
        # Un listado sin filtros no tiene nada que validar. El metodo se queda
        # igualmente porque forma parte de la plantilla: quien anada un filtro
        # manana encuentra el sitio donde validarlo ya hecho.
        return None

    def __get_item_with_counter(self, list_row: dict[str, Any]) -> dict[str, Any]:
        # Una consulta al contador por lista. Con las decenas de listas de un PoC
        # es irrelevante; si algun dia son miles, el puerto crece con un metodo
        # que devuelva los contadores en bloque y este bucle desaparece. Se deja
        # asi porque optimizar antes de tener el problema es como se acaba con
        # codigo complicado que nadie sabe por que existe.
        return {
            **list_row,
            ListFieldEnum.OPEN_TASKS_COUNT: self._tasks_counter.get_open_tasks_count(int(list_row[ListFieldEnum.ID])),
        }
