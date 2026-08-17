from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.lists_mod.domain.enums.list_field_enum import ListFieldEnum


@final
@dataclass(frozen=True, slots=True)
class SearchListsDto:
    """Entrada del caso de uso SearchLists (filtros del listado).

    Un caso de uso de busqueda tambien tiene DTO de entrada, aunque los filtros
    sean opcionales. Es lo que evita que manana alguien anada un filtro leyendo
    directamente de la peticion dentro del service.
    """

    name_contains: str

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        # Vacio = sin filtro. El repositorio lo traduce a un LIKE '%%', que casa
        # con todo, de forma que hay una sola consulta y no dos caminos.
        return cls(name_contains=str(primitives.get(ListFieldEnum.NAME_CONTAINS, "")).strip())
