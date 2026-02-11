import re
from typing import final, Self, Any

from ddd.workitems.application.get_wi_tasks.get_tasks_dto import GetTasksDto
from ddd.workitems.application.get_wi_tasks.get_tasks_result_dto import GetTasksResultDto
from ddd.workitems.infrastructure.repositories.work_items_reader_api_repository import WorkItemsReaderApiRepository


@final
class GetTasksService:
    _get_tasks_dto: GetTasksDto
    _work_items_reader_api_repository: WorkItemsReaderApiRepository

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, get_tasks_dto: GetTasksDto) -> GetTasksResultDto:
        """
        Raises:
            WorkItemsException: When query fails
        """
        self._get_tasks_dto = get_tasks_dto
        self._work_items_reader_api_repository = WorkItemsReaderApiRepository.get_instance(
            project=get_tasks_dto.project
        )

        work_items = await self._query_work_items()
        tasks_primitives = await self._get_tasks_primitives(work_items)

        return GetTasksResultDto.from_primitives({
            "tasks": tasks_primitives,
            "total": len(tasks_primitives),
        })

    async def _query_work_items(self) -> list[dict]:
        wiql = self._build_wiql_query()
        return await self._work_items_reader_api_repository.query(wiql)

    def _build_wiql_query(self) -> str:
        conditions = ["[System.TeamProject] = @project"]

        if self._get_tasks_dto.work_item_type:
            conditions.append(f"[System.WorkItemType] = '{self._get_tasks_dto.work_item_type}'")

        if self._get_tasks_dto.state:
            conditions.append(f"[System.State] = '{self._get_tasks_dto.state}'")

        if self._get_tasks_dto.assigned_to:
            conditions.append(f"[System.AssignedTo] = '{self._get_tasks_dto.assigned_to}'")

        if self._get_tasks_dto.epic_id:
            conditions.append(f"[System.Parent] = {self._get_tasks_dto.epic_id}")

        where_clause = " AND ".join(conditions)
        return f"""
            SELECT [System.Id]
            FROM WorkItems
            WHERE {where_clause}
            ORDER BY [System.CreatedDate] DESC
        """

    async def _get_tasks_primitives(self, work_items: list[dict]) -> list[dict[str, Any]]:
        if not work_items:
            return []

        ids = [item.get("id") for item in work_items[:self._get_tasks_dto.limit]]
        if not ids:
            return []

        response = await self._work_items_reader_api_repository.get_many(ids)
        if not response:
            return []

        items = response.get("value", [])
        return [self._get_primitives_from_work_item(item) for item in items]

    def _get_primitives_from_work_item(self, work_item: dict[str, Any]) -> dict[str, Any]:
        fields = work_item.get("fields", {})
        title = fields.get("System.Title", "")

        due_date = fields.get("Microsoft.VSTS.Scheduling.TargetDate", "")
        if due_date:
            due_date = due_date[:10]
        else:
            due_date = self._get_due_date_from_title(title)

        assigned_to_field = fields.get("System.AssignedTo", {})
        if isinstance(assigned_to_field, dict):
            assigned_to = assigned_to_field.get("displayName", "")
        else:
            assigned_to = str(assigned_to_field) if assigned_to_field else ""

        return {
            "id": work_item.get("id", 0),
            "work_item_type": fields.get("System.WorkItemType", ""),
            "title": title,
            "state": fields.get("System.State", ""),
            "assigned_to": assigned_to,
            "due_date": due_date,
            "url": work_item.get("_links", {}).get("html", {}).get("href", ""),
        }

    def _get_due_date_from_title(self, title: str) -> str:
        match = re.search(r"(\d{4}-\d{2}-\d{2})$", title.strip())
        if match:
            return match.group(1)
        return ""
