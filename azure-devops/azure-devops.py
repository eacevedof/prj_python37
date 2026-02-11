from ddd.workitems.infrastructure.repositories.projects_reader_api_repository import ProjectsReaderApiRepository
from ddd.workitems.infrastructure.repositories.work_items_reader_api_repository import WorkItemsReaderApiRepository


# https://learn.microsoft.com/es-es/rest/api/azure/devops/wit/work-items?view=azure-devops-rest-7.1

async def main():
    projectsRepository = ProjectsReaderApiRepository.get_instance()
    projects = await projectsRepository.get_projects_by_organization()
    print("Projects:")
    for project in projects:
        print(f"- {project['name']} (ID: {project['id']})")

if __name__ == "__main__":
    main()
