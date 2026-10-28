from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetMessageResultDto:
    """Output DTO containing a single message with a plain-text body."""

    id: str = ""
    subject: str = ""
    from_address: str = ""
    to: list[str] = field(default_factory=list)
    received: str = ""
    has_attachments: bool = False
    body_text: str = ""

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=str(primitives.get("id", "")),
            subject=str(primitives.get("subject", "")),
            from_address=str(primitives.get("from", "")),
            to=[str(address) for address in primitives.get("to", [])],
            received=str(primitives.get("received", "")),
            has_attachments=bool(primitives.get("has_attachments", False)),
            body_text=str(primitives.get("body_text", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "subject": self.subject,
            "from": self.from_address,
            "to": self.to,
            "received": self.received,
            "has_attachments": self.has_attachments,
            "body_text": self.body_text,
        }
