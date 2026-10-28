from typing import Any, Self, final

from src.modules.shared.domain.enums.response_code_enum import ResponseCodeEnum
from src.modules.shared.domain.enums.response_key_enum import ResponseKeyEnum
from src.modules.shared.domain.enums.response_message_enum import ResponseMessageEnum
from src.modules.shared.infrastructure.components.logger.logger import Logger
from src.modules.tasks_mod.application.update_task.update_task_dto import UpdateTaskDto
from src.modules.tasks_mod.application.update_task.update_task_service import UpdateTaskService
from src.modules.tasks_mod.domain.exceptions.tasks_exception import TasksException


@final
class UpdateTaskController:
    """Controller de PUT /api/tasks/{id}.

    Misma forma que todos los controllers del proyecto; la plantilla comentada
    linea a linea esta en `lists_mod/infrastructure/controllers/create_list_controller.py`.
    """

    _logger: Logger
    _update_task_service: UpdateTaskService

    def __init__(self) -> None:
        self._logger = Logger.get_instance()
        self._update_task_service = UpdateTaskService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def invoke(self, request_data: dict[str, Any]) -> dict[str, Any]:
        try:
            update_task_result_dto = self._update_task_service(UpdateTaskDto.from_primitives(request_data))
            return {
                ResponseKeyEnum.STATUS: ResponseCodeEnum.OK.value,
                ResponseKeyEnum.DATA: update_task_result_dto.to_dict(),
            }
        except TasksException as tasks_exception:
            return {
                ResponseKeyEnum.STATUS: tasks_exception.code,
                ResponseKeyEnum.ERROR: tasks_exception.message,
            }
        except Exception as exception:
            self._logger.log_exception(exception, "UpdateTaskController.invoke")
            return {
                ResponseKeyEnum.STATUS: ResponseCodeEnum.INTERNAL_SERVER_ERROR.value,
                ResponseKeyEnum.ERROR: ResponseMessageEnum.UNEXPECTED_ERROR,
            }
