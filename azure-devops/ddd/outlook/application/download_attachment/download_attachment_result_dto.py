from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DownloadAttachmentResultDto:
    """Output DTO with the metadata of an attachment saved to disk."""

    name: str = ""
    content_type: str = ""
    size: int = 0
    saved_path: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            name=str(primitives.get("name", "")),
            content_type=str(primitives.get("content_type", "")),
            size=int(primitives.get("size", 0)),
            saved_path=str(primitives.get("saved_path", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "name": self.name,
            "content_type": self.content_type,
            "size": self.size,
            "saved_path": self.saved_path,
        }
