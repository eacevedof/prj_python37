-- Learn Languages App - Grupo "zullen" y todas sus bifurcaciones
-- Migration: 20260706000005-create-zullen-group.sql
-- Description: Crea el grupo "zullen" con 12 frases que cubren los usos de
--   zullen/zou: propuesta (zullen we...?), ofrecimiento (zal ik...?), promesa
--   (ik zal...), probabilidad/suposicion (zal wel), frases hechas (we zullen
--   zien) y el condicional zou (cortesia, hipotesis, duda).
--   Idempotente: words_es guardado con WHERE NOT EXISTS (text no es UNIQUE),
--   words_lang y asociaciones con INSERT OR IGNORE. No toca ids existentes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'zullen',
    'Usos de zullen y zou: propuestas (zullen we), ofrecimientos (zal ik), promesas (ik zal), probabilidad (zal wel) y cortesia/condicional/duda (zou)',
    'migracion'
);

-- ==============================================================================
-- 2. PALABRAS EN ESPAÑOL (solo si no existen)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes)
SELECT '¿comemos algo?', 'PHRASE', 'Uso de zullen: propuesta'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿comemos algo?');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿nos vamos?', 'PHRASE', 'Uso de zullen: propuesta'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿nos vamos?');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿te ayudo?', 'PHRASE', 'Uso de zullen: ofrecimiento'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿te ayudo?');

INSERT INTO words_es (text, word_type, notes)
SELECT 'lo haré mañana', 'PHRASE', 'Uso de zullen: promesa'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'lo haré mañana');

INSERT INTO words_es (text, word_type, notes)
SELECT 'estaré allí', 'PHRASE', 'Uso de zullen: promesa'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estaré allí');

INSERT INTO words_es (text, word_type, notes)
SELECT 'será eso, supongo', 'PHRASE', 'Uso de zullen: probabilidad/resignacion'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'será eso, supongo');

INSERT INTO words_es (text, word_type, notes)
SELECT 'estará cansado', 'PHRASE', 'Uso de zullen: suposicion'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estará cansado');

INSERT INTO words_es (text, word_type, notes)
SELECT 'ya veremos', 'PHRASE', 'Uso de zullen: frase hecha'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ya veremos');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿podrías ayudarme?', 'PHRASE', 'Uso de zou: cortesia'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿podrías ayudarme?');

INSERT INTO words_es (text, word_type, notes)
SELECT 'sería genial', 'PHRASE', 'Uso de zou: condicional'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'sería genial');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿vendrá?', 'PHRASE', 'Uso de zou: duda/especulacion'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿vendrá?');

INSERT INTO words_es (text, word_type, notes)
SELECT 'no te quedará otra', 'PHRASE', 'Uso de zullen: obligacion resignada'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no te quedará otra');

-- ==============================================================================
-- 3. TRADUCCIONES + 5 EJEMPLOS (INSERT OR IGNORE: no pisa lo existente)
-- ==============================================================================

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿comemos algo?'),
    'nl_NL',
    'zullen we wat eten?',
    '• [vraag] Zullen we wat eten? — ¿Comemos algo?
• [vraag] Zullen we vanavond pizza bestellen? — ¿Pedimos pizza esta noche?
• [vraag] Zullen we even pauze nemen? — ¿Hacemos una pausa?
• [bijzin] Ik vroeg of we samen wat zullen eten. — Pregunté si comemos algo juntos.
• [uitdr.] Zullen we maar? — ¿Empezamos, entonces? (frase hecha para ponerse en marcha)'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿nos vamos?'),
    'nl_NL',
    'zullen we gaan?',
    '• [vraag] Zullen we gaan? — ¿Nos vamos?
• [vraag] Zullen we morgen naar het strand gaan? — ¿Vamos mañana a la playa?
• [vraag] Zullen we met de fiets gaan? — ¿Vamos en bici?
• [inv.] Na de koffie zullen we gaan. — Después del café nos vamos.
• [uitdr.] Zullen we er maar aan beginnen? — ¿Nos ponemos ya con ello?'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿te ayudo?'),
    'nl_NL',
    'zal ik je helpen?',
    '• [vraag] Zal ik je helpen? — ¿Te ayudo?
• [vraag] Zal ik het raam opendoen? — ¿Abro la ventana?
• [vraag] Zal ik koffie zetten? — ¿Preparo café?
• [vraag] Zal ik je van het station ophalen? — ¿Te recojo de la estación?
• [uitdr.] Zal ik maar? — ¿Lo hago yo, entonces? (ofrecimiento con "maar")'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'lo haré mañana'),
    'nl_NL',
    'ik zal het morgen doen',
    '• [can.] Ik zal het morgen doen. — Lo haré mañana (prometido).
• [inv.] Morgen zal ik het echt doen. — Mañana lo haré de verdad.
• [can.] Ik zal eraan denken. — Me acordaré, lo tendré en cuenta.
• [vraag] Zul je voorzichtig zijn? — ¿Serás prudente? (promesa que se pide)
• [bijzin] Ik beloof dat ik het morgen zal doen. — Prometo que lo haré mañana.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'estaré allí'),
    'nl_NL',
    'ik zal er zijn',
    '• [can.] Ik zal er zijn. — Estaré allí (cuenta conmigo).
