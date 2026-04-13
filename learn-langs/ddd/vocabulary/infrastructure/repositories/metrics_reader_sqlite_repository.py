from typing import final, Self

from ddd.shared.infrastructure.repositories.sqlite_connection import SqliteConnection


@final
class MetricsReaderSqliteRepository:
    """Repositorio de lectura para métricas SM-2."""

    _sqlite: SqliteConnection

    def __init__(self) -> None:
        self._sqlite = SqliteConnection.get_instance()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_by_word_and_lang(self, word_es_id: int, lang_code: str) -> dict | None:
        """Obtiene métricas de una palabra en un idioma específico."""
        query = """
            SELECT id, word_es_id, lang_code, repetitions, easiness_factor,
                   interval_days, next_review_at, last_reviewed_at,
                   total_attempts, total_score, created_at, updated_at
            FROM word_metrics
            WHERE word_es_id = ? AND lang_code = ?
        """
        return await self._sqlite.fetch_one(query, (word_es_id, lang_code))

    async def get_words_for_review(
        self,
        lang_code: str,
        tag_names: list[str] | None = None,
        limit: int = 20,
    ) -> list[dict]:
        """
        Obtiene palabras para repaso ordenadas por prioridad SM-2.
        Incluye palabras sin métricas (nuevas) y con next_review_at vencido.
        """
        if tag_names:
            placeholders = ",".join(["?" for _ in tag_names])
            query = f"""
                SELECT DISTINCT
                    we.id as word_es_id,
                    we.text as text_es,
                    we.word_type,
                    wl.text as text_lang,
                    wl.pronunciation,
                    COALESCE(wm.repetitions, 0) as repetitions,
                    COALESCE(wm.easiness_factor, 2.5) as easiness_factor,
                    COALESCE(wm.interval_days, 1) as interval_days,
                    wm.next_review_at,
                    COALESCE(wm.total_attempts, 0) as total_attempts
                FROM words_es we
                INNER JOIN words_lang wl ON we.id = wl.word_es_id AND wl.lang_code = ?
                INNER JOIN word_es_tags wt ON we.id = wt.word_es_id
                INNER JOIN tags t ON wt.tag_id = t.id AND t.name IN ({placeholders})
                LEFT JOIN word_metrics wm ON we.id = wm.word_es_id AND wm.lang_code = ?
                WHERE wm.next_review_at IS NULL
                   OR wm.next_review_at <= datetime('now')
                ORDER BY
                    CASE WHEN wm.next_review_at IS NULL THEN 0 ELSE 1 END,
                    wm.next_review_at ASC,
                    wm.easiness_factor ASC
                LIMIT ?
            """
            params = (lang_code,) + tuple(tag_names) + (lang_code, limit)
        else:
            query = """
                SELECT
                    we.id as word_es_id,
                    we.text as text_es,
                    we.word_type,
                    wl.text as text_lang,
                    wl.pronunciation,
                    COALESCE(wm.repetitions, 0) as repetitions,
                    COALESCE(wm.easiness_factor, 2.5) as easiness_factor,
                    COALESCE(wm.interval_days, 1) as interval_days,
                    wm.next_review_at,
                    COALESCE(wm.total_attempts, 0) as total_attempts
                FROM words_es we
                INNER JOIN words_lang wl ON we.id = wl.word_es_id AND wl.lang_code = ?
                LEFT JOIN word_metrics wm ON we.id = wm.word_es_id AND wm.lang_code = ?
                WHERE wm.next_review_at IS NULL
                   OR wm.next_review_at <= datetime('now')
                ORDER BY
                    CASE WHEN wm.next_review_at IS NULL THEN 0 ELSE 1 END,
                    wm.next_review_at ASC,
                    wm.easiness_factor ASC
                LIMIT ?
            """
            params = (lang_code, lang_code, limit)

        return await self._sqlite.fetch_all(query, params)

    async def get_stats_for_lang(self, lang_code: str) -> dict:
        """Obtiene estadísticas generales para un idioma."""
        query = """
            SELECT
                COUNT(*) as total_words,
                SUM(CASE WHEN next_review_at <= datetime('now') THEN 1 ELSE 0 END) as due_for_review,
                AVG(easiness_factor) as avg_easiness,
                SUM(total_attempts) as total_reviews,
                AVG(CASE WHEN total_attempts > 0 THEN total_score / total_attempts ELSE 0 END) as avg_score
            FROM word_metrics
            WHERE lang_code = ?
        """
        result = await self._sqlite.fetch_one(query, (lang_code,))
        return result or {
            "total_words": 0,
            "due_for_review": 0,
            "avg_easiness": 2.5,
            "total_reviews": 0,
            "avg_score": 0.0,
        }
