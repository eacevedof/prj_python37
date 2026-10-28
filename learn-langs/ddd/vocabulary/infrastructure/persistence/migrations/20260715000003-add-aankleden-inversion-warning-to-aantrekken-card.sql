-- Learn Languages App - Aviso aankleden y inversion is/het en la tarjeta aantrekken (id 669)
-- Migration: 20260715000003-add-aankleden-inversion-warning-to-aantrekken-card.sql
-- Description: Anade un bloque ⚠️ al rules_help de la tarjeta "Trek je jas aan, het is koud"
--   (grupo verbos separables, id 669) con dos errores frecuentes:
--   (1) aankleden = vestirse EN GENERAL (kleed je aan = vistete); no se usa para una prenda
--   concreta, no existe *jas aankleden* ni *opkleden* -> para una prenda va aantrekken.
--   (2) "…, is het koud" con inversion (verbo antes del sujeto) es una PREGUNTA (¿hace frio?);
--   la afirmacion explicativa lleva el sujeto delante: "…, het is koud".
--   Keyeada por notes (unico), idempotente (guarda NOT LIKE '%⚠️%'). Solo UPDATE de
--   words_es.rules_help; no toca words_lang/audio, imagenes ni notes.

PRAGMA foreign_keys = ON;

UPDATE words_es SET rules_help = rules_help || '

⚠️ Errores frecuentes:
• aankleden ≠ aantrekken: aankleden sí existe, pero significa «vestirse» en general (kleed je aan = vístete), no se usa para una prenda concreta. No puedes combinar jas con aankleden ni con opkleden → para una prenda concreta (jas, trui, schoenen) siempre aantrekken.
• «Trek je jas aan, is het koud» es incorrecta tal cual está escrita: la inversión (verbo antes del sujeto) convierte la segunda parte en PREGUNTA («¿hace frío?»). No funciona como afirmación explicativa. La afirmación lleva el sujeto delante → Trek je jas aan, het is koud (ponte la chaqueta, hace frío).'
WHERE notes = 'Verbo separable: aantrekken (imperativo)' AND rules_help NOT LIKE '%⚠️%';
