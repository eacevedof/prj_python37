from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.tasks_mod.domain.enums.task_field_enum import TaskFieldEnum


@final
@dataclass(frozen=True, slots=True)
class DeleteTaskDto:
    """Entrada del caso de uso DeleteTask."""

    task_id: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(task_id=int(primitives.get(TaskFieldEnum.TASK_ID, 0) or 0))
