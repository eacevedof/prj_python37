from typing import final
from .abstract_work_items_api_repository import AbstractWorkItemsApiRepository


@final
class WorkItemsWriterApiRepository(AbstractWorkItemsApiRepository):

    async def create(self, item_type: str, title: str, **fields) -> dict:
        """
        Create a new work item.

        Args:
            item_type: Type of work item (Task, Bug, User Story, etc.)
            title: Title of the work item
            **fields: Additional fields (e.g., System.Description, System.AssignedTo)
        """
        url = f"{self._base_url}/${item_type}?api-version=7.0"
        payload = [{"op": "add", "path": "/fields/System.Title", "value": title}]
        for field, value in fields.items():
            payload.append({"op": "add", "path": f"/fields/{field}", "value": value})
        return await self._request("POST", url, payload)

    async def update(self, work_item_id: int, **fields) -> dict:
        """
        Update a work item.

        Args:
            work_item_id: ID of the work item to update
            **fields: Fields to update (e.g., System.State="Active", System.Title="New Title")
        """
        url = f"{self._base_url}/{work_item_id}?api-version=7.0"
        payload = [
            {"op": "replace", "path": f"/fields/{field}", "value": value}
            for field, value in fields.items()
        ]
        return await self._request("PATCH", url, payload)

    async def delete(self, work_item_id: int, permanent: bool = False) -> dict:
        """
        Delete a work item.

        Args:
            work_item_id: ID of the work item to delete
            permanent: If True, permanently destroys the work item
        """
        url = f"{self._base_url}/{work_item_id}?api-version=7.0"
        if permanent:
            url += "&destroy=true"
        return await self._request("DELETE", url)
