from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class RequestAnubisDto:
    """Input DTO for Anubis SQL query execution."""

    sql: str
    confirmed: bool

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            sql=str(primitives.get("sql", "")).strip(),
            confirmed=bool(primitives.get("confirmed", False)),
        )
