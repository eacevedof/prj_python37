import asyncio
from tabulate import tabulate
from ddd.shared.infrastructure.components.printer import pr_green, pr_blue, pr_white, pr_red
from ddd.workitems.infrastructure.repositories.projects_reader_api_repository import ProjectsReaderApiRepository
from ddd.workitems.infrastructure.repositories.work_items_reader_api_repository import WorkItemsReaderApiRepository


# https://learn.microsoft.com/es-es/rest/api/azure/devops/wit/work-items?view=azure-devops-rest-7.1

async def main():
    try:
        pr_blue("Fetching projects from Azure DevOps...\n")

        projects_repository = ProjectsReaderApiRepository.get_instance()
        projects = await projects_repository.get_projects_by_organization()

        if not projects:
            pr_red("No projects found")
            return

        pr_green(f"Found {len(projects)} projects:\n")

        headers = ["Name", "ID", "State", "Visibility"]
        table = [
            [
                project.get("name", ""),
                project.get("id", ""),
                project.get("state", ""),
                project.get("visibility", "")
            ]
            for project in projects
        ]

        pr_white(tabulate(table, headers, tablefmt="grid"))

    except Exception as e:
        pr_red(f"Error: {e}")


if __name__ == "__main__":
    asyncio.run(main())
