from typing import Self, final

from src.modules.lists_mod.application.delete_list.delete_list_dto import DeleteListDto
from src.modules.lists_mod.application.delete_list.delete_list_result_dto import DeleteListResultDto
from src.modules.lists_mod.domain.enums.list_field_enum import ListFieldEnum
from src.modules.lists_mod.domain.exceptions.lists_exception import ListsException
from src.modules.lists_mod.domain.ports.tasks_counter import TasksCounter
from src.modules.lists_mod.infrastructure.repositories.lists_writer_sqlite_repository import (
    ListsWriterSqliteRepository,
)
from src.modules.tasks_mod.infrastructure.adapters.tasks_counter_adapter import TasksCounterAdapter


@final
class DeleteListService:
    """Caso de uso: borrar una lista (borrado logico).

    Aqui esta la SEGUNDA razon de ser del puerto TasksCounter: no se puede borrar
    una lista que aun tiene tareas sin terminar. Es una regla de negocio, y por eso
    vive en este service y no en la base de datos.

    Podria haberse resuelto con un ON DELETE CASCADE que borrase las tareas en
    silencio. No se ha hecho: borrar trabajo pendiente sin avisar es una sorpresa
    desagradable. Es mejor devolver un 409 explicando por que, y que sea la persona
    quien decida.
    """

    _delete_list_dto: DeleteListDto
    _tasks_counter: TasksCounter
    _lists_writer_sqlite_repository: ListsWriterSqliteRepository

    def __init__(self) -> None:
        self._tasks_counter = TasksCounterAdapter.get_instance()
        self._lists_writer_sqlite_repository = ListsWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, delete_list_dto: DeleteListDto) -> DeleteListResultDto:
        """Ejecuta el caso de uso.

        Returns:
            DeleteListResultDto: el id borrado.

        Raises:
            ListsException: 400 id invalido, 404 no existe, 409 tiene tareas abiertas.
        """
        self._delete_list_dto = delete_list_dto
        self._fail_if_wrong_input()
        self.__fail_if_has_open_tasks()

        is_deleted = self._lists_writer_sqlite_repository.soft_delete(self._delete_list_dto.list_id)
        if not is_deleted:
            ListsException.not_found_custom(f"no existe la lista {self._delete_list_dto.list_id}")

        return DeleteListResultDto.from_primitives(
            {
                ListFieldEnum.ID: self._delete_list_dto.list_id,
                ListFieldEnum.IS_DELETED: True,
            }
        )

    def _fail_if_wrong_input(self) -> None:
        if self._delete_list_dto.list_id <= 0:
            ListsException.bad_request_custom("list_id tiene que ser un entero positivo")

    def __fail_if_has_open_tasks(self) -> None:
        open_tasks_count = self._tasks_counter.get_open_tasks_count(self._delete_list_dto.list_id)
        if open_tasks_count > 0:
            ListsException.conflict_custom(
                f"la lista {self._delete_list_dto.list_id} tiene {open_tasks_count} tareas sin"
                " terminar; termina o borra las tareas antes de borrar la lista"
            )
