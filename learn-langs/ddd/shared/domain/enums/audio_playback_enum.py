"""Cadencias de la reproducción de audio."""

from enum import Enum


class AudioPlaybackEnum(float, Enum):
    """Cada cuánto se comprueba el estado del reproductor mientras suena."""

    POLL_SECONDS = 0.05
