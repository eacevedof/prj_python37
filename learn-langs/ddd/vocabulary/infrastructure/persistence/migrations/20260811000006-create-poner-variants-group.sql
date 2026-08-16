-- Learn Languages App - Grupo "variantes de poner - zetten leggen stoppen stellen"
-- Migration: 20260811000006-create-poner-variants-group.sql
-- Description: 15 frases sobre las variantes de «poner», que en espanol es UN solo verbo
--   pero en neerlandes se reparte segun DONDE y COMO queda la cosa: zetten (de pie,
--   par de staan), leggen (tumbado, par de liggen), stoppen/steken in (dentro, par de
--   zitten), hangen (colgado), doen (echar/meter coloquial), stellen (abstracto: een
--   vraag stellen, voorstellen), plaatsen (formal: anuncio/pedido), aantrekken/opzetten
--   (ropa/gafas), aanzetten (aparatos) y frases hechas (koffie zetten, de tafel dekken,
--   de wekker zetten). Eje: el error tipico del hispanohablante de usar doen/zetten para
--   todo. Cada tarjeta: nota propia + bloque compartido (el mapa de poner) + 📐 formula
--   + 🧭 ejemplo + 🏋️ ejercicio. Pronunciation aproximada estilo DutchToSpanishPhonetic.
--   100% aditiva e IDEMPOTENTE (INSERT ... WHERE NOT EXISTS / OR IGNORE). No toca audios
--   ni imagenes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'variantes de poner - zetten leggen stoppen stellen',
    'El espanol «poner» es un solo verbo, pero el neerlandes lo reparte por posicion y tipo: zetten (de pie, par de staan), leggen (tumbado, par de liggen), stoppen/steken in (dentro, par de zitten), hangen (colgado), doen (echar/meter coloquial), stellen (abstracto: een vraag stellen, voorstellen), plaatsen (formal), aantrekken/opzetten (ropa/gafas), aanzetten (aparatos) y frases hechas (koffie zetten, de tafel dekken, de wekker zetten). Con ejercicios para elegir el verbo correcto',
    'migracion'
);

-- ==============================================================================
-- 1) zetten = poner de pie / vertical (par de staan)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pon el jarron en la mesa', 'PHRASE', 'poner: zetten (de pie/vertical)', 'zetten = poner de pie / en vertical, «plantar» algo en un sitio. Zet de vaas op tafel = pon el jarron en la mesa. La cosa queda de pie -> luego de vaas STAAT op tafel. Es el par de staan.

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Imperativo: Zet (1a posicion) + objeto (de vaas) + lugar (op tafel).

🧭 Cuando usarlo: pedir que coloquen algo de pie. Ej.: → Zet de vaas maar op tafel (pon el jarron en la mesa).

🏋️ Ejercicio: «pon el vaso en la mesa» (queda de pie) → ___ het glas op tafel. (Respuesta: Zet. De pie = zetten.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pon el jarron en la mesa' AND notes = 'poner: zetten (de pie/vertical)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'pon el jarron en la mesa' AND notes = 'poner: zetten (de pie/vertical)' LIMIT 1),
    'nl_NL', 'Zet de vaas op tafel.', 'Set de fas op tafel.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pon el jarron en la mesa' AND notes = 'poner: zetten (de pie/vertical)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pon el jarron en la mesa' AND notes = 'poner: zetten (de pie/vertical)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 2) leggen = poner tumbado / plano (par de liggen)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pon el libro en la mesa', 'PHRASE', 'poner: leggen (tumbado/plano)', 'leggen = poner tumbado / en horizontal. Leg het boek op tafel = pon el libro en la mesa. La cosa queda tumbada -> luego het boek LIGT op tafel. Es el par de liggen.

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Imperativo: Leg (1a posicion) + objeto (het boek) + lugar (op tafel).

🧭 Cuando usarlo: dejar algo plano en una superficie. Ej.: → Leg het boek maar op tafel (pon el libro en la mesa).

🏋️ Ejercicio: «pon el movil en la mesa» (plano) → ___ je telefoon op tafel. (Respuesta: Leg. Tumbado = leggen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pon el libro en la mesa' AND notes = 'poner: leggen (tumbado/plano)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'pon el libro en la mesa' AND notes = 'poner: leggen (tumbado/plano)' LIMIT 1),
    'nl_NL', 'Leg het boek op tafel.', 'Lej het buk op tafel.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pon el libro en la mesa' AND notes = 'poner: leggen (tumbado/plano)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pon el libro en la mesa' AND notes = 'poner: leggen (tumbado/plano)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 3) de wekker zetten = poner el despertador (frase hecha con zetten)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pongo el despertador a las siete', 'PHRASE', 'poner: de wekker zetten (despertador)', 'de wekker zetten = poner el despertador (frase hecha con zetten, NO doen). Ik zet de wekker op zeven uur. op + hora.

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Presente: sujeto + zet (2a posicion) + de wekker + op zeven uur.

