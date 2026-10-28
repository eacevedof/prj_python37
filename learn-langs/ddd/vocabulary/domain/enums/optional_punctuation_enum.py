from enum import Enum
from typing import final


@final
class OptionalPunctuationEnum(str, Enum):
    """Puntuación OPCIONAL al comparar respuestas: su presencia/ausencia no
    penaliza (se ignora al normalizar el texto)."""

    COMMA = ","
    SEMICOLON = ";"
    EXCLAMATION = "!"
    QUESTION = "?"
    PERIOD = "."

    @classmethod
    def is_optional(cls, char: str) -> bool:
        """True si el carácter es puntuación opcional (se ignora al comparar)."""
        return any(char == member.value for member in cls)
