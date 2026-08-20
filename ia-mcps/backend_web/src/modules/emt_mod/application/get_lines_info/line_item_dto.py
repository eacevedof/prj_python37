from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class LineItemDto:
    """DTO representing a bus line."""

    line: str
    label: str
    name_a: str
    name_b: str
    group: str
    start_date: str
    end_date: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            line=str(primitives.get("line", "")),
            label=str(primitives.get("label", "")),
            name_a=str(primitives.get("nameA", "")),
            name_b=str(primitives.get("nameB", "")),
            group=str(primitives.get("group", "")),
            start_date=str(primitives.get("startDate", "")),
            end_date=str(primitives.get("endDate", "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "line": self.line,
            "label": self.label,
            "name_a": self.name_a,
            "name_b": self.name_b,
            "group": self.group,
            "start_date": self.start_date,
            "end_date": self.end_date,
        }
