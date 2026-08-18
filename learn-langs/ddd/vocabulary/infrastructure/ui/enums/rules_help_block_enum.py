"""Tipos de bloque en que se descompone la ayuda (`rules_help`) al pasarla a markdown."""

from enum import Enum


class RulesHelpBlockEnum(str, Enum):
    """Bloque markdown resultante de una línea de la ayuda.

    El tipo decide dónde hacen falta líneas en blanco al volver a unir el texto:
    markdown se «come» el párrafo que sigue a una lista si no van separados.
    """

    BLANK = "blank"
    HEADING = "heading"
    ITEM = "item"
    PARAGRAPH = "paragraph"
    QUOTE = "quote"
