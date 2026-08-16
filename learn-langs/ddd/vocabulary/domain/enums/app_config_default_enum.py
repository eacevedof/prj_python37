"""Valores por defecto de la configuración de la app (si no hay variable de entorno)."""

from enum import Enum


class AppConfigDefaultEnum(Enum):
    """Defaults de título y geometría de la ventana."""

    APP_TITLE = "Learn Languages"
    WINDOW_WIDTH = 900
    WINDOW_HEIGHT = 950
    WINDOW_MIN_WIDTH = 800
    WINDOW_MIN_HEIGHT = 950
