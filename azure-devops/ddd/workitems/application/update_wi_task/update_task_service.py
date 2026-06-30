from typing import final, Self, Any

from ddd.shared.infrastructure.components.texter import Texter
from ddd.workitems.domain.enums import WorkItemFieldEnum
from ddd.workitems.infrastructure.repositories.tasks_writer_api_repository import TasksWriterApiRepository
from ddd.workitems.application.update_wi_task.update_task_dto import UpdateTaskDto
from ddd.workitems.application.update_wi_task.update_task_result_dto import UpdateTaskResultDto


@final
class UpdateTaskService:
    """Service for updating Task work items in Azure DevOps."""

    _texter: Texter
    _tasks_writer_api_repository: TasksWriterApiRepository
    _update_task_dto: UpdateTaskDto

    def __init__(self) -> None:
        self._texter = Texter.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, update_task_dto: UpdateTaskDto) -> UpdateTaskResultDto:
        self._update_task_dto = update_task_dto
        self._tasks_writer_api_repository = TasksWriterApiRepository.get_instance(
            project=update_task_dto.project
        )

        fields = self.__get_fields_updated()
        api_response = await self._tasks_writer_api_repository.update_work_item(
            work_item_id=update_task_dto.task_id,
            **fields
        )

        return UpdateTaskResultDto.from_primitives(
            self.__get_primitives_from_api_response(api_response)
        )

    def __get_fields_updated(self) -> dict[str, Any]:
        fields: dict[str, Any] = {}

        if self._update_task_dto.state:
            fields[WorkItemFieldEnum.STATE.value] = self._update_task_dto.state

        if self._update_task_dto.assigned_to:
            fields[WorkItemFieldEnum.ASSIGNED_TO.value] = self._update_task_dto.assigned_to

        if self._update_task_dto.title:
            fields[WorkItemFieldEnum.TITLE.value] = self._update_task_dto.title

        if self._update_task_dto.description:
            fields[WorkItemFieldEnum.DESCRIPTION.value] = self._texter.get_html_from_plain_text(self._update_task_dto.description)

        return fields

    def __get_primitives_from_api_response(self, api_resp_dict: dict[str, Any]) -> dict[str, Any]:
        fields_dict = api_resp_dict.get("fields", {})
        return {
            "id": api_resp_dict.get("id", 0),
            "title": fields_dict.get(WorkItemFieldEnum.TITLE.value, ""),
            "state": fields_dict.get(WorkItemFieldEnum.STATE.value, ""),
            "url": api_resp_dict.get("_links", {}).get("html", {}).get("href", ""),
        }
