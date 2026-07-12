-- Learn Languages App - Grupo "zullen-conjugation"
-- Migration: 20260711000001-create-zullen-conjugation-group.sql
-- Description: Grupo dedicado a la conjugacion de zullen (zal/zult/zullen) y su
--   condicional zou/zouden, cada forma como frase aislada (declarativas y preguntas,
--   incluida la formal con u). Cada frase lleva rules_help con la tabla de conjugacion
--   y la formula de estructura (principal / pregunta), y pronunciation generada con
--   DutchToSpanishPhoneticService.
--   Idempotente y 100% aditiva: INSERT con WHERE NOT EXISTS / OR IGNORE.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'zullen-conjugation',
    'Conjugación de zullen (zal/zult/zullen) y condicional zou/zouden: cada forma como frase aislada, con preguntas',
    'migracion'
);

-- ==============================================================================
-- ik zal: Ik zal het doen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'lo haré', 'PHRASE', 'Conjugación de zullen: ik zal', 'Conjugación de zullen (futuro):
• ik zal — yo
• jij/je zult (o zal) — tú · en pregunta pierde la -t: zul jij?
• u zult — usted (formal)
• hij/zij/het zal — él/ella/ello
• wij/we zullen — nosotros
• jullie zullen — vosotros
• zij/ze zullen — ellos

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'lo haré' AND notes = 'Conjugación de zullen: ik zal');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'lo haré' AND notes = 'Conjugación de zullen: ik zal' LIMIT 1),
    'nl_NL', 'Ik zal het doen.', 'Ik sal et dun.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'lo haré' AND notes = 'Conjugación de zullen: ik zal' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'lo haré' AND notes = 'Conjugación de zullen: ik zal' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- jij zult: Jij zult het zien.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ya lo verás', 'PHRASE', 'Conjugación de zullen: jij zult', 'Conjugación de zullen (futuro):
• ik zal — yo
• jij/je zult (o zal) — tú · en pregunta pierde la -t: zul jij?
• u zult — usted (formal)
• hij/zij/het zal — él/ella/ello
• wij/we zullen — nosotros
• jullie zullen — vosotros
• zij/ze zullen — ellos

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'ya lo verás' AND notes = 'Conjugación de zullen: jij zult');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ya lo verás' AND notes = 'Conjugación de zullen: jij zult' LIMIT 1),
    'nl_NL', 'Jij zult het zien.', 'Yei sult et sin.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ya lo verás' AND notes = 'Conjugación de zullen: jij zult' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ya lo verás' AND notes = 'Conjugación de zullen: jij zult' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- u zult: U zult tevreden zijn.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'usted quedará satisfecho', 'PHRASE', 'Conjugación de zullen: u zult', 'Conjugación de zullen (futuro):
• ik zal — yo
• jij/je zult (o zal) — tú · en pregunta pierde la -t: zul jij?
• u zult — usted (formal)
• hij/zij/het zal — él/ella/ello
• wij/we zullen — nosotros
• jullie zullen — vosotros
• zij/ze zullen — ellos

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'usted quedará satisfecho' AND notes = 'Conjugación de zullen: u zult');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'usted quedará satisfecho' AND notes = 'Conjugación de zullen: u zult' LIMIT 1),
    'nl_NL', 'U zult tevreden zijn.', 'U sult tefreden sein.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'usted quedará satisfecho' AND notes = 'Conjugación de zullen: u zult' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'usted quedará satisfecho' AND notes = 'Conjugación de zullen: u zult' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- hij zal: Hij zal morgen komen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'él vendrá mañana', 'PHRASE', 'Conjugación de zullen: hij zal', 'Conjugación de zullen (futuro):
