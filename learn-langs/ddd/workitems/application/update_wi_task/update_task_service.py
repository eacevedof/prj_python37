from typing import final, Self, Any

from ddd.workitems.application.update_wi_task.update_task_dto import UpdateTaskDto
from ddd.workitems.application.update_wi_task.update_task_result_dto import UpdateTaskResultDto
from ddd.workitems.infrastructure.repositories.tasks_writer_api_repository import TasksWriterApiRepository


@final
class UpdateTaskService:
    """Service for updating Task work items in Azure DevOps."""

    _update_task_dto: UpdateTaskDto
    _tasks_writer_api_repository: TasksWriterApiRepository

    def __init__(self) -> None:
        pass

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
            fields["System.State"] = self._update_task_dto.state

        if self._update_task_dto.assigned_to:
            fields["System.AssignedTo"] = self._update_task_dto.assigned_to

        if self._update_task_dto.title:
            fields["System.Title"] = self._update_task_dto.title

        if self._update_task_dto.description:
            fields["System.Description"] = self._update_task_dto.description

        return fields

    def __get_primitives_from_api_response(self, api_resp_dict: dict[str, Any]) -> dict[str, Any]:
        fields_dict = api_resp_dict.get("fields", {})
        return {
            "id": api_resp_dict.get("id", 0),
            "title": fields_dict.get("System.Title", ""),
            "state": fields_dict.get("System.State", ""),
            "url": api_resp_dict.get("_links", {}).get("html", {}).get("href", ""),
        }
