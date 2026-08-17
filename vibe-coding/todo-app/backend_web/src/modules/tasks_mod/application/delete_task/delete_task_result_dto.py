from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.tasks_mod.domain.enums.task_field_enum import TaskFieldEnum


@final
@dataclass(frozen=True, slots=True)
class DeleteTaskResultDto:
    """Salida del caso de uso DeleteTask."""

    task_id: int
    is_deleted: bool

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            task_id=int(primitives.get(TaskFieldEnum.ID, 0)),
            is_deleted=bool(primitives.get(TaskFieldEnum.IS_DELETED, False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            TaskFieldEnum.ID: self.task_id,
            TaskFieldEnum.IS_DELETED: self.is_deleted,
        }
