-- Learn Languages App - Frases de ejemplo del grupo "soms-weleens-ooit" como tarjetas entrenables
-- Migration: 20260710000003-add-example-sentences-soms-weleens-ooit.sql
-- Description: Convierte las frases de ejemplo (words_lang.notes) de las palabras del
--   grupo "soms-weleens-ooit" en entradas words_es/words_lang propias (word_type SENTENCE),
--   asociadas al grupo y a "generic", enlazadas a su palabra madre via word_es_relations
--   (relation_type EXAMPLE) y con pronunciacion generada con DutchToSpanishPhoneticService.
--   Ademas rellena pronunciation de las palabras madre SOLO si esta vacia.
--   100% aditiva e idempotente: solo INSERT (NOT EXISTS / OR IGNORE) y UPDATE de
--   pronunciation vacia. No borra ni modifica notes, audio_path ni imagenes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- ben je weleens geweest?  (¿has estado alguna vez?)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'ben ye uelens jeuest?', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿has estado alguna vez?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Has estado alguna vez en Ámsterdam?', 'SENTENCE', 'Ejemplo de "ben je weleens geweest?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Has estado alguna vez en Ámsterdam?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has estado alguna vez en Ámsterdam?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)' LIMIT 1),
    'nl_NL', 'Ben je weleens in Amsterdam geweest?', 'Ben ye uelens in Amsterdam jeuest?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has estado alguna vez en Ámsterdam?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has estado alguna vez en Ámsterdam?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿has estado alguna vez?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Has estado alguna vez en Ámsterdam?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Has probado alguna vez el arenque?', 'SENTENCE', 'Ejemplo de "ben je weleens geweest?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Has probado alguna vez el arenque?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has probado alguna vez el arenque?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)' LIMIT 1),
    'nl_NL', 'Heb je weleens haring geprobeerd?', 'Eb ye uelens arinj jeproberd?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has probado alguna vez el arenque?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has probado alguna vez el arenque?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿has estado alguna vez?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Has probado alguna vez el arenque?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Has dormido alguna vez en un barco?', 'SENTENCE', 'Ejemplo de "ben je weleens geweest?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Has dormido alguna vez en un barco?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has dormido alguna vez en un barco?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)' LIMIT 1),
    'nl_NL', 'Heb je weleens op een boot geslapen?', 'Eb ye uelens op en bot jeslapen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has dormido alguna vez en un barco?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has dormido alguna vez en un barco?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿has estado alguna vez?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Has dormido alguna vez en un barco?' AND notes = 'Ejemplo de "ben je weleens geweest?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'He estado alguna vez.', 'SENTENCE', 'Ejemplo de "ben je weleens geweest?" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'He estado alguna vez.' AND notes = 'Ejemplo de "ben je weleens geweest?" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'He estado alguna vez.' AND notes = 'Ejemplo de "ben je weleens geweest?" (can.)' LIMIT 1),
    'nl_NL', 'Ik ben er weleens geweest.', 'Ik ben er uelens jeuest.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He estado alguna vez.' AND notes = 'Ejemplo de "ben je weleens geweest?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He estado alguna vez.' AND notes = 'Ejemplo de "ben je weleens geweest?" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿has estado alguna vez?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'He estado alguna vez.' AND notes = 'Ejemplo de "ben je weleens geweest?" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Preguntó si había estado alguna vez en España.', 'SENTENCE', 'Ejemplo de "ben je weleens geweest?" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Preguntó si había estado alguna vez en España.' AND notes = 'Ejemplo de "ben je weleens geweest?" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Preguntó si había estado alguna vez en España.' AND notes = 'Ejemplo de "ben je weleens geweest?" (bijzin)' LIMIT 1),
    'nl_NL', 'Ze vroeg of ik weleens in Spanje was geweest.', 'Se fruj of ik uelens in Spanye uas jeuest.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Preguntó si había estado alguna vez en España.' AND notes = 'Ejemplo de "ben je weleens geweest?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Preguntó si había estado alguna vez en España.' AND notes = 'Ejemplo de "ben je weleens geweest?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿has estado alguna vez?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Preguntó si había estado alguna vez en España.' AND notes = 'Ejemplo de "ben je weleens geweest?" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- dat gebeurt weleens  (eso pasa a veces)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'dat jebert uelens', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'eso pasa a veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'A todo el mundo se le olvida algo alguna vez.', 'SENTENCE', 'Ejemplo de "dat gebeurt weleens" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'A todo el mundo se le olvida algo alguna vez.' AND notes = 'Ejemplo de "dat gebeurt weleens" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'A todo el mundo se le olvida algo alguna vez.' AND notes = 'Ejemplo de "dat gebeurt weleens" (can.)' LIMIT 1),
    'nl_NL', 'Iedereen vergeet weleens iets.', 'Ideren ferjet uelens its.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A todo el mundo se le olvida algo alguna vez.' AND notes = 'Ejemplo de "dat gebeurt weleens" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A todo el mundo se le olvida algo alguna vez.' AND notes = 'Ejemplo de "dat gebeurt weleens" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'eso pasa a veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'A todo el mundo se le olvida algo alguna vez.' AND notes = 'Ejemplo de "dat gebeurt weleens" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Voy alguna que otra vez a la sauna.', 'SENTENCE', 'Ejemplo de "dat gebeurt weleens" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Voy alguna que otra vez a la sauna.' AND notes = 'Ejemplo de "dat gebeurt weleens" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy alguna que otra vez a la sauna.' AND notes = 'Ejemplo de "dat gebeurt weleens" (can.)' LIMIT 1),
    'nl_NL', 'Ik ga weleens naar de sauna.', 'Ik ja uelens nar de sauna.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy alguna que otra vez a la sauna.' AND notes = 'Ejemplo de "dat gebeurt weleens" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy alguna que otra vez a la sauna.' AND notes = 'Ejemplo de "dat gebeurt weleens" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'eso pasa a veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Voy alguna que otra vez a la sauna.' AND notes = 'Ejemplo de "dat gebeurt weleens" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Tú cometes errores alguna vez?', 'SENTENCE', 'Ejemplo de "dat gebeurt weleens" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Tú cometes errores alguna vez?' AND notes = 'Ejemplo de "dat gebeurt weleens" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tú cometes errores alguna vez?' AND notes = 'Ejemplo de "dat gebeurt weleens" (vraag)' LIMIT 1),
    'nl_NL', 'Maak jij weleens een fout?', 'Mak yei uelens en faut?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tú cometes errores alguna vez?' AND notes = 'Ejemplo de "dat gebeurt weleens" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tú cometes errores alguna vez?' AND notes = 'Ejemplo de "dat gebeurt weleens" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'eso pasa a veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Tú cometes errores alguna vez?' AND notes = 'Ejemplo de "dat gebeurt weleens" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¡Pásate algún día!', 'SENTENCE', 'Ejemplo de "dat gebeurt weleens" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡Pásate algún día!' AND notes = 'Ejemplo de "dat gebeurt weleens" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡Pásate algún día!' AND notes = 'Ejemplo de "dat gebeurt weleens" (uitdr.)' LIMIT 1),
    'nl_NL', 'Kom nog weleens langs!', 'Kom noj uelens lanjs!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Pásate algún día!' AND notes = 'Ejemplo de "dat gebeurt weleens" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Pásate algún día!' AND notes = 'Ejemplo de "dat gebeurt weleens" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'eso pasa a veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¡Pásate algún día!' AND notes = 'Ejemplo de "dat gebeurt weleens" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- soms  (a veces)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'soms', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'a veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'A veces trabajo desde casa.', 'SENTENCE', 'Ejemplo de "soms" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'A veces trabajo desde casa.' AND notes = 'Ejemplo de "soms" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'A veces trabajo desde casa.' AND notes = 'Ejemplo de "soms" (can.)' LIMIT 1),
    'nl_NL', 'Ik werk soms thuis.', 'Ik uerk soms taus.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A veces trabajo desde casa.' AND notes = 'Ejemplo de "soms" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A veces trabajo desde casa.' AND notes = 'Ejemplo de "soms" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'a veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'A veces trabajo desde casa.' AND notes = 'Ejemplo de "soms" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'A veces aquí llueve todo el día.', 'SENTENCE', 'Ejemplo de "soms" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'A veces aquí llueve todo el día.' AND notes = 'Ejemplo de "soms" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'A veces aquí llueve todo el día.' AND notes = 'Ejemplo de "soms" (inv.)' LIMIT 1),
    'nl_NL', 'Soms regent het hier de hele dag.', 'Soms rejent et ir de ele daj.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A veces aquí llueve todo el día.' AND notes = 'Ejemplo de "soms" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A veces aquí llueve todo el día.' AND notes = 'Ejemplo de "soms" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'a veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'A veces aquí llueve todo el día.' AND notes = 'Ejemplo de "soms" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'A veces sí, a veces no.', 'SENTENCE', 'Ejemplo de "soms" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'A veces sí, a veces no.' AND notes = 'Ejemplo de "soms" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'A veces sí, a veces no.' AND notes = 'Ejemplo de "soms" (uitdr.)' LIMIT 1),
    'nl_NL', 'Soms wel, soms niet.', 'Soms uel, soms nit.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A veces sí, a veces no.' AND notes = 'Ejemplo de "soms" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A veces sí, a veces no.' AND notes = 'Ejemplo de "soms" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'a veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'A veces sí, a veces no.' AND notes = 'Ejemplo de "soms" (uitdr.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Comes carne a veces?', 'SENTENCE', 'Ejemplo de "soms" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Comes carne a veces?' AND notes = 'Ejemplo de "soms" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Comes carne a veces?' AND notes = 'Ejemplo de "soms" (vraag)' LIMIT 1),
    'nl_NL', 'Eet je soms vlees?', 'Et ye soms fles?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Comes carne a veces?' AND notes = 'Ejemplo de "soms" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Comes carne a veces?' AND notes = 'Ejemplo de "soms" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'a veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Comes carne a veces?' AND notes = 'Ejemplo de "soms" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Creo que a veces se siente solo.', 'SENTENCE', 'Ejemplo de "soms" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Creo que a veces se siente solo.' AND notes = 'Ejemplo de "soms" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Creo que a veces se siente solo.' AND notes = 'Ejemplo de "soms" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik denk dat hij soms eenzaam is.', 'Ik denk dat ei soms ensam is.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Creo que a veces se siente solo.' AND notes = 'Ejemplo de "soms" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Creo que a veces se siente solo.' AND notes = 'Ejemplo de "soms" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'a veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Creo que a veces se siente solo.' AND notes = 'Ejemplo de "soms" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- heb je soms...?  (¿por casualidad...?)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'eb ye soms...?', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿por casualidad...?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Has visto por casualidad mis llaves?', 'SENTENCE', 'Ejemplo de "heb je soms...?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Has visto por casualidad mis llaves?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has visto por casualidad mis llaves?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    'nl_NL', 'Heb je soms mijn sleutels gezien?', 'Eb ye soms mein sletels jesin?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has visto por casualidad mis llaves?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has visto por casualidad mis llaves?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿por casualidad...?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Has visto por casualidad mis llaves?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Sabes por casualidad qué hora es?', 'SENTENCE', 'Ejemplo de "heb je soms...?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Sabes por casualidad qué hora es?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Sabes por casualidad qué hora es?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    'nl_NL', 'Weet jij soms hoe laat het is?', 'Uet yei soms u lat et is?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Sabes por casualidad qué hora es?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Sabes por casualidad qué hora es?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿por casualidad...?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Sabes por casualidad qué hora es?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Llevas por casualidad un cargador?', 'SENTENCE', 'Ejemplo de "heb je soms...?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Llevas por casualidad un cargador?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Llevas por casualidad un cargador?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    'nl_NL', 'Heb je soms een oplader bij je?', 'Eb ye soms en oplader bei ye?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Llevas por casualidad un cargador?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Llevas por casualidad un cargador?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿por casualidad...?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Llevas por casualidad un cargador?' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Acaso estás enfadado? (con retintín)', 'SENTENCE', 'Ejemplo de "heb je soms...?" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Acaso estás enfadado? (con retintín)' AND notes = 'Ejemplo de "heb je soms...?" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Acaso estás enfadado? (con retintín)' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    'nl_NL', 'Ben je soms boos?', 'Ben ye soms bos?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Acaso estás enfadado? (con retintín)' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Acaso estás enfadado? (con retintín)' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿por casualidad...?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Acaso estás enfadado? (con retintín)' AND notes = 'Ejemplo de "heb je soms...?" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Pregunta si por casualidad tiene un boli.', 'SENTENCE', 'Ejemplo de "heb je soms...?" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Pregunta si por casualidad tiene un boli.' AND notes = 'Ejemplo de "heb je soms...?" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Pregunta si por casualidad tiene un boli.' AND notes = 'Ejemplo de "heb je soms...?" (bijzin)' LIMIT 1),
    'nl_NL', 'Vraag even of hij soms een pen heeft.', 'Fraj efen of ei soms en pen eft.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Pregunta si por casualidad tiene un boli.' AND notes = 'Ejemplo de "heb je soms...?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Pregunta si por casualidad tiene un boli.' AND notes = 'Ejemplo de "heb je soms...?" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = '¿por casualidad...?'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Pregunta si por casualidad tiene un boli.' AND notes = 'Ejemplo de "heb je soms...?" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- ooit  (algún día)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'oit', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'algún día'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Algún día iré a Japón.', 'SENTENCE', 'Ejemplo de "ooit" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Algún día iré a Japón.' AND notes = 'Ejemplo de "ooit" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Algún día iré a Japón.' AND notes = 'Ejemplo de "ooit" (inv.)' LIMIT 1),
    'nl_NL', 'Ooit ga ik naar Japan.', 'Oit ja ik nar Yapan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Algún día iré a Japón.' AND notes = 'Ejemplo de "ooit" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Algún día iré a Japón.' AND notes = 'Ejemplo de "ooit" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'algún día'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Algún día iré a Japón.' AND notes = 'Ejemplo de "ooit" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Algún día llegará el día en que todo salga.', 'SENTENCE', 'Ejemplo de "ooit" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Algún día llegará el día en que todo salga.' AND notes = 'Ejemplo de "ooit" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Algún día llegará el día en que todo salga.' AND notes = 'Ejemplo de "ooit" (inv.)' LIMIT 1),
    'nl_NL', 'Ooit komt de dag dat alles lukt.', 'Oit komt de daj dat alles lukt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Algún día llegará el día en que todo salga.' AND notes = 'Ejemplo de "ooit" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Algún día llegará el día en que todo salga.' AND notes = 'Ejemplo de "ooit" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'algún día'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Algún día llegará el día en que todo salga.' AND notes = 'Ejemplo de "ooit" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Has estado enamorado alguna vez?', 'SENTENCE', 'Ejemplo de "ooit" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Has estado enamorado alguna vez?' AND notes = 'Ejemplo de "ooit" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has estado enamorado alguna vez?' AND notes = 'Ejemplo de "ooit" (vraag)' LIMIT 1),
    'nl_NL', 'Ben je ooit verliefd geweest?', 'Ben ye oit ferlifd jeuest?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has estado enamorado alguna vez?' AND notes = 'Ejemplo de "ooit" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has estado enamorado alguna vez?' AND notes = 'Ejemplo de "ooit" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'algún día'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Has estado enamorado alguna vez?' AND notes = 'Ejemplo de "ooit" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Viví en Utrecht en su día.', 'SENTENCE', 'Ejemplo de "ooit" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Viví en Utrecht en su día.' AND notes = 'Ejemplo de "ooit" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Viví en Utrecht en su día.' AND notes = 'Ejemplo de "ooit" (can.)' LIMIT 1),
    'nl_NL', 'Ik heb ooit in Utrecht gewoond.', 'Ik eb oit in Utrejt jeuond.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Viví en Utrecht en su día.' AND notes = 'Ejemplo de "ooit" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Viví en Utrecht en su día.' AND notes = 'Ejemplo de "ooit" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'algún día'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Viví en Utrecht en su día.' AND notes = 'Ejemplo de "ooit" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Espera poder comprarse una casa algún día.', 'SENTENCE', 'Ejemplo de "ooit" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Espera poder comprarse una casa algún día.' AND notes = 'Ejemplo de "ooit" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Espera poder comprarse una casa algún día.' AND notes = 'Ejemplo de "ooit" (bijzin)' LIMIT 1),
    'nl_NL', 'Hij hoopt dat hij ooit een huis kan kopen.', 'Ei opt dat ei oit en aus kan kopen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Espera poder comprarse una casa algún día.' AND notes = 'Ejemplo de "ooit" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Espera poder comprarse una casa algún día.' AND notes = 'Ejemplo de "ooit" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'algún día'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Espera poder comprarse una casa algún día.' AND notes = 'Ejemplo de "ooit" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- een paar keer  (algunas veces)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'en par ker', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'algunas veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'He estado allí algunas veces.', 'SENTENCE', 'Ejemplo de "een paar keer" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'He estado allí algunas veces.' AND notes = 'Ejemplo de "een paar keer" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'He estado allí algunas veces.' AND notes = 'Ejemplo de "een paar keer" (can.)' LIMIT 1),
    'nl_NL', 'Ik ben er een paar keer geweest.', 'Ik ben er en par ker jeuest.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He estado allí algunas veces.' AND notes = 'Ejemplo de "een paar keer" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He estado allí algunas veces.' AND notes = 'Ejemplo de "een paar keer" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'algunas veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'He estado allí algunas veces.' AND notes = 'Ejemplo de "een paar keer" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Lo he intentado unas cuantas veces.', 'SENTENCE', 'Ejemplo de "een paar keer" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Lo he intentado unas cuantas veces.' AND notes = 'Ejemplo de "een paar keer" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo he intentado unas cuantas veces.' AND notes = 'Ejemplo de "een paar keer" (can.)' LIMIT 1),
    'nl_NL', 'Ik heb het een paar keer geprobeerd.', 'Ik eb et en par ker jeproberd.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo he intentado unas cuantas veces.' AND notes = 'Ejemplo de "een paar keer" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo he intentado unas cuantas veces.' AND notes = 'Ejemplo de "een paar keer" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'algunas veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Lo he intentado unas cuantas veces.' AND notes = 'Ejemplo de "een paar keer" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Unas cuantas veces por semana hago deporte.', 'SENTENCE', 'Ejemplo de "een paar keer" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Unas cuantas veces por semana hago deporte.' AND notes = 'Ejemplo de "een paar keer" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Unas cuantas veces por semana hago deporte.' AND notes = 'Ejemplo de "een paar keer" (inv.)' LIMIT 1),
    'nl_NL', 'Een paar keer per week sport ik.', 'En par ker per uek sport ik.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Unas cuantas veces por semana hago deporte.' AND notes = 'Ejemplo de "een paar keer" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Unas cuantas veces por semana hago deporte.' AND notes = 'Ejemplo de "een paar keer" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'algunas veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Unas cuantas veces por semana hago deporte.' AND notes = 'Ejemplo de "een paar keer" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Cuántas veces? Solo unas pocas.', 'SENTENCE', 'Ejemplo de "een paar keer" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Cuántas veces? Solo unas pocas.' AND notes = 'Ejemplo de "een paar keer" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cuántas veces? Solo unas pocas.' AND notes = 'Ejemplo de "een paar keer" (vraag)' LIMIT 1),
    'nl_NL', 'Hoe vaak? Een paar keer maar.', 'U fak? En par ker mar.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cuántas veces? Solo unas pocas.' AND notes = 'Ejemplo de "een paar keer" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Cuántas veces? Solo unas pocas.' AND notes = 'Ejemplo de "een paar keer" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'algunas veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Cuántas veces? Solo unas pocas.' AND notes = 'Ejemplo de "een paar keer" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Lo sé porque lo he visto varias veces.', 'SENTENCE', 'Ejemplo de "een paar keer" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Lo sé porque lo he visto varias veces.' AND notes = 'Ejemplo de "een paar keer" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo sé porque lo he visto varias veces.' AND notes = 'Ejemplo de "een paar keer" (bijzin)' LIMIT 1),
    'nl_NL', 'Ik weet het, omdat ik het een paar keer heb gezien.', 'Ik uet et, omdat ik et en par ker eb jesin.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo sé porque lo he visto varias veces.' AND notes = 'Ejemplo de "een paar keer" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo sé porque lo he visto varias veces.' AND notes = 'Ejemplo de "een paar keer" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'algunas veces'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Lo sé porque lo he visto varias veces.' AND notes = 'Ejemplo de "een paar keer" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- een enkele keer  (alguna que otra vez)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'en enkele ker', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'alguna que otra vez'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Como carne alguna que otra vez.', 'SENTENCE', 'Ejemplo de "een enkele keer" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Como carne alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Como carne alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (can.)' LIMIT 1),
    'nl_NL', 'Ik eet een enkele keer vlees.', 'Ik et en enkele ker fles.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Como carne alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Como carne alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'alguna que otra vez'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Como carne alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Salimos a cenar alguna que otra vez.', 'SENTENCE', 'Ejemplo de "een enkele keer" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Salimos a cenar alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Salimos a cenar alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (can.)' LIMIT 1),
    'nl_NL', 'We gaan een enkele keer uit eten.', 'Ue jan en enkele ker aut eten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Salimos a cenar alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Salimos a cenar alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'alguna que otra vez'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Salimos a cenar alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Solo muy rara vez llega tarde.', 'SENTENCE', 'Ejemplo de "een enkele keer" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Solo muy rara vez llega tarde.' AND notes = 'Ejemplo de "een enkele keer" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Solo muy rara vez llega tarde.' AND notes = 'Ejemplo de "een enkele keer" (inv.)' LIMIT 1),
    'nl_NL', 'Slechts een enkele keer komt hij te laat.', 'Slejts en enkele ker komt ei te lat.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Solo muy rara vez llega tarde.' AND notes = 'Ejemplo de "een enkele keer" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Solo muy rara vez llega tarde.' AND notes = 'Ejemplo de "een enkele keer" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'alguna que otra vez'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Solo muy rara vez llega tarde.' AND notes = 'Ejemplo de "een enkele keer" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Sigues fumando? Alguna que otra vez.', 'SENTENCE', 'Ejemplo de "een enkele keer" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Sigues fumando? Alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Sigues fumando? Alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (vraag)' LIMIT 1),
    'nl_NL', 'Rook je nog? Een enkele keer.', 'Rok ye noj? En enkele ker.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Sigues fumando? Alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Sigues fumando? Alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'alguna que otra vez'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Sigues fumando? Alguna que otra vez.' AND notes = 'Ejemplo de "een enkele keer" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Solo muy de vez en cuando nieva aquí.', 'SENTENCE', 'Ejemplo de "een enkele keer" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Solo muy de vez en cuando nieva aquí.' AND notes = 'Ejemplo de "een enkele keer" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Solo muy de vez en cuando nieva aquí.' AND notes = 'Ejemplo de "een enkele keer" (bijzin)' LIMIT 1),
    'nl_NL', 'Het gebeurt maar een enkele keer dat het hier sneeuwt.', 'Et jebert mar en enkele ker dat et ir sneuut.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Solo muy de vez en cuando nieva aquí.' AND notes = 'Ejemplo de "een enkele keer" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Solo muy de vez en cuando nieva aquí.' AND notes = 'Ejemplo de "een enkele keer" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'alguna que otra vez'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Solo muy de vez en cuando nieva aquí.' AND notes = 'Ejemplo de "een enkele keer" (bijzin)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- af en toe  (de vez en cuando)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'af en tu', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'de vez en cuando'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me tomo una cerveza de vez en cuando.', 'SENTENCE', 'Ejemplo de "af en toe" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Me tomo una cerveza de vez en cuando.' AND notes = 'Ejemplo de "af en toe" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me tomo una cerveza de vez en cuando.' AND notes = 'Ejemplo de "af en toe" (can.)' LIMIT 1),
    'nl_NL', 'Ik drink af en toe een biertje.', 'Ik drink af en tu en birtye.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me tomo una cerveza de vez en cuando.' AND notes = 'Ejemplo de "af en toe" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me tomo una cerveza de vez en cuando.' AND notes = 'Ejemplo de "af en toe" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'de vez en cuando'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me tomo una cerveza de vez en cuando.' AND notes = 'Ejemplo de "af en toe" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'De vez en cuando llamo a mi abuela.', 'SENTENCE', 'Ejemplo de "af en toe" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'De vez en cuando llamo a mi abuela.' AND notes = 'Ejemplo de "af en toe" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'De vez en cuando llamo a mi abuela.' AND notes = 'Ejemplo de "af en toe" (inv.)' LIMIT 1),
    'nl_NL', 'Af en toe bel ik mijn oma.', 'Af en tu bel ik mein oma.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'De vez en cuando llamo a mi abuela.' AND notes = 'Ejemplo de "af en toe" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'De vez en cuando llamo a mi abuela.' AND notes = 'Ejemplo de "af en toe" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'de vez en cuando'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'De vez en cuando llamo a mi abuela.' AND notes = 'Ejemplo de "af en toe" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Nos vemos de vez en cuando.', 'SENTENCE', 'Ejemplo de "af en toe" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Nos vemos de vez en cuando.' AND notes = 'Ejemplo de "af en toe" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Nos vemos de vez en cuando.' AND notes = 'Ejemplo de "af en toe" (can.)' LIMIT 1),
    'nl_NL', 'We zien elkaar af en toe.', 'Ue sin elkar af en tu.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Nos vemos de vez en cuando.' AND notes = 'Ejemplo de "af en toe" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Nos vemos de vez en cuando.' AND notes = 'Ejemplo de "af en toe" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'de vez en cuando'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Nos vemos de vez en cuando.' AND notes = 'Ejemplo de "af en toe" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Haces deporte de vez en cuando?', 'SENTENCE', 'Ejemplo de "af en toe" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Haces deporte de vez en cuando?' AND notes = 'Ejemplo de "af en toe" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Haces deporte de vez en cuando?' AND notes = 'Ejemplo de "af en toe" (vraag)' LIMIT 1),
    'nl_NL', 'Sport je af en toe?', 'Sport ye af en tu?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Haces deporte de vez en cuando?' AND notes = 'Ejemplo de "af en toe" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Haces deporte de vez en cuando?' AND notes = 'Ejemplo de "af en toe" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'de vez en cuando'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Haces deporte de vez en cuando?' AND notes = 'Ejemplo de "af en toe" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'De tanto en tanto echo una siesta ("zo nu en dan" = af en toe).', 'SENTENCE', 'Ejemplo de "af en toe" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'De tanto en tanto echo una siesta ("zo nu en dan" = af en toe).' AND notes = 'Ejemplo de "af en toe" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'De tanto en tanto echo una siesta ("zo nu en dan" = af en toe).' AND notes = 'Ejemplo de "af en toe" (uitdr.)' LIMIT 1),
    'nl_NL', 'Zo nu en dan doe ik een dutje.', 'So nu en dan du ik en dutye.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'De tanto en tanto echo una siesta ("zo nu en dan" = af en toe).' AND notes = 'Ejemplo de "af en toe" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'De tanto en tanto echo una siesta ("zo nu en dan" = af en toe).' AND notes = 'Ejemplo de "af en toe" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'de vez en cuando'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'De tanto en tanto echo una siesta ("zo nu en dan" = af en toe).' AND notes = 'Ejemplo de "af en toe" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- nog een keer  (otra vez, una vez más)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'noj en ker', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'otra vez, una vez más'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Lo hago otra vez.', 'SENTENCE', 'Ejemplo de "nog een keer" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Lo hago otra vez.' AND notes = 'Ejemplo de "nog een keer" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo hago otra vez.' AND notes = 'Ejemplo de "nog een keer" (can.)' LIMIT 1),
    'nl_NL', 'Ik doe het nog een keer.', 'Ik du et noj en ker.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo hago otra vez.' AND notes = 'Ejemplo de "nog een keer" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo hago otra vez.' AND notes = 'Ejemplo de "nog een keer" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'otra vez, una vez más'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Lo hago otra vez.' AND notes = 'Ejemplo de "nog een keer" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¡Dilo otra vez!', 'SENTENCE', 'Ejemplo de "nog een keer" (geb.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡Dilo otra vez!' AND notes = 'Ejemplo de "nog een keer" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡Dilo otra vez!' AND notes = 'Ejemplo de "nog een keer" (geb.)' LIMIT 1),
    'nl_NL', 'Zeg het nog een keer!', 'Sej et noj en ker!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Dilo otra vez!' AND notes = 'Ejemplo de "nog een keer" (geb.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Dilo otra vez!' AND notes = 'Ejemplo de "nog een keer" (geb.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'otra vez, una vez más'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¡Dilo otra vez!' AND notes = 'Ejemplo de "nog een keer" (geb.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Lo intentamos una vez más?', 'SENTENCE', 'Ejemplo de "nog een keer" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Lo intentamos una vez más?' AND notes = 'Ejemplo de "nog een keer" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Lo intentamos una vez más?' AND notes = 'Ejemplo de "nog een keer" (vraag)' LIMIT 1),
    'nl_NL', 'Zullen we het nog een keer proberen?', 'Sullen ue et noj en ker proberen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Lo intentamos una vez más?' AND notes = 'Ejemplo de "nog een keer" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Lo intentamos una vez más?' AND notes = 'Ejemplo de "nog een keer" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'otra vez, una vez más'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Lo intentamos una vez más?' AND notes = 'Ejemplo de "nog een keer" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Esa peli quiero verla otra vez.', 'SENTENCE', 'Ejemplo de "nog een keer" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Esa peli quiero verla otra vez.' AND notes = 'Ejemplo de "nog een keer" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Esa peli quiero verla otra vez.' AND notes = 'Ejemplo de "nog een keer" (inv.)' LIMIT 1),
    'nl_NL', 'Die film wil ik nog een keer zien.', 'Di film uil ik noj en ker sin.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esa peli quiero verla otra vez.' AND notes = 'Ejemplo de "nog een keer" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esa peli quiero verla otra vez.' AND notes = 'Ejemplo de "nog een keer" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'otra vez, una vez más'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Esa peli quiero verla otra vez.' AND notes = 'Ejemplo de "nog een keer" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Una última vez y paramos.', 'SENTENCE', 'Ejemplo de "nog een keer" (uitdr.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Una última vez y paramos.' AND notes = 'Ejemplo de "nog een keer" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Una última vez y paramos.' AND notes = 'Ejemplo de "nog een keer" (uitdr.)' LIMIT 1),
    'nl_NL', 'Nog één keer en dan stoppen we.', 'Noj één ker en dan stoppen ue.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Una última vez y paramos.' AND notes = 'Ejemplo de "nog een keer" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Una última vez y paramos.' AND notes = 'Ejemplo de "nog een keer" (uitdr.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'otra vez, una vez más'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Una última vez y paramos.' AND notes = 'Ejemplo de "nog een keer" (uitdr.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- het enige  (lo único)
