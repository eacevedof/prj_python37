from enum import Enum
from typing import final


@final
class RelationTypeEnum(str, Enum):
    """Tipos de relaciones entre palabras."""

    SYNONYM = "SYNONYM"
    ANTONYM = "ANTONYM"
    RELATED = "RELATED"
    CONJUGATION = "CONJUGATION"
