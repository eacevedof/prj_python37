-- Learn Languages App - Grupo "cambio de estado y pasiva con se - worden"
-- Migration: 20260807000002-create-worden-change-passive-group.sql
-- Description: 15 frases sobre WORDEN como equivalente de dos usos del «se» espanol:
--   (1) CAMBIO DE ESTADO (ponerse/volverse/hacerse y los -arse: moe/boos/ziek/verliefd
--   worden) y (2) PASIVA/IMPERSONAL con se (se vende/se dice/aqui no se fuma = wordt
--   verkocht / er wordt gezegd / hier wordt niet gerookt). Eje transversal: el contraste
--   worden (PROCESO/cambio) vs zijn (RESULTADO/estado), que es EL error tipico del
--   hispanohablante (traducir con zijn lo que es worden y al reves). Cada tarjeta lleva:
--   nota propia + bloque compartido (worden y el se + worden vs zijn + truco) + 📐 formula
--   + 🧭 ejemplo + 🏋️ ejercicio (traducir eligiendo worden o zijn, con respuesta).
--   Pronunciation aproximada estilo DutchToSpanishPhoneticService. 100% aditiva e
--   IDEMPOTENTE (INSERT ... WHERE NOT EXISTS / OR IGNORE). No toca audios ni imagenes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'cambio de estado y pasiva con se - worden',
    'El «se» espanol con worden: cambio de estado (ponerse/volverse/hacerse y los -arse: moe/boos/ziek/verliefd worden = cansarse/enfadarse/ponerse enfermo/enamorarse) y pasiva impersonal (se vende/se dice/aqui no se fuma = wordt verkocht / er wordt gezegd / hier wordt niet gerookt); mas el contraste clave worden (proceso/cambio) vs zijn (estado/resultado) = el error tipico del hispanohablante, con ejercicios',
    'migracion'
);

-- ==============================================================================
-- 1) moe worden = cansarse
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me canso de tanto andar', 'PHRASE', 'worden: moe worden (cansarse)', 'moe worden = cansarse (cambio de estado). Ik word moe = me canso / me estoy cansando. van = de (la causa). Compara: Ik ben moe = estoy cansado (estado, ya cansado).

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO (te vuelves / se esta haciendo): Ik word moe = me estoy cansando · Het wordt koud = se esta enfriando.
• zijn = el RESULTADO/estado (ya es / esta): Ik ben moe = estoy cansado · Het is koud = esta frio.
Truco: si en espanol dices «me pongo / me vuelvo / cambio (-arse)» → worden; si dices «estoy / ya es» → zijn. «cansarse» = worden; «estar cansado» = zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Presente (cambio de estado): sujeto + word (2a posicion) + adjetivo (moe) + causa (van al dat lopen).

🧭 Cuando usarlo: quejarte de que algo te cansa. Ej.: → Ik word moe van al dat lopen (me canso de tanto andar).

