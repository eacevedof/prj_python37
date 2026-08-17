from typing import Any, Self, final

from src.modules.shared.domain.enums.response_code_enum import ResponseCodeEnum
from src.modules.shared.domain.enums.response_key_enum import ResponseKeyEnum
from src.modules.shared.domain.enums.response_message_enum import ResponseMessageEnum
from src.modules.shared.infrastructure.components.logger.logger import Logger

from src.modules.lists_mod.application.search_lists.search_lists_dto import SearchListsDto
from src.modules.lists_mod.application.search_lists.search_lists_service import SearchListsService
from src.modules.lists_mod.domain.exceptions.lists_exception import ListsException


@final
class SearchListsController:
    """Controller de GET /api/lists.

    Misma forma que todos los controllers del proyecto; la plantilla comentada
    linea a linea esta en `create_list_controller.py`.
    """

    _logger: Logger
    _search_lists_service: SearchListsService

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._search_lists_service = SearchListsService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def invoke(self, request_data: dict[str, Any]) -> dict[str, Any]:
        try:
            search_lists_result_dto = self._search_lists_service(SearchListsDto.from_primitives(request_data))
            return {
                ResponseKeyEnum.STATUS: ResponseCodeEnum.OK,
                ResponseKeyEnum.DATA: search_lists_result_dto.to_dict(),
            }
        except ListsException as lists_exception:
            return {
                ResponseKeyEnum.STATUS: lists_exception.code,
                ResponseKeyEnum.ERROR: lists_exception.message,
            }
        except Exception as exception:
            self._logger.log_exception(exception, "SearchListsController.invoke")
            return {
                ResponseKeyEnum.STATUS: ResponseCodeEnum.INTERNAL_SERVER_ERROR,
                ResponseKeyEnum.ERROR: ResponseMessageEnum.UNEXPECTED_ERROR,
            }
