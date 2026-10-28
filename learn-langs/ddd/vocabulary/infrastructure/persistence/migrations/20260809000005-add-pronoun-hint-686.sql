-- Learn Languages App - Pista de pronombre en frases de 3a persona (tarjeta 686)
-- Migration: 20260809000005-add-pronoun-hint-686.sql
-- Description: El español omite el sujeto en 3a persona ("se enfada enseguida") pero el
--   neerlandes exige hij/zij/het. Sin la pista no se puede elegir el pronombre correcto.
--   Se anade el pronombre entre parentesis al final del texto_es para saber como traducir.
--   686: "se enfada enseguida" -> "se enfada enseguida (el)" (NL: Hij wordt snel boos).
--   Idempotente: solo actualiza la fila cuyo texto coincide exactamente (2a ejecucion = 0).

PRAGMA foreign_keys = ON;

UPDATE words_es SET text = 'se enfada enseguida (él)'
WHERE text = 'se enfada enseguida'
  AND id IN (SELECT word_es_id FROM words_lang WHERE lang_code='nl_NL' AND text='Hij wordt snel boos.');
