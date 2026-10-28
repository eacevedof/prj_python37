from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.lists_mod.domain.enums.list_field_enum import ListFieldEnum


@final
@dataclass(frozen=True, slots=True)
class GetListResultDto:
    """Salida del caso de uso GetList.

    Incluye `open_tasks_count`, que NO sale de la tabla de listas: lo aporta el
    modulo de tareas a traves del puerto TasksCounter. Es el ejemplo vivo de como
    dos modulos colaboran sin conocerse por dentro: este modulo declara QUE
    necesita (un contador) y el otro lo cumple, sin que ninguno importe las
    entranas del otro.
    """

    list_id: int
    name: str
    color: str | None
    position: int
    open_tasks_count: int
    insert_date: str
    update_date: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            list_id=int(primitives.get(ListFieldEnum.ID, 0)),
            name=str(primitives.get(ListFieldEnum.NAME, "")),
            color=primitives.get(ListFieldEnum.COLOR),
            position=int(primitives.get(ListFieldEnum.POSITION, 0)),
            open_tasks_count=int(primitives.get(ListFieldEnum.OPEN_TASKS_COUNT, 0)),
            insert_date=str(primitives.get(ListFieldEnum.INSERT_DATE, "")),
            update_date=str(primitives.get(ListFieldEnum.UPDATE_DATE, "")),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            ListFieldEnum.ID: self.list_id,
            ListFieldEnum.NAME: self.name,
            ListFieldEnum.COLOR: self.color,
            ListFieldEnum.POSITION: self.position,
            ListFieldEnum.OPEN_TASKS_COUNT: self.open_tasks_count,
            ListFieldEnum.INSERT_DATE: self.insert_date,
            ListFieldEnum.UPDATE_DATE: self.update_date,
        }
