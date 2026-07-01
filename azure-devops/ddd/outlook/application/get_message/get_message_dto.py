from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetMessageDto:
    """Input DTO for retrieving a single mailbox message."""

    mailbox: str
    message_id: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            mailbox=str(primitives.get("mailbox", "")).strip(),
            message_id=str(primitives.get("message_id", "")).strip(),
        )
