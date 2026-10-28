-- Learn Languages App - Migration
-- Migration: 20260924000005-grupo-cada-y-algunos-sommige-enige
-- Description: Eduardo: "hay que crear un grupo ieder, elke, sommige y enige si es q no hay
--   ninguno".
--
--   Existia el grupo 31 «elke vs ieder - cada, cada uno, todos» (20260829000007), pero solo con elke/ieder:
--   14 tarjetas. sommige no salia en ninguna tarjeta ni ayuda; enige solo con el valor de «lo
--   unico» (415-419) y en la 828 (enige spijt). No se crea otro grupo: se amplia el 31 y se
--   renombra a «cada y algunos - elke, ieder, sommige, enige, enkele», para que elke/ieder y sommige/enige se estudien
--   juntos. El titulo no se usa en el codigo (grep sin resultados).
--
--   1. 16 tarjetas nuevas: sommige/sommigen (con el contraste «y otros no», sommige van,
--      sommigen … anderen), enig/enige (preguntas y negaciones, zonder enige twijfel, enig kind =
--      hijo unico, enige + plural formal), enkele (geen enkele, een enkele reis = billete de ida),
--      een paar, y el par elke/sommige en una misma frase.
--   2. Se suman al grupo 21 tarjetas que ya existian y encajan: een paar keer y een enkele
--      keer (230, 231, 395-404), het enige / de enige (234, 415-419), enige spijt (828), wat
--      water (889) y een paar vragen (898). Siguen en sus grupos de origen.
--   3. Bloque compartido «🧺 Cada, algunos y alguno» en todo el grupo: tabla de las nueve formas, el truco
--      del «y otros no», regla de bolsillo, terminaciones y las tres dobles vidas (enig kind,
--      enkele reis, Enig!). Las que no tienen ayuda (398, 403) se quedan sin bloque (§5.4).

PRAGMA foreign_keys = ON;

UPDATE word_groups
SET title = 'cada y algunos - elke, ieder, sommige, enige, enkele',
    description = 'Cada, todos, algunos y alguno: las palabras que se cruzan. elke/elk e iedere/ieder son cada, iedereen es todos sin sustantivo; sommige son algunos frente al resto (y otros no), sommigen si son personas; enkele y een paar son unos pocos, sin contraste; enig/enige es alguno en preguntas, negaciones y registro formal, y con articulo (het enige) pasa a ser el unico. Con sus tres dobles vidas: enig kind, een enkele reis y Enig!',
    updated_at = datetime('now')
