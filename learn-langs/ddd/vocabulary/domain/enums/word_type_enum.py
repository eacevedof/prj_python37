from enum import Enum
from typing import final


@final
class WordTypeEnum(str, Enum):
    """Tipos de palabras/textos."""

    WORD = "WORD"
    PHRASE = "PHRASE"
    SENTENCE = "SENTENCE"

    @classmethod
    def coerce(cls, value: object) -> "WordTypeEnum":
        """Miembro correspondiente a `value` (normalizado a mayúsculas), o WORD.

        Alternativa SIN try/except a WordTypeEnum(value) para normalizar primitivos
        de datos legados/externos. No sustituye a WordTypeEnum(value): la validación
        estricta de los DTO sigue usando el constructor para detectar valores inválidos.
        """
        normalized = str(value or "").upper()
        for member in cls:
            if member.value == normalized:
                return member
        return cls.WORD
