-- Learn Languages App - Frases de ejemplo del grupo "conjuncties" como tarjetas entrenables
-- Migration: 20260710000005-add-example-sentences-conjuncties.sql
-- Description: Convierte las frases de ejemplo (words_lang.notes) de las palabras del
--   grupo "conjuncties" en entradas words_es/words_lang propias (word_type SENTENCE),
--   asociadas al grupo y a "generic", enlazadas a su palabra madre via word_es_relations
--   (relation_type EXAMPLE) y con pronunciacion generada con DutchToSpanishPhoneticService.
--   Ademas rellena pronunciation de las palabras madre SOLO si esta vacia.
--   100% aditiva e idempotente: solo INSERT (NOT EXISTS / OR IGNORE) y UPDATE de
--   pronunciation vacia. No borra ni modifica notes, audio_path ni imagenes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- en  (y)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'en', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'y'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Yo bebo café y ella bebe té.', 'SENTENCE', 'Ejemplo de "en" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Yo bebo café y ella bebe té.' AND notes = 'Ejemplo de "en" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Yo bebo café y ella bebe té.' AND notes = 'Ejemplo de "en" (can.)' LIMIT 1),
    'nl_NL', 'Ik drink koffie en zij drinkt thee.', 'Ik drink koffi en sei drinkt te.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Yo bebo café y ella bebe té.' AND notes = 'Ejemplo de "en" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Yo bebo café y ella bebe té.' AND notes = 'Ejemplo de "en" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'y'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Yo bebo café y ella bebe té.' AND notes = 'Ejemplo de "en" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Vamos al mercado y luego a casa.', 'SENTENCE', 'Ejemplo de "en" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Vamos al mercado y luego a casa.' AND notes = 'Ejemplo de "en" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Vamos al mercado y luego a casa.' AND notes = 'Ejemplo de "en" (can.)' LIMIT 1),
    'nl_NL', 'We gaan naar de markt en daarna naar huis.', 'Ue jan nar de markt en darna nar aus.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vamos al mercado y luego a casa.' AND notes = 'Ejemplo de "en" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vamos al mercado y luego a casa.' AND notes = 'Ejemplo de "en" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'y'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Vamos al mercado y luego a casa.' AND notes = 'Ejemplo de "en" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Quieres queso y pan?', 'SENTENCE', 'Ejemplo de "en" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Quieres queso y pan?' AND notes = 'Ejemplo de "en" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Quieres queso y pan?' AND notes = 'Ejemplo de "en" (vraag)' LIMIT 1),
    'nl_NL', 'Wil je kaas en brood?', 'Uil ye kas en brod?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Quieres queso y pan?' AND notes = 'Ejemplo de "en" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Quieres queso y pan?' AND notes = 'Ejemplo de "en" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'y'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Quieres queso y pan?' AND notes = 'Ejemplo de "en" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Y entonces qué pasó?', 'SENTENCE', 'Ejemplo de "en" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Y entonces qué pasó?' AND notes = 'Ejemplo de "en" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Y entonces qué pasó?' AND notes = 'Ejemplo de "en" (vraag)' LIMIT 1),
    'nl_NL', 'En toen?', 'En tun?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Y entonces qué pasó?' AND notes = 'Ejemplo de "en" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Y entonces qué pasó?' AND notes = 'Ejemplo de "en" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'y'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Y entonces qué pasó?' AND notes = 'Ejemplo de "en" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Dice que viene y que trae comida.', 'SENTENCE', 'Ejemplo de "en" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Dice que viene y que trae comida.' AND notes = 'Ejemplo de "en" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que viene y que trae comida.' AND notes = 'Ejemplo de "en" (bijzin)' LIMIT 1),
    'nl_NL', 'Hij zegt dat hij komt en dat hij eten meeneemt.', 'Ei sejt dat ei komt en dat ei eten menemt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que viene y que trae comida.' AND notes = 'Ejemplo de "en" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que viene y que trae comida.' AND notes = 'Ejemplo de "en" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'y'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Dice que viene y que trae comida.' AND notes = 'Ejemplo de "en" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- maar  (pero)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'mar', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'pero'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Hace frío, pero brilla el sol.', 'SENTENCE', 'Ejemplo de "maar" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Hace frío, pero brilla el sol.' AND notes = 'Ejemplo de "maar" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Hace frío, pero brilla el sol.' AND notes = 'Ejemplo de "maar" (can.)' LIMIT 1),
    'nl_NL', 'Het is koud, maar de zon schijnt.', 'Et is kaud, mar de son sjeint.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hace frío, pero brilla el sol.' AND notes = 'Ejemplo de "maar" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hace frío, pero brilla el sol.' AND notes = 'Ejemplo de "maar" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'pero'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Hace frío, pero brilla el sol.' AND notes = 'Ejemplo de "maar" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'El camino por delante es más corto, pero hay más tráfico.', 'SENTENCE', 'Ejemplo de "maar" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'El camino por delante es más corto, pero hay más tráfico.' AND notes = 'Ejemplo de "maar" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El camino por delante es más corto, pero hay más tráfico.' AND notes = 'Ejemplo de "maar" (can.)' LIMIT 1),
    'nl_NL', 'De weg voorlangs is korter, maar er is meer verkeer.', 'De uej forlanjs is korter, mar er is mer ferker.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El camino por delante es más corto, pero hay más tráfico.' AND notes = 'Ejemplo de "maar" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El camino por delante es más corto, pero hay más tráfico.' AND notes = 'Ejemplo de "maar" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'pero'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'El camino por delante es más corto, pero hay más tráfico.' AND notes = 'Ejemplo de "maar" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Querer quiero, pero no puedo.', 'SENTENCE', 'Ejemplo de "maar" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Querer quiero, pero no puedo.' AND notes = 'Ejemplo de "maar" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Querer quiero, pero no puedo.' AND notes = 'Ejemplo de "maar" (can.)' LIMIT 1),
    'nl_NL', 'Ik wil wel, maar ik kan niet.', 'Ik uil uel, mar ik kan nit.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Querer quiero, pero no puedo.' AND notes = 'Ejemplo de "maar" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Querer quiero, pero no puedo.' AND notes = 'Ejemplo de "maar" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'pero'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Querer quiero, pero no puedo.' AND notes = 'Ejemplo de "maar" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¡Pasa, pasa! (ojo: aquí maar es partícula suavizadora, no "pero")', 'SENTENCE', 'Ejemplo de "maar" (geb.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡Pasa, pasa! (ojo: aquí maar es partícula suavizadora, no "pero")' AND notes = 'Ejemplo de "maar" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡Pasa, pasa! (ojo: aquí maar es partícula suavizadora, no "pero")' AND notes = 'Ejemplo de "maar" (geb.)' LIMIT 1),
    'nl_NL', 'Kom maar binnen!', 'Kom mar binnen!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Pasa, pasa! (ojo: aquí maar es partícula suavizadora, no "pero")' AND notes = 'Ejemplo de "maar" (geb.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Pasa, pasa! (ojo: aquí maar es partícula suavizadora, no "pero")' AND notes = 'Ejemplo de "maar" (geb.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'pero'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¡Pasa, pasa! (ojo: aquí maar es partícula suavizadora, no "pero")' AND notes = 'Ejemplo de "maar" (geb.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'En fin... (muletilla para cambiar de tema)', 'SENTENCE', 'Ejemplo de "maar" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'En fin... (muletilla para cambiar de tema)' AND notes = 'Ejemplo de "maar" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'En fin... (muletilla para cambiar de tema)' AND notes = 'Ejemplo de "maar" (uitdr.)' LIMIT 1),
    'nl_NL', 'Maar goed...', 'Mar jud...');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En fin... (muletilla para cambiar de tema)' AND notes = 'Ejemplo de "maar" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En fin... (muletilla para cambiar de tema)' AND notes = 'Ejemplo de "maar" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'pero'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'En fin... (muletilla para cambiar de tema)' AND notes = 'Ejemplo de "maar" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- of  (o)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'of', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'o'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Quieres té o café?', 'SENTENCE', 'Ejemplo de "of" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Quieres té o café?' AND notes = 'Ejemplo de "of" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Quieres té o café?' AND notes = 'Ejemplo de "of" (vraag)' LIMIT 1),
    'nl_NL', 'Wil je thee of koffie?', 'Uil ye te of koffi?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Quieres té o café?' AND notes = 'Ejemplo de "of" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Quieres té o café?' AND notes = 'Ejemplo de "of" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'o'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Quieres té o café?' AND notes = 'Ejemplo de "of" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Vamos mañana o pasado mañana.', 'SENTENCE', 'Ejemplo de "of" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Vamos mañana o pasado mañana.' AND notes = 'Ejemplo de "of" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Vamos mañana o pasado mañana.' AND notes = 'Ejemplo de "of" (can.)' LIMIT 1),
    'nl_NL', 'We gaan morgen of overmorgen.', 'Ue jan morjen of ofermorjen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vamos mañana o pasado mañana.' AND notes = 'Ejemplo de "of" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vamos mañana o pasado mañana.' AND notes = 'Ejemplo de "of" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'o'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Vamos mañana o pasado mañana.' AND notes = 'Ejemplo de "of" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Vienes o te quedas en casa?', 'SENTENCE', 'Ejemplo de "of" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Vienes o te quedas en casa?' AND notes = 'Ejemplo de "of" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Vienes o te quedas en casa?' AND notes = 'Ejemplo de "of" (vraag)' LIMIT 1),
    'nl_NL', 'Kom je, of blijf je thuis?', 'Kom ye, of bleif ye taus?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Vienes o te quedas en casa?' AND notes = 'Ejemplo de "of" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Vienes o te quedas en casa?' AND notes = 'Ejemplo de "of" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'o'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Vienes o te quedas en casa?' AND notes = 'Ejemplo de "of" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'No sé si viene (¡of = "si" indirecto es SUBORDINANTE: verbo al final!).', 'SENTENCE', 'Ejemplo de "of" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'No sé si viene (¡of = "si" indirecto es SUBORDINANTE: verbo al final!).' AND notes = 'Ejemplo de "of" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No sé si viene (¡of = "si" indirecto es SUBORDINANTE: verbo al final!).' AND notes = 'Ejemplo de "of" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik weet niet of hij komt.', 'Ik uet nit of ei komt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No sé si viene (¡of = "si" indirecto es SUBORDINANTE: verbo al final!).' AND notes = 'Ejemplo de "of" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No sé si viene (¡of = "si" indirecto es SUBORDINANTE: verbo al final!).' AND notes = 'Ejemplo de "of" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'o'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'No sé si viene (¡of = "si" indirecto es SUBORDINANTE: verbo al final!).' AND notes = 'Ejemplo de "of" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¡Ya lo creo!', 'SENTENCE', 'Ejemplo de "of" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡Ya lo creo!' AND notes = 'Ejemplo de "of" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡Ya lo creo!' AND notes = 'Ejemplo de "of" (uitdr.)' LIMIT 1),
    'nl_NL', 'Nou en of!', 'Nau en of!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Ya lo creo!' AND notes = 'Ejemplo de "of" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Ya lo creo!' AND notes = 'Ejemplo de "of" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'o'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¡Ya lo creo!' AND notes = 'Ejemplo de "of" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- want  (pues, porque)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'uant', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'pues, porque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me quedo en casa, pues llueve todo el día (verbo en posición 2).', 'SENTENCE', 'Ejemplo de "want" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Me quedo en casa, pues llueve todo el día (verbo en posición 2).' AND notes = 'Ejemplo de "want" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me quedo en casa, pues llueve todo el día (verbo en posición 2).' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    'nl_NL', 'Ik blijf thuis, want het regent de hele dag.', 'Ik bleif taus, uant et rejent de ele daj.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me quedo en casa, pues llueve todo el día (verbo en posición 2).' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me quedo en casa, pues llueve todo el día (verbo en posición 2).' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'pues, porque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me quedo en casa, pues llueve todo el día (verbo en posición 2).' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Llévate abrigo, que hace frío fuera.', 'SENTENCE', 'Ejemplo de "want" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Llévate abrigo, que hace frío fuera.' AND notes = 'Ejemplo de "want" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Llévate abrigo, que hace frío fuera.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    'nl_NL', 'Neem een jas mee, want het is koud buiten.', 'Nem en yas me, uant et is kaud bauten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Llévate abrigo, que hace frío fuera.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Llévate abrigo, que hace frío fuera.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'pues, porque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Llévate abrigo, que hace frío fuera.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me voy a dormir, que mañana madrugo.', 'SENTENCE', 'Ejemplo de "want" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Me voy a dormir, que mañana madrugo.' AND notes = 'Ejemplo de "want" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me voy a dormir, que mañana madrugo.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    'nl_NL', 'Ik ga slapen, want ik moet morgen vroeg op.', 'Ik ja slapen, uant ik mut morjen fruj op.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me voy a dormir, que mañana madrugo.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me voy a dormir, que mañana madrugo.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'pues, porque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me voy a dormir, que mañana madrugo.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Está contento, pues ha conseguido el trabajo.', 'SENTENCE', 'Ejemplo de "want" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Está contento, pues ha conseguido el trabajo.' AND notes = 'Ejemplo de "want" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Está contento, pues ha conseguido el trabajo.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    'nl_NL', 'Hij is blij, want hij heeft de baan gekregen.', 'Ei is blei, uant ei eft de ban jekrejen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Está contento, pues ha conseguido el trabajo.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Está contento, pues ha conseguido el trabajo.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'pues, porque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Está contento, pues ha conseguido el trabajo.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Está cansada, pues ha dormido mal.', 'SENTENCE', 'Ejemplo de "want" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Está cansada, pues ha dormido mal.' AND notes = 'Ejemplo de "want" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Está cansada, pues ha dormido mal.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    'nl_NL', 'Ze is moe, want ze heeft slecht geslapen.', 'Se is mu, uant se eft slejt jeslapen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Está cansada, pues ha dormido mal.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Está cansada, pues ha dormido mal.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'pues, porque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Está cansada, pues ha dormido mal.' AND notes = 'Ejemplo de "want" (can.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- dus  (así que)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'dus', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'así que'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Llueve, así que nos quedamos en casa.', 'SENTENCE', 'Ejemplo de "dus" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Llueve, así que nos quedamos en casa.' AND notes = 'Ejemplo de "dus" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Llueve, así que nos quedamos en casa.' AND notes = 'Ejemplo de "dus" (can.)' LIMIT 1),
    'nl_NL', 'Het regent, dus we blijven thuis.', 'Et rejent, dus ue bleifen taus.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Llueve, así que nos quedamos en casa.' AND notes = 'Ejemplo de "dus" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Llueve, así que nos quedamos en casa.' AND notes = 'Ejemplo de "dus" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'así que'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Llueve, así que nos quedamos en casa.' AND notes = 'Ejemplo de "dus" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Tenía hambre, así que me compré un bocadillo.', 'SENTENCE', 'Ejemplo de "dus" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Tenía hambre, así que me compré un bocadillo.' AND notes = 'Ejemplo de "dus" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Tenía hambre, así que me compré un bocadillo.' AND notes = 'Ejemplo de "dus" (can.)' LIMIT 1),
    'nl_NL', 'Ik had honger, dus ik heb een broodje gekocht.', 'Ik ad onjer, dus ik eb en brodye jekojt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tenía hambre, así que me compré un bocadillo.' AND notes = 'Ejemplo de "dus" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tenía hambre, así que me compré un bocadillo.' AND notes = 'Ejemplo de "dus" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'así que'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Tenía hambre, así que me compré un bocadillo.' AND notes = 'Ejemplo de "dus" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Así que tú eres el nuevo vecino?', 'SENTENCE', 'Ejemplo de "dus" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Así que tú eres el nuevo vecino?' AND notes = 'Ejemplo de "dus" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Así que tú eres el nuevo vecino?' AND notes = 'Ejemplo de "dus" (vraag)' LIMIT 1),
    'nl_NL', 'Dus jij bent de nieuwe buurman?', 'Dus yei bent de niuue burman?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Así que tú eres el nuevo vecino?' AND notes = 'Ejemplo de "dus" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Así que tú eres el nuevo vecino?' AND notes = 'Ejemplo de "dus" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'así que'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Así que tú eres el nuevo vecino?' AND notes = 'Ejemplo de "dus" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Así que esa era la idea.', 'SENTENCE', 'Ejemplo de "dus" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Así que esa era la idea.' AND notes = 'Ejemplo de "dus" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Así que esa era la idea.' AND notes = 'Ejemplo de "dus" (can.)' LIMIT 1),
    'nl_NL', 'Dus dat was het idee.', 'Dus dat uas et ide.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Así que esa era la idea.' AND notes = 'Ejemplo de "dus" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Así que esa era la idea.' AND notes = 'Ejemplo de "dus" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'así que'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Así que esa era la idea.' AND notes = 'Ejemplo de "dus" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Así que bueno... (muletilla)', 'SENTENCE', 'Ejemplo de "dus" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Así que bueno... (muletilla)' AND notes = 'Ejemplo de "dus" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Así que bueno... (muletilla)' AND notes = 'Ejemplo de "dus" (uitdr.)' LIMIT 1),
    'nl_NL', 'Dus ja...', 'Dus ya...');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Así que bueno... (muletilla)' AND notes = 'Ejemplo de "dus" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Así que bueno... (muletilla)' AND notes = 'Ejemplo de "dus" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'así que'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Así que bueno... (muletilla)' AND notes = 'Ejemplo de "dus" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- omdat  (porque)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'omdat', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'porque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me quedo en casa porque llueve todo el día (¡verbo al final!).', 'SENTENCE', 'Ejemplo de "omdat" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Me quedo en casa porque llueve todo el día (¡verbo al final!).' AND notes = 'Ejemplo de "omdat" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me quedo en casa porque llueve todo el día (¡verbo al final!).' AND notes = 'Ejemplo de "omdat" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik blijf thuis, omdat het de hele dag regent.', 'Ik bleif taus, omdat et de ele daj rejent.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me quedo en casa porque llueve todo el día (¡verbo al final!).' AND notes = 'Ejemplo de "omdat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me quedo en casa porque llueve todo el día (¡verbo al final!).' AND notes = 'Ejemplo de "omdat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'porque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me quedo en casa porque llueve todo el día (¡verbo al final!).' AND notes = 'Ejemplo de "omdat" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Está cansado porque hoy ha trabajado duro (los dos verbos juntos al final).', 'SENTENCE', 'Ejemplo de "omdat" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Está cansado porque hoy ha trabajado duro (los dos verbos juntos al final).' AND notes = 'Ejemplo de "omdat" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Está cansado porque hoy ha trabajado duro (los dos verbos juntos al final).' AND notes = 'Ejemplo de "omdat" (bijzin)' LIMIT 1),
    'nl_NL', 'Hij is moe, omdat hij vandaag hard heeft gewerkt.', 'Ei is mu, omdat ei fandaj ard eft jeuerkt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Está cansado porque hoy ha trabajado duro (los dos verbos juntos al final).' AND notes = 'Ejemplo de "omdat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Está cansado porque hoy ha trabajado duro (los dos verbos juntos al final).' AND notes = 'Ejemplo de "omdat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'porque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Está cansado porque hoy ha trabajado duro (los dos verbos juntos al final).' AND notes = 'Ejemplo de "omdat" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Aprende neerlandés porque vive en Países Bajos.', 'SENTENCE', 'Ejemplo de "omdat" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Aprende neerlandés porque vive en Países Bajos.' AND notes = 'Ejemplo de "omdat" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Aprende neerlandés porque vive en Países Bajos.' AND notes = 'Ejemplo de "omdat" (bijzin)' LIMIT 1),
    'nl_NL', 'Ze leert Nederlands, omdat ze in Nederland woont.', 'Se lert Nederlands, omdat se in Nederland uont.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aprende neerlandés porque vive en Países Bajos.' AND notes = 'Ejemplo de "omdat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aprende neerlandés porque vive en Países Bajos.' AND notes = 'Ejemplo de "omdat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'porque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Aprende neerlandés porque vive en Países Bajos.' AND notes = 'Ejemplo de "omdat" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Como llueve, nos quedamos en casa (subordinada delante → inversión en la principal).', 'SENTENCE', 'Ejemplo de "omdat" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Como llueve, nos quedamos en casa (subordinada delante → inversión en la principal).' AND notes = 'Ejemplo de "omdat" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Como llueve, nos quedamos en casa (subordinada delante → inversión en la principal).' AND notes = 'Ejemplo de "omdat" (inv.)' LIMIT 1),
    'nl_NL', 'Omdat het regent, blijven we thuis.', 'Omdat et rejent, bleifen ue taus.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Como llueve, nos quedamos en casa (subordinada delante → inversión en la principal).' AND notes = 'Ejemplo de "omdat" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Como llueve, nos quedamos en casa (subordinada delante → inversión en la principal).' AND notes = 'Ejemplo de "omdat" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'porque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Como llueve, nos quedamos en casa (subordinada delante → inversión en la principal).' AND notes = 'Ejemplo de "omdat" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Por qué? ¡Porque sí!', 'SENTENCE', 'Ejemplo de "omdat" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Por qué? ¡Porque sí!' AND notes = 'Ejemplo de "omdat" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Por qué? ¡Porque sí!' AND notes = 'Ejemplo de "omdat" (vraag)' LIMIT 1),
    'nl_NL', 'Waarom? Omdat het zo is!', 'Uarom? Omdat et so is!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Por qué? ¡Porque sí!' AND notes = 'Ejemplo de "omdat" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Por qué? ¡Porque sí!' AND notes = 'Ejemplo de "omdat" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'porque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Por qué? ¡Porque sí!' AND notes = 'Ejemplo de "omdat" (vraag)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- hoewel  (aunque)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'uuel', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'aunque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'El camino por delante es más corto, aunque hay más tráfico.', 'SENTENCE', 'Ejemplo de "hoewel" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'El camino por delante es más corto, aunque hay más tráfico.' AND notes = 'Ejemplo de "hoewel" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El camino por delante es más corto, aunque hay más tráfico.' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    'nl_NL', 'De weg voorlangs is korter, hoewel er meer verkeer is.', 'De uej forlanjs is korter, uuel er mer ferker is.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El camino por delante es más corto, aunque hay más tráfico.' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El camino por delante es más corto, aunque hay más tráfico.' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'aunque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'El camino por delante es más corto, aunque hay más tráfico.' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Aunque llovía, fuimos en bici (subordinada delante → inversión).', 'SENTENCE', 'Ejemplo de "hoewel" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Aunque llovía, fuimos en bici (subordinada delante → inversión).' AND notes = 'Ejemplo de "hoewel" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Aunque llovía, fuimos en bici (subordinada delante → inversión).' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    'nl_NL', 'Hoewel het regende, gingen we fietsen.', 'Uuel et rejende, jinjen ue fitsen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aunque llovía, fuimos en bici (subordinada delante → inversión).' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aunque llovía, fuimos en bici (subordinada delante → inversión).' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'aunque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Aunque llovía, fuimos en bici (subordinada delante → inversión).' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Vino, aunque estaba enfermo.', 'SENTENCE', 'Ejemplo de "hoewel" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Vino, aunque estaba enfermo.' AND notes = 'Ejemplo de "hoewel" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Vino, aunque estaba enfermo.' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    'nl_NL', 'Hij kwam, hoewel hij ziek was.', 'Ei kuam, uuel ei sik uas.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vino, aunque estaba enfermo.' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vino, aunque estaba enfermo.' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'aunque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Vino, aunque estaba enfermo.' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me gusta, aunque es muy dulce.', 'SENTENCE', 'Ejemplo de "hoewel" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Me gusta, aunque es muy dulce.' AND notes = 'Ejemplo de "hoewel" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me gusta, aunque es muy dulce.' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik vind het lekker, hoewel het erg zoet is.', 'Ik find et lekker, uuel et erj sut is.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me gusta, aunque es muy dulce.' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me gusta, aunque es muy dulce.' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'aunque'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me gusta, aunque es muy dulce.' AND notes = 'Ejemplo de "hoewel" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- als  (si (condicional))
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'als', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'si (condicional)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Si llueve, nos quedamos en casa.', 'SENTENCE', 'Ejemplo de "als" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Si llueve, nos quedamos en casa.' AND notes = 'Ejemplo de "als" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Si llueve, nos quedamos en casa.' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    'nl_NL', 'Als het regent, blijven we thuis.', 'Als et rejent, bleifen ue taus.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Si llueve, nos quedamos en casa.' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Si llueve, nos quedamos en casa.' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'si (condicional)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Si llueve, nos quedamos en casa.' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Si tienes tiempo, llámame.', 'SENTENCE', 'Ejemplo de "als" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Si tienes tiempo, llámame.' AND notes = 'Ejemplo de "als" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Si tienes tiempo, llámame.' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    'nl_NL', 'Als je tijd hebt, bel me even.', 'Als ye teid ebt, bel me efen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Si tienes tiempo, llámame.' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Si tienes tiempo, llámame.' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'si (condicional)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Si tienes tiempo, llámame.' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Te ayudo si lo pides.', 'SENTENCE', 'Ejemplo de "als" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Te ayudo si lo pides.' AND notes = 'Ejemplo de "als" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Te ayudo si lo pides.' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik help je, als je het vraagt.', 'Ik elp ye, als ye et frajt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Te ayudo si lo pides.' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Te ayudo si lo pides.' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'si (condicional)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Te ayudo si lo pides.' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'De niño vivía en Sevilla (als también = "de/como").', 'SENTENCE', 'Ejemplo de "als" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'De niño vivía en Sevilla (als también = "de/como").' AND notes = 'Ejemplo de "als" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'De niño vivía en Sevilla (als también = "de/como").' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    'nl_NL', 'Als kind woonde ik in Sevilla.', 'Als kind uonde ik in Sefilla.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'De niño vivía en Sevilla (als también = "de/como").' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'De niño vivía en Sevilla (als también = "de/como").' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'si (condicional)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'De niño vivía en Sevilla (als también = "de/como").' AND notes = 'Ejemplo de "als" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- dat  (que (conjunción))
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'dat', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'que (conjunción)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Creo que mañana llueve.', 'SENTENCE', 'Ejemplo de "dat" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Creo que mañana llueve.' AND notes = 'Ejemplo de "dat" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Creo que mañana llueve.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik denk dat het morgen regent.', 'Ik denk dat et morjen rejent.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Creo que mañana llueve.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Creo que mañana llueve.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'que (conjunción)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Creo que mañana llueve.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Dice que está cansada.', 'SENTENCE', 'Ejemplo de "dat" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Dice que está cansada.' AND notes = 'Ejemplo de "dat" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que está cansada.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    'nl_NL', 'Ze zegt dat ze moe is.', 'Se sejt dat se mu is.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que está cansada.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que está cansada.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'que (conjunción)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Dice que está cansada.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Es una pena que no puedas venir.', 'SENTENCE', 'Ejemplo de "dat" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Es una pena que no puedas venir.' AND notes = 'Ejemplo de "dat" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Es una pena que no puedas venir.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    'nl_NL', 'Het is jammer dat je niet kunt komen.', 'Et is yammer dat ye nit kunt komen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Es una pena que no puedas venir.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Es una pena que no puedas venir.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'que (conjunción)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Es una pena que no puedas venir.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'No sabía que vivías en Haarlem.', 'SENTENCE', 'Ejemplo de "dat" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'No sabía que vivías en Haarlem.' AND notes = 'Ejemplo de "dat" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No sabía que vivías en Haarlem.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik wist niet dat je in Haarlem woonde.', 'Ik uist nit dat ye in Arlem uonde.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No sabía que vivías en Haarlem.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No sabía que vivías en Haarlem.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'que (conjunción)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'No sabía que vivías en Haarlem.' AND notes = 'Ejemplo de "dat" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Estás seguro de que es correcto?', 'SENTENCE', 'Ejemplo de "dat" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Estás seguro de que es correcto?' AND notes = 'Ejemplo de "dat" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Estás seguro de que es correcto?' AND notes = 'Ejemplo de "dat" (vraag)' LIMIT 1),
    'nl_NL', 'Weet je zeker dat het klopt?', 'Uet ye seker dat et klopt?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Estás seguro de que es correcto?' AND notes = 'Ejemplo de "dat" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Estás seguro de que es correcto?' AND notes = 'Ejemplo de "dat" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'que (conjunción)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Estás seguro de que es correcto?' AND notes = 'Ejemplo de "dat" (vraag)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- terwijl  (mientras)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'terueil', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'mientras'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Yo cocino mientras ella pone la mesa.', 'SENTENCE', 'Ejemplo de "terwijl" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Yo cocino mientras ella pone la mesa.' AND notes = 'Ejemplo de "terwijl" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Yo cocino mientras ella pone la mesa.' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik kook, terwijl zij de tafel dekt.', 'Ik kok, terueil sei de tafel dekt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Yo cocino mientras ella pone la mesa.' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Yo cocino mientras ella pone la mesa.' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'mientras'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Yo cocino mientras ella pone la mesa.' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mientras esperaba, leía un libro.', 'SENTENCE', 'Ejemplo de "terwijl" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Mientras esperaba, leía un libro.' AND notes = 'Ejemplo de "terwijl" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mientras esperaba, leía un libro.' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    'nl_NL', 'Terwijl ik wachtte, las ik een boek.', 'Terueil ik uajtte, las ik en buk.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mientras esperaba, leía un libro.' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mientras esperaba, leía un libro.' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'mientras'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Mientras esperaba, leía un libro.' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Habla por teléfono mientras va en bici (estampa holandesa).', 'SENTENCE', 'Ejemplo de "terwijl" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Habla por teléfono mientras va en bici (estampa holandesa).' AND notes = 'Ejemplo de "terwijl" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Habla por teléfono mientras va en bici (estampa holandesa).' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    'nl_NL', 'Hij belt, terwijl hij fietst.', 'Ei belt, terueil ei fitst.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Habla por teléfono mientras va en bici (estampa holandesa).' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Habla por teléfono mientras va en bici (estampa holandesa).' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'mientras'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Habla por teléfono mientras va en bici (estampa holandesa).' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mientras dormías, hice la compra.', 'SENTENCE', 'Ejemplo de "terwijl" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Mientras dormías, hice la compra.' AND notes = 'Ejemplo de "terwijl" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mientras dormías, hice la compra.' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    'nl_NL', 'Terwijl jij sliep, heb ik boodschappen gedaan.', 'Terueil yei slip, eb ik bodsjappen jedan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mientras dormías, hice la compra.' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mientras dormías, hice la compra.' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'mientras'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Mientras dormías, hice la compra.' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Él es alto, mientras que su hermano es bajito (contraste).', 'SENTENCE', 'Ejemplo de "terwijl" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Él es alto, mientras que su hermano es bajito (contraste).' AND notes = 'Ejemplo de "terwijl" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Él es alto, mientras que su hermano es bajito (contraste).' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    'nl_NL', 'Hij is lang, terwijl zijn broer klein is.', 'Ei is lanj, terueil sein brur klein is.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Él es alto, mientras que su hermano es bajito (contraste).' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Él es alto, mientras que su hermano es bajito (contraste).' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'mientras'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Él es alto, mientras que su hermano es bajito (contraste).' AND notes = 'Ejemplo de "terwijl" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- zodat  (de modo que)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'sodat', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'de modo que'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Habla despacio, de modo que pueda entenderte.', 'SENTENCE', 'Ejemplo de "zodat" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Habla despacio, de modo que pueda entenderte.' AND notes = 'Ejemplo de "zodat" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Habla despacio, de modo que pueda entenderte.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    'nl_NL', 'Spreek langzaam, zodat ik je kan verstaan.', 'Sprek lanjsam, sodat ik ye kan ferstan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Habla despacio, de modo que pueda entenderte.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Habla despacio, de modo que pueda entenderte.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'de modo que'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Habla despacio, de modo que pueda entenderte.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Lo apunto para que no se me olvide.', 'SENTENCE', 'Ejemplo de "zodat" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Lo apunto para que no se me olvide.' AND notes = 'Ejemplo de "zodat" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo apunto para que no se me olvide.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik schrijf het op, zodat ik het niet vergeet.', 'Ik sjreif et op, sodat ik et nit ferjet.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo apunto para que no se me olvide.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo apunto para que no se me olvide.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'de modo que'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Lo apunto para que no se me olvide.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Pone el despertador para levantarse a tiempo.', 'SENTENCE', 'Ejemplo de "zodat" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Pone el despertador para levantarse a tiempo.' AND notes = 'Ejemplo de "zodat" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Pone el despertador para levantarse a tiempo.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    'nl_NL', 'Ze zet de wekker, zodat ze op tijd opstaat.', 'Se set de uekker, sodat se op teid opstat.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Pone el despertador para levantarse a tiempo.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Pone el despertador para levantarse a tiempo.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'de modo que'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Pone el despertador para levantarse a tiempo.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Salimos pronto, así evitamos el atasco.', 'SENTENCE', 'Ejemplo de "zodat" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Salimos pronto, así evitamos el atasco.' AND notes = 'Ejemplo de "zodat" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Salimos pronto, así evitamos el atasco.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    'nl_NL', 'We vertrekken vroeg, zodat we de file vermijden.', 'Ue fertrekken fruj, sodat ue de file fermeiden.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Salimos pronto, así evitamos el atasco.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Salimos pronto, así evitamos el atasco.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'de modo que'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Salimos pronto, así evitamos el atasco.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Cierra la puerta, que no se escape el gato.', 'SENTENCE', 'Ejemplo de "zodat" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Cierra la puerta, que no se escape el gato.' AND notes = 'Ejemplo de "zodat" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cierra la puerta, que no se escape el gato.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    'nl_NL', 'Doe de deur dicht, zodat de kat niet ontsnapt.', 'Du de der dijt, sodat de kat nit ontsnapt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cierra la puerta, que no se escape el gato.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cierra la puerta, que no se escape el gato.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'de modo que'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Cierra la puerta, que no se escape el gato.' AND notes = 'Ejemplo de "zodat" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- toen  (cuando (pasado puntual))
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'tun', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'cuando (pasado puntual)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Cuando era joven, vivía en Sevilla.', 'SENTENCE', 'Ejemplo de "toen" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Cuando era joven, vivía en Sevilla.' AND notes = 'Ejemplo de "toen" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuando era joven, vivía en Sevilla.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    'nl_NL', 'Toen ik jong was, woonde ik in Sevilla.', 'Tun ik yonj uas, uonde ik in Sefilla.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuando era joven, vivía en Sevilla.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuando era joven, vivía en Sevilla.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'cuando (pasado puntual)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Cuando era joven, vivía en Sevilla.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Cuando llegó el tren, llovía.', 'SENTENCE', 'Ejemplo de "toen" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Cuando llegó el tren, llovía.' AND notes = 'Ejemplo de "toen" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuando llegó el tren, llovía.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    'nl_NL', 'Toen de trein aankwam, regende het.', 'Tun de trein ankuam, rejende et.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuando llegó el tren, llovía.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuando llegó el tren, llovía.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'cuando (pasado puntual)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Cuando llegó el tren, llovía.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Dormía cuando llamaste.', 'SENTENCE', 'Ejemplo de "toen" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Dormía cuando llamaste.' AND notes = 'Ejemplo de "toen" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Dormía cuando llamaste.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik sliep, toen je belde.', 'Ik slip, tun ye belde.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dormía cuando llamaste.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dormía cuando llamaste.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'cuando (pasado puntual)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Dormía cuando llamaste.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'als = presente/futuro; toen = pasado.', 'SENTENCE', 'Ejemplo de "toen" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'als = presente/futuro; toen = pasado.' AND notes = 'Ejemplo de "toen" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'als = presente/futuro; toen = pasado.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    'nl_NL', 'Als het regent, blijf ik thuis; toen het regende, bleef ik thuis.', 'Als et rejent, bleif ik taus; tun et rejende, blef ik taus.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'als = presente/futuro; toen = pasado.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'conjuncties'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'als = presente/futuro; toen = pasado.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'cuando (pasado puntual)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'conjuncties')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'als = presente/futuro; toen = pasado.' AND notes = 'Ejemplo de "toen" (bijzin)' LIMIT 1),
    'EXAMPLE');