🧭 Cuando usarlo: antes de dormir. Ej.: → Ik zet de wekker op zeven uur, morgen werk ik (pongo el despertador a las siete, manana trabajo).

🏋️ Ejercicio: «pongo el despertador a las seis» → Ik ___ de wekker op zes uur. (Respuesta: zet. Frase hecha con zetten, no doen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pongo el despertador a las siete' AND notes = 'poner: de wekker zetten (despertador)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'pongo el despertador a las siete' AND notes = 'poner: de wekker zetten (despertador)' LIMIT 1),
    'nl_NL', 'Ik zet de wekker op zeven uur.', 'Ik set de uekker op seifen ur.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pongo el despertador a las siete' AND notes = 'poner: de wekker zetten (despertador)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pongo el despertador a las siete' AND notes = 'poner: de wekker zetten (despertador)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 4) stoppen in = meter dentro (par de zitten)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me meto las manos en los bolsillos', 'PHRASE', 'poner: stoppen in (meter dentro)', 'stoppen (in) = meter dentro de algo. Ik stop mijn handen in mijn zakken. Queda dentro -> luego ZIT. Sinonimo steken. OJO: stoppen tambien = parar; aqui es meter.

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Presente: sujeto + stop (2a posicion) + objeto (mijn handen) + in + lugar (mijn zakken).

🧭 Cuando usarlo: tener frio en las manos. Ej.: → Ik stop mijn handen in mijn zakken want het is koud (me meto las manos en los bolsillos porque hace frio).

