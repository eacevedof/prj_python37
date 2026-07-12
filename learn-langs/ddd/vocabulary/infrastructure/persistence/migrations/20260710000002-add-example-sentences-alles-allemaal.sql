-- Learn Languages App - Frases de ejemplo del grupo "alles-allemaal" como tarjetas entrenables
-- Migration: 20260710000002-add-example-sentences-alles-allemaal.sql
-- Description: Convierte las frases de ejemplo (words_lang.notes) de las palabras del
--   grupo "alles-allemaal" en entradas words_es/words_lang propias (word_type SENTENCE),
--   asociadas al grupo y a "generic", enlazadas a su palabra madre via word_es_relations
--   (relation_type EXAMPLE) y con pronunciacion generada con DutchToSpanishPhoneticService.
--   Ademas rellena pronunciation de las palabras madre SOLO si esta vacia.
--   100% aditiva e idempotente: solo INSERT (NOT EXISTS / OR IGNORE) y UPDATE de
--   pronunciation vacia. No borra ni modifica notes, audio_path ni imagenes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- alles goed?  (¿todo bien?)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'alles jud?', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿todo bien?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Hola, ¿todo bien?', 'SENTENCE', 'Ejemplo de "alles goed?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Hola, ¿todo bien?' AND notes = 'Ejemplo de "alles goed?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Hola, ¿todo bien?' AND notes = 'Ejemplo de "alles goed?" (vraag)' LIMIT 1),
    'nl_NL', 'Hoi, alles goed?', 'Oi, alles jud?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hola, ¿todo bien?' AND notes = 'Ejemplo de "alles goed?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hola, ¿todo bien?' AND notes = 'Ejemplo de "alles goed?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿todo bien?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Hola, ¿todo bien?' AND notes = 'Ejemplo de "alles goed?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Tu madre está bien?', 'SENTENCE', 'Ejemplo de "alles goed?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Tu madre está bien?' AND notes = 'Ejemplo de "alles goed?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tu madre está bien?' AND notes = 'Ejemplo de "alles goed?" (vraag)' LIMIT 1),
    'nl_NL', 'Alles goed met je moeder?', 'Alles jud met ye muder?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tu madre está bien?' AND notes = 'Ejemplo de "alles goed?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tu madre está bien?' AND notes = 'Ejemplo de "alles goed?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿todo bien?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Tu madre está bien?' AND notes = 'Ejemplo de "alles goed?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Todo ha salido bien.', 'SENTENCE', 'Ejemplo de "alles goed?" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Todo ha salido bien.' AND notes = 'Ejemplo de "alles goed?" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo ha salido bien.' AND notes = 'Ejemplo de "alles goed?" (perf.)' LIMIT 1),
    'nl_NL', 'Alles is goed gegaan.', 'Alles is jud jejan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo ha salido bien.' AND notes = 'Ejemplo de "alles goed?" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo ha salido bien.' AND notes = 'Ejemplo de "alles goed?" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿todo bien?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Todo ha salido bien.' AND notes = 'Ejemplo de "alles goed?" (perf.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Todo guay? (variante muy coloquial)', 'SENTENCE', 'Ejemplo de "alles goed?" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Todo guay? (variante muy coloquial)' AND notes = 'Ejemplo de "alles goed?" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Todo guay? (variante muy coloquial)' AND notes = 'Ejemplo de "alles goed?" (uitdr.)' LIMIT 1),
    'nl_NL', 'Alles kits?', 'Alles kits?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Todo guay? (variante muy coloquial)' AND notes = 'Ejemplo de "alles goed?" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Todo guay? (variante muy coloquial)' AND notes = 'Ejemplo de "alles goed?" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿todo bien?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Todo guay? (variante muy coloquial)' AND notes = 'Ejemplo de "alles goed?" (uitdr.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Espero que todo se arregle.', 'SENTENCE', 'Ejemplo de "alles goed?" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Espero que todo se arregle.' AND notes = 'Ejemplo de "alles goed?" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Espero que todo se arregle.' AND notes = 'Ejemplo de "alles goed?" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik hoop dat alles goed komt.', 'Ik op dat alles jud komt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Espero que todo se arregle.' AND notes = 'Ejemplo de "alles goed?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Espero que todo se arregle.' AND notes = 'Ejemplo de "alles goed?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿todo bien?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Espero que todo se arregle.' AND notes = 'Ejemplo de "alles goed?" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- ik heb alles weggegeven  (lo regalé todo)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ik eb alles uejjejefen', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo regalé todo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Tras la mudanza lo regalé todo.', 'SENTENCE', 'Ejemplo de "ik heb alles weggegeven" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Tras la mudanza lo regalé todo.' AND notes = 'Ejemplo de "ik heb alles weggegeven" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Tras la mudanza lo regalé todo.' AND notes = 'Ejemplo de "ik heb alles weggegeven" (inv.)' LIMIT 1),
    'nl_NL', 'Na de verhuizing heb ik alles weggegeven.', 'Na de ferausinj eb ik alles uejjejefen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tras la mudanza lo regalé todo.' AND notes = 'Ejemplo de "ik heb alles weggegeven" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tras la mudanza lo regalé todo.' AND notes = 'Ejemplo de "ik heb alles weggegeven" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo regalé todo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Tras la mudanza lo regalé todo.' AND notes = 'Ejemplo de "ik heb alles weggegeven" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿De verdad lo regalaste todo?', 'SENTENCE', 'Ejemplo de "ik heb alles weggegeven" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿De verdad lo regalaste todo?' AND notes = 'Ejemplo de "ik heb alles weggegeven" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿De verdad lo regalaste todo?' AND notes = 'Ejemplo de "ik heb alles weggegeven" (vraag)' LIMIT 1),
    'nl_NL', 'Heb je echt alles weggegeven?', 'Eb ye ejt alles uejjejefen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿De verdad lo regalaste todo?' AND notes = 'Ejemplo de "ik heb alles weggegeven" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿De verdad lo regalaste todo?' AND notes = 'Ejemplo de "ik heb alles weggegeven" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo regalé todo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿De verdad lo regalaste todo?' AND notes = 'Ejemplo de "ik heb alles weggegeven" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'No queda nada, todo ha desaparecido.', 'SENTENCE', 'Ejemplo de "ik heb alles weggegeven" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'No queda nada, todo ha desaparecido.' AND notes = 'Ejemplo de "ik heb alles weggegeven" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No queda nada, todo ha desaparecido.' AND notes = 'Ejemplo de "ik heb alles weggegeven" (can.)' LIMIT 1),
    'nl_NL', 'Alles is weg.', 'Alles is uej.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No queda nada, todo ha desaparecido.' AND notes = 'Ejemplo de "ik heb alles weggegeven" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No queda nada, todo ha desaparecido.' AND notes = 'Ejemplo de "ik heb alles weggegeven" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo regalé todo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'No queda nada, todo ha desaparecido.' AND notes = 'Ejemplo de "ik heb alles weggegeven" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¡Todo o nada!', 'SENTENCE', 'Ejemplo de "ik heb alles weggegeven" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡Todo o nada!' AND notes = 'Ejemplo de "ik heb alles weggegeven" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡Todo o nada!' AND notes = 'Ejemplo de "ik heb alles weggegeven" (uitdr.)' LIMIT 1),
    'nl_NL', 'Alles of niets!', 'Alles of nits!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Todo o nada!' AND notes = 'Ejemplo de "ik heb alles weggegeven" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Todo o nada!' AND notes = 'Ejemplo de "ik heb alles weggegeven" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo regalé todo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¡Todo o nada!' AND notes = 'Ejemplo de "ik heb alles weggegeven" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- alles wat je zegt  (todo lo que dices)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'alles uat ye sejt', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todo lo que dices'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Todo lo que dices es verdad.', 'SENTENCE', 'Ejemplo de "alles wat je zegt" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Todo lo que dices es verdad.' AND notes = 'Ejemplo de "alles wat je zegt" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo lo que dices es verdad.' AND notes = 'Ejemplo de "alles wat je zegt" (can.)' LIMIT 1),
    'nl_NL', 'Alles wat je zegt, is waar.', 'Alles uat ye sejt, is uar.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo lo que dices es verdad.' AND notes = 'Ejemplo de "alles wat je zegt" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo lo que dices es verdad.' AND notes = 'Ejemplo de "alles wat je zegt" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todo lo que dices'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Todo lo que dices es verdad.' AND notes = 'Ejemplo de "alles wat je zegt" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me creo todo lo que cuenta.', 'SENTENCE', 'Ejemplo de "alles wat je zegt" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Me creo todo lo que cuenta.' AND notes = 'Ejemplo de "alles wat je zegt" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me creo todo lo que cuenta.' AND notes = 'Ejemplo de "alles wat je zegt" (can.)' LIMIT 1),
    'nl_NL', 'Ik geloof alles wat hij vertelt.', 'Ik jelof alles uat ei fertelt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me creo todo lo que cuenta.' AND notes = 'Ejemplo de "alles wat je zegt" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me creo todo lo que cuenta.' AND notes = 'Ejemplo de "alles wat je zegt" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todo lo que dices'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me creo todo lo que cuenta.' AND notes = 'Ejemplo de "alles wat je zegt" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'De todo lo que comí, esto fue lo más rico.', 'SENTENCE', 'Ejemplo de "alles wat je zegt" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'De todo lo que comí, esto fue lo más rico.' AND notes = 'Ejemplo de "alles wat je zegt" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'De todo lo que comí, esto fue lo más rico.' AND notes = 'Ejemplo de "alles wat je zegt" (inv.)' LIMIT 1),
    'nl_NL', 'Van alles wat ik at, was dit het lekkerst.', 'Fan alles uat ik at, uas dit et lekkerst.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'De todo lo que comí, esto fue lo más rico.' AND notes = 'Ejemplo de "alles wat je zegt" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'De todo lo que comí, esto fue lo más rico.' AND notes = 'Ejemplo de "alles wat je zegt" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todo lo que dices'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'De todo lo que comí, esto fue lo más rico.' AND notes = 'Ejemplo de "alles wat je zegt" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Todo lo que necesitas está preparado.', 'SENTENCE', 'Ejemplo de "alles wat je zegt" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Todo lo que necesitas está preparado.' AND notes = 'Ejemplo de "alles wat je zegt" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo lo que necesitas está preparado.' AND notes = 'Ejemplo de "alles wat je zegt" (bijzin)' LIMIT 1),
    'nl_NL', 'Alles wat je nodig hebt, ligt klaar.', 'Alles uat ye nodij ebt, lijt klar.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo lo que necesitas está preparado.' AND notes = 'Ejemplo de "alles wat je zegt" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo lo que necesitas está preparado.' AND notes = 'Ejemplo de "alles wat je zegt" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todo lo que dices'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Todo lo que necesitas está preparado.' AND notes = 'Ejemplo de "alles wat je zegt" (bijzin)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'He probado de todo ("van alles" = de todo un poco).', 'SENTENCE', 'Ejemplo de "alles wat je zegt" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'He probado de todo ("van alles" = de todo un poco).' AND notes = 'Ejemplo de "alles wat je zegt" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'He probado de todo ("van alles" = de todo un poco).' AND notes = 'Ejemplo de "alles wat je zegt" (uitdr.)' LIMIT 1),
    'nl_NL', 'Ik heb van alles geprobeerd.', 'Ik eb fan alles jeproberd.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He probado de todo ("van alles" = de todo un poco).' AND notes = 'Ejemplo de "alles wat je zegt" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He probado de todo ("van alles" = de todo un poco).' AND notes = 'Ejemplo de "alles wat je zegt" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todo lo que dices'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'He probado de todo ("van alles" = de todo un poco).' AND notes = 'Ejemplo de "alles wat je zegt" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- ik heb ze allemaal weggegeven  (los regalé todos)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ik eb se allemal uejjejefen', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'los regalé todos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Los libros los he leído todos.', 'SENTENCE', 'Ejemplo de "ik heb ze allemaal weggegeven" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Los libros los he leído todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Los libros los he leído todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (can.)' LIMIT 1),
    'nl_NL', 'De boeken heb ik allemaal gelezen.', 'De buken eb ik allemal jelesen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Los libros los he leído todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Los libros los he leído todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'los regalé todos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Los libros los he leído todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Los has regalado todos?', 'SENTENCE', 'Ejemplo de "ik heb ze allemaal weggegeven" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Los has regalado todos?' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Los has regalado todos?' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (vraag)' LIMIT 1),
    'nl_NL', 'Heb je ze allemaal weggegeven?', 'Eb ye se allemal uejjejefen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Los has regalado todos?' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Los has regalado todos?' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'los regalé todos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Los has regalado todos?' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Ayer los recogí todos.', 'SENTENCE', 'Ejemplo de "ik heb ze allemaal weggegeven" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Ayer los recogí todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer los recogí todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (inv.)' LIMIT 1),
    'nl_NL', 'Gisteren heb ik ze allemaal opgeruimd.', 'Jisteren eb ik se allemal opjeraumd.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer los recogí todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer los recogí todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'los regalé todos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Ayer los recogí todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Preguntó si aún los tenía todos.', 'SENTENCE', 'Ejemplo de "ik heb ze allemaal weggegeven" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Preguntó si aún los tenía todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Preguntó si aún los tenía todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (bijzin)' LIMIT 1),
    'nl_NL', 'Ze vroeg of ik ze allemaal nog had.', 'Se fruj of ik se allemal noj ad.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Preguntó si aún los tenía todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Preguntó si aún los tenía todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'los regalé todos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Preguntó si aún los tenía todos.' AND notes = 'Ejemplo de "ik heb ze allemaal weggegeven" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- we gaan allemaal  (vamos todos)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ue jan allemal', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'vamos todos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Todos vosotros sois bienvenidos.', 'SENTENCE', 'Ejemplo de "we gaan allemaal" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Todos vosotros sois bienvenidos.' AND notes = 'Ejemplo de "we gaan allemaal" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Todos vosotros sois bienvenidos.' AND notes = 'Ejemplo de "we gaan allemaal" (can.)' LIMIT 1),
    'nl_NL', 'Jullie zijn allemaal welkom.', 'Yulli sein allemal uelkom.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todos vosotros sois bienvenidos.' AND notes = 'Ejemplo de "we gaan allemaal" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todos vosotros sois bienvenidos.' AND notes = 'Ejemplo de "we gaan allemaal" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'vamos todos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Todos vosotros sois bienvenidos.' AND notes = 'Ejemplo de "we gaan allemaal" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Esta noche vienen todos.', 'SENTENCE', 'Ejemplo de "we gaan allemaal" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Esta noche vienen todos.' AND notes = 'Ejemplo de "we gaan allemaal" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta noche vienen todos.' AND notes = 'Ejemplo de "we gaan allemaal" (inv.)' LIMIT 1),
    'nl_NL', 'Vanavond komen ze allemaal.', 'Fanafond komen se allemal.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta noche vienen todos.' AND notes = 'Ejemplo de "we gaan allemaal" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta noche vienen todos.' AND notes = 'Ejemplo de "we gaan allemaal" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'vamos todos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Esta noche vienen todos.' AND notes = 'Ejemplo de "we gaan allemaal" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Os apuntáis todos?', 'SENTENCE', 'Ejemplo de "we gaan allemaal" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Os apuntáis todos?' AND notes = 'Ejemplo de "we gaan allemaal" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Os apuntáis todos?' AND notes = 'Ejemplo de "we gaan allemaal" (vraag)' LIMIT 1),
    'nl_NL', 'Gaan jullie allemaal mee?', 'Jan yulli allemal me?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Os apuntáis todos?' AND notes = 'Ejemplo de "we gaan allemaal" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Os apuntáis todos?' AND notes = 'Ejemplo de "we gaan allemaal" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'vamos todos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Os apuntáis todos?' AND notes = 'Ejemplo de "we gaan allemaal" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¡Todos a la vez!', 'SENTENCE', 'Ejemplo de "we gaan allemaal" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡Todos a la vez!' AND notes = 'Ejemplo de "we gaan allemaal" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡Todos a la vez!' AND notes = 'Ejemplo de "we gaan allemaal" (uitdr.)' LIMIT 1),
    'nl_NL', 'Allemaal tegelijk!', 'Allemal tejeleik!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Todos a la vez!' AND notes = 'Ejemplo de "we gaan allemaal" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Todos a la vez!' AND notes = 'Ejemplo de "we gaan allemaal" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'vamos todos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¡Todos a la vez!' AND notes = 'Ejemplo de "we gaan allemaal" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- allemaal troep  (un montón de trastos)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'allemal trup', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'un montón de trastos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Hay un montón de trastos por la calle.', 'SENTENCE', 'Ejemplo de "allemaal troep" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Hay un montón de trastos por la calle.' AND notes = 'Ejemplo de "allemaal troep" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Hay un montón de trastos por la calle.' AND notes = 'Ejemplo de "allemaal troep" (can.)' LIMIT 1),
    'nl_NL', 'Er ligt allemaal troep op straat.', 'Er lijt allemal trup op strat.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hay un montón de trastos por la calle.' AND notes = 'Ejemplo de "allemaal troep" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hay un montón de trastos por la calle.' AND notes = 'Ejemplo de "allemaal troep" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'un montón de trastos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Hay un montón de trastos por la calle.' AND notes = 'Ejemplo de "allemaal troep" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me llegó un montón de propaganda al buzón.', 'SENTENCE', 'Ejemplo de "allemaal troep" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Me llegó un montón de propaganda al buzón.' AND notes = 'Ejemplo de "allemaal troep" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me llegó un montón de propaganda al buzón.' AND notes = 'Ejemplo de "allemaal troep" (can.)' LIMIT 1),
    'nl_NL', 'Ik kreeg allemaal reclame in de bus.', 'Ik krej allemal reclame in de bus.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me llegó un montón de propaganda al buzón.' AND notes = 'Ejemplo de "allemaal troep" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me llegó un montón de propaganda al buzón.' AND notes = 'Ejemplo de "allemaal troep" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'un montón de trastos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me llegó un montón de propaganda al buzón.' AND notes = 'Ejemplo de "allemaal troep" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'En el cobertizo hay un montón de trastos viejos.', 'SENTENCE', 'Ejemplo de "allemaal troep" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'En el cobertizo hay un montón de trastos viejos.' AND notes = 'Ejemplo de "allemaal troep" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'En el cobertizo hay un montón de trastos viejos.' AND notes = 'Ejemplo de "allemaal troep" (inv.)' LIMIT 1),
    'nl_NL', 'In de schuur staat allemaal oude rommel.', 'In de sjur stat allemal aude rommel.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En el cobertizo hay un montón de trastos viejos.' AND notes = 'Ejemplo de "allemaal troep" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En el cobertizo hay un montón de trastos viejos.' AND notes = 'Ejemplo de "allemaal troep" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'un montón de trastos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'En el cobertizo hay un montón de trastos viejos.' AND notes = 'Ejemplo de "allemaal troep" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Qué es todo esto?', 'SENTENCE', 'Ejemplo de "allemaal troep" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Qué es todo esto?' AND notes = 'Ejemplo de "allemaal troep" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué es todo esto?' AND notes = 'Ejemplo de "allemaal troep" (vraag)' LIMIT 1),
    'nl_NL', 'Wat is dat allemaal?', 'Uat is dat allemal?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué es todo esto?' AND notes = 'Ejemplo de "allemaal troep" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué es todo esto?' AND notes = 'Ejemplo de "allemaal troep" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'un montón de trastos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Qué es todo esto?' AND notes = 'Ejemplo de "allemaal troep" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Y qué hago yo con todo eso?', 'SENTENCE', 'Ejemplo de "allemaal troep" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Y qué hago yo con todo eso?' AND notes = 'Ejemplo de "allemaal troep" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Y qué hago yo con todo eso?' AND notes = 'Ejemplo de "allemaal troep" (uitdr.)' LIMIT 1),
    'nl_NL', 'Wat moet ik daar allemaal mee?', 'Uat mut ik dar allemal me?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Y qué hago yo con todo eso?' AND notes = 'Ejemplo de "allemaal troep" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Y qué hago yo con todo eso?' AND notes = 'Ejemplo de "allemaal troep" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'un montón de trastos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Y qué hago yo con todo eso?' AND notes = 'Ejemplo de "allemaal troep" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- alle kinderen  (todos los niños)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'alle kinderen', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todos los niños'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Todos los niños reciben un regalito.', 'SENTENCE', 'Ejemplo de "alle kinderen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Todos los niños reciben un regalito.' AND notes = 'Ejemplo de "alle kinderen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Todos los niños reciben un regalito.' AND notes = 'Ejemplo de "alle kinderen" (can.)' LIMIT 1),
    'nl_NL', 'Alle kinderen krijgen een cadeautje.', 'Alle kinderen kreijen en cadeautye.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todos los niños reciben un regalito.' AND notes = 'Ejemplo de "alle kinderen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todos los niños reciben un regalito.' AND notes = 'Ejemplo de "alle kinderen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todos los niños'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Todos los niños reciben un regalito.' AND notes = 'Ejemplo de "alle kinderen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Trabajo todos los días menos el domingo.', 'SENTENCE', 'Ejemplo de "alle kinderen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Trabajo todos los días menos el domingo.' AND notes = 'Ejemplo de "alle kinderen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Trabajo todos los días menos el domingo.' AND notes = 'Ejemplo de "alle kinderen" (can.)' LIMIT 1),
    'nl_NL', 'Ik werk alle dagen behalve zondag.', 'Ik uerk alle dajen bealfe sondaj.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Trabajo todos los días menos el domingo.' AND notes = 'Ejemplo de "alle kinderen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Trabajo todos los días menos el domingo.' AND notes = 'Ejemplo de "alle kinderen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todos los niños'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Trabajo todos los días menos el domingo.' AND notes = 'Ejemplo de "alle kinderen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'En todas las tiendas hay gente.', 'SENTENCE', 'Ejemplo de "alle kinderen" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'En todas las tiendas hay gente.' AND notes = 'Ejemplo de "alle kinderen" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'En todas las tiendas hay gente.' AND notes = 'Ejemplo de "alle kinderen" (inv.)' LIMIT 1),
    'nl_NL', 'In alle winkels is het druk.', 'In alle uinkels is et druk.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En todas las tiendas hay gente.' AND notes = 'Ejemplo de "alle kinderen" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En todas las tiendas hay gente.' AND notes = 'Ejemplo de "alle kinderen" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todos los niños'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'En todas las tiendas hay gente.' AND notes = 'Ejemplo de "alle kinderen" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Están ocupados todos los sitios?', 'SENTENCE', 'Ejemplo de "alle kinderen" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Están ocupados todos los sitios?' AND notes = 'Ejemplo de "alle kinderen" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Están ocupados todos los sitios?' AND notes = 'Ejemplo de "alle kinderen" (vraag)' LIMIT 1),
    'nl_NL', 'Zijn alle plaatsen bezet?', 'Sein alle platsen beset?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Están ocupados todos los sitios?' AND notes = 'Ejemplo de "alle kinderen" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Están ocupados todos los sitios?' AND notes = 'Ejemplo de "alle kinderen" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todos los niños'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Están ocupados todos los sitios?' AND notes = 'Ejemplo de "alle kinderen" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Se levantó de madrugada (frase hecha: in alle vroegte).', 'SENTENCE', 'Ejemplo de "alle kinderen" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Se levantó de madrugada (frase hecha: in alle vroegte).' AND notes = 'Ejemplo de "alle kinderen" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Se levantó de madrugada (frase hecha: in alle vroegte).' AND notes = 'Ejemplo de "alle kinderen" (uitdr.)' LIMIT 1),
    'nl_NL', 'Hij stond in alle vroegte op.', 'Ei stond in alle frujte op.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Se levantó de madrugada (frase hecha: in alle vroegte).' AND notes = 'Ejemplo de "alle kinderen" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Se levantó de madrugada (frase hecha: in alle vroegte).' AND notes = 'Ejemplo de "alle kinderen" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todos los niños'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Se levantó de madrugada (frase hecha: in alle vroegte).' AND notes = 'Ejemplo de "alle kinderen" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- iedereen  (todo el mundo)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ideren', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todo el mundo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Todo el mundo lo sabe (¡verbo en singular!).', 'SENTENCE', 'Ejemplo de "iedereen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Todo el mundo lo sabe (¡verbo en singular!).' AND notes = 'Ejemplo de "iedereen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo el mundo lo sabe (¡verbo en singular!).' AND notes = 'Ejemplo de "iedereen" (can.)' LIMIT 1),
    'nl_NL', 'Iedereen weet het.', 'Ideren uet et.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo el mundo lo sabe (¡verbo en singular!).' AND notes = 'Ejemplo de "iedereen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo el mundo lo sabe (¡verbo en singular!).' AND notes = 'Ejemplo de "iedereen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todo el mundo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Todo el mundo lo sabe (¡verbo en singular!).' AND notes = 'Ejemplo de "iedereen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'En la fiesta todos se conocían.', 'SENTENCE', 'Ejemplo de "iedereen" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'En la fiesta todos se conocían.' AND notes = 'Ejemplo de "iedereen" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'En la fiesta todos se conocían.' AND notes = 'Ejemplo de "iedereen" (inv.)' LIMIT 1),
    'nl_NL', 'Op het feest kende iedereen elkaar.', 'Op et fest kende ideren elkar.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En la fiesta todos se conocían.' AND notes = 'Ejemplo de "iedereen" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En la fiesta todos se conocían.' AND notes = 'Ejemplo de "iedereen" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todo el mundo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'En la fiesta todos se conocían.' AND notes = 'Ejemplo de "iedereen" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Todo el mundo se ha ido ya a casa.', 'SENTENCE', 'Ejemplo de "iedereen" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Todo el mundo se ha ido ya a casa.' AND notes = 'Ejemplo de "iedereen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo el mundo se ha ido ya a casa.' AND notes = 'Ejemplo de "iedereen" (perf.)' LIMIT 1),
    'nl_NL', 'Iedereen is al naar huis gegaan.', 'Ideren is al nar aus jejan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo el mundo se ha ido ya a casa.' AND notes = 'Ejemplo de "iedereen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo el mundo se ha ido ya a casa.' AND notes = 'Ejemplo de "iedereen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todo el mundo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Todo el mundo se ha ido ya a casa.' AND notes = 'Ejemplo de "iedereen" (perf.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Están todos?', 'SENTENCE', 'Ejemplo de "iedereen" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Están todos?' AND notes = 'Ejemplo de "iedereen" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Están todos?' AND notes = 'Ejemplo de "iedereen" (vraag)' LIMIT 1),
    'nl_NL', 'Is iedereen er?', 'Is ideren er?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Están todos?' AND notes = 'Ejemplo de "iedereen" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Están todos?' AND notes = 'Ejemplo de "iedereen" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todo el mundo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Están todos?' AND notes = 'Ejemplo de "iedereen" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Dice que todo el mundo es bienvenido.', 'SENTENCE', 'Ejemplo de "iedereen" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Dice que todo el mundo es bienvenido.' AND notes = 'Ejemplo de "iedereen" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que todo el mundo es bienvenido.' AND notes = 'Ejemplo de "iedereen" (bijzin)' LIMIT 1),
    'nl_NL', 'Ze zegt dat iedereen welkom is.', 'Se sejt dat ideren uelkom is.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que todo el mundo es bienvenido.' AND notes = 'Ejemplo de "iedereen" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dice que todo el mundo es bienvenido.' AND notes = 'Ejemplo de "iedereen" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'todo el mundo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Dice que todo el mundo es bienvenido.' AND notes = 'Ejemplo de "iedereen" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- allebei  (los dos, ambos)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'allebei', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'los dos, ambos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Venimos los dos.', 'SENTENCE', 'Ejemplo de "allebei" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Venimos los dos.' AND notes = 'Ejemplo de "allebei" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Venimos los dos.' AND notes = 'Ejemplo de "allebei" (can.)' LIMIT 1),
    'nl_NL', 'We komen allebei.', 'Ue komen allebei.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Venimos los dos.' AND notes = 'Ejemplo de "allebei" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Venimos los dos.' AND notes = 'Ejemplo de "allebei" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'los dos, ambos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Venimos los dos.' AND notes = 'Ejemplo de "allebei" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me gustan los dos.', 'SENTENCE', 'Ejemplo de "allebei" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Me gustan los dos.' AND notes = 'Ejemplo de "allebei" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me gustan los dos.' AND notes = 'Ejemplo de "allebei" (can.)' LIMIT 1),
    'nl_NL', 'Ik vind ze allebei leuk.', 'Ik find se allebei lek.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me gustan los dos.' AND notes = 'Ejemplo de "allebei" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me gustan los dos.' AND notes = 'Ejemplo de "allebei" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'los dos, ambos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me gustan los dos.' AND notes = 'Ejemplo de "allebei" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Queréis café los dos?', 'SENTENCE', 'Ejemplo de "allebei" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Queréis café los dos?' AND notes = 'Ejemplo de "allebei" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Queréis café los dos?' AND notes = 'Ejemplo de "allebei" (vraag)' LIMIT 1),
    'nl_NL', 'Willen jullie allebei koffie?', 'Uillen yulli allebei koffi?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Queréis café los dos?' AND notes = 'Ejemplo de "allebei" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Queréis café los dos?' AND notes = 'Ejemplo de "allebei" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'los dos, ambos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Queréis café los dos?' AND notes = 'Ejemplo de "allebei" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'En la foto sonríen ambos.', 'SENTENCE', 'Ejemplo de "allebei" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'En la foto sonríen ambos.' AND notes = 'Ejemplo de "allebei" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'En la foto sonríen ambos.' AND notes = 'Ejemplo de "allebei" (inv.)' LIMIT 1),
    'nl_NL', 'Op de foto lachen ze allebei.', 'Op de foto lajen se allebei.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En la foto sonríen ambos.' AND notes = 'Ejemplo de "allebei" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En la foto sonríen ambos.' AND notes = 'Ejemplo de "allebei" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'los dos, ambos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'En la foto sonríen ambos.' AND notes = 'Ejemplo de "allebei" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Valen las dos opciones.', 'SENTENCE', 'Ejemplo de "allebei" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Valen las dos opciones.' AND notes = 'Ejemplo de "allebei" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Valen las dos opciones.' AND notes = 'Ejemplo de "allebei" (uitdr.)' LIMIT 1),
    'nl_NL', 'Het kan allebei.', 'Et kan allebei.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Valen las dos opciones.' AND notes = 'Ejemplo de "allebei" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'alles-allemaal'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Valen las dos opciones.' AND notes = 'Ejemplo de "allebei" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'los dos, ambos'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Valen las dos opciones.' AND notes = 'Ejemplo de "allebei" (uitdr.)' LIMIT 1),
    'EXAMPLE');
