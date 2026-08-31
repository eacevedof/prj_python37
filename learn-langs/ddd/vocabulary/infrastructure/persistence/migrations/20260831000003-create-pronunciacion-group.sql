-- Learn Languages App - Grupo "pronunciacion - palabras que se pegan al hablar"
-- Migration: 20260831000003-create-pronunciacion-group.sql
-- Description: Pedido por Eduardo: cadenas de palabras que por separado se leen bien pero
--   juntas se traban, empezando por su ejemplo «Ik herken dat ook wel hoor». 12 frases de
--   diario, cada una anclada en UNA operacion del habla encadenada: enlace (dat ook -> da-took),
--   h atona que se desvanece (wel hoor -> we-loor), asimilacion de sonoridad (uit de -> uid-de),
--   -n final muda (lopen -> lope), atonas reducidas a apostrofo (het -> 't, hem -> 'm,
--   als het -> as 't) y -t que cae en racimo (niet waar -> nie waar, dat is -> da's), mas el
--   racimo consonantico (angstschreeuw). Bloque 🗣️ compartido IDENTICO byte a byte con la
--   tabla de las seis operaciones, la trampa AL REVES (en espanol la h es muda siempre, en
--   neerlandes la h acentuada es un sonido de verdad: si las quitas todas no se te entiende)
--   y el metodo: leer por golpes de voz, no por palabras. Cada tarjeta anade 🔊 como suena de
--   verdad (con el acento marcado), 📐 formula, 🧭 ejemplo y 🏋️ ejercicio.
--   La 1a tarjeta explica ademas herkennen (reconocer lo ya conocido) vs erkennen (admitir),
--   «ook wel» concesivo y la particula «hoor», que no es el verbo oir.
--   Pronunciation aproximada estilo DutchToSpanishPhoneticService. 100% aditiva e
--   IDEMPOTENTE (INSERT ... WHERE NOT EXISTS / OR IGNORE).

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'pronunciacion - palabras que se pegan al hablar',
    'Cadenas de palabras que por separado se leen bien pero juntas se traban: enlace de la consonante final con la vocal siguiente, la h atona que se desvanece, asimilacion de sonoridad, la -n final que se cae, las atonas reducidas a apostrofo (''t, ''n, ''m) y la -t que desaparece en racimo. 12 frases de diario, cada una con como suena de verdad al hablar',
    'migracion'
);

-- ==============================================================================
-- 1) pronunciacion: ik + h atona, enlace dat-ook
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Sí, eso también me suena, ¿eh?', 'PHRASE', 'pronunciacion: ik + h atona, enlace dat-ook', 'Tres trampas seguidas en seis palabras. 1) ik herken: la k de «ik» choca con la h de «herken» y al hablar suena casi «i-kerken» — cuidado, porque erkennen (admitir, reconocer oficialmente) es OTRO verbo: herkennen es reconocer algo que ya conocias. 2) dat ook: la -t salta a la vocal y hace «da-took». 3) wel hoor: la h de «hoor» va atona y se desvanece, «we-loor». Y el sentido: «ook wel» concede (a mi TAMBIEN me pasa) y «hoor» es la particula que suaviza, un «¿eh?» tranquilizador, no el verbo oir.

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔊 Como suena de verdad: i-ker-KEN da-took we-LOOR (acento en KEN y en HOOR, lo demas corre)

📐 Formula: Sujeto + verbo (2a casilla) + objeto + ook wel + hoor al final.

🧭 Cuando usarlo: quitar hierro a lo que cuenta el otro. Ej.: → Ik herken dat ook wel hoor, mij overkomt het ook.

🏋️ Ejercicio: «herkennen» o «erkennen» para «reconoci su cara»? → Ik ___ zijn gezicht. (Respuesta: herkende, de herkennen: identificar algo ya conocido.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Sí, eso también me suena, ¿eh?' AND notes = 'pronunciacion: ik + h atona, enlace dat-ook');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Sí, eso también me suena, ¿eh?' AND notes = 'pronunciacion: ik + h atona, enlace dat-ook' LIMIT 1),
    'nl_NL', 'Ik herken dat ook wel hoor.', 'Ik herken dat ok uel hor.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Sí, eso también me suena, ¿eh?' AND notes = 'pronunciacion: ik + h atona, enlace dat-ook' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Sí, eso también me suena, ¿eh?' AND notes = 'pronunciacion: ik + h atona, enlace dat-ook' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 2) pronunciacion: het reducido a 't
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No lo he visto.', 'PHRASE', 'pronunciacion: het reducido a ''t', 'Escrita tiene cinco palabras, hablada suena a tres. «het» atono se encoge a ''t y se pega al verbo, y «niet» delante de consonante pierde la -t: k-eb-''t nie gezien. Este ''t es el mismo de «''t is koud» y no tiene nada que ver con el articulo het cuando va acentuado.

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔊 Como suena de verdad: k-eb-''t nie je-SIEN (el acento cae solo en ZIEN)

