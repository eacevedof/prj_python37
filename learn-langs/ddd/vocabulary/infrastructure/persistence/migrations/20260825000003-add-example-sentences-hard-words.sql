-- Learn Languages App - Frases de ejemplo del grupo "palabras dificiles - moeilijke woorden"
-- Migration: 20260825000003-add-example-sentences-hard-words.sql
-- Description: Anade 2 frases de ejemplo por palabra del grupo 28 como tarjetas SENTENCE
--   entrenables, tomadas de los ejemplos ya existentes en words_lang.notes (alternando
--   pronombre y tiempo verbal entre las dos), asociadas al grupo y a "generic", enlazadas
--   a su palabra madre via word_es_relations (relation_type EXAMPLE).
--   100% aditiva e idempotente: solo INSERT (NOT EXISTS / OR IGNORE). No borra ni modifica
--   notes, audio_path ni imagenes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- zodra
-- ==============================================================================

INSERT INTO words_es (text, word_type, notes)
SELECT 'En cuanto llegue a casa, te llamo.', 'SENTENCE', 'Ejemplo de "zodra" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'En cuanto llegue a casa, te llamo.' AND notes = 'Ejemplo de "zodra" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'En cuanto llegue a casa, te llamo.' AND notes = 'Ejemplo de "zodra" (inv.)' LIMIT 1),
    'nl_NL', 'Zodra ik thuis ben, bel ik je.', 'Sodra ik teuis ben, bel ik ye.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En cuanto llegue a casa, te llamo.' AND notes = 'Ejemplo de "zodra" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En cuanto llegue a casa, te llamo.' AND notes = 'Ejemplo de "zodra" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'en cuanto, tan pronto como'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'En cuanto llegue a casa, te llamo.' AND notes = 'Ejemplo de "zodra" (inv.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'En cuanto terminó, salió.', 'SENTENCE', 'Ejemplo de "zodra" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'En cuanto terminó, salió.' AND notes = 'Ejemplo de "zodra" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'En cuanto terminó, salió.' AND notes = 'Ejemplo de "zodra" (inv.)' LIMIT 1),
    'nl_NL', 'Zodra hij klaar was, ging hij naar buiten.', 'Sodra ei klar uas, jinj ei nar beuiten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En cuanto terminó, salió.' AND notes = 'Ejemplo de "zodra" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En cuanto terminó, salió.' AND notes = 'Ejemplo de "zodra" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'en cuanto, tan pronto como'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'En cuanto terminó, salió.' AND notes = 'Ejemplo de "zodra" (inv.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- tenslotte
-- ==============================================================================

INSERT INTO words_es (text, word_type, notes)
SELECT 'Al fin y al cabo no es más que un niño.', 'SENTENCE', 'Ejemplo de "tenslotte" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Al fin y al cabo no es más que un niño.' AND notes = 'Ejemplo de "tenslotte" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Al fin y al cabo no es más que un niño.' AND notes = 'Ejemplo de "tenslotte" (can.)' LIMIT 1),
    'nl_NL', 'Hij is tenslotte nog maar een kind.', 'Ei is tenslotte noj mar en kint.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Al fin y al cabo no es más que un niño.' AND notes = 'Ejemplo de "tenslotte" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Al fin y al cabo no es más que un niño.' AND notes = 'Ejemplo de "tenslotte" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'al fin y al cabo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Al fin y al cabo no es más que un niño.' AND notes = 'Ejemplo de "tenslotte" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Al fin y al cabo fue idea tuya, no mía.', 'SENTENCE', 'Ejemplo de "tenslotte" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Al fin y al cabo fue idea tuya, no mía.' AND notes = 'Ejemplo de "tenslotte" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Al fin y al cabo fue idea tuya, no mía.' AND notes = 'Ejemplo de "tenslotte" (inv.)' LIMIT 1),
    'nl_NL', 'Tenslotte was het jouw idee, niet het mijne.', 'Tenslotte uas et yau ide, nit et meine.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Al fin y al cabo fue idea tuya, no mía.' AND notes = 'Ejemplo de "tenslotte" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Al fin y al cabo fue idea tuya, no mía.' AND notes = 'Ejemplo de "tenslotte" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'al fin y al cabo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Al fin y al cabo fue idea tuya, no mía.' AND notes = 'Ejemplo de "tenslotte" (inv.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- tenzij
-- ==============================================================================

INSERT INTO words_es (text, word_type, notes)
SELECT 'Voy mañana, a menos que llueva.', 'SENTENCE', 'Ejemplo de "tenzij" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Voy mañana, a menos que llueva.' AND notes = 'Ejemplo de "tenzij" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy mañana, a menos que llueva.' AND notes = 'Ejemplo de "tenzij" (can.)' LIMIT 1),
    'nl_NL', 'Ik kom morgen, tenzij het regent.', 'Ik kom morjen, tensei et rejent.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy mañana, a menos que llueva.' AND notes = 'Ejemplo de "tenzij" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy mañana, a menos que llueva.' AND notes = 'Ejemplo de "tenzij" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'a menos que'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Voy mañana, a menos que llueva.' AND notes = 'Ejemplo de "tenzij" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Antes no salía nunca, a menos que hiciera sol.', 'SENTENCE', 'Ejemplo de "tenzij" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Antes no salía nunca, a menos que hiciera sol.' AND notes = 'Ejemplo de "tenzij" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Antes no salía nunca, a menos que hiciera sol.' AND notes = 'Ejemplo de "tenzij" (can.)' LIMIT 1),
    'nl_NL', 'Vroeger ging ze nooit naar buiten, tenzij de zon scheen.', 'Frujer jinj se noit nar beuiten, tensei de son sjen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Antes no salía nunca, a menos que hiciera sol.' AND notes = 'Ejemplo de "tenzij" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Antes no salía nunca, a menos que hiciera sol.' AND notes = 'Ejemplo de "tenzij" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'a menos que'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Antes no salía nunca, a menos que hiciera sol.' AND notes = 'Ejemplo de "tenzij" (can.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- uitzetten
