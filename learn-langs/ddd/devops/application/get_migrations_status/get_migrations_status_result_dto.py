from dataclasses import dataclass, field
from typing import Any, Self


@dataclass(frozen=True, slots=True)
class GetMigrationsStatusResultDto:
    """Estado de las migraciones: aplicadas y pendientes."""

    applied: tuple[str, ...] = field(default_factory=tuple)
    pending: tuple[str, ...] = field(default_factory=tuple)

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            applied=tuple(primitives.get("applied", [])),
            pending=tuple(primitives.get("pending", [])),
        )
