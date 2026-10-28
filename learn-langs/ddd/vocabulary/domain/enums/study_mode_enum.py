from enum import Enum
from typing import final


@final
class StudyModeEnum(str, Enum):
    """Modos de estudio."""

    TYPING = "TYPING"           # Usuario escribe la traducción
    PRESENTATION = "PRESENTATION"  # Solo visualización, Enter para continuar
    IMAGE_TYPING = "IMAGE_TYPING"  # Usuario ve imagen y escribe traducción
    SLIDER = "SLIDER"           # Presentación auto-reproducida con audio ES/idioma

    @classmethod
    def coerce(cls, value: object) -> "StudyModeEnum":
        """Miembro correspondiente a `value` (normalizado a mayúsculas), o TYPING.

        Alternativa SIN try/except a StudyModeEnum(value) para normalizar primitivos
        de datos legados/externos.
        """
        normalized = str(value or "").upper()
        for member in cls:
            if member.value == normalized:
                return member
        return cls.TYPING
