from typing import final, Self, Any

from pydantic import BaseModel

from ddd.shared.infrastructure.components.response_dto import ResponseDto
from ddd.workitems.infrastructure.controllers.abstract_api_controller import AbstractApiController
from ddd.workitems.application.create_wi_epic import CreateEpicDto, CreateEpicService
from ddd.workitems.domain.exceptions.work_items_exception import WorkItemsException


class CreateEpicRequestPyd(BaseModel):
    project: str
    title: str
    description: str = ""
    departments: list[str] = []
    assigned_to: str = ""
    tags: str = ""


@final
class CreateEpicController(AbstractApiController):

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, request_pyd: CreateEpicRequestPyd) -> ResponseDto:
        try:
            create_epic_result_dto = await CreateEpicService.get_instance()(
                CreateEpicDto.from_primitives(
                    request_pyd.model_dump()
                )
            )
            return self._response_created(
                data=create_epic_result_dto.to_dict(),
                message="Epic created successfully",
            )
        except WorkItemsException as e:
            return self._response_error(message=e.message, code=e.code)
        except Exception:
            return self._response_error_500()
