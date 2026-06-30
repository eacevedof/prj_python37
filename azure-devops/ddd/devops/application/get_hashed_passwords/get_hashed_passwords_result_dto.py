from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class GetHashedPasswordsResultDto:
    """Output DTO containing list of hashed passwords."""

    items: list[dict[str, Any]] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        items = list(primitives.get("items", []))
        return cls(
            items=items,
            total=int(primitives.get("total", len(items))),
        )

    def to_list(self) -> list[dict[str, Any]]:
        return [
            {
                "password": item.get("password", ""),
                "hashedPassword": item.get("hashed_password", ""),
            }
            for item in self.items
        ]

    def to_dict(self) -> dict[str, Any]:
        return {
            "items": self.to_list(),
            "total": self.total,
        }
