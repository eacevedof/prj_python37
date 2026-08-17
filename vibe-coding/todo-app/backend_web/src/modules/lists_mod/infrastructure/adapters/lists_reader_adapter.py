from typing import Self, final

from src.modules.lists_mod.infrastructure.repositories.lists_reader_sqlite_repository import (
    ListsReaderSqliteRepository,
)


@final
class ListsReaderAdapter:
    """Cumple el puerto `ListsReader` que declara tasks_mod.

    Unica puerta de LECTURA de este modulo hacia otros modulos. Si manana otro
    modulo necesita algo de listas, se anade un metodo aqui (y al puerto que lo
    pida), no se importa el repositorio desde fuera.

    Envuelve el repositorio, no `GetListService`. Si llamase al caso de uso, un id
    inexistente lanzaria `ListsException` (404), que cruzaria la frontera hasta el
    controller de tareas -que solo captura `TasksException`- y se convertiria en un
    500. Un puerto devuelve datos, no excepciones ajenas.
    """

    _lists_reader_sqlite_repository: ListsReaderSqliteRepository

    def __init__(self) -> None:
        self._lists_reader_sqlite_repository = ListsReaderSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def has_list(self, list_id: int) -> bool:
        return self._lists_reader_sqlite_repository.get_by_id(list_id) is not None
