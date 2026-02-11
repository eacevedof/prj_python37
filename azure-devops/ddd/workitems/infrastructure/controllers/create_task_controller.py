from typing import final, Self

from pydantic import BaseModel

from ddd.shared.infrastructure.components.response_dto import ResponseDto
from ddd.workitems.infrastructure.controllers.abstract_api_controller import AbstractApiController
from ddd.workitems.application.create_wi_task import CreateTaskDto, CreateTaskService
from ddd.workitems.domain.exceptions.work_items_exception import WorkItemsException


class CreateTaskRequestPyd(BaseModel):
    project: str
    epic_id: int
    title: str
    description: str = ""
    assigned_to: str = ""
    tags: str = ""


@final
class CreateTaskController(AbstractApiController):

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, request_pyd: CreateTaskRequestPyd) -> ResponseDto:
        try:
            create_task_result_dto = await CreateTaskService.get_instance()(
                CreateTaskDto.from_primitives(
                    request_pyd.model_dump()
                )
            )

            return self._response_created(
                data=create_task_result_dto.to_dict(),
                message="Task created successfully",
            )
        except WorkItemsException as e:
            return self._response_error(message=e.message, code=e.code)
        except Exception:
            return self._response_error_500()