🏋️ Ejercicio: «Estoy cansado» → Ik ___ moe. · «Me estoy cansando» → Ik ___ moe. (Respuestas: ben / word. Estado = ben, cambio = word.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'me canso de tanto andar' AND notes = 'worden: moe worden (cansarse)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'me canso de tanto andar' AND notes = 'worden: moe worden (cansarse)' LIMIT 1),
    'nl_NL', 'Ik word moe van al dat lopen.', 'Ik uort mu fan al dat lopen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me canso de tanto andar' AND notes = 'worden: moe worden (cansarse)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me canso de tanto andar' AND notes = 'worden: moe worden (cansarse)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 2) boos worden = enfadarse
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'se enfada enseguida', 'PHRASE', 'worden: boos worden (enfadarse)', 'boos worden = enfadarse (cambio de estado). Hij wordt snel boos = se enfada enseguida. snel = rapido. Estado: hij is boos = esta enfadado.

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO (te vuelves / se esta haciendo): Ik word moe = me estoy cansando · Het wordt koud = se esta enfriando.
• zijn = el RESULTADO/estado (ya es / esta): Ik ben moe = estoy cansado · Het is koud = esta frio.
Truco: si en espanol dices «me pongo / me vuelvo / cambio (-arse)» → worden; si dices «estoy / ya es» → zijn. «cansarse» = worden; «estar cansado» = zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Presente: sujeto + wordt (2a posicion) + snel + boos.

🧭 Cuando usarlo: describir a alguien que salta enseguida. Ej.: → Hij wordt snel boos, maar het gaat ook snel over (se enfada enseguida, pero se le pasa rapido).

🏋️ Ejercicio: «Esta enfadado» → Hij ___ boos. · «Se enfada» → Hij ___ boos. (Respuestas: is / wordt.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'se enfada enseguida' AND notes = 'worden: boos worden (enfadarse)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'se enfada enseguida' AND notes = 'worden: boos worden (enfadarse)' LIMIT 1),
    'nl_NL', 'Hij wordt snel boos.', 'Hei uort snel bos.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se enfada enseguida' AND notes = 'worden: boos worden (enfadarse)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se enfada enseguida' AND notes = 'worden: boos worden (enfadarse)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 3) ziek worden = ponerse enfermo (perfecto con zijn)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me he puesto enfermo', 'PHRASE', 'worden: ziek worden (ponerse enfermo, perfecto zijn)', 'ziek worden = ponerse enfermo / enfermar. Perfecto con ZIJN → Ik ben ziek geworden = me he puesto enfermo. OJO: ik ben ziek = estoy enfermo (estado); ik ben ziek geworden = me puse enfermo (cambio). El mismo «ben», lo que cambia es «geworden».

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO (te vuelves / se esta haciendo): Ik word moe = me estoy cansando · Het wordt koud = se esta enfriando.
• zijn = el RESULTADO/estado (ya es / esta): Ik ben moe = estoy cansado · Het is koud = esta frio.
Truco: si en espanol dices «me pongo / me vuelvo / cambio (-arse)» → worden; si dices «estoy / ya es» → zijn. «cansarse» = worden; «estar cansado» = zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Perfecto (cambio de estado): sujeto + ben + adjetivo (ziek) + geworden al final. Auxiliar zijn.

🧭 Cuando usarlo: contar que caiste enfermo. Ej.: → Ik kon niet komen, ik ben ziek geworden (no pude venir, me puse enfermo).

🏋️ Ejercicio: «Estoy enfermo» → Ik ben ziek. · «Me he puesto enfermo» → Ik ben ziek ___. (Respuesta: geworden. Sin geworden = estado; con geworden = el cambio.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'me he puesto enfermo' AND notes = 'worden: ziek worden (ponerse enfermo, perfecto zijn)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'me he puesto enfermo' AND notes = 'worden: ziek worden (ponerse enfermo, perfecto zijn)' LIMIT 1),
    'nl_NL', 'Ik ben ziek geworden.', 'Ik ben sik jeuorden.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me he puesto enfermo' AND notes = 'worden: ziek worden (ponerse enfermo, perfecto zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me he puesto enfermo' AND notes = 'worden: ziek worden (ponerse enfermo, perfecto zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 4) verliefd worden op = enamorarse de
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'se enamoro de el', 'PHRASE', 'worden: verliefd worden op (enamorarse de)', 'verliefd worden op = enamorarse DE. La preposicion es OP, no «van». Ze werd verliefd op hem = se enamoro de el. werd = pasado de worden. Estado: ze is verliefd = esta enamorada.

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO (te vuelves / se esta haciendo): Ik word moe = me estoy cansando · Het wordt koud = se esta enfriando.
• zijn = el RESULTADO/estado (ya es / esta): Ik ben moe = estoy cansado · Het is koud = esta frio.
Truco: si en espanol dices «me pongo / me vuelvo / cambio (-arse)» → worden; si dices «estoy / ya es» → zijn. «cansarse» = worden; «estar cansado» = zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Pasado: sujeto + werd + verliefd + op + persona (hem).

🧭 Cuando usarlo: contar de quien se enamoro alguien. Ej.: → Ze werd verliefd op hem tijdens de vakantie (se enamoro de el en las vacaciones).

🏋️ Ejercicio: «Esta enamorada de el» → Ze ___ verliefd op hem. · «Se enamoro de el» → Ze ___ verliefd op hem. (Respuestas: is / werd. Y la preposicion es op, no van.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'se enamoro de el' AND notes = 'worden: verliefd worden op (enamorarse de)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'se enamoro de el' AND notes = 'worden: verliefd worden op (enamorarse de)' LIMIT 1),
    'nl_NL', 'Ze werd verliefd op hem.', 'Se uert ferlift op em.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se enamoro de el' AND notes = 'worden: verliefd worden op (enamorarse de)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se enamoro de el' AND notes = 'worden: verliefd worden op (enamorarse de)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 5) rustig worden = calmarse (imperativo)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'calmate', 'PHRASE', 'worden: rustig worden (calmarse, imperativo)', 'rustig worden = calmarse / tranquilizarse (cambio de estado). Imperativo: Word eens rustig! = calmate! eens suaviza (venga). Estado ya alcanzado: wees rustig = esta tranquilo.

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO (te vuelves / se esta haciendo): Ik word moe = me estoy cansando · Het wordt koud = se esta enfriando.
• zijn = el RESULTADO/estado (ya es / esta): Ik ben moe = estoy cansado · Het is koud = esta frio.
Truco: si en espanol dices «me pongo / me vuelvo / cambio (-arse)» → worden; si dices «estoy / ya es» → zijn. «cansarse» = worden; «estar cansado» = zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Imperativo: Word (1a posicion) + eens + rustig.

🧭 Cuando usarlo: pedir a alguien que se calme. Ej.: → Word eens rustig, we lossen het op (calmate, lo solucionamos).

🏋️ Ejercicio: «Calmate» (el cambio) → ___ eens rustig! (Respuesta: Word.) Nota: «estate tranquilo» seria Wees rustig.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'calmate' AND notes = 'worden: rustig worden (calmarse, imperativo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'calmate' AND notes = 'worden: rustig worden (calmarse, imperativo)' LIMIT 1),
    'nl_NL', 'Word eens rustig!', 'Uort ens rustej!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'calmate' AND notes = 'worden: rustig worden (calmarse, imperativo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'calmate' AND notes = 'worden: rustig worden (calmarse, imperativo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 6) wakker worden = despertarse
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me desperte temprano', 'PHRASE', 'worden: wakker worden (despertarse)', 'wakker worden = despertarse (el cambio: pasar a estar despierto). Ik werd vroeg wakker = me desperte temprano. Estado: ik ben wakker = estoy despierto. Distinto de opstaan = levantarse (salir de la cama).

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO (te vuelves / se esta haciendo): Ik word moe = me estoy cansando · Het wordt koud = se esta enfriando.
• zijn = el RESULTADO/estado (ya es / esta): Ik ben moe = estoy cansado · Het is koud = esta frio.
Truco: si en espanol dices «me pongo / me vuelvo / cambio (-arse)» → worden; si dices «estoy / ya es» → zijn. «cansarse» = worden; «estar cansado» = zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Pasado: sujeto + werd + tiempo (vroeg) + wakker.

🧭 Cuando usarlo: contar a que hora te despertaste. Ej.: → Ik werd vroeg wakker door de vogels (me desperte temprano por los pajaros).

🏋️ Ejercicio: «Estoy despierto» → Ik ___ wakker. · «Me desperte» → Ik ___ wakker. (Respuestas: ben / werd.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'me desperte temprano' AND notes = 'worden: wakker worden (despertarse)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'me desperte temprano' AND notes = 'worden: wakker worden (despertarse)' LIMIT 1),
    'nl_NL', 'Ik werd vroeg wakker.', 'Ik uert fruj uakker.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me desperte temprano' AND notes = 'worden: wakker worden (despertarse)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me desperte temprano' AND notes = 'worden: wakker worden (despertarse)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 7) verkouden worden = resfriarse
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'te vas a resfriar', 'PHRASE', 'worden: verkouden worden (resfriarse)', 'verkouden worden = resfriarse / acatarrarse. Straks word je verkouden = te vas a resfriar. straks = luego/ahora (aviso). Estado: ik ben verkouden = estoy resfriado.

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO (te vuelves / se esta haciendo): Ik word moe = me estoy cansando · Het wordt koud = se esta enfriando.
• zijn = el RESULTADO/estado (ya es / esta): Ik ben moe = estoy cansado · Het is koud = esta frio.
Truco: si en espanol dices «me pongo / me vuelvo / cambio (-arse)» → worden; si dices «estoy / ya es» → zijn. «cansarse» = worden; «estar cansado» = zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Presente con aviso: straks + word + je + verkouden.

🧭 Cuando usarlo: advertir a alguien que se abrigue. Ej.: → Trek een jas aan, straks word je verkouden (ponte una chaqueta, que te vas a resfriar).

🏋️ Ejercicio: «Estoy resfriado» → Ik ___ verkouden. · «Me voy a resfriar» → Straks ___ ik verkouden. (Respuestas: ben / word.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'te vas a resfriar' AND notes = 'worden: verkouden worden (resfriarse)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'te vas a resfriar' AND notes = 'worden: verkouden worden (resfriarse)' LIMIT 1),
    'nl_NL', 'Straks word je verkouden.', 'Straks uort ye ferkauden.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'te vas a resfriar' AND notes = 'worden: verkouden worden (resfriarse)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'te vas a resfriar' AND notes = 'worden: verkouden worden (resfriarse)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 8) oud worden = hacerse viejo / envejecer
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'todos envejecemos', 'PHRASE', 'worden: oud worden (hacerse viejo)', 'oud worden = hacerse viejo / envejecer. Iedereen wordt oud = todos envejecemos. iedereen = todo el mundo (lleva verbo en singular: wordt). Estado: hij is oud = es viejo.

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO (te vuelves / se esta haciendo): Ik word moe = me estoy cansando · Het wordt koud = se esta enfriando.
• zijn = el RESULTADO/estado (ya es / esta): Ik ben moe = estoy cansado · Het is koud = esta frio.
Truco: si en espanol dices «me pongo / me vuelvo / cambio (-arse)» → worden; si dices «estoy / ya es» → zijn. «cansarse» = worden; «estar cansado» = zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Presente: sujeto (iedereen) + wordt + oud.

🧭 Cuando usarlo: reflexionar sobre la edad. Ej.: → Iedereen wordt oud, dat is normaal (todos envejecemos, es normal).

🏋️ Ejercicio: «Es viejo» → Hij ___ oud. · «Se hace viejo / envejece» → Hij ___ oud. (Respuestas: is / wordt.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'todos envejecemos' AND notes = 'worden: oud worden (hacerse viejo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'todos envejecemos' AND notes = 'worden: oud worden (hacerse viejo)' LIMIT 1),
    'nl_NL', 'Iedereen wordt oud.', 'Ideren uort aut.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'todos envejecemos' AND notes = 'worden: oud worden (hacerse viejo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'todos envejecemos' AND notes = 'worden: oud worden (hacerse viejo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 9) gek worden = volverse loco
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me vuelvo loco con este ruido', 'PHRASE', 'worden: gek worden (volverse loco)', 'gek worden = volverse loco. Ik word gek van dit lawaai = me vuelvo loco con este ruido. van = de/con (la causa). lawaai = ruido. Estado: hij is gek = esta loco.

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO (te vuelves / se esta haciendo): Ik word moe = me estoy cansando · Het wordt koud = se esta enfriando.
• zijn = el RESULTADO/estado (ya es / esta): Ik ben moe = estoy cansado · Het is koud = esta frio.
Truco: si en espanol dices «me pongo / me vuelvo / cambio (-arse)» → worden; si dices «estoy / ya es» → zijn. «cansarse» = worden; «estar cansado» = zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Presente: sujeto + word + gek + van + causa (dit lawaai).

🧭 Cuando usarlo: expresar hartazgo. Ej.: → Ik word gek van dit lawaai! (me vuelvo loco con este ruido!).

🏋️ Ejercicio: «Esta loco» → Hij ___ gek. · «Me vuelvo loco» → Ik ___ gek. (Respuestas: is / word.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'me vuelvo loco con este ruido' AND notes = 'worden: gek worden (volverse loco)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'me vuelvo loco con este ruido' AND notes = 'worden: gek worden (volverse loco)' LIMIT 1),
    'nl_NL', 'Ik word gek van dit lawaai.', 'Ik uort jek fan dit lauai.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me vuelvo loco con este ruido' AND notes = 'worden: gek worden (volverse loco)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me vuelvo loco con este ruido' AND notes = 'worden: gek worden (volverse loco)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 10) worden verkocht = se vende (pasiva)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'esta casa se vende', 'PHRASE', 'worden: pasiva se vende (worden verkocht)', 'PASIVA con «se»: se vende = wordt verkocht (worden + participio verkocht). Dit huis wordt verkocht = esta casa se vende. No hay zich; el «se» pasivo espanol = worden. Resultado: het is verkocht = esta vendido (ya).

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO/proceso (se esta haciendo): het wordt verkocht = se vende (esta en venta) · De deur wordt geopend = se esta abriendo.
• zijn = el RESULTADO/estado (ya es / esta): het is verkocht = esta vendido · De deur is open = esta abierta.
Truco: proceso/pasiva en curso → worden; resultado ya alcanzado → zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Pasiva: sujeto (dit huis) + wordt + participio (verkocht) al final.

🧭 Cuando usarlo: un cartel o anuncio. Ej.: → Dit huis wordt verkocht (se vende esta casa).

🏋️ Ejercicio: «Se vende» → Het ___ verkocht. · «Esta vendido» (ya) → Het ___ verkocht. (Respuestas: wordt / is. Proceso = wordt, resultado = is.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'esta casa se vende' AND notes = 'worden: pasiva se vende (worden verkocht)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'esta casa se vende' AND notes = 'worden: pasiva se vende (worden verkocht)' LIMIT 1),
    'nl_NL', 'Dit huis wordt verkocht.', 'Dit haus uort ferkojt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'esta casa se vende' AND notes = 'worden: pasiva se vende (worden verkocht)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'esta casa se vende' AND notes = 'worden: pasiva se vende (worden verkocht)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 11) er wordt gezegd = se dice (impersonal)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'se dice que es rico', 'PHRASE', 'worden: pasiva impersonal se dice (er wordt gezegd)', 'IMPERSONAL con «se»: se dice = er wordt gezegd. Se abre con «er» (sujeto ficticio) + wordt + gezegd. Er wordt gezegd dat hij rijk is = se dice que es rico. rijk = rico.

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO/proceso (se esta haciendo): het wordt verkocht = se vende · De deur wordt geopend = se esta abriendo.
• zijn = el RESULTADO/estado (ya es / esta): het is verkocht = esta vendido · De deur is open = esta abierta.
Truco: proceso/pasiva en curso → worden; resultado ya alcanzado → zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Impersonal: er + wordt + participio (gezegd) + [dat + subordinada (hij rijk is)].

🧭 Cuando usarlo: transmitir un rumor. Ej.: → Er wordt gezegd dat hij rijk is (se dice que es rico).

🏋️ Ejercicio: «Se dice que...» → Er ___ gezegd dat... (Respuesta: wordt.) Recuerda el «er» al principio.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'se dice que es rico' AND notes = 'worden: pasiva impersonal se dice (er wordt gezegd)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'se dice que es rico' AND notes = 'worden: pasiva impersonal se dice (er wordt gezegd)' LIMIT 1),
    'nl_NL', 'Er wordt gezegd dat hij rijk is.', 'Er uort jesejt dat hei reik is.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se dice que es rico' AND notes = 'worden: pasiva impersonal se dice (er wordt gezegd)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se dice que es rico' AND notes = 'worden: pasiva impersonal se dice (er wordt gezegd)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 12) hier wordt Nederlands gesproken = aqui se habla neerlandes
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'aqui se habla neerlandes', 'PHRASE', 'worden: pasiva se habla (hier wordt gesproken)', 'se habla = wordt gesproken. Hier wordt Nederlands gesproken = aqui se habla neerlandes. El «se» impersonal espanol = worden + participio.

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO/proceso (se esta haciendo): het wordt verkocht = se vende · De deur wordt geopend = se esta abriendo.
• zijn = el RESULTADO/estado (ya es / esta): het is verkocht = esta vendido · De deur is open = esta abierta.
Truco: proceso/pasiva en curso → worden; resultado ya alcanzado → zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Impersonal: lugar (hier) + wordt + objeto (Nederlands) + participio (gesproken).

🧭 Cuando usarlo: un cartel informativo. Ej.: → Hier wordt Nederlands gesproken (aqui se habla neerlandes).

🏋️ Ejercicio: «Aqui se habla espanol» → Hier ___ Spaans ___. (Respuestas: wordt / gesproken.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'aqui se habla neerlandes' AND notes = 'worden: pasiva se habla (hier wordt gesproken)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'aqui se habla neerlandes' AND notes = 'worden: pasiva se habla (hier wordt gesproken)' LIMIT 1),
    'nl_NL', 'Hier wordt Nederlands gesproken.', 'Hir uort nederlants jesproken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'aqui se habla neerlandes' AND notes = 'worden: pasiva se habla (hier wordt gesproken)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'aqui se habla neerlandes' AND notes = 'worden: pasiva se habla (hier wordt gesproken)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 13) hier wordt niet gerookt = aqui no se fuma
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'aqui no se fuma', 'PHRASE', 'worden: pasiva impersonal prohibicion (hier wordt niet gerookt)', 'prohibicion impersonal con «se»: aqui no se fuma = hier wordt niet gerookt. worden + niet + participio (gerookt). Muy usado en carteles.

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO/proceso (se esta haciendo): het wordt verkocht = se vende · De deur wordt geopend = se esta abriendo.
• zijn = el RESULTADO/estado (ya es / esta): het is verkocht = esta vendido · De deur is open = esta abierta.
Truco: proceso/pasiva en curso → worden; resultado ya alcanzado → zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Impersonal: lugar (hier) + wordt + niet + participio (gerookt).

🧭 Cuando usarlo: un cartel de norma. Ej.: → Hier wordt niet gerookt (aqui no se fuma).

🏋️ Ejercicio: «Aqui no se fuma» → Hier ___ niet ___. (Respuestas: wordt / gerookt.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'aqui no se fuma' AND notes = 'worden: pasiva impersonal prohibicion (hier wordt niet gerookt)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'aqui no se fuma' AND notes = 'worden: pasiva impersonal prohibicion (hier wordt niet gerookt)' LIMIT 1),
    'nl_NL', 'Hier wordt niet gerookt.', 'Hir uort nit jerokt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'aqui no se fuma' AND notes = 'worden: pasiva impersonal prohibicion (hier wordt niet gerookt)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'aqui no se fuma' AND notes = 'worden: pasiva impersonal prohibicion (hier wordt niet gerookt)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 14) De deur wordt geopend (proceso) vs is open (estado)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la puerta se abre a las nueve', 'PHRASE', 'worden: pasiva se abre vs estado (deur)', 'CONTRASTE clave: De deur wordt geopend = la puerta se abre / esta siendo abierta (PROCESO, pasiva con worden) ≠ De deur is open = la puerta esta abierta (ESTADO, con zijn). El error tipico es usar «is» para el proceso.

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO/proceso (se esta haciendo): De deur wordt geopend = se abre / se esta abriendo.
• zijn = el RESULTADO/estado (ya es / esta): De deur is open = esta abierta.
Truco: proceso/pasiva en curso → worden; resultado ya alcanzado → zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Pasiva con hora: sujeto (de deur) + wordt + tiempo (om negen uur) + participio (geopend).

🧭 Cuando usarlo: informar de un horario de apertura. Ej.: → De deur wordt om negen uur geopend (la puerta se abre a las nueve).

🏋️ Ejercicio: «La puerta se abre a las 9» → De deur ___ om negen uur geopend. · «La puerta esta abierta» → De deur ___ open. (Respuestas: wordt / is.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la puerta se abre a las nueve' AND notes = 'worden: pasiva se abre vs estado (deur)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'la puerta se abre a las nueve' AND notes = 'worden: pasiva se abre vs estado (deur)' LIMIT 1),
    'nl_NL', 'De deur wordt om negen uur geopend.', 'De deur uort om nejen ur jeopent.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la puerta se abre a las nueve' AND notes = 'worden: pasiva se abre vs estado (deur)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la puerta se abre a las nueve' AND notes = 'worden: pasiva se abre vs estado (deur)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 15) Het wordt koud (cambio) vs het is koud (estado)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cierra la puerta que se esta enfriando', 'PHRASE', 'worden: cambio de estado clima (het wordt koud)', 'het wordt koud = se esta enfriando / va a hacer frio (CAMBIO) ≠ het is koud = hace/esta frio (ESTADO). Doe de deur dicht = cierra la puerta. Es el contraste worden/zijn mas cotidiano.

«worden» y el «se» espanol:
El «se» espanol hace dos trabajos que en neerlandes van con WORDEN (nunca con zich):
1) CAMBIO DE ESTADO (ponerse / volverse / hacerse y los -arse): worden + adjetivo → moe worden (cansarse), boos worden (enfadarse), ziek worden (ponerse enfermo), verliefd worden (enamorarse). El «se» desaparece; NO se dice «zich».
2) PASIVA / IMPERSONAL con «se»: worden + participio → het wordt verkocht (se vende), er wordt gezegd (se dice), hier wordt niet gerookt (aqui no se fuma).

⚠️ worden vs zijn — EL error del hispanohablante:
• worden = el CAMBIO (se esta haciendo): Het wordt koud = se esta enfriando · Ik word moe = me estoy cansando.
• zijn = el RESULTADO/estado (ya es / esta): Het is koud = hace/esta frio · Ik ben moe = estoy cansado.
Truco: si en espanol dices «se pone / se esta haciendo / cambio» → worden; si dices «hace / esta / ya es» → zijn.
Perfecto del cambio de estado: con ZIJN → Ik ben ziek geworden (me he puesto enfermo).

📐 Presente (sujeto ficticio): het + wordt + adjetivo (koud).

🧭 Cuando usarlo: comentar que refresca. Ej.: → Doe de deur dicht, het wordt koud (cierra la puerta, que se esta enfriando).

🏋️ Ejercicio: «Hace frio» → Het ___ koud. · «Se esta enfriando / va a hacer frio» → Het ___ koud. (Respuestas: is / wordt.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'cierra la puerta que se esta enfriando' AND notes = 'worden: cambio de estado clima (het wordt koud)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'cierra la puerta que se esta enfriando' AND notes = 'worden: cambio de estado clima (het wordt koud)' LIMIT 1),
    'nl_NL', 'Doe de deur dicht, het wordt koud.', 'Du de deur dijt, het uort kaut.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cierra la puerta que se esta enfriando' AND notes = 'worden: cambio de estado clima (het wordt koud)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'cambio de estado y pasiva con se - worden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cierra la puerta que se esta enfriando' AND notes = 'worden: cambio de estado clima (het wordt koud)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