📐 Formula: Sujeto + heb (2a casilla) + het + niet + participio al final.

🧭 Cuando usarlo: negar que sepas algo. Ej.: → Ik heb het niet gezien, sorry.

🏋️ Ejercicio: Di «Ik heb het niet gehoord» a velocidad normal. ¿Cuantos golpes de voz salen? (Respuesta: tres — k-eb-''t nie je-HORT.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No lo he visto.' AND notes = 'pronunciacion: het reducido a ''t');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No lo he visto.' AND notes = 'pronunciacion: het reducido a ''t' LIMIT 1),
    'nl_NL', 'Ik heb het niet gezien.', 'Ik hep et nit jesin.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No lo he visto.' AND notes = 'pronunciacion: het reducido a ''t' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No lo he visto.' AND notes = 'pronunciacion: het reducido a ''t' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 3) pronunciacion: dat is contraido a da's
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Eso no es verdad.', 'PHRASE', 'pronunciacion: dat is contraido a da''s', '«dat is» es de las contracciones mas frecuentes del habla: da''s. Igual que «het is» → ''t is y «wat is» → wa''s. Y otra vez «niet» pierde la -t delante de consonante. Escrito NUNCA se pone da''s en registro formal, pero oido esta en todas partes.

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔊 Como suena de verdad: da''s nie WAAR (dos golpes, el peso al final)

📐 Formula: Dat + is (2a casilla) + niet + adjetivo.

🧭 Cuando usarlo: contradecir a alguien. Ej.: → Dat is niet waar, dat heb ik nooit gezegd.

🏋️ Ejercicio: «eso es raro» en habla rapida → ___ vreemd. (Respuesta: da''s.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Eso no es verdad.' AND notes = 'pronunciacion: dat is contraido a da''s');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso no es verdad.' AND notes = 'pronunciacion: dat is contraido a da''s' LIMIT 1),
    'nl_NL', 'Dat is niet waar.', 'Dat is nit uar.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso no es verdad.' AND notes = 'pronunciacion: dat is contraido a da''s' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso no es verdad.' AND notes = 'pronunciacion: dat is contraido a da''s' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 4) pronunciacion: cadena de enlaces con -t
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Qué hora es?', 'PHRASE', 'pronunciacion: cadena de enlaces con -t', 'La frase mas pedida del dia y la que peor sale: las tres -t/-s finales se encadenan con lo siguiente y el «het» final se queda en ''t. No son cuatro palabras, es un bloque: hoe-laa-tis-''t. Si lo dices palabra a palabra te entienden, pero suena a manual.

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔊 Como suena de verdad: hu-LAA-tis-''t (un solo bloque, acento en LAAT)

📐 Formula: Palabra interrogativa + adjetivo + verbo (2a casilla) + sujeto.

🧭 Cuando usarlo: preguntar la hora por la calle. Ej.: → Sorry, hoe laat is het?

🏋️ Ejercicio: Junta y di del tiron: Hoe laat is het? (Respuesta: hu-LAA-tis-''t, sin pausas.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Qué hora es?' AND notes = 'pronunciacion: cadena de enlaces con -t');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué hora es?' AND notes = 'pronunciacion: cadena de enlaces con -t' LIMIT 1),
    'nl_NL', 'Hoe laat is het?', 'Hu lat is et?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué hora es?' AND notes = 'pronunciacion: cadena de enlaces con -t' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué hora es?' AND notes = 'pronunciacion: cadena de enlaces con -t' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 5) pronunciacion: cadena larga, todo enlazado
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Qué pasa?', 'PHRASE', 'pronunciacion: cadena larga, todo enlazado', 'Seis palabras, ningun hueco: la -t de «wat» salta a «is», la -s a «er», y «aan de» se pega en «aan-de». Es el ejemplo perfecto de que en neerlandes se habla por golpes de voz y no por palabras. Ademas «de hand» aqui no es la mano: «aan de hand zijn» es la expresion fija de estar pasando algo.

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔊 Como suena de verdad: ua-ti-se-ran-de-HANT (todo seguido, acento en HAND)

