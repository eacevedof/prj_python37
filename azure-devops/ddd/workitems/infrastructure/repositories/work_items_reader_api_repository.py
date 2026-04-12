from typing import final, Any

from ddd.workitems.infrastructure.repositories.abstract_work_items_api_repository import AbstractWorkItemsApiRepository
from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import EnvironmentReaderRawRepository


@final
class WorkItemsReaderApiRepository(AbstractWorkItemsApiRepository):
    """Repository for reading work items from Azure DevOps API."""

    @staticmethod
    def get_instance(project: str) -> "WorkItemsReaderApiRepository":
        env = EnvironmentReaderRawRepository.get_instance()
        return WorkItemsReaderApiRepository(
            organization=env.get_azure_organization_name(),
            project_name=project
        )

    async def get_work_item_by_work_item_id(self, work_item_id: int) -> dict[str, Any] | None:
        """Get a single work item by ID."""
        url = f"{self._base_url}/{work_item_id}?api-version=7.0"
        return await self._request("GET", url)

    async def get_work_items_by_work_items_ids(self, work_items_ids: list[int]) -> dict[str, Any] | None:
        """Get multiple work items by IDs."""
        ids_str = ",".join(map(str, work_items_ids))
        url = f"{self._base_url}?ids={ids_str}&api-version=7.0"
        return await self._request("GET", url)

    async def query(self, wiql: str) -> list[dict[str, Any]]:
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

    async def search(
        self,
        search_text: str,
        limit: int = 25,
        work_item_type: str = "",
    ) -> list[dict[str, Any]]:
        """
        Search work items by text.

        Args:
            search_text: Text to search for in work items
            limit: Maximum number of results
            work_item_type: Filter by work item type (task, bug, epic, issue, etc.)

        Returns:
            List of work item search results ordered by ID desc
        """
        url = f"{self._search_url}?api-version=7.0"
        payload: dict[str, Any] = {
            "searchText": search_text,
            "$top": limit,
            "$skip": 0,
            "$orderBy": [
                {
                    "field": "system.id",
                    "sortOrder": "DESC"
                }
            ],
        }
        if work_item_type:
            payload["filters"] = {"System.WorkItemType": [work_item_type]}

        result = await self._request("POST", url, payload, "application/json")
        return result.get("results", []) if result else []

    async def get_comments_by_work_item_id(self, work_item_id: int) -> list[dict[str, Any]]:
        """
        Get comments for a work item.

        Args:
            work_item_id: The work item ID

        Returns:
            List of comments
        """
        url = f"{self._base_url}/{work_item_id}/comments?api-version=7.0-preview"
        result = await self._request("GET", url, content_type="application/json")
        return result.get("comments", []) if result else []
