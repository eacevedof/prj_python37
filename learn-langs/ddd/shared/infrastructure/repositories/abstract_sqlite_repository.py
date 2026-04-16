"""Repositorio abstracto para SQLite."""

from abc import ABC
from typing import Any

from ddd.shared.infrastructure.components.sqlite_connector import SqliteConnector
from ddd.shared.infrastructure.components.logger import Logger


class AbstractSqliteRepository(ABC):
    """Repositorio base con helpers comunes para SQLite."""

    _sqlite: SqliteConnector
    _logger: Logger
    _last_insert_id: int | None = None

    def __init__(self) -> None:
        self._sqlite = SqliteConnector.get_instance()
        self._logger = Logger.get_instance()
        self._last_insert_id = None

    # ==================== SQL Helpers ====================

    def _get_integers_sql_in(self, entity_ids: list[int]) -> str:
        """
        Genera una lista de enteros para usar en cláusula IN.

        Args:
            entity_ids: Lista de IDs enteros.

        Returns:
            String con formato "1, 2, 3" o vacío si no hay elementos.
        """
        if not entity_ids:
            return ""
        unique_ids = sorted(set(int(id_) for id_ in entity_ids))
        return ", ".join(str(id_) for id_ in unique_ids)

    def _get_strings_sql_in(self, entity_uuids: list[str]) -> str:
        """
        Genera una lista de strings escapados para usar en cláusula IN.

        Args:
            entity_uuids: Lista de strings/UUIDs.

        Returns:
            String con formato "'a', 'b', 'c'" o vacío si no hay elementos.
        """
        if not entity_uuids:
            return ""
        unique_uuids = sorted(set(entity_uuids))
        escaped = [self._get_escaped_sql_string(uuid) for uuid in unique_uuids]
        return "'" + "', '".join(escaped) + "'"

    def _get_escaped_sql_string(self, string: str) -> str:
        """
        Escapa una string para uso seguro en SQL.

        Args:
            string: String a escapar.

        Returns:
            String escapada.
        """
        string = string.replace("\\", "\\\\")
        return string.replace("'", "''")  # SQLite usa '' para escapar

    def _get_placeholders(self, count: int) -> str:
        """
        Genera placeholders para queries parametrizadas.

        Args:
            count: Número de placeholders.

        Returns:
            String con formato "?, ?, ?" o vacío si count es 0.
        """
        if count <= 0:
            return ""
        return ", ".join(["?"] * count)

    # ==================== Type Mapping ====================

    def _map_column_to_int(
        self,
        objects: list[dict],
        column: str,
    ) -> list[dict]:
        """
        Convierte una columna a entero en una lista de dicts.

        Args:
            objects: Lista de diccionarios.
            column: Nombre de la columna a convertir.

        Returns:
            La misma lista con la columna convertida.
        """
        for obj in objects:
            if column in obj and obj[column] is not None:
                obj[column] = int(obj[column])
        return objects

    def _map_column_to_bool(
        self,
        objects: list[dict],
        column: str,
    ) -> list[dict]:
        """
        Convierte una columna a booleano en una lista de dicts.

        Args:
            objects: Lista de diccionarios.
            column: Nombre de la columna a convertir.

        Returns:
            La misma lista con la columna convertida.
        """
        for obj in objects:
            if column in obj:
                obj[column] = bool(obj[column])
        return objects

    def _map_columns_to_int(
        self,
        objects: list[dict],
        columns: list[str],
    ) -> list[dict]:
        """
        Convierte múltiples columnas a entero.

        Args:
            objects: Lista de diccionarios.
            columns: Lista de nombres de columnas.

        Returns:
            La misma lista con las columnas convertidas.
        """
        for column in columns:
            self._map_column_to_int(objects, column)
        return objects

    # ==================== CRUD Operations ====================

    async def _insert_into(
        self,
        table: str,
        data: dict[str, Any],
    ) -> int:
        """
        Inserta un registro en una tabla.

        Args:
            table: Nombre de la tabla.
            data: Diccionario con columnas y valores.

        Returns:
            ID del registro insertado o 0 si falla.
        """
        self._last_insert_id = None

        if not data:
            self._logger.error(f"insert_into {table}: empty data")
            return 0

        columns = ", ".join(data.keys())
        placeholders = self._get_placeholders(len(data))
        values = tuple(data.values())

        query = f"INSERT INTO {table} ({columns}) VALUES ({placeholders})"

        try:
            self._last_insert_id = await self._sqlite.insert(query, values)
            return self._last_insert_id
        except Exception as e:
            self._logger.error(f"insert_into {table}: {e}")
            return 0

    async def _update_where(
        self,
        table: str,
        data: dict[str, Any],
        where: str,
        where_params: tuple = (),
    ) -> int:
        """
        Actualiza registros en una tabla.

        Args:
            table: Nombre de la tabla.
            data: Diccionario con columnas y valores a actualizar.
            where: Cláusula WHERE (sin la palabra WHERE).
            where_params: Parámetros para la cláusula WHERE.

        Returns:
            Número de filas afectadas.
        """
        if not data:
            self._logger.error(f"update_where {table}: empty data")
            return 0

        set_clause = ", ".join(f"{col} = ?" for col in data.keys())
        values = tuple(data.values()) + where_params

        query = f"UPDATE {table} SET {set_clause} WHERE {where}"

        try:
            return await self._sqlite.update(query, values)
        except Exception as e:
            self._logger.error(f"update_where {table}: {e}")
            return 0

    async def _delete_where(
        self,
        table: str,
        where: str,
        where_params: tuple = (),
    ) -> int:
        """
        Elimina registros de una tabla.

        Args:
            table: Nombre de la tabla.
            where: Cláusula WHERE (sin la palabra WHERE).
            where_params: Parámetros para la cláusula WHERE.

        Returns:
            Número de filas afectadas.
        """
        query = f"DELETE FROM {table} WHERE {where}"

        try:
            return await self._sqlite.delete(query, where_params)
        except Exception as e:
            self._logger.error(f"delete_where {table}: {e}")
            return 0

    async def _query(self, sql: str, params: tuple = ()) -> list[dict]:
        """
        Ejecuta una query SELECT y retorna los resultados.

        Args:
            sql: Query SQL.
            params: Parámetros de la query.

        Returns:
            Lista de diccionarios con los resultados.
        """
        self._logger.sql(sql)
        try:
            return await self._sqlite.fetch_all(sql, params)
        except Exception as e:
            self._logger.error(f"query error: {e}")
            return []

    async def _query_one(self, sql: str, params: tuple = ()) -> dict | None:
        """
        Ejecuta una query SELECT y retorna un solo resultado.

        Args:
            sql: Query SQL.
            params: Parámetros de la query.

        Returns:
            Diccionario con el resultado o None.
        """
        self._logger.sql(sql)
        try:
            return await self._sqlite.fetch_one(sql, params)
        except Exception as e:
            self._logger.error(f"query_one error: {e}")
            return None

    async def _query_scalar(
        self,
        sql: str,
        params: tuple = (),
        column: str = "count",
    ) -> Any:
        """
        Ejecuta una query y retorna un valor escalar.

        Args:
            sql: Query SQL.
            params: Parámetros de la query.
            column: Nombre de la columna a retornar.

        Returns:
            Valor escalar o None.
        """
        result = await self._query_one(sql, params)
        if result and column in result:
            return result[column]
        return None

    # ==================== Getters ====================

    def get_last_insert_id(self) -> int | None:
        """Retorna el último ID insertado."""
        return self._last_insert_id
