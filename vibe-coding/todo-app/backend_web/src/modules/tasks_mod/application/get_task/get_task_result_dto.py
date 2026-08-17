from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.tasks_mod.domain.enums.task_done_enum import TaskDoneEnum
from src.modules.tasks_mod.domain.enums.task_field_enum import TaskFieldEnum


@final
@dataclass(frozen=True, slots=True)
class GetTaskResultDto:
    """Salida del caso de uso GetTask."""

    task_id: int
    id_list: int
    title: str
    description: str | None
    is_done: bool
    due_date: str | None
    position: int
    insert_date: str
    update_date: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            task_id=int(primitives.get(TaskFieldEnum.ID, 0)),
            id_list=int(primitives.get(TaskFieldEnum.ID_LIST, 0)),
            title=str(primitives.get(TaskFieldEnum.TITLE, "")),
            description=primitives.get(TaskFieldEnum.DESCRIPTION),
            is_done=int(primitives.get(TaskFieldEnum.IS_DONE, TaskDoneEnum.PENDING)) == TaskDoneEnum.DONE,
            due_date=primitives.get(TaskFieldEnum.DUE_DATE),
            position=int(primitives.get(TaskFieldEnum.POSITION, 0)),
            insert_date=str(primitives.get(TaskFieldEnum.INSERT_DATE, "")),
            update_date=str(primitives.get(TaskFieldEnum.UPDATE_DATE, "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            TaskFieldEnum.ID: self.task_id,
            TaskFieldEnum.ID_LIST: self.id_list,
            TaskFieldEnum.TITLE: self.title,
            TaskFieldEnum.DESCRIPTION: self.description,
            TaskFieldEnum.IS_DONE: self.is_done,
            TaskFieldEnum.DUE_DATE: self.due_date,
            TaskFieldEnum.POSITION: self.position,
            TaskFieldEnum.INSERT_DATE: self.insert_date,
            TaskFieldEnum.UPDATE_DATE: self.update_date,
        }
