-- Learn Languages App - Grupo "werkwoord-varianten" (verbos y sus variantes con prefijo)
-- Migration: 20260712000002-create-werkwoord-varianten-group.sql
-- Description: 10 verbos comunes y sus variantes con prefijo (zorgen/bezorgen/verzorgen,
--   denken/nadenken/bedenken, passen, kijken, komen, staan, houden, nemen, spreken,
--   geven), cada variante como frase coloquial/recurrente. rules_help = familia completa
--   contrastada + regla separable/inseparable + apunte de la variante + formula.
--   Pronunciation generada con DutchToSpanishPhoneticService.
--   Idempotente y 100% aditiva: INSERT con WHERE NOT EXISTS / OR IGNORE.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'werkwoord-varianten',
    'Los 10 verbos más comunes y sus variantes con prefijo (zorgen/bezorgen/verzorgen, denken/nadenken/bedenken, passen, kijken, komen, staan, houden, nemen, spreken, geven): contextos y diferencias',
    'migracion'
);

-- ==============================================================================
-- zorgen voor: Ik zorg voor de kinderen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'yo cuido de los niños', 'PHRASE', 'Variante de zorgen: zorgen voor', 'Familia zorgen:
• zorgen voor — cuidar de, ocuparse de
• ervoor zorgen dat — encargarse de que
• bezorgen (insep.) — entregar (a domicilio); causar (hoofdpijn bezorgen)
• verzorgen (insep.) — cuidar, atender (personas, animales, el aspecto)
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

El básico de la familia: zorgen casi siempre con ''voor''.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'yo cuido de los niños' AND notes = 'Variante de zorgen: zorgen voor');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'yo cuido de los niños' AND notes = 'Variante de zorgen: zorgen voor' LIMIT 1),
    'nl_NL', 'Ik zorg voor de kinderen.', 'Ik sorj for de kinderen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'yo cuido de los niños' AND notes = 'Variante de zorgen: zorgen voor' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'yo cuido de los niños' AND notes = 'Variante de zorgen: zorgen voor' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- ervoor zorgen dat: Ik zorg ervoor dat alles klaar is.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me encargo de que todo esté listo', 'PHRASE', 'Variante de zorgen: ervoor zorgen dat', 'Familia zorgen:
• zorgen voor — cuidar de, ocuparse de
• ervoor zorgen dat — encargarse de que
• bezorgen (insep.) — entregar (a domicilio); causar (hoofdpijn bezorgen)
• verzorgen (insep.) — cuidar, atender (personas, animales, el aspecto)
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

Muy usado en trabajo. La parte ''dat...'' es subordinada: verbos al final.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'me encargo de que todo esté listo' AND notes = 'Variante de zorgen: ervoor zorgen dat');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'me encargo de que todo esté listo' AND notes = 'Variante de zorgen: ervoor zorgen dat' LIMIT 1),
    'nl_NL', 'Ik zorg ervoor dat alles klaar is.', 'Ik sorj erfor dat alles klar is.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me encargo de que todo esté listo' AND notes = 'Variante de zorgen: ervoor zorgen dat' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me encargo de que todo esté listo' AND notes = 'Variante de zorgen: ervoor zorgen dat' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- bezorgen: Ze bezorgen het pakje morgen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'entregan el paquete mañana', 'PHRASE', 'Variante de zorgen: bezorgen', 'Familia zorgen:
• zorgen voor — cuidar de, ocuparse de
• ervoor zorgen dat — encargarse de que
• bezorgen (insep.) — entregar (a domicilio); causar (hoofdpijn bezorgen)
• verzorgen (insep.) — cuidar, atender (personas, animales, el aspecto)
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

bezorgen = entregar a domicilio (de bezorger = el repartidor). También causar: iemand hoofdpijn bezorgen.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'entregan el paquete mañana' AND notes = 'Variante de zorgen: bezorgen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'entregan el paquete mañana' AND notes = 'Variante de zorgen: bezorgen' LIMIT 1),
    'nl_NL', 'Ze bezorgen het pakje morgen.', 'Se besorjen et pakye morjen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'entregan el paquete mañana' AND notes = 'Variante de zorgen: bezorgen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'entregan el paquete mañana' AND notes = 'Variante de zorgen: bezorgen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- verzorgen: Zij verzorgt haar zieke moeder.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ella cuida a su madre enferma', 'PHRASE', 'Variante de zorgen: verzorgen', 'Familia zorgen:
