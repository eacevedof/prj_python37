"""Output DTO con datos del home."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class TagItemDto:
    """DTO para un tag."""

    id: int
    name: str
    color: str = "#6B7280"

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            name=str(primitives.get("name", "")),
            color=str(primitives.get("color", "#6B7280") or "#6B7280"),
        )


@dataclass(frozen=True, slots=True)
class StatsDto:
    """DTO para estadísticas."""

    total_words: int = 0
    due_for_review: int = 0
    avg_score: float = 0.0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            total_words=int(primitives.get("total_words", 0) or 0),
            due_for_review=int(primitives.get("due_for_review", 0) or 0),
            avg_score=float(primitives.get("avg_score", 0.0) or 0.0),
        )


@dataclass(frozen=True, slots=True)
class LoadHomeResultDto:
    """Output DTO con todos los datos del home."""

    success: bool
    tags: list[TagItemDto] = field(default_factory=list)
    stats: StatsDto = field(default_factory=StatsDto)
    error_message: str | None = None

    @classmethod
    def ok(cls, tags: list[TagItemDto], stats: StatsDto) -> Self:
        """Crea un DTO de éxito."""
        return cls(success=True, tags=tags, stats=stats)

    @classmethod
    def error(cls, message: str) -> Self:
        """Crea un DTO de error."""
        return cls(success=False, error_message=message)
