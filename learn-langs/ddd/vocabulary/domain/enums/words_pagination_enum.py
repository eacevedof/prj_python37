"""Tamaños por defecto de la paginación del listado de palabras."""

from enum import IntEnum


class WordsPaginationEnum(IntEnum):
    """Cuántas palabras se piden/pintan por página."""

    PAGE_SIZE = 100
    DEFAULT_LIMIT = 100
