-- Learn Languages App - Grupo "la hora - hoe laat is het"
-- Migration: 20260820000003-create-clock-time-group.sql
-- Description: el reloj neerlandes entero, anclado en las 9 para que se vea el mecanismo:
--   9:00 · 9:13 · 9:15 · 9:19 · 9:30 · 9:37 · 9:45 · 9:57, mas cuatro tarjetas del entorno
--   de la hora (Hoe laat is het? · om + hora · een uur of tien / tegen tienen · las franjas
--   ''s ochtends-''s avonds y el reloj de 24 h). 12 tarjetas.
--   Eje: el reloj neerlandes cuelga de la MEDIA y la media pertenece a la hora SIGUIENTE
--   (half tien = 9:30), asi que del :16 al :44 hay que RECALCULAR, no traducir. Los dos
--   tramos con resta distinta (a 30 con voor half, a 60 con voor) son el error tipico.
--   En la BD no habia nada de esto: cero kwart, cero half, cero over/voor de hora; solo
--   horas en punto sueltas dentro de otras frases (om acht uur, om zeven uur).
--   Cada tarjeta: regla propia + el mapa del reloj + 📐 formula + ⚠️ trampa + 🏋️ ejercicio,
--   y 5 ejemplos en words_lang.notes (los que pinta el slider).
--   El mapa compartido se escribe UNA vez, al final, con REPLACE sobre el marcador @@KLOK@@.
--   100% aditiva e IDEMPOTENTE (INSERT ... WHERE NOT EXISTS / OR IGNORE / REPLACE guardado).

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'la hora - hoe laat is het',
    'El reloj neerlandes de punta a punta, anclado en las 9 para ver el mecanismo: en punto, y trece, y cuarto, y diecinueve, y media, y treinta y siete, menos cuarto y menos tres. La clave es que el reloj cuelga de la MEDIA y la media pertenece a la hora siguiente (half tien = 9:30), con dos restas distintas: a 30 en el tramo voor half y a 60 en el tramo voor. Incluye Hoe laat is het?, la preposicion om, las formas de aproximar (een uur of tien, tegen tienen, rond, omstreeks) y las franjas del dia con el reloj de 24 h',
    'migracion'
);

-- ==============================================================================
-- 01) 9:00 - negen uur (en punto)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las nueve en punto (9:00)', 'PHRASE', 'hora: 9:00 - negen uur (en punto)', 'En punto = la hora + UUR, que es obligatorio: Het is negen uur. «Het is negen» a secas no existe. Para el «en punto» exacto: precies negen uur.
@@KLOK@@
📐 Estructura: Het + is (2a posicion) + [numero] + uur.

⚠️ Tras cifra, uur NO se pluraliza: twee uur vale para «las dos» y para «dos horas» (uren solo sin cifra o en contextos tecnicos). Es la misma regla de la tarjeta de twee uur gefietst.

⚠️ En espanol «SON las nueve», en plural; en neerlandes la hora es impersonal y en singular: HET IS negen uur.

🏋️ Ejercicio: «son las cinco» → Het is vijf ___. (Respuesta: uur. Sin uur no hay hora.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'las nueve en punto (9:00)' AND notes = 'hora: 9:00 - negen uur (en punto)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve en punto (9:00)' AND notes = 'hora: 9:00 - negen uur (en punto)' LIMIT 1),
    'nl_NL', 'Het is negen uur.', 'Et is nejen ur.',
    '• [can.] Het is precies negen uur. — Son las nueve en punto.
