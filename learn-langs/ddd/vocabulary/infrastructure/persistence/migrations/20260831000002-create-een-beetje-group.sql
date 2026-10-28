-- Learn Languages App - Grupo "un poco - weinig, een beetje, wat y compania"
-- Migration: 20260831000002-create-een-beetje-group.sql
-- Description: 15 frases cotidianas con las formas de decir «un poco» y lo que de verdad las
--   separa: weinig (escasez, incontables y plurales contables), een beetje (cantidad pequena
--   y marcada), wat (algo de, atono), iets (delante de comparativo), een paar (contables),
--   even / een tijdje (el «un poco» del TIEMPO, que es el error clasico), nauwelijks (apenas),
--   een tikkeltje, enigszins (formal), min of meer, y los tres usos de minder: comparativo de
--   weinig (weinig -> minder -> minst), steeds minder (tendencia) y minder + adjetivo como
--   EUFEMISMO. Nace de la duda sobre «Dit element wordt minder goed bekeken»: minder es
--   comparativo aunque no lleve «dan» detras. Cada tarjeta: nota propia + bloque compartido
--   (mapa + escalera + tres trampas, IDENTICO byte a byte) + formula + ejemplo + ejercicio.
--   Se remite a 704/601 para el reparto fino wat vs een beetje, que ya estaba explicado alli.
--   Pronunciation aproximada estilo DutchToSpanishPhoneticService. 100% aditiva e
--   IDEMPOTENTE (INSERT ... WHERE NOT EXISTS / OR IGNORE).

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'un poco - weinig, een beetje, wat y compania',
    'Las formas de decir «un poco» en neerlandes y lo que las separa: weinig (escasez), een beetje (cantidad pequena y marcada), wat (algo de, atono), iets (delante de comparativo), even (un rato, tiempo y no cantidad) y la escalera weinig -> minder -> minst, con la trampa de minder como comparativo y como eufemismo. 15 frases cotidianas, alternando tiempos y pronombres',
    'migracion'
);

-- ==============================================================================
-- 1) un poco: weinig + incontable (escasez)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Esta semana tengo poco tiempo.', 'PHRASE', 'un poco: weinig + incontable (escasez)', 'weinig = poco, pero con tono de ESCASEZ: dice que hay menos de lo que haria falta. «tijd» es incontable y weinig es su cuantificador natural. No es lo mismo que «wat tijd» (algo de tiempo, neutro y sin queja) ni que «een beetje tijd» (un poquito).

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Complemento de tiempo en la 1a casilla + verbo (2a) + sujeto + weinig + sustantivo.

🧭 Cuando usarlo: quejarte de la agenda. Ej.: → Deze week heb ik weinig tijd, sorry.

