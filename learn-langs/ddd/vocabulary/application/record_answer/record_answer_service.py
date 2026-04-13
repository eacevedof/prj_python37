from typing import final, Self

from ddd.vocabulary.application.record_answer.record_answer_dto import RecordAnswerDto
from ddd.vocabulary.application.record_answer.record_answer_result_dto import RecordAnswerResultDto
from ddd.vocabulary.domain.entities import WordMetricEntity, SessionAnswerEntity, StudySessionEntity
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
    """Servicio para registrar respuestas y actualizar metricas SM-2."""

    _record_answer_dto: RecordAnswerDto
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

    async def __call__(self, record_answer_dto: RecordAnswerDto) -> RecordAnswerResultDto:
        """
        Registra una respuesta, calcula score y actualiza metricas SM-2.

        Args:
            record_answer_dto: Datos de la respuesta.

        Returns:
            RecordAnswerResultDto con score y metricas actualizadas.

        Raises:
            VocabularyException: Si la sesion no existe o esta finalizada.
        """
        self._record_answer_dto = record_answer_dto
        self._sessions_reader = SessionsReaderSqliteRepository.get_instance()
        self._sessions_writer = SessionsWriterSqliteRepository.get_instance()
        self._metrics_reader = MetricsReaderSqliteRepository.get_instance()
        self._metrics_writer = MetricsWriterSqliteRepository.get_instance()
        self._answers_writer = AnswersWriterSqliteRepository.get_instance()

        # Validar DTO
        errors = record_answer_dto.validate()
        if errors:
            raise VocabularyException.word_creation_failed(", ".join(errors))

        # Verificar sesion
        session = await self._sessions_reader.get_by_id(record_answer_dto.session_id)
        if not session:
            raise VocabularyException.session_not_found(record_answer_dto.session_id)

        if session.get("finished_at"):
            raise VocabularyException.session_already_finished(record_answer_dto.session_id)

        # Calcular score
        score = ScoreCalculatorService.calculate(
            record_answer_dto.expected_text,
            record_answer_dto.user_input,
        )

        # Obtener metricas actuales
        lang_code = session["lang_code"]
        current_metrics = await self._metrics_reader.get_by_word_and_lang(
            record_answer_dto.word_es_id, lang_code
        )

        # Calcular nuevas metricas SM-2
        if current_metrics:
            sm2_result = SpacedRepetitionService.calculate_from_score(
                score=score,
                repetitions=current_metrics["repetitions"],
                easiness_factor=current_metrics["easiness_factor"],
                interval_days=current_metrics["interval_days"],
            )
            total_attempts = current_metrics["total_attempts"] + 1
            total_score = current_metrics["total_score"] + score
        else:
            sm2_result = SpacedRepetitionService.calculate_from_score(score=score)
            total_attempts = 1
            total_score = score

        # Crear entidad de metricas
        word_metric_entity = WordMetricEntity(
            id=current_metrics["id"] if current_metrics else 0,
            word_es_id=record_answer_dto.word_es_id,
            lang_code=lang_code,
            repetitions=sm2_result.repetitions,
            easiness_factor=sm2_result.easiness_factor,
            interval_days=sm2_result.interval_days,
            next_review_at=sm2_result.next_review_at,
            total_attempts=total_attempts,
            total_score=total_score,
        )

        # Guardar metricas
        await self._metrics_writer.create_or_update(word_metric_entity)

        # Crear entidad de respuesta
        session_answer_entity = SessionAnswerEntity(
            id=0,
            session_id=record_answer_dto.session_id,
            word_es_id=record_answer_dto.word_es_id,
            user_input=record_answer_dto.user_input or "",
            expected_text=record_answer_dto.expected_text,
            score=score,
            response_time_ms=record_answer_dto.response_time_ms or 0,
        )

        # Guardar respuesta
        answer_id = await self._answers_writer.create(session_answer_entity)

        # Actualizar progreso de sesion
        await self._update_session_progress(record_answer_dto.session_id)

        return RecordAnswerResultDto.from_primitives({
            "answer_id": answer_id,
            "session_id": record_answer_dto.session_id,
            "word_es_id": record_answer_dto.word_es_id,
            "user_input": record_answer_dto.user_input,
            "expected_text": record_answer_dto.expected_text,
            "score": score,
            "response_time_ms": record_answer_dto.response_time_ms,
            "new_repetitions": sm2_result.repetitions,
            "new_easiness_factor": sm2_result.easiness_factor,
            "new_interval_days": sm2_result.interval_days,
            "next_review_at": sm2_result.next_review_at,
        })

    async def _update_session_progress(self, session_id: int) -> None:
        """Actualiza el progreso de la sesion con las respuestas actuales."""
        from ddd.vocabulary.infrastructure.repositories import AnswersReaderSqliteRepository

        answers_reader = AnswersReaderSqliteRepository.get_instance()
        summary = await answers_reader.get_session_summary(session_id)

        # Leer sesion actual
        session_data = await self._sessions_reader.get_by_id(session_id)
        if not session_data:
            return

        total_words = summary["total_answers"]
        total_score = summary["average_score"] * summary["total_answers"]
        average_score = summary["average_score"]

        # Crear entidad de sesion con datos actualizados
        study_session_entity = StudySessionEntity.from_primitives({
            **session_data,
            "total_words": total_words,
            "total_score": total_score,
            "average_score": round(average_score, 2),
        })

        await self._sessions_writer.update(study_session_entity)
