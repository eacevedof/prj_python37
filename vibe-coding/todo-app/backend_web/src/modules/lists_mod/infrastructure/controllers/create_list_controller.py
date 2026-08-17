from typing import Any, Self, final

from src.modules.lists_mod.application.create_list.create_list_dto import CreateListDto
from src.modules.lists_mod.application.create_list.create_list_service import CreateListService
from src.modules.lists_mod.domain.exceptions.lists_exception import ListsException
from src.modules.shared.domain.enums.response_code_enum import ResponseCodeEnum
from src.modules.shared.domain.enums.response_key_enum import ResponseKeyEnum
from src.modules.shared.domain.enums.response_message_enum import ResponseMessageEnum
from src.modules.shared.infrastructure.components.logger.logger import Logger


@final
class CreateListController:
    """Controller de POST /api/lists.

    ESTA ES LA PLANTILLA DE TODOS LOS CONTROLLERS, y son todos iguales a
    proposito: cuando todos hacen lo mismo, leer uno es leerlos todos.

    Un controller hace exactamente tres cosas:
      1. Convierte el diccionario de la peticion en el DTO de entrada.
      2. Llama al service.
      3. Envuelve el resultado en el sobre de respuesta.

    **EL CONTROLLER ES EL UNICO SITIO DE LA APLICACION QUE CAPTURA EXCEPCIONES.**
    Esa es la regla que sostiene todo lo demas: si los services y los repositorios
    tambien capturasen, un error podria quedarse tragado en cinco sitios distintos
    y nunca sabrias donde mirar. Aqui hay dos capturas, y son distintas:

      `except ListsException`  error ESPERADO. El service decidio que esto podia
                               pasar (falta un campo, no existe, hay conflicto).
                               Se devuelve su codigo y su mensaje tal cual: son
                               para el cliente.

      `except Exception`       error INESPERADO. Un bug, la base caida, lo que sea.
                               Va al log CON su traza, y al cliente le llega un
                               mensaje generico. Nunca se devuelve el texto de la
                               excepcion: puede contener rutas del servidor o
                               trozos de SQL.

    No hay logica aqui. Si te ves escribiendo un `if` en un controller que no sea
    uno de estos dos `except`, esa decision es del service.
    """

    _logger: Logger
    _create_list_service: CreateListService

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._create_list_service = CreateListService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def invoke(self, request_data: dict[str, Any]) -> dict[str, Any]:
        try:
            create_list_result_dto = self._create_list_service(CreateListDto.from_primitives(request_data))
            return {
                ResponseKeyEnum.STATUS: ResponseCodeEnum.CREATED.value,
                ResponseKeyEnum.DATA: create_list_result_dto.to_dict(),
            }
        except ListsException as lists_exception:
            return {
                ResponseKeyEnum.STATUS: lists_exception.code,
                ResponseKeyEnum.ERROR: lists_exception.message,
            }
        except Exception as exception:
            self._logger.log_exception(exception, "CreateListController.invoke")
            return {
                ResponseKeyEnum.STATUS: ResponseCodeEnum.INTERNAL_SERVER_ERROR.value,
                ResponseKeyEnum.ERROR: ResponseMessageEnum.UNEXPECTED_ERROR,
            }
