-- Learn Languages App - Frases de ejemplo del grupo "zullen" como tarjetas entrenables
-- Migration: 20260710000001-add-example-sentences-zullen.sql
-- Description: Convierte las frases de ejemplo (words_lang.notes) de las palabras del
--   grupo "zullen" en entradas words_es/words_lang propias (word_type SENTENCE),
--   asociadas al grupo y a "generic", enlazadas a su palabra madre via word_es_relations
--   (relation_type EXAMPLE) y con pronunciacion generada con DutchToSpanishPhoneticService.
--   Ademas rellena pronunciation de las palabras madre SOLO si esta vacia.
--   100% aditiva e idempotente: solo INSERT (NOT EXISTS / OR IGNORE) y UPDATE de
--   pronunciation vacia. No borra ni modifica notes, audio_path ni imagenes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- zullen we wat eten?  (¿comemos algo?)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'sullen ue uat eten?', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿comemos algo?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Pedimos pizza esta noche?', 'SENTENCE', 'Ejemplo de "zullen we wat eten?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Pedimos pizza esta noche?' AND notes = 'Ejemplo de "zullen we wat eten?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Pedimos pizza esta noche?' AND notes = 'Ejemplo de "zullen we wat eten?" (vraag)' LIMIT 1),
    'nl_NL', 'Zullen we vanavond pizza bestellen?', 'Sullen ue fanafond pissa bestellen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Pedimos pizza esta noche?' AND notes = 'Ejemplo de "zullen we wat eten?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Pedimos pizza esta noche?' AND notes = 'Ejemplo de "zullen we wat eten?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿comemos algo?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Pedimos pizza esta noche?' AND notes = 'Ejemplo de "zullen we wat eten?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Hacemos una pausa?', 'SENTENCE', 'Ejemplo de "zullen we wat eten?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Hacemos una pausa?' AND notes = 'Ejemplo de "zullen we wat eten?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Hacemos una pausa?' AND notes = 'Ejemplo de "zullen we wat eten?" (vraag)' LIMIT 1),
    'nl_NL', 'Zullen we even pauze nemen?', 'Sullen ue efen pause nemen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Hacemos una pausa?' AND notes = 'Ejemplo de "zullen we wat eten?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Hacemos una pausa?' AND notes = 'Ejemplo de "zullen we wat eten?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿comemos algo?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Hacemos una pausa?' AND notes = 'Ejemplo de "zullen we wat eten?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Pregunté si comemos algo juntos.', 'SENTENCE', 'Ejemplo de "zullen we wat eten?" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Pregunté si comemos algo juntos.' AND notes = 'Ejemplo de "zullen we wat eten?" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Pregunté si comemos algo juntos.' AND notes = 'Ejemplo de "zullen we wat eten?" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik vroeg of we samen wat zullen eten.', 'Ik fruj of ue samen uat sullen eten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Pregunté si comemos algo juntos.' AND notes = 'Ejemplo de "zullen we wat eten?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Pregunté si comemos algo juntos.' AND notes = 'Ejemplo de "zullen we wat eten?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿comemos algo?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Pregunté si comemos algo juntos.' AND notes = 'Ejemplo de "zullen we wat eten?" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Empezamos, entonces? (frase hecha para ponerse en marcha)', 'SENTENCE', 'Ejemplo de "zullen we wat eten?" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Empezamos, entonces? (frase hecha para ponerse en marcha)' AND notes = 'Ejemplo de "zullen we wat eten?" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Empezamos, entonces? (frase hecha para ponerse en marcha)' AND notes = 'Ejemplo de "zullen we wat eten?" (uitdr.)' LIMIT 1),
    'nl_NL', 'Zullen we maar?', 'Sullen ue mar?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Empezamos, entonces? (frase hecha para ponerse en marcha)' AND notes = 'Ejemplo de "zullen we wat eten?" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Empezamos, entonces? (frase hecha para ponerse en marcha)' AND notes = 'Ejemplo de "zullen we wat eten?" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿comemos algo?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Empezamos, entonces? (frase hecha para ponerse en marcha)' AND notes = 'Ejemplo de "zullen we wat eten?" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- zullen we gaan?  (¿nos vamos?)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'sullen ue jan?', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿nos vamos?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Vamos mañana a la playa?', 'SENTENCE', 'Ejemplo de "zullen we gaan?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Vamos mañana a la playa?' AND notes = 'Ejemplo de "zullen we gaan?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Vamos mañana a la playa?' AND notes = 'Ejemplo de "zullen we gaan?" (vraag)' LIMIT 1),
    'nl_NL', 'Zullen we morgen naar het strand gaan?', 'Sullen ue morjen nar et strand jan?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Vamos mañana a la playa?' AND notes = 'Ejemplo de "zullen we gaan?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Vamos mañana a la playa?' AND notes = 'Ejemplo de "zullen we gaan?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿nos vamos?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Vamos mañana a la playa?' AND notes = 'Ejemplo de "zullen we gaan?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Vamos en bici?', 'SENTENCE', 'Ejemplo de "zullen we gaan?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Vamos en bici?' AND notes = 'Ejemplo de "zullen we gaan?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Vamos en bici?' AND notes = 'Ejemplo de "zullen we gaan?" (vraag)' LIMIT 1),
    'nl_NL', 'Zullen we met de fiets gaan?', 'Sullen ue met de fits jan?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Vamos en bici?' AND notes = 'Ejemplo de "zullen we gaan?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Vamos en bici?' AND notes = 'Ejemplo de "zullen we gaan?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿nos vamos?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Vamos en bici?' AND notes = 'Ejemplo de "zullen we gaan?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Después del café nos vamos.', 'SENTENCE', 'Ejemplo de "zullen we gaan?" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Después del café nos vamos.' AND notes = 'Ejemplo de "zullen we gaan?" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Después del café nos vamos.' AND notes = 'Ejemplo de "zullen we gaan?" (inv.)' LIMIT 1),
    'nl_NL', 'Na de koffie zullen we gaan.', 'Na de koffi sullen ue jan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Después del café nos vamos.' AND notes = 'Ejemplo de "zullen we gaan?" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Después del café nos vamos.' AND notes = 'Ejemplo de "zullen we gaan?" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿nos vamos?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Después del café nos vamos.' AND notes = 'Ejemplo de "zullen we gaan?" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Nos ponemos ya con ello?', 'SENTENCE', 'Ejemplo de "zullen we gaan?" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Nos ponemos ya con ello?' AND notes = 'Ejemplo de "zullen we gaan?" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Nos ponemos ya con ello?' AND notes = 'Ejemplo de "zullen we gaan?" (uitdr.)' LIMIT 1),
    'nl_NL', 'Zullen we er maar aan beginnen?', 'Sullen ue er mar an bejinnen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Nos ponemos ya con ello?' AND notes = 'Ejemplo de "zullen we gaan?" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Nos ponemos ya con ello?' AND notes = 'Ejemplo de "zullen we gaan?" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿nos vamos?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Nos ponemos ya con ello?' AND notes = 'Ejemplo de "zullen we gaan?" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- zal ik je helpen?  (¿te ayudo?)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'sal ik ye elpen?', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿te ayudo?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Abro la ventana?', 'SENTENCE', 'Ejemplo de "zal ik je helpen?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Abro la ventana?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Abro la ventana?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)' LIMIT 1),
    'nl_NL', 'Zal ik het raam opendoen?', 'Sal ik et ram opendun?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Abro la ventana?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Abro la ventana?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿te ayudo?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Abro la ventana?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Preparo café?', 'SENTENCE', 'Ejemplo de "zal ik je helpen?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Preparo café?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Preparo café?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)' LIMIT 1),
    'nl_NL', 'Zal ik koffie zetten?', 'Sal ik koffi setten?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Preparo café?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Preparo café?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿te ayudo?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Preparo café?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Te recojo de la estación?', 'SENTENCE', 'Ejemplo de "zal ik je helpen?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Te recojo de la estación?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Te recojo de la estación?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)' LIMIT 1),
    'nl_NL', 'Zal ik je van het station ophalen?', 'Sal ik ye fan et station opalen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Te recojo de la estación?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Te recojo de la estación?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿te ayudo?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Te recojo de la estación?' AND notes = 'Ejemplo de "zal ik je helpen?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Lo hago yo, entonces? (ofrecimiento con "maar")', 'SENTENCE', 'Ejemplo de "zal ik je helpen?" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Lo hago yo, entonces? (ofrecimiento con "maar")' AND notes = 'Ejemplo de "zal ik je helpen?" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Lo hago yo, entonces? (ofrecimiento con "maar")' AND notes = 'Ejemplo de "zal ik je helpen?" (uitdr.)' LIMIT 1),
    'nl_NL', 'Zal ik maar?', 'Sal ik mar?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Lo hago yo, entonces? (ofrecimiento con "maar")' AND notes = 'Ejemplo de "zal ik je helpen?" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Lo hago yo, entonces? (ofrecimiento con "maar")' AND notes = 'Ejemplo de "zal ik je helpen?" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿te ayudo?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Lo hago yo, entonces? (ofrecimiento con "maar")' AND notes = 'Ejemplo de "zal ik je helpen?" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- ik zal het morgen doen  (lo haré mañana)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ik sal et morjen dun', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo haré mañana'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Mañana lo haré de verdad.', 'SENTENCE', 'Ejemplo de "ik zal het morgen doen" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Mañana lo haré de verdad.' AND notes = 'Ejemplo de "ik zal het morgen doen" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mañana lo haré de verdad.' AND notes = 'Ejemplo de "ik zal het morgen doen" (inv.)' LIMIT 1),
    'nl_NL', 'Morgen zal ik het echt doen.', 'Morjen sal ik et ejt dun.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mañana lo haré de verdad.' AND notes = 'Ejemplo de "ik zal het morgen doen" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mañana lo haré de verdad.' AND notes = 'Ejemplo de "ik zal het morgen doen" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo haré mañana'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Mañana lo haré de verdad.' AND notes = 'Ejemplo de "ik zal het morgen doen" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me acordaré, lo tendré en cuenta.', 'SENTENCE', 'Ejemplo de "ik zal het morgen doen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Me acordaré, lo tendré en cuenta.' AND notes = 'Ejemplo de "ik zal het morgen doen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me acordaré, lo tendré en cuenta.' AND notes = 'Ejemplo de "ik zal het morgen doen" (can.)' LIMIT 1),
    'nl_NL', 'Ik zal eraan denken.', 'Ik sal eran denken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me acordaré, lo tendré en cuenta.' AND notes = 'Ejemplo de "ik zal het morgen doen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me acordaré, lo tendré en cuenta.' AND notes = 'Ejemplo de "ik zal het morgen doen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo haré mañana'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me acordaré, lo tendré en cuenta.' AND notes = 'Ejemplo de "ik zal het morgen doen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Serás prudente? (promesa que se pide)', 'SENTENCE', 'Ejemplo de "ik zal het morgen doen" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Serás prudente? (promesa que se pide)' AND notes = 'Ejemplo de "ik zal het morgen doen" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Serás prudente? (promesa que se pide)' AND notes = 'Ejemplo de "ik zal het morgen doen" (vraag)' LIMIT 1),
    'nl_NL', 'Zul je voorzichtig zijn?', 'Sul ye forsijtij sein?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Serás prudente? (promesa que se pide)' AND notes = 'Ejemplo de "ik zal het morgen doen" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Serás prudente? (promesa que se pide)' AND notes = 'Ejemplo de "ik zal het morgen doen" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo haré mañana'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Serás prudente? (promesa que se pide)' AND notes = 'Ejemplo de "ik zal het morgen doen" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Prometo que lo haré mañana.', 'SENTENCE', 'Ejemplo de "ik zal het morgen doen" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Prometo que lo haré mañana.' AND notes = 'Ejemplo de "ik zal het morgen doen" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Prometo que lo haré mañana.' AND notes = 'Ejemplo de "ik zal het morgen doen" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik beloof dat ik het morgen zal doen.', 'Ik belof dat ik et morjen sal dun.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Prometo que lo haré mañana.' AND notes = 'Ejemplo de "ik zal het morgen doen" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Prometo que lo haré mañana.' AND notes = 'Ejemplo de "ik zal het morgen doen" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo haré mañana'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Prometo que lo haré mañana.' AND notes = 'Ejemplo de "ik zal het morgen doen" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- ik zal er zijn  (estaré allí)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ik sal er sein', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'estaré allí'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'A las ocho estaré allí.', 'SENTENCE', 'Ejemplo de "ik zal er zijn" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'A las ocho estaré allí.' AND notes = 'Ejemplo de "ik zal er zijn" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'A las ocho estaré allí.' AND notes = 'Ejemplo de "ik zal er zijn" (inv.)' LIMIT 1),
    'nl_NL', 'Om acht uur zal ik er zijn.', 'Om ajt ur sal ik er sein.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A las ocho estaré allí.' AND notes = 'Ejemplo de "ik zal er zijn" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A las ocho estaré allí.' AND notes = 'Ejemplo de "ik zal er zijn" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'estaré allí'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'A las ocho estaré allí.' AND notes = 'Ejemplo de "ik zal er zijn" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Nunca te olvidaré.', 'SENTENCE', 'Ejemplo de "ik zal er zijn" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Nunca te olvidaré.' AND notes = 'Ejemplo de "ik zal er zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Nunca te olvidaré.' AND notes = 'Ejemplo de "ik zal er zijn" (can.)' LIMIT 1),
    'nl_NL', 'Ik zal je nooit vergeten.', 'Ik sal ye noit ferjeten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Nunca te olvidaré.' AND notes = 'Ejemplo de "ik zal er zijn" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Nunca te olvidaré.' AND notes = 'Ejemplo de "ik zal er zijn" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'estaré allí'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Nunca te olvidaré.' AND notes = 'Ejemplo de "ik zal er zijn" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿De verdad estarás allí?', 'SENTENCE', 'Ejemplo de "ik zal er zijn" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿De verdad estarás allí?' AND notes = 'Ejemplo de "ik zal er zijn" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿De verdad estarás allí?' AND notes = 'Ejemplo de "ik zal er zijn" (vraag)' LIMIT 1),
    'nl_NL', 'Zul je er echt zijn?', 'Sul ye er ejt sein?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿De verdad estarás allí?' AND notes = 'Ejemplo de "ik zal er zijn" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿De verdad estarás allí?' AND notes = 'Ejemplo de "ik zal er zijn" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'estaré allí'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿De verdad estarás allí?' AND notes = 'Ejemplo de "ik zal er zijn" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Promete que estará allí.', 'SENTENCE', 'Ejemplo de "ik zal er zijn" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Promete que estará allí.' AND notes = 'Ejemplo de "ik zal er zijn" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Promete que estará allí.' AND notes = 'Ejemplo de "ik zal er zijn" (bijzin)' LIMIT 1),
    'nl_NL', 'Ze belooft dat ze er zal zijn.', 'Se beloft dat se er sal sein.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Promete que estará allí.' AND notes = 'Ejemplo de "ik zal er zijn" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Promete que estará allí.' AND notes = 'Ejemplo de "ik zal er zijn" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'estaré allí'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Promete que estará allí.' AND notes = 'Ejemplo de "ik zal er zijn" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- dat zal wel  (será eso, supongo)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'dat sal uel', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'será eso, supongo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Ya se arreglará.', 'SENTENCE', 'Ejemplo de "dat zal wel" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Ya se arreglará.' AND notes = 'Ejemplo de "dat zal wel" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya se arreglará.' AND notes = 'Ejemplo de "dat zal wel" (can.)' LIMIT 1),
    'nl_NL', 'Het zal wel goedkomen.', 'Et sal uel judkomen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya se arreglará.' AND notes = 'Ejemplo de "dat zal wel" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya se arreglará.' AND notes = 'Ejemplo de "dat zal wel" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'será eso, supongo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Ya se arreglará.' AND notes = 'Ejemplo de "dat zal wel" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Seguro que llega tarde otra vez.', 'SENTENCE', 'Ejemplo de "dat zal wel" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Seguro que llega tarde otra vez.' AND notes = 'Ejemplo de "dat zal wel" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Seguro que llega tarde otra vez.' AND notes = 'Ejemplo de "dat zal wel" (can.)' LIMIT 1),
    'nl_NL', 'Hij zal wel weer te laat zijn.', 'Ei sal uel uer te lat sein.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Seguro que llega tarde otra vez.' AND notes = 'Ejemplo de "dat zal wel" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Seguro que llega tarde otra vez.' AND notes = 'Ejemplo de "dat zal wel" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'será eso, supongo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Seguro que llega tarde otra vez.' AND notes = 'Ejemplo de "dat zal wel" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Saldrá bien? ¡Tendrá que salir!', 'SENTENCE', 'Ejemplo de "dat zal wel" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Saldrá bien? ¡Tendrá que salir!' AND notes = 'Ejemplo de "dat zal wel" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Saldrá bien? ¡Tendrá que salir!' AND notes = 'Ejemplo de "dat zal wel" (vraag)' LIMIT 1),
    'nl_NL', 'Zal het lukken? Het zal wel moeten!', 'Sal et lukken? Et sal uel muten!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Saldrá bien? ¡Tendrá que salir!' AND notes = 'Ejemplo de "dat zal wel" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Saldrá bien? ¡Tendrá que salir!' AND notes = 'Ejemplo de "dat zal wel" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'será eso, supongo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Saldrá bien? ¡Tendrá que salir!' AND notes = 'Ejemplo de "dat zal wel" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Seguro que otra vez es culpa mía (irónico).', 'SENTENCE', 'Ejemplo de "dat zal wel" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Seguro que otra vez es culpa mía (irónico).' AND notes = 'Ejemplo de "dat zal wel" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Seguro que otra vez es culpa mía (irónico).' AND notes = 'Ejemplo de "dat zal wel" (uitdr.)' LIMIT 1),
    'nl_NL', 'Het zal wel weer aan mij liggen.', 'Et sal uel uer an mei lijjen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Seguro que otra vez es culpa mía (irónico).' AND notes = 'Ejemplo de "dat zal wel" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Seguro que otra vez es culpa mía (irónico).' AND notes = 'Ejemplo de "dat zal wel" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'será eso, supongo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Seguro que otra vez es culpa mía (irónico).' AND notes = 'Ejemplo de "dat zal wel" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- hij zal wel moe zijn  (estará cansado)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ei sal uel mu sein', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'estará cansado'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Estará en el atasco.', 'SENTENCE', 'Ejemplo de "hij zal wel moe zijn" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Estará en el atasco.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Estará en el atasco.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (can.)' LIMIT 1),
    'nl_NL', 'Ze zal wel in de file staan.', 'Se sal uel in de file stan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estará en el atasco.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estará en el atasco.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'estará cansado'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Estará en el atasco.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Será caro, imagino.', 'SENTENCE', 'Ejemplo de "hij zal wel moe zijn" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Será caro, imagino.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Será caro, imagino.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (can.)' LIMIT 1),
    'nl_NL', 'Het zal wel duur zijn.', 'Et sal uel dur sein.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Será caro, imagino.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Será caro, imagino.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'estará cansado'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Será caro, imagino.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Dónde está? Estará en casa.', 'SENTENCE', 'Ejemplo de "hij zal wel moe zijn" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Dónde está? Estará en casa.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Dónde está? Estará en casa.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (vraag)' LIMIT 1),
    'nl_NL', 'Waar is hij? Hij zal wel thuis zijn.', 'Uar is ei? Ei sal uel taus sein.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Dónde está? Estará en casa.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Dónde está? Estará en casa.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'estará cansado'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Dónde está? Estará en casa.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Creo que estará cansado.', 'SENTENCE', 'Ejemplo de "hij zal wel moe zijn" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Creo que estará cansado.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Creo que estará cansado.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik denk dat hij wel moe zal zijn.', 'Ik denk dat ei uel mu sal sein.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Creo que estará cansado.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Creo que estará cansado.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'estará cansado'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Creo que estará cansado.' AND notes = 'Ejemplo de "hij zal wel moe zijn" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- we zullen zien  (ya veremos)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ue sullen sin', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'ya veremos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Ya veremos en qué queda.', 'SENTENCE', 'Ejemplo de "we zullen zien" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Ya veremos en qué queda.' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya veremos en qué queda.' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)' LIMIT 1),
    'nl_NL', 'We zullen wel zien wat het wordt.', 'Ue sullen uel sin uat et uordt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya veremos en qué queda.' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya veremos en qué queda.' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'ya veremos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Ya veremos en qué queda.' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Saldrá bien? Ya veremos.', 'SENTENCE', 'Ejemplo de "we zullen zien" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Saldrá bien? Ya veremos.' AND notes = 'Ejemplo de "we zullen zien" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Saldrá bien? Ya veremos.' AND notes = 'Ejemplo de "we zullen zien" (vraag)' LIMIT 1),
    'nl_NL', 'Komt het goed? We zullen zien.', 'Komt et jud? Ue sullen sin.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Saldrá bien? Ya veremos.' AND notes = 'Ejemplo de "we zullen zien" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Saldrá bien? Ya veremos.' AND notes = 'Ejemplo de "we zullen zien" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'ya veremos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Saldrá bien? Ya veremos.' AND notes = 'Ejemplo de "we zullen zien" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Quién sabe?', 'SENTENCE', 'Ejemplo de "we zullen zien" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Quién sabe?' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Quién sabe?' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)' LIMIT 1),
    'nl_NL', 'Wie zal het zeggen?', 'Ui sal et sejjen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Quién sabe?' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Quién sabe?' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'ya veremos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Quién sabe?' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¡Eso ya lo veremos! (desafío)', 'SENTENCE', 'Ejemplo de "we zullen zien" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡Eso ya lo veremos! (desafío)' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡Eso ya lo veremos! (desafío)' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)' LIMIT 1),
    'nl_NL', 'Dat zullen we nog weleens zien!', 'Dat sullen ue noj uelens sin!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Eso ya lo veremos! (desafío)' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Eso ya lo veremos! (desafío)' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'ya veremos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¡Eso ya lo veremos! (desafío)' AND notes = 'Ejemplo de "we zullen zien" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- zou je me kunnen helpen?  (¿podrías ayudarme?)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'sau ye me kunnen elpen?', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿podrías ayudarme?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Te importaría cerrar la ventana?', 'SENTENCE', 'Ejemplo de "zou je me kunnen helpen?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Te importaría cerrar la ventana?' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Te importaría cerrar la ventana?' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (vraag)' LIMIT 1),
    'nl_NL', 'Zou je het raam dicht willen doen?', 'Sau ye et ram dijt uillen dun?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Te importaría cerrar la ventana?' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Te importaría cerrar la ventana?' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿podrías ayudarme?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Te importaría cerrar la ventana?' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Podría preguntarle algo? (formal, con "u")', 'SENTENCE', 'Ejemplo de "zou je me kunnen helpen?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Podría preguntarle algo? (formal, con "u")' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Podría preguntarle algo? (formal, con "u")' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (vraag)' LIMIT 1),
    'nl_NL', 'Zou ik u iets mogen vragen?', 'Sau ik u its mojen frajen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Podría preguntarle algo? (formal, con "u")' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Podría preguntarle algo? (formal, con "u")' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿podrías ayudarme?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Podría preguntarle algo? (formal, con "u")' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Eso sería estupendo.', 'SENTENCE', 'Ejemplo de "zou je me kunnen helpen?" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Eso sería estupendo.' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso sería estupendo.' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (can.)' LIMIT 1),
    'nl_NL', 'Dat zou heel fijn zijn.', 'Dat sau el fein sein.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso sería estupendo.' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso sería estupendo.' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿podrías ayudarme?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Eso sería estupendo.' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Pregunté si podrías ayudarme.', 'SENTENCE', 'Ejemplo de "zou je me kunnen helpen?" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Pregunté si podrías ayudarme.' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Pregunté si podrías ayudarme.' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik vroeg of je me zou kunnen helpen.', 'Ik fruj of ye me sau kunnen elpen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Pregunté si podrías ayudarme.' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Pregunté si podrías ayudarme.' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿podrías ayudarme?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Pregunté si podrías ayudarme.' AND notes = 'Ejemplo de "zou je me kunnen helpen?" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- dat zou leuk zijn  (sería genial)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'dat sau lek sein', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'sería genial'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Querría un café (pedir con educación).', 'SENTENCE', 'Ejemplo de "dat zou leuk zijn" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Querría un café (pedir con educación).' AND notes = 'Ejemplo de "dat zou leuk zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Querría un café (pedir con educación).' AND notes = 'Ejemplo de "dat zou leuk zijn" (can.)' LIMIT 1),
    'nl_NL', 'Ik zou graag een koffie willen.', 'Ik sau jraj en koffi uillen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Querría un café (pedir con educación).' AND notes = 'Ejemplo de "dat zou leuk zijn" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Querría un café (pedir con educación).' AND notes = 'Ejemplo de "dat zou leuk zijn" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'sería genial'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Querría un café (pedir con educación).' AND notes = 'Ejemplo de "dat zou leuk zijn" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Sin ti no saldría bien.', 'SENTENCE', 'Ejemplo de "dat zou leuk zijn" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Sin ti no saldría bien.' AND notes = 'Ejemplo de "dat zou leuk zijn" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Sin ti no saldría bien.' AND notes = 'Ejemplo de "dat zou leuk zijn" (inv.)' LIMIT 1),
    'nl_NL', 'Zonder jou zou het niet lukken.', 'Sonder yau sau et nit lukken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Sin ti no saldría bien.' AND notes = 'Ejemplo de "dat zou leuk zijn" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Sin ti no saldría bien.' AND notes = 'Ejemplo de "dat zou leuk zijn" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'sería genial'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Sin ti no saldría bien.' AND notes = 'Ejemplo de "dat zou leuk zijn" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Tú qué harías?', 'SENTENCE', 'Ejemplo de "dat zou leuk zijn" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Tú qué harías?' AND notes = 'Ejemplo de "dat zou leuk zijn" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tú qué harías?' AND notes = 'Ejemplo de "dat zou leuk zijn" (vraag)' LIMIT 1),
    'nl_NL', 'Wat zou jij doen?', 'Uat sau yei dun?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tú qué harías?' AND notes = 'Ejemplo de "dat zou leuk zijn" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tú qué harías?' AND notes = 'Ejemplo de "dat zou leuk zijn" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'sería genial'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Tú qué harías?' AND notes = 'Ejemplo de "dat zou leuk zijn" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Yo que tú, lo haría.', 'SENTENCE', 'Ejemplo de "dat zou leuk zijn" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Yo que tú, lo haría.' AND notes = 'Ejemplo de "dat zou leuk zijn" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Yo que tú, lo haría.' AND notes = 'Ejemplo de "dat zou leuk zijn" (bijzin)' LIMIT 1),
    'nl_NL', 'Als ik jou was, zou ik het doen.', 'Als ik yau uas, sau ik et dun.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Yo que tú, lo haría.' AND notes = 'Ejemplo de "dat zou leuk zijn" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Yo que tú, lo haría.' AND notes = 'Ejemplo de "dat zou leuk zijn" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'sería genial'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Yo que tú, lo haría.' AND notes = 'Ejemplo de "dat zou leuk zijn" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- zou hij komen?  (¿vendrá?)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'sau ei komen?', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿vendrá?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Lloverá? (quién sabe)', 'SENTENCE', 'Ejemplo de "zou hij komen?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Lloverá? (quién sabe)' AND notes = 'Ejemplo de "zou hij komen?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Lloverá? (quién sabe)' AND notes = 'Ejemplo de "zou hij komen?" (vraag)' LIMIT 1),
    'nl_NL', 'Zou het gaan regenen?', 'Sau et jan rejenen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Lloverá? (quién sabe)' AND notes = 'Ejemplo de "zou hij komen?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Lloverá? (quién sabe)' AND notes = 'Ejemplo de "zou hij komen?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿vendrá?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Lloverá? (quién sabe)' AND notes = 'Ejemplo de "zou hij komen?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Lo sabrá ya?', 'SENTENCE', 'Ejemplo de "zou hij komen?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Lo sabrá ya?' AND notes = 'Ejemplo de "zou hij komen?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Lo sabrá ya?' AND notes = 'Ejemplo de "zou hij komen?" (vraag)' LIMIT 1),
    'nl_NL', 'Zou ze het al weten?', 'Sau se et al ueten?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Lo sabrá ya?' AND notes = 'Ejemplo de "zou hij komen?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Lo sabrá ya?' AND notes = 'Ejemplo de "zou hij komen?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿vendrá?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Lo sabrá ya?' AND notes = 'Ejemplo de "zou hij komen?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Podría ser.', 'SENTENCE', 'Ejemplo de "zou hij komen?" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Podría ser.' AND notes = 'Ejemplo de "zou hij komen?" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Podría ser.' AND notes = 'Ejemplo de "zou hij komen?" (can.)' LIMIT 1),
    'nl_NL', 'Het zou kunnen.', 'Et sau kunnen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Podría ser.' AND notes = 'Ejemplo de "zou hij komen?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Podría ser.' AND notes = 'Ejemplo de "zou hij komen?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿vendrá?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Podría ser.' AND notes = 'Ejemplo de "zou hij komen?" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me pregunto si vendría.', 'SENTENCE', 'Ejemplo de "zou hij komen?" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Me pregunto si vendría.' AND notes = 'Ejemplo de "zou hij komen?" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me pregunto si vendría.' AND notes = 'Ejemplo de "zou hij komen?" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik vraag me af of hij zou komen.', 'Ik fraj me af of ei sau komen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me pregunto si vendría.' AND notes = 'Ejemplo de "zou hij komen?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me pregunto si vendría.' AND notes = 'Ejemplo de "zou hij komen?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿vendrá?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me pregunto si vendría.' AND notes = 'Ejemplo de "zou hij komen?" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- je zult wel moeten  (no te quedará otra)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ye sult uel muten', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'no te quedará otra'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Tendremos que madrugar.', 'SENTENCE', 'Ejemplo de "je zult wel moeten" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Tendremos que madrugar.' AND notes = 'Ejemplo de "je zult wel moeten" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Tendremos que madrugar.' AND notes = 'Ejemplo de "je zult wel moeten" (can.)' LIMIT 1),
    'nl_NL', 'We zullen vroeg op moeten staan.', 'Ue sullen fruj op muten stan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tendremos que madrugar.' AND notes = 'Ejemplo de "je zult wel moeten" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tendremos que madrugar.' AND notes = 'Ejemplo de "je zult wel moeten" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'no te quedará otra'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Tendremos que madrugar.' AND notes = 'Ejemplo de "je zult wel moeten" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿En serio hay que hacerlo? ¡No queda otra!', 'SENTENCE', 'Ejemplo de "je zult wel moeten" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿En serio hay que hacerlo? ¡No queda otra!' AND notes = 'Ejemplo de "je zult wel moeten" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿En serio hay que hacerlo? ¡No queda otra!' AND notes = 'Ejemplo de "je zult wel moeten" (vraag)' LIMIT 1),
    'nl_NL', 'Moet dat echt? Je zult wel moeten!', 'Mut dat ejt? Ye sult uel muten!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿En serio hay que hacerlo? ¡No queda otra!' AND notes = 'Ejemplo de "je zult wel moeten" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿En serio hay que hacerlo? ¡No queda otra!' AND notes = 'Ejemplo de "je zult wel moeten" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'no te quedará otra'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿En serio hay que hacerlo? ¡No queda otra!' AND notes = 'Ejemplo de "je zult wel moeten" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Algo tendrá que cambiar.', 'SENTENCE', 'Ejemplo de "je zult wel moeten" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Algo tendrá que cambiar.' AND notes = 'Ejemplo de "je zult wel moeten" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Algo tendrá que cambiar.' AND notes = 'Ejemplo de "je zult wel moeten" (can.)' LIMIT 1),
    'nl_NL', 'Er zal iets moeten veranderen.', 'Er sal its muten feranderen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Algo tendrá que cambiar.' AND notes = 'Ejemplo de "je zult wel moeten" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Algo tendrá que cambiar.' AND notes = 'Ejemplo de "je zult wel moeten" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'no te quedará otra'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Algo tendrá que cambiar.' AND notes = 'Ejemplo de "je zult wel moeten" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Sabe que tendrá que elegir.', 'SENTENCE', 'Ejemplo de "je zult wel moeten" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Sabe que tendrá que elegir.' AND notes = 'Ejemplo de "je zult wel moeten" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Sabe que tendrá que elegir.' AND notes = 'Ejemplo de "je zult wel moeten" (bijzin)' LIMIT 1),
    'nl_NL', 'Hij weet dat hij zal moeten kiezen.', 'Ei uet dat ei sal muten kisen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Sabe que tendrá que elegir.' AND notes = 'Ejemplo de "je zult wel moeten" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'zullen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Sabe que tendrá que elegir.' AND notes = 'Ejemplo de "je zult wel moeten" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'no te quedará otra'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'zullen')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Sabe que tendrá que elegir.' AND notes = 'Ejemplo de "je zult wel moeten" (bijzin)' LIMIT 1),
    'EXAMPLE');
