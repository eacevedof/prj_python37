"""Enumerado de tamaños (px) de la tarjeta del slider."""

from enum import IntEnum


class SliderCardSizeEnum(IntEnum):
    """Tamaños en píxeles de la tarjeta del slider (lectura a ~5 metros, modo kiosko)."""

    PHASE = 30
    WORD = 90
    TRANSLATION = 84
    PRONUNCIATION = 34
    EXAMPLES = 22  # frase de ejemplo en neerlandés (negrita; 5 ejemplos por tarjeta)
    EXAMPLES_TRANSLATION = 15  # traducción española del ejemplo (gris, pegada debajo)
    EXAMPLES_TAG = 12  # número + tipo de frase (can./inv./perf./vraag/bijzin...)
    IMAGE = 340  # lado de la imagen (cuadrada, fit=CONTAIN)
