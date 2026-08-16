-- Learn Languages App - Grupo "pronomen" (pronombres de objeto)
-- Migration: 20260712000001-create-pronomen-group.sql
-- Description: Pronombres de objeto (me/mij, je/jou, u, hem, haar, het, ons, jullie,
--   ze, hen/hun) en frases coloquiales y frases hechas muy recurrentes, una tarjeta por
--   frase. Cada rules_help lleva la tabla de pronombres (de-woord->hem, het-woord->het,
--   plural->ze), el apunte del pronombre y la formula de estructura (principal /
--   pregunta / imperativo). Pronunciation generada con DutchToSpanishPhoneticService.
--   Idempotente y 100% aditiva: INSERT con WHERE NOT EXISTS / OR IGNORE.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'pronomen',
    'Pronombres de objeto (lo, la, le, los, les): me/mij, je/jou, u, hem, haar, het, ons, jullie, ze, hen/hun en frases coloquiales recurrentes',
    'migracion'
);

-- ==============================================================================
-- me: Het spijt me.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'lo siento', 'PHRASE', 'Pronombre objeto: me', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

Frase hecha: literalmente ''ello me pesa''. El ''me'' es objeto.

📐 Oración principal: sujeto + verbo conjugado (2ª posición) + pronombre objeto + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'lo siento' AND notes = 'Pronombre objeto: me');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'lo siento' AND notes = 'Pronombre objeto: me' LIMIT 1),
    'nl_NL', 'Het spijt me.', 'Et speit me.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'lo siento' AND notes = 'Pronombre objeto: me' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'lo siento' AND notes = 'Pronombre objeto: me' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- me: Laat me met rust.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'déjame en paz', 'PHRASE', 'Pronombre objeto: me', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

Coloquial. ''met rust laten'' = dejar en paz.

📐 Imperativo: verbo en 1ª posición (forma de ik) + pronombre objeto + resto; sin sujeto. El ''maar'' lo suaviza (anda, venga).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'déjame en paz' AND notes = 'Pronombre objeto: me');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'déjame en paz' AND notes = 'Pronombre objeto: me' LIMIT 1),
    'nl_NL', 'Laat me met rust.', 'Lat me met rust.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'déjame en paz' AND notes = 'Pronombre objeto: me' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'déjame en paz' AND notes = 'Pronombre objeto: me' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- mij (tónico): Dat maakt mij niet uit.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'a mí me da igual', 'PHRASE', 'Pronombre objeto: mij (tónico)', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

''mij'' es la forma tónica de ''me'': se usa para enfatizar (a MÍ). Frase hecha: ''het maakt niet uit'' = da igual.

📐 Oración principal: sujeto + verbo conjugado (2ª posición) + pronombre objeto + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'a mí me da igual' AND notes = 'Pronombre objeto: mij (tónico)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'a mí me da igual' AND notes = 'Pronombre objeto: mij (tónico)' LIMIT 1),
    'nl_NL', 'Dat maakt mij niet uit.', 'Dat makt mei nit aut.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a mí me da igual' AND notes = 'Pronombre objeto: mij (tónico)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a mí me da igual' AND notes = 'Pronombre objeto: mij (tónico)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- je: Ik hou van je.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'te quiero', 'PHRASE', 'Pronombre objeto: je', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

La frase más recurrente con ''je'' objeto. ''houden van'' = querer/amar.

📐 Oración principal: sujeto + verbo conjugado (2ª posición) + pronombre objeto + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'te quiero' AND notes = 'Pronombre objeto: je');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'te quiero' AND notes = 'Pronombre objeto: je' LIMIT 1),
    'nl_NL', 'Ik hou van je.', 'Ik au fan ye.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'te quiero' AND notes = 'Pronombre objeto: je' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'te quiero' AND notes = 'Pronombre objeto: je' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- jou (tónico): Dat gaat jou niets aan.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'eso a ti no te importa', 'PHRASE', 'Pronombre objeto: jou (tónico)', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

