import aiohttp
import base64
from typing import final

from infrastructure.repositories.environment_reader_raw_repository import EnvironmentReaderRawRepository


@final
class ProjectsReaderApiRepository:

    def __init__(self, organization: str, pat: str):
        self._organization = organization
        self._base_url = f"https://dev.azure.com/{organization}/_apis"
        self._auth = base64.b64encode(f":{pat}".encode()).decode()

    @staticmethod
    def get_instance() -> "ProjectsReaderApiRepository":
        env = EnvironmentReaderRawRepository.get_instance()
        return ProjectsReaderApiRepository(
            organization=env.get_azure_organization_name(),
            pat=env.get_azure_pat()
        )


    def _get_headers(self) -> dict:
        return {
            "Authorization": f"Basic {self._auth}",
            "Content-Type": "application/json"
        }

    async def _request(self, url: str):
        async with aiohttp.ClientSession() as session:
            async with session.get(url, headers=self._get_headers()) as response:
                if response.status == 404:
                    return None
                response.raise_for_status()
                return await response.json()

    async def get_projects_by_organization(self) -> list[dict]:
        """
        Get all projects for the organization.

        Returns:
            List of project dictionaries with id, name, description, etc.
        """
        url = f"{self._base_url}/projects?api-version=7.0"
        result = await self._request(url)
        return result.get("value", []) if result else []
