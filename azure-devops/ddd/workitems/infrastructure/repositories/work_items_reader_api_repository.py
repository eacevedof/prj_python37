from typing import Optional, final
from ddd.workitems.infrastructure.repositories.abstract_work_items_api_repository import AbstractWorkItemsApiRepository
from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import EnvironmentReaderRawRepository


@final
class WorkItemsReaderApiRepository(AbstractWorkItemsApiRepository):

    @staticmethod
    def get_instance(project: str) -> "WorkItemsReaderApiRepository":
        env = EnvironmentReaderRawRepository.get_instance()
        return WorkItemsReaderApiRepository(
            organization=env.get_azure_organization_name(),
            project=project
        )


    async def get(self, work_item_id: int) -> Optional[dict]:
        """Get a single work item by ID."""
        url = f"{self._base_url}/{work_item_id}?api-version=7.0"
        return await self._request("GET", url)

    async def get_many(self, ids: list[int]) -> Optional[dict]:
        """Get multiple work items by IDs."""
        ids_str = ",".join(map(str, ids))
        url = f"{self._base_url}?ids={ids_str}&api-version=7.0"
        return await self._request("GET", url)

    async def query(self, wiql: str) -> list[dict]:
        """
        Query work items using WIQL.

        Args:
            wiql: WIQL query string

        Example:
            await repo.query("SELECT [Id], [Title] FROM WorkItems WHERE [State] = 'Active'")
        """
        url = f"{self._wiql_url}?api-version=7.0"
        result = await self._request("POST", url, {"query": wiql}, "application/json")
        return result.get("workItems", []) if result else []
