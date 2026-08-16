"""Origen del audio devuelto por los casos de uso de generación TTS."""

from enum import Enum


class AudioSourceEnum(str, Enum):
    """Marca con qué se resolvió la petición de audio (caché local o modelo)."""

    CACHED = "cached"
