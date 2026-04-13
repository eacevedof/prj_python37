from dataclasses import dataclass, field
from typing import Self, Any

from ddd.sharepoint.application.list_files.file_item_dto import FileItemDto


@dataclass(frozen=True, slots=True)
class ListFilesResultDto:
    """Output DTO containing list of files and folders."""

    items: list[FileItemDto] = field(default_factory=list)
    folder_path: str = "/"
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        items_primitives = primitives.get("items", [])
        items = [FileItemDto.from_primitives(item) for item in items_primitives]
        return cls(
            items=items,
            folder_path=str(primitives.get("folder_path", "/")),
            total=int(primitives.get("total", len(items))),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "items": [item.to_dict() for item in self.items],
            "folder_path": self.folder_path,
            "total": self.total,
        }