-- ==============================================================================

INSERT INTO words_es (text, word_type, notes)
SELECT 'He apagado la calefacción, hace calor.', 'SENTENCE', 'Ejemplo de "uitzetten" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'He apagado la calefacción, hace calor.' AND notes = 'Ejemplo de "uitzetten" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'He apagado la calefacción, hace calor.' AND notes = 'Ejemplo de "uitzetten" (perf.)' LIMIT 1),
    'nl_NL', 'Ik heb de verwarming uitgezet, want het is warm.', 'Ik ep de ferwarminj eutjeset, uant et is uarm.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He apagado la calefacción, hace calor.' AND notes = 'Ejemplo de "uitzetten" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He apagado la calefacción, hace calor.' AND notes = 'Ejemplo de "uitzetten" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'apagar'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'He apagado la calefacción, hace calor.' AND notes = 'Ejemplo de "uitzetten" (perf.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Apagó el motor y se bajó.', 'SENTENCE', 'Ejemplo de "uitzetten" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Apagó el motor y se bajó.' AND notes = 'Ejemplo de "uitzetten" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Apagó el motor y se bajó.' AND notes = 'Ejemplo de "uitzetten" (can.)' LIMIT 1),
    'nl_NL', 'Hij zette de motor uit en stapte uit.', 'Ei sette de motor eut en stapte eut.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Apagó el motor y se bajó.' AND notes = 'Ejemplo de "uitzetten" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Apagó el motor y se bajó.' AND notes = 'Ejemplo de "uitzetten" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'apagar'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Apagó el motor y se bajó.' AND notes = 'Ejemplo de "uitzetten" (can.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- vooraanstaande
-- ==============================================================================

INSERT INTO words_es (text, word_type, notes)
SELECT 'Es un abogado destacado en Ámsterdam.', 'SENTENCE', 'Ejemplo de "vooraanstaande" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Es un abogado destacado en Ámsterdam.' AND notes = 'Ejemplo de "vooraanstaande" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Es un abogado destacado en Ámsterdam.' AND notes = 'Ejemplo de "vooraanstaande" (can.)' LIMIT 1),
    'nl_NL', 'Hij is een vooraanstaande advocaat in Amsterdam.', 'Ei is en foranstande atfokat in Amsterdam.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Es un abogado destacado en Ámsterdam.' AND notes = 'Ejemplo de "vooraanstaande" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Es un abogado destacado en Ámsterdam.' AND notes = 'Ejemplo de "vooraanstaande" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'destacado, de primera fila'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Es un abogado destacado en Ámsterdam.' AND notes = 'Ejemplo de "vooraanstaande" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Su padre fue un político destacado.', 'SENTENCE', 'Ejemplo de "vooraanstaande" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Su padre fue un político destacado.' AND notes = 'Ejemplo de "vooraanstaande" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Su padre fue un político destacado.' AND notes = 'Ejemplo de "vooraanstaande" (can.)' LIMIT 1),
    'nl_NL', 'Haar vader was vroeger een vooraanstaande politicus.', 'Har fader uas frujer en foranstande politikus.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Su padre fue un político destacado.' AND notes = 'Ejemplo de "vooraanstaande" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Su padre fue un político destacado.' AND notes = 'Ejemplo de "vooraanstaande" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'destacado, de primera fila'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Su padre fue un político destacado.' AND notes = 'Ejemplo de "vooraanstaande" (can.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- nogmaals
