from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.lists_mod.domain.enums.list_field_enum import ListFieldEnum


@final
@dataclass(frozen=True, slots=True)
class UpdateListResultDto:
    """Salida del caso de uso UpdateList: la lista como ha quedado."""

    list_id: int
    name: str
    color: str | None
    position: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            list_id=int(primitives.get(ListFieldEnum.ID, 0)),
            name=str(primitives.get(ListFieldEnum.NAME, "")),
            color=primitives.get(ListFieldEnum.COLOR),
            position=int(primitives.get(ListFieldEnum.POSITION, 0)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            ListFieldEnum.ID: self.list_id,
            ListFieldEnum.NAME: self.name,
            ListFieldEnum.COLOR: self.color,
            ListFieldEnum.POSITION: self.position,
        }
