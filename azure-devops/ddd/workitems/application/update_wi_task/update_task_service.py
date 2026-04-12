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

        fields = self._build_fields()
        api_response = await self._tasks_writer_api_repository.update_work_item(
            work_item_id=update_task_dto.task_id,
            **fields
        )

        return UpdateTaskResultDto.from_primitives(
            self._get_primitives_from_api_response(api_response)
        )

    def _build_fields(self) -> dict[str, Any]:
        fields: dict[str, Any] = {}

        if self._update_task_dto.state:
            fields["System.State"] = self._update_task_dto.state

        if self._update_task_dto.assigned_to:
            fields["System.AssignedTo"] = self._update_task_dto.assigned_to

        if self._update_task_dto.title:
            fields["System.Title"] = self._update_task_dto.title

        return fields

    def _get_primitives_from_api_response(self, api_response: dict[str, Any]) -> dict[str, Any]:
        fields = api_response.get("fields", {})
        return {
            "id": api_response.get("id", 0),
            "title": fields.get("System.Title", ""),
            "state": fields.get("System.State", ""),
            "url": api_response.get("_links", {}).get("html", {}).get("href", ""),
        }