WHERE title = 'elke vs ieder - cada, cada uno, todos';

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Algunas personas prefieren el té.', 'PHRASE', 'Cada y algunos (can.)', 'SOMMIGE = algunos, una parte del grupo frente al resto. Sommige mensen drinken liever thee, y los demás no: ese contraste es lo que pide sommige.

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Algunas personas prefieren el té.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Algunas personas prefieren el té.' LIMIT 1), 'nl_NL', 'Sommige mensen drinken liever thee.', 'sómije ménsen drínken líifer tee');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Algunos lo saben, otros no.', 'PHRASE', 'Cada y algunos (can.)', 'SOMMIGEN, con -n, es el pronombre de personas, sin sustantivo detrás. Y su pareja natural es anderen, otros: Sommigen … anderen …

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Algunos lo saben, otros no.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Algunos lo saben, otros no.' LIMIT 1), 'nl_NL', 'Sommigen weten het, anderen niet.', 'sómijen wéeten et, ánderen niit');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Algunos días no tengo ganas de nada.', 'PHRASE', 'Cada y algunos (inv.)', 'SOMMIGE DAGEN abre la frase, así que el verbo va segundo y el sujeto detrás, heb ik. Y nada de ganas es nergens zin in, con el nergens partido.

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Algunos días no tengo ganas de nada.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Algunos días no tengo ganas de nada.' LIMIT 1), 'nl_NL', 'Sommige dagen heb ik nergens zin in.', 'sómije dáajen hep ik nérjens sin in');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Algunas de mis amigas viven en Utrecht.', 'PHRASE', 'Cada y algunos (can.)', 'SOMMIGE VAN = algunos de, sin -n aunque no lleve sustantivo detrás, porque el grupo ya lo dice van mijn vriendinnen.

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Algunas de mis amigas viven en Utrecht.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Algunas de mis amigas viven en Utrecht.' LIMIT 1), 'nl_NL', 'Sommige van mijn vriendinnen wonen in Utrecht.', 'sómije fan méin frindínen wóonen in útrejt');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'En algunos casos no es posible.', 'PHRASE', 'Cada y algunos (inv.)', 'IN SOMMIGE GEVALLEN = en algunos casos, fórmula muy frecuente en textos y avisos.

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'En algunos casos no es posible.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'En algunos casos no es posible.' LIMIT 1), 'nl_NL', 'In sommige gevallen is het niet mogelijk.', 'in sómije jefálen is et niit móojelek');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No todos los días, solo algunos.', 'PHRASE', 'Cada y algunos (contrast)', 'ELKE frente a SOMMIGE en una sola frase: elke dag es todos sin excepción, sommige dagen una parte.

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No todos los días, solo algunos.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No todos los días, solo algunos.' LIMIT 1), 'nl_NL', 'Niet elke dag, alleen sommige dagen.', 'niit élke daj, álen sómije dáajen');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Tienes alguna idea de dónde está? (él)', 'PHRASE', 'Cada y algunos (vraag)', 'ENIG = alguno, algún, en preguntas y negaciones. Va sin -e porque idee es het-woord en singular.

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Tienes alguna idea de dónde está? (él)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Tienes alguna idea de dónde está? (él)' LIMIT 1), 'nl_NL', 'Heb je enig idee waar hij is?', 'hep ye éenej idée waar hei is');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Sin ninguna duda.', 'PHRASE', 'Cada y algunos (uitdr.)', 'ZONDER ENIGE = sin ningún, sin ninguna. El español niega con ninguna; el neerlandés usa enige, alguno, detrás de zonder.

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Sin ninguna duda.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Sin ninguna duda.' LIMIT 1), 'nl_NL', 'Zonder enige twijfel.', 'sónder éenije tuéifel');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Es hijo único. (él)', 'PHRASE', 'Cada y algunos (can.)', 'ENIG KIND = hijo único, sin artículo. Es la doble vida más traicionera de enig: aquí no es alguno sino único.

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Es hijo único. (él)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Es hijo único. (él)' LIMIT 1), 'nl_NL', 'Hij is enig kind.', 'hei is éenej kint');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Después de algunos años volvió a Países Bajos. (ella)', 'PHRASE', 'Cada y algunos (imperf.)', 'ENIGE + plural = unos cuantos, algunos, en registro cuidado o escrito. Al hablar se dice na een paar jaar.

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Después de algunos años volvió a Países Bajos. (ella)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Después de algunos años volvió a Países Bajos. (ella)' LIMIT 1), 'nl_NL', 'Na enige jaren ging ze terug naar Nederland.', 'na éenije yáaren jing se terúj naar néederlant');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Solo me quedan unos pocos euros.', 'PHRASE', 'Cada y algunos (can.)', 'ENKELE = unos pocos, la cantidad sin contraste. Nog maar = ya solo, que es lo que hace de «solo me quedan».

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Solo me quedan unos pocos euros.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Solo me quedan unos pocos euros.' LIMIT 1), 'nl_NL', 'Ik heb nog maar enkele euro''s.', 'ik hep noj maar énkele éuros');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No he cometido ni un solo error.', 'PHRASE', 'Cada y algunos (perf.)', 'GEEN ENKELE = ni un solo, ninguno en absoluto. Es geen reforzado, y se usa mucho.

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No he cometido ni un solo error.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No he cometido ni un solo error.' LIMIT 1), 'nl_NL', 'Ik heb geen enkele fout gemaakt.', 'ik hep jeen énkele faut jemáakt');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Un billete de ida a Ámsterdam, por favor.', 'PHRASE', 'Cada y algunos (uitdr.)', 'EEN ENKELE REIS = billete de ida, porque enkel es también sencillo. La ida y vuelta es een retour.

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Un billete de ida a Ámsterdam, por favor.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Un billete de ida a Ámsterdam, por favor.' LIMIT 1), 'nl_NL', 'Een enkele reis naar Amsterdam, alstublieft.', 'en énkele reis naar ámsterdam, alstubliift');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Vuelvo en un par de minutos.', 'PHRASE', 'Cada y algunos (can.)', 'EEN PAAR = un par, unos cuantos, la forma coloquial de enkele. Y en + tiempo futuro es over, no in.

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Vuelvo en un par de minutos.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Vuelvo en un par de minutos.' LIMIT 1), 'nl_NL', 'Ik ben over een paar minuten terug.', 'ik ben óofer en paar minúuten terúj');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Cada uno paga lo suyo.', 'PHRASE', 'Cada y algunos (refl.)', 'IEDEREEN = cada uno, todos, siempre sin sustantivo. Lo suyo sale con el reflexivo tónico, voor zichzelf.

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cada uno paga lo suyo.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada uno paga lo suyo.' LIMIT 1), 'nl_NL', 'Iedereen betaalt voor zichzelf.', 'íidereen betáalt foor sijsélf');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Algunos compañeros trabajan desde casa los viernes.', 'PHRASE', 'Cada y algunos (can.)', 'SOMMIGE COLLEGA''S, y los demás van a la oficina. Otra vez el contraste escondido que pide sommige.

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Algunos compañeros trabajan desde casa los viernes.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Algunos compañeros trabajan desde casa los viernes.' LIMIT 1), 'nl_NL', 'Sommige collega''s werken op vrijdag thuis.', 'sómije koléejas wérken op fréidaj taus');

