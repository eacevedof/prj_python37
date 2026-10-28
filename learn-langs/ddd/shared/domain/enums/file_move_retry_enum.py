"""Política de reintentos al mover/borrar ficheros con lock transitorio (Windows)."""

from enum import Enum


class FileMoveRetryEnum(Enum):
    """Cuántas veces se reintenta y cuánto se espera entre intentos."""

    RETRIES = 5
    BACKOFF_SECONDS = 0.15