• [vraag] Is het al negen uur? — ¿Ya son las nueve?
• [can.] De winkel gaat om negen uur open. — La tienda abre a las nueve.
• [inv.] Om negen uur begint de vergadering. — A las nueve empieza la reunión.
• [uitdr.] Het is klokslag negen uur. — Son las nueve clavadas.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve en punto (9:00)' AND notes = 'hora: 9:00 - negen uur (en punto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve en punto (9:00)' AND notes = 'hora: 9:00 - negen uur (en punto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 02) 9:13 - dertien over negen (tramo over, :01-:15)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las nueve y trece (9:13)', 'PHRASE', 'hora: 9:13 - dertien over negen (tramo over)', 'Del minuto 1 al 15 el reloj cuenta hacia DELANTE: minutos + OVER + hora. dertien over negen = 9:13. over = pasados.
@@KLOK@@
📐 Estructura: [minutos] + over + [hora]. Aqui el numero es el minuto tal cual del reloj, sin cuentas.

⚠️ Este «hacia delante» solo llega hasta el :15. Del :16 en adelante el reloj se agarra a la media (voor half) — ese salto es lo que descoloca al hispanohablante.

⚠️ over + hora en -en, sin minuto, significa «pasadas las»: het is over negenen (ya son mas de las nueve).

🏋️ Ejercicio: 9:07 → ___ over negen. (Respuesta: zeven. Minuto tal cual.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'las nueve y trece (9:13)' AND notes = 'hora: 9:13 - dertien over negen (tramo over)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve y trece (9:13)' AND notes = 'hora: 9:13 - dertien over negen (tramo over)' LIMIT 1),
    'nl_NL', 'Het is dertien over negen.', 'Et is dertin ofer nejen.',
    '• [can.] Het is dertien over negen. — Son las nueve y trece.
• [can.] De bus komt om vijf over negen. — El bus llega a las nueve y cinco.
• [vraag] Vertrekken we om tien over negen? — ¿Salimos a las nueve y diez?
• [can.] Ik was er om acht over negen. — Estuve allí a las nueve y ocho.
• [uitdr.] Het is al over negenen. — Ya son más de las nueve.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve y trece (9:13)' AND notes = 'hora: 9:13 - dertien over negen (tramo over)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve y trece (9:13)' AND notes = 'hora: 9:13 - dertien over negen (tramo over)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 03) 9:15 - kwart over negen
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las nueve y cuarto (9:15)', 'PHRASE', 'hora: 9:15 - kwart over negen', 'kwart over negen = 9:15. kwart va SIN articulo: nunca «een kwart over negen». Es el ultimo escalon del tramo over, justo antes de saltar a la media.
@@KLOK@@
📐 Estructura: kwart + over/voor + [hora]. Sin numero y sin uur.

⚠️ kwart over = y cuarto · kwart voor = menos cuarto (en Belgica se oye tambien kwart na). El sustantivo «un cuarto de hora» en cambio si lleva articulo: een kwartier wachten.

⚠️ No confundas kwart (el cuarto del reloj) con kwartier (el rato de quince minutos): Het is kwart over negen / Ik wacht al een kwartier.

🏋️ Ejercicio: 9:45 → kwart ___ tien. (Respuesta: voor. Y ojo: se nombra tien, no negen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'las nueve y cuarto (9:15)' AND notes = 'hora: 9:15 - kwart over negen');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve y cuarto (9:15)' AND notes = 'hora: 9:15 - kwart over negen' LIMIT 1),
    'nl_NL', 'Het is kwart over negen.', 'Et is kuart ofer nejen.',
    '• [can.] Het is kwart over negen. — Son las nueve y cuarto.
• [can.] We beginnen om kwart over negen. — Empezamos a las nueve y cuarto.
• [vraag] Is het al kwart over negen? — ¿Ya son las nueve y cuarto?
• [can.] Ik moet nog een kwartier wachten. — Todavía tengo que esperar un cuarto de hora.
• [inv.] Om kwart over negen ging de telefoon. — A las nueve y cuarto sonó el teléfono.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve y cuarto (9:15)' AND notes = 'hora: 9:15 - kwart over negen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve y cuarto (9:15)' AND notes = 'hora: 9:15 - kwart over negen' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 04) 9:19 - elf voor half tien (el salto al tramo voor half)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las nueve y diecinueve (9:19)', 'PHRASE', 'hora: 9:19 - elf voor half tien (tramo voor half)', '9:19 = elf voor half tien. A partir del minuto 16 el neerlandes deja de contar desde las nueve y cuenta hacia ATRAS desde las nueve y media: 30 - 19 = 11 minutos antes de half tien.
@@KLOK@@
📐 Estructura: [30 menos el minuto] + voor + half + [hora siguiente]. El numero es la DIFERENCIA con la media, no el minuto del reloj.

