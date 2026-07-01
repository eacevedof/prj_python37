from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ListAttachmentsResultDto:
    """Output DTO containing a flattened list of message attachments."""

    attachments: list[dict[str, Any]] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        attachments_primitives = primitives.get("attachments", [])
        attachments = [
            cls._to_attachment(attachment) for attachment in attachments_primitives
        ]
        return cls(
            attachments=attachments,
            total=int(primitives.get("total", len(attachments))),
        )

    @staticmethod
    def _to_attachment(primitives: dict[str, Any]) -> dict[str, Any]:
        return {
            "id": str(primitives.get("id", "")),
            "name": str(primitives.get("name", "")),
            "content_type": str(primitives.get("contentType", "")),
            "size": int(primitives.get("size", 0)),
        }

    def to_dict(self) -> dict[str, Any]:
        return {
            "attachments": self.attachments,
            "total": self.total,
        }
