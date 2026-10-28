from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.lists_mod.domain.enums.list_field_enum import ListFieldEnum
from src.modules.lists_mod.domain.enums.list_limit_enum import ListLimitEnum


@final
@dataclass(frozen=True, slots=True)
class UpdateListDto:
    """Entrada del caso de uso UpdateList.

    Es un reemplazo completo (PUT): el cliente manda como debe quedar la lista, no
    solo lo que cambia. Es mas simple de razonar que un parcial, y para un PoC casi
    siempre es suficiente.
    """

    list_id: int
    name: str
    color: str | None
    position: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        color = str(primitives.get(ListFieldEnum.COLOR, "")).strip()
        return cls(
            list_id=int(primitives.get(ListFieldEnum.LIST_ID, 0) or 0),
            name=str(primitives.get(ListFieldEnum.NAME, "")).strip(),
            color=color or None,
            position=int(primitives.get(ListFieldEnum.POSITION, ListLimitEnum.DEFAULT_POSITION) or 0),
        )
