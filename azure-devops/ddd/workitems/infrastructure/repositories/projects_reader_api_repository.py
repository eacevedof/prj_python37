import base64
from typing import final, Self, Any

import aiohttp

from ddd.shared.infrastructure.repositories.environment_reader_raw_repository import EnvironmentReaderRawRepository


@final
class ProjectsReaderApiRepository:
    """Repository for reading projects from Azure DevOps API."""

    _organization: str
    _auth: str
    _base_url: str

    def __init__(self, organization: str) -> None:
        azure_pat = EnvironmentReaderRawRepository.get_instance().get_azure_pat()
        self._auth = base64.b64encode(f":{azure_pat}".encode()).decode()
        self._organization = organization
        self._base_url = f"https://dev.azure.com/{organization}/_apis/projects"

    @classmethod
    def get_instance(cls) -> Self:
        env = EnvironmentReaderRawRepository.get_instance()
        return cls(organization=env.get_azure_organization_name())

    def _get_headers(self) -> dict[str, str]:
        return {
            "Authorization": f"Basic {self._auth}",
            "Content-Type": "application/json",
        }

    async def _request(self, url: str) -> dict[str, Any] | None:
        async with aiohttp.ClientSession() as session:
            async with session.get(url, headers=self._get_headers()) as response:
                if response.status == 404:
                    return None
                response.raise_for_status()
                return await response.json()

    async def get_all_projects(self) -> list[dict[str, Any]]:
        """
        Get all projects in the organization.

        Returns:
            List of project dictionaries with id, name, description, etc.
        """
        url = f"{self._base_url}?api-version=7.0&$top=500"
        result = await self._request(url)
        return result.get("value", []) if result else []
