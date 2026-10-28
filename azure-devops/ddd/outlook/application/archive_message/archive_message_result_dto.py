from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ArchiveMessageResultDto:
    """Output DTO with the archived message folder and its saved files."""

    subject: str = ""
    from_address: str = ""
    received: str = ""
    folder_path: str = ""
    email_file_path: str = ""
    attachments: list[dict[str, Any]] = field(default_factory=list)
    total_attachments: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            subject=str(primitives.get("subject", "")),
            from_address=str(primitives.get("from", "")),
            received=str(primitives.get("received", "")),
            folder_path=str(primitives.get("folder_path", "")),
            email_file_path=str(primitives.get("email_file_path", "")),
            attachments=list(primitives.get("attachments", [])),
            total_attachments=int(primitives.get("total_attachments", 0)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "subject": self.subject,
            "from": self.from_address,
            "received": self.received,
            "folder_path": self.folder_path,
            "email_file_path": self.email_file_path,
            "attachments": self.attachments,
            "total_attachments": self.total_attachments,
        }
