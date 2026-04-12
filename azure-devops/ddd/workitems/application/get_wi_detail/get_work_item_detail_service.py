from typing import final, Self, Any

from ddd.workitems.application.get_wi_detail.get_work_item_detail_dto import GetWorkItemDetailDto
from ddd.workitems.application.get_wi_detail.get_work_item_detail_result_dto import GetWorkItemDetailResultDto
from ddd.workitems.domain.exceptions.work_items_exception import WorkItemsException
from ddd.workitems.infrastructure.repositories.work_items_reader_api_repository import WorkItemsReaderApiRepository


@final
class GetWorkItemDetailService:
    """Service for getting work item detail including description and comments."""

    _detail_dto: GetWorkItemDetailDto
    _work_items_reader_api_repository: WorkItemsReaderApiRepository

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, detail_dto: GetWorkItemDetailDto) -> GetWorkItemDetailResultDto:
        """
        Get work item detail with description and comments.

        Raises:
            WorkItemsException: When work item not found
        """
        self._detail_dto = detail_dto
        self._work_items_reader_api_repository = WorkItemsReaderApiRepository.get_instance(
            project=detail_dto.project
        )

        work_item = await self._work_items_reader_api_repository.get_work_item_by_work_item_id(
            detail_dto.work_item_id
        )

        if not work_item:
            raise WorkItemsException.epic_not_found(detail_dto.work_item_id)

        comments = await self._work_items_reader_api_repository.get_comments_by_work_item_id(
            detail_dto.work_item_id
        )

        primitives = self._map_to_primitives(work_item, comments)

        return GetWorkItemDetailResultDto.from_primitives(primitives)

    def _map_to_primitives(
        self,
        work_item: dict[str, Any],
        comments: list[dict[str, Any]]
    ) -> dict[str, Any]:
        fields = work_item.get("fields", {})

        created_date = fields.get("System.CreatedDate", "")
        if created_date:
            created_date = created_date[:10]

        changed_date = fields.get("System.ChangedDate", "")
        if changed_date:
            changed_date = changed_date[:10]

        assigned_to = fields.get("System.AssignedTo", {})
        if isinstance(assigned_to, dict):
            assigned_to = assigned_to.get("displayName", "")

        return {
            "id": work_item.get("id", 0),
            "title": fields.get("System.Title", ""),
            "work_item_type": fields.get("System.WorkItemType", ""),
            "state": fields.get("System.State", ""),
            "description": fields.get("System.Description", ""),
            "assigned_to": assigned_to,
            "created_date": created_date,
            "changed_date": changed_date,
            "url": work_item.get("_links", {}).get("html", {}).get("href", ""),
            "comments": self._map_comments(comments),
        }

    def _map_comments(self, comments: list[dict[str, Any]]) -> list[dict[str, Any]]:
        return [self._map_single_comment(c) for c in comments]

    def _map_single_comment(self, comment: dict[str, Any]) -> dict[str, Any]:
        created_date = comment.get("createdDate", "")
        if created_date:
            created_date = created_date[:10]

        created_by = comment.get("createdBy", {})
        if isinstance(created_by, dict):
            created_by = created_by.get("displayName", "")

        return {
            "id": comment.get("id", 0),
            "text": comment.get("text", ""),
            "created_by": created_by,
            "created_date": created_date,
        }
