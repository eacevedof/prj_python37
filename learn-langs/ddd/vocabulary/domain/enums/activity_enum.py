from enum import Enum
from typing import final


@final
class ActivityEnum(str, Enum):
    """Actividades con estado reanudable (tabla activity_states)."""

    WORD_SLIDER = "WORD_SLIDER"  # Aprendizaje (slider)
    IMAGE_STUDY = "IMAGE_STUDY"  # Examen con imágenes

    @property
    def display_name(self) -> str:
        """Nombre para mostrar en la UI."""
        return {
            ActivityEnum.WORD_SLIDER: "Aprendizaje",
            ActivityEnum.IMAGE_STUDY: "Examen con imágenes",
        }[self]