• zorgen voor — cuidar de, ocuparse de
• ervoor zorgen dat — encargarse de que
• bezorgen (insep.) — entregar (a domicilio); causar (hoofdpijn bezorgen)
• verzorgen (insep.) — cuidar, atender (personas, animales, el aspecto)
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

verzorgen = cuidar activamente (curas, comida, aseo); zorgen voor es más general (ocuparse).

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'ella cuida a su madre enferma' AND notes = 'Variante de zorgen: verzorgen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ella cuida a su madre enferma' AND notes = 'Variante de zorgen: verzorgen' LIMIT 1),
    'nl_NL', 'Zij verzorgt haar zieke moeder.', 'Sei fersorjt ar sike muder.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ella cuida a su madre enferma' AND notes = 'Variante de zorgen: verzorgen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ella cuida a su madre enferma' AND notes = 'Variante de zorgen: verzorgen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- denken aan: Ik denk aan je.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pienso en ti', 'PHRASE', 'Variante de denken: denken aan', 'Familia denken:
• denken — pensar, creer · denken aan — pensar en
• nadenken over (sep.) — reflexionar, darle vueltas
• bedenken (insep.) — idear, ocurrírsele · zich bedenken — cambiar de idea
Ojo: aandenken NO es verbo, es sustantivo (het aandenken = el recuerdo/souvenir)
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

denken aan = pensar en · denken dat = creer que.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'pienso en ti' AND notes = 'Variante de denken: denken aan');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'pienso en ti' AND notes = 'Variante de denken: denken aan' LIMIT 1),
    'nl_NL', 'Ik denk aan je.', 'Ik denk an ye.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pienso en ti' AND notes = 'Variante de denken: denken aan' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pienso en ti' AND notes = 'Variante de denken: denken aan' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- nadenken: Laat me even nadenken.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'déjame pensarlo un momento', 'PHRASE', 'Variante de denken: nadenken', 'Familia denken:
• denken — pensar, creer · denken aan — pensar en
• nadenken over (sep.) — reflexionar, darle vueltas
• bedenken (insep.) — idear, ocurrírsele · zich bedenken — cambiar de idea
Ojo: aandenken NO es verbo, es sustantivo (het aandenken = el recuerdo/souvenir)
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

nadenken = reflexionar, darle vueltas (más profundo que denken). Separable: denk goed na!

📐 Imperativo: verbo en 1ª posición (forma de ik) + resto; sin sujeto. Si el verbo es separable, el prefijo va al final (Pas op! Geef niet op!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'déjame pensarlo un momento' AND notes = 'Variante de denken: nadenken');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'déjame pensarlo un momento' AND notes = 'Variante de denken: nadenken' LIMIT 1),
    'nl_NL', 'Laat me even nadenken.', 'Lat me efen nadenken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'déjame pensarlo un momento' AND notes = 'Variante de denken: nadenken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'déjame pensarlo un momento' AND notes = 'Variante de denken: nadenken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- bedenken: Ik heb iets bedacht.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'se me ha ocurrido algo', 'PHRASE', 'Variante de denken: bedenken', 'Familia denken:
• denken — pensar, creer · denken aan — pensar en
• nadenken over (sep.) — reflexionar, darle vueltas
• bedenken (insep.) — idear, ocurrírsele · zich bedenken — cambiar de idea
Ojo: aandenken NO es verbo, es sustantivo (het aandenken = el recuerdo/souvenir)
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

bedenken = idear/ocurrírsele (participio sin ge-: bedacht). zich bedenken = cambiar de idea: ik heb me bedacht.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'se me ha ocurrido algo' AND notes = 'Variante de denken: bedenken');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'se me ha ocurrido algo' AND notes = 'Variante de denken: bedenken' LIMIT 1),
    'nl_NL', 'Ik heb iets bedacht.', 'Ik eb its bedajt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se me ha ocurrido algo' AND notes = 'Variante de denken: bedenken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se me ha ocurrido algo' AND notes = 'Variante de denken: bedenken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- passen: Deze broek past niet.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'este pantalón no me queda', 'PHRASE', 'Variante de passen: passen', 'Familia passen:
• passen — quedar bien (talla), caber; probarse (iets passen)
• passen bij — pegar con, combinar
• oppassen (sep.) — tener cuidado; hacer de canguro (de oppas)
• aanpassen (sep.) — adaptar, ajustar · zich aanpassen — adaptarse
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

