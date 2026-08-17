from typing import Any, Self, final

from src.modules.tasks_mod.application.search_tasks.search_tasks_dto import SearchTasksDto
from src.modules.tasks_mod.application.search_tasks.search_tasks_result_dto import SearchTasksResultDto
from src.modules.tasks_mod.domain.enums.task_done_enum import TaskDoneEnum
from src.modules.tasks_mod.domain.enums.task_field_enum import TaskFieldEnum
from src.modules.tasks_mod.infrastructure.repositories.tasks_reader_sqlite_repository import (
    TasksReaderSqliteRepository,
)


@final
class SearchTasksService:
    """Caso de uso: listar tareas, filtrando por lista y/o estado.

    Este service sirve a DOS rutas:
        GET /api/tasks?id_list=3
        GET /api/lists/3/tasks

    La segunda es la misma consulta con el filtro sacado de la URL en vez de la
    query string. No hay dos casos de uso porque no hay dos comportamientos: la
    diferencia es de forma de la URL, y eso se resuelve en la tabla de rutas.
    """

    _search_tasks_dto: SearchTasksDto
    _tasks_reader_sqlite_repository: TasksReaderSqliteRepository

    def __init__(self) -> None:
        self._tasks_reader_sqlite_repository = TasksReaderSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, search_tasks_dto: SearchTasksDto) -> SearchTasksResultDto:
        """Ejecuta el caso de uso.

        Returns:
            SearchTasksResultDto: las tareas vivas que casan con los filtros.
        """
        self._search_tasks_dto = search_tasks_dto
        self._fail_if_wrong_input()

        task_rows = self._tasks_reader_sqlite_repository.get_filtered(
            self._search_tasks_dto.id_list,
            self._search_tasks_dto.is_done,
        )
        return SearchTasksResultDto.from_primitives(
            {TaskFieldEnum.ITEMS: [self.__get_item(task_row) for task_row in task_rows]}
        )

    def _fail_if_wrong_input(self) -> None:
        return None

    def __get_item(self, task_row: dict[str, Any]) -> dict[str, Any]:
        # is_done sale de la base como 0/1 y se devuelve como booleano JSON. La
        # traduccion se hace aqui y no en el repositorio: un repositorio devuelve
        # lo que hay en la tabla, sin interpretar.
        return {
            **task_row,
            TaskFieldEnum.IS_DONE: int(task_row[TaskFieldEnum.IS_DONE]) == TaskDoneEnum.DONE,
        }
