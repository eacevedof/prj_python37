-- Learn Languages App - Anade veranderen, wisselen, verwisselen y omzetten al grupo de palabras dificiles
-- Migration: 20260827000001-create-cambiar-family-hard-words-group.sql
-- Description: Anade los cuatro "cambiar" del neerlandes al grupo 28: veranderen (cambiar en
--   general), wisselen (cambiar/alternar entre equivalentes: turnos, divisas, sitio),
--   verwisselen (sustituir una cosa por otra igual, o confundirlas) y omzetten (convertir,
--   transformar de una forma/unidad a otra). Cada una con rules_help, 5 frases de ejemplo en
--   notes y 2 promovidas a tarjetas SENTENCE entrenables.
--   La tabla comparativa + la regla de bolsillo es un bloque IDENTICO repetido en las 4
--   tarjetas (misma teoria, no reescrita).
--   100% aditiva e idempotente: solo INSERT (NOT EXISTS / OR IGNORE).

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- veranderen
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cambiar (en general, volverse distinto)', 'WORD', 'dificil: veranderen (cambiar, en general)', 'veranderen = cambiar, en general: algo se vuelve distinto. Verbo debil (regular): verandert, veranderde, veranderd. Puede ser intransitivo (algo cambia solo: zijn en el perfecto) o transitivo (cambias algo tu: hebben en el perfecto).
📐 Conjugacion: presente — ik verander · jij/hij verandert · wij/jullie/zij veranderen. pasado — ik/jij/hij veranderde · wij/jullie/zij veranderden. participio — veranderd (is veranderd si es un cambio de estado — Het weer is veranderd; heeft veranderd si cambias algo tu — Ik heb mijn mening veranderd).

🗺️ Los cuatro «cambiar» — no son intercambiables:

| neerlandes | que cambia | ejemplo |
|---|---|---|
| **veranderen** | cambiar, en general (un estado, una opinion, algo se vuelve distinto) | Het weer verandert. — El tiempo cambia. |
| **wisselen** | cambiar/alternar entre dos cosas equivalentes (turnos, sitio, divisas) | Euro''s wisselen voor dollars. — Cambiar euros por dolares. |
| **verwisselen** | cambiar una cosa POR otra igual (sustituir) o confundir dos cosas entre si | De sleutels verwisselen. — Confundir/cambiar las llaves. |
| **omzetten** | convertir, transformar de una forma/unidad/formato a otra | Graden omzetten naar Fahrenheit. — Convertir grados a Fahrenheit. |

📌 Regla de bolsillo:
• ¿Algo se vuelve distinto, sin mas? → veranderen.
• ¿Intercambias/alternas entre dos cosas del mismo tipo (dinero, turno, sitio)? → wisselen.
• ¿Sustituyes una cosa por otra igual, o las confundes? → verwisselen.
• ¿Transformas de un formato/unidad/moneda a otro? → omzetten.

⚠️ La trampa: wisselen y verwisselen se parecen mucho — wisselen es neutro (cambiar/alternar sin mas), verwisselen anade la idea de sustitucion 1x1 o de CONFUNDIR (por error). Bij het wisselen van de wacht (el cambio de guardia) usa wisselen porque es un turno regular, no un error.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'cambiar (en general, volverse distinto)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'cambiar (en general, volverse distinto)' LIMIT 1),
    'nl_NL', 'veranderen', 'feranderen',
    '• [can.] Het weer verandert elke dag. — El tiempo cambia cada día.
• [perf.] Ze is helemaal veranderd sinds de verhuizing. — Ha cambiado por completo desde la mudanza.
• [perf.] Ik heb mijn mening veranderd. — He cambiado de opinión.
• [inv.] Zodra de wet verandert, moeten we ons aanpassen. — En cuanto cambie la ley, tenemos que adaptarnos.
• [vraag] Waarom verander je steeds van gedachten? — ¿Por qué cambias de idea constantemente?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cambiar (en general, volverse distinto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cambiar (en general, volverse distinto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes)
SELECT 'El tiempo cambia cada día.', 'SENTENCE', 'Ejemplo de "veranderen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El tiempo cambia cada día.' AND notes = 'Ejemplo de "veranderen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El tiempo cambia cada día.' AND notes = 'Ejemplo de "veranderen" (can.)' LIMIT 1),
    'nl_NL', 'Het weer verandert elke dag.', 'Et uer ferandert elke daj.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El tiempo cambia cada día.' AND notes = 'Ejemplo de "veranderen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El tiempo cambia cada día.' AND notes = 'Ejemplo de "veranderen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'cambiar (en general, volverse distinto)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'El tiempo cambia cada día.' AND notes = 'Ejemplo de "veranderen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'He cambiado de opinión.', 'SENTENCE', 'Ejemplo de "veranderen" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'He cambiado de opinión.' AND notes = 'Ejemplo de "veranderen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'He cambiado de opinión.' AND notes = 'Ejemplo de "veranderen" (perf.)' LIMIT 1),
    'nl_NL', 'Ik heb mijn mening veranderd.', 'Ik ep mein mening ferandert.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He cambiado de opinión.' AND notes = 'Ejemplo de "veranderen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He cambiado de opinión.' AND notes = 'Ejemplo de "veranderen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'cambiar (en general, volverse distinto)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'He cambiado de opinión.' AND notes = 'Ejemplo de "veranderen" (perf.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- wisselen
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cambiar, alternar (turnos, dinero, lugar)', 'WORD', 'dificil: wisselen (cambiar/alternar entre equivalentes)', 'wisselen = cambiar o alternar entre dos cosas del mismo tipo: turnos, divisas, sitio. Verbo debil (regular): wisselt, wisselde, gewisseld.
📐 Conjugacion: presente — ik wissel · jij/hij wisselt · wij/jullie/zij wisselen. pasado — ik/jij/hij wisselde · wij/jullie/zij wisselden. participio — gewisseld (heeft gewisseld).

