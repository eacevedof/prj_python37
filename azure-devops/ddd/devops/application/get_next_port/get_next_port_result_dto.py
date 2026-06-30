from typing import final, Self, Any
from dataclasses import dataclass


@final
@dataclass(frozen=True, slots=True)
class GetNextPortResultDto:
    """Result DTO for get next port operation."""

    port: int

    @classmethod
    def from_primitives(cls, data: dict) -> Self:
        return cls(
            port=data["port"],
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "port": self.port,
        }
