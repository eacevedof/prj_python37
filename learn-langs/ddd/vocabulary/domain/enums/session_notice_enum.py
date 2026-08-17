"""Avisos hablados que cierran una sesión de aprendizaje."""

from enum import Enum


class SessionNoticeEnum(str, Enum):
    """Aviso de fin de sesión: clave de caché del mp3 + texto que se pronuncia.

    La clave nombra el fichero (`notice-<clave>-<acento>.mp3`), así que cambiar
    el texto sin cambiar la clave NO regenera el audio ya cacheado.
    """

    END_OF_SESSION_KEY = "end-of-session"
    END_OF_SESSION_TEXT = "Fin de la sesión de aprendizaje"
