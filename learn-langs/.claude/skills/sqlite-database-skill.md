---
name: sqlite-database
description: SQLite database patterns for Python applications. Parameterized queries, performance optimization, migrations, and async operations with aiosqlite. Use when working with SQLite databases, writing queries, or optimizing database operations.
---

# SQLite Database Expert (Python)

Comprehensive guidance for SQLite database development in Python applications, emphasizing security, performance, and async patterns.

## When to Use This Skill

- Creating or modifying SQLite database schemas
- Writing queries (SELECT, INSERT, UPDATE, DELETE)
- Optimizing database performance
- Implementing migrations
- Using aiosqlite for async operations
- Preventing SQL injection vulnerabilities

## Risk Level: MEDIUM

SQLite databases handle user data, present SQL injection risks without proper parameterization, and require careful migration management.

## Core Principles

1. **Security First** — Always use parameterized queries; NEVER concatenate user input
2. **Performance Aware** — WAL mode, prepared statements, batch operations
3. **Async Native** — Use aiosqlite for non-blocking database operations
4. **Transaction Safety** — ACID compliance with proper commit/rollback
5. **Migration Discipline** — Versioned schema changes

## Quick Start

```python
import aiosqlite

async def get_connection(db_path: str) -> aiosqlite.Connection:
    conn = await aiosqlite.connect(db_path)
    conn.row_factory = aiosqlite.Row
    await conn.execute("PRAGMA foreign_keys = ON")
    await conn.execute("PRAGMA journal_mode = WAL")
    return conn
```

## Fundamental Patterns

### Pattern 1: Database Initialization with PRAGMAs

Always configure SQLite for optimal performance and safety.

```python
async def initialize_database(db_path: str) -> None:
    """Initialize SQLite with performance and safety PRAGMAs."""
    conn = await aiosqlite.connect(db_path)
    try:
        # Performance PRAGMAs
        await conn.execute("PRAGMA journal_mode = WAL")      # Write-Ahead Logging
        await conn.execute("PRAGMA synchronous = NORMAL")    # Balance speed/safety
        await conn.execute("PRAGMA cache_size = -64000")     # 64MB cache
        await conn.execute("PRAGMA temp_store = MEMORY")     # Temp tables in memory

        # Safety PRAGMAs
        await conn.execute("PRAGMA foreign_keys = ON")       # Enforce FK constraints
        await conn.execute("PRAGMA busy_timeout = 5000")     # 5s timeout on locks

        await conn.commit()
    finally:
        await conn.close()
```

### Pattern 2: Parameterized Queries (CRITICAL)

**NEVER use string formatting for queries.** Always use parameters.

```python
# WRONG - SQL Injection vulnerability!
query = f"SELECT * FROM users WHERE name = '{user_input}'"  # NEVER DO THIS

# CORRECT - Positional parameters
query = "SELECT * FROM users WHERE name = ?"
await conn.execute(query, (user_input,))

# CORRECT - Named parameters
query = "SELECT * FROM users WHERE name = :name AND age > :min_age"
await conn.execute(query, {"name": user_input, "min_age": 18})
```

### Pattern 3: Safe Dynamic Column/Table Names

When column or table names must be dynamic, use whitelisting.

```python
ALLOWED_COLUMNS = {"name", "email", "created_at", "status"}
ALLOWED_TABLES = {"users", "orders", "products"}

def safe_column(column: str) -> str:
    """Validate and return safe column name."""
    if column not in ALLOWED_COLUMNS:
        raise ValueError(f"Invalid column: {column}")
    return column

def safe_order_by(column: str, direction: str = "ASC") -> str:
    """Build safe ORDER BY clause."""
    column = safe_column(column)
    direction = "DESC" if direction.upper() == "DESC" else "ASC"
    return f"{column} {direction}"
```

### Pattern 4: Transaction Management

Use transactions for data integrity.

```python
async def transfer_funds(
    conn: aiosqlite.Connection,
    from_account: int,
    to_account: int,
    amount: float,
) -> bool:
    """Transfer funds between accounts atomically."""
    try:
        await conn.execute("BEGIN TRANSACTION")

        # Debit
        await conn.execute(
            "UPDATE accounts SET balance = balance - ? WHERE id = ?",
            (amount, from_account)
        )

        # Credit
        await conn.execute(
            "UPDATE accounts SET balance = balance + ? WHERE id = ?",
            (amount, to_account)
        )

        await conn.commit()
        return True

    except Exception:
        await conn.rollback()
        raise
```

### Pattern 5: Batch Operations

Use executemany for bulk inserts.

```python
async def bulk_insert_words(
    conn: aiosqlite.Connection,
    words: list[dict],
) -> int:
    """Insert multiple words efficiently."""
    query = """
        INSERT INTO words_es (text, word_type, notes)
        VALUES (:text, :word_type, :notes)
    """

    await conn.executemany(query, words)
    await conn.commit()

    return len(words)
```

## Advanced Patterns

### Pattern 6: Connection Context Manager

Ensure connections are always closed.

```python
from contextlib import asynccontextmanager
from typing import AsyncGenerator

@asynccontextmanager
async def get_db_connection(db_path: str) -> AsyncGenerator[aiosqlite.Connection, None]:
    """Context manager for database connections."""
    conn = await aiosqlite.connect(db_path)
    conn.row_factory = aiosqlite.Row
    await conn.execute("PRAGMA foreign_keys = ON")

    try:
        yield conn
    finally:
        await conn.close()

# Usage
async with get_db_connection("app.db") as conn:
    result = await conn.execute("SELECT * FROM users")
    rows = await result.fetchall()
```

