from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.components.sqlite_connector import SqliteConnector
from ddd.vocabulary.domain.entities import WordMetricEntity


@final
class MetricsWriterSqliteRepository:
    """Repositorio de escritura para métricas SM-2."""

    _sqlite: SqliteConnector

    def __init__(self) -> None:
        self._sqlite = SqliteConnector.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create(self, word_metric_entity: WordMetricEntity) -> int:
        """Crea nuevas métricas para una palabra y retorna el ID generado."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        query = """
            INSERT INTO word_metrics
            (word_es_id, lang_code, repetitions, easiness_factor, interval_days,
             next_review_at, last_reviewed_at, total_attempts, total_score,
             created_at, updated_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """
        metric_id = await self._sqlite.insert(
            query,
            (
                word_metric_entity.word_es_id,
                word_metric_entity.lang_code,
                word_metric_entity.repetitions,
                word_metric_entity.easiness_factor,
                word_metric_entity.interval_days,
                word_metric_entity.next_review_at,
                now,
                word_metric_entity.total_attempts,
                word_metric_entity.total_score,
                now,
                now,
            ),
        )

        return metric_id

    async def update(self, word_metric_entity: WordMetricEntity) -> bool:
        """Actualiza métricas existentes."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        query = """
            UPDATE word_metrics
            SET repetitions = ?,
                easiness_factor = ?,
                interval_days = ?,
                next_review_at = ?,
                last_reviewed_at = ?,
                total_attempts = ?,
                total_score = ?,
                updated_at = ?
            WHERE id = ?
        """
        rows = await self._sqlite.update(
            query,
            (
                word_metric_entity.repetitions,
                word_metric_entity.easiness_factor,
                word_metric_entity.interval_days,
                word_metric_entity.next_review_at,
                now,
                word_metric_entity.total_attempts,
                word_metric_entity.total_score,
                now,
                word_metric_entity.id,
            ),
        )
        return rows > 0

    async def create_or_update(self, word_metric_entity: WordMetricEntity) -> int:
        """Crea o actualiza métricas para una palabra. Retorna el ID."""
        existing = await self._sqlite.fetch_one(
            "SELECT id, total_attempts, total_score FROM word_metrics WHERE word_es_id = ? AND lang_code = ?",
            (word_metric_entity.word_es_id, word_metric_entity.lang_code),
        )

        if existing:
            now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            query = """
                UPDATE word_metrics
                SET repetitions = ?,
                    easiness_factor = ?,
                    interval_days = ?,
                    next_review_at = ?,
                    last_reviewed_at = ?,
                    total_attempts = ?,
                    total_score = ?,
                    updated_at = ?
                WHERE id = ?
            """
            await self._sqlite.update(
                query,
                (
                    word_metric_entity.repetitions,
                    word_metric_entity.easiness_factor,
                    word_metric_entity.interval_days,
                    word_metric_entity.next_review_at,
                    now,
                    word_metric_entity.total_attempts,
                    word_metric_entity.total_score,
                    now,
                    existing["id"],
                ),
            )
            return existing["id"]
        else:
            return await self.create(word_metric_entity)

    async def reset_metrics(self, word_metric_entity: WordMetricEntity) -> bool:
        """Reinicia las métricas de una palabra (para re-aprender)."""
        query = """
            UPDATE word_metrics
            SET repetitions = 0,
                easiness_factor = 2.5,
                interval_days = 1,
                next_review_at = datetime('now'),
                updated_at = datetime('now')
            WHERE word_es_id = ? AND lang_code = ?
        """
        rows = await self._sqlite.update(
            query,
            (word_metric_entity.word_es_id, word_metric_entity.lang_code),
        )
        return rows > 0
