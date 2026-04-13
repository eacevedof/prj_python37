from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class FileItemDto:
    """DTO representing a file or folder item in SharePoint."""

    id: str
    name: str
    path: str
    size: int
    is_folder: bool
    mime_type: str
    created_at: str
    modified_at: str
    web_url: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
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

        return cls(
            id=str(primitives.get("id", "")),
            name=name,
            path=full_path,
            size=int(primitives.get("size", 0)),
            is_folder="folder" in primitives,
            mime_type=primitives.get("file", {}).get("mimeType", ""),
            created_at=str(primitives.get("createdDateTime", "")),
            modified_at=str(primitives.get("lastModifiedDateTime", "")),
            web_url=str(primitives.get("webUrl", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "name": self.name,
            "path": self.path,
            "size": self.size,
            "is_folder": self.is_folder,
            "mime_type": self.mime_type,
            "created_at": self.created_at,
            "modified_at": self.modified_at,
            "web_url": self.web_url,
        }
