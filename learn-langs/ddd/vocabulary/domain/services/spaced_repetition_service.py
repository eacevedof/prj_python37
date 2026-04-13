from dataclasses import dataclass
from datetime import datetime, timedelta
from typing import final


@dataclass(frozen=True, slots=True)
class SM2Result:
    """Resultado del cálculo SM-2."""

    repetitions: int
    easiness_factor: float
    interval_days: int
    next_review_at: str


@final
class SpacedRepetitionService:
    """
    Servicio de dominio para algoritmo de repetición espaciada SM-2.

    El algoritmo SM-2 (SuperMemo 2) calcula el intervalo óptimo
    para repasar una palabra basándose en la calidad de la respuesta.
    """

    DEFAULT_EASINESS_FACTOR = 2.5
    MIN_EASINESS_FACTOR = 1.3

    @classmethod
    def calculate_next_review(
        cls,
        quality: int,
        repetitions: int,
        easiness_factor: float,
        interval_days: int,
    ) -> SM2Result:
        """
        Calcula los nuevos parámetros SM-2 basados en la calidad de respuesta.

        Args:
            quality: 0-5 (0-2 = error, 3-5 = correcto)
            repetitions: Veces consecutivas correctas previas
            easiness_factor: Factor de facilidad actual (default 2.5)
            interval_days: Intervalo actual en días

        Returns:
            SM2Result con los nuevos valores calculados.
        """
        if quality < 3:
            # Respuesta incorrecta: reiniciar
            new_repetitions = 0
            new_interval = 1
        else:
            # Respuesta correcta: incrementar
            if repetitions == 0:
                new_interval = 1
            elif repetitions == 1:
                new_interval = 6
            else:
                new_interval = round(interval_days * easiness_factor)

            new_repetitions = repetitions + 1

        # Ajustar factor de facilidad
        # EF' = EF + (0.1 - (5-q) * (0.08 + (5-q) * 0.02))
        new_easiness = easiness_factor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
        new_easiness = max(cls.MIN_EASINESS_FACTOR, new_easiness)

        # Calcular fecha de próximo repaso
        next_review_date = datetime.now() + timedelta(days=new_interval)
        next_review_at = next_review_date.strftime("%Y-%m-%d %H:%M:%S")

        return SM2Result(
            repetitions=new_repetitions,
            easiness_factor=round(new_easiness, 2),
            interval_days=new_interval,
            next_review_at=next_review_at,
        )

    @classmethod
    def calculate_from_score(
        cls,
        score: float,
        repetitions: int = 0,
        easiness_factor: float = DEFAULT_EASINESS_FACTOR,
        interval_days: int = 1,
    ) -> SM2Result:
        """
        Calcula SM-2 directamente desde un score 0.0-1.0.

        Args:
            score: Score de 0.0 a 1.0
            repetitions: Repeticiones previas
            easiness_factor: Factor de facilidad
            interval_days: Intervalo actual

        Returns:
            SM2Result con los nuevos valores.
        """
        quality = cls._score_to_quality(score)
        return cls.calculate_next_review(quality, repetitions, easiness_factor, interval_days)

    @staticmethod
    def _score_to_quality(score: float) -> int:
        """Convierte score (0.0-1.0) a quality (0-5)."""
        if score >= 1.0:
            return 5
        elif score >= 0.9:
            return 4
        elif score >= 0.7:
            return 3
        elif score >= 0.5:
            return 2
        elif score > 0.0:
            return 1
        else:
            return 0

    @classmethod
    def is_due_for_review(cls, next_review_at: str) -> bool:
        """
        Verifica si una palabra necesita repaso.

        Args:
            next_review_at: Fecha de próximo repaso en formato ISO.

        Returns:
            True si debe ser repasada (fecha pasada o actual).
        """
        if not next_review_at:
            return True

        try:
            review_date = datetime.fromisoformat(next_review_at.replace(" ", "T"))
            return datetime.now() >= review_date
        except ValueError:
            return True

    @classmethod
    def calculate_priority_score(
        cls,
        next_review_at: str,
        easiness_factor: float,
        total_attempts: int,
    ) -> float:
        """
        Calcula un score de prioridad para ordenar palabras a estudiar.

        Factores considerados:
        - Días de retraso (mayor prioridad si más vencida)
        - Factor de facilidad (menor EF = más difícil = mayor prioridad)
        - Intentos totales (menos intentos = más nueva = mayor prioridad)

        Args:
            next_review_at: Fecha próximo repaso.
            easiness_factor: Factor de facilidad actual.
            total_attempts: Intentos totales históricos.

        Returns:
            Score de prioridad (mayor = más urgente).
        """
        priority = 0.0

        # Factor 1: Días de retraso
        if next_review_at:
            try:
                review_date = datetime.fromisoformat(next_review_at.replace(" ", "T"))
                days_overdue = (datetime.now() - review_date).days
                if days_overdue > 0:
                    priority += days_overdue * 10
                else:
                    priority -= abs(days_overdue)
            except ValueError:
                priority += 100  # Si no tiene fecha, alta prioridad
        else:
            priority += 100  # Palabras nuevas tienen alta prioridad

        # Factor 2: Dificultad (EF bajo = más difícil)
        priority += (cls.DEFAULT_EASINESS_FACTOR - easiness_factor) * 20

        # Factor 3: Palabras con pocos intentos
        if total_attempts < 5:
            priority += (5 - total_attempts) * 5

        return priority