Coloquial. ''jou'' es la forma tónica de ''je''. ''iemand aangaan'' = incumbir a alguien.

📐 Oración principal: sujeto + verbo conjugado (2ª posición) + pronombre objeto + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'eso a ti no te importa' AND notes = 'Pronombre objeto: jou (tónico)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'eso a ti no te importa' AND notes = 'Pronombre objeto: jou (tónico)' LIMIT 1),
    'nl_NL', 'Dat gaat jou niets aan.', 'Dat jat yau nits an.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'eso a ti no te importa' AND notes = 'Pronombre objeto: jou (tónico)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'eso a ti no te importa' AND notes = 'Pronombre objeto: jou (tónico)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- u (formal): Kan ik u helpen?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿puedo ayudarle?', 'PHRASE', 'Pronombre objeto: u (formal)', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

La frase de tienda por excelencia. ''u'' vale para objeto y sujeto formal.

📐 Pregunta sí/no: verbo conjugado en 1ª posición + sujeto + pronombre objeto + resto; otros verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿puedo ayudarle?' AND notes = 'Pronombre objeto: u (formal)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿puedo ayudarle?' AND notes = 'Pronombre objeto: u (formal)' LIMIT 1),
    'nl_NL', 'Kan ik u helpen?', 'Kan ik u elpen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿puedo ayudarle?' AND notes = 'Pronombre objeto: u (formal)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿puedo ayudarle?' AND notes = 'Pronombre objeto: u (formal)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- hem (cosa de-woord): Mag ik hem al wel weggeven?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿ahora sí puedo regalarla?', 'PHRASE', 'Pronombre objeto: hem (cosa de-woord)', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

''hem'' = lo/la para COSAS de-woord (aquí: de camera). ''al wel'' = ya sí (antes no se podía). Con modal (mag) el otro verbo va al final en infinitivo.

📐 Pregunta sí/no: verbo conjugado en 1ª posición + sujeto + pronombre objeto + resto; otros verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿ahora sí puedo regalarla?' AND notes = 'Pronombre objeto: hem (cosa de-woord)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿ahora sí puedo regalarla?' AND notes = 'Pronombre objeto: hem (cosa de-woord)' LIMIT 1),
    'nl_NL', 'Mag ik hem al wel weggeven?', 'Maj ik em al uel uejjefen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿ahora sí puedo regalarla?' AND notes = 'Pronombre objeto: hem (cosa de-woord)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿ahora sí puedo regalarla?' AND notes = 'Pronombre objeto: hem (cosa de-woord)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- hem (persona): Ik ken hem goed.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'lo conozco bien', 'PHRASE', 'Pronombre objeto: hem (persona)', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

''hem'' también es ''lo/le'' para él (persona).

📐 Oración principal: sujeto + verbo conjugado (2ª posición) + pronombre objeto + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'lo conozco bien' AND notes = 'Pronombre objeto: hem (persona)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'lo conozco bien' AND notes = 'Pronombre objeto: hem (persona)' LIMIT 1),
    'nl_NL', 'Ik ken hem goed.', 'Ik ken em jud.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'lo conozco bien' AND notes = 'Pronombre objeto: hem (persona)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'lo conozco bien' AND notes = 'Pronombre objeto: hem (persona)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- haar: Bel haar maar even.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'llámala un momento, anda', 'PHRASE', 'Pronombre objeto: haar', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

''haar'' = la/le (ella). ''maar even'' suaviza la orden (anda, un momentito).