• ik zal — yo
• jij/je zult (o zal) — tú · en pregunta pierde la -t: zul jij?
• u zult — usted (formal)
• hij/zij/het zal — él/ella/ello
• wij/we zullen — nosotros
• jullie zullen — vosotros
• zij/ze zullen — ellos

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'él vendrá mañana' AND notes = 'Conjugación de zullen: hij zal');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'él vendrá mañana' AND notes = 'Conjugación de zullen: hij zal' LIMIT 1),
    'nl_NL', 'Hij zal morgen komen.', 'Ei sal morjen komen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'él vendrá mañana' AND notes = 'Conjugación de zullen: hij zal' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'él vendrá mañana' AND notes = 'Conjugación de zullen: hij zal' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zij zal: Zij zal thuis zijn.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ella estará en casa', 'PHRASE', 'Conjugación de zullen: zij zal', 'Conjugación de zullen (futuro):
• ik zal — yo
• jij/je zult (o zal) — tú · en pregunta pierde la -t: zul jij?
• u zult — usted (formal)
• hij/zij/het zal — él/ella/ello
• wij/we zullen — nosotros
• jullie zullen — vosotros
• zij/ze zullen — ellos

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'ella estará en casa' AND notes = 'Conjugación de zullen: zij zal');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ella estará en casa' AND notes = 'Conjugación de zullen: zij zal' LIMIT 1),
    'nl_NL', 'Zij zal thuis zijn.', 'Sei sal taus sein.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ella estará en casa' AND notes = 'Conjugación de zullen: zij zal' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ella estará en casa' AND notes = 'Conjugación de zullen: zij zal' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- wij zullen: Wij zullen het proberen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'lo intentaremos', 'PHRASE', 'Conjugación de zullen: wij zullen', 'Conjugación de zullen (futuro):
• ik zal — yo
• jij/je zult (o zal) — tú · en pregunta pierde la -t: zul jij?
• u zult — usted (formal)
• hij/zij/het zal — él/ella/ello
• wij/we zullen — nosotros
• jullie zullen — vosotros
• zij/ze zullen — ellos

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'lo intentaremos' AND notes = 'Conjugación de zullen: wij zullen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'lo intentaremos' AND notes = 'Conjugación de zullen: wij zullen' LIMIT 1),
    'nl_NL', 'Wij zullen het proberen.', 'Uei sullen et proberen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'lo intentaremos' AND notes = 'Conjugación de zullen: wij zullen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'lo intentaremos' AND notes = 'Conjugación de zullen: wij zullen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- jullie zullen: Jullie zullen het leuk vinden.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'os gustará', 'PHRASE', 'Conjugación de zullen: jullie zullen', 'Conjugación de zullen (futuro):
• ik zal — yo
• jij/je zult (o zal) — tú · en pregunta pierde la -t: zul jij?
• u zult — usted (formal)
• hij/zij/het zal — él/ella/ello
• wij/we zullen — nosotros
• jullie zullen — vosotros
• zij/ze zullen — ellos

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'os gustará' AND notes = 'Conjugación de zullen: jullie zullen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'os gustará' AND notes = 'Conjugación de zullen: jullie zullen' LIMIT 1),
    'nl_NL', 'Jullie zullen het leuk vinden.', 'Yulli sullen et lek finden.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'os gustará' AND notes = 'Conjugación de zullen: jullie zullen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'os gustará' AND notes = 'Conjugación de zullen: jullie zullen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zij zullen: Zij zullen later aankomen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ellos llegarán más tarde', 'PHRASE', 'Conjugación de zullen: zij zullen', 'Conjugación de zullen (futuro):
• ik zal — yo
• jij/je zult (o zal) — tú · en pregunta pierde la -t: zul jij?
• u zult — usted (formal)
• hij/zij/het zal — él/ella/ello
• wij/we zullen — nosotros
• jullie zullen — vosotros
• zij/ze zullen — ellos

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'ellos llegarán más tarde' AND notes = 'Conjugación de zullen: zij zullen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ellos llegarán más tarde' AND notes = 'Conjugación de zullen: zij zullen' LIMIT 1),
    'nl_NL', 'Zij zullen later aankomen.', 'Sei sullen later ankomen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ellos llegarán más tarde' AND notes = 'Conjugación de zullen: zij zullen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ellos llegarán más tarde' AND notes = 'Conjugación de zullen: zij zullen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zal ik? (pregunta): Zal ik koken?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿cocino yo?', 'PHRASE', 'Conjugación de zullen: zal ik? (pregunta)', 'Conjugación de zullen (futuro):
