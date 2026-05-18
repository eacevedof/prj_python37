-- Learn Languages App - Add source field to word_groups
-- Migration: 20260518000000-add-source-to-word-groups.sql
-- Description: Agregar campo source para rastrear el origen de las palabras del grupo

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- ALTER TABLE: word_groups - Agregar campo source
-- ==============================================================================

ALTER TABLE word_groups ADD COLUMN source TEXT;

-- ==============================================================================
-- COMENTARIO: El campo source puede contener:
-- - URL de un PDF online
-- - Path de un PDF local
-- - URL de un video (YouTube, etc.)
-- - URL de un articulo
-- - Nombre de archivo
-- - Cualquier otra fuente de donde se extrajeron las palabras
-- ==============================================================================
