-- Learn Languages App - Grupo "verbos reflexivos - wederkerige werkwoorden"
-- Migration: 20260713000002-create-reflexive-verbs-group.sql
-- Description: 15 verbos reflexivos (wederkerige werkwoorden) más usados en neerlandés,
--   cada uno con una frase cotidiana o frase hecha y VARIANDO el pronombre reflexivo
--   (me / je / zich / u+zich / ons). rules_help = uso + paradigma de pronombres
--   reflexivos + fórmula de estructura. Pronunciation con DutchToSpanishPhoneticService.
--   100% aditiva e IDEMPOTENTE (INSERT ... WHERE NOT EXISTS / OR IGNORE): no toca
--   words_lang de otras palabras, imágenes ni audios existentes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'verbos reflexivos - wederkerige werkwoorden',
    'Los 15 verbos reflexivos (wederkerige werkwoorden) más usados en neerlandés con frases cotidianas o frases hechas, variando el pronombre reflexivo (me/je/zich/u/ons)',
    'migracion'
);

-- ==============================================================================
-- zich voelen (me): Ik voel me niet lekker.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no me encuentro bien', 'PHRASE', 'Verbo reflexivo: zich voelen', 'zich voelen = sentirse / encontrarse. Ik voel me niet lekker = no me encuentro bien (malestar físico). También zich goed / moe / rot voelen.

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'no me encuentro bien' AND notes = 'Verbo reflexivo: zich voelen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'no me encuentro bien' AND notes = 'Verbo reflexivo: zich voelen' LIMIT 1),
    'nl_NL', 'Ik voel me niet lekker.', 'Ik ful me nit lekker.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no me encuentro bien' AND notes = 'Verbo reflexivo: zich voelen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no me encuentro bien' AND notes = 'Verbo reflexivo: zich voelen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich vergissen (me): Sorry, ik heb me vergist.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'perdona, me he equivocado', 'PHRASE', 'Verbo reflexivo: zich vergissen', 'zich vergissen = equivocarse. Obligatoriamente reflexivo (no existe sin pronombre). Insep. (ver-): participio sin ge- → ik heb me vergist. ¿Me equivoco? = Vergis ik me?

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'perdona, me he equivocado' AND notes = 'Verbo reflexivo: zich vergissen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'perdona, me he equivocado' AND notes = 'Verbo reflexivo: zich vergissen' LIMIT 1),
    'nl_NL', 'Sorry, ik heb me vergist.', 'Sorry, ik eb me ferjist.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'perdona, me he equivocado' AND notes = 'Verbo reflexivo: zich vergissen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'perdona, me he equivocado' AND notes = 'Verbo reflexivo: zich vergissen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich herinneren (je): Herinner je je mij nog?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿todavía te acuerdas de mí?', 'PHRASE', 'Verbo reflexivo: zich herinneren', 'zich herinneren = acordarse de, recordar. Herinner je je mij nog? = ¿todavía te acuerdas de mí? (dos je seguidos: sujeto je + reflexivo je). Ojo: onthouden = memorizar / retener; herinneren = traer a la memoria.

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Pregunta sí/no (ja/nee-vraag): verbo conjugado en 1ª posición + sujeto + resto; los demás verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿todavía te acuerdas de mí?' AND notes = 'Verbo reflexivo: zich herinneren');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿todavía te acuerdas de mí?' AND notes = 'Verbo reflexivo: zich herinneren' LIMIT 1),
    'nl_NL', 'Herinner je je mij nog?', 'Erinner ye ye mei noj?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿todavía te acuerdas de mí?' AND notes = 'Verbo reflexivo: zich herinneren' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿todavía te acuerdas de mí?' AND notes = 'Verbo reflexivo: zich herinneren' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich haasten (je, imperativo): Haast je een beetje!
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡date prisa!', 'PHRASE', 'Verbo reflexivo: zich haasten', 'zich haasten = darse prisa. Haast je een beetje! = ¡date un poco de prisa! (imperativo: verbo + je). Alternativa coloquial: Schiet op!

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Imperativo: verbo en 1ª posición (forma de ik) + resto; sin sujeto. El pronombre reflexivo va justo detrás (Haast je!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡date prisa!' AND notes = 'Verbo reflexivo: zich haasten');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡date prisa!' AND notes = 'Verbo reflexivo: zich haasten' LIMIT 1),
    'nl_NL', 'Haast je een beetje!', 'Ast ye en betye!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡date prisa!' AND notes = 'Verbo reflexivo: zich haasten' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡date prisa!' AND notes = 'Verbo reflexivo: zich haasten' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich vervelen (zich, 3a pl): De kinderen vervelen zich.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'los niños se aburren', 'PHRASE', 'Verbo reflexivo: zich vervelen', 'zich vervelen = aburrirse. De kinderen vervelen zich = los niños se aburren (sujeto plural → zich). No confundir con vervelend = molesto / pesado.

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'los niños se aburren' AND notes = 'Verbo reflexivo: zich vervelen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'los niños se aburren' AND notes = 'Verbo reflexivo: zich vervelen' LIMIT 1),
    'nl_NL', 'De kinderen vervelen zich.', 'De kinderen ferfelen sij.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los niños se aburren' AND notes = 'Verbo reflexivo: zich vervelen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los niños se aburren' AND notes = 'Verbo reflexivo: zich vervelen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich schamen (me, frase hecha): Ik schaam me dood.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me muero de vergüenza', 'PHRASE', 'Verbo reflexivo: zich schamen', 'zich schamen (voor) = avergonzarse (de). Ik schaam me dood = me muero de vergüenza (frase hecha; literal: me avergüenzo muerto). Schaam je! = ¡qué vergüenza!

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Frase hecha: orden fijo, se memoriza tal cual.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'me muero de vergüenza' AND notes = 'Verbo reflexivo: zich schamen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'me muero de vergüenza' AND notes = 'Verbo reflexivo: zich schamen' LIMIT 1),
    'nl_NL', 'Ik schaam me dood.', 'Ik sjam me dod.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me muero de vergüenza' AND notes = 'Verbo reflexivo: zich schamen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me muero de vergüenza' AND notes = 'Verbo reflexivo: zich schamen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich aankleden (je, imperativo separable): Kleed je aan, we gaan zo.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡vístete, nos vamos ya!', 'PHRASE', 'Verbo reflexivo: zich aankleden', 'zich aankleden = vestirse (separable: kleed … aan). Kleed je aan! = ¡vístete! El reflexivo (je) va tras el verbo y el prefijo (aan) al final. También transitivo: een kind aankleden = vestir a un niño. Contrario: zich uitkleden = desvestirse.

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Imperativo: verbo en 1ª posición (forma de ik) + resto; sin sujeto. Si el verbo es separable, el prefijo va al final (Kleed je aan!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡vístete, nos vamos ya!' AND notes = 'Verbo reflexivo: zich aankleden');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡vístete, nos vamos ya!' AND notes = 'Verbo reflexivo: zich aankleden' LIMIT 1),
    'nl_NL', 'Kleed je aan, we gaan zo.', 'Kled ye an, ue jan so.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡vístete, nos vamos ya!' AND notes = 'Verbo reflexivo: zich aankleden' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡vístete, nos vamos ya!' AND notes = 'Verbo reflexivo: zich aankleden' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich concentreren (me): Ik kan me niet concentreren.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no me puedo concentrar', 'PHRASE', 'Verbo reflexivo: zich concentreren', 'zich concentreren (op) = concentrarse (en). Ik kan me niet concentreren = no me puedo concentrar (modal kan → infinitivo concentreren al final). Insep.

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'no me puedo concentrar' AND notes = 'Verbo reflexivo: zich concentreren');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'no me puedo concentrar' AND notes = 'Verbo reflexivo: zich concentreren' LIMIT 1),
    'nl_NL', 'Ik kan me niet concentreren.', 'Ik kan me nit concentreren.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no me puedo concentrar' AND notes = 'Verbo reflexivo: zich concentreren' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no me puedo concentrar' AND notes = 'Verbo reflexivo: zich concentreren' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich ontspannen (u/zich, imperativo cortés): Ontspant u zich maar.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'relájese (tranquilo)', 'PHRASE', 'Verbo reflexivo: zich ontspannen', 'zich ontspannen = relajarse. Ontspant u zich maar = relájese, tranquilo (forma de cortesía u → zich; maar suaviza, como venga / tranquilo). Tuteo: Ontspan je!

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Imperativo (forma de cortesía con u): verbo + u + zich + resto. Con tuteo el verbo va en 1ª posición sin sujeto (Ontspan je!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'relájese (tranquilo)' AND notes = 'Verbo reflexivo: zich ontspannen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'relájese (tranquilo)' AND notes = 'Verbo reflexivo: zich ontspannen' LIMIT 1),
    'nl_NL', 'Ontspant u zich maar.', 'Ontspant u sij mar.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'relájese (tranquilo)' AND notes = 'Verbo reflexivo: zich ontspannen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'relájese (tranquilo)' AND notes = 'Verbo reflexivo: zich ontspannen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich gedragen (je, imperativo): Gedraag je!
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡compórtate!', 'PHRASE', 'Verbo reflexivo: zich gedragen', 'zich gedragen = comportarse. Gedraag je! = ¡compórtate! (lo típico que se dice a los niños). Insep. (ge-): participio gedragen. het gedrag = el comportamiento.

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Imperativo: verbo en 1ª posición (forma de ik) + resto; sin sujeto. El pronombre reflexivo va justo detrás (Gedraag je!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡compórtate!' AND notes = 'Verbo reflexivo: zich gedragen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡compórtate!' AND notes = 'Verbo reflexivo: zich gedragen' LIMIT 1),
    'nl_NL', 'Gedraag je!', 'Jedraj ye!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡compórtate!' AND notes = 'Verbo reflexivo: zich gedragen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡compórtate!' AND notes = 'Verbo reflexivo: zich gedragen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich afvragen (me, + subordinada): Ik vraag me af of het waar is.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me pregunto si es verdad', 'PHRASE', 'Verbo reflexivo: zich afvragen', 'zich afvragen = preguntarse. Ik vraag me af of het waar is = me pregunto si es verdad (separable: vraag … af; of… introduce subordinada, verbo al final: … waar is).

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Oración principal (hoofdzin) + subordinada: sujeto + verbo (2ª posición) + resto; tras of… el verbo de la subordinada va al final (of het waar is).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'me pregunto si es verdad' AND notes = 'Verbo reflexivo: zich afvragen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'me pregunto si es verdad' AND notes = 'Verbo reflexivo: zich afvragen' LIMIT 1),
    'nl_NL', 'Ik vraag me af of het waar is.', 'Ik fraj me af of et uar is.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me pregunto si es verdad' AND notes = 'Verbo reflexivo: zich afvragen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me pregunto si es verdad' AND notes = 'Verbo reflexivo: zich afvragen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich voorstellen (me, pregunta modal): Mag ik me even voorstellen?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿me presento?', 'PHRASE', 'Verbo reflexivo: zich voorstellen', 'zich voorstellen = presentarse; también imaginarse. Mag ik me even voorstellen? = ¿me presento un momento? (modal mag → infinitivo voorstellen al final; separable: stel … voor). ¡Imagínate! = Stel je voor!

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Pregunta sí/no (ja/nee-vraag): verbo conjugado en 1ª posición + sujeto + resto; los demás verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¿me presento?' AND notes = 'Verbo reflexivo: zich voorstellen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿me presento?' AND notes = 'Verbo reflexivo: zich voorstellen' LIMIT 1),
    'nl_NL', 'Mag ik me even voorstellen?', 'Maj ik me efen forstellen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿me presento?' AND notes = 'Verbo reflexivo: zich voorstellen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿me presento?' AND notes = 'Verbo reflexivo: zich voorstellen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich bemoeien met (je, imperativo): Bemoei je er niet mee!
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡no te metas!', 'PHRASE', 'Verbo reflexivo: zich bemoeien', 'zich bemoeien met = entrometerse en, meterse. Bemoei je er niet mee! = ¡no te metas! (er … mee = con eso, pronombre partido). Bemoei je met je eigen zaken = métete en tus asuntos.

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Imperativo: verbo en 1ª posición (forma de ik) + resto; sin sujeto. El pronombre reflexivo va justo detrás (Bemoei je … niet mee!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡no te metas!' AND notes = 'Verbo reflexivo: zich bemoeien');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡no te metas!' AND notes = 'Verbo reflexivo: zich bemoeien' LIMIT 1),
    'nl_NL', 'Bemoei je er niet mee!', 'Bemui ye er nit me!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡no te metas!' AND notes = 'Verbo reflexivo: zich bemoeien' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡no te metas!' AND notes = 'Verbo reflexivo: zich bemoeien' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich verheugen op (ons, 1a pl): We verheugen ons op de vakantie.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tenemos ganas de las vacaciones', 'PHRASE', 'Verbo reflexivo: zich verheugen', 'zich verheugen op = ilusionarse por, tener ganas de (algo futuro). We verheugen ons op de vakantie = tenemos ganas de las vacaciones (sujeto plural we → ons). Más informal y equivalente: Ik kijk ernaar uit.

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = 'tenemos ganas de las vacaciones' AND notes = 'Verbo reflexivo: zich verheugen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'tenemos ganas de las vacaciones' AND notes = 'Verbo reflexivo: zich verheugen' LIMIT 1),
    'nl_NL', 'We verheugen ons op de vakantie.', 'Ue ferejen ons op de fakanti.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tenemos ganas de las vacaciones' AND notes = 'Verbo reflexivo: zich verheugen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tenemos ganas de las vacaciones' AND notes = 'Verbo reflexivo: zich verheugen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- zich verslapen (me, perfecto): Ik heb me verslapen!
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡me he quedado dormido!', 'PHRASE', 'Verbo reflexivo: zich verslapen', 'zich verslapen = quedarse dormido (dormir más de la cuenta). Ik heb me verslapen! = ¡me he quedado dormido! (la excusa clásica de llegar tarde). Insep. (ver-): participio sin ge- (verslapen).

Pronombres reflexivos: ik→me · jij/je→je · u→u/zich · hij/zij/het→zich · wij→ons · jullie→je · zij/ze (pl)→zich. El reflexivo va justo tras el verbo conjugado (en preguntas e imperativo, tras el sujeto).

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
WHERE NOT EXISTS (SELECT 1 FROM words_es
    WHERE text = '¡me he quedado dormido!' AND notes = 'Verbo reflexivo: zich verslapen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡me he quedado dormido!' AND notes = 'Verbo reflexivo: zich verslapen' LIMIT 1),
    'nl_NL', 'Ik heb me verslapen!', 'Ik eb me ferslapen!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡me he quedado dormido!' AND notes = 'Verbo reflexivo: zich verslapen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos reflexivos - wederkerige werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡me he quedado dormido!' AND notes = 'Verbo reflexivo: zich verslapen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
