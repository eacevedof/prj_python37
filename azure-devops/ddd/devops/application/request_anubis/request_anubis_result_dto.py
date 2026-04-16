from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class RequestAnubisResultDto:
    """Result DTO for Anubis query execution."""

    result: list[dict[str, Any]]
    row_count: int
    status_code: int
    requires_confirmation: bool
    query: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        result = primitives.get("result", [])
        return cls(
            result=result,
            row_count=len(result),
            status_code=int(primitives.get("status_code", 0)),
            requires_confirmation=bool(primitives.get("requires_confirmation", False)),
            query=str(primitives.get("query", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "result": self.result,
            "rowCount": self.row_count,
            "statusCode": self.status_code,
            "requiresConfirmation": self.requires_confirmation,
            "query": self.query,
        }