🏋️ Ejercicio: «Tengo poco dinero» → Ik heb ___ geld. (Respuesta: weinig, escasez con incontable.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Esta semana tengo poco tiempo.' AND notes = 'un poco: weinig + incontable (escasez)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta semana tengo poco tiempo.' AND notes = 'un poco: weinig + incontable (escasez)' LIMIT 1),
    'nl_NL', 'Deze week heb ik weinig tijd.', 'Deze uek hep ik ueinij teid.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta semana tengo poco tiempo.' AND notes = 'un poco: weinig + incontable (escasez)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta semana tengo poco tiempo.' AND notes = 'un poco: weinig + incontable (escasez)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 2) un poco: weinig + plural contable
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Vino poca gente a la charla.', 'PHRASE', 'un poco: weinig + plural contable', 'weinig tambien va con plurales CONTABLES: weinig mensen = poca gente. Aqui es donde «een beetje» se descarta solo: «een beetje mensen» no existe. La frase arranca con «er» porque el sujeto es indefinido y la informacion nueva se va al final.

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Er + verbo (2a casilla) + weinig + sustantivo plural + resto.

🧭 Cuando usarlo: contar que un acto salio deslucido. Ej.: → Er kwamen weinig mensen naar de lezing, jammer.

🏋️ Ejercicio: «Vinieron pocos ninos» → Er kwamen ___ kinderen. (Respuesta: weinig, plural contable.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Vino poca gente a la charla.' AND notes = 'un poco: weinig + plural contable');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Vino poca gente a la charla.' AND notes = 'un poco: weinig + plural contable' LIMIT 1),
    'nl_NL', 'Er kwamen weinig mensen naar de lezing.', 'Er kuamen ueinij mensen nar de lesinj.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vino poca gente a la charla.' AND notes = 'un poco: weinig + plural contable' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vino poca gente a la charla.' AND notes = 'un poco: weinig + plural contable' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 3) un poco: een beetje + incontable (marca la pequenez)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Échale un poco de azúcar al café.', 'PHRASE', 'un poco: een beetje + incontable (marca la pequenez)', 'een beetje = un poco, y SUBRAYA que es poca cantidad (es el diminutivo de «beet», bocado). Admite acento: «maar EEN BEETJE» = solo un poquito. Con «wat suiker» dirias lo mismo pero sin marcar la pequenez.

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Imperativo (verbo en la 1a casilla) + een beetje + sustantivo + complemento.

🧭 Cuando usarlo: cocinar o servir algo. Ej.: → Doe een beetje suiker in de koffie, niet te veel.

🏋️ Ejercicio: «Ponle un poco de sal» → Doe er ___ zout in. (Respuesta: een beetje, marcando poca cantidad.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Échale un poco de azúcar al café.' AND notes = 'un poco: een beetje + incontable (marca la pequenez)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Échale un poco de azúcar al café.' AND notes = 'un poco: een beetje + incontable (marca la pequenez)' LIMIT 1),
    'nl_NL', 'Doe een beetje suiker in de koffie.', 'Du en betye seuker in de koffi.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Échale un poco de azúcar al café.' AND notes = 'un poco: een beetje + incontable (marca la pequenez)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Échale un poco de azúcar al café.' AND notes = 'un poco: een beetje + incontable (marca la pequenez)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 4) un poco: wat = algo de (atono, neutro)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Me puedes dar algo de agua?', 'PHRASE', 'un poco: wat = algo de (atono, neutro)', 'wat = algo de: es el atono y neutro, no dice si es mucho o poco ni se queja. «wat water» = algo de agua, sin mas. Es el «un poco» por defecto del habla, mucho mas frecuente que een beetje.

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Modal (2a casilla) + sujeto + complementos + wat + sustantivo + infinitivo al final.

🧭 Cuando usarlo: pedir algo en casa de alguien. Ej.: → Kun je me wat water geven, alsjeblieft?

🏋️ Ejercicio: «¿Me das algo de pan?» → Geef je me ___ brood? (Respuesta: wat, neutro y atono.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Me puedes dar algo de agua?' AND notes = 'un poco: wat = algo de (atono, neutro)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me puedes dar algo de agua?' AND notes = 'un poco: wat = algo de (atono, neutro)' LIMIT 1),
    'nl_NL', 'Kun je me wat water geven?', 'Kun ye me uat uater jefen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me puedes dar algo de agua?' AND notes = 'un poco: wat = algo de (atono, neutro)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me puedes dar algo de agua?' AND notes = 'un poco: wat = algo de (atono, neutro)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 5) un poco: iets + comparativo
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Hoy hace un poco más de frío que ayer.', 'PHRASE', 'un poco: iets + comparativo', 'Delante de un COMPARATIVO, «un poco mas» es iets (o een beetje, pero iets es lo natural): iets kouder = un poco mas frio. Aqui «wat» tambien vale (wat kouder), pero weinig NO: weinig nunca modifica a un comparativo.

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Het + is (2a casilla) + complemento de tiempo + iets + comparativo + dan + termino.

🧭 Cuando usarlo: comentar el tiempo. Ej.: → Het is vandaag iets kouder dan gisteren, neem een jas mee.

🏋️ Ejercicio: «un poco mas caro» → ___ duurder. (Respuesta: iets, delante de comparativo.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Hoy hace un poco más de frío que ayer.' AND notes = 'un poco: iets + comparativo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Hoy hace un poco más de frío que ayer.' AND notes = 'un poco: iets + comparativo' LIMIT 1),
    'nl_NL', 'Het is vandaag iets kouder dan gisteren.', 'Et is fandaj its kauder dan jisteren.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hoy hace un poco más de frío que ayer.' AND notes = 'un poco: iets + comparativo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hoy hace un poco más de frío que ayer.' AND notes = 'un poco: iets + comparativo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 6) un poco: minder = comparativo de weinig
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Esta sección del programa se ve menos.', 'PHRASE', 'un poco: minder = comparativo de weinig', 'minder NO es «poco», es MENOS: el comparativo de weinig. weinig bekeken = se ve poco (absoluto) · minder bekeken = se ve menos (comparado con las demas secciones, con antes, con lo esperado), aunque el «dan» no aparezca. Y «goed bekeken worden» es la colocacion de AUDIENCIA: een goed bekeken programma = un programa muy visto. Ojo: no es «apreciado», que seria gewaardeerd.

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Sujeto + wordt (2a casilla) + minder goed + participio al final (pasiva con worden).

🧭 Cuando usarlo: hablar de audiencia o de atencion. Ej.: → Dit element in het programma wordt minder goed bekeken dan de rest.

🏋️ Ejercicio: «se ve poco» (sin comparar) → wordt ___ bekeken. · «se ve menos» → wordt ___ bekeken. (Respuestas: weinig / minder.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Esta sección del programa se ve menos.' AND notes = 'un poco: minder = comparativo de weinig');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta sección del programa se ve menos.' AND notes = 'un poco: minder = comparativo de weinig' LIMIT 1),
    'nl_NL', 'Dit element in het programma wordt minder goed bekeken.', 'Dit element in et projramma uort minder jut bekeken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta sección del programa se ve menos.' AND notes = 'un poco: minder = comparativo de weinig' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta sección del programa se ve menos.' AND notes = 'un poco: minder = comparativo de weinig' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 7) un poco: steeds minder = cada vez menos
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Cada vez leo menos periódicos.', 'PHRASE', 'un poco: steeds minder = cada vez menos', 'steeds minder = cada vez menos: es el comparativo minder con «steeds» (cada vez) delante, para marcar la tendencia. La pareja es steeds meer (cada vez mas). Tambien se oye «hoe langer hoe minder» para lo mismo.

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Sujeto + verbo (2a casilla) + steeds minder + sustantivo plural.

🧭 Cuando usarlo: hablar de un habito que se te va. Ej.: → Ik lees steeds minder kranten, alles gaat via mijn telefoon.

🏋️ Ejercicio: «cada vez mas gente» → ___ ___ mensen. (Respuesta: steeds meer.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cada vez leo menos periódicos.' AND notes = 'un poco: steeds minder = cada vez menos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada vez leo menos periódicos.' AND notes = 'un poco: steeds minder = cada vez menos' LIMIT 1),
    'nl_NL', 'Ik lees steeds minder kranten.', 'Ik les stets minder kranten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada vez leo menos periódicos.' AND notes = 'un poco: steeds minder = cada vez menos' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada vez leo menos periódicos.' AND notes = 'un poco: steeds minder = cada vez menos' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 8) un poco: een tikkeltje = un pelin
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Está un pelín salado.', 'PHRASE', 'un poco: een tikkeltje = un pelin', 'een tikkeltje = un pelin, un pelo: es el «un poco» mas pequeno y algo carinoso, hermano de een klein beetje. Delante de «te + adjetivo» suaviza la critica: te zout (demasiado salado) suena duro, een tikkeltje te zout suena a comentario amable.

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Het + is (2a casilla) + een tikkeltje + te + adjetivo.

🧭 Cuando usarlo: criticar sin ofender. Ej.: → Het is een tikkeltje te zout, maar verder heerlijk.

🏋️ Ejercicio: «un pelin caro» → een ___ te duur. (Respuesta: tikkeltje.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Está un pelín salado.' AND notes = 'un poco: een tikkeltje = un pelin');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Está un pelín salado.' AND notes = 'un poco: een tikkeltje = un pelin' LIMIT 1),
    'nl_NL', 'Het is een tikkeltje te zout.', 'Et is en tikkeltye te saut.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Está un pelín salado.' AND notes = 'un poco: een tikkeltje = un pelin' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Está un pelín salado.' AND notes = 'un poco: een tikkeltje = un pelin' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 9) un poco: nauwelijks / amper = apenas
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ayer apenas dormí.', 'PHRASE', 'un poco: nauwelijks / amper = apenas', 'nauwelijks (o amper, mas coloquial) = apenas: no es «poco», es «casi nada». Es el escalon por debajo de weinig y arrastra sentido negativo, asi que no lleva «niet» delante: «niet nauwelijks» no se dice.

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Sujeto + heb (2a casilla) + complemento de tiempo + nauwelijks + participio al final.

🧭 Cuando usarlo: contar una mala noche. Ej.: → Ik heb gisteren nauwelijks geslapen, ik ben kapot.

🏋️ Ejercicio: «apenas comio» → Hij heeft ___ gegeten. (Respuesta: nauwelijks, o amper.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ayer apenas dormí.' AND notes = 'un poco: nauwelijks / amper = apenas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer apenas dormí.' AND notes = 'un poco: nauwelijks / amper = apenas' LIMIT 1),
    'nl_NL', 'Ik heb gisteren nauwelijks geslapen.', 'Ik hep jisteren naueleiks jeslapen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer apenas dormí.' AND notes = 'un poco: nauwelijks / amper = apenas' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer apenas dormí.' AND notes = 'un poco: nauwelijks / amper = apenas' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 10) un poco: even = un rato (TIEMPO, no cantidad)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Espera un momento, ya voy.', 'PHRASE', 'un poco: even = un rato (TIEMPO, no cantidad)', 'Aqui esta EL error clasico: «espera un poco» no es «wacht een beetje» sino wacht EVEN. even (o eventjes, mas suave) es el «un poco» del TIEMPO, no de la cantidad. Ademas even se cuela en mil frases para quitar peso a lo que pides: Kun je even helpen? = ¿me echas una mano?

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Imperativo (verbo en la 1a casilla) + even + resto.

🧭 Cuando usarlo: pedir que te esperen. Ej.: → Wacht even, ik kom eraan.

🏋️ Ejercicio: «mira un momento» → Kijk ___. · «pon un poco de leche» → Doe er ___ melk in. (Respuestas: even / een beetje. Tiempo vs cantidad.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Espera un momento, ya voy.' AND notes = 'un poco: even = un rato (TIEMPO, no cantidad)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Espera un momento, ya voy.' AND notes = 'un poco: even = un rato (TIEMPO, no cantidad)' LIMIT 1),
    'nl_NL', 'Wacht even, ik kom eraan.', 'Uajt efen, ik kom eran.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Espera un momento, ya voy.' AND notes = 'un poco: even = un rato (TIEMPO, no cantidad)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Espera un momento, ya voy.' AND notes = 'un poco: even = un rato (TIEMPO, no cantidad)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 11) un poco: een tijdje / een poosje = un rato largo
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Vivimos un tiempo en Utrecht.', 'PHRASE', 'un poco: een tijdje / een poosje = un rato largo', 'een tijdje (o een poosje) = una temporada, un rato largo: es el escalon siguiente a even. even son segundos o minutos, een tijdje son semanas o meses. Los dos son tiempo, nunca cantidad.

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Sujeto + hebben (2a casilla) + een tijdje + complemento + participio al final.

🧭 Cuando usarlo: contar por encima donde has vivido. Ej.: → We hebben een tijdje in Utrecht gewoond, voor de kinderen kwamen.

🏋️ Ejercicio: «espera un momento» → Wacht ___. · «estuvo una temporada enfermo» → Hij was ___ ziek. (Respuestas: even / een tijdje.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Vivimos un tiempo en Utrecht.' AND notes = 'un poco: een tijdje / een poosje = un rato largo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Vivimos un tiempo en Utrecht.' AND notes = 'un poco: een tijdje / een poosje = un rato largo' LIMIT 1),
    'nl_NL', 'We hebben een tijdje in Utrecht gewoond.', 'Ue hebben en teidye in Utrejt jeuont.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vivimos un tiempo en Utrecht.' AND notes = 'un poco: een tijdje / een poosje = un rato largo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vivimos un tiempo en Utrecht.' AND notes = 'un poco: een tijdje / een poosje = un rato largo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 12) un poco: enigszins = en cierta medida (formal)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'La situación ha mejorado algo.', 'PHRASE', 'un poco: enigszins = en cierta medida (formal)', 'enigszins = en cierta medida, algo: es el «un poco» de registro FORMAL, de informe o de prensa. En una conversacion normal dirias «wat» o «een beetje»; enigszins en el bar suena a discurso.

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Sujeto + is (2a casilla) + enigszins + participio al final.

🧭 Cuando usarlo: leer o redactar algo formal. Ej.: → De situatie is enigszins verbeterd, maar we zijn er nog niet.

🏋️ Ejercicio: En un informe, «ha mejorado algo» → is ___ verbeterd. (Respuesta: enigszins.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'La situación ha mejorado algo.' AND notes = 'un poco: enigszins = en cierta medida (formal)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'La situación ha mejorado algo.' AND notes = 'un poco: enigszins = en cierta medida (formal)' LIMIT 1),
    'nl_NL', 'De situatie is enigszins verbeterd.', 'De situatsi is enijsins ferbetert.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'La situación ha mejorado algo.' AND notes = 'un poco: enigszins = en cierta medida (formal)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'La situación ha mejorado algo.' AND notes = 'un poco: enigszins = en cierta medida (formal)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 13) un poco: een paar = unos cuantos (contables)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Todavía me quedan un par de preguntas.', 'PHRASE', 'un poco: een paar = unos cuantos (contables)', 'een paar = un par, unos cuantos: es el «un poco» de las cosas CONTABLES, donde een beetje no puede entrar. Y ojo, no significa exactamente dos: een paar vragen son dos, tres o cuatro. Para exactamente dos se dice «twee» o «een paar schoenen» (un par de zapatos, que van de dos en dos).

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Sujeto + heb (2a casilla) + nog + een paar + sustantivo plural.

🧭 Cuando usarlo: cerrar una reunion. Ej.: → Ik heb nog een paar vragen, mag dat?

🏋️ Ejercicio: «un poco de leche» → ___ melk. · «un par de preguntas» → ___ vragen. (Respuestas: een beetje / een paar. Incontable vs contable.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Todavía me quedan un par de preguntas.' AND notes = 'un poco: een paar = unos cuantos (contables)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Todavía me quedan un par de preguntas.' AND notes = 'un poco: een paar = unos cuantos (contables)' LIMIT 1),
    'nl_NL', 'Ik heb nog een paar vragen.', 'Ik hep noj en par frajen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todavía me quedan un par de preguntas.' AND notes = 'un poco: een paar = unos cuantos (contables)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todavía me quedan un par de preguntas.' AND notes = 'un poco: een paar = unos cuantos (contables)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 14) un poco: min of meer = mas o menos
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Más o menos estoy de acuerdo contigo.', 'PHRASE', 'un poco: min of meer = mas o menos', 'min of meer = mas o menos: la expresion fija que relativiza. Fijate en que el neerlandes la dice al reves que el espanol (min OF meer = «menos o mas»), asi que hay que aprenderla entera, sin traducir palabra por palabra. Y «het eens zijn met» es la construccion de estar de acuerdo.

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Sujeto + ben (2a casilla) + het + min of meer + met + persona + eens al final.

🧭 Cuando usarlo: aceptar a medias. Ej.: → Ik ben het min of meer met je eens, maar niet helemaal.

🏋️ Ejercicio: «mas o menos» → ___ ___ ___. (Respuesta: min of meer, en ese orden.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Más o menos estoy de acuerdo contigo.' AND notes = 'un poco: min of meer = mas o menos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Más o menos estoy de acuerdo contigo.' AND notes = 'un poco: min of meer = mas o menos' LIMIT 1),
    'nl_NL', 'Ik ben het min of meer met je eens.', 'Ik ben et min of mer met ye ens.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Más o menos estoy de acuerdo contigo.' AND notes = 'un poco: min of meer = mas o menos' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Más o menos estoy de acuerdo contigo.' AND notes = 'un poco: min of meer = mas o menos' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 15) un poco: minder + adjetivo = eufemismo
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Mi madre últimamente está pachucha.', 'PHRASE', 'un poco: minder + adjetivo = eufemismo', 'minder gezond no es «menos sana» en frio: es el EUFEMISMO nacional. Poner minder delante de un adjetivo positivo es la manera holandesa de decir lo malo sin decirlo: minder goed (flojito), minder leuk (poco agradable), minder gezond (pachucho). Rebajar en vez de negar.

🥄 El mapa del «un poco» — cinco cosas distintas bajo la misma palabra espanola:

| forma | que dice | va con | ejemplo |
|---|---|---|---|
| **weinig** | poco = ESCASEZ, hay menos de lo deseable | incontables y plurales contables | weinig tijd, weinig mensen |
| **een beetje** | un poco = cantidad PEQUENA, y la subraya | incontables, y verbos | een beetje suiker |
| **wat** | algo de, atono y neutro, no juzga | incontables y plurales contables | wat water, wat mensen |
| **iets** | un poco MAS o MENOS, delante de comparativo | comparativos | iets kouder |
| **even** | un poco = un RATO, es TIEMPO y no cantidad | verbos | wacht even |

📊 La escalera de la cantidad — weinig y veel tienen comparativo irregular, como goed → beter:
• weinig → minder → minst  (poco → menos → el que menos)
• veel → meer → meest  (mucho → mas → el que mas)

⚠️ Las tres trampas:
1. minder es el COMPARATIVO de weinig, no un sinonimo suyo: weinig bekeken = se ve POCO (absoluto) · minder bekeken = se ve MENOS (comparado). Y NO hace falta poner el «dan»: el termino de comparacion puede quedar implicito, igual que en espanol («esta seccion se ve menos» ¿menos que que? que las demas, que antes).
2. minder + adjetivo es el EUFEMISMO nacional: minder goed = «flojito» sin llegar a decir slecht, minder gezond = «pachucho». El neerlandes rebaja en vez de negar, y por eso minder goed bekeken no es «mal visto» sino «visto menos bien».
3. El «un poco» de TIEMPO no es cantidad: «espera un poco» NO es «wacht een beetje» sino WACHT EVEN. Para un rato mas largo, een tijdje o een poosje.

🔗 El reparto fino entre wat y een beetje (con plural contable solo wat, con verbo solo een beetje) esta explicado en las tarjetas 704 y 601.

📐 Formula: Sujeto + is (2a casilla) + complemento de tiempo + minder + adjetivo.

🧭 Cuando usarlo: dar una mala noticia con suavidad. Ej.: → Mijn moeder is de laatste tijd minder gezond, we zien wel.

🏋️ Ejercicio: Sin decir «slecht», «va flojo en el trabajo» → Het gaat ___ ___ op zijn werk. (Respuesta: minder goed.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi madre últimamente está pachucha.' AND notes = 'un poco: minder + adjetivo = eufemismo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi madre últimamente está pachucha.' AND notes = 'un poco: minder + adjetivo = eufemismo' LIMIT 1),
    'nl_NL', 'Mijn moeder is de laatste tijd minder gezond.', 'Mein muder is de latste teid minder jesont.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi madre últimamente está pachucha.' AND notes = 'un poco: minder + adjetivo = eufemismo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'un poco - weinig, een beetje, wat y compania'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi madre últimamente está pachucha.' AND notes = 'un poco: minder + adjetivo = eufemismo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
