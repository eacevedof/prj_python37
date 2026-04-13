from typing import final, Self

from pydantic import BaseModel, Field

from ddd.shared.infrastructure.components.response_dto import ResponseDto
from ddd.workitems.infrastructure.controllers.abstract_api_controller import AbstractApiController
from ddd.workitems.application.get_wi_tasks import GetTasksDto, GetTasksService
from ddd.workitems.domain.exceptions.work_items_exception import WorkItemsException


class GetTasksRequestPyd(BaseModel):
    project: str = Field(..., min_length=1, description="Azure DevOps project name")
    epic_id: int | None = Field(None, description="Filter by epic ID")
    state: str | None = Field(None, description="Filter by state (New, Active, Resolved, Closed)")
    assigned_to: str | None = Field(None, description="Filter by assigned user")
    work_item_type: str | None = Field(None, description="Filter by work item type")
    limit: int = Field(50, ge=1, le=200, description="Maximum number of results")


@final
class GetTasksController(AbstractApiController):

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, request_pyd: GetTasksRequestPyd) -> ResponseDto:
        try:
            get_task_result_dto = await GetTasksService.get_instance()(
                GetTasksDto.from_primitives(
                    request_pyd.model_dump()
                )
            )

            return self._response_ok(
                data=get_task_result_dto.to_dict(),
                message="Tasks retrieved successfully",
            )
        except WorkItemsException as e:
            return self._response_error(message=e.message, code=e.code)
        except Exception:
            return self._response_error_500()
