"""DTO de resultado para GetTagsService."""

from dataclasses import dataclass, field
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class TagDto:
    """DTO para un tag."""

    id: int = 0
    name: str = ""
    color: str = "#6B7280"

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            name=str(primitives.get("name", "")),
            color=str(primitives.get("color", "#6B7280")),
        )


@dataclass(frozen=True, slots=True)
class GetTagsResultDto:
    """DTO de resultado con los tags."""

    tags: tuple[TagDto, ...] = field(default_factory=tuple)
    error_message: str | None = None

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        tags_raw = primitives.get("tags", []) or []
        tags = tuple(
            t if isinstance(t, TagDto) else TagDto.from_primitives(t)
            for t in tags_raw
        )
        return cls(
            tags=tags,
            error_message=primitives.get("error_message"),
        )

    @classmethod
    def ok(cls, tags: list[TagDto]) -> Self:
        return cls.from_primitives({"tags": tags})

    @classmethod
    def error(cls, message: str) -> Self:
        return cls.from_primitives({"error_message": message})

    @property
    def success(self) -> bool:
        return self.error_message is None

    def to_list_of_dicts(self) -> list[dict[str, Any]]:
        """Convierte tags a lista de dicts para la vista."""
        return [{"id": t.id, "name": t.name, "color": t.color} for t in self.tags]
