from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ListFilesResultDto:
    """Output DTO containing list of files and folders."""

    items: list[dict[str, Any]] = field(default_factory=list)
    folder_path: str = "/"
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        items_primitives = primitives.get("items", [])
        items = [cls._to_file_item(item) for item in items_primitives]
        return cls(
            items=items,
            folder_path=str(primitives.get("folder_path", "/")),
            total=int(primitives.get("total", len(items))),
        )

    @staticmethod
    def _to_file_item(primitives: dict[str, Any]) -> dict[str, Any]:
        parent_ref = primitives.get("parentReference", {})
        parent_path = parent_ref.get("path", "")
        if "/root:" in parent_path:
            parent_path = parent_path.split("/root:")[-1]
        else:
            parent_path = ""

        name = str(primitives.get("name", ""))
        full_path = f"{parent_path}/{name}".replace("//", "/")
        if not full_path.startswith("/"):
            full_path = f"/{full_path}"

        return {
            "id": str(primitives.get("id", "")),
            "name": name,
            "path": full_path,
            "size": int(primitives.get("size", 0)),
            "is_folder": "folder" in primitives,
            "mime_type": primitives.get("file", {}).get("mimeType", ""),
            "created_at": str(primitives.get("createdDateTime", "")),
            "modified_at": str(primitives.get("lastModifiedDateTime", "")),
            "web_url": str(primitives.get("webUrl", "")),
        }

    def to_dict(self) -> dict[str, Any]:
        return {
            "items": self.items,
            "folder_path": self.folder_path,
            "total": self.total,
        }