-- ==============================================================================

INSERT INTO words_es (text, word_type, notes)
SELECT 'Lo he intentado una vez más, pero no salió.', 'SENTENCE', 'Ejemplo de "nogmaals" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Lo he intentado una vez más, pero no salió.' AND notes = 'Ejemplo de "nogmaals" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo he intentado una vez más, pero no salió.' AND notes = 'Ejemplo de "nogmaals" (perf.)' LIMIT 1),
    'nl_NL', 'Ik heb het nogmaals geprobeerd, maar het lukte niet.', 'Ik ep et nojmals jeprobert, mar et lukte nit.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo he intentado una vez más, pero no salió.' AND notes = 'Ejemplo de "nogmaals" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo he intentado una vez más, pero no salió.' AND notes = 'Ejemplo de "nogmaals" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'una vez más, de nuevo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Lo he intentado una vez más, pero no salió.' AND notes = 'Ejemplo de "nogmaals" (perf.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Lo explicó otra vez, con calma y despacio.', 'SENTENCE', 'Ejemplo de "nogmaals" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Lo explicó otra vez, con calma y despacio.' AND notes = 'Ejemplo de "nogmaals" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo explicó otra vez, con calma y despacio.' AND notes = 'Ejemplo de "nogmaals" (can.)' LIMIT 1),
    'nl_NL', 'Hij legde het nogmaals uit, rustig en langzaam.', 'Ei lejde et nojmals eut, rustij en lansam.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo explicó otra vez, con calma y despacio.' AND notes = 'Ejemplo de "nogmaals" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo explicó otra vez, con calma y despacio.' AND notes = 'Ejemplo de "nogmaals" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'una vez más, de nuevo'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Lo explicó otra vez, con calma y despacio.' AND notes = 'Ejemplo de "nogmaals" (can.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- bijstaan
-- ==============================================================================

INSERT INTO words_es (text, word_type, notes)
SELECT 'Estoy a tu lado, pase lo que pase.', 'SENTENCE', 'Ejemplo de "bijstaan" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Estoy a tu lado, pase lo que pase.' AND notes = 'Ejemplo de "bijstaan" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy a tu lado, pase lo que pase.' AND notes = 'Ejemplo de "bijstaan" (can.)' LIMIT 1),
    'nl_NL', 'Ik sta je bij, wat er ook gebeurt.', 'Ik sta ye bei, uat er ok jebeurt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy a tu lado, pase lo que pase.' AND notes = 'Ejemplo de "bijstaan" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy a tu lado, pase lo que pase.' AND notes = 'Ejemplo de "bijstaan" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'asistir, apoyar a alguien'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Estoy a tu lado, pase lo que pase.' AND notes = 'Ejemplo de "bijstaan" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Estuvo al lado de su madre hasta el final.', 'SENTENCE', 'Ejemplo de "bijstaan" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Estuvo al lado de su madre hasta el final.' AND notes = 'Ejemplo de "bijstaan" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Estuvo al lado de su madre hasta el final.' AND notes = 'Ejemplo de "bijstaan" (can.)' LIMIT 1),
    'nl_NL', 'Ze stond haar moeder bij tot het einde.', 'Se stont har muder bei tot et einde.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estuvo al lado de su madre hasta el final.' AND notes = 'Ejemplo de "bijstaan" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estuvo al lado de su madre hasta el final.' AND notes = 'Ejemplo de "bijstaan" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'asistir, apoyar a alguien'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Estuvo al lado de su madre hasta el final.' AND notes = 'Ejemplo de "bijstaan" (can.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- afvallen
