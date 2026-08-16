-- Learn Languages App - Grupo "perfecto hebben/zijn - voltooide tijd"
-- Migration: 20260713000005-create-perfect-tense-hebben-zijn-group.sql
-- Description: 18 frases cotidianas en pretérito perfecto (voltooid tegenwoordige tijd)
--   para reforzar la elección del auxiliar HEBBEN vs ZIJN, con pronombres variados.
--   Incluye el par de contraste de movimiento con/sin destino (naar school gefietst = zijn
--   vs twee uur gefietst = hebben) y la postura estática staan/liggen/zitten (en nl_NL van
--   con HEBBEN; en Bélgica con zijn) frente a "gaan liggen" (zijn, por gaan).
--   rules_help = nota del verbo + regla hebben/zijn + fórmula + 🧭 ejemplo de situación.
--   Pronunciation con DutchToSpanishPhoneticService. 100% aditiva e IDEMPOTENTE
--   (INSERT ... WHERE NOT EXISTS / OR IGNORE): no toca audios ni imágenes existentes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'perfecto hebben/zijn - voltooide tijd',
    'Pretérito perfecto (voltooid tegenwoordige tijd) reforzando cuándo se usa el auxiliar hebben y cuándo zijn, con frases cotidianas y pronombres variados: transitivos/acciones (hebben), cambio de lugar o estado (zijn), movimiento con o sin destino, y postura estática staan/liggen/zitten',
    'migracion'
);

-- ==============================================================================
-- kopen (hebben): Ik heb een boek gekocht.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'he comprado un libro', 'PHRASE', 'Perfecto: kopen (hebben)', 'kopen = comprar, transitivo (lleva objeto: een boek) → HEBBEN. Participio irregular: gekocht.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + participio al final.

