from enum import Enum
from typing import final


@final
class StudyModeEnum(str, Enum):
    """Modos de estudio."""

    TYPING = "TYPING"           # Usuario escribe la traducción
    PRESENTATION = "PRESENTATION"  # Solo visualización, Enter para continuar
    IMAGE_TYPING = "IMAGE_TYPING"  # Usuario ve imagen y escribe traducción
