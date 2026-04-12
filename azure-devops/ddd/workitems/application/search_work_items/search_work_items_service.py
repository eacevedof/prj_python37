from typing import final, Self, Any

from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import EnvironmentReaderRawRepository
from ddd.workitems.application.search_work_items.search_work_items_dto import SearchWorkItemsDto
from ddd.workitems.application.search_work_items.search_work_items_result_dto import SearchWorkItemsResultDto
from ddd.workitems.infrastructure.repositories.work_items_reader_api_repository import WorkItemsReaderApiRepository


@final
class SearchWorkItemsService:
    """Service for searching work items by text across the Azure DevOps organization."""

    _search_dto: SearchWorkItemsDto
    _work_items_reader_api_repository: WorkItemsReaderApiRepository

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
        self._search_dto = search_dto

        default_project = EnvironmentReaderRawRepository.get_instance().get_app_default_project()
        self._work_items_reader_api_repository = WorkItemsReaderApiRepository.get_instance(
            project=default_project
        )

        search_results = await self._work_items_reader_api_repository.search(
            search_text=search_dto.search_text,
            limit=search_dto.limit,
        )

        items_primitives = self._map_search_results_to_primitives(search_results)
        items_primitives.sort(key=lambda x: x["id"], reverse=True)

        return SearchWorkItemsResultDto.from_primitives({
            "items": items_primitives,
            "total": len(items_primitives),
        })

    def _map_search_results_to_primitives(self, search_results: list[dict[str, Any]]) -> list[dict[str, Any]]:
        return [self._map_single_result(result) for result in search_results]

    def _map_single_result(self, result: dict[str, Any]) -> dict[str, Any]:
        fields = result.get("fields", {})
        return {
            "id": fields.get("system.id", 0),
            "title": fields.get("system.title", ""),
            "work_item_type": fields.get("system.workitemtype", ""),
            "state": fields.get("system.state", ""),
            "project": fields.get("system.teamproject", ""),
            "url": result.get("url", ""),
        }
