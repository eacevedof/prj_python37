"""Resultado del cálculo SM-2 (value object de dominio)."""

from dataclasses import dataclass


@dataclass(frozen=True, slots=True)
class SM2Result:
    """Resultado del cálculo SM-2."""

    repetitions: int
    easiness_factor: float
    interval_days: int
    next_review_at: str
