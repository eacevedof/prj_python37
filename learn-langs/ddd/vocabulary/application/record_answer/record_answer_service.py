from typing import final, Self

from ddd.vocabulary.application.record_answer.record_answer_dto import RecordAnswerDto
from ddd.vocabulary.application.record_answer.record_answer_result_dto import RecordAnswerResultDto
from ddd.vocabulary.domain.exceptions import VocabularyException
from ddd.vocabulary.domain.services import ScoreCalculatorService, SpacedRepetitionService
from ddd.vocabulary.infrastructure.repositories import (
    SessionsReaderSqliteRepository,
    MetricsReaderSqliteRepository,
    MetricsWriterSqliteRepository,
    AnswersWriterSqliteRepository,
    SessionsWriterSqliteRepository,
)


@final
class RecordAnswerService:
    """Servicio para registrar respuestas y actualizar métricas SM-2."""

    _dto: RecordAnswerDto
    _sessions_reader: SessionsReaderSqliteRepository
    _sessions_writer: SessionsWriterSqliteRepository
    _metrics_reader: MetricsReaderSqliteRepository
    _metrics_writer: MetricsWriterSqliteRepository
    _answers_writer: AnswersWriterSqliteRepository

    def __init__(self) -> None:
        pass

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def __call__(self, dto: RecordAnswerDto) -> RecordAnswerResultDto:
        """
        Registra una respuesta, calcula score y actualiza métricas SM-2.

        Args:
            dto: Datos de la respuesta.

        Returns:
            RecordAnswerResultDto con score y métricas actualizadas.

        Raises:
            VocabularyException: Si la sesión no existe o está finalizada.
        """
        self._dto = dto
        self._sessions_reader = SessionsReaderSqliteRepository.get_instance()
        self._sessions_writer = SessionsWriterSqliteRepository.get_instance()
        self._metrics_reader = MetricsReaderSqliteRepository.get_instance()
        self._metrics_writer = MetricsWriterSqliteRepository.get_instance()
        self._answers_writer = AnswersWriterSqliteRepository.get_instance()

        # Validar DTO
        errors = dto.validate()
        if errors:
            raise VocabularyException.word_creation_failed(", ".join(errors))

        # Verificar sesión
        session = await self._sessions_reader.get_by_id(dto.session_id)
        if not session:
            raise VocabularyException.session_not_found(dto.session_id)

        if session.get("finished_at"):
            raise VocabularyException.session_already_finished(dto.session_id)

        # Calcular score
        score = ScoreCalculatorService.calculate(dto.expected_text, dto.user_input)

        # Obtener métricas actuales
        lang_code = session["lang_code"]
        current_metrics = await self._metrics_reader.get_by_word_and_lang(
            dto.word_es_id, lang_code
        )

        # Calcular nuevas métricas SM-2
        if current_metrics:
            sm2_result = SpacedRepetitionService.calculate_from_score(
                score=score,
                repetitions=current_metrics["repetitions"],
                easiness_factor=current_metrics["easiness_factor"],
                interval_days=current_metrics["interval_days"],
            )
        else:
            sm2_result = SpacedRepetitionService.calculate_from_score(score=score)

        # Guardar métricas
        await self._metrics_writer.create_or_update(
            word_es_id=dto.word_es_id,
            lang_code=lang_code,
            repetitions=sm2_result.repetitions,
            easiness_factor=sm2_result.easiness_factor,
            interval_days=sm2_result.interval_days,
            next_review_at=sm2_result.next_review_at,
            score=score,
        )

        # Guardar respuesta
        answer_data = await self._answers_writer.create(
            session_id=dto.session_id,
            word_es_id=dto.word_es_id,
            expected_text=dto.expected_text,
            user_input=dto.user_input,
            score=score,
            response_time_ms=dto.response_time_ms,
        )

        # Actualizar progreso de sesión
        await self._update_session_progress(dto.session_id)

        return RecordAnswerResultDto.from_primitives({
            "answer_id": answer_data["id"],
            "session_id": dto.session_id,
            "word_es_id": dto.word_es_id,
            "user_input": dto.user_input,
            "expected_text": dto.expected_text,
            "score": score,
            "response_time_ms": dto.response_time_ms,
            "new_repetitions": sm2_result.repetitions,
            "new_easiness_factor": sm2_result.easiness_factor,
            "new_interval_days": sm2_result.interval_days,
            "next_review_at": sm2_result.next_review_at,
        })

    async def _update_session_progress(self, session_id: int) -> None:
        """Actualiza el progreso de la sesión con las respuestas actuales."""
        from ddd.vocabulary.infrastructure.repositories import AnswersReaderSqliteRepository

        answers_reader = AnswersReaderSqliteRepository.get_instance()
        summary = await answers_reader.get_session_summary(session_id)

        await self._sessions_writer.update_progress(
            session_id=session_id,
            total_words=summary["total_answers"],
            total_score=summary["average_score"] * summary["total_answers"],
        )
