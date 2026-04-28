from typing import final, Self, Any
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class AdminLocMysqlResultDto:
    """Result DTO for local MySQL administration operations."""

    action: str
    success: bool
    message: str
    data: list[dict[str, Any]]
    row_count: int

    @classmethod
    def from_primitives(cls, data: dict[str, Any]) -> Self:
        return cls(
            action=str(data.get("action", "")),
            success=bool(data.get("success", False)),
            message=str(data.get("message", "")),
            data=data.get("data", []),
            row_count=int(data.get("row_count", 0)),
        )