📐 Formula: Wat + is (2a casilla) + er + aan de hand.

🧭 Cuando usarlo: llegar a un sitio y notar tension. Ej.: → Wat is er aan de hand? Jullie kijken zo serieus.

🏋️ Ejercicio: ¿Que significa literalmente «aan de hand»? (Respuesta: nada util — es expresion fija, «pasar/ocurrir», no tiene que ver con la mano.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Qué pasa?' AND notes = 'pronunciacion: cadena larga, todo enlazado');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué pasa?' AND notes = 'pronunciacion: cadena larga, todo enlazado' LIMIT 1),
    'nl_NL', 'Wat is er aan de hand?', 'Uat is er an de hant?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué pasa?' AND notes = 'pronunciacion: cadena larga, todo enlazado' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué pasa?' AND notes = 'pronunciacion: cadena larga, todo enlazado' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 6) pronunciacion: ik y het reducidos a la vez
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ni idea.', 'PHRASE', 'pronunciacion: ik y het reducidos a la vez', 'Dos reducciones seguidas: «ik» se queda casi en k- y «het» en ''t, asi que las tres primeras palabras salen en un solo golpe: k-zou-''t. Ojo con el sentido, que no es literal: no dice «no lo sabria» sino que es la manera cortes y muy holandesa de decir «ni idea», mas suave que «Ik weet het niet».

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔊 Como suena de verdad: k-sau-''t nie UE-ten (acento en WE-)

📐 Formula: Sujeto + zou (2a casilla) + het + niet + infinitivo al final.

🧭 Cuando usarlo: que te pregunten algo que no sabes, sin sonar seco. Ej.: → Ik zou het niet weten, vraag het even aan Anne.

🏋️ Ejercicio: Mas suave o mas seco que «Ik weet het niet»? (Respuesta: mas suave — es el «ni idea» cortes.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ni idea.' AND notes = 'pronunciacion: ik y het reducidos a la vez');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ni idea.' AND notes = 'pronunciacion: ik y het reducidos a la vez' LIMIT 1),
    'nl_NL', 'Ik zou het niet weten.', 'Ik sau et nit ueten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ni idea.' AND notes = 'pronunciacion: ik y het reducidos a la vez' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ni idea.' AND notes = 'pronunciacion: ik y het reducidos a la vez' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 7) pronunciacion: je atono pegado al verbo
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Te apetece venir?', 'PHRASE', 'pronunciacion: je atono pegado al verbo', '«heb je» en habla rapida es un bloque, «heb-je», y la j suena como la y de «ya». Luego viene la estructura om…te, que reparte el verbo: «om» abre y «te gaan» cierra al final, con «mee» en medio. La h inicial de «heb» SI se pronuncia: va acentuada.

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔊 Como suena de verdad: hep-ye SIN om me te JAN (dos acentos: ZIN y GAAN)

📐 Formula: Verbo (1a casilla, pregunta) + je + zin + om + resto + te + infinitivo al final.

🧭 Cuando usarlo: invitar a alguien sin formalidad. Ej.: → Heb je zin om mee te gaan naar de markt?

