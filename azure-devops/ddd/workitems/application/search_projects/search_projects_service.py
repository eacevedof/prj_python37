from typing import final, Self, Any

from ddd.workitems.application.search_projects.search_projects_dto import SearchProjectsDto
from ddd.workitems.application.search_projects.search_projects_result_dto import SearchProjectsResultDto
from ddd.workitems.infrastructure.repositories.projects_reader_api_repository import ProjectsReaderApiRepository


@final
class SearchProjectsService:
    """Service for searching projects in Azure DevOps organization."""

    _search_dto: SearchProjectsDto
    _projects_reader_api_repository: ProjectsReaderApiRepository

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, search_dto: SearchProjectsDto) -> SearchProjectsResultDto:
        """
        Search projects by text.

        Raises:
            WorkItemsException: When search fails
        """
        self._search_dto = search_dto
        self._projects_reader_api_repository = ProjectsReaderApiRepository.get_instance()

        all_projects = await self._projects_reader_api_repository.get_all_projects()
        filtered_projects = self._filter_projects(all_projects)

        return SearchProjectsResultDto.from_primitives({
            "projects": filtered_projects,
            "total": len(filtered_projects),
        })

    def _filter_projects(self, projects: list[dict[str, Any]]) -> list[dict[str, Any]]:
        if not self._search_dto.search_text:
            return projects[:self._search_dto.limit]

        search_text = self._search_dto.search_text
        filtered = []

        for project in projects:
            name = str(project.get("name", "")).lower()
            description = str(project.get("description", "")).lower()

            if search_text in name or search_text in description:
                filtered.append(self._map_project(project))

            if len(filtered) >= self._search_dto.limit:
                break

        return filtered

    def _map_project(self, project: dict[str, Any]) -> dict[str, Any]:
        return {
            "id": project.get("id", ""),
            "name": project.get("name", ""),
            "description": project.get("description", ""),
            "url": project.get("url", ""),
            "state": project.get("state", ""),
        }