-- ==============================================================================

INSERT INTO words_es (text, word_type, notes)
SELECT 'He adelgazado cinco kilos.', 'SENTENCE', 'Ejemplo de "afvallen" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'He adelgazado cinco kilos.' AND notes = 'Ejemplo de "afvallen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'He adelgazado cinco kilos.' AND notes = 'Ejemplo de "afvallen" (perf.)' LIMIT 1),
    'nl_NL', 'Ik ben vijf kilo afgevallen.', 'Ik ben feif kilo affefallen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He adelgazado cinco kilos.' AND notes = 'Ejemplo de "afvallen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He adelgazado cinco kilos.' AND notes = 'Ejemplo de "afvallen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'adelgazar'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'He adelgazado cinco kilos.' AND notes = 'Ejemplo de "afvallen" (perf.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Quiere adelgazar para el verano.', 'SENTENCE', 'Ejemplo de "afvallen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Quiere adelgazar para el verano.' AND notes = 'Ejemplo de "afvallen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Quiere adelgazar para el verano.' AND notes = 'Ejemplo de "afvallen" (can.)' LIMIT 1),
    'nl_NL', 'Ze wil afvallen voor de zomer.', 'Se uil affallen for de somer.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Quiere adelgazar para el verano.' AND notes = 'Ejemplo de "afvallen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Quiere adelgazar para el verano.' AND notes = 'Ejemplo de "afvallen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'adelgazar'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Quiere adelgazar para el verano.' AND notes = 'Ejemplo de "afvallen" (can.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- afschrikking
-- ==============================================================================

INSERT INTO words_es (text, word_type, notes)
SELECT 'Las armas nucleares sirven sobre todo como disuasión.', 'SENTENCE', 'Ejemplo de "afschrikking" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Las armas nucleares sirven sobre todo como disuasión.' AND notes = 'Ejemplo de "afschrikking" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Las armas nucleares sirven sobre todo como disuasión.' AND notes = 'Ejemplo de "afschrikking" (can.)' LIMIT 1),
    'nl_NL', 'Kernwapens dienen vooral als afschrikking.', 'Kernuapens dinen foral als afsjrikkinj.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Las armas nucleares sirven sobre todo como disuasión.' AND notes = 'Ejemplo de "afschrikking" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Las armas nucleares sirven sobre todo como disuasión.' AND notes = 'Ejemplo de "afschrikking" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'la disuasión'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Las armas nucleares sirven sobre todo como disuasión.' AND notes = 'Ejemplo de "afschrikking" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Antes se creía que las penas duras eran la mejor disuasión.', 'SENTENCE', 'Ejemplo de "afschrikking" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Antes se creía que las penas duras eran la mejor disuasión.' AND notes = 'Ejemplo de "afschrikking" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Antes se creía que las penas duras eran la mejor disuasión.' AND notes = 'Ejemplo de "afschrikking" (can.)' LIMIT 1),
    'nl_NL', 'Vroeger dacht men dat zware straffen de beste afschrikking waren.', 'Frujer dajt men dat suare straffen de beste afsjrikkinj uaren.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Antes se creía que las penas duras eran la mejor disuasión.' AND notes = 'Ejemplo de "afschrikking" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Antes se creía que las penas duras eran la mejor disuasión.' AND notes = 'Ejemplo de "afschrikking" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'la disuasión'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Antes se creía que las penas duras eran la mejor disuasión.' AND notes = 'Ejemplo de "afschrikking" (can.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- verbergen
