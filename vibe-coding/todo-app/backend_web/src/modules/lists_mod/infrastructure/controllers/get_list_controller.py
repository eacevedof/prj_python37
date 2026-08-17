from typing import Any, Self, final

from src.modules.lists_mod.application.get_list.get_list_dto import GetListDto
from src.modules.lists_mod.application.get_list.get_list_service import GetListService
from src.modules.lists_mod.domain.exceptions.lists_exception import ListsException
from src.modules.shared.domain.enums.response_code_enum import ResponseCodeEnum
from src.modules.shared.domain.enums.response_key_enum import ResponseKeyEnum
from src.modules.shared.domain.enums.response_message_enum import ResponseMessageEnum
from src.modules.shared.infrastructure.components.logger.logger import Logger


@final
class GetListController:
    """Controller de GET /api/lists/{id}.

    Misma forma que todos los controllers del proyecto; la plantilla comentada
    linea a linea esta en `create_list_controller.py`.
    """

    _logger: Logger
    _get_list_service: GetListService

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._get_list_service = GetListService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def invoke(self, request_data: dict[str, Any]) -> dict[str, Any]:
        try:
            get_list_result_dto = self._get_list_service(GetListDto.from_primitives(request_data))
            return {
                ResponseKeyEnum.STATUS: ResponseCodeEnum.OK.value,
                ResponseKeyEnum.DATA: get_list_result_dto.to_dict(),
            }
        except ListsException as lists_exception:
            return {
                ResponseKeyEnum.STATUS: lists_exception.code,
                ResponseKeyEnum.ERROR: lists_exception.message,
            }
        except Exception as exception:
            self._logger.log_exception(exception, "GetListController.invoke")
            return {
                ResponseKeyEnum.STATUS: ResponseCodeEnum.INTERNAL_SERVER_ERROR.value,
                ResponseKeyEnum.ERROR: ResponseMessageEnum.UNEXPECTED_ERROR,
            }
