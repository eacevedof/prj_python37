from typing import final


@final
class MigrationSqlEnum:
    """SQL fijo que usa el migrador.

    BEGIN / COMMIT envuelven el contenido de cada fichero .sql. Hace falta porque
    `executescript()` de Python **no abre transaccion por su cuenta**: sin estas
    dos lineas, un fichero con tres sentencias que falla en la segunda dejaria la
    primera aplicada y la base a medias.

    Con ellas, o entra el fichero entero o no entra nada. SQLite si soporta DDL
    transaccional (a diferencia de otros motores), asi que un CREATE TABLE dentro
    de una transaccion se puede deshacer.
    """

    BEGIN = "BEGIN;"
    COMMIT = "COMMIT;"
    TABLE_EXISTS = "SELECT name FROM sqlite_master WHERE type = 'table' AND name = ? LIMIT 1"
    SELECT_APPLIED = "SELECT file_name FROM migrations"
    INSERT_APPLIED = "INSERT INTO migrations (file_name) VALUES (?)"
    MIGRATIONS_TABLE = "migrations"
