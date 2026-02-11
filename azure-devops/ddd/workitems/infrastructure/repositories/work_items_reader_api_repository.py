import aiohttp
import base64
from typing import Optional

class WorkItemsReaderApiRepository:

    def __init__(self, organization: str, project: str, pat: str):
        self.organization = organization
        self.project = project
        self.base_url = f"https://dev.azure.com/{organization}/{project}/_apis/wit/workitems"
        self.wiql_url = f"https://dev.azure.com/{organization}/{project}/_apis/wit/wiql"
        self.auth = base64.b64encode(f":{pat}".encode()).decode()

    async def get(self, work_item_id: int) -> Optional[dict]:
        """Get a single work item by ID."""
        url = f"{self.base_url}/{work_item_id}?api-version=7.0"
        return await self._request("GET", url)

    async def get_many(self, ids: list[int]) -> Optional[dict]:
        """Get multiple work items by IDs."""
        ids_str = ",".join(map(str, ids))
        url = f"{self.base_url}?ids={ids_str}&api-version=7.0"
        return await self._request("GET", url)

    async def query(self, wiql: str) -> list[dict]:
        """
        Query work items using WIQL.

        Args:
            wiql: WIQL query string

        Example:
            await repo.query("SELECT [Id], [Title] FROM WorkItems WHERE [State] = 'Active'")
        """
        url = f"{self.wiql_url}?api-version=7.0"
        result = await self._request("POST", url, {"query": wiql}, "application/json")
        return result.get("workItems", []) if result else []

    async def _request(self, method: str, url: str, json_data=None, content_type: str = "application/json-patch+json"):
        async with aiohttp.ClientSession() as session:
            async with session.request(
                method,
                url,
                headers=self._get_headers(content_type),
                json=json_data
            ) as response:
                if response.status == 404:
                    return None
                if response.status == 204:
                    return {"deleted": True}
                response.raise_for_status()
                return await response.json()

    # QUERY (WIQL)
    def _get_headers(self, content_type: str = "application/json-patch+json") -> dict:
        return {
            "Authorization": f"Basic {self.auth}",
            "Content-Type": content_type
        }
