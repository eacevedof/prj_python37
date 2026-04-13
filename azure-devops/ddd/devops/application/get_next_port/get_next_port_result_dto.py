from typing import final, Self
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class GetNextPortResultDto:
    """Result DTO for get next port operation."""

    port: int

    @classmethod
    def from_primitives(cls, data: dict) -> Self:
        return cls(
            port=data["port"],
        )
