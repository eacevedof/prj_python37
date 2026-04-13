import base64
from abc import ABC
from typing import Any

import aiohttp

from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import EnvironmentReaderRawRepository


class AbstractWorkItemsApiRepository(ABC):
    """Base repository for Azure DevOps Work Items API operations."""

    def __init__(self, organization: str, project_name: str) -> None:
        azure_path = EnvironmentReaderRawRepository.get_instance().get_azure_pat()
        self._auth = base64.b64encode(f":{azure_path}".encode()).decode()
        self._organization = organization

        self._project = project_name
        self._base_url = f"https://dev.azure.com/{organization}/{project_name}/_apis/wit/workitems"
        self._wiql_url = f"https://dev.azure.com/{organization}/{project_name}/_apis/wit/wiql"
        self._search_url = f"https://almsearch.dev.azure.com/{organization}/_apis/search/workitemsearchresults"

    def _get_headers(self, content_type: str = "application/json-patch+json") -> dict[str, str]:
        return {
            "Authorization": f"Basic {self._auth}",
            "Content-Type": content_type
        }

    async def _request(
        self,
        method: str,
        url: str,
        json_data: list[dict[str, Any]] | dict[str, Any] | None = None,
        content_type: str = "application/json-patch+json"
    ) -> dict[str, Any] | None:
        async with aiohttp.ClientSession() as aio_http_session:
            async with aio_http_session.request(
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
