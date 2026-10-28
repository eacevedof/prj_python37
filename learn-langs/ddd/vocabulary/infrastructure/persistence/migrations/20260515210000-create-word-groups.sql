-- Learn Languages App - Word Groups System
-- Migration: 20260515210000-create-word-groups.sql
-- Description: Sistema de grupos de palabras con relacion N:M

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- TABLA: word_groups
-- ==============================================================================

CREATE TABLE IF NOT EXISTS word_groups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL UNIQUE,
    description TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_word_groups_title ON word_groups(title);

-- ==============================================================================
-- TABLA: word_es_groups (relacion N:M)
-- ==============================================================================

CREATE TABLE IF NOT EXISTS word_es_groups (
    word_es_id INTEGER NOT NULL,
    group_id INTEGER NOT NULL,
    PRIMARY KEY (word_es_id, group_id),
    FOREIGN KEY (word_es_id) REFERENCES words_es(id) ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES word_groups(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_word_es_groups_word_es_id ON word_es_groups(word_es_id);
CREATE INDEX IF NOT EXISTS idx_word_es_groups_group_id ON word_es_groups(group_id);

-- ==============================================================================
-- DATOS INICIALES: Grupo por defecto "generic"
-- ==============================================================================

INSERT INTO word_groups (title, description)
VALUES ('generic', 'Default group for all words');

-- ==============================================================================
-- RELACIONAR PALABRAS EXISTENTES CON GRUPO "generic"
-- ==============================================================================

-- Insertar relacion para todas las palabras existentes
INSERT INTO word_es_groups (word_es_id, group_id)
SELECT we.id, wg.id
FROM words_es we
CROSS JOIN word_groups wg
WHERE wg.title = 'generic'
  AND NOT EXISTS (
    SELECT 1 FROM word_es_groups weg
    WHERE weg.word_es_id = we.id AND weg.group_id = wg.id
  );