passen = quedar de talla o caber. Probarse algo = iets passen (mag ik dit passen?).

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'este pantalón no me queda' AND notes = 'Variante de passen: passen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'este pantalón no me queda' AND notes = 'Variante de passen: passen' LIMIT 1),
    'nl_NL', 'Deze broek past niet.', 'Dese bruk past nit.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'este pantalón no me queda' AND notes = 'Variante de passen: passen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'este pantalón no me queda' AND notes = 'Variante de passen: passen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- oppassen: Pas op!
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡cuidado!', 'PHRASE', 'Variante de passen: oppassen', 'Familia passen:
• passen — quedar bien (talla), caber; probarse (iets passen)
• passen bij — pegar con, combinar
• oppassen (sep.) — tener cuidado; hacer de canguro (de oppas)
• aanpassen (sep.) — adaptar, ajustar · zich aanpassen — adaptarse
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

La advertencia nº1. oppassen también = cuidar niños: de oppas = el/la canguro.

📐 Imperativo: verbo en 1ª posición (forma de ik) + resto; sin sujeto. Si el verbo es separable, el prefijo va al final (Pas op! Geef niet op!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡cuidado!' AND notes = 'Variante de passen: oppassen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡cuidado!' AND notes = 'Variante de passen: oppassen' LIMIT 1),
    'nl_NL', 'Pas op!', 'Pas op!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡cuidado!' AND notes = 'Variante de passen: oppassen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡cuidado!' AND notes = 'Variante de passen: oppassen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- passen bij: Dat past niet bij jou.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'eso no pega contigo', 'PHRASE', 'Variante de passen: passen bij', 'Familia passen:
• passen — quedar bien (talla), caber; probarse (iets passen)
• passen bij — pegar con, combinar
• oppassen (sep.) — tener cuidado; hacer de canguro (de oppas)
• aanpassen (sep.) — adaptar, ajustar · zich aanpassen — adaptarse
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

passen bij = combinar/pegar con (ropa, colores, personas, planes).

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'eso no pega contigo' AND notes = 'Variante de passen: passen bij');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'eso no pega contigo' AND notes = 'Variante de passen: passen bij' LIMIT 1),
    'nl_NL', 'Dat past niet bij jou.', 'Dat past nit bei yau.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'eso no pega contigo' AND notes = 'Variante de passen: passen bij' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'eso no pega contigo' AND notes = 'Variante de passen: passen bij' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich aanpassen: Ik moet me nog aanpassen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'todavía me tengo que adaptar', 'PHRASE', 'Variante de passen: zich aanpassen', 'Familia passen:
• passen — quedar bien (talla), caber; probarse (iets passen)
• passen bij — pegar con, combinar
• oppassen (sep.) — tener cuidado; hacer de canguro (de oppas)
• aanpassen (sep.) — adaptar, ajustar · zich aanpassen — adaptarse
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

aanpassen = adaptar/ajustar; reflexivo (me/je/zich) para adaptarse uno mismo.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'todavía me tengo que adaptar' AND notes = 'Variante de passen: zich aanpassen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'todavía me tengo que adaptar' AND notes = 'Variante de passen: zich aanpassen' LIMIT 1),
    'nl_NL', 'Ik moet me nog aanpassen.', 'Ik mut me noj anpassen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'todavía me tengo que adaptar' AND notes = 'Variante de passen: zich aanpassen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'todavía me tengo que adaptar' AND notes = 'Variante de passen: zich aanpassen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- kijken: Even kijken.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'a ver…', 'PHRASE', 'Variante de kijken: kijken', 'Familia kijken:
• kijken (naar) — mirar (tv kijken = ver la tele)
• bekijken (insep.) — mirar con detalle, examinar
• uitkijken (sep.) — tener cuidado · uitkijken naar — esperar con ganas
• uitkijken op — dar a, tener vistas a
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

Muletilla universal: mientras piensas, buscas o miras algo.

📐 Frase hecha: orden fijo, se memoriza tal cual.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'a ver…' AND notes = 'Variante de kijken: kijken');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'a ver…' AND notes = 'Variante de kijken: kijken' LIMIT 1),
    'nl_NL', 'Even kijken.', 'Efen keiken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a ver…' AND notes = 'Variante de kijken: kijken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a ver…' AND notes = 'Variante de kijken: kijken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- bekijken: Ik bekijk het morgen rustig.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'lo miro mañana con calma', 'PHRASE', 'Variante de kijken: bekijken', 'Familia kijken:
• kijken (naar) — mirar (tv kijken = ver la tele)
• bekijken (insep.) — mirar con detalle, examinar
• uitkijken (sep.) — tener cuidado · uitkijken naar — esperar con ganas
• uitkijken op — dar a, tener vistas a
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

