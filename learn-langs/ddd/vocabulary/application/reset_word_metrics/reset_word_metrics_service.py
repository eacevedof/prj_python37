"""Servicio para reiniciar el progreso de estudio (SM-2) de una palabra."""

from typing import final, Self

from ddd.vocabulary.application.reset_word_metrics.reset_word_metrics_dto import (
    ResetWordMetricsDto,
)
from ddd.vocabulary.application.reset_word_metrics.reset_word_metrics_result_dto import (
    ResetWordMetricsResultDto,
)
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.infrastructure.repositories import MetricsWriterSqliteRepository


@final
class ResetWordMetricsService:
    """Servicio para reiniciar las métricas SM-2 de una palabra en un idioma."""

    _metrics_writer_sqlite_repository: MetricsWriterSqliteRepository

    def __init__(self) -> None:
        self._metrics_writer_sqlite_repository = (
            MetricsWriterSqliteRepository.get_instance()
        )

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(
        self, reset_word_metrics_dto: ResetWordMetricsDto
    ) -> ResetWordMetricsResultDto:
        """
        Reinicia el progreso de estudio de la palabra: vuelve a entrar al
        entrenamiento como nueva. No toca traducciones, audios, imágenes
        ni el historial de sesiones.

        Args:
            reset_word_metrics_dto: Palabra e idioma a reiniciar.

        Returns:
            ResetWordMetricsResultDto con is_reset (False si no tenía métricas).

        Raises:
            VocabularyException: Si el DTO no es válido.
        """
        errors = reset_word_metrics_dto.validate()
        if errors:
            VocabularyException.bad_request_custom(", ".join(errors))

        is_reset = await self._metrics_writer_sqlite_repository.reset_metrics(
            word_es_id=reset_word_metrics_dto.word_es_id,
            lang_code=reset_word_metrics_dto.lang_code,
        )

        return ResetWordMetricsResultDto.from_primitives(
            {
                "word_es_id": reset_word_metrics_dto.word_es_id,
                "lang_code": reset_word_metrics_dto.lang_code,
                "is_reset": is_reset,
            }
        )
