from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class CreateEpicResultDto:
    id: int
    title: str
    url: str
    project: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            title=str(primitives.get("title", "")).strip(),
            url=str(primitives.get("url", "")).strip(),
            project=str(primitives.get("project", "")).strip(),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "title": self.title,
            "url": self.url,
            "project": self.project,
        }
