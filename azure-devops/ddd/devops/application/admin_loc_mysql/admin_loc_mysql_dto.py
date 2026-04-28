from typing import final, Self, Any
from dataclasses import dataclass


@final
@dataclass(frozen=True)
class AdminLocMysqlDto:
    """DTO for local MySQL administration operations."""

    action: str
    database: str
    table: str
    query: str

    @classmethod
    def from_primitives(cls, data: dict[str, Any]) -> Self:
        return cls(
            action=str(data.get("action", "")).strip().lower(),
            database=str(data.get("database", "")).strip(),
            table=str(data.get("table", "")).strip(),
            query=str(data.get("query", "")).strip(),
        )