-- ==============================================================================
UPDATE words_lang SET pronunciation = 'et enije', updated_at = datetime('now')
WHERE lang_code = 'nl_NL'
AND (pronunciation IS NULL OR pronunciation = '')
AND word_es_id = (SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo único'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1);

INSERT INTO words_es (text, word_type, notes)
SELECT 'Lo único que quiero es tranquilidad.', 'SENTENCE', 'Ejemplo de "het enige" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Lo único que quiero es tranquilidad.' AND notes = 'Ejemplo de "het enige" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo único que quiero es tranquilidad.' AND notes = 'Ejemplo de "het enige" (can.)' LIMIT 1),
    'nl_NL', 'Het enige wat ik wil, is rust.', 'Et enije uat ik uil, is rust.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo único que quiero es tranquilidad.' AND notes = 'Ejemplo de "het enige" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo único que quiero es tranquilidad.' AND notes = 'Ejemplo de "het enige" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo único'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Lo único que quiero es tranquilidad.' AND notes = 'Ejemplo de "het enige" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Es el único que lo sabe.', 'SENTENCE', 'Ejemplo de "het enige" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Es el único que lo sabe.' AND notes = 'Ejemplo de "het enige" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Es el único que lo sabe.' AND notes = 'Ejemplo de "het enige" (can.)' LIMIT 1),
    'nl_NL', 'Hij is de enige die het weet.', 'Ei is de enije di et uet.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Es el único que lo sabe.' AND notes = 'Ejemplo de "het enige" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Es el único que lo sabe.' AND notes = 'Ejemplo de "het enige" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo único'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Es el único que lo sabe.' AND notes = 'Ejemplo de "het enige" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Este es el único ejemplar.', 'SENTENCE', 'Ejemplo de "het enige" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Este es el único ejemplar.' AND notes = 'Ejemplo de "het enige" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Este es el único ejemplar.' AND notes = 'Ejemplo de "het enige" (can.)' LIMIT 1),
    'nl_NL', 'Dit is het enige exemplaar.', 'Dit is et enije exemplar.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Este es el único ejemplar.' AND notes = 'Ejemplo de "het enige" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Este es el único ejemplar.' AND notes = 'Ejemplo de "het enige" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo único'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Este es el único ejemplar.' AND notes = 'Ejemplo de "het enige" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Soy el único al que esto le parece raro?', 'SENTENCE', 'Ejemplo de "het enige" (vraag)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿Soy el único al que esto le parece raro?' AND notes = 'Ejemplo de "het enige" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Soy el único al que esto le parece raro?' AND notes = 'Ejemplo de "het enige" (vraag)' LIMIT 1),
    'nl_NL', 'Ben ik de enige die dit raar vindt?', 'Ben ik de enije di dit rar findt?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Soy el único al que esto le parece raro?' AND notes = 'Ejemplo de "het enige" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Soy el único al que esto le parece raro?' AND notes = 'Ejemplo de "het enige" (vraag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo único'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Soy el único al que esto le parece raro?' AND notes = 'Ejemplo de "het enige" (vraag)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Lo único que tienes que hacer es llamar.', 'SENTENCE', 'Ejemplo de "het enige" (bijzin)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'Lo único que tienes que hacer es llamar.' AND notes = 'Ejemplo de "het enige" (bijzin)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo único que tienes que hacer es llamar.' AND notes = 'Ejemplo de "het enige" (bijzin)' LIMIT 1),
    'nl_NL', 'Het enige wat je hoeft te doen, is bellen.', 'Et enije uat ye uft te dun, is bellen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo único que tienes que hacer es llamar.' AND notes = 'Ejemplo de "het enige" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo único que tienes que hacer es llamar.' AND notes = 'Ejemplo de "het enige" (bijzin)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'lo único'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Lo único que tienes que hacer es llamar.' AND notes = 'Ejemplo de "het enige" (bijzin)' LIMIT 1),
    'EXAMPLE');
