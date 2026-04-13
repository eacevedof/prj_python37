from datetime import datetime
from typing import final, Self

from ddd.shared.infrastructure.repositories.sqlite_connection import SqliteConnection


@final
class MetricsWriterSqliteRepository:
    """Repositorio de escritura para métricas SM-2."""

    _sqlite: SqliteConnection

    def __init__(self) -> None:
        self._sqlite = SqliteConnection.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def create_or_update(
        self,
        word_es_id: int,
        lang_code: str,
        repetitions: int,
        easiness_factor: float,
        interval_days: int,
        next_review_at: str,
        score: float,
    ) -> dict:
        """Crea o actualiza métricas para una palabra."""
        now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        # Verificar si existe
        existing = await self._sqlite.fetch_one(
            "SELECT id, total_attempts, total_score FROM word_metrics WHERE word_es_id = ? AND lang_code = ?",
            (word_es_id, lang_code)
        )

        if existing:
            # Actualizar
            query = """
                UPDATE word_metrics
                SET repetitions = ?,
                    easiness_factor = ?,
                    interval_days = ?,
                    next_review_at = ?,
                    last_reviewed_at = ?,
                    total_attempts = total_attempts + 1,
                    total_score = total_score + ?,
                    updated_at = ?
                WHERE id = ?
            """
            await self._sqlite.update(
                query,
                (repetitions, easiness_factor, interval_days, next_review_at,
                 now, score, now, existing["id"])
            )
            metric_id = existing["id"]
            total_attempts = existing["total_attempts"] + 1
            total_score = existing["total_score"] + score
        else:
            # Crear
            query = """
                INSERT INTO word_metrics
                (word_es_id, lang_code, repetitions, easiness_factor, interval_days,
                 next_review_at, last_reviewed_at, total_attempts, total_score,
                 created_at, updated_at)
                VALUES (?, ?, ?, ?, ?, ?, ?, 1, ?, ?, ?)
            """
            metric_id = await self._sqlite.insert(
                query,
                (word_es_id, lang_code, repetitions, easiness_factor, interval_days,
                 next_review_at, now, score, now, now)
            )
            total_attempts = 1
            total_score = score

        return {
            "id": metric_id,
            "word_es_id": word_es_id,
            "lang_code": lang_code,
            "repetitions": repetitions,
            "easiness_factor": easiness_factor,
            "interval_days": interval_days,
            "next_review_at": next_review_at,
            "last_reviewed_at": now,
            "total_attempts": total_attempts,
            "total_score": total_score,
        }

    async def reset_metrics(self, word_es_id: int, lang_code: str) -> bool:
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
        rows = await self._sqlite.update(query, (word_es_id, lang_code))
        return rows > 0