📐 Imperativo: verbo en 1ª posición (forma de ik) + pronombre objeto + resto; sin sujeto. El ''maar'' lo suaviza (anda, venga).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'llámala un momento, anda' AND notes = 'Pronombre objeto: haar');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'llámala un momento, anda' AND notes = 'Pronombre objeto: haar' LIMIT 1),
    'nl_NL', 'Bel haar maar even.', 'Bel ar mar efen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'llámala un momento, anda' AND notes = 'Pronombre objeto: haar' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'llámala un momento, anda' AND notes = 'Pronombre objeto: haar' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- het: Ik weet het niet.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no lo sé', 'PHRASE', 'Pronombre objeto: het', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

La frase más dicha del neerlandés. ''het'' = lo (cosas het-woord o algo abstracto).

📐 Oración principal: sujeto + verbo conjugado (2ª posición) + pronombre objeto + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'no lo sé' AND notes = 'Pronombre objeto: het');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'no lo sé' AND notes = 'Pronombre objeto: het' LIMIT 1),
    'nl_NL', 'Ik weet het niet.', 'Ik uet et nit.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no lo sé' AND notes = 'Pronombre objeto: het' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no lo sé' AND notes = 'Pronombre objeto: het' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- het: Zeg het maar.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tú dirás / dime', 'PHRASE', 'Pronombre objeto: het', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

Frase hecha de bar/tienda: te invita a pedir. Literal: ''dilo sin más''.

📐 Imperativo: verbo en 1ª posición (forma de ik) + pronombre objeto + resto; sin sujeto. El ''maar'' lo suaviza (anda, venga).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'tú dirás / dime' AND notes = 'Pronombre objeto: het');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'tú dirás / dime' AND notes = 'Pronombre objeto: het' LIMIT 1),
    'nl_NL', 'Zeg het maar.', 'Sej et mar.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tú dirás / dime' AND notes = 'Pronombre objeto: het' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tú dirás / dime' AND notes = 'Pronombre objeto: het' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- ons: Laat het ons weten.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'háznoslo saber', 'PHRASE', 'Pronombre objeto: ons', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

Doble pronombre: ''het'' (directo) antes de ''ons'' (indirecto). Muy usada en emails.

📐 Imperativo: verbo en 1ª posición (forma de ik) + pronombre objeto + resto; sin sujeto. El ''maar'' lo suaviza (anda, venga).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'háznoslo saber' AND notes = 'Pronombre objeto: ons');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'háznoslo saber' AND notes = 'Pronombre objeto: ons' LIMIT 1),
    'nl_NL', 'Laat het ons weten.', 'Lat et ons ueten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'háznoslo saber' AND notes = 'Pronombre objeto: ons' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'háznoslo saber' AND notes = 'Pronombre objeto: ons' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- jullie: Ik wens jullie veel succes.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'os deseo mucho éxito', 'PHRASE', 'Pronombre objeto: jullie', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

''jullie'' = os. ''Veel succes!'' solo también es la frase hecha de ánimo.

📐 Oración principal: sujeto + verbo conjugado (2ª posición) + pronombre objeto + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'os deseo mucho éxito' AND notes = 'Pronombre objeto: jullie');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'os deseo mucho éxito' AND notes = 'Pronombre objeto: jullie' LIMIT 1),
    'nl_NL', 'Ik wens jullie veel succes.', 'Ik uens yulli fel succes.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'os deseo mucho éxito' AND notes = 'Pronombre objeto: jullie' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'os deseo mucho éxito' AND notes = 'Pronombre objeto: jullie' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- ze (cosas plural): Gooi ze maar weg.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tíralos sin más', 'PHRASE', 'Pronombre objeto: ze (cosas plural)', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

''ze'' = los/las para cosas en plural. ''weggooien'' = tirar (separable: gooi ... weg).

📐 Imperativo: verbo en 1ª posición (forma de ik) + pronombre objeto + resto; sin sujeto. El ''maar'' lo suaviza (anda, venga).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'tíralos sin más' AND notes = 'Pronombre objeto: ze (cosas plural)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'tíralos sin más' AND notes = 'Pronombre objeto: ze (cosas plural)' LIMIT 1),
    'nl_NL', 'Gooi ze maar weg.', 'Joi se mar uej.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tíralos sin más' AND notes = 'Pronombre objeto: ze (cosas plural)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tíralos sin más' AND notes = 'Pronombre objeto: ze (cosas plural)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- ze (personas plural): Ik heb ze gisteren gezien.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'los vi ayer', 'PHRASE', 'Pronombre objeto: ze (personas plural)', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

