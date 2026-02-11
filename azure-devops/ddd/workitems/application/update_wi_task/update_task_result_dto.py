from dataclasses import dataclass
from typing import Self, Any


@dataclass(frozen=True, slots=True)
class UpdateTaskResultDto:
    id: int
    title: str
    state: str
    url: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            id=int(primitives.get("id", 0)),
            title=str(primitives.get("title", "")).strip(),
            state=str(primitives.get("state", "")).strip(),
            url=str(primitives.get("url", "")).strip(),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            "id": self.id,
            "title": self.title,
            "state": self.state,
            "url": self.url,
        }
