-- Learn Languages App - Renombrar grupo "pronomen" a "pronombres - voornaamwoorden"
-- Migration: 20260712000003-rename-pronomen-group.sql
-- Description: El grupo de pronombres de objeto pasa a llamarse con el patrón
--   español - neerlandés: "pronombres - voornaamwoorden". Se hace por UPDATE (y no
--   renombrando la migración de creación) porque la original ya está aplicada en la
--   BD viva. Idempotente: si ya no existe "pronomen", no hace nada.

PRAGMA foreign_keys = ON;

UPDATE word_groups
SET title = 'pronombres - voornaamwoorden',
    updated_at = datetime('now')
WHERE title = 'pronomen';
