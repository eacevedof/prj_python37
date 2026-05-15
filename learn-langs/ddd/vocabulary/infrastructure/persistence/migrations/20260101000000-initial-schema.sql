-- Learn Languages App - Initial Schema
-- Migration: 001_initial_schema.sql

PRAGMA foreign_keys = ON;

-- Catálogo de idiomas disponibles
CREATE TABLE IF NOT EXISTS languages (
    code TEXT PRIMARY KEY,              -- nl_NL, en_US, de_DE...
    name TEXT NOT NULL,                 -- Dutch, English, German...
    native_name TEXT NOT NULL,          -- Nederlands, English, Deutsch...
    flag_emoji TEXT DEFAULT '',         -- 🇳🇱, 🇺🇸, 🇩🇪...
    is_active INTEGER DEFAULT 1,
    created_at TEXT DEFAULT (datetime('now'))
);

-- Palabras en español (tabla principal)
CREATE TABLE IF NOT EXISTS words_es (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    text TEXT NOT NULL,
    word_type TEXT NOT NULL DEFAULT 'WORD',  -- WORD, PHRASE, SENTENCE
    image_path TEXT,
    notes TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now'))
);

CREATE INDEX IF NOT EXISTS idx_words_es_text ON words_es(text);
CREATE INDEX IF NOT EXISTS idx_words_es_word_type ON words_es(word_type);

-- Traducciones a otros idiomas
CREATE TABLE IF NOT EXISTS words_lang (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    word_es_id INTEGER NOT NULL,
    lang_code TEXT NOT NULL,
    text TEXT NOT NULL,
    pronunciation TEXT,
    audio_path TEXT,
    notes TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (word_es_id) REFERENCES words_es(id) ON DELETE CASCADE,
    FOREIGN KEY (lang_code) REFERENCES languages(code),
    UNIQUE(word_es_id, lang_code)
);

CREATE INDEX IF NOT EXISTS idx_words_lang_word_es_id ON words_lang(word_es_id);
CREATE INDEX IF NOT EXISTS idx_words_lang_lang_code ON words_lang(lang_code);

-- Tags para categorizar palabras
CREATE TABLE IF NOT EXISTS tags (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    color TEXT DEFAULT '#6B7280',        -- Hex color para UI
    created_at TEXT DEFAULT (datetime('now'))
);

-- Relación N:M palabras-tags
CREATE TABLE IF NOT EXISTS word_es_tags (
    word_es_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    PRIMARY KEY (word_es_id, tag_id),
    FOREIGN KEY (word_es_id) REFERENCES words_es(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);

-- Relaciones N:M entre palabras (sinónimos, antónimos, etc.)
CREATE TABLE IF NOT EXISTS word_es_relations (
    word_es_id_a INTEGER NOT NULL,
    word_es_id_b INTEGER NOT NULL,
    relation_type TEXT NOT NULL,          -- SYNONYM, ANTONYM, RELATED, CONJUGATION
    PRIMARY KEY (word_es_id_a, word_es_id_b),
    FOREIGN KEY (word_es_id_a) REFERENCES words_es(id) ON DELETE CASCADE,
    FOREIGN KEY (word_es_id_b) REFERENCES words_es(id) ON DELETE CASCADE
);

-- Métricas SM-2 por palabra+idioma
CREATE TABLE IF NOT EXISTS word_metrics (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    word_es_id INTEGER NOT NULL,
    lang_code TEXT NOT NULL,
    repetitions INTEGER DEFAULT 0,        -- Veces consecutivas correctas
    easiness_factor REAL DEFAULT 2.5,     -- EF del algoritmo SM-2
    interval_days INTEGER DEFAULT 1,      -- Días hasta próximo repaso
    next_review_at TEXT,                  -- Fecha próximo repaso
    last_reviewed_at TEXT,
    total_attempts INTEGER DEFAULT 0,
    total_score REAL DEFAULT 0.0,         -- Suma de scores para promedio
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (word_es_id) REFERENCES words_es(id) ON DELETE CASCADE,
    FOREIGN KEY (lang_code) REFERENCES languages(code),
    UNIQUE(word_es_id, lang_code)
);

CREATE INDEX IF NOT EXISTS idx_word_metrics_next_review ON word_metrics(next_review_at);
CREATE INDEX IF NOT EXISTS idx_word_metrics_lang_code ON word_metrics(lang_code);

-- Sesiones de estudio/repaso
CREATE TABLE IF NOT EXISTS study_sessions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    lang_code TEXT NOT NULL,
    study_mode TEXT NOT NULL DEFAULT 'TYPING',  -- TYPING, PRESENTATION
    started_at TEXT DEFAULT (datetime('now')),
    finished_at TEXT,                     -- NULL si en progreso
    total_words INTEGER DEFAULT 0,
    total_score REAL DEFAULT 0.0,
    average_score REAL DEFAULT 0.0,
    tags_filter TEXT,                     -- JSON array de tags
    FOREIGN KEY (lang_code) REFERENCES languages(code)
);

CREATE INDEX IF NOT EXISTS idx_study_sessions_lang_code ON study_sessions(lang_code);
CREATE INDEX IF NOT EXISTS idx_study_sessions_started_at ON study_sessions(started_at);

-- Respuestas individuales por sesión (histórico)
CREATE TABLE IF NOT EXISTS session_answers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    session_id INTEGER NOT NULL,
    word_es_id INTEGER NOT NULL,
    user_input TEXT,                      -- Respuesta del usuario (nullable si PRESENTATION)
    expected_text TEXT NOT NULL,          -- Texto correcto (desnormalizado)
    score REAL NOT NULL DEFAULT 0.0,      -- 0.0 a 1.0
    response_time_ms INTEGER,             -- Tiempo de respuesta en ms
    answered_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (session_id) REFERENCES study_sessions(id) ON DELETE CASCADE,
    FOREIGN KEY (word_es_id) REFERENCES words_es(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_session_answers_session_id ON session_answers(session_id);
CREATE INDEX IF NOT EXISTS idx_session_answers_word_es_id ON session_answers(word_es_id);

-- Datos iniciales: idiomas
INSERT OR IGNORE INTO languages (code, name, native_name, flag_emoji, is_active) VALUES
    ('nl_NL', 'Dutch', 'Nederlands', '🇳🇱', 1),
    ('nl_BE', 'Flemish', 'Vlaams', '🇧🇪', 1),
    ('en_US', 'English (US)', 'English', '🇺🇸', 1),
    ('en_GB', 'English (UK)', 'English', '🇬🇧', 1),
    ('de_DE', 'German', 'Deutsch', '🇩🇪', 1),
    ('fr_FR', 'French', 'Français', '🇫🇷', 1),
    ('pt_BR', 'Portuguese', 'Português', '🇧🇷', 1),
    ('it_IT', 'Italian', 'Italiano', '🇮🇹', 1);

-- Datos iniciales: tags comunes
INSERT OR IGNORE INTO tags (name, color) VALUES
    ('verbos', '#EF4444'),
    ('sustantivos', '#3B82F6'),
    ('adjetivos', '#10B981'),
    ('adverbios', '#F59E0B'),
    ('preposiciones', '#8B5CF6'),
    ('frases', '#EC4899'),
    ('básico', '#6B7280'),
    ('intermedio', '#F97316'),
    ('avanzado', '#DC2626'),
    ('cotidiano', '#14B8A6'),
    ('formal', '#6366F1'),
    ('coloquial', '#84CC16');
