from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class ListMessagesDto:
    """Input DTO for listing messages in a mailbox."""

    mailbox: str
    folder: str | None = None
    top: int = 25
    unread_only: bool = False
    search: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        folder = primitives.get("folder")
        if folder is not None:
            folder = str(folder).strip() or None

        search = primitives.get("search")
        if search is not None:
            search = str(search).strip() or None

        return cls(
            mailbox=str(primitives.get("mailbox", "")).strip(),
            folder=folder,
            top=int(primitives.get("top", 25)),
            unread_only=bool(primitives.get("unread_only", False)),
            search=search,
        )
