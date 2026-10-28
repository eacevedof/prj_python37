-- Learn Languages App - Frases de ejemplo del grupo "er" como tarjetas entrenables
-- Migration: 20260710000004-add-example-sentences-er.sql
-- Description: Convierte las frases de ejemplo (words_lang.notes) de las palabras del
--   grupo "er" en entradas words_es/words_lang propias (word_type SENTENCE),
--   asociadas al grupo y a "generic", enlazadas a su palabra madre via word_es_relations
--   (relation_type EXAMPLE) y con pronunciacion generada con DutchToSpanishPhoneticService.
--   Ademas rellena pronunciation de las palabras madre SOLO si esta vacia.
--   100% aditiva e idempotente: solo INSERT (NOT EXISTS / OR IGNORE) y UPDATE de
--   pronunciation vacia. No borra ni modifica notes, audio_path ni imagenes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- er is, er zijn  (hay)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'er is, er sein', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'hay'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Hay café en la cocina.', 'SENTENCE', 'Ejemplo de "er is, er zijn" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Hay café en la cocina.' AND notes = 'Ejemplo de "er is, er zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Hay café en la cocina.' AND notes = 'Ejemplo de "er is, er zijn" (can.)' LIMIT 1),
    'nl_NL', 'Er is koffie in de keuken.', 'Er is koffi in de keken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hay café en la cocina.' AND notes = 'Ejemplo de "er is, er zijn" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hay café en la cocina.' AND notes = 'Ejemplo de "er is, er zijn" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'hay'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Hay café en la cocina.' AND notes = 'Ejemplo de "er is, er zijn" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Hay muchas bicis en Ámsterdam.', 'SENTENCE', 'Ejemplo de "er is, er zijn" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Hay muchas bicis en Ámsterdam.' AND notes = 'Ejemplo de "er is, er zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Hay muchas bicis en Ámsterdam.' AND notes = 'Ejemplo de "er is, er zijn" (can.)' LIMIT 1),
    'nl_NL', 'Er zijn veel fietsen in Amsterdam.', 'Er sein fel fitsen in Amsterdam.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hay muchas bicis en Ámsterdam.' AND notes = 'Ejemplo de "er is, er zijn" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hay muchas bicis en Ámsterdam.' AND notes = 'Ejemplo de "er is, er zijn" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'hay'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Hay muchas bicis en Ámsterdam.' AND notes = 'Ejemplo de "er is, er zijn" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Queda leche?', 'SENTENCE', 'Ejemplo de "er is, er zijn" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Queda leche?' AND notes = 'Ejemplo de "er is, er zijn" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Queda leche?' AND notes = 'Ejemplo de "er is, er zijn" (vraag)' LIMIT 1),
    'nl_NL', 'Is er nog melk?', 'Is er noj melk?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Queda leche?' AND notes = 'Ejemplo de "er is, er zijn" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Queda leche?' AND notes = 'Ejemplo de "er is, er zijn" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'hay'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Queda leche?' AND notes = 'Ejemplo de "er is, er zijn" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Esta noche hay fiesta en casa de los vecinos.', 'SENTENCE', 'Ejemplo de "er is, er zijn" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Esta noche hay fiesta en casa de los vecinos.' AND notes = 'Ejemplo de "er is, er zijn" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta noche hay fiesta en casa de los vecinos.' AND notes = 'Ejemplo de "er is, er zijn" (inv.)' LIMIT 1),
    'nl_NL', 'Vanavond is er een feestje bij de buren.', 'Fanafond is er en festye bei de buren.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta noche hay fiesta en casa de los vecinos.' AND notes = 'Ejemplo de "er is, er zijn" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta noche hay fiesta en casa de los vecinos.' AND notes = 'Ejemplo de "er is, er zijn" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'hay'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Esta noche hay fiesta en casa de los vecinos.' AND notes = 'Ejemplo de "er is, er zijn" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me quedo en casa porque hay tormenta.', 'SENTENCE', 'Ejemplo de "er is, er zijn" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Me quedo en casa porque hay tormenta.' AND notes = 'Ejemplo de "er is, er zijn" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me quedo en casa porque hay tormenta.' AND notes = 'Ejemplo de "er is, er zijn" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik blijf thuis, omdat er storm is.', 'Ik bleif taus, omdat er storm is.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me quedo en casa porque hay tormenta.' AND notes = 'Ejemplo de "er is, er zijn" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me quedo en casa porque hay tormenta.' AND notes = 'Ejemplo de "er is, er zijn" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'hay'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me quedo en casa porque hay tormenta.' AND notes = 'Ejemplo de "er is, er zijn" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- wat is er?  (¿qué pasa?)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'uat is er?', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué pasa?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Qué te pasa a ti?', 'SENTENCE', 'Ejemplo de "wat is er?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Qué te pasa a ti?' AND notes = 'Ejemplo de "wat is er?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué te pasa a ti?' AND notes = 'Ejemplo de "wat is er?" (vraag)' LIMIT 1),
    'nl_NL', 'Wat is er met jou?', 'Uat is er met yau?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué te pasa a ti?' AND notes = 'Ejemplo de "wat is er?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué te pasa a ti?' AND notes = 'Ejemplo de "wat is er?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué pasa?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Qué te pasa a ti?' AND notes = 'Ejemplo de "wat is er?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Pasa algo?', 'SENTENCE', 'Ejemplo de "wat is er?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Pasa algo?' AND notes = 'Ejemplo de "wat is er?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Pasa algo?' AND notes = 'Ejemplo de "wat is er?" (vraag)' LIMIT 1),
    'nl_NL', 'Is er iets?', 'Is er its?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Pasa algo?' AND notes = 'Ejemplo de "wat is er?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Pasa algo?' AND notes = 'Ejemplo de "wat is er?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué pasa?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Pasa algo?' AND notes = 'Ejemplo de "wat is er?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'No pasa nada, tranquilo.', 'SENTENCE', 'Ejemplo de "wat is er?" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'No pasa nada, tranquilo.' AND notes = 'Ejemplo de "wat is er?" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No pasa nada, tranquilo.' AND notes = 'Ejemplo de "wat is er?" (can.)' LIMIT 1),
    'nl_NL', 'Er is niets, hoor.', 'Er is nits, or.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No pasa nada, tranquilo.' AND notes = 'Ejemplo de "wat is er?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No pasa nada, tranquilo.' AND notes = 'Ejemplo de "wat is er?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué pasa?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'No pasa nada, tranquilo.' AND notes = 'Ejemplo de "wat is er?" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Cuéntame qué pasa.', 'SENTENCE', 'Ejemplo de "wat is er?" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Cuéntame qué pasa.' AND notes = 'Ejemplo de "wat is er?" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuéntame qué pasa.' AND notes = 'Ejemplo de "wat is er?" (bijzin)' LIMIT 1),
    'nl_NL', 'Vertel me wat er is.', 'Fertel me uat er is.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuéntame qué pasa.' AND notes = 'Ejemplo de "wat is er?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cuéntame qué pasa.' AND notes = 'Ejemplo de "wat is er?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué pasa?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Cuéntame qué pasa.' AND notes = 'Ejemplo de "wat is er?" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- wat is er aan de hand?  (¿qué está pasando?)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'uat is er an de and?', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué está pasando?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Qué pasa aquí?', 'SENTENCE', 'Ejemplo de "wat is er aan de hand?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Qué pasa aquí?' AND notes = 'Ejemplo de "wat is er aan de hand?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué pasa aquí?' AND notes = 'Ejemplo de "wat is er aan de hand?" (vraag)' LIMIT 1),
    'nl_NL', 'Wat is er hier aan de hand?', 'Uat is er ir an de and?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué pasa aquí?' AND notes = 'Ejemplo de "wat is er aan de hand?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué pasa aquí?' AND notes = 'Ejemplo de "wat is er aan de hand?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué está pasando?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Qué pasa aquí?' AND notes = 'Ejemplo de "wat is er aan de hand?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'No pasa nada, todo en orden.', 'SENTENCE', 'Ejemplo de "wat is er aan de hand?" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'No pasa nada, todo en orden.' AND notes = 'Ejemplo de "wat is er aan de hand?" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No pasa nada, todo en orden.' AND notes = 'Ejemplo de "wat is er aan de hand?" (can.)' LIMIT 1),
    'nl_NL', 'Er is niets aan de hand.', 'Er is nits an de and.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No pasa nada, todo en orden.' AND notes = 'Ejemplo de "wat is er aan de hand?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No pasa nada, todo en orden.' AND notes = 'Ejemplo de "wat is er aan de hand?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué está pasando?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'No pasa nada, todo en orden.' AND notes = 'Ejemplo de "wat is er aan de hand?" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Fuera está pasando algo.', 'SENTENCE', 'Ejemplo de "wat is er aan de hand?" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Fuera está pasando algo.' AND notes = 'Ejemplo de "wat is er aan de hand?" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Fuera está pasando algo.' AND notes = 'Ejemplo de "wat is er aan de hand?" (inv.)' LIMIT 1),
    'nl_NL', 'Buiten is er iets aan de hand.', 'Bauten is er its an de and.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Fuera está pasando algo.' AND notes = 'Ejemplo de "wat is er aan de hand?" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Fuera está pasando algo.' AND notes = 'Ejemplo de "wat is er aan de hand?" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué está pasando?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Fuera está pasando algo.' AND notes = 'Ejemplo de "wat is er aan de hand?" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'No sé qué está pasando.', 'SENTENCE', 'Ejemplo de "wat is er aan de hand?" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'No sé qué está pasando.' AND notes = 'Ejemplo de "wat is er aan de hand?" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No sé qué está pasando.' AND notes = 'Ejemplo de "wat is er aan de hand?" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik weet niet wat er aan de hand is.', 'Ik uet nit uat er an de and is.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No sé qué está pasando.' AND notes = 'Ejemplo de "wat is er aan de hand?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No sé qué está pasando.' AND notes = 'Ejemplo de "wat is er aan de hand?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué está pasando?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'No sé qué está pasando.' AND notes = 'Ejemplo de "wat is er aan de hand?" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- ik ben er  (ya estoy aquí)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ik ben er', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'ya estoy aquí'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'El taxi ya está aquí.', 'SENTENCE', 'Ejemplo de "ik ben er" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'El taxi ya está aquí.' AND notes = 'Ejemplo de "ik ben er" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El taxi ya está aquí.' AND notes = 'Ejemplo de "ik ben er" (can.)' LIMIT 1),
    'nl_NL', 'De taxi is er.', 'De taxi is er.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El taxi ya está aquí.' AND notes = 'Ejemplo de "ik ben er" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El taxi ya está aquí.' AND notes = 'Ejemplo de "ik ben er" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'ya estoy aquí'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'El taxi ya está aquí.' AND notes = 'Ejemplo de "ik ben er" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Ya has llegado? Acabo de llegar.', 'SENTENCE', 'Ejemplo de "ik ben er" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Ya has llegado? Acabo de llegar.' AND notes = 'Ejemplo de "ik ben er" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Ya has llegado? Acabo de llegar.' AND notes = 'Ejemplo de "ik ben er" (perf.)' LIMIT 1),
    'nl_NL', 'Ben je er al? Ik ben er net.', 'Ben ye er al? Ik ben er net.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Ya has llegado? Acabo de llegar.' AND notes = 'Ejemplo de "ik ben er" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Ya has llegado? Acabo de llegar.' AND notes = 'Ejemplo de "ik ben er" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'ya estoy aquí'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Ya has llegado? Acabo de llegar.' AND notes = 'Ejemplo de "ik ben er" (perf.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¡Ya casi llego!', 'SENTENCE', 'Ejemplo de "ik ben er" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡Ya casi llego!' AND notes = 'Ejemplo de "ik ben er" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡Ya casi llego!' AND notes = 'Ejemplo de "ik ben er" (uitdr.)' LIMIT 1),
    'nl_NL', 'Ik ben er bijna!', 'Ik ben er beina!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Ya casi llego!' AND notes = 'Ejemplo de "ik ben er" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Ya casi llego!' AND notes = 'Ejemplo de "ik ben er" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'ya estoy aquí'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¡Ya casi llego!' AND notes = 'Ejemplo de "ik ben er" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- ik ben er nooit geweest  (nunca he estado allí)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ik ben er noit jeuest', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'nunca he estado allí'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Has estado allí alguna vez?', 'SENTENCE', 'Ejemplo de "ik ben er nooit geweest" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Has estado allí alguna vez?' AND notes = 'Ejemplo de "ik ben er nooit geweest" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has estado allí alguna vez?' AND notes = 'Ejemplo de "ik ben er nooit geweest" (vraag)' LIMIT 1),
    'nl_NL', 'Ben je er weleens geweest?', 'Ben ye er uelens jeuest?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has estado allí alguna vez?' AND notes = 'Ejemplo de "ik ben er nooit geweest" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has estado allí alguna vez?' AND notes = 'Ejemplo de "ik ben er nooit geweest" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'nunca he estado allí'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Has estado allí alguna vez?' AND notes = 'Ejemplo de "ik ben er nooit geweest" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Voy mucho por allí.', 'SENTENCE', 'Ejemplo de "ik ben er nooit geweest" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Voy mucho por allí.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy mucho por allí.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (can.)' LIMIT 1),
    'nl_NL', 'Ik kom er vaak.', 'Ik kom er fak.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy mucho por allí.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy mucho por allí.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'nunca he estado allí'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Voy mucho por allí.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Antes vivía allí.', 'SENTENCE', 'Ejemplo de "ik ben er nooit geweest" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Antes vivía allí.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Antes vivía allí.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (inv.)' LIMIT 1),
    'nl_NL', 'Vroeger woonde ik er.', 'Frujer uonde ik er.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Antes vivía allí.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Antes vivía allí.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'nunca he estado allí'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Antes vivía allí.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Dice que allí es bonito.', 'SENTENCE', 'Ejemplo de "ik ben er nooit geweest" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Dice que allí es bonito.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que allí es bonito.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (bijzin)' LIMIT 1),
    'nl_NL', 'Ze zegt dat het er mooi is.', 'Se sejt dat et er moi is.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que allí es bonito.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que allí es bonito.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'nunca he estado allí'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Dice que allí es bonito.' AND notes = 'Ejemplo de "ik ben er nooit geweest" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- ik heb er drie  (tengo tres (de esos))
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ik eb er dri', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'tengo tres (de esos)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Cuántos tienes?', 'SENTENCE', 'Ejemplo de "ik heb er drie" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Cuántos tienes?' AND notes = 'Ejemplo de "ik heb er drie" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cuántos tienes?' AND notes = 'Ejemplo de "ik heb er drie" (vraag)' LIMIT 1),
    'nl_NL', 'Hoeveel heb je er?', 'Ufel eb ye er?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cuántos tienes?' AND notes = 'Ejemplo de "ik heb er drie" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cuántos tienes?' AND notes = 'Ejemplo de "ik heb er drie" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'tengo tres (de esos)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Cuántos tienes?' AND notes = 'Ejemplo de "ik heb er drie" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Quiero otro más.', 'SENTENCE', 'Ejemplo de "ik heb er drie" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Quiero otro más.' AND notes = 'Ejemplo de "ik heb er drie" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Quiero otro más.' AND notes = 'Ejemplo de "ik heb er drie" (can.)' LIMIT 1),
    'nl_NL', 'Ik wil er nog een.', 'Ik uil er noj en.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Quiero otro más.' AND notes = 'Ejemplo de "ik heb er drie" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Quiero otro más.' AND notes = 'Ejemplo de "ik heb er drie" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'tengo tres (de esos)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Quiero otro más.' AND notes = 'Ejemplo de "ik heb er drie" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Ya no nos quedan.', 'SENTENCE', 'Ejemplo de "ik heb er drie" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Ya no nos quedan.' AND notes = 'Ejemplo de "ik heb er drie" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya no nos quedan.' AND notes = 'Ejemplo de "ik heb er drie" (can.)' LIMIT 1),
    'nl_NL', 'We hebben er geen meer.', 'Ue ebben er jen mer.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya no nos quedan.' AND notes = 'Ejemplo de "ik heb er drie" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya no nos quedan.' AND notes = 'Ejemplo de "ik heb er drie" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'tengo tres (de esos)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Ya no nos quedan.' AND notes = 'Ejemplo de "ik heb er drie" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Preguntó cuántos me quedaban.', 'SENTENCE', 'Ejemplo de "ik heb er drie" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Preguntó cuántos me quedaban.' AND notes = 'Ejemplo de "ik heb er drie" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Preguntó cuántos me quedaban.' AND notes = 'Ejemplo de "ik heb er drie" (bijzin)' LIMIT 1),
    'nl_NL', 'Hij vroeg hoeveel ik er nog had.', 'Ei fruj ufel ik er noj ad.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Preguntó cuántos me quedaban.' AND notes = 'Ejemplo de "ik heb er drie" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Preguntó cuántos me quedaban.' AND notes = 'Ejemplo de "ik heb er drie" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'tengo tres (de esos)'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Preguntó cuántos me quedaban.' AND notes = 'Ejemplo de "ik heb er drie" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- wat vind je ervan?  (¿qué te parece?)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'uat find ye erfan?', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué te parece?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Qué te pareció la peli? (con sustantivo: van + cosa)', 'SENTENCE', 'Ejemplo de "wat vind je ervan?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Qué te pareció la peli? (con sustantivo: van + cosa)' AND notes = 'Ejemplo de "wat vind je ervan?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué te pareció la peli? (con sustantivo: van + cosa)' AND notes = 'Ejemplo de "wat vind je ervan?" (vraag)' LIMIT 1),
    'nl_NL', 'Wat vond je van de film?', 'Uat fond ye fan de film?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué te pareció la peli? (con sustantivo: van + cosa)' AND notes = 'Ejemplo de "wat vind je ervan?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué te pareció la peli? (con sustantivo: van + cosa)' AND notes = 'Ejemplo de "wat vind je ervan?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué te parece?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Qué te pareció la peli? (con sustantivo: van + cosa)' AND notes = 'Ejemplo de "wat vind je ervan?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'No le veo la gracia (frase hecha).', 'SENTENCE', 'Ejemplo de "wat vind je ervan?" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'No le veo la gracia (frase hecha).' AND notes = 'Ejemplo de "wat vind je ervan?" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No le veo la gracia (frase hecha).' AND notes = 'Ejemplo de "wat vind je ervan?" (can.)' LIMIT 1),
    'nl_NL', 'Ik vind er niets aan.', 'Ik find er nits an.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No le veo la gracia (frase hecha).' AND notes = 'Ejemplo de "wat vind je ervan?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No le veo la gracia (frase hecha).' AND notes = 'Ejemplo de "wat vind je ervan?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué te parece?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'No le veo la gracia (frase hecha).' AND notes = 'Ejemplo de "wat vind je ervan?" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'No sé nada de eso.', 'SENTENCE', 'Ejemplo de "wat vind je ervan?" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'No sé nada de eso.' AND notes = 'Ejemplo de "wat vind je ervan?" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No sé nada de eso.' AND notes = 'Ejemplo de "wat vind je ervan?" (can.)' LIMIT 1),
    'nl_NL', 'Ik weet er niets van.', 'Ik uet er nits fan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No sé nada de eso.' AND notes = 'Ejemplo de "wat vind je ervan?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No sé nada de eso.' AND notes = 'Ejemplo de "wat vind je ervan?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué te parece?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'No sé nada de eso.' AND notes = 'Ejemplo de "wat vind je ervan?" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Di qué te parece.', 'SENTENCE', 'Ejemplo de "wat vind je ervan?" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Di qué te parece.' AND notes = 'Ejemplo de "wat vind je ervan?" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Di qué te parece.' AND notes = 'Ejemplo de "wat vind je ervan?" (bijzin)' LIMIT 1),
    'nl_NL', 'Zeg eens wat je ervan vindt.', 'Sej ens uat ye erfan findt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Di qué te parece.' AND notes = 'Ejemplo de "wat vind je ervan?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Di qué te parece.' AND notes = 'Ejemplo de "wat vind je ervan?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿qué te parece?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Di qué te parece.' AND notes = 'Ejemplo de "wat vind je ervan?" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- ik heb er zin in  (¡qué ganas!)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ik eb er sin in', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¡qué ganas!'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Tienes ganas?', 'SENTENCE', 'Ejemplo de "ik heb er zin in" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Tienes ganas?' AND notes = 'Ejemplo de "ik heb er zin in" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tienes ganas?' AND notes = 'Ejemplo de "ik heb er zin in" (vraag)' LIMIT 1),
    'nl_NL', 'Heb je er zin in?', 'Eb ye er sin in?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tienes ganas?' AND notes = 'Ejemplo de "ik heb er zin in" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tienes ganas?' AND notes = 'Ejemplo de "ik heb er zin in" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¡qué ganas!'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Tienes ganas?' AND notes = 'Ejemplo de "ik heb er zin in" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'No me apetece nada.', 'SENTENCE', 'Ejemplo de "ik heb er zin in" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'No me apetece nada.' AND notes = 'Ejemplo de "ik heb er zin in" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No me apetece nada.' AND notes = 'Ejemplo de "ik heb er zin in" (can.)' LIMIT 1),
    'nl_NL', 'Ik heb er geen zin in.', 'Ik eb er jen sin in.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No me apetece nada.' AND notes = 'Ejemplo de "ik heb er zin in" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No me apetece nada.' AND notes = 'Ejemplo de "ik heb er zin in" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¡qué ganas!'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'No me apetece nada.' AND notes = 'Ejemplo de "ik heb er zin in" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me apetece un café (con sustantivo: zin in + cosa).', 'SENTENCE', 'Ejemplo de "ik heb er zin in" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Me apetece un café (con sustantivo: zin in + cosa).' AND notes = 'Ejemplo de "ik heb er zin in" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me apetece un café (con sustantivo: zin in + cosa).' AND notes = 'Ejemplo de "ik heb er zin in" (can.)' LIMIT 1),
    'nl_NL', 'Ik heb zin in koffie.', 'Ik eb sin in koffi.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me apetece un café (con sustantivo: zin in + cosa).' AND notes = 'Ejemplo de "ik heb er zin in" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me apetece un café (con sustantivo: zin in + cosa).' AND notes = 'Ejemplo de "ik heb er zin in" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¡qué ganas!'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me apetece un café (con sustantivo: zin in + cosa).' AND notes = 'Ejemplo de "ik heb er zin in" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Dijo que tenía muchísimas ganas.', 'SENTENCE', 'Ejemplo de "ik heb er zin in" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Dijo que tenía muchísimas ganas.' AND notes = 'Ejemplo de "ik heb er zin in" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Dijo que tenía muchísimas ganas.' AND notes = 'Ejemplo de "ik heb er zin in" (bijzin)' LIMIT 1),
    'nl_NL', 'Ze zei dat ze er echt zin in had.', 'Se sei dat se er ejt sin in ad.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dijo que tenía muchísimas ganas.' AND notes = 'Ejemplo de "ik heb er zin in" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dijo que tenía muchísimas ganas.' AND notes = 'Ejemplo de "ik heb er zin in" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¡qué ganas!'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Dijo que tenía muchísimas ganas.' AND notes = 'Ejemplo de "ik heb er zin in" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- ik kan er niets aan doen  (no puedo hacer nada)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ik kan er nits an dun', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'no puedo hacer nada'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Puedes hacer algo al respecto?', 'SENTENCE', 'Ejemplo de "ik kan er niets aan doen" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Puedes hacer algo al respecto?' AND notes = 'Ejemplo de "ik kan er niets aan doen" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Puedes hacer algo al respecto?' AND notes = 'Ejemplo de "ik kan er niets aan doen" (vraag)' LIMIT 1),
    'nl_NL', 'Kun je er iets aan doen?', 'Kun ye er its an dun?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Puedes hacer algo al respecto?' AND notes = 'Ejemplo de "ik kan er niets aan doen" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Puedes hacer algo al respecto?' AND notes = 'Ejemplo de "ik kan er niets aan doen" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'no puedo hacer nada'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Puedes hacer algo al respecto?' AND notes = 'Ejemplo de "ik kan er niets aan doen" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Eso no está en mi mano (enfático con daar).', 'SENTENCE', 'Ejemplo de "ik kan er niets aan doen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Eso no está en mi mano (enfático con daar).' AND notes = 'Ejemplo de "ik kan er niets aan doen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso no está en mi mano (enfático con daar).' AND notes = 'Ejemplo de "ik kan er niets aan doen" (can.)' LIMIT 1),
    'nl_NL', 'Daar kan ik niets aan doen.', 'Dar kan ik nits an dun.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso no está en mi mano (enfático con daar).' AND notes = 'Ejemplo de "ik kan er niets aan doen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso no está en mi mano (enfático con daar).' AND notes = 'Ejemplo de "ik kan er niets aan doen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'no puedo hacer nada'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Eso no está en mi mano (enfático con daar).' AND notes = 'Ejemplo de "ik kan er niets aan doen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Tenemos que hacer algo al respecto.', 'SENTENCE', 'Ejemplo de "ik kan er niets aan doen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Tenemos que hacer algo al respecto.' AND notes = 'Ejemplo de "ik kan er niets aan doen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Tenemos que hacer algo al respecto.' AND notes = 'Ejemplo de "ik kan er niets aan doen" (can.)' LIMIT 1),
    'nl_NL', 'We moeten er iets aan doen.', 'Ue muten er its an dun.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tenemos que hacer algo al respecto.' AND notes = 'Ejemplo de "ik kan er niets aan doen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tenemos que hacer algo al respecto.' AND notes = 'Ejemplo de "ik kan er niets aan doen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'no puedo hacer nada'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Tenemos que hacer algo al respecto.' AND notes = 'Ejemplo de "ik kan er niets aan doen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Dice que no es culpa suya.', 'SENTENCE', 'Ejemplo de "ik kan er niets aan doen" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Dice que no es culpa suya.' AND notes = 'Ejemplo de "ik kan er niets aan doen" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que no es culpa suya.' AND notes = 'Ejemplo de "ik kan er niets aan doen" (bijzin)' LIMIT 1),
    'nl_NL', 'Hij zegt dat hij er niets aan kan doen.', 'Ei sejt dat ei er nits an kan dun.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que no es culpa suya.' AND notes = 'Ejemplo de "ik kan er niets aan doen" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que no es culpa suya.' AND notes = 'Ejemplo de "ik kan er niets aan doen" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'no puedo hacer nada'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Dice que no es culpa suya.' AND notes = 'Ejemplo de "ik kan er niets aan doen" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- hoe gaat het ermee?  (¿cómo te va?)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'u jat et erme?', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿cómo te va?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Cómo va eso? (el estado de un asunto)', 'SENTENCE', 'Ejemplo de "hoe gaat het ermee?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Cómo va eso? (el estado de un asunto)' AND notes = 'Ejemplo de "hoe gaat het ermee?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cómo va eso? (el estado de un asunto)' AND notes = 'Ejemplo de "hoe gaat het ermee?" (vraag)' LIMIT 1),
    'nl_NL', 'Hoe staat het ermee?', 'U stat et erme?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cómo va eso? (el estado de un asunto)' AND notes = 'Ejemplo de "hoe gaat het ermee?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cómo va eso? (el estado de un asunto)' AND notes = 'Ejemplo de "hoe gaat het ermee?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿cómo te va?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Cómo va eso? (el estado de un asunto)' AND notes = 'Ejemplo de "hoe gaat het ermee?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Va bien la cosa.', 'SENTENCE', 'Ejemplo de "hoe gaat het ermee?" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Va bien la cosa.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Va bien la cosa.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (can.)' LIMIT 1),
    'nl_NL', 'Het gaat er goed mee.', 'Et jat er jud me.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Va bien la cosa.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Va bien la cosa.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿cómo te va?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Va bien la cosa.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Estoy muy liado con ello.', 'SENTENCE', 'Ejemplo de "hoe gaat het ermee?" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Estoy muy liado con ello.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy muy liado con ello.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (can.)' LIMIT 1),
    'nl_NL', 'Ik ben er druk mee bezig.', 'Ik ben er druk me besij.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy muy liado con ello.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy muy liado con ello.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿cómo te va?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Estoy muy liado con ello.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Preguntó cómo iba todo.', 'SENTENCE', 'Ejemplo de "hoe gaat het ermee?" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Preguntó cómo iba todo.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Preguntó cómo iba todo.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (bijzin)' LIMIT 1),
    'nl_NL', 'Ze vroeg hoe het ermee ging.', 'Se fruj u et erme jinj.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Preguntó cómo iba todo.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Preguntó cómo iba todo.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿cómo te va?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Preguntó cómo iba todo.' AND notes = 'Ejemplo de "hoe gaat het ermee?" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- er wordt aangebeld  (llaman a la puerta)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'er uordt anjebeld', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'llaman a la puerta'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Están llamando a la puerta (golpes).', 'SENTENCE', 'Ejemplo de "er wordt aangebeld" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Están llamando a la puerta (golpes).' AND notes = 'Ejemplo de "er wordt aangebeld" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Están llamando a la puerta (golpes).' AND notes = 'Ejemplo de "er wordt aangebeld" (can.)' LIMIT 1),
    'nl_NL', 'Er wordt op de deur geklopt.', 'Er uordt op de der jeklopt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Están llamando a la puerta (golpes).' AND notes = 'Ejemplo de "er wordt aangebeld" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Están llamando a la puerta (golpes).' AND notes = 'Ejemplo de "er wordt aangebeld" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'llaman a la puerta'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Están llamando a la puerta (golpes).' AND notes = 'Ejemplo de "er wordt aangebeld" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Aquí se trabaja duro.', 'SENTENCE', 'Ejemplo de "er wordt aangebeld" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Aquí se trabaja duro.' AND notes = 'Ejemplo de "er wordt aangebeld" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí se trabaja duro.' AND notes = 'Ejemplo de "er wordt aangebeld" (can.)' LIMIT 1),
    'nl_NL', 'Er wordt hier hard gewerkt.', 'Er uordt ir ard jeuerkt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí se trabaja duro.' AND notes = 'Ejemplo de "er wordt aangebeld" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí se trabaja duro.' AND notes = 'Ejemplo de "er wordt aangebeld" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'llaman a la puerta'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Aquí se trabaja duro.' AND notes = 'Ejemplo de "er wordt aangebeld" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Por la noche llama mucha gente.', 'SENTENCE', 'Ejemplo de "er wordt aangebeld" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Por la noche llama mucha gente.' AND notes = 'Ejemplo de "er wordt aangebeld" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Por la noche llama mucha gente.' AND notes = 'Ejemplo de "er wordt aangebeld" (inv.)' LIMIT 1),
    'nl_NL', '''s Avonds wordt er veel gebeld.', '''s Afonds uordt er fel jebeld.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Por la noche llama mucha gente.' AND notes = 'Ejemplo de "er wordt aangebeld" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Por la noche llama mucha gente.' AND notes = 'Ejemplo de "er wordt aangebeld" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'llaman a la puerta'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Por la noche llama mucha gente.' AND notes = 'Ejemplo de "er wordt aangebeld" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Oigo que llaman a la puerta.', 'SENTENCE', 'Ejemplo de "er wordt aangebeld" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Oigo que llaman a la puerta.' AND notes = 'Ejemplo de "er wordt aangebeld" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Oigo que llaman a la puerta.' AND notes = 'Ejemplo de "er wordt aangebeld" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik hoor dat er wordt aangebeld.', 'Ik or dat er uordt anjebeld.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Oigo que llaman a la puerta.' AND notes = 'Ejemplo de "er wordt aangebeld" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Oigo que llaman a la puerta.' AND notes = 'Ejemplo de "er wordt aangebeld" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'llaman a la puerta'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Oigo que llaman a la puerta.' AND notes = 'Ejemplo de "er wordt aangebeld" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- we gaan ertegenaan!  (¡a por ello!)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ue jan ertejenan!', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¡a por ello!'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¡Venga, a por ello! (ergens voor gaan)', 'SENTENCE', 'Ejemplo de "we gaan ertegenaan!" (geb.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡Venga, a por ello! (ergens voor gaan)' AND notes = 'Ejemplo de "we gaan ertegenaan!" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡Venga, a por ello! (ergens voor gaan)' AND notes = 'Ejemplo de "we gaan ertegenaan!" (geb.)' LIMIT 1),
    'nl_NL', 'Kom op, ga ervoor!', 'Kom op, ja erfor!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Venga, a por ello! (ergens voor gaan)' AND notes = 'Ejemplo de "we gaan ertegenaan!" (geb.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Venga, a por ello! (ergens voor gaan)' AND notes = 'Ejemplo de "we gaan ertegenaan!" (geb.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¡a por ello!'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¡Venga, a por ello! (ergens voor gaan)' AND notes = 'Ejemplo de "we gaan ertegenaan!" (geb.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Voy a por todas.', 'SENTENCE', 'Ejemplo de "we gaan ertegenaan!" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Voy a por todas.' AND notes = 'Ejemplo de "we gaan ertegenaan!" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy a por todas.' AND notes = 'Ejemplo de "we gaan ertegenaan!" (can.)' LIMIT 1),
    'nl_NL', 'Ik ga er vol voor.', 'Ik ja er fol for.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy a por todas.' AND notes = 'Ejemplo de "we gaan ertegenaan!" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy a por todas.' AND notes = 'Ejemplo de "we gaan ertegenaan!" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¡a por ello!'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Voy a por todas.' AND notes = 'Ejemplo de "we gaan ertegenaan!" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¡O todo o nada!', 'SENTENCE', 'Ejemplo de "we gaan ertegenaan!" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡O todo o nada!' AND notes = 'Ejemplo de "we gaan ertegenaan!" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡O todo o nada!' AND notes = 'Ejemplo de "we gaan ertegenaan!" (uitdr.)' LIMIT 1),
    'nl_NL', 'Erop of eronder!', 'Erop of eronder!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡O todo o nada!' AND notes = 'Ejemplo de "we gaan ertegenaan!" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡O todo o nada!' AND notes = 'Ejemplo de "we gaan ertegenaan!" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¡a por ello!'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¡O todo o nada!' AND notes = 'Ejemplo de "we gaan ertegenaan!" (uitdr.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'El míster dice que hay que darlo todo.', 'SENTENCE', 'Ejemplo de "we gaan ertegenaan!" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'El míster dice que hay que darlo todo.' AND notes = 'Ejemplo de "we gaan ertegenaan!" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El míster dice que hay que darlo todo.' AND notes = 'Ejemplo de "we gaan ertegenaan!" (bijzin)' LIMIT 1),
    'nl_NL', 'De coach zegt dat we ertegenaan moeten.', 'De coaj sejt dat ue ertejenan muten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El míster dice que hay que darlo todo.' AND notes = 'Ejemplo de "we gaan ertegenaan!" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'er'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El míster dice que hay que darlo todo.' AND notes = 'Ejemplo de "we gaan ertegenaan!" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¡a por ello!'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'er')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'El míster dice que hay que darlo todo.' AND notes = 'Ejemplo de "we gaan ertegenaan!" (bijzin)' LIMIT 1),
    'EXAMPLE');
