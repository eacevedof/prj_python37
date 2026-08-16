from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ReadPdfAttachmentResultDto:
    """Output DTO containing a PDF attachment's metadata and extracted text."""

    name: str = ""
    content_type: str = ""
    size: int = 0
    text: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            name=str(primitives.get("name", "")),
            content_type=str(primitives.get("content_type", "")),
            size=int(primitives.get("size", 0)),
            text=str(primitives.get("text", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "name": self.name,
            "content_type": self.content_type,
            "size": self.size,
            "text": self.text,
        }
