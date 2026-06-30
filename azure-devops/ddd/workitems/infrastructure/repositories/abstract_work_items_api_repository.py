import base64
from abc import ABC
from typing import Any

import aiohttp

from ddd.shared.infrastructure.repositories.environment_reader_env_repository import EnvironmentReaderEnvRepository

HTTP_STATUS_NOT_FOUND = 404
HTTP_STATUS_NO_CONTENT = 204


class AbstractWorkItemsApiRepository(ABC):
    """Base repository for Azure DevOps Work Items API operations."""

    def __init__(self, organization: str, project_name: str) -> None:
        azure_pat = EnvironmentReaderEnvRepository.get_instance().get_azure_pat()
        self._auth = base64.b64encode(f":{azure_pat}".encode()).decode()
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
                if response.status == HTTP_STATUS_NOT_FOUND:
                    return None
                if response.status == HTTP_STATUS_NO_CONTENT:
                    return {"deleted": True}
                response.raise_for_status()
                return await response.json()
