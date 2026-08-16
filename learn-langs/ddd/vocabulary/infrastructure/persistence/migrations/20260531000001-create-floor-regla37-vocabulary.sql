-- Learn Languages App - Vocabulario de Floor - Regla 37
-- Migration: 20260531000001-create-floor-regla37-vocabulary.sql
-- Source: https://www.youtube.com/watch?v=5GjEH-5TXtw
--
-- ⚠️ NEUTRALIZADA (2026-07-06):
-- Esta migración nunca llegó a registrarse en la BD real: falló a mitad por un
-- UNIQUE(word_es_id, lang_code) en words_lang y quedó aplicada PARCIALMENTE.
-- Después el vocabulario se corrigió y amplió A MANO desde la app (textos,
-- notas/contexto para imágenes, grupos), por lo que re-ejecutar los INSERT
-- originales duplicaría palabras (words_es.text no es UNIQUE).
--
-- El estado real y autoritativo de este vocabulario lo aporta la migración
-- snapshot: 20260706000001-sync-vocabulary-from-db.sql
--
-- El contenido original de este fichero se conserva en git (commit 29b1f165).

SELECT 1;
