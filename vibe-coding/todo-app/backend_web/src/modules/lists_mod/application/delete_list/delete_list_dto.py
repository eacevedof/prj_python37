from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.lists_mod.domain.enums.list_field_enum import ListFieldEnum


@final
@dataclass(frozen=True, slots=True)
class DeleteListDto:
    """Entrada del caso de uso DeleteList."""

    list_id: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(list_id=int(primitives.get(ListFieldEnum.LIST_ID, 0) or 0))
