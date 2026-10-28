from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.tasks_mod.domain.enums.task_field_enum import TaskFieldEnum


@final
@dataclass(frozen=True, slots=True)
class SearchTasksResultDto:
    """Salida del caso de uso SearchTasks."""

    items: list[dict[str, Any]]
    total: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        items = list(primitives.get(TaskFieldEnum.ITEMS, []))
        return cls(items=items, total=len(items))

    def to_dict(self) -> dict[str, Any]:
        return {
            TaskFieldEnum.ITEMS: self.items,
            TaskFieldEnum.TOTAL: self.total,
        }
