from enum import Enum
from typing import final


@final
class EasinessFactorEnum(float, Enum):
    """Factores de facilidad (easiness factor) del algoritmo SM-2."""

    TWO_DOT_FIVE = 2.5   # factor de facilidad inicial de una palabra nueva
    ONE_DOT_THREE = 1.3   # suelo del factor: nunca baja de aquí
