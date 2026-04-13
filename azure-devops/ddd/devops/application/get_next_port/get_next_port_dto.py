from typing import final, Self, Any
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class GetNextPortDto:
    """DTO for getting next available port."""

    @classmethod
    def from_primitives(cls, data: dict[str, Any]) -> Self:
        return cls()