⚠️ Este es el tramo que nadie ve venir: entre el :16 y el :29 la referencia deja de ser la hora en curso y pasa a ser la media. Si te sale «negentien over negen», es traduccion del espanol, no neerlandes.

⚠️ Cuidado con las dos restas del reloj: aqui restas a 30 (voor half), pero del :46 al :59 restas a 60 (voor la hora siguiente). Confundirlas es el error tipico.

🏋️ Ejercicio: 9:22 → ___ voor half tien. (Respuesta: acht. 30 - 22 = 8.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'las nueve y diecinueve (9:19)' AND notes = 'hora: 9:19 - elf voor half tien (tramo voor half)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve y diecinueve (9:19)' AND notes = 'hora: 9:19 - elf voor half tien (tramo voor half)' LIMIT 1),
    'nl_NL', 'Het is elf voor half tien.', 'Et is elf for alf tin.',
    '• [can.] Het is elf voor half tien. — Son las nueve y diecinueve.
• [vraag] Hoe laat is het? Elf voor half tien. — ¿Qué hora es? Las nueve y diecinueve.
• [can.] De trein vertrekt om elf voor half tien. — El tren sale a las nueve y diecinueve.
• [inv.] Om tien voor half tien belde hij me op. — A las nueve y veinte me llamó.
• [uitdr.] Het is bijna half tien, we moeten gaan. — Casi son las nueve y media, nos vamos.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve y diecinueve (9:19)' AND notes = 'hora: 9:19 - elf voor half tien (tramo voor half)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve y diecinueve (9:19)' AND notes = 'hora: 9:19 - elf voor half tien (tramo voor half)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 05) 9:30 - half tien (LA trampa)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las nueve y media (9:30)', 'PHRASE', 'hora: 9:30 - half tien (la trampa)', 'half tien = 9:30, NO las diez y media. El neerlandes cuenta la media HACIA la hora siguiente: half tien = media hora para las diez.
@@KLOK@@
📐 Estructura: half + [hora siguiente]. Sin numero delante y sin uur detras.

⚠️ LA trampa del reloj neerlandes: half tien = 9:30 · half elf = 10:30 · half een = 12:30. Regla mental: al numero que oigas, restale una hora. Si te citan om half tien y apareces a las 10:30, llegas una hora tarde.

⚠️ Funciona igual que el aleman (halb zehn) y al reves que el ingles (half past nine = 9:30 pero contando desde las nueve).

🏋️ Ejercicio: 7:30 → half ___. (Respuesta: acht. La media apunta a la hora siguiente.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'las nueve y media (9:30)' AND notes = 'hora: 9:30 - half tien (la trampa)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve y media (9:30)' AND notes = 'hora: 9:30 - half tien (la trampa)' LIMIT 1),
    'nl_NL', 'Het is half tien.', 'Et is alf tin.',
    '• [can.] Het is half tien. — Son las nueve y media.
• [can.] De film begint om half negen. — La película empieza a las ocho y media.
• [vraag] Zullen we om half elf afspreken? — ¿Quedamos a las diez y media?
• [can.] Ik sta elke dag om half zeven op. — Me levanto todos los días a las seis y media.
• [uitdr.] Het is al bijna half tien. — Ya casi son las nueve y media.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve y media (9:30)' AND notes = 'hora: 9:30 - half tien (la trampa)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las nueve y media (9:30)' AND notes = 'hora: 9:30 - half tien (la trampa)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 06) 9:37 - zeven over half tien (tramo over half)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las diez menos veintitrés (9:37)', 'PHRASE', 'hora: 9:37 - zeven over half tien (tramo over half)', 'Pasada la media, el neerlandes sigue contando DESDE la media: minutos + over half + hora siguiente. 9:37 son siete minutos pasada half tien → zeven over half tien.
@@KLOK@@
📐 Estructura: [minuto menos 30] + over + half + [hora siguiente]. 37 - 30 = 7.