🏋️ Ejercicio: «meto el dinero en la cartera» → Ik ___ het geld in mijn portemonnee. (Respuesta: stop. Dentro = stoppen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'me meto las manos en los bolsillos' AND notes = 'poner: stoppen in (meter dentro)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'me meto las manos en los bolsillos' AND notes = 'poner: stoppen in (meter dentro)' LIMIT 1),
    'nl_NL', 'Ik stop mijn handen in mijn zakken.', 'Ik stop mein handen in mein sakken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me meto las manos en los bolsillos' AND notes = 'poner: stoppen in (meter dentro)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me meto las manos en los bolsillos' AND notes = 'poner: stoppen in (meter dentro)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 5) doen = echar / poner coloquial (ingredientes, liquidos)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pon un poco de leche en el te', 'PHRASE', 'poner: doen (echar liquido/ingrediente)', 'doen = echar / poner coloquial (ingredientes, liquidos, o meter sin precisar postura). Doe wat melk in de thee. wat = un poco de. Para postura precisa usa zetten/leggen; doen es el «meter/echar» generico.

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Imperativo: Doe (1a posicion) + cantidad (wat melk) + in + lugar (de thee).

🧭 Cuando usarlo: preparar una bebida o cocinar. Ej.: → Doe wat melk in de thee, graag (pon un poco de leche en el te, por favor).

🏋️ Ejercicio: «echa sal a la sopa» → ___ wat zout in de soep. (Respuesta: Doe. Echar/ingrediente = doen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pon un poco de leche en el te' AND notes = 'poner: doen (echar liquido/ingrediente)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'pon un poco de leche en el te' AND notes = 'poner: doen (echar liquido/ingrediente)' LIMIT 1),
    'nl_NL', 'Doe wat melk in de thee.', 'Du uat melk in de te.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pon un poco de leche en el te' AND notes = 'poner: doen (echar liquido/ingrediente)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pon un poco de leche en el te' AND notes = 'poner: doen (echar liquido/ingrediente)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 6) stellen = een vraag stellen (hacer una pregunta) [abstracto]
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'puedo hacerte una pregunta', 'PHRASE', 'poner: een vraag stellen (hacer una pregunta)', 'een vraag stellen = hacer / plantear una pregunta. NO «een vraag maken» ni «doen». Mag ik je een vraag stellen? stellen = el «poner» ABSTRACTO (plantear).

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Pregunta con modal: Mag + ik + je + een vraag + stellen (infinitivo al final).

🧭 Cuando usarlo: pedir permiso para preguntar. Ej.: → Mag ik je een vraag stellen? (¿puedo hacerte una pregunta?).

🏋️ Ejercicio: «te hago una pregunta» → Ik ___ je een vraag. (Respuesta: stel. Una pregunta se «stelt», no maakt/doet.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'puedo hacerte una pregunta' AND notes = 'poner: een vraag stellen (hacer una pregunta)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'puedo hacerte una pregunta' AND notes = 'poner: een vraag stellen (hacer una pregunta)' LIMIT 1),
    'nl_NL', 'Mag ik je een vraag stellen?', 'Maj ik ye en fraj stellen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'puedo hacerte una pregunta' AND notes = 'poner: een vraag stellen (hacer una pregunta)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'puedo hacerte una pregunta' AND notes = 'poner: een vraag stellen (hacer una pregunta)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 7) voorstellen = proponer / presentar (familia stellen)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'propongo esperar', 'PHRASE', 'poner: voorstellen (proponer)', 'voorstellen = proponer (tambien presentar a alguien; zich voorstellen = imaginarse / presentarse). Ik stel voor om te wachten. Separable: voor va al final. De la familia de stellen (poner abstracto).

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Presente (separable): sujeto + stel (2a posicion) + resto + voor + [om te + infinitivo].

🧭 Cuando usarlo: sugerir un plan. Ej.: → Ik stel voor om te wachten tot morgen (propongo esperar hasta manana).

🏋️ Ejercicio: «propongo ir a casa» → Ik ___ voor om naar huis te gaan. (Respuesta: stel. voorstellen separable, voor al final.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'propongo esperar' AND notes = 'poner: voorstellen (proponer)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'propongo esperar' AND notes = 'poner: voorstellen (proponer)' LIMIT 1),
    'nl_NL', 'Ik stel voor om te wachten.', 'Ik stel for om te uajten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'propongo esperar' AND notes = 'poner: voorstellen (proponer)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'propongo esperar' AND notes = 'poner: voorstellen (proponer)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 8) hangen = poner colgado
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cuelga tu abrigo en el perchero', 'PHRASE', 'poner: hangen (colgado)', 'hangen = poner colgado. Hang je jas aan de kapstok. Queda colgado -> luego HANGT. En espanol dirias «pon/cuelga el abrigo». kapstok = perchero.

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Imperativo: Hang (1a posicion) + objeto (je jas) + aan + lugar (de kapstok).

🧭 Cuando usarlo: al llegar a casa. Ej.: → Hang je jas aan de kapstok (cuelga el abrigo en el perchero).

🏋️ Ejercicio: «pon el cuadro en la pared» → ___ het schilderij aan de muur. (Respuesta: Hang. Colgado = hangen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'cuelga tu abrigo en el perchero' AND notes = 'poner: hangen (colgado)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'cuelga tu abrigo en el perchero' AND notes = 'poner: hangen (colgado)' LIMIT 1),
    'nl_NL', 'Hang je jas aan de kapstok.', 'Hang ye yas an de kapstok.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cuelga tu abrigo en el perchero' AND notes = 'poner: hangen (colgado)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cuelga tu abrigo en el perchero' AND notes = 'poner: hangen (colgado)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 9) aanzetten = poner en marcha / encender (aparatos)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pon la tele', 'PHRASE', 'poner: aanzetten (encender aparato)', 'aanzetten / aandoen = poner en marcha / encender (aparatos, luz). Zet de tv aan. Separable: aan al final. Apagar = uitzetten / uitdoen.

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Imperativo (separable): Zet (1a posicion) + objeto (de tv) + aan.

🧭 Cuando usarlo: querer ver algo. Ej.: → Zet de tv aan, de wedstrijd begint (pon la tele, empieza el partido).

🏋️ Ejercicio: «pon la luz» → ___ het licht ___. (Respuesta: Doe/Zet ... aan. Encender aparato/luz = aandoen/aanzetten.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pon la tele' AND notes = 'poner: aanzetten (encender aparato)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'pon la tele' AND notes = 'poner: aanzetten (encender aparato)' LIMIT 1),
    'nl_NL', 'Zet de tv aan.', 'Set de teevee an.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pon la tele' AND notes = 'poner: aanzetten (encender aparato)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pon la tele' AND notes = 'poner: aanzetten (encender aparato)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 10) aantrekken = ponerse ropa/zapatos
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ponte los zapatos', 'PHRASE', 'poner: aantrekken (ponerse ropa)', 'aantrekken = ponerse (ropa y zapatos). Trek je schoenen aan. Separable: aan al final. NO «zet je schoenen». Quitarse ropa = uittrekken.

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Imperativo (separable): Trek (1a posicion) + objeto (je schoenen) + aan.

🧭 Cuando usarlo: antes de salir. Ej.: → Trek je schoenen aan, we gaan (ponte los zapatos, nos vamos).

🏋️ Ejercicio: «ponte el abrigo» → ___ je jas ___. (Respuesta: Trek ... aan. Ropa = aantrekken, no zetten.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ponte los zapatos' AND notes = 'poner: aantrekken (ponerse ropa)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ponte los zapatos' AND notes = 'poner: aantrekken (ponerse ropa)' LIMIT 1),
    'nl_NL', 'Trek je schoenen aan.', 'Trek ye sjunen an.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ponte los zapatos' AND notes = 'poner: aantrekken (ponerse ropa)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ponte los zapatos' AND notes = 'poner: aantrekken (ponerse ropa)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 11) opzetten = ponerse gafas/gorro / poner musica
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ponte las gafas', 'PHRASE', 'poner: opzetten (gafas/gorro/musica)', 'opzetten = ponerse (gafas, gorro, casco) y tambien poner musica (muziek opzetten). Zet je bril op. Separable: op al final. La ropa normal en cambio = aantrekken.

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Imperativo (separable): Zet (1a posicion) + objeto (je bril) + op.

🧭 Cuando usarlo: para leer o ver mejor. Ej.: → Zet je bril op, dan zie je het beter (ponte las gafas, asi lo ves mejor).

🏋️ Ejercicio: «pon musica» → ___ wat muziek ___. (Respuesta: Zet ... op. Gafas/gorro/musica = opzetten.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ponte las gafas' AND notes = 'poner: opzetten (gafas/gorro/musica)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ponte las gafas' AND notes = 'poner: opzetten (gafas/gorro/musica)' LIMIT 1),
    'nl_NL', 'Zet je bril op.', 'Set ye bril op.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ponte las gafas' AND notes = 'poner: opzetten (gafas/gorro/musica)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ponte las gafas' AND notes = 'poner: opzetten (gafas/gorro/musica)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 12) koffie zetten = hacer cafe (frase hecha)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'voy a hacer cafe', 'PHRASE', 'poner: koffie zetten (hacer cafe)', 'koffie / thee zetten = hacer cafe / te (prepararlo). Ik zet even koffie. even = un momento. Frase hecha con zetten (no maken).

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Presente: sujeto + zet (2a posicion) + even + koffie.

🧭 Cuando usarlo: ofrecer cafe a alguien. Ej.: → Ik zet even koffie, wil jij ook? (voy a hacer cafe, ¿quieres tu tambien?).

🏋️ Ejercicio: «hago te» → Ik ___ thee. (Respuesta: zet. Cafe/te se «zet», no maakt.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'voy a hacer cafe' AND notes = 'poner: koffie zetten (hacer cafe)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a hacer cafe' AND notes = 'poner: koffie zetten (hacer cafe)' LIMIT 1),
    'nl_NL', 'Ik zet even koffie.', 'Ik set eifen koffie.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a hacer cafe' AND notes = 'poner: koffie zetten (hacer cafe)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a hacer cafe' AND notes = 'poner: koffie zetten (hacer cafe)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 13) plaatsen = colocar/poner formal (anuncio/pedido)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'he puesto un anuncio', 'PHRASE', 'poner: plaatsen (anuncio/pedido, formal)', 'plaatsen = colocar / situar (formal); poner un anuncio o un pedido. Ik heb een advertentie geplaatst. Perfecto con hebben (transitivo), participio geplaatst.

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Perfecto: sujeto + heb (2a posicion) + objeto (een advertentie) + geplaatst (al final).

🧭 Cuando usarlo: vender algo online. Ej.: → Ik heb een advertentie geplaatst op Marktplaats (he puesto un anuncio en Marktplaats).

🏋️ Ejercicio: «pongo un pedido» → Ik ___ een bestelling. (Respuesta: plaats. Anuncio/pedido = plaatsen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'he puesto un anuncio' AND notes = 'poner: plaatsen (anuncio/pedido, formal)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'he puesto un anuncio' AND notes = 'poner: plaatsen (anuncio/pedido, formal)' LIMIT 1),
    'nl_NL', 'Ik heb een advertentie geplaatst.', 'Ik hep en atfertensie jeplatst.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'he puesto un anuncio' AND notes = 'poner: plaatsen (anuncio/pedido, formal)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'he puesto un anuncio' AND notes = 'poner: plaatsen (anuncio/pedido, formal)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 14) neerzetten = dejar / posar (soltar de pie)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'deja la bolsa un momento', 'PHRASE', 'poner: neerzetten (dejar/posar de pie)', 'neerzetten = dejar / posar (soltar algo de pie en una superficie). Zet de tas even neer. neer al final. Si es algo plano -> neerleggen. Es el «poner/dejar» de soltar una carga.

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Imperativo (separable): Zet (1a posicion) + objeto (de tas) + even + neer.

🧭 Cuando usarlo: cuando algo pesa. Ej.: → Zet de tas even neer, hij is zwaar (deja la bolsa un momento, pesa).

🏋️ Ejercicio: «deja el plato ahi» (de pie) → ___ het bord daar ___. (Respuesta: Zet ... neer. Plano seria neerleggen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'deja la bolsa un momento' AND notes = 'poner: neerzetten (dejar/posar de pie)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'deja la bolsa un momento' AND notes = 'poner: neerzetten (dejar/posar de pie)' LIMIT 1),
    'nl_NL', 'Zet de tas even neer.', 'Set de tas eifen neer.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'deja la bolsa un momento' AND notes = 'poner: neerzetten (dejar/posar de pie)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'deja la bolsa un momento' AND notes = 'poner: neerzetten (dejar/posar de pie)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 15) de tafel dekken = poner la mesa (falso amigo)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pon la mesa', 'PHRASE', 'poner: de tafel dekken (poner la mesa, falso amigo)', 'FALSO AMIGO: «poner la mesa» = de tafel DEKKEN, NO «de tafel zetten» ni «leggen». dekken = poner / preparar la mesa (mantel, platos, cubiertos). Ik dek de tafel.

🗺️ El mapa de «poner» (en neerlandes NO es un solo verbo; se elige por DONDE y COMO queda la cosa):
POSICION FISICA (el par con staan/liggen/zitten):
• zetten = poner de PIE / vertical (vasos, botellas, tazas, la tele) → luego STAAT. Zet de vaas op tafel.
• leggen = poner TUMBADO / plano (libros, papeles, cubiertos, el movil) → luego LIGT. Leg het boek op tafel.
• stoppen / steken (in) = METER dentro (manos en los bolsillos, dinero en la cartera) → luego ZIT. Ik stop het geld in mijn zak.
• hangen = poner COLGADO (abrigo, cuadro) → luego HANGT.
OTROS «poner» que NO son zetten/leggen:
• doen = echar / meter coloquial (liquidos, ingredientes, o meter sin precisar postura). Doe wat zout in de soep.
• stellen = poner ABSTRACTO: een vraag stellen (hacer una pregunta), voorstellen (proponer), eisen stellen (poner exigencias), instellen (ajustar). NO es colocar un objeto.
• plaatsen = colocar/situar (formal): een advertentie/bestelling plaatsen (poner un anuncio/pedido).
• ROPA: aantrekken (ropa y zapatos), opzetten (gafas, gorro, tambien poner musica), omdoen (bufanda).
• APARATOS: aanzetten / aandoen = encender / poner en marcha (la tele, la luz).
• FRASES HECHAS: koffie zetten (hacer cafe), de tafel dekken (poner la mesa, NO «de tafel zetten»), de wekker zetten (poner el despertador).
⚠️ Error tipico: usar «doen» o «zetten» para todo. ¿De pie? zetten · ¿tumbado? leggen · ¿dentro? stoppen · ¿colgado? hangen · ¿abstracto (pregunta/propuesta/ajuste)? stellen · ¿ropa? aantrekken/opzetten · ¿aparato? aanzetten.
Truco del par: zetten↔staan · leggen↔liggen · stoppen↔zitten (el mismo trio que en «estar»).

📐 Presente: sujeto + dek (2a posicion) + de tafel.

🧭 Cuando usarlo: antes de comer. Ej.: → Kun je de tafel dekken? Het eten is bijna klaar (¿puedes poner la mesa? la comida esta casi lista).

🏋️ Ejercicio: «pongo la mesa» → Ik ___ de tafel. (Respuesta: dek. OJO: no zetten ni leggen; poner la mesa = dekken.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pon la mesa' AND notes = 'poner: de tafel dekken (poner la mesa, falso amigo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'pon la mesa' AND notes = 'poner: de tafel dekken (poner la mesa, falso amigo)' LIMIT 1),
    'nl_NL', 'Ik dek de tafel.', 'Ik dek de tafel.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pon la mesa' AND notes = 'poner: de tafel dekken (poner la mesa, falso amigo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'variantes de poner - zetten leggen stoppen stellen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pon la mesa' AND notes = 'poner: de tafel dekken (poner la mesa, falso amigo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
