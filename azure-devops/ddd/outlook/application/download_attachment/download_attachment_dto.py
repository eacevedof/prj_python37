from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class DownloadAttachmentDto:
    """Input DTO for downloading a message attachment to disk."""

    mailbox: str
    message_id: str
    attachment_id: str
    target_dir: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            mailbox=str(primitives.get("mailbox", "")).strip(),
            message_id=str(primitives.get("message_id", "")).strip(),
            attachment_id=str(primitives.get("attachment_id", "")).strip(),
            target_dir=str(primitives.get("target_dir", "")).strip(),
        )
