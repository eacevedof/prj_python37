from dataclasses import dataclass
from typing import Any, Self, final

from src.modules.lists_mod.domain.enums.list_field_enum import ListFieldEnum
from src.modules.lists_mod.domain.enums.list_limit_enum import ListLimitEnum


@final
@dataclass(frozen=True, slots=True)
class CreateListDto:
    """Entrada del caso de uso CreateList.

    `from_primitives` recibe el diccionario crudo que llego por HTTP y lo convierte
    a tipos de Python. Solo eso: **convertir, no validar**.

    La diferencia importa. Convertir es "esto venia como texto y es un numero".
    Validar es "un nombre vacio no vale", que es una regla de negocio y va en el
    service. Si validaras aqui, la regla quedaria escondida en un constructor y no
    podrias probarla sin construir un DTO.

    Fijate en `str(primitives.get(..., "")).strip()`: lo que llega por HTTP puede
    ser None, un numero o texto con espacios. La conversion lo deja siempre en una
    cadena limpia, y asi el service compara contra algo predecible.
    """

    name: str
    color: str | None
    position: int

    @classmethod
    def from_primitives(cls, primitives: dict[str, Any]) -> Self:
        color = str(primitives.get(ListFieldEnum.COLOR, "")).strip()
        return cls(
            name=str(primitives.get(ListFieldEnum.NAME, "")).strip(),
            # Cadena vacia -> None: en la base "sin color" es NULL, no "".
            color=color or None,
            position=int(primitives.get(ListFieldEnum.POSITION, ListLimitEnum.DEFAULT_POSITION) or 0),
        )