⚠️ Aqui se cruzan los dos idiomas: el espanol ya cuenta hacia atras (las diez menos veintitres) y el neerlandes todavia cuenta hacia delante desde la media. No traduzcas: recalcula desde el reloj.

⚠️ Este tramo llega hasta el :44. En el :45 se cambia otra vez de referencia y se pasa a kwart voor + hora siguiente.

🏋️ Ejercicio: 9:35 → ___ over half tien. (Respuesta: vijf. 35 - 30 = 5.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'las diez menos veintitrés (9:37)' AND notes = 'hora: 9:37 - zeven over half tien (tramo over half)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'las diez menos veintitrés (9:37)' AND notes = 'hora: 9:37 - zeven over half tien (tramo over half)' LIMIT 1),
    'nl_NL', 'Het is zeven over half tien.', 'Et is sefen ofer alf tin.',
    '• [can.] Het is zeven over half tien. — Son las diez menos veintitrés.
• [can.] De les eindigt om vijf over half tien. — La clase acaba a las nueve treinta y cinco.
• [vraag] Was het tien over half tien? — ¿Eran las nueve cuarenta?
• [inv.] Om vijf over half tien stond ik al buiten. — A las nueve treinta y cinco ya estaba fuera.
• [uitdr.] Even na half tien belde ze. — Llamó justo pasadas las nueve y media.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las diez menos veintitrés (9:37)' AND notes = 'hora: 9:37 - zeven over half tien (tramo over half)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las diez menos veintitrés (9:37)' AND notes = 'hora: 9:37 - zeven over half tien (tramo over half)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 07) 9:45 - kwart voor tien
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las diez menos cuarto (9:45)', 'PHRASE', 'hora: 9:45 - kwart voor tien', 'kwart voor tien = 9:45. En el :45 el reloj se agarra ya del todo a la hora siguiente: kwart voor + hora que viene.
@@KLOK@@
📐 Estructura: kwart + voor + [hora siguiente]. Sin uur y sin articulo.

⚠️ Fijate en el numero: en «kwart voor tien» aparece TIEN aunque sean las nueve y algo. En neerlandes, del :16 en adelante la hora que se nombra es siempre la SIGUIENTE — por eso hay que oir la frase entera antes de mirar el reloj.

⚠️ En el habla se elide lo evidente: Ik ben er om kwart voor (estoy alli a menos cuarto), cuando la hora ya se sabe.

🏋️ Ejercicio: 10:45 → kwart voor ___. (Respuesta: elf. Siempre la hora siguiente.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'las diez menos cuarto (9:45)' AND notes = 'hora: 9:45 - kwart voor tien');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'las diez menos cuarto (9:45)' AND notes = 'hora: 9:45 - kwart voor tien' LIMIT 1),
    'nl_NL', 'Het is kwart voor tien.', 'Et is kuart for tin.',
    '• [can.] Het is kwart voor tien. — Son las diez menos cuarto.
• [can.] De winkel sluit om kwart voor zes. — La tienda cierra a las seis menos cuarto.
• [vraag] Red je het om kwart voor tien? — ¿Llegas para las diez menos cuarto?
• [inv.] Om kwart voor tien vertrok de laatste bus. — A las diez menos cuarto salió el último bus.
• [uitdr.] Ik ben er om kwart voor. — Estoy allí a menos cuarto.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las diez menos cuarto (9:45)' AND notes = 'hora: 9:45 - kwart voor tien' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las diez menos cuarto (9:45)' AND notes = 'hora: 9:45 - kwart voor tien' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 08) 9:57 - drie voor tien (tramo voor, :46-:59)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las diez menos tres (9:57)', 'PHRASE', 'hora: 9:57 - drie voor tien (tramo voor)', 'Del :46 al :59 se dice lo que FALTA para la hora siguiente: minutos + voor + hora. 60 - 57 = 3 → drie voor tien.
@@KLOK@@
📐 Estructura: [60 menos el minuto] + voor + [hora siguiente].

