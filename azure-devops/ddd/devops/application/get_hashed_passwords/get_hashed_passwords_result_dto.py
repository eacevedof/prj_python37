from dataclasses import dataclass, field
from typing import Self, Any

from ddd.devops.application.get_hashed_passwords.hashed_password_item_dto import (
    HashedPasswordItemDto,
)


@dataclass(frozen=True, slots=True)
class GetHashedPasswordsResultDto:
    """Output DTO containing list of hashed passwords."""

    items: list[HashedPasswordItemDto] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        items_primitives = primitives.get("items", [])
        items = [
            HashedPasswordItemDto.from_primitives(item) for item in items_primitives
        ]
        return cls(
            items=items,
            total=int(primitives.get("total", len(items))),
        )

    def to_list(self) -> list[dict[str, Any]]:
        return [item.to_dict() for item in self.items]
