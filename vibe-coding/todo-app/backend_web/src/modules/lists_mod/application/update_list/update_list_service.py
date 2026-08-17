import re
from typing import Self, final

from src.modules.lists_mod.application.update_list.update_list_dto import UpdateListDto
from src.modules.lists_mod.application.update_list.update_list_result_dto import UpdateListResultDto
from src.modules.lists_mod.domain.enums.list_field_enum import ListFieldEnum
from src.modules.lists_mod.domain.enums.list_limit_enum import ListLimitEnum
from src.modules.lists_mod.domain.exceptions.lists_exception import ListsException
from src.modules.lists_mod.infrastructure.repositories.lists_reader_sqlite_repository import (
    ListsReaderSqliteRepository,
)
from src.modules.lists_mod.infrastructure.repositories.lists_writer_sqlite_repository import (
    ListsWriterSqliteRepository,
)


@final
class UpdateListService:
    """Caso de uso: modificar una lista."""

    _update_list_dto: UpdateListDto
    _lists_reader_sqlite_repository: ListsReaderSqliteRepository
    _lists_writer_sqlite_repository: ListsWriterSqliteRepository

    def __init__(self) -> None:
        self._lists_reader_sqlite_repository = ListsReaderSqliteRepository.get_instance()
        self._lists_writer_sqlite_repository = ListsWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, update_list_dto: UpdateListDto) -> UpdateListResultDto:
        """Ejecuta el caso de uso.

        Returns:
            UpdateListResultDto: la lista como ha quedado.

        Raises:
            ListsException: 400 entrada invalida, 404 no existe, 409 nombre repetido.
        """
        self._update_list_dto = update_list_dto
        self._fail_if_wrong_input()
        self.__fail_if_name_taken()

        is_updated = self._lists_writer_sqlite_repository.update(
            self._update_list_dto.list_id,
            self._update_list_dto.name,
            self._update_list_dto.color,
            self._update_list_dto.position,
        )
        if not is_updated:
            # rowcount 0: o no existe, o ya estaba borrada. Para el cliente es lo
            # mismo, y decirle cual de las dos filtraria informacion sin necesidad.
            ListsException.not_found_custom(f"no existe la lista {self._update_list_dto.list_id}")

        return UpdateListResultDto.from_primitives({
            ListFieldEnum.LIST_ID: self._update_list_dto.list_id,
            ListFieldEnum.NAME: self._update_list_dto.name,
            ListFieldEnum.COLOR: self._update_list_dto.color,
            ListFieldEnum.POSITION: self._update_list_dto.position,
        })

    def _fail_if_wrong_input(self) -> None:
        if self._update_list_dto.list_id <= 0:
            ListsException.bad_request_custom("list_id tiene que ser un entero positivo")
        if not self._update_list_dto.name:
            ListsException.bad_request_custom("name es obligatorio")
        if len(self._update_list_dto.name) > ListLimitEnum.NAME_MAX_LENGTH:
            ListsException.bad_request_custom(
                f"name no puede pasar de {ListLimitEnum.NAME_MAX_LENGTH} caracteres"
            )
        if self._update_list_dto.color is not None and not re.match(
            ListLimitEnum.COLOR_PATTERN, self._update_list_dto.color
        ):
            ListsException.bad_request_custom("color tiene que ser un hexadecimal tipo '#4F8EF7'")

    def __fail_if_name_taken(self) -> None:
        # Se excluye la propia lista: renombrar la lista 3 de "Compra" a "Compra"
        # (o cambiarle solo el color) no puede chocar consigo misma.
        if self._lists_reader_sqlite_repository.has_name_taken(
            self._update_list_dto.name, self._update_list_dto.list_id
        ):
            ListsException.conflict_custom(f"ya existe una lista llamada '{self._update_list_dto.name}'")
