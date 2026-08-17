import re
from typing import Self, final

from src.modules.lists_mod.application.create_list.create_list_dto import CreateListDto
from src.modules.lists_mod.application.create_list.create_list_result_dto import CreateListResultDto
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
class CreateListService:
    """Caso de uso: crear una lista.

    ESTE FICHERO ES LA PLANTILLA. Todos los services del proyecto tienen esta
    forma exacta:

      1. Los colaboradores se DECLARAN arriba, como anotaciones de clase, antes
         de `__init__`. Sirve de indice: de un vistazo sabes de que depende este
         caso de uso.
      2. `__init__` los construye con `get_instance()`. Nunca `Clase()` directo.
      3. `get_instance()` es la unica forma de crear el service.
      4. `__call__` es el UNICO metodo publico. Recibe el DTO de entrada y
         devuelve el DTO de resultado. Nada mas.
      5. Lo primero que hace `__call__` es guardar el DTO en `self` y llamar a
         `_fail_if_wrong_input()`.
      6. **No hay try/except.** Si algo falla, la excepcion sube hasta el
         controller, que es el unico que captura.

    El nombre del atributo es el nombre de la clase en snake_case, COMPLETO:
    `_lists_writer_sqlite_repository`, no `_writer` ni `_repo`. Es largo a
    proposito: al leer una linea suelta sabes exactamente que se esta usando.
    """

    _lists_reader_sqlite_repository: ListsReaderSqliteRepository
    _lists_writer_sqlite_repository: ListsWriterSqliteRepository
    _create_list_dto: CreateListDto

    def __init__(self) -> None:
        self._lists_reader_sqlite_repository = ListsReaderSqliteRepository.get_instance()
        self._lists_writer_sqlite_repository = ListsWriterSqliteRepository.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def __call__(self, create_list_dto: CreateListDto) -> CreateListResultDto:
        """Ejecuta el caso de uso.

        Returns:
            CreateListResultDto: la lista creada, con su id nuevo.

        Raises:
            ListsException: 400 si la entrada es invalida, 409 si el nombre ya existe.
        """
        self._create_list_dto = create_list_dto
        self._fail_if_wrong_input()
        self.__fail_if_name_taken()

        new_list_id = self._lists_writer_sqlite_repository.create(
            self._create_list_dto.name,
            self._create_list_dto.color,
            self._create_list_dto.position,
        )

        return CreateListResultDto.from_primitives(
            {
                ListFieldEnum.ID: new_list_id,
                ListFieldEnum.NAME: self._create_list_dto.name,
                ListFieldEnum.COLOR: self._create_list_dto.color,
                ListFieldEnum.POSITION: self._create_list_dto.position,
            }
        )

    def _fail_if_wrong_input(self) -> None:
        """Valida la ENTRADA: lo que se puede comprobar sin tocar la base de datos.

        Va con un guion bajo (protegido) y no con dos, porque es un metodo que
        existe en todos los services y forma parte de la plantilla: se espera
        encontrarlo con este nombre exacto.
        """
        if not self._create_list_dto.name:
            ListsException.bad_request_custom("name es obligatorio")
        if len(self._create_list_dto.name) > ListLimitEnum.NAME_MAX_LENGTH:
            ListsException.bad_request_custom(f"name no puede pasar de {ListLimitEnum.NAME_MAX_LENGTH} caracteres")
        if self._create_list_dto.color is not None and not re.match(
            ListLimitEnum.COLOR_PATTERN, self._create_list_dto.color
        ):
            ListsException.bad_request_custom("color tiene que ser un hexadecimal tipo '#4F8EF7'")

    def __fail_if_name_taken(self) -> None:
        """Valida contra el ESTADO: hace falta consultar la base de datos.

        Va con dos guiones bajos (privado) porque es propio de este caso de uso, no
        parte de la plantilla.

        Se comprueba aqui en vez de dejar que reviente el indice unico de la tabla
        por dos razones: el cliente recibe un 409 con un mensaje que explica que
        pasa, y no un 500 con un error de integridad; y el mensaje se escribe en
        castellano en vez de venir del motor.
        """
        if self._lists_reader_sqlite_repository.has_name_taken(self._create_list_dto.name, 0):
            ListsException.conflict_custom(f"ya existe una lista llamada '{self._create_list_dto.name}'")
