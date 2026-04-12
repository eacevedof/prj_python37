from typing import final, Self, Any

from ddd.workitems.application.create_wi_epic.create_epic_dto import CreateEpicDto
from ddd.workitems.application.create_wi_epic.create_epic_result_dto import CreateEpicResultDto
from ddd.workitems.domain.enums import WorkItemTypeEnum
from ddd.workitems.infrastructure.repositories.epics_writer_api_repository import EpicsWriterApiRepository


@final
class CreateEpicService:
    """Service for creating Epic work items in Azure DevOps."""

    _create_epic_dto: CreateEpicDto
    _epics_writer_api_repository: EpicsWriterApiRepository

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, create_epic_dto: CreateEpicDto) -> CreateEpicResultDto:
        """
        Raises:
            WorkItemsException: When epic creation fails
        """
        self._create_epic_dto = create_epic_dto
        self._epics_writer_api_repository = EpicsWriterApiRepository.get_instance(
            project=create_epic_dto.project
        )

        api_response = await self._create_epic_in_azure_devops()
        return CreateEpicResultDto.from_primitives(
            self._get_primitives_from_api_response(api_response)
        )

    async def _create_epic_in_azure_devops(self) -> dict:
        fields = {}

        if self._create_epic_dto.description:
            fields["System.Description"] = self._create_epic_dto.description

        if self._create_epic_dto.assigned_to:
            fields["System.AssignedTo"] = self._create_epic_dto.assigned_to

        if self._create_epic_dto.tags:
            fields["System.Tags"] = self._create_epic_dto.tags

        if self._create_epic_dto.departments:
            departments_text = ", ".join(self._create_epic_dto.departments)
            current_description = fields.get("System.Description", "")
            fields["System.Description"] = f"{current_description}\n\nDepartamentos: {departments_text}"

        return await self._epics_writer_api_repository.create_work_item(
            item_type=WorkItemTypeEnum.EPIC.value,
            title=self._create_epic_dto.title,
            **fields
        )

    def _get_primitives_from_api_response(self, api_response: dict[str, Any]) -> dict[str, Any]:
        return {
            "id": api_response.get("id", 0),
            "title": api_response.get("fields", {}).get_work_item_by_work_item_id("System.Title", ""),
            "url": api_response.get("_links", {}).get_work_item_by_work_item_id("html", {}).get_work_item_by_work_item_id("href", ""),
            "project": self._create_epic_dto.project,
        }
