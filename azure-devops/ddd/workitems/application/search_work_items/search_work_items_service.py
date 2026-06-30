from typing import final, Self, Any

from ddd.shared.infrastructure.repositories.environment_reader_env_repository import EnvironmentReaderEnvRepository
from ddd.workitems.infrastructure.repositories.work_items_reader_api_repository import WorkItemsReaderApiRepository
from ddd.workitems.application.search_work_items.search_work_items_dto import SearchWorkItemsDto
from ddd.workitems.application.search_work_items.search_work_items_result_dto import SearchWorkItemsResultDto


@final
class SearchWorkItemsService:
    """Service for searching work items by text across the Azure DevOps organization."""

    _work_items_reader_api_repository: WorkItemsReaderApiRepository
    _search_work_items_dto: SearchWorkItemsDto

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, search_dto: SearchWorkItemsDto) -> SearchWorkItemsResultDto:
        """
        Search work items by text across all projects.

        Raises:
            WorkItemsException: When search fails
        """
        self._search_work_items_dto = search_dto

        default_project = EnvironmentReaderEnvRepository.get_instance().get_app_default_project()
        self._work_items_reader_api_repository = WorkItemsReaderApiRepository.get_instance(
            project=default_project
        )

        search_results = await self._work_items_reader_api_repository.search(
            search_text=search_dto.search_text,
            limit=search_dto.limit,
            work_item_type=search_dto.work_item_type,
        )

        items_primitives = self._get_search_results_to_primitives(search_results)

        return SearchWorkItemsResultDto.from_primitives({
            "items": items_primitives,
            "total": len(items_primitives),
        })

    def _get_search_results_to_primitives(self, search_results: list[dict[str, Any]]) -> list[dict[str, Any]]:
        return [self._get_single_result_primitives(result) for result in search_results]

    def _get_single_result_primitives(self, result: dict[str, Any]) -> dict[str, Any]:
        fields = result.get("fields", {})

        created_date = fields.get("system.createddate", "")
        if created_date:
            created_date = created_date[:10]

        changed_date = fields.get("system.changeddate", "")
        if changed_date:
            changed_date = changed_date[:10]

        return {
            "id": fields.get("system.id", 0),
            "title": fields.get("system.title", ""),
            "work_item_type": fields.get("system.workitemtype", ""),
            "state": fields.get("system.state", ""),
            "project": fields.get("system.teamproject", ""),
            "assigned_to": fields.get("system.assignedto", ""),
            "created_date": created_date,
            "changed_date": changed_date,
            "url": result.get("url", ""),
        }
