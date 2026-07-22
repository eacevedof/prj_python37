from enum import Enum
from typing import final


@final
class ImageStudySequenceEnum(int, Enum):
    """Cadencia del examen con imágenes, por palabra.

    Alineada con el aprendizaje (slider): el tiempo para contestar UNA palabra
    corta se reutiliza de SliderSequenceEnum.FIRST_ES_WAIT_SECONDS (10s); aquí se
    define el tiempo extra para frases y las esperas de revisión tras responder.
    """

    MULTI_WORD_ANSWER_TIMER_SECONDS = 20  # frases (>2 palabras): más tiempo para teclear
    WRONG_REVIEW_WAIT_SECONDS = 4  # tras fallar: se oye el NL y da tiempo a ver la corrección
    CORRECT_REVIEW_WAIT_SECONDS = 1  # tras acertar: breve confirmación antes de la siguiente