bekijken = examinar, mirar en detalle. Coloquial: Bekijk het maar! = ¡allá tú!

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'lo miro mañana con calma' AND notes = 'Variante de kijken: bekijken');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'lo miro mañana con calma' AND notes = 'Variante de kijken: bekijken' LIMIT 1),
    'nl_NL', 'Ik bekijk het morgen rustig.', 'Ik bekeik et morjen rustij.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'lo miro mañana con calma' AND notes = 'Variante de kijken: bekijken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'lo miro mañana con calma' AND notes = 'Variante de kijken: bekijken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- uitkijken: Kijk uit!
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡ojo! ¡cuidado!', 'PHRASE', 'Variante de kijken: uitkijken', 'Familia kijken:
• kijken (naar) — mirar (tv kijken = ver la tele)
• bekijken (insep.) — mirar con detalle, examinar
• uitkijken (sep.) — tener cuidado · uitkijken naar — esperar con ganas
• uitkijken op — dar a, tener vistas a
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

Como Pas op!. uitkijken op = tener vistas a: De kamer kijkt uit op zee.

📐 Imperativo: verbo en 1ª posición (forma de ik) + resto; sin sujeto. Si el verbo es separable, el prefijo va al final (Pas op! Geef niet op!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡ojo! ¡cuidado!' AND notes = 'Variante de kijken: uitkijken');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡ojo! ¡cuidado!' AND notes = 'Variante de kijken: uitkijken' LIMIT 1),
    'nl_NL', 'Kijk uit!', 'Keik aut!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡ojo! ¡cuidado!' AND notes = 'Variante de kijken: uitkijken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡ojo! ¡cuidado!' AND notes = 'Variante de kijken: uitkijken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- uitkijken naar: Ik kijk uit naar het weekend.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tengo muchas ganas del fin de semana', 'PHRASE', 'Variante de kijken: uitkijken naar', 'Familia kijken:
• kijken (naar) — mirar (tv kijken = ver la tele)
• bekijken (insep.) — mirar con detalle, examinar
• uitkijken (sep.) — tener cuidado · uitkijken naar — esperar con ganas
• uitkijken op — dar a, tener vistas a
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

uitkijken naar = esperar con ilusión. Cierre típico de email: Ik kijk ernaar uit!

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'tengo muchas ganas del fin de semana' AND notes = 'Variante de kijken: uitkijken naar');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'tengo muchas ganas del fin de semana' AND notes = 'Variante de kijken: uitkijken naar' LIMIT 1),
    'nl_NL', 'Ik kijk uit naar het weekend.', 'Ik keik aut nar et uekend.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tengo muchas ganas del fin de semana' AND notes = 'Variante de kijken: uitkijken naar' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tengo muchas ganas del fin de semana' AND notes = 'Variante de kijken: uitkijken naar' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- aankomen: Hoe laat kom je aan?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿a qué hora llegas?', 'PHRASE', 'Variante de komen: aankomen', 'Familia komen:
• komen — venir · aankomen (sep.) — llegar; ¡también engordar!
• terugkomen (sep.) — volver · tegenkomen (sep.) — encontrarse con (por azar)
• vóorkomen (sep.) — ocurrir, darse · voorkómen (insep.) — prevenir, evitar
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

aankomen = llegar… ¡y también engordar! (Ik ben aangekomen — el contexto decide).

📐 Pregunta con interrogativo (W-vraag): palabra-W (wat/waar/hoe/wie/wanneer/waarom…) + verbo conjugado + sujeto + resto; los demás verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿a qué hora llegas?' AND notes = 'Variante de komen: aankomen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿a qué hora llegas?' AND notes = 'Variante de komen: aankomen' LIMIT 1),
    'nl_NL', 'Hoe laat kom je aan?', 'U lat kom ye an?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿a qué hora llegas?' AND notes = 'Variante de komen: aankomen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿a qué hora llegas?' AND notes = 'Variante de komen: aankomen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- tegenkomen: Ik ben hem gisteren tegengekomen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me lo encontré ayer por casualidad', 'PHRASE', 'Variante de komen: tegenkomen', 'Familia komen:
• komen — venir · aankomen (sep.) — llegar; ¡también engordar!
• terugkomen (sep.) — volver · tegenkomen (sep.) — encontrarse con (por azar)
• vóorkomen (sep.) — ocurrir, darse · voorkómen (insep.) — prevenir, evitar
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

