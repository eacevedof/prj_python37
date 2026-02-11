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

    def _get_headers(self, content_type: str = "application/json-patch+json") -> dict:
        return {
            "Authorization": f"Basic {self.auth}",
            "Content-Type": content_type
        }

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

    # CREATE
    async def create(self, item_type: str, title: str, **fields) -> dict:
        """
        Create a new work item.

        Args:
            item_type: Type of work item (Task, Bug, User Story, etc.)
            title: Title of the work item
            **fields: Additional fields (e.g., System.Description, System.AssignedTo)
        """
        url = f"{self.base_url}/${item_type}?api-version=7.0"
        payload = [{"op": "add", "path": "/fields/System.Title", "value": title}]
        for field, value in fields.items():
            payload.append({"op": "add", "path": f"/fields/{field}", "value": value})
        return await self._request("POST", url, payload)

    # READ
    async def get(self, work_item_id: int) -> Optional[dict]:
        """Get a single work item by ID."""
        url = f"{self.base_url}/{work_item_id}?api-version=7.0"
        return await self._request("GET", url)

    async def get_many(self, ids: list[int]) -> Optional[dict]:
        """Get multiple work items by IDs."""
        ids_str = ",".join(map(str, ids))
        url = f"{self.base_url}?ids={ids_str}&api-version=7.0"
        return await self._request("GET", url)

    # UPDATE
    async def update(self, work_item_id: int, **fields) -> dict:
        """
        Update a work item.

        Args:
            work_item_id: ID of the work item to update
            **fields: Fields to update (e.g., System.State="Active", System.Title="New Title")
        """
        url = f"{self.base_url}/{work_item_id}?api-version=7.0"
        payload = [
            {"op": "replace", "path": f"/fields/{field}", "value": value}
            for field, value in fields.items()
        ]
        return await self._request("PATCH", url, payload)

    # DELETE
    async def delete(self, work_item_id: int, permanent: bool = False) -> dict:
        """
        Delete a work item.

        Args:
            work_item_id: ID of the work item to delete
            permanent: If True, permanently destroys the work item
        """
        url = f"{self.base_url}/{work_item_id}?api-version=7.0"
        if permanent:
            url += "&destroy=true"
        return await self._request("DELETE", url)

    # QUERY (WIQL)
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
