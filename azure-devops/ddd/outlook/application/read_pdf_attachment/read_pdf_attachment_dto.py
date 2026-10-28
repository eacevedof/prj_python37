from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ReadPdfAttachmentDto:
    """Input DTO for reading the text of a PDF attachment of a message."""

    mailbox: str
    message_id: str
    attachment_id: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            mailbox=str(primitives.get("mailbox", "")).strip(),
            message_id=str(primitives.get("message_id", "")).strip(),
            attachment_id=str(primitives.get("attachment_id", "")).strip(),
        )
