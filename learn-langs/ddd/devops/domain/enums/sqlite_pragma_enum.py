"""PRAGMAs de SQLite usados por el runner de migraciones."""

from enum import Enum


class SqlitePragmaEnum(str, Enum):
    """Sentencias PRAGMA que se ejecutan antes de tocar el esquema."""

    FOREIGN_KEYS_ON = "PRAGMA foreign_keys = ON"
