from typing import final, Self, Any

from ddd.workitems.infrastructure.repositories.projects_reader_api_repository import ProjectsReaderApiRepository
from ddd.workitems.application.search_wi_projects.search_projects_dto import SearchProjectsDto
from ddd.workitems.application.search_wi_projects.search_projects_result_dto import SearchProjectsResultDto


@final
class SearchProjectsService:
    """Service for searching projects in Azure DevOps organization."""

    _projects_reader_api_repository: ProjectsReaderApiRepository
    _search_projects_dto: SearchProjectsDto

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, search_project_dto: SearchProjectsDto) -> SearchProjectsResultDto:
        """
        Search projects by text.

        Raises:
            WorkItemsException: When search fails
        """
        self._search_projects_dto = search_project_dto
        self._projects_reader_api_repository = ProjectsReaderApiRepository.get_instance()

        all_projects = await self._projects_reader_api_repository.get_all_projects()
        filtered_projects = self._get_filtered_projects(all_projects)

        return SearchProjectsResultDto.from_primitives({
            "projects": filtered_projects,
            "total": len(filtered_projects),
        })

    def _get_filtered_projects(self, projects: list[dict[str, Any]]) -> list[dict[str, Any]]:
        if not self._search_projects_dto.search_text:
            return projects[:self._search_projects_dto.limit]

        search_text = self._search_projects_dto.search_text
        filtered = []

        for project_dict in projects:
            name = str(project_dict.get("name", "")).lower()
            description = str(project_dict.get("description", "")).lower()

            if search_text in name or search_text in description:
                filtered.append(self._get_project_primitives(project_dict))

            if len(filtered) >= self._search_projects_dto.limit:
                break

        return filtered

    def _get_project_primitives(self, project_dict: dict[str, Any]) -> dict[str, Any]:
        return {
            "id": project_dict.get("id", ""),
            "name": project_dict.get("name", ""),
            "description": project_dict.get("description", ""),
            "url": project_dict.get("url", ""),
            "state": project_dict.get("state", ""),
        }
