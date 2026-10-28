from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.tasks_mod.domain.enums.task_field_enum import TaskFieldEnum
from src.modules.tasks_mod.domain.enums.task_limit_enum import TaskLimitEnum


@final
@dataclass(frozen=True, slots=True)
class UpdateTaskDto:
    """Entrada del caso de uso UpdateTask.

    Incluye `id_list`, asi que este caso de uso tambien sirve para MOVER una tarea
    de lista. Por eso vuelve a comprobar que la lista destino existe.
    """

    task_id: int
    id_list: int
    title: str
    description: str | None
    due_date: str | None
    position: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        description = str(primitives.get(TaskFieldEnum.DESCRIPTION, "")).strip()
        due_date = str(primitives.get(TaskFieldEnum.DUE_DATE, "")).strip()
        return cls(
            task_id=int(primitives.get(TaskFieldEnum.TASK_ID, 0) or 0),
            id_list=int(primitives.get(TaskFieldEnum.ID_LIST, 0) or 0),
            title=str(primitives.get(TaskFieldEnum.TITLE, "")).strip(),
            description=description or None,
            due_date=due_date or None,
            position=int(primitives.get(TaskFieldEnum.POSITION, TaskLimitEnum.DEFAULT_POSITION) or 0),
        )
