"""Enumerado de tamaños (px) de la tarjeta del slider."""

from enum import IntEnum


class SliderCardSizeEnum(IntEnum):
    """Tamaños en píxeles de la tarjeta del slider (lectura a ~5 metros, modo kiosko)."""

    PHASE = 30
    WORD = 90
    TRANSLATION = 84
    PRONUNCIATION = 34
    IMAGE = 340  # lado de la imagen (cuadrada, fit=CONTAIN)
