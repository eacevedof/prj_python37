"""Enumerado de rutas de navegacion de la aplicacion."""

from enum import StrEnum


class ControllerRouteEnum(StrEnum):
    """Rutas de vistas disponibles en la aplicacion."""

    HOME = "home"
    STUDY = "study"
    WORDS = "words"
    CREATE_WORD = "create_word"
    UPDATE_WORD = "update_word"
