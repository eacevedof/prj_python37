from enum import Enum
from typing import final


@final
class RelationTypeEnum(str, Enum):
    """Tipos de relaciones entre palabras."""

    SYNONYM = "SYNONYM"
    ANTONYM = "ANTONYM"
    RELATED = "RELATED"
    CONJUGATION = "CONJUGATION"
    EXAMPLE = "EXAMPLE"  # frase de ejemplo de una palabra madre (a=madre, b=frase)