🧭 Cuándo usarlo: contar una compra reciente. Ej.: enseñas algo nuevo → Kijk, ik heb een boek gekocht! (mira, ¡me he comprado un libro!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'he comprado un libro' AND notes = 'Perfecto: kopen (hebben)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'he comprado un libro' AND notes = 'Perfecto: kopen (hebben)' LIMIT 1),
    'nl_NL', 'Ik heb een boek gekocht.', 'Ik eb en buk jekojt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'he comprado un libro' AND notes = 'Perfecto: kopen (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'he comprado un libro' AND notes = 'Perfecto: kopen (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- werken (hebben): Zij heeft de hele dag gewerkt.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ella ha trabajado todo el día', 'PHRASE', 'Perfecto: werken (hebben)', 'werken = trabajar, acción sin cambio de lugar → HEBBEN. Participio gewerkt.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + participio al final.

🧭 Cuándo usarlo: justificar el cansancio de alguien. Ej.: → Ze is moe, ze heeft de hele dag gewerkt (está cansada, ha trabajado todo el día).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ella ha trabajado todo el día' AND notes = 'Perfecto: werken (hebben)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ella ha trabajado todo el día' AND notes = 'Perfecto: werken (hebben)' LIMIT 1),
    'nl_NL', 'Zij heeft de hele dag gewerkt.', 'Sei eft de ele daj jeuerkt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ella ha trabajado todo el día' AND notes = 'Perfecto: werken (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ella ha trabajado todo el día' AND notes = 'Perfecto: werken (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- eten (hebben): We hebben lekker gegeten.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hemos comido genial', 'PHRASE', 'Perfecto: eten (hebben)', 'eten = comer → HEBBEN. Participio gegeten. lekker = rico/genial.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + participio al final.

🧭 Cuándo usarlo: al salir de un restaurante o casa ajena. Ej.: → We hebben lekker gegeten, bedankt! (hemos comido genial, ¡gracias!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hemos comido genial' AND notes = 'Perfecto: eten (hebben)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'hemos comido genial' AND notes = 'Perfecto: eten (hebben)' LIMIT 1),
    'nl_NL', 'We hebben lekker gegeten.', 'Ue ebben lekker jejeten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hemos comido genial' AND notes = 'Perfecto: eten (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hemos comido genial' AND notes = 'Perfecto: eten (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zien (hebben, pregunta): Hebben jullie de film al gezien?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿ya habéis visto la peli?', 'PHRASE', 'Perfecto: zien (hebben)', 'zien = ver, transitivo → HEBBEN. Participio gezien. En pregunta, el auxiliar va delante.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto en pregunta sí/no: hebben/zijn en 1ª posición + sujeto + resto + participio al final.

🧭 Cuándo usarlo: preguntar o recomendar una peli. Ej.: → Hebben jullie de nieuwe film al gezien? (¿ya habéis visto la nueva peli?).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿ya habéis visto la peli?' AND notes = 'Perfecto: zien (hebben)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿ya habéis visto la peli?' AND notes = 'Perfecto: zien (hebben)' LIMIT 1),
    'nl_NL', 'Hebben jullie de film al gezien?', 'Ebben yulli de film al jesin?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿ya habéis visto la peli?' AND notes = 'Perfecto: zien (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿ya habéis visto la peli?' AND notes = 'Perfecto: zien (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- verkopen (hebben): Ze hebben hun huis verkocht.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'han vendido su casa', 'PHRASE', 'Perfecto: verkopen (hebben)', 'verkopen = vender, transitivo → HEBBEN. Participio verkocht (insep. ver-: sin ge-).

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + participio al final.

🧭 Cuándo usarlo: dar una noticia. Ej.: → Ze hebben hun huis verkocht en gaan verhuizen (han vendido su casa y se mudan).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'han vendido su casa' AND notes = 'Perfecto: verkopen (hebben)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'han vendido su casa' AND notes = 'Perfecto: verkopen (hebben)' LIMIT 1),
    'nl_NL', 'Ze hebben hun huis verkocht.', 'Se ebben un aus ferkojt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'han vendido su casa' AND notes = 'Perfecto: verkopen (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'han vendido su casa' AND notes = 'Perfecto: verkopen (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- slapen (hebben, formal pregunta): Heeft u goed geslapen?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿ha dormido bien usted?', 'PHRASE', 'Perfecto: slapen (hebben)', 'slapen = dormir → HEBBEN. Participio geslapen. u = trato formal.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto en pregunta sí/no (formal): hebben/zijn en 1ª posición + u + resto + participio al final.

🧭 Cuándo usarlo: en un hotel o de anfitrión, por la mañana. Ej.: → Goedemorgen, heeft u goed geslapen? (buenos días, ¿ha dormido bien?).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿ha dormido bien usted?' AND notes = 'Perfecto: slapen (hebben)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿ha dormido bien usted?' AND notes = 'Perfecto: slapen (hebben)' LIMIT 1),
    'nl_NL', 'Heeft u goed geslapen?', 'Eft u jud jeslapen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿ha dormido bien usted?' AND notes = 'Perfecto: slapen (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿ha dormido bien usted?' AND notes = 'Perfecto: slapen (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- tegenkomen (zijn): Ik ben hem gisteren tegengekomen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ayer me lo encontré por la calle', 'PHRASE', 'Perfecto: tegenkomen (zijn)', 'tegenkomen = cruzarse con (familia komen, cambio de lugar) → ZIJN. Participio separable tegen-ge-komen. Es el ejemplo estrella del contraste con hebben.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + participio al final.

🧭 Cuándo usarlo: contar un encuentro casual. Ej.: → Raad eens: ik ben Jan gisteren tegengekomen! (¿a que no sabes? ¡me crucé con Jan ayer!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ayer me lo encontré por la calle' AND notes = 'Perfecto: tegenkomen (zijn)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ayer me lo encontré por la calle' AND notes = 'Perfecto: tegenkomen (zijn)' LIMIT 1),
    'nl_NL', 'Ik ben hem gisteren tegengekomen.', 'Ik ben em jisteren tejenjekomen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ayer me lo encontré por la calle' AND notes = 'Perfecto: tegenkomen (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ayer me lo encontré por la calle' AND notes = 'Perfecto: tegenkomen (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- gaan (zijn): Hij is naar huis gegaan.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'se ha ido a casa', 'PHRASE', 'Perfecto: gaan (zijn)', 'gaan = ir, cambio de lugar puro → ZIJN. Participio gegaan.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + participio al final.

🧭 Cuándo usarlo: explicar dónde está o por qué se fue alguien. Ej.: → Hij was moe, hij is naar huis gegaan (estaba cansado, se ha ido a casa).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'se ha ido a casa' AND notes = 'Perfecto: gaan (zijn)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'se ha ido a casa' AND notes = 'Perfecto: gaan (zijn)' LIMIT 1),
    'nl_NL', 'Hij is naar huis gegaan.', 'Ei is nar aus jejan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se ha ido a casa' AND notes = 'Perfecto: gaan (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se ha ido a casa' AND notes = 'Perfecto: gaan (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- komen (zijn): Jij bent te laat gekomen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'has llegado tarde', 'PHRASE', 'Perfecto: komen (zijn)', 'komen = venir/llegar, cambio de lugar → ZIJN. Participio gekomen.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + participio al final.

🧭 Cuándo usarlo: reproche suave por la hora. Ej.: → Jij bent alweer te laat gekomen! (¡has vuelto a llegar tarde!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'has llegado tarde' AND notes = 'Perfecto: komen (zijn)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'has llegado tarde' AND notes = 'Perfecto: komen (zijn)' LIMIT 1),
    'nl_NL', 'Jij bent te laat gekomen.', 'Yei bent te lat jekomen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'has llegado tarde' AND notes = 'Perfecto: komen (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'has llegado tarde' AND notes = 'Perfecto: komen (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- vallen (zijn): De vaas is gevallen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el jarrón se ha caído', 'PHRASE', 'Perfecto: vallen (zijn)', 'vallen = caer, cambio de estado/posición → ZIJN. Participio gevallen.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + participio al final.

🧭 Cuándo usarlo: explicar un ruido o un accidente. Ej.: → Oeps, de vaas is gevallen! (uy, ¡se ha caído el jarrón!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el jarrón se ha caído' AND notes = 'Perfecto: vallen (zijn)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'el jarrón se ha caído' AND notes = 'Perfecto: vallen (zijn)' LIMIT 1),
    'nl_NL', 'De vaas is gevallen.', 'De fas is jefallen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el jarrón se ha caído' AND notes = 'Perfecto: vallen (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el jarrón se ha caído' AND notes = 'Perfecto: vallen (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zijn/geweest (zijn): We zijn in Amsterdam geweest.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hemos estado en Ámsterdam', 'PHRASE', 'Perfecto: zijn/geweest (zijn)', 'El propio verbo zijn (ser/estar) forma su perfecto con ZIJN. Participio geweest. "haber estado en un sitio".

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + participio al final.

🧭 Cuándo usarlo: contar un viaje o una visita. Ej.: → Vorige week zijn we in Amsterdam geweest (la semana pasada estuvimos en Ámsterdam).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hemos estado en Ámsterdam' AND notes = 'Perfecto: zijn/geweest (zijn)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'hemos estado en Ámsterdam' AND notes = 'Perfecto: zijn/geweest (zijn)' LIMIT 1),
    'nl_NL', 'We zijn in Amsterdam geweest.', 'Ue sein in Amsterdam jeuest.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hemos estado en Ámsterdam' AND notes = 'Perfecto: zijn/geweest (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hemos estado en Ámsterdam' AND notes = 'Perfecto: zijn/geweest (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- gebeuren (zijn, W-vraag): Wat is er gebeurd?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿qué ha pasado?', 'PHRASE', 'Perfecto: gebeuren (zijn)', 'gebeuren = ocurrir, cambio de estado → ZIJN. Participio gebeurd. La pregunta clave ante un problema.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto en pregunta con interrogativo (W-vraag): palabra-W + hebben/zijn + sujeto + participio al final.

🧭 Cuándo usarlo: llegar y ver algo raro o preocupante. Ej.: → Wat is er gebeurd? (¿qué ha pasado?).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿qué ha pasado?' AND notes = 'Perfecto: gebeuren (zijn)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿qué ha pasado?' AND notes = 'Perfecto: gebeuren (zijn)' LIMIT 1),
    'nl_NL', 'Wat is er gebeurd?', 'Uat is er jeberd?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿qué ha pasado?' AND notes = 'Perfecto: gebeuren (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿qué ha pasado?' AND notes = 'Perfecto: gebeuren (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- worden (zijn): Ze is dokter geworden.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'se ha hecho médica', 'PHRASE', 'Perfecto: worden (zijn)', 'worden = llegar a ser/volverse, cambio de estado → ZIJN. Participio geworden.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + participio al final.

🧭 Cuándo usarlo: dar una noticia sobre la vida de alguien. Ej.: → Onze dochter is dokter geworden! (¡nuestra hija se ha hecho médica!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'se ha hecho médica' AND notes = 'Perfecto: worden (zijn)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'se ha hecho médica' AND notes = 'Perfecto: worden (zijn)' LIMIT 1),
    'nl_NL', 'Ze is dokter geworden.', 'Se is dokter jeuorden.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se ha hecho médica' AND notes = 'Perfecto: worden (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se ha hecho médica' AND notes = 'Perfecto: worden (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- fietsen con destino (zijn): Ik ben naar school gefietst.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'he ido en bici al cole', 'PHRASE', 'Perfecto: fietsen con destino (zijn)', 'fietsen = ir en bici. CON destino (naar school) hay cambio de lugar → ZIJN. Participio gefietst. Compara con "Ik heb twee uur gefietst" (sin destino → hebben).

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + participio al final.

🧭 Cuándo usarlo: contar cómo te desplazaste. Ej.: → Ik ben vanmorgen naar school gefietst (esta mañana he ido en bici al cole).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'he ido en bici al cole' AND notes = 'Perfecto: fietsen con destino (zijn)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'he ido en bici al cole' AND notes = 'Perfecto: fietsen con destino (zijn)' LIMIT 1),
    'nl_NL', 'Ik ben naar school gefietst.', 'Ik ben nar sjol jefitst.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'he ido en bici al cole' AND notes = 'Perfecto: fietsen con destino (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'he ido en bici al cole' AND notes = 'Perfecto: fietsen con destino (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- fietsen actividad (hebben): Ik heb twee uur gefietst.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'he montado en bici dos horas', 'PHRASE', 'Perfecto: fietsen actividad (hebben)', 'MISMO verbo que arriba, pero SIN destino (solo la actividad, cuánto tiempo) → HEBBEN. Contrasta con "Ik ben naar school gefietst" (con destino → zijn). Esta pareja es la clave del movimiento.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + participio al final.

🧭 Cuándo usarlo: hablar de ejercicio o deporte hecho. Ej.: → Ik ben moe, ik heb twee uur gefietst (estoy cansado, he montado dos horas en bici).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'he montado en bici dos horas' AND notes = 'Perfecto: fietsen actividad (hebben)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'he montado en bici dos horas' AND notes = 'Perfecto: fietsen actividad (hebben)' LIMIT 1),
    'nl_NL', 'Ik heb twee uur gefietst.', 'Ik eb tue ur jefitst.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'he montado en bici dos horas' AND notes = 'Perfecto: fietsen actividad (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'he montado en bici dos horas' AND notes = 'Perfecto: fietsen actividad (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- liggen (hebben): Ik heb de hele nacht wakker gelegen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'he pasado la noche en vela', 'PHRASE', 'Perfecto: liggen (hebben)', 'liggen = estar tumbado (postura estática, sin cambio) → HEBBEN en nl_NL (en Bélgica: zijn). Participio gelegen. wakker liggen = estar despierto en la cama.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + participio al final.

🧭 Cuándo usarlo: quejarte de una mala noche. Ej.: → Ik ben kapot, ik heb de hele nacht wakker gelegen (estoy hecho polvo, he pasado la noche en vela).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'he pasado la noche en vela' AND notes = 'Perfecto: liggen (hebben)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'he pasado la noche en vela' AND notes = 'Perfecto: liggen (hebben)' LIMIT 1),
    'nl_NL', 'Ik heb de hele nacht wakker gelegen.', 'Ik eb de ele najt uakker jelejen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'he pasado la noche en vela' AND notes = 'Perfecto: liggen (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'he pasado la noche en vela' AND notes = 'Perfecto: liggen (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- staan (hebben): We hebben uren in de file gestaan.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hemos estado horas en el atasco', 'PHRASE', 'Perfecto: staan (hebben)', 'staan = estar de pie/parado (postura estática) → HEBBEN en nl_NL (en Bélgica: zijn). Participio gestaan. in de file staan = estar en un atasco.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + participio al final.

🧭 Cuándo usarlo: explicar un retraso. Ej.: → Sorry dat we laat zijn, we hebben uren in de file gestaan (perdón por el retraso, hemos estado horas en el atasco).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hemos estado horas en el atasco' AND notes = 'Perfecto: staan (hebben)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'hemos estado horas en el atasco' AND notes = 'Perfecto: staan (hebben)' LIMIT 1),
    'nl_NL', 'We hebben uren in de file gestaan.', 'Ue ebben uren in de file jestan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hemos estado horas en el atasco' AND notes = 'Perfecto: staan (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hemos estado horas en el atasco' AND notes = 'Perfecto: staan (hebben)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- gaan liggen (zijn): Ik ben even gaan liggen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me he echado un rato', 'PHRASE', 'Perfecto: gaan liggen (zijn)', 'OJO al contraste: liggen a secas → hebben, pero GAAN liggen (tumbarse, ir a la posición) → ZIJN por gaan. Doble infinitivo: gaan liggen (no gegaan). Igual: gaan zitten, gaan staan.

hebben o zijn (elección del auxiliar):
• hebben — la mayoría: acciones y transitivos (con objeto): kopen, eten, zien, werken…
• zijn — cambio de lugar o estado: gaan, komen, worden, vallen, blijven, gebeuren…
• Movimiento (fietsen/lopen/zwemmen): zijn con destino (naar…), hebben si es solo la actividad.
• Postura estática (staan/liggen/zitten): en nl_NL → hebben; en Bélgica → zijn.

📐 Perfecto (hoofdzin): sujeto + hebben/zijn (2ª posición) + resto + doble infinitivo al final (gaan liggen).

🧭 Cuándo usarlo: decir que descansaste un rato. Ej.: → Ik voelde me niet lekker, dus ik ben even gaan liggen (no me encontraba bien, así que me he echado un rato).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'me he echado un rato' AND notes = 'Perfecto: gaan liggen (zijn)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'me he echado un rato' AND notes = 'Perfecto: gaan liggen (zijn)' LIMIT 1),
    'nl_NL', 'Ik ben even gaan liggen.', 'Ik ben efen jan lijjen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me he echado un rato' AND notes = 'Perfecto: gaan liggen (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'perfecto hebben/zijn - voltooide tijd'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me he echado un rato' AND notes = 'Perfecto: gaan liggen (zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