-- ==============================================================================

INSERT INTO words_es (text, word_type, notes)
SELECT 'Esconde sus sentimientos ante todos.', 'SENTENCE', 'Ejemplo de "verbergen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Esconde sus sentimientos ante todos.' AND notes = 'Ejemplo de "verbergen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Esconde sus sentimientos ante todos.' AND notes = 'Ejemplo de "verbergen" (can.)' LIMIT 1),
    'nl_NL', 'Hij verbergt zijn gevoelens voor iedereen.', 'Ei ferbergt sein jefulens for ideren.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esconde sus sentimientos ante todos.' AND notes = 'Ejemplo de "verbergen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esconde sus sentimientos ante todos.' AND notes = 'Ejemplo de "verbergen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'ocultar, esconder'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Esconde sus sentimientos ante todos.' AND notes = 'Ejemplo de "verbergen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'El niño se escondió detrás del sofá.', 'SENTENCE', 'Ejemplo de "verbergen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El niño se escondió detrás del sofá.' AND notes = 'Ejemplo de "verbergen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El niño se escondió detrás del sofá.' AND notes = 'Ejemplo de "verbergen" (can.)' LIMIT 1),
    'nl_NL', 'Het kind verborg zich achter de bank.', 'Et kint ferborj sij ajter de bank.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El niño se escondió detrás del sofá.' AND notes = 'Ejemplo de "verbergen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El niño se escondió detrás del sofá.' AND notes = 'Ejemplo de "verbergen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'ocultar, esconder'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'El niño se escondió detrás del sofá.' AND notes = 'Ejemplo de "verbergen" (can.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- bespeuren
-- ==============================================================================

INSERT INTO words_es (text, word_type, notes)
SELECT 'El perro detecta el peligro antes que nosotros.', 'SENTENCE', 'Ejemplo de "bespeuren" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El perro detecta el peligro antes que nosotros.' AND notes = 'Ejemplo de "bespeuren" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El perro detecta el peligro antes que nosotros.' AND notes = 'Ejemplo de "bespeuren" (can.)' LIMIT 1),
    'nl_NL', 'De hond bespeurt gevaar eerder dan wij.', 'De hont bespeurt jefar erder dan uei.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El perro detecta el peligro antes que nosotros.' AND notes = 'Ejemplo de "bespeuren" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El perro detecta el peligro antes que nosotros.' AND notes = 'Ejemplo de "bespeuren" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'percibir, detectar'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'El perro detecta el peligro antes que nosotros.' AND notes = 'Ejemplo de "bespeuren" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Nunca ha percibido en él ningún arrepentimiento.', 'SENTENCE', 'Ejemplo de "bespeuren" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Nunca ha percibido en él ningún arrepentimiento.' AND notes = 'Ejemplo de "bespeuren" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Nunca ha percibido en él ningún arrepentimiento.' AND notes = 'Ejemplo de "bespeuren" (perf.)' LIMIT 1),
    'nl_NL', 'Ze heeft nooit enige spijt bij hem bespeurd.', 'Se eft noit enije speit bei em bespeurt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Nunca ha percibido en él ningún arrepentimiento.' AND notes = 'Ejemplo de "bespeuren" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Nunca ha percibido en él ningún arrepentimiento.' AND notes = 'Ejemplo de "bespeuren" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'percibir, detectar'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Nunca ha percibido en él ningún arrepentimiento.' AND notes = 'Ejemplo de "bespeuren" (perf.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- benaderen
