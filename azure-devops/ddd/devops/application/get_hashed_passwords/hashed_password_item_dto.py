from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class HashedPasswordItemDto:
    """DTO representing a single hashed password result."""

    password: str
    hashed_password: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            password=str(primitives.get("password", "")),
            hashed_password=str(primitives.get("hashed_password", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "password": self.password,
            "hashedPassword": self.hashed_password,
        }
