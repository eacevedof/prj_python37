from dataclasses import dataclass, field
from typing import Self, Any

from ddd.emt.application.get_lines_info.line_item_dto import LineItemDto


@dataclass(frozen=True, slots=True)
class GetLinesInfoResultDto:
    """Output DTO containing bus lines information."""

    lines: list[LineItemDto] = field(default_factory=list)
    total: int = 0

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        data = primitives.get("data", [])
        lines = [LineItemDto.from_primitives(line) for line in data]

        return cls(
            lines=lines,
            total=len(lines),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "lines": [line.to_dict() for line in self.lines],
            "total": self.total,
        }