-- grupos: las nuevas al 31 y a generic, las prestadas solo al 31
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT e.id, g.id FROM words_es e, word_groups g
WHERE g.title IN ('cada y algunos - elke, ieder, sommige, enige, enkele', 'generic')
  AND e.notes LIKE 'Cada y algunos (%';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT e.id, g.id FROM words_es e, word_groups g
WHERE g.title = 'cada y algunos - elke, ieder, sommige, enige, enkele'
  AND e.id IN (230, 231, 234, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 415, 416, 417, 418, 419, 828, 889, 898);

-- el bloque, en todo el grupo con ayuda (las nuevas ya lo llevan)
UPDATE words_es
SET rules_help = rules_help || '

🧺 Cada, algunos y alguno, las palabras que se cruzan:

| # | palabra | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **elke / elk** | cada | uno por uno, todos sin excepción; la forma normal al hablar | elke dag · elk kind |
| 2 | **iedere / ieder** | cada | lo mismo, algo más formal o subrayando a cada individuo | iedere ochtend · ieder jaar |
| 3 | **iedereen** | todos, todo el mundo | pronombre, sin sustantivo detrás | Iedereen weet het. |
| 4 | **sommige** | algunos | una parte del grupo, y los demás NO | Sommige mensen houden van regen. |
| 5 | **sommigen** | algunos | pronombre de personas, sin sustantivo | Sommigen weten het, anderen niet. |
| 6 | **enkele** | unos pocos, algunos | la cantidad, pocos | enkele dagen · geen enkele fout |
| 7 | **een paar** | un par, unos cuantos | lo mismo que enkele, más coloquial | over een paar minuten |
| 8 | **enig / enige** | alguno, algún | en preguntas, negaciones y registro formal | Heb je enig idee? · zonder enige twijfel |
| 9 | **het enige / de enige** | lo único, el único | con artículo definido cambia de significado | het enige wat ik wil |

🔑 El truco que casi nunca falla: Pregúntate si hay un «y otros no» escondido. Si lo hay, es sommige (Sommige mensen houden van regen, y otros no). Si solo cuentas pocos, es enkele o een paar. Si la frase pregunta o niega (¿alguna idea?, sin ninguna duda), es enig. Y si lleva de o het delante, ya no es alguno sino el único.

📌 Regla de bolsillo:
• ¿Todos, uno por uno? → elke o iedere delante del sustantivo, iedereen si va solo.
• ¿Una parte, frente al resto? → sommige, y sommigen si son personas sin sustantivo.
• ¿Pocos, sin contraste? → enkele o een paar.
• ¿Alguno en una pregunta o una negación? → enig, con -e o sin ella según el sustantivo.

📐 Las terminaciones siguen la regla del adjetivo:
• elke, iedere, enige delante de de-woord y de plurales — elke dag, enige dagen.
• elk, ieder, enig delante de het-woord en singular — elk kind, enig idee.
• sommige y enkele solo en plural, siempre con -e — sommige mensen, enkele euro''s.
• El pronombre de personas suma -n — sommigen, enkelen, velen.

⚠️ Tres dobles vidas que despistan. Enig kind es hijo único, no «algún niño». Een enkele reis es un billete de ida, porque enkel también es sencillo. Y Enig! suelto es ¡genial!, algo anticuado.

🏋️ Ejercicio:
• ___ mensen eten geen vlees, anderen wel. (Sommige)
• Heb je ___ idee hoe laat het is? (enig)
• Ik heb geen ___ fout gemaakt. (enkele)
• ___ kind krijgt een cadeau. (Elk)
• Hij is de ___ die het weet. (enige)'
WHERE id IN (SELECT word_es_id FROM word_es_groups
             WHERE group_id = (SELECT id FROM word_groups WHERE title = 'cada y algunos - elke, ieder, sommige, enige, enkele'))
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🧺 Cada, algunos y alguno%';
