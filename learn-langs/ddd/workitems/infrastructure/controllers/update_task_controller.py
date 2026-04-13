from typing import final, Self

from pydantic import BaseModel

from ddd.shared.infrastructure.components.response_dto import ResponseDto
from ddd.workitems.infrastructure.controllers.abstract_api_controller import AbstractApiController
from ddd.workitems.application.update_wi_task import UpdateTaskDto, UpdateTaskService
from ddd.workitems.domain.exceptions.work_items_exception import WorkItemsException


class UpdateTaskRequestPyd(BaseModel):
    project: str
    state: str | None = None
    assigned_to: str | None = None
    title: str | None = None


@final
class UpdateTaskController(AbstractApiController):

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, task_id: int, request_pyd: UpdateTaskRequestPyd) -> ResponseDto:
        try:
            update_task_result_dto = await UpdateTaskService.get_instance()(
                UpdateTaskDto.from_primitives({
                    "project": request_pyd.project,
                    "task_id": task_id,
                    "state": request_pyd.state,
                    "assigned_to": request_pyd.assigned_to,
                    "title": request_pyd.title,
                })
            )

            return self._response_ok(
                data=update_task_result_dto.to_dict(),
                message="Task updated successfully",
            )
        except WorkItemsException as e:
            return self._response_error(message=e.message, code=e.code)
        except Exception:
            return self._response_error_500()
