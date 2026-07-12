from enum import Enum
from typing import final


@final
class SliderSequenceEnum(int, Enum):
    """Cadencia de la secuencia de audio del Aprendizaje (slider), por palabra.

    8 ciclos español -> idioma destino: tras el primer español la espera es
    larga (asimilar la palabra); en el resto de ciclos las esperas son cortas;
    tras el último idioma destino, espera larga mostrando los ejemplos.
    """

    PAIR_REPETITIONS = 8  # ciclos español -> idioma destino por palabra
    FIRST_ES_WAIT_SECONDS = 15  # tras el primer español (arranque de la palabra)
    ES_TO_LANG_WAIT_SECONDS = 5  # tras el español, antes del idioma destino
    LANG_TO_ES_WAIT_SECONDS = 3  # tras el idioma destino, antes de volver al español
    NEXT_WORD_WAIT_SECONDS = 20  # tras el último ciclo (mostrando ejemplos si hay)