⚠️ Las dos restas del reloj, juntas para no mezclarlas: entre :16 y :29 restas a 30 y dices voor HALF (9:22 → acht voor half tien); entre :46 y :59 restas a 60 y dices voor a secas (9:57 → drie voor tien).

⚠️ Expresion util: het is vijf voor twaalf (literal: las doce menos cinco) = estamos al filo, es la ultima oportunidad.

🏋️ Ejercicio: 9:50 → ___ voor tien. (Respuesta: tien. 60 - 50 = 10.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'las diez menos tres (9:57)' AND notes = 'hora: 9:57 - drie voor tien (tramo voor)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'las diez menos tres (9:57)' AND notes = 'hora: 9:57 - drie voor tien (tramo voor)' LIMIT 1),
    'nl_NL', 'Het is drie voor tien.', 'Et is dri for tin.',
    '• [can.] Het is drie voor tien. — Son las diez menos tres.
• [can.] De trein komt om vijf voor tien aan. — El tren llega a las diez menos cinco.
• [vraag] Hoe laat? Twee voor tien? — ¿A qué hora? ¿Las diez menos dos?
• [inv.] Om een minuut voor tien belde hij nog. — A las diez menos un minuto todavía llamó.
• [uitdr.] Het is vijf voor twaalf. — Estamos al filo, es la última oportunidad.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las diez menos tres (9:57)' AND notes = 'hora: 9:57 - drie voor tien (tramo voor)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las diez menos tres (9:57)' AND notes = 'hora: 9:57 - drie voor tien (tramo voor)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 09) ¿que hora es? - Hoe laat is het?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿qué hora es?', 'PHRASE', 'hora: pregunta - hoe laat is het', 'Hoe laat is het? = ¿que hora es? Literalmente «¿que tarde es?». No existe «Wat is de tijd?» ni «Welk uur is het?».
@@KLOK@@
📐 Estructura: Hoe laat + is (2a posicion) + het. El interrogativo ocupa la 1a posicion y el verbo va justo detras.

⚠️ Si la pregunta va DENTRO de otra frase (subordinada), el verbo se marcha al final: Weet jij soms hoe laat HET IS? — es la tarjeta 386, la misma pregunta con otro orden. Ese cambio de orden es el sello de la bijzin.

⚠️ Familia: Hoe laat begint het? (¿a que hora empieza?) · Hoe laat kom je aan? (¿a que hora llegas?) · Heb je de tijd? (¿tienes hora?) · Mijn horloge loopt voor/achter (mi reloj adelanta/atrasa).

🏋️ Ejercicio: «¿sabes que hora es?» → Weet je hoe laat het ___? (Respuesta: is, al final: es subordinada.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿qué hora es?' AND notes = 'hora: pregunta - hoe laat is het');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¿qué hora es?' AND notes = 'hora: pregunta - hoe laat is het' LIMIT 1),
    'nl_NL', 'Hoe laat is het?', 'U lat is et?',
    '• [vraag] Hoe laat is het? — ¿Qué hora es?
• [vraag] Sorry, weet u hoe laat het is? — Perdone, ¿sabe qué hora es?
• [vraag] Hoe laat begint de film? — ¿A qué hora empieza la película?
• [vraag] Heb je de tijd voor me? — ¿Me dices la hora?
• [can.] Mijn horloge loopt vijf minuten voor. — Mi reloj va cinco minutos adelantado.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿qué hora es?' AND notes = 'hora: pregunta - hoe laat is het' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿qué hora es?' AND notes = 'hora: pregunta - hoe laat is het' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 10) om + hora (a las)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el tren sale a las diez menos cuarto (9:45)', 'PHRASE', 'hora: om + hora (a las)', '«A las» es OM, siempre, por compuesta que sea la hora: om kwart voor tien. Es la preposicion fija del reloj.
@@KLOK@@
📐 Estructura: sujeto + verbo + om + [hora] (+ resto). Si adelantas la hora, inversion: Om kwart voor tien vertrekt de trein.