• [inv.] Om acht uur zal ik er zijn. — A las ocho estaré allí.
• [can.] Ik zal je nooit vergeten. — Nunca te olvidaré.
• [vraag] Zul je er echt zijn? — ¿De verdad estarás allí?
• [bijzin] Ze belooft dat ze er zal zijn. — Promete que estará allí.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'será eso, supongo'),
    'nl_NL',
    'dat zal wel',
    '• [uitdr.] Dat zal wel. — Será eso, supongo (a veces con retintín escéptico).
• [can.] Het zal wel goedkomen. — Ya se arreglará.
• [can.] Hij zal wel weer te laat zijn. — Seguro que llega tarde otra vez.
• [vraag] Zal het lukken? Het zal wel moeten! — ¿Saldrá bien? ¡Tendrá que salir!
• [uitdr.] Het zal wel weer aan mij liggen. — Seguro que otra vez es culpa mía (irónico).'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'estará cansado'),
    'nl_NL',
    'hij zal wel moe zijn',
    '• [can.] Hij zal wel moe zijn. — Estará cansado, supongo.
• [can.] Ze zal wel in de file staan. — Estará en el atasco.
• [can.] Het zal wel duur zijn. — Será caro, imagino.
• [vraag] Waar is hij? Hij zal wel thuis zijn. — ¿Dónde está? Estará en casa.
• [bijzin] Ik denk dat hij wel moe zal zijn. — Creo que estará cansado.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'ya veremos'),
    'nl_NL',
    'we zullen zien',
    '• [uitdr.] We zullen zien. — Ya veremos.
• [uitdr.] We zullen wel zien wat het wordt. — Ya veremos en qué queda.
• [vraag] Komt het goed? We zullen zien. — ¿Saldrá bien? Ya veremos.
• [uitdr.] Wie zal het zeggen? — ¿Quién sabe?
• [uitdr.] Dat zullen we nog weleens zien! — ¡Eso ya lo veremos! (desafío)'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿podrías ayudarme?'),
    'nl_NL',
    'zou je me kunnen helpen?',
    '• [vraag] Zou je me kunnen helpen? — ¿Podrías ayudarme?
• [vraag] Zou je het raam dicht willen doen? — ¿Te importaría cerrar la ventana?
• [vraag] Zou ik u iets mogen vragen? — ¿Podría preguntarle algo? (formal, con "u")
• [can.] Dat zou heel fijn zijn. — Eso sería estupendo.
• [bijzin] Ik vroeg of je me zou kunnen helpen. — Pregunté si podrías ayudarme.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'sería genial'),
    'nl_NL',
    'dat zou leuk zijn',
    '• [can.] Dat zou leuk zijn! — ¡Sería genial!
• [can.] Ik zou graag een koffie willen. — Querría un café (pedir con educación).
• [inv.] Zonder jou zou het niet lukken. — Sin ti no saldría bien.
• [vraag] Wat zou jij doen? — ¿Tú qué harías?
• [bijzin] Als ik jou was, zou ik het doen. — Yo que tú, lo haría.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿vendrá?'),
    'nl_NL',
    'zou hij komen?',
    '• [vraag] Zou hij komen? — ¿Vendrá? (me lo pregunto)
• [vraag] Zou het gaan regenen? — ¿Lloverá? (quién sabe)
• [vraag] Zou ze het al weten? — ¿Lo sabrá ya?
• [can.] Het zou kunnen. — Podría ser.
• [bijzin] Ik vraag me af of hij zou komen. — Me pregunto si vendría.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'no te quedará otra'),
    'nl_NL',
    'je zult wel moeten',
    '• [uitdr.] Je zult wel moeten. — No te quedará otra.
• [can.] We zullen vroeg op moeten staan. — Tendremos que madrugar.
• [vraag] Moet dat echt? Je zult wel moeten! — ¿En serio hay que hacerlo? ¡No queda otra!
• [can.] Er zal iets moeten veranderen. — Algo tendrá que cambiar.
• [bijzin] Hij weet dat hij zal moeten kiezen. — Sabe que tendrá que elegir.'
);

-- ==============================================================================
-- 4. ASOCIAR AL GRUPO "zullen" (y a "generic", invariante de la app)
-- ==============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, (SELECT id FROM word_groups WHERE title = 'zullen')
FROM words_es we
WHERE we.text IN (
    '¿comemos algo?', '¿nos vamos?', '¿te ayudo?', 'lo haré mañana',
    'estaré allí', 'será eso, supongo', 'estará cansado', 'ya veremos',
    '¿podrías ayudarme?', 'sería genial', '¿vendrá?', 'no te quedará otra'
);

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, (SELECT id FROM word_groups WHERE title = 'generic')
FROM words_es we
WHERE we.text IN (
    '¿comemos algo?', '¿nos vamos?', '¿te ayudo?', 'lo haré mañana',
    'estaré allí', 'será eso, supongo', 'estará cansado', 'ya veremos',
    '¿podrías ayudarme?', 'sería genial', '¿vendrá?', 'no te quedará otra'
);