🗺️ Los cuatro «cambiar» — no son intercambiables:

| neerlandes | que cambia | ejemplo |
|---|---|---|
| **veranderen** | cambiar, en general (un estado, una opinion, algo se vuelve distinto) | Het weer verandert. — El tiempo cambia. |
| **wisselen** | cambiar/alternar entre dos cosas equivalentes (turnos, sitio, divisas) | Euro''s wisselen voor dollars. — Cambiar euros por dolares. |
| **verwisselen** | cambiar una cosa POR otra igual (sustituir) o confundir dos cosas entre si | De sleutels verwisselen. — Confundir/cambiar las llaves. |
| **omzetten** | convertir, transformar de una forma/unidad/formato a otra | Graden omzetten naar Fahrenheit. — Convertir grados a Fahrenheit. |

📌 Regla de bolsillo:
• ¿Algo se vuelve distinto, sin mas? → veranderen.
• ¿Intercambias/alternas entre dos cosas del mismo tipo (dinero, turno, sitio)? → wisselen.
• ¿Sustituyes una cosa por otra igual, o las confundes? → verwisselen.
• ¿Transformas de un formato/unidad/moneda a otro? → omzetten.

⚠️ La trampa: wisselen y verwisselen se parecen mucho — wisselen es neutro (cambiar/alternar sin mas), verwisselen anade la idea de sustitucion 1x1 o de CONFUNDIR (por error). Bij het wisselen van de wacht (el cambio de guardia) usa wisselen porque es un turno regular, no un error.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'cambiar, alternar (turnos, dinero, lugar)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'cambiar, alternar (turnos, dinero, lugar)' LIMIT 1),
    'nl_NL', 'wisselen', 'wisselen',
    '• [can.] Kun je hier euro''s wisselen voor dollars? — ¿Puedes cambiar aquí euros por dólares?
