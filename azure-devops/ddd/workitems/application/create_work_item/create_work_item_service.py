from typing import final, Self, Any

from ddd.shared.infrastructure.components.texter import Texter
from ddd.shared.infrastructure.repositories.environment_reader_env_repository import EnvironmentReaderEnvRepository
from ddd.workitems.domain.enums import WorkItemFieldEnum
from ddd.workitems.infrastructure.repositories.tasks_writer_api_repository import TasksWriterApiRepository
from ddd.workitems.application.create_work_item.create_work_item_dto import CreateWorkItemDto
from ddd.workitems.application.create_work_item.create_work_item_result_dto import CreateWorkItemResultDto


@final
class CreateWorkItemService:
    """Service for creating standalone work items (Task, Issue, Epic, Bug) in Azure DevOps."""

    _texter: Texter
    _tasks_writer_api_repository: TasksWriterApiRepository
    _create_work_item_dto: CreateWorkItemDto
    _project: str

    def __init__(self) -> None:
        self._texter = Texter.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: CreateWorkItemDto) -> CreateWorkItemResultDto:
        """Create a standalone work item without parent linking.

        Raises:
            WorkItemsException: When creation fails.
        """
        self._create_work_item_dto = dto
        self._project = dto.project or EnvironmentReaderEnvRepository.get_instance().get_app_default_project()
        self._tasks_writer_api_repository = TasksWriterApiRepository.get_instance(
            project=self._project
        )

        api_resp_dict = await self._create_work_item()

        return CreateWorkItemResultDto.from_primitives(
            self._get_primitives_from_api_response(api_resp_dict)
        )

    async def _create_work_item(self) -> dict:
        fields: dict[str, Any] = {}

        if self._create_work_item_dto.description:
            fields[WorkItemFieldEnum.DESCRIPTION.value] = self._texter.get_html_from_plain_text(self._create_work_item_dto.description)

        if self._create_work_item_dto.assigned_to:
            fields[WorkItemFieldEnum.ASSIGNED_TO.value] = self._create_work_item_dto.assigned_to

        if self._create_work_item_dto.tags:
            fields[WorkItemFieldEnum.TAGS.value] = self._create_work_item_dto.tags

        due_date = self._create_work_item_dto.get_due_date_from_title()
        if due_date:
            fields[WorkItemFieldEnum.TARGET_DATE.value] = due_date

        return await self._tasks_writer_api_repository.create_work_item(
            item_type=self._create_work_item_dto.work_item_type,
            title=self._create_work_item_dto.title,
            **fields
        )

    def _get_primitives_from_api_response(self, api_resp_dict: dict[str, Any]) -> dict[str, Any]:
        fields = api_resp_dict.get("fields", {})
        due_date = fields.get(WorkItemFieldEnum.TARGET_DATE.value, "")
        if due_date:
            due_date = due_date[:10]

        return {
            "id": api_resp_dict.get("id", 0),
            "work_item_type": fields.get("System.WorkItemType", self._create_work_item_dto.work_item_type),
            "title": fields.get(WorkItemFieldEnum.TITLE.value, ""),
            "url": api_resp_dict.get("_links", {}).get("html", {}).get("href", ""),
            "project": self._project,
            "due_date": due_date,
        }
