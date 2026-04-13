import base64
from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DownloadFileResultDto:
    """Output DTO containing downloaded file content."""

    file_path: str
    content_base64: str
    size: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        content = primitives.get("content", b"")
        if isinstance(content, bytes):
            content_base64 = base64.b64encode(content).decode("utf-8")
            size = len(content)
        else:
            content_base64 = str(content)
            size = len(content_base64)

        return cls(
            file_path=str(primitives.get("file_path", "")),
            content_base64=content_base64,
            size=size,
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "file_path": self.file_path,
            "content_base64": self.content_base64,
            "size": self.size,
        }

    def get_content_bytes(self) -> bytes:
        """Decode base64 content to bytes."""
        return base64.b64decode(self.content_base64)
