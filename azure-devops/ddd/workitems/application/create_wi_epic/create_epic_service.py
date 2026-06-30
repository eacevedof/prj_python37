from typing import final, Self, Any

from ddd.shared.infrastructure.components.texter import Texter
from ddd.workitems.domain.enums import WorkItemTypeEnum, WorkItemFieldEnum
from ddd.workitems.infrastructure.repositories.epics_writer_api_repository import EpicsWriterApiRepository
from ddd.workitems.application.create_wi_epic.create_epic_dto import CreateEpicDto
from ddd.workitems.application.create_wi_epic.create_epic_result_dto import CreateEpicResultDto


@final
class CreateEpicService:
    """Service for creating Epic work items in Azure DevOps."""

    _texter: Texter
    _epics_writer_api_repository: EpicsWriterApiRepository
    _create_epic_dto: CreateEpicDto

    def __init__(self) -> None:
        self._texter = Texter.get_instance()

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

        api_resp_dict = await self.__get_epic_after_creation()
        return CreateEpicResultDto.from_primitives(
            self.__get_primitives_from_api_response(api_resp_dict)
        )

    async def __get_epic_after_creation(self) -> dict:
        fields = {}

        description_parts: list[str] = []
        if self._create_epic_dto.description:
            description_parts.append(self._create_epic_dto.description)
        if self._create_epic_dto.departments:
            departments_text = ", ".join(self._create_epic_dto.departments)
            description_parts.append(f"Departamentos: {departments_text}")

        if description_parts:
            plain_description = "\n\n".join(description_parts)
            fields[WorkItemFieldEnum.DESCRIPTION.value] = self._texter.get_html_from_plain_text(plain_description)

        if self._create_epic_dto.assigned_to:
            fields[WorkItemFieldEnum.ASSIGNED_TO.value] = self._create_epic_dto.assigned_to

        if self._create_epic_dto.tags:
            fields[WorkItemFieldEnum.TAGS.value] = self._create_epic_dto.tags

        return await self._epics_writer_api_repository.create_work_item(
            item_type=WorkItemTypeEnum.EPIC.value,
            title=self._create_epic_dto.title,
            **fields
        )

    def __get_primitives_from_api_response(self, api_resp_dict: dict[str, Any]) -> dict[str, Any]:
        return {
            "id": api_resp_dict.get("id", 0),
            "title": api_resp_dict.get("fields", {}).get(WorkItemFieldEnum.TITLE.value, ""),
            "url": api_resp_dict.get("_links", {}).get("html", {}).get("href", ""),
            "project": self._create_epic_dto.project,
        }
