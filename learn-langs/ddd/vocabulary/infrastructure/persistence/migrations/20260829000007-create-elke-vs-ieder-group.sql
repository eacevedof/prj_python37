-- Learn Languages App - Grupo "elke vs ieder - cada, cada uno, todos"
-- Migration: 20260829000007-create-elke-vs-ieder-group.sql
-- Description: 14 frases cotidianas sobre la confusion habitual elke/elk vs iedere/ieder
--   (casi sinonimos, mismo reparto de genero: elke/iedere con de-woorden, elk/ieder con
--   het-woorden) y la trampa de iedereen (el pronombre "todos/cada uno" SIN sustantivo
--   detras, que nunca es "elkeen"). Alterna tiempos (presente, pasado, perfecto, modal) y
--   pronombres (ik, ze, hij, we, sujetos sustantivo). Cada tarjeta lleva nota propia + bloque
--   compartido (tabla de genero + trampa de iedereen) + 📐 formula + 🧭 ejemplo + 🏋️ ejercicio.
--   Pronunciation aproximada estilo DutchToSpanishPhoneticService. 100% aditiva e
--   IDEMPOTENTE (INSERT ... WHERE NOT EXISTS / OR IGNORE).

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'elke vs ieder - cada, cada uno, todos',
    'La confusion habitual elke/elk vs iedere/ieder (casi sinonimos, mismo reparto de genero: elke/iedere con de-woorden, elk/ieder con het-woorden) y la trampa de iedereen (todos/cada uno sin sustantivo, nunca "elkeen"). 14 frases cotidianas, alternando tiempos y pronombres',
    'migracion'
);

-- ==============================================================================
-- 1) elke dag = cada dia (elke + de-woord)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Voy al gimnasio cada día.', 'PHRASE', 'elke/ieder: elke + de-woord (dag)', 'elke dag = cada dia. «dag» es de-woord (de dag), por eso «elke», no «elk».

«cada» en neerlandes: elke/elk vs iedere/ieder — casi sinonimos, con el mismo reparto de genero:

| forma | genero del sustantivo | ejemplo |
|---|---|---|
| **elke** | de-woorden (comun) | elke dag — cada dia |
| **elk** | het-woorden (neutro) | elk kind — cada niño |
| **iedere** | de-woorden (comun) | iedere ochtend — cada mañana |
| **ieder** | het-woorden (neutro) | ieder jaar — cada año |

📌 No es una diferencia de significado sino de matiz: elke/elk es la forma neutra y mas usada en el habla; iedere/ieder suena un poco mas formal o subraya mas la individualidad (cada uno por separado), pero en la practica se pueden intercambiar casi siempre.

⚠️ La trampa mas peligrosa: el pronombre "todos / cada uno", SIN sustantivo detras, es SIEMPRE iedereen (ieder + een) — nunca "elkeen", que no existe en neerlandes estandar. Iedereen weet dat. — Todos lo saben.

🗺️ "cada uno de" se dice ieder van o elk van, los dos valen: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinion.

📐 Formula: sujeto + verbo (2a posicion) + elke + sustantivo (de-woord) + resto.

🧭 Ejemplo: Ik ga elke dag naar de sportschool. — Voy al gimnasio cada día.

