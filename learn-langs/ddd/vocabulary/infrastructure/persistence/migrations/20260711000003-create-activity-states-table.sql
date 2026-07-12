-- Learn Languages App - Tabla de estado de actividad
-- Migration: 20260711000003-create-activity-states-table.sql
-- Description: Guarda lo último que se estaba haciendo en cada actividad (Aprendizaje /
--   Examen con imágenes) para poder retomarla desde el Home: idioma, tags, grupo,
--   palabra en curso y posición. Una fila por actividad (UPSERT); se borra al
--   completar la sesión. Aditiva e idempotente (CREATE TABLE IF NOT EXISTS).

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS activity_states (
    activity TEXT PRIMARY KEY,                  -- WORD_SLIDER | IMAGE_STUDY
    lang_code TEXT NOT NULL,
    tags TEXT NOT NULL DEFAULT '[]',            -- JSON array de nombres de tags
    group_id INTEGER,                           -- NULL = sin filtro de grupo
    word_es_id INTEGER NOT NULL DEFAULT 0,      -- palabra donde se estaba
    word_index INTEGER NOT NULL DEFAULT 0,      -- posición dentro de la sesión
    total_words INTEGER NOT NULL DEFAULT 0,
    is_random_order INTEGER NOT NULL DEFAULT 0, -- solo aplica al slider
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now'))
);