''ze'' también vale para personas en plural (forma átona de hen).

📐 Oración principal: sujeto + verbo conjugado (2ª posición) + pronombre objeto + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'los vi ayer' AND notes = 'Pronombre objeto: ze (personas plural)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'los vi ayer' AND notes = 'Pronombre objeto: ze (personas plural)' LIMIT 1),
    'nl_NL', 'Ik heb ze gisteren gezien.', 'Ik eb se jisteren jesin.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los vi ayer' AND notes = 'Pronombre objeto: ze (personas plural)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los vi ayer' AND notes = 'Pronombre objeto: ze (personas plural)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- hen (directo): Ik heb hen niet uitgenodigd.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no los invité', 'PHRASE', 'Pronombre objeto: hen (directo)', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

''hen'' = los/las (objeto DIRECTO, tónico). En el habla se suele decir ''ze''.

📐 Oración principal: sujeto + verbo conjugado (2ª posición) + pronombre objeto + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'no los invité' AND notes = 'Pronombre objeto: hen (directo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'no los invité' AND notes = 'Pronombre objeto: hen (directo)' LIMIT 1),
    'nl_NL', 'Ik heb hen niet uitgenodigd.', 'Ik eb en nit autjenodijd.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no los invité' AND notes = 'Pronombre objeto: hen (directo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no los invité' AND notes = 'Pronombre objeto: hen (directo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- hun (indirecto): Ik heb hun niets verteld.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no les conté nada', 'PHRASE', 'Pronombre objeto: hun (indirecto)', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

''hun'' = les (objeto INDIRECTO sin preposición). Regla: hen directo, hun indirecto; en la duda, ''ze'' o ''aan hen''.

📐 Oración principal: sujeto + verbo conjugado (2ª posición) + pronombre objeto + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'no les conté nada' AND notes = 'Pronombre objeto: hun (indirecto)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'no les conté nada' AND notes = 'Pronombre objeto: hun (indirecto)' LIMIT 1),
    'nl_NL', 'Ik heb hun niets verteld.', 'Ik eb un nits ferteld.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no les conté nada' AND notes = 'Pronombre objeto: hun (indirecto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no les conté nada' AND notes = 'Pronombre objeto: hun (indirecto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- het + je (doble): Ik geef het je zo.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ahora te lo doy', 'PHRASE', 'Pronombre objeto: het + je (doble)', 'Pronombres de objeto (lo, la, le, los, las, les...):
• me/mij — me · je/jou — te · u — le/lo (usted)
• hem — lo/le (él, y COSAS de-woord) · haar — la/le (ella) · het — lo (cosas het-woord)
• ons — nos · jullie — os
• ze — los/las (personas y cosas en plural) · hen — los (directo) · hun — les (indirecto)
Cosas: de-woord → hem · het-woord → het · plural → ze

Orden de dobles pronombres: ''het'' (directo) SIEMPRE antes del indirecto (''je''). ''zo'' = ahora mismo, enseguida.

📐 Oración principal: sujeto + verbo conjugado (2ª posición) + pronombre objeto + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'ahora te lo doy' AND notes = 'Pronombre objeto: het + je (doble)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ahora te lo doy' AND notes = 'Pronombre objeto: het + je (doble)' LIMIT 1),
    'nl_NL', 'Ik geef het je zo.', 'Ik jef et ye so.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ahora te lo doy' AND notes = 'Pronombre objeto: het + je (doble)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronomen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ahora te lo doy' AND notes = 'Pronombre objeto: het + je (doble)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