tegenkomen = cruzarse por azar (≠ ontmoeten = conocer/encontrarse quedando). Participio separable: tegen-ge-komen.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'me lo encontré ayer por casualidad' AND notes = 'Variante de komen: tegenkomen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'me lo encontré ayer por casualidad' AND notes = 'Variante de komen: tegenkomen' LIMIT 1),
    'nl_NL', 'Ik ben hem gisteren tegengekomen.', 'Ik ben em jisteren tejenjekomen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me lo encontré ayer por casualidad' AND notes = 'Variante de komen: tegenkomen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me lo encontré ayer por casualidad' AND notes = 'Variante de komen: tegenkomen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- voorkomen: Dat komt vaak voor.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'eso pasa a menudo', 'PHRASE', 'Variante de komen: voorkomen', 'Familia komen:
• komen — venir · aankomen (sep.) — llegar; ¡también engordar!
• terugkomen (sep.) — volver · tegenkomen (sep.) — encontrarse con (por azar)
• vóorkomen (sep.) — ocurrir, darse · voorkómen (insep.) — prevenir, evitar
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

VÓORkomen (sep.) = ocurrir · voorKÓMEN (insep.) = prevenir. Beter voorkomen dan genezen = más vale prevenir que curar.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'eso pasa a menudo' AND notes = 'Variante de komen: voorkomen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'eso pasa a menudo' AND notes = 'Variante de komen: voorkomen' LIMIT 1),
    'nl_NL', 'Dat komt vaak voor.', 'Dat komt fak for.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'eso pasa a menudo' AND notes = 'Variante de komen: voorkomen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'eso pasa a menudo' AND notes = 'Variante de komen: voorkomen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- staan (ropa): Die jas staat je goed.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'esa chaqueta te queda bien', 'PHRASE', 'Variante de staan: staan (ropa)', 'Familia staan:
• staan — estar (de pie, escrito) · staan + persona — quedar bien/mal (ropa)
• opstaan (sep.) — levantarse
• verstaan (insep.) — entender (oír bien) ≠ begrijpen/snappen (comprender)
• bestaan (insep.) — existir · bestaan uit — consistir en
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

staan + persona = quedar bien/mal de estilo (≠ passen = quedar de talla).

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'esa chaqueta te queda bien' AND notes = 'Variante de staan: staan (ropa)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'esa chaqueta te queda bien' AND notes = 'Variante de staan: staan (ropa)' LIMIT 1),
    'nl_NL', 'Die jas staat je goed.', 'Di yas stat ye jud.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'esa chaqueta te queda bien' AND notes = 'Variante de staan: staan (ropa)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'esa chaqueta te queda bien' AND notes = 'Variante de staan: staan (ropa)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- verstaan: Ik versta je niet.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no te entiendo (no te oigo bien)', 'PHRASE', 'Variante de staan: verstaan', 'Familia staan:
• staan — estar (de pie, escrito) · staan + persona — quedar bien/mal (ropa)
• opstaan (sep.) — levantarse
• verstaan (insep.) — entender (oír bien) ≠ begrijpen/snappen (comprender)
• bestaan (insep.) — existir · bestaan uit — consistir en
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

verstaan = entender acústicamente (teléfono, ruido); begrijpen/snappen = comprender la idea.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'no te entiendo (no te oigo bien)' AND notes = 'Variante de staan: verstaan');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'no te entiendo (no te oigo bien)' AND notes = 'Variante de staan: verstaan' LIMIT 1),
    'nl_NL', 'Ik versta je niet.', 'Ik fersta ye nit.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no te entiendo (no te oigo bien)' AND notes = 'Variante de staan: verstaan' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no te entiendo (no te oigo bien)' AND notes = 'Variante de staan: verstaan' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- opstaan: Ik sta om zeven uur op.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me levanto a las siete', 'PHRASE', 'Variante de staan: opstaan', 'Familia staan:
• staan — estar (de pie, escrito) · staan + persona — quedar bien/mal (ropa)
• opstaan (sep.) — levantarse
• verstaan (insep.) — entender (oír bien) ≠ begrijpen/snappen (comprender)
• bestaan (insep.) — existir · bestaan uit — consistir en
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

