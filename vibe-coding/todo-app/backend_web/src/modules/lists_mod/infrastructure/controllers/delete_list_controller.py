from typing import Any, Self, final

from src.modules.shared.domain.enums.response_code_enum import ResponseCodeEnum
from src.modules.shared.domain.enums.response_key_enum import ResponseKeyEnum
from src.modules.shared.domain.enums.response_message_enum import ResponseMessageEnum
from src.modules.shared.infrastructure.components.logger.logger import Logger

from src.modules.lists_mod.application.delete_list.delete_list_dto import DeleteListDto
from src.modules.lists_mod.application.delete_list.delete_list_service import DeleteListService
from src.modules.lists_mod.domain.exceptions.lists_exception import ListsException


@final
class DeleteListController:
    """Controller de DELETE /api/lists/{id}.

    Misma forma que todos los controllers del proyecto; la plantilla comentada
    linea a linea esta en `create_list_controller.py`.
    """

    _logger: Logger
    _delete_list_service: DeleteListService

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._delete_list_service = DeleteListService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def invoke(self, request_data: dict[str, Any]) -> dict[str, Any]:
        try:
            delete_list_result_dto = self._delete_list_service(DeleteListDto.from_primitives(request_data))
            return {
                ResponseKeyEnum.STATUS: ResponseCodeEnum.OK,
                ResponseKeyEnum.DATA: delete_list_result_dto.to_dict(),
            }
        except ListsException as lists_exception:
            return {
                ResponseKeyEnum.STATUS: lists_exception.code,
                ResponseKeyEnum.ERROR: lists_exception.message,
            }
        except Exception as exception:
            self._logger.log_exception(exception, "DeleteListController.invoke")
            return {
                ResponseKeyEnum.STATUS: ResponseCodeEnum.INTERNAL_SERVER_ERROR,
                ResponseKeyEnum.ERROR: ResponseMessageEnum.UNEXPECTED_ERROR,
            }
