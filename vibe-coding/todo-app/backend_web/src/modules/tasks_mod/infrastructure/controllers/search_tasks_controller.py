from typing import Any, Self, final

from src.modules.shared.domain.enums.response_code_enum import ResponseCodeEnum
from src.modules.shared.domain.enums.response_key_enum import ResponseKeyEnum
from src.modules.shared.domain.enums.response_message_enum import ResponseMessageEnum
from src.modules.shared.infrastructure.components.logger.logger import Logger
from src.modules.tasks_mod.application.search_tasks.search_tasks_dto import SearchTasksDto
from src.modules.tasks_mod.application.search_tasks.search_tasks_service import SearchTasksService
from src.modules.tasks_mod.domain.exceptions.tasks_exception import TasksException


@final
class SearchTasksController:
    """Controller de GET /api/tasks.

    Misma forma que todos los controllers del proyecto; la plantilla comentada
    linea a linea esta en `lists_mod/infrastructure/controllers/create_list_controller.py`.
    """

    _logger: Logger
    _search_tasks_service: SearchTasksService

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._search_tasks_service = SearchTasksService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def invoke(self, request_data: dict[str, Any]) -> dict[str, Any]:
        try:
            search_tasks_result_dto = self._search_tasks_service(SearchTasksDto.from_primitives(request_data))
            return {
                ResponseKeyEnum.STATUS: ResponseCodeEnum.OK,
                ResponseKeyEnum.DATA: search_tasks_result_dto.to_dict(),
            }
        except TasksException as tasks_exception:
            return {
                ResponseKeyEnum.STATUS: tasks_exception.code,
                ResponseKeyEnum.ERROR: tasks_exception.message,
            }
        except Exception as exception:
            self._logger.log_exception(exception, "SearchTasksController.invoke")
            return {
                ResponseKeyEnum.STATUS: ResponseCodeEnum.INTERNAL_SERVER_ERROR,
                ResponseKeyEnum.ERROR: ResponseMessageEnum.UNEXPECTED_ERROR,
            }