• [perf.] We hebben van plaats gewisseld tijdens de pauze. — Cambiamos de sitio durante el descanso.
• [can.] Ze wisselen om de beurt van chauffeur. — Se turnan para conducir.
• [inv.] Zodra ze van baan wisselt, verhuist ze naar een andere stad. — En cuanto cambie de trabajo, se muda a otra ciudad.
• [vraag] Waar kan ik geld wisselen? — ¿Dónde puedo cambiar dinero?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cambiar, alternar (turnos, dinero, lugar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cambiar, alternar (turnos, dinero, lugar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes)
SELECT '¿Puedes cambiar aquí euros por dólares?', 'SENTENCE', 'Ejemplo de "wisselen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Puedes cambiar aquí euros por dólares?' AND notes = 'Ejemplo de "wisselen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Puedes cambiar aquí euros por dólares?' AND notes = 'Ejemplo de "wisselen" (can.)' LIMIT 1),
    'nl_NL', 'Kun je hier euro''s wisselen voor dollars?', 'Kun ye hir eurus wisselen for dollars?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Puedes cambiar aquí euros por dólares?' AND notes = 'Ejemplo de "wisselen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Puedes cambiar aquí euros por dólares?' AND notes = 'Ejemplo de "wisselen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'cambiar, alternar (turnos, dinero, lugar)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = '¿Puedes cambiar aquí euros por dólares?' AND notes = 'Ejemplo de "wisselen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Cambiamos de sitio durante el descanso.', 'SENTENCE', 'Ejemplo de "wisselen" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cambiamos de sitio durante el descanso.' AND notes = 'Ejemplo de "wisselen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cambiamos de sitio durante el descanso.' AND notes = 'Ejemplo de "wisselen" (perf.)' LIMIT 1),
    'nl_NL', 'We hebben van plaats gewisseld tijdens de pauze.', 'Ue eben fan plats jewisselt teidens de pauze.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cambiamos de sitio durante el descanso.' AND notes = 'Ejemplo de "wisselen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cambiamos de sitio durante el descanso.' AND notes = 'Ejemplo de "wisselen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'cambiar, alternar (turnos, dinero, lugar)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Cambiamos de sitio durante el descanso.' AND notes = 'Ejemplo de "wisselen" (perf.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- verwisselen
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'confundir, cambiar una cosa por otra (sustituir)', 'WORD', 'dificil: verwisselen (confundir/sustituir 1x1), inseparable', 'verwisselen = cambiar una cosa POR otra igual (sustituir) o confundir dos cosas entre si por error. Verbo debil pero con prefijo INSEPARABLE ver-: no lleva ge- en el participio.
📐 Conjugacion: presente — ik verwissel · jij/hij verwisselt · wij/jullie/zij verwisselen. pasado — ik/jij/hij verwisselde · wij/jullie/zij verwisselden. participio — verwisseld (heeft verwisseld, sin ge-).

🗺️ Los cuatro «cambiar» — no son intercambiables:

| neerlandes | que cambia | ejemplo |
|---|---|---|
| **veranderen** | cambiar, en general (un estado, una opinion, algo se vuelve distinto) | Het weer verandert. — El tiempo cambia. |
| **wisselen** | cambiar/alternar entre dos cosas equivalentes (turnos, sitio, divisas) | Euro''s wisselen voor dollars. — Cambiar euros por dolares. |
| **verwisselen** | cambiar una cosa POR otra igual (sustituir) o confundir dos cosas entre si | De sleutels verwisselen. — Confundir/cambiar las llaves. |
| **omzetten** | convertir, transformar de una forma/unidad/formato a otra | Graden omzetten naar Fahrenheit. — Convertir grados a Fahrenheit. |

📌 Regla de bolsillo:
• ¿Algo se vuelve distinto, sin mas? → veranderen.
• ¿Intercambias/alternas entre dos cosas del mismo tipo (dinero, turno, sitio)? → wisselen.
• ¿Sustituyes una cosa por otra igual, o las confundes? → verwisselen.
• ¿Transformas de un formato/unidad/moneda a otro? → omzetten.

⚠️ La trampa: wisselen y verwisselen se parecen mucho — wisselen es neutro (cambiar/alternar sin mas), verwisselen anade la idea de sustitucion 1x1 o de CONFUNDIR (por error). Bij het wisselen van de wacht (el cambio de guardia) usa wisselen porque es un turno regular, no un error.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'confundir, cambiar una cosa por otra (sustituir)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'confundir, cambiar una cosa por otra (sustituir)' LIMIT 1),
    'nl_NL', 'verwisselen', 'ferwisselen',
    '• [can.] Ik verwissel steeds hun namen. — Siempre confundo sus nombres.
• [perf.] Hij heeft de sleutels verwisseld. — Ha confundido/cambiado las llaves.
• [can.] Kun je de lamp even verwisselen? — ¿Puedes cambiar la bombilla un momento?
• [inv.] Zodra je de banden hebt verwisseld, kun je weer rijden. — En cuanto hayas cambiado los neumáticos, puedes volver a conducir.
• [vraag] Heb je per ongeluk de tassen verwisseld? — ¿Has confundido las bolsas sin querer?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'confundir, cambiar una cosa por otra (sustituir)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'confundir, cambiar una cosa por otra (sustituir)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes)
SELECT 'Siempre confundo sus nombres.', 'SENTENCE', 'Ejemplo de "verwisselen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Siempre confundo sus nombres.' AND notes = 'Ejemplo de "verwisselen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Siempre confundo sus nombres.' AND notes = 'Ejemplo de "verwisselen" (can.)' LIMIT 1),
    'nl_NL', 'Ik verwissel steeds hun namen.', 'Ik ferwissel stets hun namen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Siempre confundo sus nombres.' AND notes = 'Ejemplo de "verwisselen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Siempre confundo sus nombres.' AND notes = 'Ejemplo de "verwisselen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'confundir, cambiar una cosa por otra (sustituir)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Siempre confundo sus nombres.' AND notes = 'Ejemplo de "verwisselen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Ha confundido/cambiado las llaves.', 'SENTENCE', 'Ejemplo de "verwisselen" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ha confundido/cambiado las llaves.' AND notes = 'Ejemplo de "verwisselen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha confundido/cambiado las llaves.' AND notes = 'Ejemplo de "verwisselen" (perf.)' LIMIT 1),
    'nl_NL', 'Hij heeft de sleutels verwisseld.', 'Ei eft de sleutels ferwisselt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha confundido/cambiado las llaves.' AND notes = 'Ejemplo de "verwisselen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha confundido/cambiado las llaves.' AND notes = 'Ejemplo de "verwisselen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'confundir, cambiar una cosa por otra (sustituir)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Ha confundido/cambiado las llaves.' AND notes = 'Ejemplo de "verwisselen" (perf.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- omzetten
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'convertir, transformar (de una forma o unidad a otra)', 'WORD', 'dificil: omzetten (convertir, transformar)', 'omzetten = convertir, transformar algo de una forma, unidad o formato a otra. Separable y debil: zet … om, zette … om, heeft … omgezet.
📐 Conjugacion: presente — ik zet om · jij/hij zet om · wij/jullie/zij zetten om. pasado — ik/jij/hij zette om · wij/jullie/zij zetten om. participio — omgezet (heeft omgezet).

🗺️ Los cuatro «cambiar» — no son intercambiables:

| neerlandes | que cambia | ejemplo |
|---|---|---|
| **veranderen** | cambiar, en general (un estado, una opinion, algo se vuelve distinto) | Het weer verandert. — El tiempo cambia. |
| **wisselen** | cambiar/alternar entre dos cosas equivalentes (turnos, sitio, divisas) | Euro''s wisselen voor dollars. — Cambiar euros por dolares. |
| **verwisselen** | cambiar una cosa POR otra igual (sustituir) o confundir dos cosas entre si | De sleutels verwisselen. — Confundir/cambiar las llaves. |
| **omzetten** | convertir, transformar de una forma/unidad/formato a otra | Graden omzetten naar Fahrenheit. — Convertir grados a Fahrenheit. |

📌 Regla de bolsillo:
• ¿Algo se vuelve distinto, sin mas? → veranderen.
• ¿Intercambias/alternas entre dos cosas del mismo tipo (dinero, turno, sitio)? → wisselen.
• ¿Sustituyes una cosa por otra igual, o las confundes? → verwisselen.
• ¿Transformas de un formato/unidad/moneda a otro? → omzetten.

⚠️ La trampa: wisselen y verwisselen se parecen mucho — wisselen es neutro (cambiar/alternar sin mas), verwisselen anade la idea de sustitucion 1x1 o de CONFUNDIR (por error). Bij het wisselen van de wacht (el cambio de guardia) usa wisselen porque es un turno regular, no un error.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'convertir, transformar (de una forma o unidad a otra)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'convertir, transformar (de una forma o unidad a otra)' LIMIT 1),
    'nl_NL', 'omzetten', 'omsetten',
    '• [can.] Ik zet euro''s om in dollars. — Convierto euros en dólares.
• [perf.] Ze heeft het idee omgezet in een concreet plan. — Ha convertido la idea en un plan concreto.
• [can.] De app zet graden Celsius om naar Fahrenheit. — La app convierte grados Celsius a Fahrenheit.
• [inv.] Zodra het bestand is omgezet naar PDF, kun je het versturen. — En cuanto el archivo esté convertido a PDF, puedes enviarlo.
• [vraag] Kun je deze tekst omzetten naar spraak? — ¿Puedes convertir este texto en voz?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'convertir, transformar (de una forma o unidad a otra)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'convertir, transformar (de una forma o unidad a otra)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes)
SELECT 'Convierto euros en dólares.', 'SENTENCE', 'Ejemplo de "omzetten" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Convierto euros en dólares.' AND notes = 'Ejemplo de "omzetten" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Convierto euros en dólares.' AND notes = 'Ejemplo de "omzetten" (can.)' LIMIT 1),
    'nl_NL', 'Ik zet euro''s om in dollars.', 'Ik set eurus om in dollars.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Convierto euros en dólares.' AND notes = 'Ejemplo de "omzetten" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Convierto euros en dólares.' AND notes = 'Ejemplo de "omzetten" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'convertir, transformar (de una forma o unidad a otra)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Convierto euros en dólares.' AND notes = 'Ejemplo de "omzetten" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Ha convertido la idea en un plan concreto.', 'SENTENCE', 'Ejemplo de "omzetten" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ha convertido la idea en un plan concreto.' AND notes = 'Ejemplo de "omzetten" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha convertido la idea en un plan concreto.' AND notes = 'Ejemplo de "omzetten" (perf.)' LIMIT 1),
    'nl_NL', 'Ze heeft het idee omgezet in een concreet plan.', 'Se eft et ide omjeset in en konkret plan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha convertido la idea en un plan concreto.' AND notes = 'Ejemplo de "omzetten" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha convertido la idea en un plan concreto.' AND notes = 'Ejemplo de "omzetten" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'convertir, transformar (de una forma o unidad a otra)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Ha convertido la idea en un plan concreto.' AND notes = 'Ejemplo de "omzetten" (perf.)' LIMIT 1),
    'EXAMPLE');
