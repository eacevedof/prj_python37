from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.tasks_mod.domain.enums.task_field_enum import TaskFieldEnum


@final
@dataclass(frozen=True, slots=True)
class SetTaskDoneResultDto:
    """Salida del caso de uso SetTaskDone."""

    task_id: int
    is_done: bool

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            task_id=int(primitives.get(TaskFieldEnum.ID, 0)),
            is_done=bool(primitives.get(TaskFieldEnum.IS_DONE, False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            TaskFieldEnum.ID: self.task_id,
            TaskFieldEnum.IS_DONE: self.is_done,
        }
