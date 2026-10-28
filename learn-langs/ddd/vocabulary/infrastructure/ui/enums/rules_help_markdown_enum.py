"""Enumerado de límites al convertir la ayuda (`rules_help`) a markdown."""

from enum import IntEnum


class RulesHelpMarkdownEnum(IntEnum):
    """Umbrales que deciden si una línea es encabezado o párrafo."""

    HEADING_MAX_LENGTH = 90  # más largo que esto ya no es un rótulo, es un párrafo
    LABEL_MAX_WORDS = 4  # «Truco mental:» sí, una frase entera con dos puntos no
