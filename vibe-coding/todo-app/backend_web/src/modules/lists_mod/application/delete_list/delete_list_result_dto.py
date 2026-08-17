from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.lists_mod.domain.enums.list_field_enum import ListFieldEnum


@final
@dataclass(frozen=True, slots=True)
class DeleteListResultDto:
    """Salida del caso de uso DeleteList.

    Un borrado tambien devuelve un ResultDto, aunque solo lleve el id. Devolver
    `None` o un diccionario suelto romperia la regla de que todo caso de uso
    devuelve un DTO, y esa regularidad es justo lo que hace el codigo predecible.
    """

    list_id: int
    is_deleted: bool

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        return cls(
            list_id=int(primitives.get(ListFieldEnum.ID, 0)),
            is_deleted=bool(primitives.get(ListFieldEnum.IS_DELETED, False)),
        )

    def to_dict(self) -> dict[str, Any]:
        return {
            ListFieldEnum.ID: self.list_id,
            ListFieldEnum.IS_DELETED: self.is_deleted,
        }
