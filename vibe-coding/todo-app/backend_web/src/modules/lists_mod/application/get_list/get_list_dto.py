from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.lists_mod.domain.enums.list_field_enum import ListFieldEnum


@final
@dataclass(frozen=True, slots=True)
class GetListDto:
    """Entrada del caso de uso GetList."""

    list_id: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        # El `or 0` cubre el caso de que llegue None o cadena vacia: int(None)
        # reventaria con TypeError, y ese error no diria nada util. Con 0, el
        # service devuelve un 400 con un mensaje claro.
        return cls(list_id=int(primitives.get(ListFieldEnum.LIST_ID, 0) or 0))