### Pattern 7: Full-Text Search (FTS5)

Implement efficient text search.

```sql
-- Create FTS5 virtual table
CREATE VIRTUAL TABLE words_fts USING fts5(
    text,
    content='words_es',
    content_rowid='id'
);

-- Triggers to keep FTS in sync
CREATE TRIGGER words_es_ai AFTER INSERT ON words_es BEGIN
    INSERT INTO words_fts(rowid, text) VALUES (new.id, new.text);
END;

CREATE TRIGGER words_es_ad AFTER DELETE ON words_es BEGIN
    INSERT INTO words_fts(words_fts, rowid, text) VALUES('delete', old.id, old.text);
END;

CREATE TRIGGER words_es_au AFTER UPDATE ON words_es BEGIN
    INSERT INTO words_fts(words_fts, rowid, text) VALUES('delete', old.id, old.text);
    INSERT INTO words_fts(rowid, text) VALUES (new.id, new.text);
END;
```

```python
async def search_words(conn: aiosqlite.Connection, query: str) -> list[dict]:
    """Search words using FTS5."""
    sql = """
        SELECT w.* FROM words_es w
        INNER JOIN words_fts fts ON w.id = fts.rowid
        WHERE words_fts MATCH ?
        ORDER BY rank
        LIMIT 50
    """
    cursor = await conn.execute(sql, (query,))
    rows = await cursor.fetchall()
    return [dict(row) for row in rows]
```

### Pattern 8: Migration Management

Version-controlled schema changes.

```python
MIGRATIONS = [
    # Migration 001
    """
    CREATE TABLE IF NOT EXISTS schema_version (
        version INTEGER PRIMARY KEY,
        applied_at TEXT DEFAULT (datetime('now'))
    );
    """,
    # Migration 002
    """
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        created_at TEXT DEFAULT (datetime('now'))
    );
    """,
    # Migration 003
    """
    ALTER TABLE users ADD COLUMN status TEXT DEFAULT 'active';
    """,
]

async def run_migrations(conn: aiosqlite.Connection) -> int:
    """Run pending migrations."""
    # Get current version
    try:
        cursor = await conn.execute(
            "SELECT MAX(version) FROM schema_version"
        )
        row = await cursor.fetchone()
        current_version = row[0] or 0
    except Exception:
        current_version = 0

    # Apply pending migrations
    applied = 0
    for i, migration in enumerate(MIGRATIONS, start=1):
        if i > current_version:
            await conn.executescript(migration)
            await conn.execute(
                "INSERT INTO schema_version (version) VALUES (?)",
                (i,)
            )
            await conn.commit()
            applied += 1

    return applied
```

### Pattern 9: Query Builder Helper

Type-safe query construction.

```python
from dataclasses import dataclass, field
from typing import Any

@dataclass
class QueryBuilder:
    """Simple query builder with parameterized values."""

    _select: list[str] = field(default_factory=list)
    _from: str = ""
    _where: list[str] = field(default_factory=list)
    _params: list[Any] = field(default_factory=list)
    _order_by: str = ""
    _limit: int | None = None
    _offset: int | None = None

    def select(self, *columns: str) -> "QueryBuilder":
        self._select.extend(columns)
        return self

    def from_table(self, table: str) -> "QueryBuilder":
        self._from = table
        return self

    def where(self, condition: str, *params: Any) -> "QueryBuilder":
        self._where.append(condition)
        self._params.extend(params)
        return self

    def order_by(self, column: str, direction: str = "ASC") -> "QueryBuilder":
        self._order_by = f"{column} {direction}"
        return self

    def limit(self, limit: int, offset: int = 0) -> "QueryBuilder":
        self._limit = limit
        self._offset = offset
        return self

    def build(self) -> tuple[str, tuple]:
        parts = [f"SELECT {', '.join(self._select) or '*'}"]
        parts.append(f"FROM {self._from}")

        if self._where:
            parts.append(f"WHERE {' AND '.join(self._where)}")

        if self._order_by:
            parts.append(f"ORDER BY {self._order_by}")

        if self._limit:
            parts.append(f"LIMIT {self._limit}")
            if self._offset:
                parts.append(f"OFFSET {self._offset}")

        return " ".join(parts), tuple(self._params)

# Usage
query, params = (
    QueryBuilder()
    .select("id", "text", "word_type")
    .from_table("words_es")
    .where("word_type = ?", "WORD")
    .where("created_at > ?", "2024-01-01")
    .order_by("created_at", "DESC")
    .limit(20)
    .build()
)
```

## Common Mistakes

1. **String concatenation in queries** → Use parameterized queries
2. **Not closing connections** → Use context managers or try/finally
3. **Missing foreign_keys PRAGMA** → Always enable for data integrity
4. **Large transactions** → Break into smaller batches
5. **No indexes on query columns** → Add indexes for frequently filtered columns
6. **Synchronous operations in async code** → Use aiosqlite, not sqlite3

## Performance Tips

1. **Use WAL mode** for concurrent reads
2. **Create indexes** on columns used in WHERE, JOIN, ORDER BY
3. **Use LIMIT** to avoid fetching unnecessary rows
4. **Batch inserts** with executemany
5. **Use EXISTS** instead of COUNT for existence checks
6. **VACUUM** periodically to reclaim space

## Security Checklist

- [ ] All queries use parameterized values
- [ ] Dynamic column/table names are whitelisted
- [ ] Database file has restricted permissions
- [ ] Foreign keys are enabled
- [ ] User input is validated before reaching database layer
- [ ] Error messages don't expose database structure