-- ==============================================================================

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me abordó después de la reunión.', 'SENTENCE', 'Ejemplo de "benaderen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me abordó después de la reunión.' AND notes = 'Ejemplo de "benaderen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me abordó después de la reunión.' AND notes = 'Ejemplo de "benaderen" (can.)' LIMIT 1),
    'nl_NL', 'Hij benaderde me na de vergadering.', 'Ei benaderde me na de ferjaderinj.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me abordó después de la reunión.' AND notes = 'Ejemplo de "benaderen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me abordó después de la reunión.' AND notes = 'Ejemplo de "benaderen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'abordar, contactar'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me abordó después de la reunión.' AND notes = 'Ejemplo de "benaderen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Me ha contactado un cazatalentos.', 'SENTENCE', 'Ejemplo de "benaderen" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me ha contactado un cazatalentos.' AND notes = 'Ejemplo de "benaderen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me ha contactado un cazatalentos.' AND notes = 'Ejemplo de "benaderen" (perf.)' LIMIT 1),
    'nl_NL', 'Ik ben benaderd door een recruiter.', 'Ik ben benadert dor en rikruter.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me ha contactado un cazatalentos.' AND notes = 'Ejemplo de "benaderen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me ha contactado un cazatalentos.' AND notes = 'Ejemplo de "benaderen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'abordar, contactar'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Me ha contactado un cazatalentos.' AND notes = 'Ejemplo de "benaderen" (perf.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- verwijderen
-- ==============================================================================

INSERT INTO words_es (text, word_type, notes)
SELECT 'He borrado las fotos del móvil.', 'SENTENCE', 'Ejemplo de "verwijderen" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'He borrado las fotos del móvil.' AND notes = 'Ejemplo de "verwijderen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'He borrado las fotos del móvil.' AND notes = 'Ejemplo de "verwijderen" (perf.)' LIMIT 1),
    'nl_NL', 'Ik heb de foto''s van mijn telefoon verwijderd.', 'Ik ep de foto''s fan mein telefon ferweidert.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He borrado las fotos del móvil.' AND notes = 'Ejemplo de "verwijderen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He borrado las fotos del móvil.' AND notes = 'Ejemplo de "verwijderen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'eliminar, borrar'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'He borrado las fotos del móvil.' AND notes = 'Ejemplo de "verwijderen" (perf.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Borra los archivos viejos todas las semanas.', 'SENTENCE', 'Ejemplo de "verwijderen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Borra los archivos viejos todas las semanas.' AND notes = 'Ejemplo de "verwijderen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Borra los archivos viejos todas las semanas.' AND notes = 'Ejemplo de "verwijderen" (can.)' LIMIT 1),
    'nl_NL', 'Hij verwijdert elke week de oude bestanden.', 'Ei ferweidert elke uek de aude bestanden.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Borra los archivos viejos todas las semanas.' AND notes = 'Ejemplo de "verwijderen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Borra los archivos viejos todas las semanas.' AND notes = 'Ejemplo de "verwijderen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT weg.word_es_id FROM word_es_groups weg
        JOIN words_es wep ON wep.id = weg.word_es_id
        WHERE wep.text = 'eliminar, borrar'
        AND weg.group_id = (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden')
        LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Borra los archivos viejos todas las semanas.' AND notes = 'Ejemplo de "verwijderen" (can.)' LIMIT 1),
    'EXAMPLE');
