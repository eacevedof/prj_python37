from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ListMessagesResultDto:
    """Output DTO containing a flattened list of mailbox messages."""

    messages: list[dict[str, Any]] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        messages_primitives = primitives.get("messages", [])
        messages = [cls._to_message(message) for message in messages_primitives]
        return cls(
            messages=messages,
            total=int(primitives.get("total", len(messages))),
        )

    @staticmethod
    def _to_message(primitives: dict[str, Any]) -> dict[str, Any]:
        from_field = primitives.get("from", {}) or {}
        email_address = from_field.get("emailAddress", {}) or {}
        return {
            "id": str(primitives.get("id", "")),
            "subject": str(primitives.get("subject", "")),
            "from": str(email_address.get("address", "")),
            "received": str(primitives.get("receivedDateTime", "")),
            "is_read": bool(primitives.get("isRead", False)),
            "has_attachments": bool(primitives.get("hasAttachments", False)),
            "preview": str(primitives.get("bodyPreview", "")),
        }

    def to_dict(self) -> dict[str, Any]:
        return {
            "messages": self.messages,
            "total": self.total,
        }
