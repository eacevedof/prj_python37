import aiohttp
import base64
from abc import ABC

from shared.infrastructure.repositories.environment_reader_raw_repository import EnvironmentReaderRawRepository


class AbstractWorkItemsApiRepository(ABC):

    def __init__(self, organization: str, project: str):
        azure_path = EnvironmentReaderRawRepository.get_instance().get_azure_pat()
        self._auth = base64.b64encode(f":{azure_path}".encode()).decode()
        self._organization = organization

        self._project = project
        self._base_url = f"https://dev.azure.com/{organization}/{project}/_apis/wit/workitems"
        self._wiql_url = f"https://dev.azure.com/{organization}/{project}/_apis/wit/wiql"

    def _get_headers(self, content_type: str = "application/json-patch+json") -> dict:
        return {
            "Authorization": f"Basic {self._auth}",
            "Content-Type": content_type
        }

    async def _request(
        self,
        method: str,
        url: str,
        json_data=None,
        content_type: str = "application/json-patch+json"
    ):
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