• ik zal — yo
• jij/je zult (o zal) — tú · en pregunta pierde la -t: zul jij?
• u zult — usted (formal)
• hij/zij/het zal — él/ella/ello
• wij/we zullen — nosotros
• jullie zullen — vosotros
• zij/ze zullen — ellos

📐 Pregunta sí/no: zal/zul/zullen/zou/zouden en 1ª posición + sujeto + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿cocino yo?' AND notes = 'Conjugación de zullen: zal ik? (pregunta)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿cocino yo?' AND notes = 'Conjugación de zullen: zal ik? (pregunta)' LIMIT 1),
    'nl_NL', 'Zal ik koken?', 'Sal ik koken?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿cocino yo?' AND notes = 'Conjugación de zullen: zal ik? (pregunta)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿cocino yo?' AND notes = 'Conjugación de zullen: zal ik? (pregunta)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zul jij? (pregunta, pierde la -t): Zul jij er zijn?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿estarás allí?', 'PHRASE', 'Conjugación de zullen: zul jij? (pregunta, pierde la -t)', 'Conjugación de zullen (futuro):
• ik zal — yo
• jij/je zult (o zal) — tú · en pregunta pierde la -t: zul jij?
• u zult — usted (formal)
• hij/zij/het zal — él/ella/ello
• wij/we zullen — nosotros
• jullie zullen — vosotros
• zij/ze zullen — ellos

📐 Pregunta sí/no: zal/zul/zullen/zou/zouden en 1ª posición + sujeto + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿estarás allí?' AND notes = 'Conjugación de zullen: zul jij? (pregunta, pierde la -t)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿estarás allí?' AND notes = 'Conjugación de zullen: zul jij? (pregunta, pierde la -t)' LIMIT 1),
    'nl_NL', 'Zul jij er zijn?', 'Sul yei er sein?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿estarás allí?' AND notes = 'Conjugación de zullen: zul jij? (pregunta, pierde la -t)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿estarás allí?' AND notes = 'Conjugación de zullen: zul jij? (pregunta, pierde la -t)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zullen we? (pregunta): Zullen we beginnen?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿empezamos?', 'PHRASE', 'Conjugación de zullen: zullen we? (pregunta)', 'Conjugación de zullen (futuro):
• ik zal — yo
• jij/je zult (o zal) — tú · en pregunta pierde la -t: zul jij?
• u zult — usted (formal)
• hij/zij/het zal — él/ella/ello
• wij/we zullen — nosotros
• jullie zullen — vosotros
• zij/ze zullen — ellos

📐 Pregunta sí/no: zal/zul/zullen/zou/zouden en 1ª posición + sujeto + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿empezamos?' AND notes = 'Conjugación de zullen: zullen we? (pregunta)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿empezamos?' AND notes = 'Conjugación de zullen: zullen we? (pregunta)' LIMIT 1),
    'nl_NL', 'Zullen we beginnen?', 'Sullen ue bejinnen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿empezamos?' AND notes = 'Conjugación de zullen: zullen we? (pregunta)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿empezamos?' AND notes = 'Conjugación de zullen: zullen we? (pregunta)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zullen zij? (pregunta): Zullen zij komen?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿vendrán ellos?', 'PHRASE', 'Conjugación de zullen: zullen zij? (pregunta)', 'Conjugación de zullen (futuro):
• ik zal — yo
• jij/je zult (o zal) — tú · en pregunta pierde la -t: zul jij?
• u zult — usted (formal)
• hij/zij/het zal — él/ella/ello
• wij/we zullen — nosotros
• jullie zullen — vosotros
• zij/ze zullen — ellos

