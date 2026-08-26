-- Learn Languages App - Anade 'opgericht' al grupo de palabras dificiles
-- Migration: 20260826000001-add-word-opgericht-hard-words-group.sql
-- Description: Anade 'opgericht' (participio de oprichten = fundar/crear una empresa u
--   organizacion) al grupo 28, con rules_help, 5 frases de ejemplo en notes y 2 de ellas
--   promovidas a tarjetas SENTENCE entrenables (relation_type EXAMPLE).
--   100% aditiva e idempotente: solo INSERT (NOT EXISTS / OR IGNORE).

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- opgericht
-- ==============================================================================

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'fundado, creado (una empresa, organización)', 'WORD', 'dificil: opgericht (fundado/creado, participio de oprichten)', 'opgericht = participio de oprichten (fundar, crear, erigir una empresa, organizacion, institucion o monumento). Separable: op + richten. Se usa casi siempre en pasiva o perfecto: is opgericht / werd opgericht / heeft opgericht.
🗺️ El mapa: richten solo (sin op) significa dirigir o apuntar (de camara, arma, atencion — richten op = enfocarse en). oprichten anade el «op» y cambia de sentido: NO es apuntar, es LEVANTAR algo que antes no existia — fundar una empresa, erigir un monumento, crear una asociacion. Rival cercano: beginnen (empezar algo, mas informal, sin la idea de crear una entidad formal) y stichten (fundar con caracter mas solemne, tambien para stichting = fundacion).
📌 Regla de bolsillo: si hablas de crear una entidad FORMAL (empresa, club, museo, universidad) que antes no existia → oprichten/opgericht. Si es una construccion fisica desde cero, mejor bouwen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'fundado, creado (una empresa, organización)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'fundado, creado (una empresa, organización)' LIMIT 1),
    'nl_NL', 'opgericht', 'opjerijt',
    '• [perf.] Het bedrijf is opgericht in 1990. — La empresa fue fundada en 1990.
• [perf.] We hebben de vereniging vorig jaar opgericht. — Fundamos la asociación el año pasado.
• [vraag] Wie heeft dit museum opgericht? — ¿Quién fundó este museo?
• [inv.] Zodra de stichting was opgericht, begon het werk. — En cuanto se fundó la fundación, empezó el trabajo.
• [can.] Het is een van de oudste universiteiten, opgericht in de 13e eeuw. — Es una de las universidades más antiguas, fundada en el siglo XIII.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'fundado, creado (una empresa, organización)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'fundado, creado (una empresa, organización)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes)
SELECT 'La empresa fue fundada en 1990.', 'SENTENCE', 'Ejemplo de "opgericht" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'La empresa fue fundada en 1990.' AND notes = 'Ejemplo de "opgericht" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'La empresa fue fundada en 1990.' AND notes = 'Ejemplo de "opgericht" (perf.)' LIMIT 1),
    'nl_NL', 'Het bedrijf is opgericht in 1990.', 'Et bedreif is opjerijt in negentien negentij.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'La empresa fue fundada en 1990.' AND notes = 'Ejemplo de "opgericht" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'La empresa fue fundada en 1990.' AND notes = 'Ejemplo de "opgericht" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'fundado, creado (una empresa, organización)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'La empresa fue fundada en 1990.' AND notes = 'Ejemplo de "opgericht" (perf.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Fundamos la asociación el año pasado.', 'SENTENCE', 'Ejemplo de "opgericht" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Fundamos la asociación el año pasado.' AND notes = 'Ejemplo de "opgericht" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Fundamos la asociación el año pasado.' AND notes = 'Ejemplo de "opgericht" (perf.)' LIMIT 1),
    'nl_NL', 'We hebben de vereniging vorig jaar opgericht.', 'Ue eben de ferenijinj forij yar opjerijt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Fundamos la asociación el año pasado.' AND notes = 'Ejemplo de "opgericht" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Fundamos la asociación el año pasado.' AND notes = 'Ejemplo de "opgericht" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'fundado, creado (una empresa, organización)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Fundamos la asociación el año pasado.' AND notes = 'Ejemplo de "opgericht" (perf.)' LIMIT 1),
    'EXAMPLE');