Separable: sta … op. Hoe laat sta je op?

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'me levanto a las siete' AND notes = 'Variante de staan: opstaan');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'me levanto a las siete' AND notes = 'Variante de staan: opstaan' LIMIT 1),
    'nl_NL', 'Ik sta om zeven uur op.', 'Ik sta om sefen ur op.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me levanto a las siete' AND notes = 'Variante de staan: opstaan' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me levanto a las siete' AND notes = 'Variante de staan: opstaan' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- bestaan: Dat bestaat niet!
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡no puede ser! ¡imposible!', 'PHRASE', 'Variante de staan: bestaan', 'Familia staan:
• staan — estar (de pie, escrito) · staan + persona — quedar bien/mal (ropa)
• opstaan (sep.) — levantarse
• verstaan (insep.) — entender (oír bien) ≠ begrijpen/snappen (comprender)
• bestaan (insep.) — existir · bestaan uit — consistir en
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

bestaan = existir · bestaan uit = consistir en. Como exclamación: ¡de eso nada!

📐 Frase hecha: orden fijo, se memoriza tal cual.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡no puede ser! ¡imposible!' AND notes = 'Variante de staan: bestaan');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡no puede ser! ¡imposible!' AND notes = 'Variante de staan: bestaan' LIMIT 1),
    'nl_NL', 'Dat bestaat niet!', 'Dat bestat nit!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡no puede ser! ¡imposible!' AND notes = 'Variante de staan: bestaan' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡no puede ser! ¡imposible!' AND notes = 'Variante de staan: bestaan' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- ophouden: Hou op!
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡para ya!', 'PHRASE', 'Variante de houden: ophouden', 'Familia houden:
• houden — quedarse (con algo), conservar · houden van — querer, gustar
• ophouden (met) (sep.) — parar, dejar de
• uithouden (sep.) — aguantar, soportar
• zich houden aan — atenerse a, cumplir (reglas, acuerdos)
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

Coloquial total. ophouden met = dejar de: Hou op met klagen (deja de quejarte).

📐 Imperativo: verbo en 1ª posición (forma de ik) + resto; sin sujeto. Si el verbo es separable, el prefijo va al final (Pas op! Geef niet op!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡para ya!' AND notes = 'Variante de houden: ophouden');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡para ya!' AND notes = 'Variante de houden: ophouden' LIMIT 1),
    'nl_NL', 'Hou op!', 'Au op!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡para ya!' AND notes = 'Variante de houden: ophouden' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡para ya!' AND notes = 'Variante de houden: ophouden' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- houden: Mag ik het houden?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿me lo puedo quedar?', 'PHRASE', 'Variante de houden: houden', 'Familia houden:
• houden — quedarse (con algo), conservar · houden van — querer, gustar
• ophouden (met) (sep.) — parar, dejar de
• uithouden (sep.) — aguantar, soportar
• zich houden aan — atenerse a, cumplir (reglas, acuerdos)
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

houden a secas = quedarse con algo, conservar. houden van = querer (Ik hou van je).

📐 Pregunta sí/no (ja/nee-vraag): verbo conjugado en 1ª posición + sujeto + resto; los demás verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿me lo puedo quedar?' AND notes = 'Variante de houden: houden');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿me lo puedo quedar?' AND notes = 'Variante de houden: houden' LIMIT 1),
    'nl_NL', 'Mag ik het houden?', 'Maj ik et auden?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿me lo puedo quedar?' AND notes = 'Variante de houden: houden' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿me lo puedo quedar?' AND notes = 'Variante de houden: houden' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- uithouden: Ik hou het niet meer uit.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ya no aguanto más', 'PHRASE', 'Variante de houden: uithouden', 'Familia houden:
• houden — quedarse (con algo), conservar · houden van — querer, gustar
• ophouden (met) (sep.) — parar, dejar de
• uithouden (sep.) — aguantar, soportar
• zich houden aan — atenerse a, cumplir (reglas, acuerdos)
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

uithouden = aguantar, soportar. Het is niet uit te houden = es insoportable.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'ya no aguanto más' AND notes = 'Variante de houden: uithouden');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ya no aguanto más' AND notes = 'Variante de houden: uithouden' LIMIT 1),
    'nl_NL', 'Ik hou het niet meer uit.', 'Ik au et nit mer aut.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ya no aguanto más' AND notes = 'Variante de houden: uithouden' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ya no aguanto más' AND notes = 'Variante de houden: uithouden' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- meenemen: Om mee te nemen, alstublieft.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'para llevar, por favor', 'PHRASE', 'Variante de nemen: meenemen', 'Familia nemen:
• nemen — tomar, coger
• meenemen (sep.) — llevarse (consigo)
• aannemen (sep.) — aceptar; suponer; contratar
• opnemen (sep.) — coger el teléfono; grabar; sacar dinero
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

La frase de cafetería/panadería. meenemen = llevarse consigo.

