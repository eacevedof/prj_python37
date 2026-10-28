-- Learn Languages App - Anade 'asignar' y 'editar/actualizar' al grupo de palabras dificiles
-- Migration: 20260825000004-add-words-asignar-editar-hard-words-group.sql
-- Description: Anade dos palabras nuevas (toewijzen = asignar una variable, bewerken =
--   editar/actualizar el contenido de un archivo) al grupo 'palabras dificiles', con su
--   rules_help, 5 frases de ejemplo en notes y 2 de ellas promovidas a tarjetas SENTENCE
--   entrenables (relation_type EXAMPLE), igual que el resto del grupo.
--   100% aditiva e idempotente: solo INSERT (NOT EXISTS / OR IGNORE).

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- toewijzen
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'asignar (una variable)', 'WORD', 'dificil: toewijzen (asignar, una variable)', 'toewijzen = asignar, dar/atribuir algo a algo o a alguien. En programacion: asignar un valor a una variable. Es separable: wijst ... toe, heeft ... toegewezen.
🗺️ El mapa: toewijzen no es solo de codigo, tambien vale para asignar un asiento, un presupuesto, un permiso o una tarea — cualquier cosa que se REPARTE o se ADJUDICA a alguien/algo concreto. Rival cercano: toekennen (conceder formalmente, con mas peso oficial/legal — een subsidie toekennen, een prijs toekennen), mientras toewijzen es mas neutro y tecnico.
📌 Regla de bolsillo: si en espanol dices «asignar/repartir» → toewijzen; si dices «conceder/otorgar» con caracter mas formal → toekennen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'asignar (una variable)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'asignar (una variable)' LIMIT 1),
    'nl_NL', 'toewijzen', 'tueweisen',
    '• [can.] In deze functie wijs ik een waarde toe aan de variabele x. — En esta función asigno un valor a la variable x.
• [perf.] De compiler heeft automatisch een type toegewezen. — El compilador ha asignado un tipo automáticamente.
• [can.] Het systeem wijst elke gebruiker een uniek ID toe. — El sistema asigna a cada usuario un ID único.
• [inv.] Zodra de array is gevuld, wijst hij de waarden toe aan de variabelen. — En cuanto se llena el array, asigna los valores a las variables.
• [vraag] Heb je de rechten al toegewezen aan de nieuwe gebruiker? — ¿Ya has asignado los permisos al nuevo usuario?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'asignar (una variable)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'asignar (una variable)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes)
SELECT 'En esta función asigno un valor a la variable x.', 'SENTENCE', 'Ejemplo de "toewijzen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'En esta función asigno un valor a la variable x.' AND notes = 'Ejemplo de "toewijzen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'En esta función asigno un valor a la variable x.' AND notes = 'Ejemplo de "toewijzen" (can.)' LIMIT 1),
    'nl_NL', 'In deze functie wijs ik een waarde toe aan de variabele x.', 'In dese funktie weis ik en uarde tu an de fariabele iks.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En esta función asigno un valor a la variable x.' AND notes = 'Ejemplo de "toewijzen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En esta función asigno un valor a la variable x.' AND notes = 'Ejemplo de "toewijzen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'asignar (una variable)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'En esta función asigno un valor a la variable x.' AND notes = 'Ejemplo de "toewijzen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'El compilador ha asignado un tipo automáticamente.', 'SENTENCE', 'Ejemplo de "toewijzen" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El compilador ha asignado un tipo automáticamente.' AND notes = 'Ejemplo de "toewijzen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El compilador ha asignado un tipo automáticamente.' AND notes = 'Ejemplo de "toewijzen" (perf.)' LIMIT 1),
    'nl_NL', 'De compiler heeft automatisch een type toegewezen.', 'De kompailer eft automatisj en teip tujeuesen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El compilador ha asignado un tipo automáticamente.' AND notes = 'Ejemplo de "toewijzen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El compilador ha asignado un tipo automáticamente.' AND notes = 'Ejemplo de "toewijzen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'asignar (una variable)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'El compilador ha asignado un tipo automáticamente.' AND notes = 'Ejemplo de "toewijzen" (perf.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- bewerken
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'editar, actualizar (el contenido de un archivo)', 'WORD', 'dificil: bewerken (editar/actualizar el CONTENIDO de un archivo)', 'bewerken = editar, modificar el contenido de algo (un texto, una foto, un archivo). No separable: bewerkt, heeft bewerkt.
⚠️ La trampa con bijwerken: bijwerken tambien se traduce como «actualizar», pero es otra cosa — significa poner al dia una VERSION (software, datos, un registro), no tocar el contenido con tus manos. Software bijwerken = actualizar el software (instalar la ultima version). Een tekst bewerken = editar el texto (cambiar lo que dice).
📌 Regla de bolsillo: si tu editas/cambias el contenido tu mismo → bewerken. Si algo se pone al dia solo o instalas una version nueva → bijwerken.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'editar, actualizar (el contenido de un archivo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'editar, actualizar (el contenido de un archivo)' LIMIT 1),
    'nl_NL', 'bewerken', 'beuerken',
    '• [can.] Ik bewerk het bestand voordat ik het verstuur. — Edito el archivo antes de enviarlo.
• [perf.] Ze heeft de tekst al bewerkt. — Ya ha editado el texto.
• [can.] Hij bewerkt de foto''s met een ander programma. — Edita las fotos con otro programa.
• [geb.] Bewerk dit document niet zonder het op te slaan. — No edites este documento sin guardarlo.
• [vraag] Kun je dat bestand nog even bewerken? — ¿Puedes editar ese archivo un momento más?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'editar, actualizar (el contenido de un archivo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'editar, actualizar (el contenido de un archivo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes)
SELECT 'Edito el archivo antes de enviarlo.', 'SENTENCE', 'Ejemplo de "bewerken" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Edito el archivo antes de enviarlo.' AND notes = 'Ejemplo de "bewerken" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Edito el archivo antes de enviarlo.' AND notes = 'Ejemplo de "bewerken" (can.)' LIMIT 1),
    'nl_NL', 'Ik bewerk het bestand voordat ik het verstuur.', 'Ik beuerk et bestant fordat ik et ferstuur.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Edito el archivo antes de enviarlo.' AND notes = 'Ejemplo de "bewerken" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Edito el archivo antes de enviarlo.' AND notes = 'Ejemplo de "bewerken" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'editar, actualizar (el contenido de un archivo)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Edito el archivo antes de enviarlo.' AND notes = 'Ejemplo de "bewerken" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Ya ha editado el texto.', 'SENTENCE', 'Ejemplo de "bewerken" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ya ha editado el texto.' AND notes = 'Ejemplo de "bewerken" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya ha editado el texto.' AND notes = 'Ejemplo de "bewerken" (perf.)' LIMIT 1),
    'nl_NL', 'Ze heeft de tekst al bewerkt.', 'Se eft de tekst al beuerkt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya ha editado el texto.' AND notes = 'Ejemplo de "bewerken" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya ha editado el texto.' AND notes = 'Ejemplo de "bewerken" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'editar, actualizar (el contenido de un archivo)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Ya ha editado el texto.' AND notes = 'Ejemplo de "bewerken" (perf.)' LIMIT 1),
    'EXAMPLE');
