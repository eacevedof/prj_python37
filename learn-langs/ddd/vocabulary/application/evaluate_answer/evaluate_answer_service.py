"""Servicio para evaluar una respuesta (score + corrección) SIN persistir."""

from typing import final, Self

from ddd.vocabulary.application.evaluate_answer.evaluate_answer_dto import (
    EvaluateAnswerDto,
)
from ddd.vocabulary.application.evaluate_answer.evaluate_answer_result_dto import (
    EvaluateAnswerResultDto,
)
from ddd.vocabulary.domain.services import ScoreCalculatorService


@final
class EvaluateAnswerService:
    """Evalúa una respuesta (score + corrección) sin escribir en BD.

    Lo usa el examen para mostrar el resultado en vivo mientras acumula las
    respuestas en memoria; la persistencia (métricas SM-2 + answer) se realiza
    solo al COMPLETAR el examen (replay), no aquí.
    """

    _instance: "EvaluateAnswerService | None" = None

    def __init__(self) -> None:
        self._score_calculator_service = ScoreCalculatorService.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        if cls._instance is None:
            cls._instance = cls()
        return cls._instance

    async def __call__(
        self, evaluate_answer_dto: EvaluateAnswerDto
    ) -> EvaluateAnswerResultDto:
        score = self._score_calculator_service.calculate(
            evaluate_answer_dto.expected_text,
            evaluate_answer_dto.user_input,
        )
        return EvaluateAnswerResultDto.from_primitives({"score": score})