⚠️ El reparto de preposiciones: om (hora exacta) · rond / omstreeks (alrededor de) · tegen (hacia, poco antes) · vanaf (a partir de) · tot (hasta) · tussen ... en ... (entre). Para el reloj NUNCA se usa op; op es para el dia: op maandag, op 3 mei.

⚠️ En horarios oficiales oiras la version digital: de trein van negen uur vijfenveertig (el tren de las 9:45).

🏋️ Ejercicio: «quedamos a las ocho y media» → We spreken ___ half negen af. (Respuesta: om.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el tren sale a las diez menos cuarto (9:45)' AND notes = 'hora: om + hora (a las)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el tren sale a las diez menos cuarto (9:45)' AND notes = 'hora: om + hora (a las)' LIMIT 1),
    'nl_NL', 'De trein vertrekt om kwart voor tien.', 'De trein fertrekt om kuart for tin.',
    '• [can.] De trein vertrekt om kwart voor tien. — El tren sale a las diez menos cuarto.
• [inv.] Om half negen begint mijn werk. — A las ocho y media empieza mi trabajo.
• [can.] De winkel is open vanaf negen uur. — La tienda abre a partir de las nueve.
• [can.] We zijn er tussen zevenen en achten. — Estamos allí entre las siete y las ocho.
• [vraag] Hoe laat vertrekt de volgende? — ¿A qué hora sale el siguiente?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tren sale a las diez menos cuarto (9:45)' AND notes = 'hora: om + hora (a las)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tren sale a las diez menos cuarto (9:45)' AND notes = 'hora: om + hora (a las)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 11) aproximar: een uur of tien / tegen tienen
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'llego sobre las diez', 'PHRASE', 'hora: aproximar - een uur of tien', '«Sobre las diez» es een uur of tien (literalmente «una hora o diez»). Es la formula coloquial mas holandesa para aproximar, y la primera vez desconcierta.
@@KLOK@@
📐 Estructura: om + een uur of + [hora]. Tambien vale sin om: Ik kom een uur of tien.

⚠️ Escala de precision: precies (exacto) → om (a las) → rond / omstreeks (alrededor de, omstreeks es formal) → een uur of (sobre) → tegen (hacia, un poco antes) → ruim na (bastante despues de).

⚠️ tegen y rond piden la hora en -en cuando van solas: tegen tienen, tegen enen, rond zevenen. Solo con horas, nunca con minutos.

🏋️ Ejercicio: «sobre las tres» → een uur ___ drie. (Respuesta: of.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'llego sobre las diez' AND notes = 'hora: aproximar - een uur of tien');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'llego sobre las diez' AND notes = 'hora: aproximar - een uur of tien' LIMIT 1),
    'nl_NL', 'Ik kom om een uur of tien.', 'Ik kom om en ur of tin.',
    '• [can.] Ik kom om een uur of tien. — Llego sobre las diez.
• [inv.] Tegen tienen ben ik thuis. — Hacia las diez estoy en casa.
• [vraag] Zullen we rond acht uur eten? — ¿Cenamos sobre las ocho?
• [can.] Hij belde omstreeks half elf. — Llamó alrededor de las diez y media.
• [uitdr.] Het duurt nog een uur of twee. — Todavía queda como un par de horas.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'llego sobre las diez' AND notes = 'hora: aproximar - een uur of tien' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'llego sobre las diez' AND notes = 'hora: aproximar - een uur of tien' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 12) franja del dia + reloj de 24 h
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'son las nueve de la noche (21:00)', 'PHRASE', 'hora: franja del dia - negen uur s avonds', 'Al hablar, el neerlandes usa el reloj de 12 y aclara la franja: negen uur ''s avonds = 21:00. El apostrofo es un resto del viejo genitivo «des».
@@KLOK@@
📐 Estructura: [hora] + ''s ochtends / ''s middags / ''s avonds / ''s nachts, siempre detras de la hora.

⚠️ Las franjas: ''s ochtends (de 6 a 12) · ''s middags (de 12 a 18) · ''s avonds (de 18 a 24) · ''s nachts (de 0 a 6). Ojo, no las confundas con vanochtend / vanmiddag / vanavond / vannacht, que son las de HOY concretas.

