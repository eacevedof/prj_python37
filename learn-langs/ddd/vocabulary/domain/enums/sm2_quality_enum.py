from enum import Enum
from typing import final


@final
class SM2QualityEnum(int, Enum):
    """Calidad de respuesta SM-2 (0-5) derivada de un score (0.0-1.0).

    0-2 = error (reinicia repeticiones); 3-5 = correcto.
    """

    WORST = 0        # score <= 0.0
    VERY_LOW = 1     # 0.0 < score < 0.5
    LOW = 2          # 0.5 <= score < 0.7
    MEDIUM = 3       # 0.7 <= score < 0.9
    HIGH = 4         # 0.9 <= score < 1.0
    PERFECT = 5      # score >= 1.0

    @classmethod
    def from_score(cls, score: float) -> "SM2QualityEnum":
        """Mapea un score 0.0-1.0 a la calidad SM-2 (0-5)."""
        if score >= 1.0:
            return cls.PERFECT
        if score >= 0.9:
            return cls.HIGH
        if score >= 0.7:
            return cls.MEDIUM
        if score >= 0.5:
            return cls.LOW
        if score > 0.0:
            return cls.VERY_LOW
        return cls.WORST
