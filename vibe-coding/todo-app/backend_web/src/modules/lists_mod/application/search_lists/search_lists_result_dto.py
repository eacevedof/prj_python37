from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.lists_mod.domain.enums.list_field_enum import ListFieldEnum


@final
@dataclass(frozen=True, slots=True)
class SearchListsResultDto:
    """Salida del caso de uso SearchLists.

    Devuelve `items` + `total` y no una lista pelada, a proposito: un listado casi
    siempre acaba necesitando un total, y si hoy devuelves un array y manana
    necesitas paginar, tienes que cambiar el contrato y romper al front. Con esta
    forma, anadir `page` y `page_size` no rompe nada.

    Los elementos son diccionarios de primitivos y no DTOs anidados. Regla del
    proyecto: **un DTO no contiene otros DTOs**. Anidarlos obliga a construir y
    deconstruir objetos en cada capa sin ganar nada.
    """

    items: list[dict[str, Any]]
    total: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        items = list(primitives.get(ListFieldEnum.ITEMS, []))
        return cls(items=items, total=len(items))

    def to_dict(self) -> dict[str, Any]:
        return {
            ListFieldEnum.ITEMS: self.items,
            ListFieldEnum.TOTAL: self.total,
        }