⚠️ El reloj de 24 h existe, pero es escrito y oficial (horarios, entradas, citas medicas): 21:00 = eenentwintig uur, 13:15 = dertien uur vijftien. Nadie lo usa charlando.

🏋️ Ejercicio: «a las siete de la manana» → om zeven uur ___. (Respuesta: ''s ochtends.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'son las nueve de la noche (21:00)' AND notes = 'hora: franja del dia - negen uur s avonds');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'son las nueve de la noche (21:00)' AND notes = 'hora: franja del dia - negen uur s avonds' LIMIT 1),
    'nl_NL', 'Het is negen uur ''s avonds.', 'Et is nejen ur s afonds.',
    '• [can.] Het is negen uur ''s avonds. — Son las nueve de la noche.
• [can.] Ik werk van negen uur ''s ochtends tot vijf uur ''s middags. — Trabajo de nueve de la mañana a cinco de la tarde.
• [vraag] Bel je me vanavond om acht uur? — ¿Me llamas esta noche a las ocho?
• [can.] De trein van eenentwintig uur is de laatste. — El tren de las 21:00 es el último.
• [inv.] Om drie uur ''s nachts sliep iedereen nog. — A las tres de la madrugada todos dormían aún.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'son las nueve de la noche (21:00)' AND notes = 'hora: franja del dia - negen uur s avonds' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'son las nueve de la noche (21:00)' AND notes = 'hora: franja del dia - negen uur s avonds' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- BLOQUE COMPARTIDO: el mapa del reloj
-- Se escribe una sola vez y se inyecta en las 12 tarjetas. Idempotente: tras la
-- primera pasada ya no queda marcador que sustituir.
-- ==============================================================================
UPDATE words_es
SET rules_help = REPLACE(rules_help, '@@KLOK@@', '🕰️ El reloj neerlandes de un vistazo:
• La clave: el reloj cuelga de la MEDIA, y la media pertenece a la hora SIGUIENTE. half tien = 9:30.
• :01-:15 → minutos + over + hora. vijf over negen (9:05) · kwart over negen (9:15).
• :16-:29 → [30 menos el minuto] + voor half + hora siguiente. 9:20 → tien voor half tien.
• :30 → half + hora siguiente. half tien = 9:30.
• :31-:44 → [minuto menos 30] + over half + hora siguiente. 9:35 → vijf over half tien.
• :45 → kwart voor + hora siguiente. kwart voor tien = 9:45.
• :46-:59 → [60 menos el minuto] + voor + hora siguiente. 9:55 → vijf voor tien.
⚠️ La trampa: half tien NO es las diez y media. Si te citan om half tien y apareces a las 10:30, llegas una hora tarde.
⚠️ Las dos restas: del :16 al :29 restas a 30 (voor half) y del :46 al :59 restas a 60 (voor). Mezclarlas es el error tipico.
🔢 Version digital (trenes, horarios, citas oficiales): negen uur negentien, y en 24 h eenentwintig uur negentien. Se entiende siempre, pero al hablar suena a locutor.
🕘 Aproximar: een uur of tien (sobre las diez) · tegen tienen (hacia las diez) · rond tien uur · omstreeks tien uur (formal) · bijna tien uur (casi) · ruim na tienen (pasadas de largo).
☀️ Franja del dia: ''s ochtends (manana) · ''s middags (mediodia y primera tarde) · ''s avonds (noche) · ''s nachts (madrugada). negen uur ''s avonds = 21:00.
📌 Con preposicion, siempre OM: om negen uur, om kwart over negen, om half tien. Nunca «op negen uur» (op es para el dia: op maandag). Y para preguntar, hoe laat: Hoe laat is het?
🔟 Horas en -en (solo en aproximaciones y con over/voor sueltos): tegen tienen, rond enen, over negenen, tussen zevenen en achten.')
WHERE id IN (
    SELECT word_es_id FROM word_es_groups
    WHERE group_id = (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het')
)
AND rules_help LIKE '%@@KLOK@@%';
