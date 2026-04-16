"""Repositorio de escritura para métricas SM-2."""

from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository
from ddd.vocabulary.domain.entities import WordMetricEntity


@final
class MetricsWriterSqliteRepository(AbstractSqliteRepository):
    """Repositorio de escritura para métricas SM-2."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(self, word_metric_entity: WordMetricEntity) -> int:
        """Crea nuevas métricas para una palabra y retorna el ID generado."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        return await self._insert_into("word_metrics", {
            "word_es_id": word_metric_entity.word_es_id,
            "lang_code": word_metric_entity.lang_code,
            "repetitions": word_metric_entity.repetitions,
            "easiness_factor": word_metric_entity.easiness_factor,
            "interval_days": word_metric_entity.interval_days,
            "next_review_at": word_metric_entity.next_review_at,
            "last_reviewed_at": now,
            "total_attempts": word_metric_entity.total_attempts,
            "total_score": word_metric_entity.total_score,
            "created_at": now,
            "updated_at": now,
        })

    async def update(self, word_metric_entity: WordMetricEntity) -> bool:
        """Actualiza métricas existentes."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        rows = await self._update_where(
            "word_metrics",
            {
                "repetitions": word_metric_entity.repetitions,
                "easiness_factor": word_metric_entity.easiness_factor,
                "interval_days": word_metric_entity.interval_days,
                "next_review_at": word_metric_entity.next_review_at,
                "last_reviewed_at": now,
                "total_attempts": word_metric_entity.total_attempts,
                "total_score": word_metric_entity.total_score,
                "updated_at": now,
            },
            "id = ?",
            (word_metric_entity.id,),
        )
        return rows > 0

    async def create_or_update(self, word_metric_entity: WordMetricEntity) -> int:
        """Crea o actualiza métricas para una palabra. Retorna el ID."""
        existing = await self._query_one(
            "SELECT id, total_attempts, total_score FROM word_metrics WHERE word_es_id = ? AND lang_code = ?",
            (word_metric_entity.word_es_id, word_metric_entity.lang_code),
        )

        if existing:
            now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            await self._update_where(
                "word_metrics",
                {
                    "repetitions": word_metric_entity.repetitions,
                    "easiness_factor": word_metric_entity.easiness_factor,
                    "interval_days": word_metric_entity.interval_days,
                    "next_review_at": word_metric_entity.next_review_at,
                    "last_reviewed_at": now,
                    "total_attempts": word_metric_entity.total_attempts,
                    "total_score": word_metric_entity.total_score,
                    "updated_at": now,
                },
                "id = ?",
                (existing["id"],),
            )
            return existing["id"]
        else:
            return await self.create(word_metric_entity)

    async def reset_metrics(self, word_metric_entity: WordMetricEntity) -> bool:
        """Reinicia las métricas de una palabra (para re-aprender)."""
        rows = await self._sqlite.update(
            """
            UPDATE word_metrics
            SET repetitions = 0,
                easiness_factor = 2.5,
                interval_days = 1,
                next_review_at = datetime('now'),
                updated_at = datetime('now')
            WHERE word_es_id = ? AND lang_code = ?
            """,
            (word_metric_entity.word_es_id, word_metric_entity.lang_code),
        )
        return rows > 0
