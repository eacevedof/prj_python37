"""Output DTO con datos del home."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class LoadHomeResultDto:
    """Output DTO con todos los datos del home."""

    tags: tuple[dict[str, Any], ...] = field(default_factory=tuple)
    stats: dict[str, Any] = field(default_factory=dict)
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        tags_raw = primitives.get("tags", []) or []
        stats_raw = primitives.get("stats", {}) or {}
        return cls(
            tags=tuple(tags_raw),
            stats=stats_raw,
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def error(cls, message: str) -> Self:
        return cls.from_primitives({"error_message": message})

    @property
    def success(self) -> bool:
        return self.error_message is None
