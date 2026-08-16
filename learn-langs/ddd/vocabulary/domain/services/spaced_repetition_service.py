from datetime import datetime, timedelta
from typing import final, Self

from ddd.vocabulary.domain.enums import EasinessFactorEnum, SM2QualityEnum
from ddd.vocabulary.domain.services.sm2_result import SM2Result


@final
class SpacedRepetitionService:
    """
    Servicio de dominio para algoritmo de repetición espaciada SM-2.

    El algoritmo SM-2 (SuperMemo 2) calcula el intervalo óptimo
    para repasar una palabra basándose en la calidad de la respuesta.

    Constantes en enums: EasinessFactorEnum (factores) y SM2QualityEnum (score->calidad).
    """

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    def get_next_review_from_score(
        self,
        score: float,
        repetitions: int = 0,
        easiness_factor: float = EasinessFactorEnum.TWO_DOT_FIVE.value,
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
        quality = SM2QualityEnum.from_score(score).value
        return self.__get_next_review(quality, repetitions, easiness_factor, interval_days)


    def __get_next_review(
        self,
        quality: int,
        num_repetitions: int,
        easiness_factor: float,
        interval_days: int,
    ) -> SM2Result:
        """
        Calcula los nuevos parámetros SM-2 basados en la calidad de respuesta.

        Args:
            quality: 0-5 (0-2 = error, 3-5 = correcto)
            num_repetitions: Veces consecutivas correctas previas
            easiness_factor: Factor de facilidad actual (default 2.5)
            interval_days: Intervalo actual en días

        Returns:
            SM2Result con los nuevos valores calculados.
        """
        new_interval = self.__get_new_interval_by_num_repetitions(
            num_repetitions, interval_days, easiness_factor
        )
        new_repetitions = num_repetitions + 1

        if quality < 3:
            # Respuesta incorrecta: reiniciar
            new_repetitions = 0
            new_interval = 1

        # Ajustar factor de facilidad
        # EF' = EF + (0.1 - (5-q) * (0.08 + (5-q) * 0.02))
        new_easiness = easiness_factor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
        new_easiness = max(EasinessFactorEnum.ONE_DOT_THREE.value, new_easiness)

        # Calcular fecha de próximo repaso
        next_review_date = datetime.now() + timedelta(days=new_interval)
        next_review_at = next_review_date.strftime("%Y-%m-%d %H:%M:%S")

        return SM2Result(
            repetitions=new_repetitions,
            easiness_factor=round(new_easiness, 2),
            interval_days=new_interval,
            next_review_at=next_review_at,
        )

    def __get_new_interval_by_num_repetitions(
        self, num_repetitions: int, interval_days: int, easiness_factor: float
    ) -> int:
        """
        Calcula el nuevo intervalo en días basado en el número de repeticiones.

        Args:
            num_repetitions: Número de repeticiones correctas consecutivas
            interval_days: Intervalo previo en días
            easiness_factor: Factor de facilidad actual

        Returns:
            Nuevo intervalo en días
        """
        if num_repetitions == 0:
            return 1
        if num_repetitions == 1:
            return 6

        # Para repeticiones > 1, el intervalo previo se multiplica por el factor
        # de facilidad real (SM-2: I(n) = I(n-1) * EF).
        return round(interval_days * easiness_factor)
