"""Enumerado de tamaños (px) del modal de ayuda (reglas de uso)."""

from enum import IntEnum


class RulesHelpSizeEnum(IntEnum):
    """Tamaños del modal y de su tipografía markdown.

    El modal ocupa casi toda la pantalla (SCREEN_PERCENT) porque la ayuda de una
    tarjeta puede pasar de las 100 líneas y en una caja pequeña obliga a hacer
    scroll a ciegas.
    """

    SCREEN_PERCENT = 95
    CHROME_HEIGHT = 170  # título + botonera + paddings del AlertDialog
    FALLBACK_WIDTH = 900  # si la página aún no reporta tamaño (no montada)
    FALLBACK_HEIGHT = 600
    MIN_WIDTH = 320
    MIN_HEIGHT = 240

    CLOSE_ICON = 28  # aspa de cerrar, arriba a la derecha
    TITLE = 22  # la palabra en español
    LANG_TEXT = 17  # la traducción («NL: ...»), en negrita y algo menor
    WORD_ID = 18  # «#598», para saber en qué tarjeta estás
    SUBTITLE = 13
    TEXT = 17
    HEADING = 21
    SUBHEADING = 18
    CODE = 15
