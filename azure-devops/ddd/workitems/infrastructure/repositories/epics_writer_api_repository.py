from typing import final, Self, Any

from ddd.workitems.infrastructure.repositories.abstract_work_items_api_repository import AbstractWorkItemsApiRepository
from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import EnvironmentReaderRawRepository


@final
class EpicsWriterApiRepository(AbstractWorkItemsApiRepository):

    @classmethod
    def get_instance(cls, project: str) -> Self:
        env = EnvironmentReaderRawRepository.get_instance()
        return cls(
            organization=env.get_azure_organization_name(),
            project=project
        )

    async def create_work_item(self, item_type: str, title: str, **fields: Any) -> dict:
        url = f"{self._base_url}/${item_type}?api-version=7.0"
        payload = [{"op": "add", "path": "/fields/System.Title", "value": title}]

        for field, value in fields.items():
            payload.append({"op": "add", "path": f"/fields/{field}", "value": value})

        return await self._request("POST", url, payload)

    async def update_work_item(self, work_item_id: int, **fields: Any) -> dict:
        url = f"{self._base_url}/{work_item_id}?api-version=7.0"
        payload = [
            {"op": "replace", "path": f"/fields/{field}", "value": value}
            for field, value in fields.items()
        ]
        return await self._request("PATCH", url, payload)
