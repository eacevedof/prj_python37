from enum import Enum
from typing import final


@final
class EasinessFactorEnum(float, Enum):
    """Factores de facilidad (easiness factor) del algoritmo SM-2."""

    DEFAULT = 2.5   # factor de facilidad inicial de una palabra nueva
    MINIMUM = 1.3   # suelo del factor: nunca baja de aquí
