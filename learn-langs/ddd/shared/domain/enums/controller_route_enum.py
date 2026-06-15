"""Enumerado de rutas de navegacion de la aplicacion."""

from enum import StrEnum
from typing import final


@final
class ControllerRouteEnum(StrEnum):
    """Rutas de vistas disponibles en la aplicacion."""

    HOME = "home"
    STUDY = "study"
    IMAGE_STUDY = "image_study"
    WORDS = "words"
    WORD_GROUPS = "word_groups"
    CREATE_WORD = "create_word"
    UPDATE_WORD = "update_word"
