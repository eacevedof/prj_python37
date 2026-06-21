"""Repositorio de lectura: listado paginado de palabras ES con filtros dinámicos."""

from typing import Any, Self, final

from ddd.shared.infrastructure.repositories import AbstractSqliteRepository


@final
class WordsPaginationReaderSqliteRepository(AbstractSqliteRepository):
    """Lectura del listado paginado de palabras ES.

    Recibe un dict de filtros y devuelve el result-set (registros) y/o el total.
    Filtros soportados:
    - search: texto parcial; busca en el texto, en el nombre de grupo y por id exacto.
    - word_type: tipo de palabra (WORD, PHRASE, SENTENCE).
    - tags: lista de nombres de tag.
    - limit / offset: paginación.
    """

    _DEFAULT_LIMIT: int = 100

    def __init__(self) -> None:
        super().__init__()

    @classmethod
    def get_instance(cls) -> Self:
        return cls()

    async def get_words(self, filters: dict[str, Any]) -> list[dict]:
        """Devuelve la página de registros que cumplen los filtros."""
        joins_sql, where_sql, params = self._build_query_parts(filters)
        limit = int(filters.get("limit", self._DEFAULT_LIMIT))
        offset = int(filters.get("offset", 0))

        query = f"""
        -- get_paginated_words_es
        SELECT DISTINCT
            we.id, we.text, we.word_type, we.notes, we.created_at, we.updated_at
        FROM words_es we
        {joins_sql}
        {where_sql}
        ORDER BY we.updated_at DESC
        LIMIT {limit} OFFSET {offset}
        """
        return await self._query(query, tuple(params))

    async def get_total(self, filters: dict[str, Any]) -> int:
        """Devuelve el total de registros que cumplen los filtros (sin paginar)."""
        joins_sql, where_sql, params = self._build_query_parts(filters)

        query = f"""
        -- count_paginated_words_es
        SELECT COUNT(DISTINCT we.id) AS total
        FROM words_es we
        {joins_sql}
        {where_sql}
        """
        return await self._query_scalar(query, tuple(params), "total") or 0

    def _build_query_parts(self, filters: dict[str, Any]) -> tuple[str, str, list]:
        """Construye JOINs, WHERE y params compartidos por get_words y get_total."""
        params: list = []
        joins: list[str] = []
        where_clauses: list[str] = ["1=1"]

        search = str(filters.get("search", "") or "").strip()
        word_type = filters.get("word_type")
        tags = list(filters.get("tags", []) or [])

        # Búsqueda: texto, nombre de grupo o id exacto (si es numérico)
        if search:
            joins.append("LEFT JOIN word_es_groups weg ON we.id = weg.word_es_id")
            joins.append("LEFT JOIN word_groups wg ON weg.group_id = wg.id")
            word_id = int(search) if search.isdigit() else -1
            where_clauses.append("(we.text LIKE ? OR wg.title LIKE ? OR we.id = ?)")
            params.extend([f"%{search}%", f"%{search}%", word_id])

        # Filtro por tipo de palabra
        if word_type:
            where_clauses.append("we.word_type = ?")
            params.append(word_type)

        # Filtro por tags
        if tags:
            joins.append("INNER JOIN word_es_tags wt ON we.id = wt.word_es_id")
            joins.append("INNER JOIN tags t ON wt.tag_id = t.id")
            placeholders = self._get_placeholders(len(tags))
            where_clauses.append(f"t.name IN ({placeholders})")
            params.extend(tags)

        joins_sql = "\n        ".join(joins)
        where_sql = "WHERE " + " AND ".join(where_clauses)
        return joins_sql, where_sql, params