📐 Frase hecha: orden fijo, se memoriza tal cual.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'para llevar, por favor' AND notes = 'Variante de nemen: meenemen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'para llevar, por favor' AND notes = 'Variante de nemen: meenemen' LIMIT 1),
    'nl_NL', 'Om mee te nemen, alstublieft.', 'Om me te nemen, alstublift.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'para llevar, por favor' AND notes = 'Variante de nemen: meenemen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'para llevar, por favor' AND notes = 'Variante de nemen: meenemen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- opnemen: Ze neemt de telefoon niet op.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no coge el teléfono', 'PHRASE', 'Variante de nemen: opnemen', 'Familia nemen:
• nemen — tomar, coger
• meenemen (sep.) — llevarse (consigo)
• aannemen (sep.) — aceptar; suponer; contratar
• opnemen (sep.) — coger el teléfono; grabar; sacar dinero
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

opnemen = descolgar; también grabar (een video opnemen) y sacar dinero (geld opnemen).

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'no coge el teléfono' AND notes = 'Variante de nemen: opnemen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'no coge el teléfono' AND notes = 'Variante de nemen: opnemen' LIMIT 1),
    'nl_NL', 'Ze neemt de telefoon niet op.', 'Se nemt de telefon nit op.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no coge el teléfono' AND notes = 'Variante de nemen: opnemen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no coge el teléfono' AND notes = 'Variante de nemen: opnemen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- aannemen: Ik neem aan dat je komt.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'supongo que vienes', 'PHRASE', 'Variante de nemen: aannemen', 'Familia nemen:
• nemen — tomar, coger
• meenemen (sep.) — llevarse (consigo)
• aannemen (sep.) — aceptar; suponer; contratar
• opnemen (sep.) — coger el teléfono; grabar; sacar dinero
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

aannemen = suponer; también aceptar (una oferta) y contratar a alguien.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'supongo que vienes' AND notes = 'Variante de nemen: aannemen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'supongo que vienes' AND notes = 'Variante de nemen: aannemen' LIMIT 1),
    'nl_NL', 'Ik neem aan dat je komt.', 'Ik nem an dat ye komt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'supongo que vienes' AND notes = 'Variante de nemen: aannemen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'supongo que vienes' AND notes = 'Variante de nemen: aannemen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- afspreken: Zullen we morgen afspreken?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿quedamos mañana?', 'PHRASE', 'Variante de spreken: afspreken', 'Familia spreken:
• spreken — hablar
• afspreken (sep.) — quedar (cita); acordar (de afspraak = la cita)
• uitspreken (sep.) — pronunciar (de uitspraak = la pronunciación)
• aanspreken (sep.) — dirigirse a alguien; atraer/gustar
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

afspreken = quedar/acordar · de afspraak = la cita (médico incluido).

📐 Pregunta sí/no (ja/nee-vraag): verbo conjugado en 1ª posición + sujeto + resto; los demás verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿quedamos mañana?' AND notes = 'Variante de spreken: afspreken');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿quedamos mañana?' AND notes = 'Variante de spreken: afspreken' LIMIT 1),
    'nl_NL', 'Zullen we morgen afspreken?', 'Sullen ue morjen afspreken?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿quedamos mañana?' AND notes = 'Variante de spreken: afspreken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿quedamos mañana?' AND notes = 'Variante de spreken: afspreken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- uitspreken: Hoe spreek je dit uit?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿cómo se pronuncia esto?', 'PHRASE', 'Variante de spreken: uitspreken', 'Familia spreken:
• spreken — hablar
• afspreken (sep.) — quedar (cita); acordar (de afspraak = la cita)
• uitspreken (sep.) — pronunciar (de uitspraak = la pronunciación)
• aanspreken (sep.) — dirigirse a alguien; atraer/gustar
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

uitspreken = pronunciar · de uitspraak = la pronunciación. Separable: spreek … uit.

📐 Pregunta con interrogativo (W-vraag): palabra-W (wat/waar/hoe/wie/wanneer/waarom…) + verbo conjugado + sujeto + resto; los demás verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿cómo se pronuncia esto?' AND notes = 'Variante de spreken: uitspreken');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿cómo se pronuncia esto?' AND notes = 'Variante de spreken: uitspreken' LIMIT 1),
    'nl_NL', 'Hoe spreek je dit uit?', 'U sprek ye dit aut?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿cómo se pronuncia esto?' AND notes = 'Variante de spreken: uitspreken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿cómo se pronuncia esto?' AND notes = 'Variante de spreken: uitspreken' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- afspreken (participio): Afgesproken!
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡hecho! ¡quedamos así!', 'PHRASE', 'Variante de spreken: afspreken (participio)', 'Familia spreken:
• spreken — hablar
• afspreken (sep.) — quedar (cita); acordar (de afspraak = la cita)
• uitspreken (sep.) — pronunciar (de uitspraak = la pronunciación)
• aanspreken (sep.) — dirigirse a alguien; atraer/gustar
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