🏋️ Ejercicio: «cada semana» → ___ week. (Respuesta: elke, porque week es de-woord.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Voy al gimnasio cada día.' AND notes = 'elke/ieder: elke + de-woord (dag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy al gimnasio cada día.' AND notes = 'elke/ieder: elke + de-woord (dag)' LIMIT 1),
    'nl_NL', 'Ik ga elke dag naar de sportschool.', 'Ik ja elke daj nar de sportsjol.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy al gimnasio cada día.' AND notes = 'elke/ieder: elke + de-woord (dag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'elke vs ieder - cada, cada uno, todos'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Voy al gimnasio cada día.' AND notes = 'elke/ieder: elke + de-woord (dag)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 2) elk kind = cada niño (elk + het-woord)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Cada niño tiene su propia taquilla.', 'PHRASE', 'elke/ieder: elk + het-woord (kind)', 'elk kind = cada niño. «kind» es het-woord (het kind), por eso «elk», no «elke».

«cada» en neerlandes: elke/elk vs iedere/ieder — casi sinonimos, con el mismo reparto de genero:

| forma | genero del sustantivo | ejemplo |
|---|---|---|
| **elke** | de-woorden (comun) | elke dag — cada dia |
| **elk** | het-woorden (neutro) | elk kind — cada niño |
| **iedere** | de-woorden (comun) | iedere ochtend — cada mañana |
| **ieder** | het-woorden (neutro) | ieder jaar — cada año |

📌 No es una diferencia de significado sino de matiz: elke/elk es la forma neutra y mas usada en el habla; iedere/ieder suena un poco mas formal o subraya mas la individualidad (cada uno por separado), pero en la practica se pueden intercambiar casi siempre.

⚠️ La trampa mas peligrosa: el pronombre "todos / cada uno", SIN sustantivo detras, es SIEMPRE iedereen (ieder + een) — nunca "elkeen", que no existe en neerlandes estandar. Iedereen weet dat. — Todos lo saben.

🗺️ "cada uno de" se dice ieder van o elk van, los dos valen: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinion.

📐 Formula: Elk + sustantivo het-woord (sujeto) + heeft/is + resto.

🧭 Ejemplo: Elk kind heeft zijn eigen kastje. — Cada niño tiene su propia taquilla.

🏋️ Ejercicio: «cada libro» (het boek) → ___ boek. (Respuesta: elk.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cada niño tiene su propia taquilla.' AND notes = 'elke/ieder: elk + het-woord (kind)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada niño tiene su propia taquilla.' AND notes = 'elke/ieder: elk + het-woord (kind)' LIMIT 1),
    'nl_NL', 'Elk kind heeft zijn eigen kastje.', 'Elk kint eft sein eijen kasje.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada niño tiene su propia taquilla.' AND notes = 'elke/ieder: elk + het-woord (kind)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'elke vs ieder - cada, cada uno, todos'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada niño tiene su propia taquilla.' AND notes = 'elke/ieder: elk + het-woord (kind)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 3) elke week = cada semana (elke + de-woord, pronombre ze)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ella llama a su madre cada semana.', 'PHRASE', 'elke/ieder: elke + de-woord (week)', 'elke week = cada semana. «week» es de-woord (de week), por eso «elke».

«cada» en neerlandes: elke/elk vs iedere/ieder — casi sinonimos, con el mismo reparto de genero:

| forma | genero del sustantivo | ejemplo |
|---|---|---|
| **elke** | de-woorden (comun) | elke dag — cada dia |
| **elk** | het-woorden (neutro) | elk kind — cada niño |
| **iedere** | de-woorden (comun) | iedere ochtend — cada mañana |
| **ieder** | het-woorden (neutro) | ieder jaar — cada año |

📌 No es una diferencia de significado sino de matiz: elke/elk es la forma neutra y mas usada en el habla; iedere/ieder suena un poco mas formal o subraya mas la individualidad (cada uno por separado), pero en la practica se pueden intercambiar casi siempre.

⚠️ La trampa mas peligrosa: el pronombre "todos / cada uno", SIN sustantivo detras, es SIEMPRE iedereen (ieder + een) — nunca "elkeen", que no existe en neerlandes estandar. Iedereen weet dat. — Todos lo saben.

🗺️ "cada uno de" se dice ieder van o elk van, los dos valen: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinion.

📐 Formula: sujeto + verbo (2a posicion) + elke + sustantivo + objeto.

🧭 Ejemplo: Ze belt elke week haar moeder. — Ella llama a su madre cada semana.

🏋️ Ejercicio: «cada mes» (de maand) → ___ maand. (Respuesta: elke.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ella llama a su madre cada semana.' AND notes = 'elke/ieder: elke + de-woord (week)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ella llama a su madre cada semana.' AND notes = 'elke/ieder: elke + de-woord (week)' LIMIT 1),
    'nl_NL', 'Ze belt elke week haar moeder.', 'Se belt elke uek har muder.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ella llama a su madre cada semana.' AND notes = 'elke/ieder: elke + de-woord (week)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'elke vs ieder - cada, cada uno, todos'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ella llama a su madre cada semana.' AND notes = 'elke/ieder: elke + de-woord (week)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 4) elke maand = cada mes (pasado, inversion, pronombre we)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'El año pasado leíamos un libro cada mes.', 'PHRASE', 'elke/ieder: elke + de-woord, pasado + inversion', 'elke maand = cada mes. «maand» es de-woord, por eso «elke». Como «vorig jaar» ocupa la casilla 1, el sujeto «we» salta detras del verbo (inversion).

«cada» en neerlandes: elke/elk vs iedere/ieder — casi sinonimos, con el mismo reparto de genero:

| forma | genero del sustantivo | ejemplo |
|---|---|---|
| **elke** | de-woorden (comun) | elke dag — cada dia |
| **elk** | het-woorden (neutro) | elk kind — cada niño |
| **iedere** | de-woorden (comun) | iedere ochtend — cada mañana |
| **ieder** | het-woorden (neutro) | ieder jaar — cada año |

📌 No es una diferencia de significado sino de matiz: elke/elk es la forma neutra y mas usada en el habla; iedere/ieder suena un poco mas formal o subraya mas la individualidad (cada uno por separado), pero en la practica se pueden intercambiar casi siempre.

⚠️ La trampa mas peligrosa: el pronombre "todos / cada uno", SIN sustantivo detras, es SIEMPRE iedereen (ieder + een) — nunca "elkeen", que no existe en neerlandes estandar. Iedereen weet dat. — Todos lo saben.

🗺️ "cada uno de" se dice ieder van o elk van, los dos valen: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinion.

📐 Formula: tiempo (1) + verbo pasado (2) + sujeto (3, inversion) + elke + sustantivo + resto.

🧭 Ejemplo: Vorig jaar lazen we elke maand een boek. — El año pasado leíamos un libro cada mes.

🏋️ Ejercicio: «cada semana» en pasado → Vorig jaar lazen we ___ week een boek. (Respuesta: elke.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El año pasado leíamos un libro cada mes.' AND notes = 'elke/ieder: elke + de-woord, pasado + inversion');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El año pasado leíamos un libro cada mes.' AND notes = 'elke/ieder: elke + de-woord, pasado + inversion' LIMIT 1),
    'nl_NL', 'Vorig jaar lazen we elke maand een boek.', 'Forij yar lasen ue elke mant en buk.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El año pasado leíamos un libro cada mes.' AND notes = 'elke/ieder: elke + de-woord, pasado + inversion' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'elke vs ieder - cada, cada uno, todos'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El año pasado leíamos un libro cada mes.' AND notes = 'elke/ieder: elke + de-woord, pasado + inversion' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 5) ieder jaar = cada año (ieder + het-woord, inversion)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Cada año visitamos a los abuelos.', 'PHRASE', 'elke/ieder: ieder + het-woord (jaar)', 'ieder jaar = cada año. «jaar» es het-woord (het jaar), por eso «ieder», no «iedere». Aqui ieder es sinonimo de elk, con un matiz algo mas formal.

«cada» en neerlandes: elke/elk vs iedere/ieder — casi sinonimos, con el mismo reparto de genero:

| forma | genero del sustantivo | ejemplo |
|---|---|---|
| **elke** | de-woorden (comun) | elke dag — cada dia |
| **elk** | het-woorden (neutro) | elk kind — cada niño |
| **iedere** | de-woorden (comun) | iedere ochtend — cada mañana |
| **ieder** | het-woorden (neutro) | ieder jaar — cada año |

📌 No es una diferencia de significado sino de matiz: elke/elk es la forma neutra y mas usada en el habla; iedere/ieder suena un poco mas formal o subraya mas la individualidad (cada uno por separado), pero en la practica se pueden intercambiar casi siempre.

⚠️ La trampa mas peligrosa: el pronombre "todos / cada uno", SIN sustantivo detras, es SIEMPRE iedereen (ieder + een) — nunca "elkeen", que no existe en neerlandes estandar. Iedereen weet dat. — Todos lo saben.

🗺️ "cada uno de" se dice ieder van o elk van, los dos valen: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinion.

📐 Formula: ieder + sustantivo het-woord (1) + verbo (2) + sujeto (3, inversion).

🧭 Ejemplo: Ieder jaar bezoeken we de grootouders. — Cada año visitamos a los abuelos.

🏋️ Ejercicio: forma formal de «cada mañana» (de ochtend, de-woord) → ___ ochtend. (Respuesta: iedere, no ieder — ochtend es de-woord.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cada año visitamos a los abuelos.' AND notes = 'elke/ieder: ieder + het-woord (jaar)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada año visitamos a los abuelos.' AND notes = 'elke/ieder: ieder + het-woord (jaar)' LIMIT 1),
    'nl_NL', 'Ieder jaar bezoeken we de grootouders.', 'Ider yar besuken ue de jrotauders.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada año visitamos a los abuelos.' AND notes = 'elke/ieder: ieder + het-woord (jaar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'elke vs ieder - cada, cada uno, todos'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada año visitamos a los abuelos.' AND notes = 'elke/ieder: ieder + het-woord (jaar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 6) iedere ochtend = cada mañana (iedere + de-woord, inversion)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Cada mañana bebo café.', 'PHRASE', 'elke/ieder: iedere + de-woord (ochtend)', 'iedere ochtend = cada mañana. «ochtend» es de-woord (de ochtend), por eso «iedere», no «ieder». Sinonimo mas formal de «elke ochtend».

«cada» en neerlandes: elke/elk vs iedere/ieder — casi sinonimos, con el mismo reparto de genero:

| forma | genero del sustantivo | ejemplo |
|---|---|---|
| **elke** | de-woorden (comun) | elke dag — cada dia |
| **elk** | het-woorden (neutro) | elk kind — cada niño |
| **iedere** | de-woorden (comun) | iedere ochtend — cada mañana |
| **ieder** | het-woorden (neutro) | ieder jaar — cada año |

📌 No es una diferencia de significado sino de matiz: elke/elk es la forma neutra y mas usada en el habla; iedere/ieder suena un poco mas formal o subraya mas la individualidad (cada uno por separado), pero en la practica se pueden intercambiar casi siempre.

⚠️ La trampa mas peligrosa: el pronombre "todos / cada uno", SIN sustantivo detras, es SIEMPRE iedereen (ieder + een) — nunca "elkeen", que no existe en neerlandes estandar. Iedereen weet dat. — Todos lo saben.

🗺️ "cada uno de" se dice ieder van o elk van, los dos valen: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinion.

📐 Formula: iedere + sustantivo de-woord (1) + verbo (2) + sujeto (3, inversion).

🧭 Ejemplo: Iedere ochtend drink ik koffie. — Cada mañana bebo café.

🏋️ Ejercicio: forma formal de «cada tarde» (de middag, de-woord) → ___ middag. (Respuesta: iedere.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cada mañana bebo café.' AND notes = 'elke/ieder: iedere + de-woord (ochtend)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada mañana bebo café.' AND notes = 'elke/ieder: iedere + de-woord (ochtend)' LIMIT 1),
    'nl_NL', 'Iedere ochtend drink ik koffie.', 'Idere ojtent drink ik koffi.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada mañana bebo café.' AND notes = 'elke/ieder: iedere + de-woord (ochtend)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'elke vs ieder - cada, cada uno, todos'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada mañana bebo café.' AND notes = 'elke/ieder: iedere + de-woord (ochtend)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 7) iedereen weet dat = todos lo saben (pronombre, sin sustantivo)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Todos lo saben.', 'PHRASE', 'elke/ieder: iedereen (pronombre "todos", sin sustantivo)', 'iedereen = todos / cada uno, como pronombre SOLO (sin sustantivo detras). Nunca «elkeen»: esa palabra no existe en neerlandes estandar.

«cada» en neerlandes: elke/elk vs iedere/ieder — casi sinonimos, con el mismo reparto de genero:

| forma | genero del sustantivo | ejemplo |
|---|---|---|
| **elke** | de-woorden (comun) | elke dag — cada dia |
| **elk** | het-woorden (neutro) | elk kind — cada niño |
| **iedere** | de-woorden (comun) | iedere ochtend — cada mañana |
| **ieder** | het-woorden (neutro) | ieder jaar — cada año |

📌 No es una diferencia de significado sino de matiz: elke/elk es la forma neutra y mas usada en el habla; iedere/ieder suena un poco mas formal o subraya mas la individualidad (cada uno por separado), pero en la practica se pueden intercambiar casi siempre.

⚠️ La trampa mas peligrosa: el pronombre "todos / cada uno", SIN sustantivo detras, es SIEMPRE iedereen (ieder + een) — nunca "elkeen", que no existe en neerlandes estandar. Iedereen weet dat. — Todos lo saben.

🗺️ "cada uno de" se dice ieder van o elk van, los dos valen: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinion.

📐 Formula: Iedereen (sujeto, gramaticalmente singular) + verbo en singular (2) + resto.

🧭 Ejemplo: Iedereen weet dat. — Todos lo saben.

🏋️ Ejercicio: «Todos lo saben» → ___ weet dat. (Respuesta: Iedereen, nunca "Elkeen".)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Todos lo saben.' AND notes = 'elke/ieder: iedereen (pronombre "todos", sin sustantivo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Todos lo saben.' AND notes = 'elke/ieder: iedereen (pronombre "todos", sin sustantivo)' LIMIT 1),
    'nl_NL', 'Iedereen weet dat.', 'Idereen uet dat.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todos lo saben.' AND notes = 'elke/ieder: iedereen (pronombre "todos", sin sustantivo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'elke vs ieder - cada, cada uno, todos'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todos lo saben.' AND notes = 'elke/ieder: iedereen (pronombre "todos", sin sustantivo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 8) met iedereen = con todos (perfecto, pronombre hij)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ha hablado con todos.', 'PHRASE', 'elke/ieder: iedereen + perfecto', 'met iedereen = con todos. Iedereen tambien funciona como objeto de una preposicion, sin sustantivo detras.

«cada» en neerlandes: elke/elk vs iedere/ieder — casi sinonimos, con el mismo reparto de genero:

| forma | genero del sustantivo | ejemplo |
|---|---|---|
| **elke** | de-woorden (comun) | elke dag — cada dia |
| **elk** | het-woorden (neutro) | elk kind — cada niño |
| **iedere** | de-woorden (comun) | iedere ochtend — cada mañana |
| **ieder** | het-woorden (neutro) | ieder jaar — cada año |

📌 No es una diferencia de significado sino de matiz: elke/elk es la forma neutra y mas usada en el habla; iedere/ieder suena un poco mas formal o subraya mas la individualidad (cada uno por separado), pero en la practica se pueden intercambiar casi siempre.

⚠️ La trampa mas peligrosa: el pronombre "todos / cada uno", SIN sustantivo detras, es SIEMPRE iedereen (ieder + een) — nunca "elkeen", que no existe en neerlandes estandar. Iedereen weet dat. — Todos lo saben.

🗺️ "cada uno de" se dice ieder van o elk van, los dos valen: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinion.

📐 Formula: sujeto + heeft (2) + met iedereen + participio (al final).

🧭 Ejemplo: Hij heeft met iedereen gesproken. — Ha hablado con todos.

🏋️ Ejercicio: «Ha hablado con todos» → Hij heeft met ___ gesproken. (Respuesta: iedereen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ha hablado con todos.' AND notes = 'elke/ieder: iedereen + perfecto');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha hablado con todos.' AND notes = 'elke/ieder: iedereen + perfecto' LIMIT 1),
    'nl_NL', 'Hij heeft met iedereen gesproken.', 'Ei eft met idereen jesproken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha hablado con todos.' AND notes = 'elke/ieder: iedereen + perfecto' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'elke vs ieder - cada, cada uno, todos'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha hablado con todos.' AND notes = 'elke/ieder: iedereen + perfecto' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 9) ieder van ons = cada uno de nosotros
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Cada uno de nosotros tiene una opinión.', 'PHRASE', 'elke/ieder: ieder van (cada uno de)', 'ieder van ons = cada uno de nosotros. «ieder van» + pronombre es la construccion fija para «cada uno de»; «elk van» tambien vale.

«cada» en neerlandes: elke/elk vs iedere/ieder — casi sinonimos, con el mismo reparto de genero:

| forma | genero del sustantivo | ejemplo |
|---|---|---|
| **elke** | de-woorden (comun) | elke dag — cada dia |
| **elk** | het-woorden (neutro) | elk kind — cada niño |
| **iedere** | de-woorden (comun) | iedere ochtend — cada mañana |
| **ieder** | het-woorden (neutro) | ieder jaar — cada año |

📌 No es una diferencia de significado sino de matiz: elke/elk es la forma neutra y mas usada en el habla; iedere/ieder suena un poco mas formal o subraya mas la individualidad (cada uno por separado), pero en la practica se pueden intercambiar casi siempre.

⚠️ La trampa mas peligrosa: el pronombre "todos / cada uno", SIN sustantivo detras, es SIEMPRE iedereen (ieder + een) — nunca "elkeen", que no existe en neerlandes estandar. Iedereen weet dat. — Todos lo saben.

🗺️ "cada uno de" se dice ieder van o elk van, los dos valen: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinion.

📐 Formula: ieder van + pronombre (1) + verbo (2) + resto.

🧭 Ejemplo: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinión.

🏋️ Ejercicio: «cada uno de vosotros» → ___ van jullie. (Respuesta: ieder o elk, ambas valen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cada uno de nosotros tiene una opinión.' AND notes = 'elke/ieder: ieder van (cada uno de)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada uno de nosotros tiene una opinión.' AND notes = 'elke/ieder: ieder van (cada uno de)' LIMIT 1),
    'nl_NL', 'Ieder van ons heeft een mening.', 'Ider fan ons eft en menninj.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada uno de nosotros tiene una opinión.' AND notes = 'elke/ieder: ieder van (cada uno de)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'elke vs ieder - cada, cada uno, todos'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada uno de nosotros tiene una opinión.' AND notes = 'elke/ieder: ieder van (cada uno de)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 10) elke werknemer = cada empleado (elke + de-woord, sujeto sustantivo, pasado)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Cada empleado recibió un regalo.', 'PHRASE', 'elke/ieder: elke + de-woord, sujeto sustantivo', 'elke werknemer = cada empleado. «werknemer» es de-woord, por eso «elke». Aqui «elke + sustantivo» es el sujeto de la frase.

«cada» en neerlandes: elke/elk vs iedere/ieder — casi sinonimos, con el mismo reparto de genero:

| forma | genero del sustantivo | ejemplo |
|---|---|---|
| **elke** | de-woorden (comun) | elke dag — cada dia |
| **elk** | het-woorden (neutro) | elk kind — cada niño |
| **iedere** | de-woorden (comun) | iedere ochtend — cada mañana |
| **ieder** | het-woorden (neutro) | ieder jaar — cada año |

📌 No es una diferencia de significado sino de matiz: elke/elk es la forma neutra y mas usada en el habla; iedere/ieder suena un poco mas formal o subraya mas la individualidad (cada uno por separado), pero en la practica se pueden intercambiar casi siempre.

⚠️ La trampa mas peligrosa: el pronombre "todos / cada uno", SIN sustantivo detras, es SIEMPRE iedereen (ieder + een) — nunca "elkeen", que no existe en neerlandes estandar. Iedereen weet dat. — Todos lo saben.

🗺️ "cada uno de" se dice ieder van o elk van, los dos valen: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinion.

📐 Formula: Elke + sustantivo (sujeto, 1) + verbo pasado (2) + resto.

🧭 Ejemplo: Elke werknemer kreeg een cadeau. — Cada empleado recibió un regalo.

🏋️ Ejercicio: «cada estudiante recibió un premio» → Elke student ___ een prijs. (Respuesta: kreeg.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cada empleado recibió un regalo.' AND notes = 'elke/ieder: elke + de-woord, sujeto sustantivo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada empleado recibió un regalo.' AND notes = 'elke/ieder: elke + de-woord, sujeto sustantivo' LIMIT 1),
    'nl_NL', 'Elke werknemer kreeg een cadeau.', 'Elke uerknemer krej en kado.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada empleado recibió un regalo.' AND notes = 'elke/ieder: elke + de-woord, sujeto sustantivo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'elke vs ieder - cada, cada uno, todos'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada empleado recibió un regalo.' AND notes = 'elke/ieder: elke + de-woord, sujeto sustantivo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 11) op elke hoek = en cada esquina (expresion de lugar, inversion)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'En cada esquina hay una tienda.', 'PHRASE', 'elke/ieder: elke + de-woord, expresion de lugar', 'op elke hoek = en cada esquina. «hoek» es de-woord, por eso «elke». Al ir «op elke hoek» en la casilla 1, el verbo va en la 2 y el sujeto detras (inversion).

«cada» en neerlandes: elke/elk vs iedere/ieder — casi sinonimos, con el mismo reparto de genero:

| forma | genero del sustantivo | ejemplo |
|---|---|---|
| **elke** | de-woorden (comun) | elke dag — cada dia |
| **elk** | het-woorden (neutro) | elk kind — cada niño |
| **iedere** | de-woorden (comun) | iedere ochtend — cada mañana |
| **ieder** | het-woorden (neutro) | ieder jaar — cada año |

📌 No es una diferencia de significado sino de matiz: elke/elk es la forma neutra y mas usada en el habla; iedere/ieder suena un poco mas formal o subraya mas la individualidad (cada uno por separado), pero en la practica se pueden intercambiar casi siempre.

⚠️ La trampa mas peligrosa: el pronombre "todos / cada uno", SIN sustantivo detras, es SIEMPRE iedereen (ieder + een) — nunca "elkeen", que no existe en neerlandes estandar. Iedereen weet dat. — Todos lo saben.

🗺️ "cada uno de" se dice ieder van o elk van, los dos valen: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinion.

📐 Formula: op elke + sustantivo (1) + verbo (2) + sujeto (3, inversion).

🧭 Ejemplo: Op elke hoek staat een winkel. — En cada esquina hay una tienda.

🏋️ Ejercicio: «en cada esquina hay una tienda» → Op ___ hoek staat een winkel. (Respuesta: elke.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'En cada esquina hay una tienda.' AND notes = 'elke/ieder: elke + de-woord, expresion de lugar');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'En cada esquina hay una tienda.' AND notes = 'elke/ieder: elke + de-woord, expresion de lugar' LIMIT 1),
    'nl_NL', 'Op elke hoek staat een winkel.', 'Op elke huk stat en uinkel.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En cada esquina hay una tienda.' AND notes = 'elke/ieder: elke + de-woord, expresion de lugar' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'elke vs ieder - cada, cada uno, todos'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En cada esquina hay una tienda.' AND notes = 'elke/ieder: elke + de-woord, expresion de lugar' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 12) elke keer = cada vez (expresion fija + subordinada)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Cada vez que la veo, sonríe.', 'PHRASE', 'elke/ieder: elke keer (expresion fija)', 'elke keer (dat) = cada vez (que). Es la expresion fija para «cada vez»; «iedere keer» tambien existe pero «elke keer» es mucho mas frecuente.

«cada» en neerlandes: elke/elk vs iedere/ieder — casi sinonimos, con el mismo reparto de genero:

| forma | genero del sustantivo | ejemplo |
|---|---|---|
| **elke** | de-woorden (comun) | elke dag — cada dia |
| **elk** | het-woorden (neutro) | elk kind — cada niño |
| **iedere** | de-woorden (comun) | iedere ochtend — cada mañana |
| **ieder** | het-woorden (neutro) | ieder jaar — cada año |

📌 No es una diferencia de significado sino de matiz: elke/elk es la forma neutra y mas usada en el habla; iedere/ieder suena un poco mas formal o subraya mas la individualidad (cada uno por separado), pero en la practica se pueden intercambiar casi siempre.

⚠️ La trampa mas peligrosa: el pronombre "todos / cada uno", SIN sustantivo detras, es SIEMPRE iedereen (ieder + een) — nunca "elkeen", que no existe en neerlandes estandar. Iedereen weet dat. — Todos lo saben.

🗺️ "cada uno de" se dice ieder van o elk van, los dos valen: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinion.

📐 Formula: Elke keer dat + sujeto + ... + verbo (bijzin, al final), + oracion principal.

🧭 Ejemplo: Elke keer dat ik haar zie, glimlacht ze. — Cada vez que la veo, sonríe.

🏋️ Ejercicio: «cada vez que llueve, me quedo en casa» → ___ keer dat het regent, blijf ik thuis. (Respuesta: Elke.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cada vez que la veo, sonríe.' AND notes = 'elke/ieder: elke keer (expresion fija)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada vez que la veo, sonríe.' AND notes = 'elke/ieder: elke keer (expresion fija)' LIMIT 1),
    'nl_NL', 'Elke keer dat ik haar zie, glimlacht ze.', 'Elke ker dat ik har si, jlimlajt se.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada vez que la veo, sonríe.' AND notes = 'elke/ieder: elke keer (expresion fija)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'elke vs ieder - cada, cada uno, todos'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada vez que la veo, sonríe.' AND notes = 'elke/ieder: elke keer (expresion fija)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 13) iedereen was moe = todos estaban cansados (pasado, singular gramatical)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Todos estaban cansados después del viaje.', 'PHRASE', 'elke/ieder: iedereen + pasado (singular gramatical)', 'iedereen was moe, no waren: iedereen es gramaticalmente SINGULAR (como "todo el mundo" en espanol), aunque se refiera a muchas personas.

«cada» en neerlandes: elke/elk vs iedere/ieder — casi sinonimos, con el mismo reparto de genero:

| forma | genero del sustantivo | ejemplo |
|---|---|---|
| **elke** | de-woorden (comun) | elke dag — cada dia |
| **elk** | het-woorden (neutro) | elk kind — cada niño |
| **iedere** | de-woorden (comun) | iedere ochtend — cada mañana |
| **ieder** | het-woorden (neutro) | ieder jaar — cada año |

📌 No es una diferencia de significado sino de matiz: elke/elk es la forma neutra y mas usada en el habla; iedere/ieder suena un poco mas formal o subraya mas la individualidad (cada uno por separado), pero en la practica se pueden intercambiar casi siempre.

⚠️ La trampa mas peligrosa: el pronombre "todos / cada uno", SIN sustantivo detras, es SIEMPRE iedereen (ieder + een) — nunca "elkeen", que no existe en neerlandes estandar. Iedereen weet dat. — Todos lo saben.

🗺️ "cada uno de" se dice ieder van o elk van, los dos valen: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinion.

📐 Formula: Iedereen (sujeto singular) + was (2, NO waren) + resto.

🧭 Ejemplo: Iedereen was moe na de reis. — Todos estaban cansados después del viaje.

🏋️ Ejercicio: «todos estaban cansados» → Iedereen ___ moe. (Respuesta: was, no waren — iedereen es singular gramatical.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Todos estaban cansados después del viaje.' AND notes = 'elke/ieder: iedereen + pasado (singular gramatical)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Todos estaban cansados después del viaje.' AND notes = 'elke/ieder: iedereen + pasado (singular gramatical)' LIMIT 1),
    'nl_NL', 'Iedereen was moe na de reis.', 'Idereen uas mu na de reis.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todos estaban cansados después del viaje.' AND notes = 'elke/ieder: iedereen + pasado (singular gramatical)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'elke vs ieder - cada, cada uno, todos'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todos estaban cansados después del viaje.' AND notes = 'elke/ieder: iedereen + pasado (singular gramatical)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 14) elke student = cada estudiante (modal + doble infinitivo al final)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Cada estudiante debe entregar el trabajo mañana.', 'PHRASE', 'elke/ieder: elke + de-woord + modal', 'elke student = cada estudiante. «student» es de-woord, por eso «elke». Con un modal (moet), el infinitivo se va al final.

«cada» en neerlandes: elke/elk vs iedere/ieder — casi sinonimos, con el mismo reparto de genero:

| forma | genero del sustantivo | ejemplo |
|---|---|---|
| **elke** | de-woorden (comun) | elke dag — cada dia |
| **elk** | het-woorden (neutro) | elk kind — cada niño |
| **iedere** | de-woorden (comun) | iedere ochtend — cada mañana |
| **ieder** | het-woorden (neutro) | ieder jaar — cada año |

📌 No es una diferencia de significado sino de matiz: elke/elk es la forma neutra y mas usada en el habla; iedere/ieder suena un poco mas formal o subraya mas la individualidad (cada uno por separado), pero en la practica se pueden intercambiar casi siempre.

⚠️ La trampa mas peligrosa: el pronombre "todos / cada uno", SIN sustantivo detras, es SIEMPRE iedereen (ieder + een) — nunca "elkeen", que no existe en neerlandes estandar. Iedereen weet dat. — Todos lo saben.

🗺️ "cada uno de" se dice ieder van o elk van, los dos valen: Ieder van ons heeft een mening. — Cada uno de nosotros tiene una opinion.

📐 Formula: Elke + sustantivo (sujeto, 1) + moet (2) + resto + infinitivo (al final).

🧭 Ejemplo: Elke student moet morgen het werk inleveren. — Cada estudiante debe entregar el trabajo mañana.

🏋️ Ejercicio: «cada empleado debe llegar a tiempo» → Elke werknemer moet op tijd ___. (Respuesta: aankomen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cada estudiante debe entregar el trabajo mañana.' AND notes = 'elke/ieder: elke + de-woord + modal');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada estudiante debe entregar el trabajo mañana.' AND notes = 'elke/ieder: elke + de-woord + modal' LIMIT 1),
    'nl_NL', 'Elke student moet morgen het werk inleveren.', 'Elke student mut morjen et uerk inleferen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada estudiante debe entregar el trabajo mañana.' AND notes = 'elke/ieder: elke + de-woord + modal' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'elke vs ieder - cada, cada uno, todos'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada estudiante debe entregar el trabajo mañana.' AND notes = 'elke/ieder: elke + de-woord + modal' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
