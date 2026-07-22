from enum import Enum
from typing import final


@final
class ImageStudySequenceEnum(int, Enum):
    """Cadencia del examen con imágenes, por palabra.

    Alineada con el aprendizaje (slider): el tiempo para contestar antes de oír
    el neerlandés se reutiliza de SliderSequenceEnum.FIRST_ES_WAIT_SECONDS; aquí
    solo se definen las esperas de revisión tras responder.
    """

    WRONG_REVIEW_WAIT_SECONDS = 4  # tras fallar: se oye el NL y da tiempo a ver la corrección
    CORRECT_REVIEW_WAIT_SECONDS = 1  # tras acertar: breve confirmación antes de la siguiente