🏋️ Ejercicio: ¿Donde va el «te»? → Heb je zin om mee ___ gaan. (Respuesta: te, siempre pegado al infinitivo final.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Te apetece venir?' AND notes = 'pronunciacion: je atono pegado al verbo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Te apetece venir?' AND notes = 'pronunciacion: je atono pegado al verbo' LIMIT 1),
    'nl_NL', 'Heb je zin om mee te gaan?', 'Hep ye sin om me te jan?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Te apetece venir?' AND notes = 'pronunciacion: je atono pegado al verbo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Te apetece venir?' AND notes = 'pronunciacion: je atono pegado al verbo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 8) pronunciacion: hem reducido a 'm
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No le digas nada.', 'PHRASE', 'pronunciacion: hem reducido a ''m', '«hem» atono se encoge a ''m y se pega a la preposicion: tegen-''m. Es la misma familia de «haar» → d''r y «het» → ''t. Y «maar» aqui no es «pero»: es la particula que suaviza el imperativo, lo convierte en un consejo en vez de una orden.

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔊 Como suena de verdad: sej mar nits TE-je-''m (acento en TE-, la ''m casi no se oye)

📐 Formula: Imperativo (1a casilla) + maar + niets + tegen + pronombre.

🧭 Cuando usarlo: pedir discrecion. Ej.: → Zeg maar niets tegen hem, het is een verrassing.

🏋️ Ejercicio: «no le digas nada a ella» → Zeg maar niets tegen ___ (hablado: ___). (Respuesta: haar, hablado d''r.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No le digas nada.' AND notes = 'pronunciacion: hem reducido a ''m');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No le digas nada.' AND notes = 'pronunciacion: hem reducido a ''m' LIMIT 1),
    'nl_NL', 'Zeg maar niets tegen hem.', 'Sej mar nits tejen em.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No le digas nada.' AND notes = 'pronunciacion: hem reducido a ''m' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No le digas nada.' AND notes = 'pronunciacion: hem reducido a ''m' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 9) pronunciacion: als het contraido a as 't
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Si todo va bien, mañana viene.', 'PHRASE', 'pronunciacion: als het contraido a as ''t', '«als het» en habla corriente suena «as-''t»: la l se pierde y el het se reduce. Y ojo a la gramatica, que es lo que descoloca: la subordinada con «als» manda el verbo al FINAL (…goed is), y como la subordinada ocupa la primera casilla, la principal arranca con el verbo (komt hij, no hij komt).

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔊 Como suena de verdad: as-''t JUT is, komt ei MOR-jen

📐 Formula: Subordinada con als (verbo al final) + coma + verbo principal + sujeto + resto.

🧭 Cuando usarlo: prometer algo con reservas. Ej.: → Als het goed is, komt hij morgen rond negen uur.

🏋️ Ejercicio: ¿Por que «komt hij» y no «hij komt»? (Respuesta: la subordinada ocupa la 1a casilla, asi que el verbo va en la 2a y el sujeto detras.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Si todo va bien, mañana viene.' AND notes = 'pronunciacion: als het contraido a as ''t');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Si todo va bien, mañana viene.' AND notes = 'pronunciacion: als het contraido a as ''t' LIMIT 1),
    'nl_NL', 'Als het goed is, komt hij morgen.', 'Als et jut is, komt ei morjen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Si todo va bien, mañana viene.' AND notes = 'pronunciacion: als het contraido a as ''t' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Si todo va bien, mañana viene.' AND notes = 'pronunciacion: als het contraido a as ''t' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 10) pronunciacion: asimilacion de sonoridad (uit de)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Saca la caja del armario.', 'PHRASE', 'pronunciacion: asimilacion de sonoridad (uit de)', 'Aqui manda la asimilacion: la -t de «uit» delante de la d- de «de» se contagia y suena d, «uid-de». Lo mismo pasa en «op de» (ob-de), «met de» (med-de) y dentro de palabra en «zakdoek» (zag-duk). No es dejadez: es la regla, y pronunciarlo separado suena antinatural.

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔊 Como suena de verdad: hal de dos EUID-de kast (acento en DOOS y en KAST)

📐 Formula: Imperativo (1a casilla) + objeto + complemento de lugar.

🧭 Cuando usarlo: mandar en casa. Ej.: → Haal de doos even uit de kast, wil je?

🏋️ Ejercicio: ¿Como suena «op de tafel» de verdad? (Respuesta: ob-de tafel — la p se contagia de la d.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Saca la caja del armario.' AND notes = 'pronunciacion: asimilacion de sonoridad (uit de)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Saca la caja del armario.' AND notes = 'pronunciacion: asimilacion de sonoridad (uit de)' LIMIT 1),
    'nl_NL', 'Haal de doos uit de kast.', 'Hal de dos euid de kast.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Saca la caja del armario.' AND notes = 'pronunciacion: asimilacion de sonoridad (uit de)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Saca la caja del armario.' AND notes = 'pronunciacion: asimilacion de sonoridad (uit de)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 11) pronunciacion: la -n final que no se pronuncia
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Salimos un momento fuera.', 'PHRASE', 'pronunciacion: la -n final que no se pronuncia', 'Tres -n finales en una frase (gaan, even, buiten) y en casi toda Holanda NINGUNA se pronuncia: «ga-e», «eve», «beuite». La vocal que queda es una e sorda, la misma de «de». Si pronuncias todas las enes suena a leido en voz alta, o a acento del noreste. Y «even» es el «un rato» del grupo «un poco», no una cantidad.

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔊 Como suena de verdad: ue chaa-n-EE-ve nar BEUI-te

📐 Formula: Sujeto + verbo (2a casilla) + even + complemento de lugar.

🧭 Cuando usarlo: escaparte a tomar el aire. Ej.: → We gaan even naar buiten, kom je mee?

🏋️ Ejercicio: ¿Como suena «lopen»? (Respuesta: lope, con la -n muda y una e sorda al final.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Salimos un momento fuera.' AND notes = 'pronunciacion: la -n final que no se pronuncia');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Salimos un momento fuera.' AND notes = 'pronunciacion: la -n final que no se pronuncia' LIMIT 1),
    'nl_NL', 'We gaan even naar buiten.', 'Ue jan efen nar beuten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Salimos un momento fuera.' AND notes = 'pronunciacion: la -n final que no se pronuncia' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Salimos un momento fuera.' AND notes = 'pronunciacion: la -n final que no se pronuncia' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 12) pronunciacion: racimo de consonantes
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Oí un grito de pánico.', 'PHRASE', 'pronunciacion: racimo de consonantes', '«angstschreeuw» es el ejemplo de manual del racimo consonantico neerlandes: ngstschr, siete consonantes seguidas escritas. Se desarma por partes: angst + schreeuw, y la sch- son DOS sonidos seguidos, s + jota, no la ch espanola. Ojo con la otra trampa de la palabra: la g de -ng- en angst NO es jota, es la nasal velar de «tengo» — ahi no hay raspado ninguno. Y fijate en las dos h que SI suenan, porque van en silaba acentuada: heb y gehoord.

🗣️ Por que se te traba: las SEIS cosas que hace el neerlandes hablado
Ninguna palabra de estas frases es dificil por separado. Lo dificil es que, al hablar, el neerlandes no las pronuncia sueltas: las pega y las recorta. Estas son las seis operaciones, y con ellas se explica casi cualquier frase que se te atragante:

| operacion | que pasa | ejemplo | suena |
|---|---|---|---|
| **enlace** | la consonante final salta a la vocal siguiente | dat ook | da-took |
| **h atona** | la h de una palabra sin acento se debilita casi hasta desaparecer | wel hoor | we-loor |
| **asimilacion** | una consonante contagia su sonoridad a la vecina | uit de kast | uid-de kast |
| **-n final** | la -n de los plurales e infinitivos no se pronuncia | lopen, even | lope, eve |
| **atonas reducidas** | het, een, hem, haar se encogen a ''t, ''n, ''m, d''r | ik heb het | k-eb-''t |
| **-t en racimo** | la -t desaparece entre consonantes | niet waar, dat is | nie waar, da''s |

⚠️ La trampa AL REVES, y es la que mas delata a un espanol: en espanol la h es muda SIEMPRE, asi que la tentacion es no pronunciar ninguna. En neerlandes la h de una palabra CON acento es un sonido de verdad, un soplo que hay que dar: haar, huis, hond, herkennen, gehoord. Lo que se desvanece es solo la h de las atonas dentro de la cadena (hem, haar, het, hoor). Si las quitas todas, no se te entiende.

📌 Regla de bolsillo para practicar: no leas por palabras, lee por GOLPES DE VOZ. Marca donde cae el acento, junta todo lo demas y dilo del tiron. Si lo pronuncias palabra a palabra suena a robot, y ademas cuesta mas.

🐌 Y el atajo cuando no sale: la version lenta y separada NUNCA es incorrecta, solo suena formal. Primero la frase entera despacio y bien articulada; solo cuando sale sola, se acelera y se dejan caer las piezas.

🔊 Como suena de verdad: ik hep en ANGST-s-jreu je-HORT (respira entre angst y schreeuw)

📐 Formula: Sujeto + heb (2a casilla) + objeto + participio al final.

🧭 Cuando usarlo: contar un susto. Ej.: → Ik heb vannacht een angstschreeuw gehoord.

🏋️ Ejercicio: Parte la palabra en dos para poder decirla: angstschreeuw = ___ + ___. (Respuesta: angst + schreeuw.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Oí un grito de pánico.' AND notes = 'pronunciacion: racimo de consonantes');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Oí un grito de pánico.' AND notes = 'pronunciacion: racimo de consonantes' LIMIT 1),
    'nl_NL', 'Ik heb een angstschreeuw gehoord.', 'Ik hep en angst-s-jreu jehort.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Oí un grito de pánico.' AND notes = 'pronunciacion: racimo de consonantes' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Oí un grito de pánico.' AND notes = 'pronunciacion: racimo de consonantes' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