Cierra un plan o acuerdo. Participio separable: af-ge-sproken.

📐 Frase hecha: orden fijo, se memoriza tal cual.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡hecho! ¡quedamos así!' AND notes = 'Variante de spreken: afspreken (participio)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡hecho! ¡quedamos así!' AND notes = 'Variante de spreken: afspreken (participio)' LIMIT 1),
    'nl_NL', 'Afgesproken!', 'Afjesproken!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡hecho! ¡quedamos así!' AND notes = 'Variante de spreken: afspreken (participio)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡hecho! ¡quedamos así!' AND notes = 'Variante de spreken: afspreken (participio)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- opgeven: Geef niet op!
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡no te rindas!', 'PHRASE', 'Variante de geven: opgeven', 'Familia geven:
• geven — dar · weggeven (sep.) — regalar
• opgeven (sep.) — rendirse; apuntar(se) (zich opgeven voor)
• toegeven (sep.) — admitir, reconocer; ceder
• uitgeven (sep.) — gastar (dinero); publicar · aangeven (sep.) — indicar; declarar
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

opgeven = rendirse; también apuntar(se): zich opgeven voor een cursus.

📐 Imperativo: verbo en 1ª posición (forma de ik) + resto; sin sujeto. Si el verbo es separable, el prefijo va al final (Pas op! Geef niet op!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡no te rindas!' AND notes = 'Variante de geven: opgeven');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡no te rindas!' AND notes = 'Variante de geven: opgeven' LIMIT 1),
    'nl_NL', 'Geef niet op!', 'Jef nit op!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡no te rindas!' AND notes = 'Variante de geven: opgeven' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡no te rindas!' AND notes = 'Variante de geven: opgeven' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- toegeven: Ik moet toegeven dat je gelijk had.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tengo que admitir que tenías razón', 'PHRASE', 'Variante de geven: toegeven', 'Familia geven:
• geven — dar · weggeven (sep.) — regalar
• opgeven (sep.) — rendirse; apuntar(se) (zich opgeven voor)
• toegeven (sep.) — admitir, reconocer; ceder
• uitgeven (sep.) — gastar (dinero); publicar · aangeven (sep.) — indicar; declarar
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

toegeven = admitir/reconocer; también ceder. gelijk hebben = tener razón.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'tengo que admitir que tenías razón' AND notes = 'Variante de geven: toegeven');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'tengo que admitir que tenías razón' AND notes = 'Variante de geven: toegeven' LIMIT 1),
    'nl_NL', 'Ik moet toegeven dat je gelijk had.', 'Ik mut tujefen dat ye jeleik ad.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tengo que admitir que tenías razón' AND notes = 'Variante de geven: toegeven' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tengo que admitir que tenías razón' AND notes = 'Variante de geven: toegeven' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- uitgeven: Hij geeft veel geld uit.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'gasta mucho dinero', 'PHRASE', 'Variante de geven: uitgeven', 'Familia geven:
• geven — dar · weggeven (sep.) — regalar
• opgeven (sep.) — rendirse; apuntar(se) (zich opgeven voor)
• toegeven (sep.) — admitir, reconocer; ceder
• uitgeven (sep.) — gastar (dinero); publicar · aangeven (sep.) — indicar; declarar
sep. = separable: el prefijo se va al final (ik sta óp) y el participio lleva -ge- dentro (opgestaan) · insep. (be-/ver-): nunca se separa y el participio va sin ge- (bezorgd).

uitgeven = gastar dinero (¡no dar!); también publicar (de uitgever = la editorial).

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'gasta mucho dinero' AND notes = 'Variante de geven: uitgeven');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'gasta mucho dinero' AND notes = 'Variante de geven: uitgeven' LIMIT 1),
    'nl_NL', 'Hij geeft veel geld uit.', 'Ei jeft fel jeld aut.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'gasta mucho dinero' AND notes = 'Variante de geven: uitgeven' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'werkwoord-varianten'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'gasta mucho dinero' AND notes = 'Variante de geven: uitgeven' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
