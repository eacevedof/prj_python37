"""Repositorio de lectura para métricas SM-2."""

from typing import final, Self

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository


@final
class MetricsReaderSqliteRepository(AbstractSqliteRepository):
    """Repositorio de lectura para métricas SM-2."""

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_by_word_and_lang(self, word_es_id: int, lang_code: str) -> dict | None:
        """Obtiene métricas de una palabra en un idioma específico."""
        return await self._query_one(
            f"""
            SELECT id, word_es_id, lang_code, repetitions, easiness_factor,
                   interval_days, next_review_at, last_reviewed_at,
                   total_attempts, total_score, created_at, updated_at
            FROM word_metrics
            WHERE 1=1
            AND word_es_id = {word_es_id}
            AND lang_code = ?
            """,
            (lang_code,),
        )

    async def get_words_for_review(
        self,
        lang_code: str,
        tag_names: list[str] | None = None,
        group_id: int | None = None,
        limit: int = 20,
    ) -> list[dict]:
        """
        Obtiene palabras para repaso ordenadas por prioridad SM-2.
        Incluye palabras sin métricas (nuevas) y con next_review_at vencido.
        """
        # Construir filtro de grupo
        group_join = ""
        group_where = ""
        if group_id is not None:
            group_join = "INNER JOIN word_es_groups weg ON we.id = weg.word_es_id"
            group_where = f"AND weg.group_id = {group_id}"

        if tag_names:
            placeholders = self._get_placeholders(len(tag_names))
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
                {group_join}
                LEFT JOIN word_metrics wm ON we.id = wm.word_es_id AND wm.lang_code = ?
                WHERE 1=1 {group_where}
                ORDER BY
                    CASE WHEN wm.next_review_at IS NULL THEN 0
                         WHEN wm.next_review_at <= datetime('now') THEN 1
                         ELSE 2 END,
                    wm.next_review_at ASC,
                    wm.easiness_factor ASC
                LIMIT {limit}
            """
            params = (lang_code,) + tuple(tag_names) + (lang_code,)
        else:
            query = f"""
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
                {group_join}
                LEFT JOIN word_metrics wm ON we.id = wm.word_es_id AND wm.lang_code = ?
                WHERE 1=1 {group_where}
                ORDER BY
                    CASE WHEN wm.next_review_at IS NULL THEN 0
                         WHEN wm.next_review_at <= datetime('now') THEN 1
                         ELSE 2 END,
                    wm.next_review_at ASC,
                    wm.easiness_factor ASC
                LIMIT {limit}
            """
            params = (lang_code, lang_code)

        return await self._query(query, params)

    async def get_words_with_images_for_review(
        self,
        lang_code: str,
        tag_names: list[str] | None = None,
        group_id: int | None = None,
        limit: int = 20,
    ) -> list[dict]:
        """
        Obtiene palabras con imágenes para repaso ordenadas por prioridad SM-2.
        Solo incluye palabras de tipo WORD que tienen imagen principal.
        Incluye palabras sin métricas (nuevas) y con next_review_at vencido.
        """
        # Construir filtro de grupo
        group_join = ""
        group_where = ""
        if group_id is not None:
            group_join = "INNER JOIN word_es_groups weg ON we.id = weg.word_es_id"
            group_where = f"AND weg.group_id = {group_id}"

        if tag_names:
            placeholders = self._get_placeholders(len(tag_names))
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
                    COALESCE(wm.total_attempts, 0) as total_attempts,
                    img.file_path as image_file_path,
                    img.mime_type as image_mime_type,
                    img.caption as image_caption
                FROM words_es we
                INNER JOIN words_lang wl ON we.id = wl.word_es_id AND wl.lang_code = ?
                INNER JOIN word_es_images img ON we.id = img.word_es_id
                    AND img.is_primary = 1
                    AND img.is_active = 1
                INNER JOIN word_es_tags wt ON we.id = wt.word_es_id
                INNER JOIN tags t ON wt.tag_id = t.id AND t.name IN ({placeholders})
                {group_join}
                LEFT JOIN word_metrics wm ON we.id = wm.word_es_id AND wm.lang_code = ?
                WHERE we.word_type = 'WORD' {group_where}
                ORDER BY
                    CASE WHEN wm.next_review_at IS NULL THEN 0
                         WHEN wm.next_review_at <= datetime('now') THEN 1
                         ELSE 2 END,
                    wm.next_review_at ASC,
                    wm.easiness_factor ASC
                LIMIT {limit}
            """
            params = (lang_code,) + tuple(tag_names) + (lang_code,)
        else:
            query = f"""
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
                    COALESCE(wm.total_attempts, 0) as total_attempts,
                    img.file_path as image_file_path,
                    img.mime_type as image_mime_type,
                    img.caption as image_caption
                FROM words_es we
                INNER JOIN words_lang wl ON we.id = wl.word_es_id AND wl.lang_code = ?
                INNER JOIN word_es_images img ON we.id = img.word_es_id
                    AND img.is_primary = 1
                    AND img.is_active = 1
                {group_join}
                LEFT JOIN word_metrics wm ON we.id = wm.word_es_id AND wm.lang_code = ?
                WHERE we.word_type = 'WORD' {group_where}
                ORDER BY
                    CASE WHEN wm.next_review_at IS NULL THEN 0
                         WHEN wm.next_review_at <= datetime('now') THEN 1
                         ELSE 2 END,
                    wm.next_review_at ASC,
                    wm.easiness_factor ASC
                LIMIT {limit}
            """
            params = (lang_code, lang_code)

        return await self._query(query, params)

    async def get_stats_for_lang(self, lang_code: str) -> dict:
        """Obtiene estadísticas generales para un idioma."""
        result = await self._query_one(
            """
            SELECT
                COUNT(*) as total_words,
                SUM(CASE WHEN next_review_at <= datetime('now') THEN 1 ELSE 0 END) as due_for_review,
                AVG(easiness_factor) as avg_easiness,
                SUM(total_attempts) as total_reviews,
                AVG(CASE WHEN total_attempts > 0 THEN total_score / total_attempts ELSE 0 END) as avg_score
            FROM word_metrics
            WHERE 1=1
                AND lang_code = ?
            """,
            (lang_code,),
        )
        return result or {
            "total_words": 0,
            "due_for_review": 0,
            "avg_easiness": 2.5,
            "total_reviews": 0,
            "avg_score": 0.0,
        }
