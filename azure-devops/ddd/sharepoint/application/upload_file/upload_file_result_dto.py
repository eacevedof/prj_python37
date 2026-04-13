from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class UploadFileResultDto:
    """Output DTO containing uploaded file metadata."""

    id: str
    name: str
    path: str
    size: int
    web_url: str
    created_at: str
    modified_at: str

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
            web_url=str(primitives.get("webUrl", "")),
            created_at=str(primitives.get("createdDateTime", "")),
            modified_at=str(primitives.get("lastModifiedDateTime", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "name": self.name,
            "path": self.path,
            "size": self.size,
            "web_url": self.web_url,
            "created_at": self.created_at,
            "modified_at": self.modified_at,
        }
