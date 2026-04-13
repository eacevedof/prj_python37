from typing import final, Self, Any

from ddd.workitems.application.create_work_item.create_work_item_dto import CreateWorkItemDto
from ddd.workitems.application.create_work_item.create_work_item_result_dto import CreateWorkItemResultDto
from ddd.workitems.infrastructure.repositories.tasks_writer_api_repository import TasksWriterApiRepository


@final
class CreateWorkItemService:
    """Service for creating standalone work items (Task, Issue, Epic, Bug) in Azure DevOps."""

    _dto: CreateWorkItemDto
    _writer_repository: TasksWriterApiRepository

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: CreateWorkItemDto) -> CreateWorkItemResultDto:
        """Create a standalone work item without parent linking.

        Raises:
            WorkItemsException: When creation fails.
        """
        self._dto = dto
        self._writer_repository = TasksWriterApiRepository.get_instance(
            project=dto.project
        )

        api_resp_dict = await self._create_work_item()

        return CreateWorkItemResultDto.from_primitives(
            self._get_primitives_from_api_response(api_resp_dict)
        )

    async def _create_work_item(self) -> dict:
        fields: dict[str, Any] = {}

        if self._dto.description:
            fields["System.Description"] = self._dto.description

        if self._dto.assigned_to:
            fields["System.AssignedTo"] = self._dto.assigned_to

        if self._dto.tags:
            fields["System.Tags"] = self._dto.tags

        due_date = self._dto.get_due_date_from_title()
        if due_date:
            fields["Microsoft.VSTS.Scheduling.TargetDate"] = due_date

        return await self._writer_repository.create_work_item(
            item_type=self._dto.work_item_type,
            title=self._dto.title,
            **fields
        )

    def _get_primitives_from_api_response(self, api_resp_dict: dict[str, Any]) -> dict[str, Any]:
        fields = api_resp_dict.get("fields", {})
        due_date = fields.get("Microsoft.VSTS.Scheduling.TargetDate", "")
        if due_date:
            due_date = due_date[:10]

        return {
            "id": api_resp_dict.get("id", 0),
            "work_item_type": fields.get("System.WorkItemType", self._dto.work_item_type),
            "title": fields.get("System.Title", ""),
            "url": api_resp_dict.get("_links", {}).get("html", {}).get("href", ""),
            "project": self._dto.project,
            "due_date": due_date,
        }
