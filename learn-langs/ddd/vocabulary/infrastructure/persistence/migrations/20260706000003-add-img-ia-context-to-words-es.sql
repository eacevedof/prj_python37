-- Learn Languages App - Contexto manual para generacion de imagenes IA
-- Migration: 20260706000003-add-img-ia-context-to-words-es.sql
-- Description: Anade words_es.img_ia_context. Si tiene datos, es el UNICO
--   contexto que se pasa a la IA al generar la imagen (se descartan grupos,
--   tags y notas). Si esta vacio, se mantiene el contexto automatico.

ALTER TABLE words_es ADD COLUMN img_ia_context TEXT;
