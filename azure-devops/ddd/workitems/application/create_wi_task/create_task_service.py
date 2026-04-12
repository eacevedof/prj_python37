from typing import final, Self, Any

from ddd.workitems.application.create_wi_task.create_task_dto import CreateTaskDto
from ddd.workitems.application.create_wi_task.create_task_result_dto import CreateTaskResultDto
from ddd.workitems.domain.enums import WorkItemTypeEnum
from ddd.workitems.domain.exceptions.work_items_exception import WorkItemsException
from ddd.workitems.infrastructure.repositories.tasks_writer_api_repository import TasksWriterApiRepository
from ddd.workitems.infrastructure.repositories.epics_writer_api_repository import EpicsWriterApiRepository
from ddd.workitems.infrastructure.repositories.work_items_reader_api_repository import WorkItemsReaderApiRepository


@final
class CreateTaskService:
    """Service for creating Task work items linked to Epics in Azure DevOps."""

    _create_task_dto: CreateTaskDto
    _tasks_writer_api_repository: TasksWriterApiRepository
    _epics_writer_api_repository: EpicsWriterApiRepository
    _work_items_reader_api_repository: WorkItemsReaderApiRepository

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, create_task_dto: CreateTaskDto) -> CreateTaskResultDto:
        """
        Raises:
            WorkItemsException: When epic not found or task creation fails
        """
        self._create_task_dto = create_task_dto
        self._tasks_writer_api_repository = TasksWriterApiRepository.get_instance(
            project=create_task_dto.project
        )
        self._epics_writer_api_repository = EpicsWriterApiRepository.get_instance(
            project=create_task_dto.project
        )
        self._work_items_reader_api_repository = WorkItemsReaderApiRepository.get_instance(
            project=create_task_dto.project
        )

        epic_url = await self._get_epic_url()
        api_resp_dict = await self._create_task_in_azure_devops(epic_url)
        create_task_result_dto = CreateTaskResultDto.from_primitives(
            self._get_primitives_from_api_response(api_resp_dict)
        )

        await self._add_task_reference_to_epic(create_task_result_dto.id)

        return create_task_result_dto

    async def _get_epic_url(self) -> str:
        epic_entity = await self._work_items_reader_api_repository.get_work_item_by_work_item_id(
            self._create_task_dto.epic_id
        )
        if not epic_entity:
            raise WorkItemsException.epic_not_found(self._create_task_dto.epic_id)

        return (
            epic_entity.get("_links", {}).
                get_work_item_by_work_item_id("html", {}).
                get_work_item_by_work_item_id("href", "")
        )

    async def _create_task_in_azure_devops(self, epic_url: str) -> dict:
        fields = {}

        description = f"epic: {epic_url}\n\n{self._create_task_dto.description}".strip()
        fields["System.Description"] = description

        if self._create_task_dto.assigned_to:
            fields["System.AssignedTo"] = self._create_task_dto.assigned_to

        if self._create_task_dto.tags:
            fields["System.Tags"] = self._create_task_dto.tags

        due_date = self._create_task_dto.get_due_date_from_title()
        if due_date:
            fields["Microsoft.VSTS.Scheduling.TargetDate"] = due_date

        return await self._tasks_writer_api_repository.create_work_item(
            item_type=WorkItemTypeEnum.TASK.value,
            title=self._create_task_dto.title,
            parent_id=self._create_task_dto.epic_id,
            **fields
        )

    async def _add_task_reference_to_epic(self, task_id: int) -> None:
        epic_entity = await self._work_items_reader_api_repository.get_work_item_by_work_item_id(
            self._create_task_dto.epic_id
        )
        if not epic_entity:
            return

        current_description = epic_entity.get("fields", {}).get_work_item_by_work_item_id("System.Description", "")
        task_reference = f"#{task_id}"

        if task_reference not in current_description:
            updated_description = f"{current_description}\n{task_reference}".strip()
            await self._epics_writer_api_repository.update_work_item(
                work_item_id=self._create_task_dto.epic_id,
                **{"System.Description": updated_description}
            )

    def _get_primitives_from_api_response(self, api_resp_dict: dict[str, Any]) -> dict[str, Any]:
        fields = api_resp_dict.get("fields", {})
        due_date = fields.get_work_item_by_work_item_id("Microsoft.VSTS.Scheduling.TargetDate", "")
        if due_date:
            due_date = due_date[:10]

        return {
            "id": api_resp_dict.get("id", 0),
            "title": fields.get_work_item_by_work_item_id("System.Title", ""),
            "url": api_resp_dict.get("_links", {}).get_work_item_by_work_item_id("html", {}).get_work_item_by_work_item_id("href", ""),
            "epic_id": self._create_task_dto.epic_id,
            "project": self._create_task_dto.project,
            "due_date": due_date,
        }