📐 Pregunta sí/no: zal/zul/zullen/zou/zouden en 1ª posición + sujeto + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿vendrán ellos?' AND notes = 'Conjugación de zullen: zullen zij? (pregunta)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿vendrán ellos?' AND notes = 'Conjugación de zullen: zullen zij? (pregunta)' LIMIT 1),
    'nl_NL', 'Zullen zij komen?', 'Sullen sei komen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿vendrán ellos?' AND notes = 'Conjugación de zullen: zullen zij? (pregunta)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿vendrán ellos?' AND notes = 'Conjugación de zullen: zullen zij? (pregunta)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- ik zou: Ik zou het niet doen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'yo no lo haría', 'PHRASE', 'Conjugación de zullen: ik zou', 'Conjugación de zullen en condicional (zou):
• ik/jij/u/hij/zij/het zou — singular (todos igual)
• wij/jullie/zij zouden — plural (todos igual)

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'yo no lo haría' AND notes = 'Conjugación de zullen: ik zou');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'yo no lo haría' AND notes = 'Conjugación de zullen: ik zou' LIMIT 1),
    'nl_NL', 'Ik zou het niet doen.', 'Ik sau et nit dun.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'yo no lo haría' AND notes = 'Conjugación de zullen: ik zou' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'yo no lo haría' AND notes = 'Conjugación de zullen: ik zou' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- jij zou: Jij zou meer moeten slapen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'deberías dormir más', 'PHRASE', 'Conjugación de zullen: jij zou', 'Conjugación de zullen en condicional (zou):
• ik/jij/u/hij/zij/het zou — singular (todos igual)
• wij/jullie/zij zouden — plural (todos igual)

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'deberías dormir más' AND notes = 'Conjugación de zullen: jij zou');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'deberías dormir más' AND notes = 'Conjugación de zullen: jij zou' LIMIT 1),
    'nl_NL', 'Jij zou meer moeten slapen.', 'Yei sau mer muten slapen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'deberías dormir más' AND notes = 'Conjugación de zullen: jij zou' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'deberías dormir más' AND notes = 'Conjugación de zullen: jij zou' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- u zou: U zou het kunnen proberen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'usted podría intentarlo', 'PHRASE', 'Conjugación de zullen: u zou', 'Conjugación de zullen en condicional (zou):
• ik/jij/u/hij/zij/het zou — singular (todos igual)
• wij/jullie/zij zouden — plural (todos igual)

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'usted podría intentarlo' AND notes = 'Conjugación de zullen: u zou');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'usted podría intentarlo' AND notes = 'Conjugación de zullen: u zou' LIMIT 1),
    'nl_NL', 'U zou het kunnen proberen.', 'U sau et kunnen proberen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'usted podría intentarlo' AND notes = 'Conjugación de zullen: u zou' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'usted podría intentarlo' AND notes = 'Conjugación de zullen: u zou' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zij zou: Zij zou het weten.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ella lo sabría', 'PHRASE', 'Conjugación de zullen: zij zou', 'Conjugación de zullen en condicional (zou):
• ik/jij/u/hij/zij/het zou — singular (todos igual)
• wij/jullie/zij zouden — plural (todos igual)

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'ella lo sabría' AND notes = 'Conjugación de zullen: zij zou');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ella lo sabría' AND notes = 'Conjugación de zullen: zij zou' LIMIT 1),
    'nl_NL', 'Zij zou het weten.', 'Sei sau et ueten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ella lo sabría' AND notes = 'Conjugación de zullen: zij zou' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ella lo sabría' AND notes = 'Conjugación de zullen: zij zou' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- wij zouden: Wij zouden graag komen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'nos encantaría venir', 'PHRASE', 'Conjugación de zullen: wij zouden', 'Conjugación de zullen en condicional (zou):
