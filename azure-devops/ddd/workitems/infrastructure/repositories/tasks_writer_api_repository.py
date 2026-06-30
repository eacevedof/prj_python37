from typing import final, Self, Any

from ddd.shared.infrastructure.repositories.environment_reader_env_repository import EnvironmentReaderEnvRepository
from ddd.workitems.domain.enums import AzureApiEnum, WorkItemFieldEnum
from ddd.workitems.infrastructure.repositories.abstract_work_items_api_repository import AbstractWorkItemsApiRepository


@final
class TasksWriterApiRepository(AbstractWorkItemsApiRepository):
    """Repository for creating and updating Task work items in Azure DevOps."""

    @classmethod
    def get_instance(cls, project: str) -> Self:
        env = EnvironmentReaderEnvRepository.get_instance()
        return cls(
            organization=env.get_azure_organization_name(),
            project_name=project
        )

    async def create_work_item(
        self,
        item_type: str,
        title: str,
        parent_id: int | None = None,
        **fields: Any
    ) -> dict[str, Any]:
        url = f"{self._base_url}/${item_type}?api-version={AzureApiEnum.API_VERSION.value}"
        payload: list[dict[str, Any]] = [{"op": "add", "path": f"/fields/{WorkItemFieldEnum.TITLE.value}", "value": title}]

        for field, value in fields.items():
            payload.append({"op": "add", "path": f"/fields/{field}", "value": value})

        # Add parent relation (Epic)
        if parent_id:
            payload.append({
                "op": "add",
                "path": "/relations/-",
                "value": {
                    "rel": AzureApiEnum.LINK_TYPE_HIERARCHY_REVERSE.value,
                    "url": f"{self._base_url}/{parent_id}",
                    "attributes": {"name": "Parent"}
                }
            })

        result = await self._request("POST", url, payload)
        return result or {}

    async def update_work_item(self, work_item_id: int, **fields: Any) -> dict[str, Any]:
        url = f"{self._base_url}/{work_item_id}?api-version={AzureApiEnum.API_VERSION.value}"
        payload: list[dict[str, Any]] = [
            {"op": "replace", "path": f"/fields/{field}", "value": value}
            for field, value in fields.items()
        ]
        result = await self._request("PATCH", url, payload)
        return result or {}
