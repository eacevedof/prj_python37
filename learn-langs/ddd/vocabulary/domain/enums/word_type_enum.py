from enum import Enum
from typing import final


@final
class WordTypeEnum(str, Enum):
    """Tipos de palabras/textos."""

    WORD = "WORD"
    PHRASE = "PHRASE"
    SENTENCE = "SENTENCE"