• ik/jij/u/hij/zij/het zou — singular (todos igual)
• wij/jullie/zij zouden — plural (todos igual)

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'nos encantaría venir' AND notes = 'Conjugación de zullen: wij zouden');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'nos encantaría venir' AND notes = 'Conjugación de zullen: wij zouden' LIMIT 1),
    'nl_NL', 'Wij zouden graag komen.', 'Uei sauden jraj komen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'nos encantaría venir' AND notes = 'Conjugación de zullen: wij zouden' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'nos encantaría venir' AND notes = 'Conjugación de zullen: wij zouden' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- jullie zouden: Jullie zouden trots zijn.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estaríais orgullosos', 'PHRASE', 'Conjugación de zullen: jullie zouden', 'Conjugación de zullen en condicional (zou):
• ik/jij/u/hij/zij/het zou — singular (todos igual)
• wij/jullie/zij zouden — plural (todos igual)

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'estaríais orgullosos' AND notes = 'Conjugación de zullen: jullie zouden');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'estaríais orgullosos' AND notes = 'Conjugación de zullen: jullie zouden' LIMIT 1),
    'nl_NL', 'Jullie zouden trots zijn.', 'Yulli sauden trots sein.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estaríais orgullosos' AND notes = 'Conjugación de zullen: jullie zouden' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estaríais orgullosos' AND notes = 'Conjugación de zullen: jullie zouden' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zij zouden: Zij zouden het nooit toegeven.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ellos nunca lo admitirían', 'PHRASE', 'Conjugación de zullen: zij zouden', 'Conjugación de zullen en condicional (zou):
• ik/jij/u/hij/zij/het zou — singular (todos igual)
• wij/jullie/zij zouden — plural (todos igual)

📐 Oración principal: sujeto + zal/zult/zullen/zou/zouden (2ª posición) + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'ellos nunca lo admitirían' AND notes = 'Conjugación de zullen: zij zouden');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ellos nunca lo admitirían' AND notes = 'Conjugación de zullen: zij zouden' LIMIT 1),
    'nl_NL', 'Zij zouden het nooit toegeven.', 'Sei sauden et noit tujefen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ellos nunca lo admitirían' AND notes = 'Conjugación de zullen: zij zouden' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ellos nunca lo admitirían' AND notes = 'Conjugación de zullen: zij zouden' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zou jij? (pregunta): Zou jij dat doen?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿tú harías eso?', 'PHRASE', 'Conjugación de zullen: zou jij? (pregunta)', 'Conjugación de zullen en condicional (zou):
• ik/jij/u/hij/zij/het zou — singular (todos igual)
• wij/jullie/zij zouden — plural (todos igual)

📐 Pregunta sí/no: zal/zul/zullen/zou/zouden en 1ª posición + sujeto + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿tú harías eso?' AND notes = 'Conjugación de zullen: zou jij? (pregunta)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿tú harías eso?' AND notes = 'Conjugación de zullen: zou jij? (pregunta)' LIMIT 1),
    'nl_NL', 'Zou jij dat doen?', 'Sau yei dat dun?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿tú harías eso?' AND notes = 'Conjugación de zullen: zou jij? (pregunta)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿tú harías eso?' AND notes = 'Conjugación de zullen: zou jij? (pregunta)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zouden we? (pregunta): Zouden we het proberen?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿lo intentamos?', 'PHRASE', 'Conjugación de zullen: zouden we? (pregunta)', 'Conjugación de zullen en condicional (zou):
• ik/jij/u/hij/zij/het zou — singular (todos igual)
• wij/jullie/zij zouden — plural (todos igual)

📐 Pregunta sí/no: zal/zul/zullen/zou/zouden en 1ª posición + sujeto + resto + infinitivo al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿lo intentamos?' AND notes = 'Conjugación de zullen: zouden we? (pregunta)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿lo intentamos?' AND notes = 'Conjugación de zullen: zouden we? (pregunta)' LIMIT 1),
    'nl_NL', 'Zouden we het proberen?', 'Sauden ue et proberen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿lo intentamos?' AND notes = 'Conjugación de zullen: zouden we? (pregunta)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen-conjugation'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿lo intentamos?' AND notes = 'Conjugación de zullen: zouden we? (pregunta)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
