from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class CommentDto:
    """Single comment from a work item."""

    id: int
    text: str
    created_by: str
    created_date: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=primitives.get("id", 0),
            text=primitives.get("text", ""),
            created_by=primitives.get("created_by", ""),
            created_date=primitives.get("created_date", ""),
        )


@dataclass(frozen=True, slots=True)
class GetWorkItemDetailResultDto:
    """Output DTO containing work item detail with description and comments."""

    id: int
    title: str
    work_item_type: str
    state: str
    description: str
    assigned_to: str
    created_date: str
    changed_date: str
    url: str
    comments: list[CommentDto] = field(default_factory=list)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        comments_data = primitives.get("comments", [])
        comments = [CommentDto.from_primitives(c) for c in comments_data]

        return cls(
            id=primitives.get("id", 0),
            title=primitives.get("title", ""),
            work_item_type=primitives.get("work_item_type", ""),
            state=primitives.get("state", ""),
            description=primitives.get("description", ""),
            assigned_to=primitives.get("assigned_to", ""),
            created_date=primitives.get("created_date", ""),
            changed_date=primitives.get("changed_date", ""),
            url=primitives.get("url", ""),
            comments=comments,
        )
