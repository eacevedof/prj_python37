-- Learn Languages App - Migration
-- Migration: 20261105000001-grupo-frases-hechas
-- Description: Eduardo (2026-11-05): «crea un grupo de frases hechas … Las 100 frases hechas más usadas en
--   español con su equivalente en el neerlandés, un ejemplo … en la ayuda apunta en qué contexto usarla o
--   contextos».
--
--   Grupo nuevo 'frases hechas - uitdrukkingen en spreekwoorden' con 100 tarjetas PHRASE (el modismo español → su equivalente idiomático
--   neerlandés, no la traducción literal: costar un ojo de la cara → een rib uit je lijf kosten) y 100
--   tarjetas SENTENCE (el primer ejemplo de cada una, colgado con relación EXAMPLE). Todas también en generic.
--
--   Cada ayuda lleva el bloque '🧩 Expresión fija — <nl>:' del §3.10 (literal, significa, piezas fijas,
--   tabla de 3 ejemplos, truco), más la sección '🎯 En qué contexto se usa:' que pidió Eduardo (situaciones,
--   registro y avisos ⚠️ de falso amigo o de tono ofensivo). La SENTENCE lleva la misma ayuda que su PHRASE,
--   byte a byte. Bloque compartido (§3.3) al final de las 200: '📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha' (uitdrukking,
--   spreekwoord, zegswijze, el je comodín y el registro).
--
--   Las 5 frases de words_lang.notes (§3.7) usan además la etiqueta [imperf.] (imperfecto). Las SENTENCE
--   se eligieron con el sujeto delante para no necesitar (inv). Generada con
--   C:\projects\claude-tmp\learn-langs-frases-hechas\gen.py desde data.py.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'frases hechas - uitdrukkingen en spreekwoorden',
       'Las 100 frases hechas más usadas del español con su equivalente idiomático en neerlandés: tomar el pelo es iemand voor de gek houden, pan comido es een fluitje van een cent. Cada tarjeta explica la imagen literal, las piezas fijas, el contexto y el registro en que se usa, y trae un ejemplo examinable.',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden');

-- =============================================================================
-- 001. estar en las nubes → met je gedachten ergens anders zijn
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estar en las nubes', 'PHRASE', 'frases hechas: met je gedachten ergens anders zijn', 'MET JE GEDACHTEN ERGENS ANDERS ZIJN = estar en las nubes, estar distraído, no enterarse de lo que pasa alrededor.

🧩 Expresión fija — met je gedachten ergens anders zijn:

• literal — estar con tus pensamientos en otra parte.
• significa — estar distraído, no enterarse de lo que pasa alrededor.
• piezas fijas — met je gedachten, je cambia según el sujeto, met mijn, met zijn, met haar; ergens anders va detrás.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Sorry, ik was met mijn gedachten ergens anders. | Perdona, estaba en las nubes. |
| 2 | pregunta | Ben je met je gedachten ergens anders? | ¿Estás en las nubes? |
| 3 | perfecto | Hij is de hele les met zijn gedachten ergens anders geweest. | Ha estado en las nubes toda la clase. |

🎯 En qué contexto se usa:

• en una conversación o en clase, cuando alguien no presta atención
• para disculparte por no haber escuchado, Sorry, ik was met mijn gedachten ergens anders
• ⚠️ falso amigo — in de wolken zijn no es estar distraído sino estar feliz, en el séptimo cielo

🔑 El truco que casi nunca falla: si en español cabe distraído, es met je gedachten ergens anders, si cabe feliz, es in de wolken.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estar en las nubes');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'estar en las nubes' LIMIT 1), 'nl_NL', 'met je gedachten ergens anders zijn', 'met ie jedájten érjens ánders sein', '• [can.] Sorry, ik was met mijn gedachten ergens anders. — Perdona, estaba en las nubes.
• [vraag] Ben je met je gedachten ergens anders? — ¿Estás en las nubes?
• [perf.] Hij is de hele les met zijn gedachten ergens anders geweest. — Ha estado en las nubes toda la clase.
• [bijzin] Ik merk dat je met je gedachten ergens anders bent. — Noto que estás en las nubes.
• [uitdr.] Ze is in de wolken met haar nieuwe baan. — Está feliz como una perdiz con su nuevo trabajo.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Perdona, estaba en las nubes.', 'SENTENCE', 'Ejemplo de "met je gedachten ergens anders zijn" (can.)', 'MET JE GEDACHTEN ERGENS ANDERS ZIJN = estar en las nubes, estar distraído, no enterarse de lo que pasa alrededor.

🧩 Expresión fija — met je gedachten ergens anders zijn:

• literal — estar con tus pensamientos en otra parte.
• significa — estar distraído, no enterarse de lo que pasa alrededor.
• piezas fijas — met je gedachten, je cambia según el sujeto, met mijn, met zijn, met haar; ergens anders va detrás.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Sorry, ik was met mijn gedachten ergens anders. | Perdona, estaba en las nubes. |
| 2 | pregunta | Ben je met je gedachten ergens anders? | ¿Estás en las nubes? |
| 3 | perfecto | Hij is de hele les met zijn gedachten ergens anders geweest. | Ha estado en las nubes toda la clase. |

🎯 En qué contexto se usa:

• en una conversación o en clase, cuando alguien no presta atención
• para disculparte por no haber escuchado, Sorry, ik was met mijn gedachten ergens anders
• ⚠️ falso amigo — in de wolken zijn no es estar distraído sino estar feliz, en el séptimo cielo

🔑 El truco que casi nunca falla: si en español cabe distraído, es met je gedachten ergens anders, si cabe feliz, es in de wolken.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Perdona, estaba en las nubes.' AND notes = 'Ejemplo de "met je gedachten ergens anders zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Perdona, estaba en las nubes.' AND notes = 'Ejemplo de "met je gedachten ergens anders zijn" (can.)' LIMIT 1), 'nl_NL', 'Sorry, ik was met mijn gedachten ergens anders.', 'sorri, ik vas met mein jedajten erjens anders', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'estar en las nubes' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Perdona, estaba en las nubes.' AND notes = 'Ejemplo de "met je gedachten ergens anders zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar en las nubes' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar en las nubes' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Perdona, estaba en las nubes.' AND notes = 'Ejemplo de "met je gedachten ergens anders zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Perdona, estaba en las nubes.' AND notes = 'Ejemplo de "met je gedachten ergens anders zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 002. tomar el pelo a alguien → iemand voor de gek houden
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tomar el pelo a alguien', 'PHRASE', 'frases hechas: iemand voor de gek houden', 'IEMAND VOOR DE GEK HOUDEN = tomar el pelo a alguien, burlarse de alguien haciéndole creer algo que no es.

🧩 Expresión fija — iemand voor de gek houden:

• literal — tener a alguien por el loco.
• significa — burlarse de alguien haciéndole creer algo que no es.
• piezas fijas — voor de gek con de; la persona va entre houden y voor; houden es fuerte, hield, gehouden con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je houdt me voor de gek. | Me estás tomando el pelo. |
| 2 | pregunta | Houd je me nou voor de gek? | ¿Me estás tomando el pelo? |
| 3 | perfecto | Mijn broer heeft me de hele dag voor de gek gehouden. | Mi hermano me ha tomado el pelo todo el día. |

🎯 En qué contexto se usa:

• bromas entre amigos cuando alguien se cree una trola
• para preguntar si te están engañando, Houd je me voor de gek?
• también con enfado ante un servicio o una empresa que te toma por tonto

🔑 El truco que casi nunca falla: si en español puedes decir me estás vacilando, es voor de gek houden.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'tomar el pelo a alguien');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'tomar el pelo a alguien' LIMIT 1), 'nl_NL', 'iemand voor de gek houden', 'íemant foor de jek háuden', '• [can.] Je houdt me voor de gek. — Me estás tomando el pelo.
• [vraag] Houd je me nou voor de gek? — ¿Me estás tomando el pelo?
• [perf.] Mijn broer heeft me de hele dag voor de gek gehouden. — Mi hermano me ha tomado el pelo todo el día.
• [bijzin] Ik denk dat hij ons voor de gek houdt. — Creo que nos toma el pelo.
• [geb.] Houd me niet voor de gek! — ¡No me tomes el pelo!');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me estás tomando el pelo.', 'SENTENCE', 'Ejemplo de "iemand voor de gek houden" (can.)', 'IEMAND VOOR DE GEK HOUDEN = tomar el pelo a alguien, burlarse de alguien haciéndole creer algo que no es.

🧩 Expresión fija — iemand voor de gek houden:

• literal — tener a alguien por el loco.
• significa — burlarse de alguien haciéndole creer algo que no es.
• piezas fijas — voor de gek con de; la persona va entre houden y voor; houden es fuerte, hield, gehouden con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je houdt me voor de gek. | Me estás tomando el pelo. |
| 2 | pregunta | Houd je me nou voor de gek? | ¿Me estás tomando el pelo? |
| 3 | perfecto | Mijn broer heeft me de hele dag voor de gek gehouden. | Mi hermano me ha tomado el pelo todo el día. |

🎯 En qué contexto se usa:

• bromas entre amigos cuando alguien se cree una trola
• para preguntar si te están engañando, Houd je me voor de gek?
• también con enfado ante un servicio o una empresa que te toma por tonto

🔑 El truco que casi nunca falla: si en español puedes decir me estás vacilando, es voor de gek houden.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me estás tomando el pelo.' AND notes = 'Ejemplo de "iemand voor de gek houden" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Me estás tomando el pelo.' AND notes = 'Ejemplo de "iemand voor de gek houden" (can.)' LIMIT 1), 'nl_NL', 'Je houdt me voor de gek.', 'ie haut me for de jek', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'tomar el pelo a alguien' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me estás tomando el pelo.' AND notes = 'Ejemplo de "iemand voor de gek houden" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tomar el pelo a alguien' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tomar el pelo a alguien' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me estás tomando el pelo.' AND notes = 'Ejemplo de "iemand voor de gek houden" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me estás tomando el pelo.' AND notes = 'Ejemplo de "iemand voor de gek houden" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 003. costar un ojo de la cara → een rib uit je lijf kosten
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'costar un ojo de la cara', 'PHRASE', 'frases hechas: een rib uit je lijf kosten', 'EEN RIB UIT JE LIJF KOSTEN = costar un ojo de la cara, ser carísimo.

🧩 Expresión fija — een rib uit je lijf kosten:

• literal — costar una costilla de tu cuerpo.
• significa — ser carísimo.
• piezas fijas — de rib con een, uit je lijf fijo; el sujeto es la cosa cara; kosten es débil, gekost con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Die auto kost een rib uit je lijf. | Ese coche cuesta un ojo de la cara. |
| 2 | perfecto | De reparatie heeft me een rib uit mijn lijf gekost. | La reparación me ha costado un ojo de la cara. |
| 3 | pregunta | Kost dat niet een rib uit je lijf? | ¿Eso no cuesta un ojo de la cara? |

🎯 En qué contexto se usa:

• para quejarse de precios, una casa, un coche, una reparación
• exagerando con amigos o en familia, registro coloquial
• más neutro, het kost een vermogen, cuesta una fortuna

🔑 El truco que casi nunca falla: el ojo español es una costilla neerlandesa, y el sujeto es siempre lo que cuesta.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'costar un ojo de la cara');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'costar un ojo de la cara' LIMIT 1), 'nl_NL', 'een rib uit je lijf kosten', 'en rip öit ie leif kósten', '• [can.] Die auto kost een rib uit je lijf. — Ese coche cuesta un ojo de la cara.
• [perf.] De reparatie heeft me een rib uit mijn lijf gekost. — La reparación me ha costado un ojo de la cara.
• [vraag] Kost dat niet een rib uit je lijf? — ¿Eso no cuesta un ojo de la cara?
• [bijzin] Ik weet dat een huis in Amsterdam een rib uit je lijf kost. — Sé que una casa en Ámsterdam cuesta un ojo de la cara.
• [uitdr.] Het kost een vermogen. — Cuesta una fortuna.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ese coche cuesta un ojo de la cara.', 'SENTENCE', 'Ejemplo de "een rib uit je lijf kosten" (can.)', 'EEN RIB UIT JE LIJF KOSTEN = costar un ojo de la cara, ser carísimo.

🧩 Expresión fija — een rib uit je lijf kosten:

• literal — costar una costilla de tu cuerpo.
• significa — ser carísimo.
• piezas fijas — de rib con een, uit je lijf fijo; el sujeto es la cosa cara; kosten es débil, gekost con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Die auto kost een rib uit je lijf. | Ese coche cuesta un ojo de la cara. |
| 2 | perfecto | De reparatie heeft me een rib uit mijn lijf gekost. | La reparación me ha costado un ojo de la cara. |
| 3 | pregunta | Kost dat niet een rib uit je lijf? | ¿Eso no cuesta un ojo de la cara? |

🎯 En qué contexto se usa:

• para quejarse de precios, una casa, un coche, una reparación
• exagerando con amigos o en familia, registro coloquial
• más neutro, het kost een vermogen, cuesta una fortuna

🔑 El truco que casi nunca falla: el ojo español es una costilla neerlandesa, y el sujeto es siempre lo que cuesta.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ese coche cuesta un ojo de la cara.' AND notes = 'Ejemplo de "een rib uit je lijf kosten" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Ese coche cuesta un ojo de la cara.' AND notes = 'Ejemplo de "een rib uit je lijf kosten" (can.)' LIMIT 1), 'nl_NL', 'Die auto kost een rib uit je lijf.', 'di auto kost en rib öit ie leif', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'costar un ojo de la cara' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Ese coche cuesta un ojo de la cara.' AND notes = 'Ejemplo de "een rib uit je lijf kosten" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'costar un ojo de la cara' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'costar un ojo de la cara' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ese coche cuesta un ojo de la cara.' AND notes = 'Ejemplo de "een rib uit je lijf kosten" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ese coche cuesta un ojo de la cara.' AND notes = 'Ejemplo de "een rib uit je lijf kosten" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 004. ser pan comido → een fluitje van een cent zijn
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ser pan comido', 'PHRASE', 'frases hechas: een fluitje van een cent zijn', 'EEN FLUITJE VAN EEN CENT ZIJN = ser pan comido, ser facilísimo.

🧩 Expresión fija — een fluitje van een cent zijn:

• literal — ser un silbatito de un céntimo.
• significa — ser facilísimo.
• piezas fijas — het fluitje es het por el -je, pero aquí va con een; van een cent no se toca; el sujeto es la tarea.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dit examen is een fluitje van een cent. | Este examen es pan comido. |
| 2 | perfecto | De verhuizing is een fluitje van een cent geweest. | La mudanza ha sido pan comido. |
| 3 | pregunta | Is dat echt een fluitje van een cent? | ¿De verdad eso es pan comido? |

🎯 En qué contexto se usa:

• exámenes, tareas, ejercicios que salen sin esfuerzo
• para tranquilizar a alguien antes de hacer algo
• sinónimo coloquial, een eitje, un huevito

🔑 El truco que casi nunca falla: lo fácil en neerlandés suena barato y pequeño, un silbato de un céntimo o un huevito.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ser pan comido');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ser pan comido' LIMIT 1), 'nl_NL', 'een fluitje van een cent zijn', 'en flöitie fan en sent sein', '• [can.] Dit examen is een fluitje van een cent. — Este examen es pan comido.
• [perf.] De verhuizing is een fluitje van een cent geweest. — La mudanza ha sido pan comido.
• [vraag] Is dat echt een fluitje van een cent? — ¿De verdad eso es pan comido?
• [bijzin] Hij zegt dat koken een fluitje van een cent is. — Dice que cocinar es pan comido.
• [uitdr.] Dat is een eitje. — Eso está chupado.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Este examen es pan comido.', 'SENTENCE', 'Ejemplo de "een fluitje van een cent zijn" (can.)', 'EEN FLUITJE VAN EEN CENT ZIJN = ser pan comido, ser facilísimo.

🧩 Expresión fija — een fluitje van een cent zijn:

• literal — ser un silbatito de un céntimo.
• significa — ser facilísimo.
• piezas fijas — het fluitje es het por el -je, pero aquí va con een; van een cent no se toca; el sujeto es la tarea.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dit examen is een fluitje van een cent. | Este examen es pan comido. |
| 2 | perfecto | De verhuizing is een fluitje van een cent geweest. | La mudanza ha sido pan comido. |
| 3 | pregunta | Is dat echt een fluitje van een cent? | ¿De verdad eso es pan comido? |

🎯 En qué contexto se usa:

• exámenes, tareas, ejercicios que salen sin esfuerzo
• para tranquilizar a alguien antes de hacer algo
• sinónimo coloquial, een eitje, un huevito

🔑 El truco que casi nunca falla: lo fácil en neerlandés suena barato y pequeño, un silbato de un céntimo o un huevito.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Este examen es pan comido.' AND notes = 'Ejemplo de "een fluitje van een cent zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Este examen es pan comido.' AND notes = 'Ejemplo de "een fluitje van een cent zijn" (can.)' LIMIT 1), 'nl_NL', 'Dit examen is een fluitje van een cent.', 'dit eksamen is en flöitie fan en sent', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ser pan comido' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Este examen es pan comido.' AND notes = 'Ejemplo de "een fluitje van een cent zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ser pan comido' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ser pan comido' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Este examen es pan comido.' AND notes = 'Ejemplo de "een fluitje van een cent zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Este examen es pan comido.' AND notes = 'Ejemplo de "een fluitje van een cent zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 005. estar hasta las narices → er schoon genoeg van hebben
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estar hasta las narices', 'PHRASE', 'frases hechas: er schoon genoeg van hebben', 'ER SCHOON GENOEG VAN HEBBEN = estar hasta las narices, estar harto.

🧩 Expresión fija — er schoon genoeg van hebben:

• literal — tener bastante del todo de ello.
• significa — estar harto.
• piezas fijas — er … van, y con la cosa nombrada van iets, Ik heb schoon genoeg van dit weer; schoon aquí es del todo, no limpio.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik heb er schoon genoeg van. | Estoy hasta las narices. |
| 2 | principal | Ze heeft schoon genoeg van haar baas. | Está hasta las narices de su jefe. |
| 3 | pregunta | Heb je er nog niet schoon genoeg van? | ¿Todavía no estás hasta las narices? |

🎯 En qué contexto se usa:

• quejas fuertes, el ruido, la lluvia, el jefe
• registro coloquial, entre amigos o en casa
• variante corta y muy usada, het zat zijn, Ik ben het zat

🔑 El truco que casi nunca falla: harto de algo es er … van, el er hace de el de ello del español.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estar hasta las narices');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'estar hasta las narices' LIMIT 1), 'nl_NL', 'er schoon genoeg van hebben', 'er sjoon jenúj fan hébben', '• [can.] Ik heb er schoon genoeg van. — Estoy hasta las narices.
• [can.] Ze heeft schoon genoeg van haar baas. — Está hasta las narices de su jefe.
• [vraag] Heb je er nog niet schoon genoeg van? — ¿Todavía no estás hasta las narices?
• [bijzin] Ik zei dat ik er schoon genoeg van had. — Dije que estaba hasta las narices.
• [uitdr.] Ik ben het zat. — Estoy harto.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Estoy hasta las narices.', 'SENTENCE', 'Ejemplo de "er schoon genoeg van hebben" (can.)', 'ER SCHOON GENOEG VAN HEBBEN = estar hasta las narices, estar harto.

🧩 Expresión fija — er schoon genoeg van hebben:

• literal — tener bastante del todo de ello.
• significa — estar harto.
• piezas fijas — er … van, y con la cosa nombrada van iets, Ik heb schoon genoeg van dit weer; schoon aquí es del todo, no limpio.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik heb er schoon genoeg van. | Estoy hasta las narices. |
| 2 | principal | Ze heeft schoon genoeg van haar baas. | Está hasta las narices de su jefe. |
| 3 | pregunta | Heb je er nog niet schoon genoeg van? | ¿Todavía no estás hasta las narices? |

🎯 En qué contexto se usa:

• quejas fuertes, el ruido, la lluvia, el jefe
• registro coloquial, entre amigos o en casa
• variante corta y muy usada, het zat zijn, Ik ben het zat

🔑 El truco que casi nunca falla: harto de algo es er … van, el er hace de el de ello del español.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Estoy hasta las narices.' AND notes = 'Ejemplo de "er schoon genoeg van hebben" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy hasta las narices.' AND notes = 'Ejemplo de "er schoon genoeg van hebben" (can.)' LIMIT 1), 'nl_NL', 'Ik heb er schoon genoeg van.', 'ik heb er sjon jenuj fan', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'estar hasta las narices' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Estoy hasta las narices.' AND notes = 'Ejemplo de "er schoon genoeg van hebben" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar hasta las narices' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar hasta las narices' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy hasta las narices.' AND notes = 'Ejemplo de "er schoon genoeg van hebben" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy hasta las narices.' AND notes = 'Ejemplo de "er schoon genoeg van hebben" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 006. no tener pelos en la lengua → geen blad voor de mond nemen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no tener pelos en la lengua', 'PHRASE', 'frases hechas: geen blad voor de mond nemen', 'GEEN BLAD VOOR DE MOND NEMEN = no tener pelos en la lengua, decir las cosas claras, sin suavizarlas.

🧩 Expresión fija — geen blad voor de mond nemen:

• literal — no ponerse una hoja delante de la boca.
• significa — decir las cosas claras, sin suavizarlas.
• piezas fijas — het blad sin artículo, voor de mond fijo; casi siempre en negativo con geen; nemen es fuerte, nam, genomen con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Mijn oma neemt geen blad voor de mond. | Mi abuela no tiene pelos en la lengua. |
| 2 | perfecto | Hij heeft nooit een blad voor de mond genomen. | Nunca ha tenido pelos en la lengua. |
| 3 | subordinada | Ik vind het fijn dat je geen blad voor de mond neemt. | Me gusta que no tengas pelos en la lengua. |

🎯 En qué contexto se usa:

• para describir a alguien franco, a veces como elogio y a veces como reproche
• antes de una crítica, Ik neem geen blad voor de mond
• registro neutro, vale en el trabajo

🔑 El truco que casi nunca falla: los pelos en la lengua son una hoja delante de la boca, en los dos idiomas algo que tapa.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no tener pelos en la lengua');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener pelos en la lengua' LIMIT 1), 'nl_NL', 'geen blad voor de mond nemen', 'jeen blat foor de mont némen', '• [can.] Mijn oma neemt geen blad voor de mond. — Mi abuela no tiene pelos en la lengua.
• [perf.] Hij heeft nooit een blad voor de mond genomen. — Nunca ha tenido pelos en la lengua.
• [bijzin] Ik vind het fijn dat je geen blad voor de mond neemt. — Me gusta que no tengas pelos en la lengua.
• [vraag] Neem jij ooit een blad voor de mond? — ¿Tú alguna vez te muerdes la lengua?
• [geb.] Neem geen blad voor de mond en zeg wat je denkt. — No te cortes y di lo que piensas.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Mi abuela no tiene pelos en la lengua.', 'SENTENCE', 'Ejemplo de "geen blad voor de mond nemen" (can.)', 'GEEN BLAD VOOR DE MOND NEMEN = no tener pelos en la lengua, decir las cosas claras, sin suavizarlas.

🧩 Expresión fija — geen blad voor de mond nemen:

• literal — no ponerse una hoja delante de la boca.
• significa — decir las cosas claras, sin suavizarlas.
• piezas fijas — het blad sin artículo, voor de mond fijo; casi siempre en negativo con geen; nemen es fuerte, nam, genomen con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Mijn oma neemt geen blad voor de mond. | Mi abuela no tiene pelos en la lengua. |
| 2 | perfecto | Hij heeft nooit een blad voor de mond genomen. | Nunca ha tenido pelos en la lengua. |
| 3 | subordinada | Ik vind het fijn dat je geen blad voor de mond neemt. | Me gusta que no tengas pelos en la lengua. |

🎯 En qué contexto se usa:

• para describir a alguien franco, a veces como elogio y a veces como reproche
• antes de una crítica, Ik neem geen blad voor de mond
• registro neutro, vale en el trabajo

🔑 El truco que casi nunca falla: los pelos en la lengua son una hoja delante de la boca, en los dos idiomas algo que tapa.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi abuela no tiene pelos en la lengua.' AND notes = 'Ejemplo de "geen blad voor de mond nemen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi abuela no tiene pelos en la lengua.' AND notes = 'Ejemplo de "geen blad voor de mond nemen" (can.)' LIMIT 1), 'nl_NL', 'Mijn oma neemt geen blad voor de mond.', 'mein oma nemt jen blat for de mont', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener pelos en la lengua' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi abuela no tiene pelos en la lengua.' AND notes = 'Ejemplo de "geen blad voor de mond nemen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener pelos en la lengua' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener pelos en la lengua' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi abuela no tiene pelos en la lengua.' AND notes = 'Ejemplo de "geen blad voor de mond nemen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi abuela no tiene pelos en la lengua.' AND notes = 'Ejemplo de "geen blad voor de mond nemen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 007. meter la pata → een flater slaan
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'meter la pata', 'PHRASE', 'frases hechas: een flater slaan', 'EEN FLATER SLAAN = meter la pata, cometer un error, sobre todo decir algo inoportuno.

🧩 Expresión fija — een flater slaan:

• literal — dar un patinazo.
• significa — cometer un error, sobre todo decir algo inoportuno.
• piezas fijas — de flater con een; slaan es fuerte, sloeg, geslagen con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Ik heb een flater geslagen. | He metido la pata. |
| 2 | principal | Hij slaat altijd een flater op feestjes. | Siempre mete la pata en las fiestas. |
| 3 | pregunta | Heb ik een flater geslagen? | ¿He metido la pata? |

🎯 En qué contexto se usa:

• cuando dices algo inoportuno en una reunión o en una cena
• errores en el trabajo delante de otros
• para cualquier fallo, más coloquial, de mist ingaan

🔑 El truco que casi nunca falla: meter la pata es slaan, el verbo de golpear, como dar un golpe en falso.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'meter la pata');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'meter la pata' LIMIT 1), 'nl_NL', 'een flater slaan', 'en fláter slaan', '• [perf.] Ik heb een flater geslagen. — He metido la pata.
• [can.] Hij slaat altijd een flater op feestjes. — Siempre mete la pata en las fiestas.
• [vraag] Heb ik een flater geslagen? — ¿He metido la pata?
• [bijzin] Ik was bang dat ik een flater zou slaan. — Tenía miedo de meter la pata.
• [uitdr.] Daar ging ik flink de mist in. — Ahí metí la pata pero bien.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'He metido la pata.', 'SENTENCE', 'Ejemplo de "een flater slaan" (perf.)', 'EEN FLATER SLAAN = meter la pata, cometer un error, sobre todo decir algo inoportuno.

🧩 Expresión fija — een flater slaan:

• literal — dar un patinazo.
• significa — cometer un error, sobre todo decir algo inoportuno.
• piezas fijas — de flater con een; slaan es fuerte, sloeg, geslagen con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Ik heb een flater geslagen. | He metido la pata. |
| 2 | principal | Hij slaat altijd een flater op feestjes. | Siempre mete la pata en las fiestas. |
| 3 | pregunta | Heb ik een flater geslagen? | ¿He metido la pata? |

🎯 En qué contexto se usa:

• cuando dices algo inoportuno en una reunión o en una cena
• errores en el trabajo delante de otros
• para cualquier fallo, más coloquial, de mist ingaan

🔑 El truco que casi nunca falla: meter la pata es slaan, el verbo de golpear, como dar un golpe en falso.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'He metido la pata.' AND notes = 'Ejemplo de "een flater slaan" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'He metido la pata.' AND notes = 'Ejemplo de "een flater slaan" (perf.)' LIMIT 1), 'nl_NL', 'Ik heb een flater geslagen.', 'ik heb en flater jeslajen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'meter la pata' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'He metido la pata.' AND notes = 'Ejemplo de "een flater slaan" (perf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'meter la pata' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'meter la pata' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He metido la pata.' AND notes = 'Ejemplo de "een flater slaan" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He metido la pata.' AND notes = 'Ejemplo de "een flater slaan" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 008. echar una mano → iemand een handje helpen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'echar una mano', 'PHRASE', 'frases hechas: iemand een handje helpen', 'IEMAND EEN HANDJE HELPEN = echar una mano, ayudar un poco.

🧩 Expresión fija — iemand een handje helpen:

• literal — ayudar a alguien una manita.
• significa — ayudar un poco.
• piezas fijas — het handje es het por el -je, pero va con een; helpen rige objeto directo, sin preposición; helpen es fuerte, hielp, geholpen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pregunta | Kun je me even een handje helpen? | ¿Me echas una mano? |
| 2 | principal | Ik help je wel een handje. | Ya te echo yo una mano. |
| 3 | perfecto | De buren hebben ons een handje geholpen. | Los vecinos nos han echado una mano. |

🎯 En qué contexto se usa:

• pedir ayuda informal, una mudanza, la cocina, cargar algo
• para ofrecerte, Ik help je wel een handje
• con u queda educado, Kunt u me een handje helpen?

🔑 El truco que casi nunca falla: la mano española en neerlandés es diminutiva, siempre handje.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'echar una mano');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'echar una mano' LIMIT 1), 'nl_NL', 'iemand een handje helpen', 'íemant en hántie hélpen', '• [vraag] Kun je me even een handje helpen? — ¿Me echas una mano?
• [can.] Ik help je wel een handje. — Ya te echo yo una mano.
• [perf.] De buren hebben ons een handje geholpen. — Los vecinos nos han echado una mano.
• [bijzin] Het is fijn als iemand je een handje helpt. — Está bien que alguien te eche una mano.
• [geb.] Help je zus even een handje. — Échale una mano a tu hermana.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Me echas una mano?', 'SENTENCE', 'Ejemplo de "iemand een handje helpen" (vraag)', 'IEMAND EEN HANDJE HELPEN = echar una mano, ayudar un poco.

🧩 Expresión fija — iemand een handje helpen:

• literal — ayudar a alguien una manita.
• significa — ayudar un poco.
• piezas fijas — het handje es het por el -je, pero va con een; helpen rige objeto directo, sin preposición; helpen es fuerte, hielp, geholpen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pregunta | Kun je me even een handje helpen? | ¿Me echas una mano? |
| 2 | principal | Ik help je wel een handje. | Ya te echo yo una mano. |
| 3 | perfecto | De buren hebben ons een handje geholpen. | Los vecinos nos han echado una mano. |

🎯 En qué contexto se usa:

• pedir ayuda informal, una mudanza, la cocina, cargar algo
• para ofrecerte, Ik help je wel een handje
• con u queda educado, Kunt u me een handje helpen?

🔑 El truco que casi nunca falla: la mano española en neerlandés es diminutiva, siempre handje.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Me echas una mano?' AND notes = 'Ejemplo de "iemand een handje helpen" (vraag)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me echas una mano?' AND notes = 'Ejemplo de "iemand een handje helpen" (vraag)' LIMIT 1), 'nl_NL', 'Kun je me even een handje helpen?', 'kün ie me efen en handie helpen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'echar una mano' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿Me echas una mano?' AND notes = 'Ejemplo de "iemand een handje helpen" (vraag)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'echar una mano' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'echar una mano' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me echas una mano?' AND notes = 'Ejemplo de "iemand een handje helpen" (vraag)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Me echas una mano?' AND notes = 'Ejemplo de "iemand een handje helpen" (vraag)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 009. estar como una cabra → niet goed snik zijn
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estar como una cabra', 'PHRASE', 'frases hechas: niet goed snik zijn', 'NIET GOED SNIK ZIJN = estar como una cabra, estar chiflado.

🧩 Expresión fija — niet goed snik zijn:

• literal — no estar bien snik, una palabra antigua que significaba cuerdo.
• significa — estar chiflado.
• piezas fijas — snik solo vive en esta frase y siempre con niet goed; zijn se conjuga.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Die man is niet goed snik. | Ese hombre está como una cabra. |
| 2 | pregunta | Ben je niet goed snik? | ¿Estás como una cabra? |
| 3 | perfecto | Hij is altijd al een beetje niet goed snik geweest. | Siempre ha estado un poco como una cabra. |

🎯 En qué contexto se usa:

• de broma con amigos sobre alguien que hace locuras
• con desconocidos puede ofender, mejor no
• variante, ze zien vliegen, ver moscas volando

🔑 El truco que casi nunca falla: snik no lo busques en el diccionario, solo existe pegado a niet goed.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estar como una cabra');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'estar como una cabra' LIMIT 1), 'nl_NL', 'niet goed snik zijn', 'nit jut snik sein', '• [can.] Die man is niet goed snik. — Ese hombre está como una cabra.
• [vraag] Ben je niet goed snik? — ¿Estás como una cabra?
• [perf.] Hij is altijd al een beetje niet goed snik geweest. — Siempre ha estado un poco como una cabra.
• [bijzin] Ze denken dat ik niet goed snik ben. — Piensan que estoy como una cabra.
• [uitdr.] Hij ziet ze vliegen. — Está chalado.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ese hombre está como una cabra.', 'SENTENCE', 'Ejemplo de "niet goed snik zijn" (can.)', 'NIET GOED SNIK ZIJN = estar como una cabra, estar chiflado.

🧩 Expresión fija — niet goed snik zijn:

• literal — no estar bien snik, una palabra antigua que significaba cuerdo.
• significa — estar chiflado.
• piezas fijas — snik solo vive en esta frase y siempre con niet goed; zijn se conjuga.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Die man is niet goed snik. | Ese hombre está como una cabra. |
| 2 | pregunta | Ben je niet goed snik? | ¿Estás como una cabra? |
| 3 | perfecto | Hij is altijd al een beetje niet goed snik geweest. | Siempre ha estado un poco como una cabra. |

🎯 En qué contexto se usa:

• de broma con amigos sobre alguien que hace locuras
• con desconocidos puede ofender, mejor no
• variante, ze zien vliegen, ver moscas volando

🔑 El truco que casi nunca falla: snik no lo busques en el diccionario, solo existe pegado a niet goed.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ese hombre está como una cabra.' AND notes = 'Ejemplo de "niet goed snik zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Ese hombre está como una cabra.' AND notes = 'Ejemplo de "niet goed snik zijn" (can.)' LIMIT 1), 'nl_NL', 'Die man is niet goed snik.', 'di man is nit jut snik', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'estar como una cabra' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Ese hombre está como una cabra.' AND notes = 'Ejemplo de "niet goed snik zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar como una cabra' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar como una cabra' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ese hombre está como una cabra.' AND notes = 'Ejemplo de "niet goed snik zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ese hombre está como una cabra.' AND notes = 'Ejemplo de "niet goed snik zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 010. llover a cántaros → het regent pijpenstelen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'llover a cántaros', 'PHRASE', 'frases hechas: het regent pijpenstelen', 'HET REGENT PIJPENSTELEN = llover a cántaros, llover muchísimo.

🧩 Expresión fija — het regent pijpenstelen:

• literal — llueven cañas de pipa.
• significa — llover muchísimo.
• piezas fijas — het vacío como sujeto, igual que het sneeuwt; pijpenstelen en plural sin artículo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Het regent pijpenstelen. | Llueve a cántaros. |
| 2 | perfecto | Het heeft de hele nacht pijpenstelen geregend. | Ha llovido a cántaros toda la noche. |
| 3 | inversión | Gisteren regende het pijpenstelen. | Ayer llovía a cántaros. |

🎯 En qué contexto se usa:

• hablar del tiempo, la conversación más neerlandesa que hay
• excusas para no salir o para llegar tarde
• variante corta, het giet, diluvia

🔑 El truco que casi nunca falla: el het del tiempo va siempre de sujeto, como en het regent o het waait.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'llover a cántaros');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'llover a cántaros' LIMIT 1), 'nl_NL', 'het regent pijpenstelen', 'et réjent péipenstélen', '• [can.] Het regent pijpenstelen. — Llueve a cántaros.
• [perf.] Het heeft de hele nacht pijpenstelen geregend. — Ha llovido a cántaros toda la noche.
• [inv.] Gisteren regende het pijpenstelen. — Ayer llovía a cántaros.
• [bijzin] Ik blijf binnen omdat het pijpenstelen regent. — Me quedo dentro porque llueve a cántaros.
• [uitdr.] Het giet. — Diluvia.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Llueve a cántaros.', 'SENTENCE', 'Ejemplo de "het regent pijpenstelen" (can.)', 'HET REGENT PIJPENSTELEN = llover a cántaros, llover muchísimo.

🧩 Expresión fija — het regent pijpenstelen:

• literal — llueven cañas de pipa.
• significa — llover muchísimo.
• piezas fijas — het vacío como sujeto, igual que het sneeuwt; pijpenstelen en plural sin artículo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Het regent pijpenstelen. | Llueve a cántaros. |
| 2 | perfecto | Het heeft de hele nacht pijpenstelen geregend. | Ha llovido a cántaros toda la noche. |
| 3 | inversión | Gisteren regende het pijpenstelen. | Ayer llovía a cántaros. |

🎯 En qué contexto se usa:

• hablar del tiempo, la conversación más neerlandesa que hay
• excusas para no salir o para llegar tarde
• variante corta, het giet, diluvia

🔑 El truco que casi nunca falla: el het del tiempo va siempre de sujeto, como en het regent o het waait.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Llueve a cántaros.' AND notes = 'Ejemplo de "het regent pijpenstelen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Llueve a cántaros.' AND notes = 'Ejemplo de "het regent pijpenstelen" (can.)' LIMIT 1), 'nl_NL', 'Het regent pijpenstelen.', 'het rejent peipenstelen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'llover a cántaros' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Llueve a cántaros.' AND notes = 'Ejemplo de "het regent pijpenstelen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'llover a cántaros' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'llover a cántaros' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Llueve a cántaros.' AND notes = 'Ejemplo de "het regent pijpenstelen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Llueve a cántaros.' AND notes = 'Ejemplo de "het regent pijpenstelen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 011. dar en el clavo → de spijker op de kop slaan
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'dar en el clavo', 'PHRASE', 'frases hechas: de spijker op de kop slaan', 'DE SPIJKER OP DE KOP SLAAN = dar en el clavo, acertar de lleno.

🧩 Expresión fija — de spijker op de kop slaan:

• literal — golpear el clavo en la cabeza.
• significa — acertar de lleno.
• piezas fijas — de spijker, op de kop con de; slaan es fuerte, sloeg, geslagen con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je slaat de spijker op de kop. | Das en el clavo. |
| 2 | perfecto | Met die opmerking heeft ze de spijker op de kop geslagen. | Con ese comentario ha dado en el clavo. |
| 3 | pregunta | Sla ik de spijker op de kop? | ¿Doy en el clavo? |

🎯 En qué contexto se usa:

• elogiar un comentario certero en una reunión
• muy típico con daar, Daar sla je de spijker op de kop
• registro neutro, sirve también por escrito

🔑 El truco que casi nunca falla: en los dos idiomas hay clavo, en neerlandés además le das en la cabeza.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'dar en el clavo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'dar en el clavo' LIMIT 1), 'nl_NL', 'de spijker op de kop slaan', 'de spéiker op de kop slaan', '• [can.] Je slaat de spijker op de kop. — Das en el clavo.
• [perf.] Met die opmerking heeft ze de spijker op de kop geslagen. — Con ese comentario ha dado en el clavo.
• [vraag] Sla ik de spijker op de kop? — ¿Doy en el clavo?
• [bijzin] Ik denk dat je de spijker op de kop slaat. — Creo que das en el clavo.
• [inv.] Daar sla je de spijker op de kop. — Ahí das en el clavo.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Das en el clavo.', 'SENTENCE', 'Ejemplo de "de spijker op de kop slaan" (can.)', 'DE SPIJKER OP DE KOP SLAAN = dar en el clavo, acertar de lleno.

🧩 Expresión fija — de spijker op de kop slaan:

• literal — golpear el clavo en la cabeza.
• significa — acertar de lleno.
• piezas fijas — de spijker, op de kop con de; slaan es fuerte, sloeg, geslagen con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je slaat de spijker op de kop. | Das en el clavo. |
| 2 | perfecto | Met die opmerking heeft ze de spijker op de kop geslagen. | Con ese comentario ha dado en el clavo. |
| 3 | pregunta | Sla ik de spijker op de kop? | ¿Doy en el clavo? |

🎯 En qué contexto se usa:

• elogiar un comentario certero en una reunión
• muy típico con daar, Daar sla je de spijker op de kop
• registro neutro, sirve también por escrito

🔑 El truco que casi nunca falla: en los dos idiomas hay clavo, en neerlandés además le das en la cabeza.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Das en el clavo.' AND notes = 'Ejemplo de "de spijker op de kop slaan" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Das en el clavo.' AND notes = 'Ejemplo de "de spijker op de kop slaan" (can.)' LIMIT 1), 'nl_NL', 'Je slaat de spijker op de kop.', 'ie slaat de speiker op de kop', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'dar en el clavo' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Das en el clavo.' AND notes = 'Ejemplo de "de spijker op de kop slaan" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'dar en el clavo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'dar en el clavo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Das en el clavo.' AND notes = 'Ejemplo de "de spijker op de kop slaan" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Das en el clavo.' AND notes = 'Ejemplo de "de spijker op de kop slaan" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 012. levantarse con el pie izquierdo → met het verkeerde been uit bed stappen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'levantarse con el pie izquierdo', 'PHRASE', 'frases hechas: met het verkeerde been uit bed stappen', 'MET HET VERKEERDE BEEN UIT BED STAPPEN = levantarse con el pie izquierdo, empezar el día de mal humor o con mala suerte.

🧩 Expresión fija — met het verkeerde been uit bed stappen:

• literal — salir de la cama con la pierna equivocada.
• significa — empezar el día de mal humor o con mala suerte.
• piezas fijas — het been, verkeerde con -e; uit bed sin artículo; stappen va con zijn, is uit bed gestapt.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Ik ben met het verkeerde been uit bed gestapt. | Me he levantado con el pie izquierdo. |
| 2 | pregunta | Ben je met het verkeerde been uit bed gestapt? | ¿Te has levantado con el pie izquierdo? |
| 3 | principal | Hij stapt elke maandag met het verkeerde been uit bed. | Todos los lunes se levanta con el pie izquierdo. |

🎯 En qué contexto se usa:

• explicar el mal humor de alguien, sobre todo por la mañana
• disculparte por estar borde, Sorry, ik ben met het verkeerde been uit bed gestapt
• muy frecuente en pregunta, con ironía

🔑 El truco que casi nunca falla: el pie izquierdo es una pierna equivocada, y como sales de la cama el auxiliar es zijn.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'levantarse con el pie izquierdo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'levantarse con el pie izquierdo' LIMIT 1), 'nl_NL', 'met het verkeerde been uit bed stappen', 'met et ferkérde been öit bet stápen', '• [perf.] Ik ben met het verkeerde been uit bed gestapt. — Me he levantado con el pie izquierdo.
• [vraag] Ben je met het verkeerde been uit bed gestapt? — ¿Te has levantado con el pie izquierdo?
• [can.] Hij stapt elke maandag met het verkeerde been uit bed. — Todos los lunes se levanta con el pie izquierdo.
• [bijzin] Het lijkt erop dat de baas met het verkeerde been uit bed is gestapt. — Parece que el jefe se ha levantado con el pie izquierdo.
• [inv.] Vanochtend stapte ze met het verkeerde been uit bed. — Esta mañana se levantó con el pie izquierdo.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me he levantado con el pie izquierdo.', 'SENTENCE', 'Ejemplo de "met het verkeerde been uit bed stappen" (perf.)', 'MET HET VERKEERDE BEEN UIT BED STAPPEN = levantarse con el pie izquierdo, empezar el día de mal humor o con mala suerte.

🧩 Expresión fija — met het verkeerde been uit bed stappen:

• literal — salir de la cama con la pierna equivocada.
• significa — empezar el día de mal humor o con mala suerte.
• piezas fijas — het been, verkeerde con -e; uit bed sin artículo; stappen va con zijn, is uit bed gestapt.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Ik ben met het verkeerde been uit bed gestapt. | Me he levantado con el pie izquierdo. |
| 2 | pregunta | Ben je met het verkeerde been uit bed gestapt? | ¿Te has levantado con el pie izquierdo? |
| 3 | principal | Hij stapt elke maandag met het verkeerde been uit bed. | Todos los lunes se levanta con el pie izquierdo. |

🎯 En qué contexto se usa:

• explicar el mal humor de alguien, sobre todo por la mañana
• disculparte por estar borde, Sorry, ik ben met het verkeerde been uit bed gestapt
• muy frecuente en pregunta, con ironía

🔑 El truco que casi nunca falla: el pie izquierdo es una pierna equivocada, y como sales de la cama el auxiliar es zijn.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me he levantado con el pie izquierdo.' AND notes = 'Ejemplo de "met het verkeerde been uit bed stappen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Me he levantado con el pie izquierdo.' AND notes = 'Ejemplo de "met het verkeerde been uit bed stappen" (perf.)' LIMIT 1), 'nl_NL', 'Ik ben met het verkeerde been uit bed gestapt.', 'ik ben met het ferkerde ben öit bet jestapt', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'levantarse con el pie izquierdo' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me he levantado con el pie izquierdo.' AND notes = 'Ejemplo de "met het verkeerde been uit bed stappen" (perf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'levantarse con el pie izquierdo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'levantarse con el pie izquierdo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me he levantado con el pie izquierdo.' AND notes = 'Ejemplo de "met het verkeerde been uit bed stappen" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me he levantado con el pie izquierdo.' AND notes = 'Ejemplo de "met het verkeerde been uit bed stappen" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 013. ponerse las pilas → een tandje bijzetten
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ponerse las pilas', 'PHRASE', 'frases hechas: een tandje bijzetten', 'EEN TANDJE BIJZETTEN = ponerse las pilas, esforzarse más, acelerar.

🧩 Expresión fija — een tandje bijzetten:

• literal — poner un dientecito más, del engranaje.
• significa — esforzarse más, acelerar.
• piezas fijas — het tandje con een; bijzetten es separable, zet een tandje bij, heeft bijgezet, bij te zetten.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je moet een tandje bijzetten. | Tienes que ponerte las pilas. |
| 2 | pregunta | Kun je een tandje bijzetten? | ¿Puedes ponerte las pilas? |
| 3 | perfecto | Na de vakantie heb ik een tandje bijgezet. | Después de las vacaciones me he puesto las pilas. |

🎯 En qué contexto se usa:

• trabajo, estudio y deporte, cuando hay que rendir más
• animar a un equipo, We moeten een tandje bijzetten
• registro neutro, lo dice un jefe y lo dice un entrenador

🔑 El truco que casi nunca falla: el tandje es un diente del engranaje, subes una marcha.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ponerse las pilas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse las pilas' LIMIT 1), 'nl_NL', 'een tandje bijzetten', 'en tántie béisetten', '• [can.] Je moet een tandje bijzetten. — Tienes que ponerte las pilas.
• [vraag] Kun je een tandje bijzetten? — ¿Puedes ponerte las pilas?
• [perf.] Na de vakantie heb ik een tandje bijgezet. — Después de las vacaciones me he puesto las pilas.
• [bijzin] De coach zegt dat we een tandje moeten bijzetten. — El entrenador dice que tenemos que ponernos las pilas.
• [can.] Ze zet nu een tandje bij. — Ahora se pone las pilas.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Tienes que ponerte las pilas.', 'SENTENCE', 'Ejemplo de "een tandje bijzetten" (can.)', 'EEN TANDJE BIJZETTEN = ponerse las pilas, esforzarse más, acelerar.

🧩 Expresión fija — een tandje bijzetten:

• literal — poner un dientecito más, del engranaje.
• significa — esforzarse más, acelerar.
• piezas fijas — het tandje con een; bijzetten es separable, zet een tandje bij, heeft bijgezet, bij te zetten.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je moet een tandje bijzetten. | Tienes que ponerte las pilas. |
| 2 | pregunta | Kun je een tandje bijzetten? | ¿Puedes ponerte las pilas? |
| 3 | perfecto | Na de vakantie heb ik een tandje bijgezet. | Después de las vacaciones me he puesto las pilas. |

🎯 En qué contexto se usa:

• trabajo, estudio y deporte, cuando hay que rendir más
• animar a un equipo, We moeten een tandje bijzetten
• registro neutro, lo dice un jefe y lo dice un entrenador

🔑 El truco que casi nunca falla: el tandje es un diente del engranaje, subes una marcha.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Tienes que ponerte las pilas.' AND notes = 'Ejemplo de "een tandje bijzetten" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Tienes que ponerte las pilas.' AND notes = 'Ejemplo de "een tandje bijzetten" (can.)' LIMIT 1), 'nl_NL', 'Je moet een tandje bijzetten.', 'ie mut en tandie beiseten', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse las pilas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Tienes que ponerte las pilas.' AND notes = 'Ejemplo de "een tandje bijzetten" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse las pilas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse las pilas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tienes que ponerte las pilas.' AND notes = 'Ejemplo de "een tandje bijzetten" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tienes que ponerte las pilas.' AND notes = 'Ejemplo de "een tandje bijzetten" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 014. no pegar ojo → geen oog dichtdoen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no pegar ojo', 'PHRASE', 'frases hechas: geen oog dichtdoen', 'GEEN OOG DICHTDOEN = no pegar ojo, no dormir nada en toda la noche.

🧩 Expresión fija — geen oog dichtdoen:

• literal — no cerrar un ojo.
• significa — no dormir nada en toda la noche.
• piezas fijas — het oog sin artículo detrás de geen; dichtdoen es separable y fuerte, deed geen oog dicht, heeft geen oog dichtgedaan.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Ik heb de hele nacht geen oog dichtgedaan. | No he pegado ojo en toda la noche. |
| 2 | inversión | Door de buren deed ik geen oog dicht. | Por los vecinos no pegué ojo. |
| 3 | pregunta | Heb je geen oog dichtgedaan? | ¿No has pegado ojo? |

🎯 En qué contexto se usa:

• noches de insomnio, ruido de vecinos, nervios antes de algo
• casi siempre en perfecto o en imperfecto, hablando de anoche
• registro neutro

🔑 El truco que casi nunca falla: pegar el ojo es cerrarlo, dicht, y dichtdoen se separa.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no pegar ojo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'no pegar ojo' LIMIT 1), 'nl_NL', 'geen oog dichtdoen', 'jeen oj díjtdun', '• [perf.] Ik heb de hele nacht geen oog dichtgedaan. — No he pegado ojo en toda la noche.
• [inv.] Door de buren deed ik geen oog dicht. — Por los vecinos no pegué ojo.
• [vraag] Heb je geen oog dichtgedaan? — ¿No has pegado ojo?
• [bijzin] Hij zegt dat hij geen oog heeft dichtgedaan. — Dice que no ha pegado ojo.
• [can.] Voor een examen doe ik nooit een oog dicht. — Antes de un examen nunca pego ojo.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No he pegado ojo en toda la noche.', 'SENTENCE', 'Ejemplo de "geen oog dichtdoen" (perf.)', 'GEEN OOG DICHTDOEN = no pegar ojo, no dormir nada en toda la noche.

🧩 Expresión fija — geen oog dichtdoen:

• literal — no cerrar un ojo.
• significa — no dormir nada en toda la noche.
• piezas fijas — het oog sin artículo detrás de geen; dichtdoen es separable y fuerte, deed geen oog dicht, heeft geen oog dichtgedaan.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Ik heb de hele nacht geen oog dichtgedaan. | No he pegado ojo en toda la noche. |
| 2 | inversión | Door de buren deed ik geen oog dicht. | Por los vecinos no pegué ojo. |
| 3 | pregunta | Heb je geen oog dichtgedaan? | ¿No has pegado ojo? |

🎯 En qué contexto se usa:

• noches de insomnio, ruido de vecinos, nervios antes de algo
• casi siempre en perfecto o en imperfecto, hablando de anoche
• registro neutro

🔑 El truco que casi nunca falla: pegar el ojo es cerrarlo, dicht, y dichtdoen se separa.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No he pegado ojo en toda la noche.' AND notes = 'Ejemplo de "geen oog dichtdoen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'No he pegado ojo en toda la noche.' AND notes = 'Ejemplo de "geen oog dichtdoen" (perf.)' LIMIT 1), 'nl_NL', 'Ik heb de hele nacht geen oog dichtgedaan.', 'ik heb de hele najt jen oj dijtjedaan', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'no pegar ojo' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No he pegado ojo en toda la noche.' AND notes = 'Ejemplo de "geen oog dichtdoen" (perf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no pegar ojo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no pegar ojo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No he pegado ojo en toda la noche.' AND notes = 'Ejemplo de "geen oog dichtdoen" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No he pegado ojo en toda la noche.' AND notes = 'Ejemplo de "geen oog dichtdoen" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 015. tirar la toalla → de handdoek in de ring gooien
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tirar la toalla', 'PHRASE', 'frases hechas: de handdoek in de ring gooien', 'DE HANDDOEK IN DE RING GOOIEN = tirar la toalla, rendirse.

🧩 Expresión fija — de handdoek in de ring gooien:

• literal — tirar la toalla al ring.
• significa — rendirse.
• piezas fijas — de handdoek, in de ring; gooien es débil, gegooid con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Gooi de handdoek niet in de ring! | ¡No tires la toalla! |
| 2 | perfecto | Na drie maanden heeft hij de handdoek in de ring gegooid. | Después de tres meses ha tirado la toalla. |
| 3 | principal | Ik gooi de handdoek nog niet in de ring. | Todavía no tiro la toalla. |

🎯 En qué contexto se usa:

• rendirse en un proyecto, una dieta, un curso de idiomas
• para animar, Gooi de handdoek niet in de ring
• viene del boxeo, igual que en español

🔑 El truco que casi nunca falla: igual que en español, solo hay que añadir el ring.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'tirar la toalla');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'tirar la toalla' LIMIT 1), 'nl_NL', 'de handdoek in de ring gooien', 'de hánduk in de ring jóien', '• [geb.] Gooi de handdoek niet in de ring! — ¡No tires la toalla!
• [perf.] Na drie maanden heeft hij de handdoek in de ring gegooid. — Después de tres meses ha tirado la toalla.
• [can.] Ik gooi de handdoek nog niet in de ring. — Todavía no tiro la toalla.
• [bijzin] Het is jammer dat ze de handdoek in de ring gooit. — Es una pena que tire la toalla.
• [vraag] Gooi je nu al de handdoek in de ring? — ¿Ya tiras la toalla?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡No tires la toalla!', 'SENTENCE', 'Ejemplo de "de handdoek in de ring gooien" (geb.)', 'DE HANDDOEK IN DE RING GOOIEN = tirar la toalla, rendirse.

🧩 Expresión fija — de handdoek in de ring gooien:

• literal — tirar la toalla al ring.
• significa — rendirse.
• piezas fijas — de handdoek, in de ring; gooien es débil, gegooid con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Gooi de handdoek niet in de ring! | ¡No tires la toalla! |
| 2 | perfecto | Na drie maanden heeft hij de handdoek in de ring gegooid. | Después de tres meses ha tirado la toalla. |
| 3 | principal | Ik gooi de handdoek nog niet in de ring. | Todavía no tiro la toalla. |

🎯 En qué contexto se usa:

• rendirse en un proyecto, una dieta, un curso de idiomas
• para animar, Gooi de handdoek niet in de ring
• viene del boxeo, igual que en español

🔑 El truco que casi nunca falla: igual que en español, solo hay que añadir el ring.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡No tires la toalla!' AND notes = 'Ejemplo de "de handdoek in de ring gooien" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡No tires la toalla!' AND notes = 'Ejemplo de "de handdoek in de ring gooien" (geb.)' LIMIT 1), 'nl_NL', 'Gooi de handdoek niet in de ring!', 'joi de handuk nit in de ring', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'tirar la toalla' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡No tires la toalla!' AND notes = 'Ejemplo de "de handdoek in de ring gooien" (geb.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tirar la toalla' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tirar la toalla' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡No tires la toalla!' AND notes = 'Ejemplo de "de handdoek in de ring gooien" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡No tires la toalla!' AND notes = 'Ejemplo de "de handdoek in de ring gooien" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 016. matar dos pájaros de un tiro → twee vliegen in één klap slaan
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'matar dos pájaros de un tiro', 'PHRASE', 'frases hechas: twee vliegen in één klap slaan', 'TWEE VLIEGEN IN ÉÉN KLAP SLAAN = matar dos pájaros de un tiro, conseguir dos cosas con una sola acción.

🧩 Expresión fija — twee vliegen in één klap slaan:

• literal — matar dos moscas de un golpe.
• significa — conseguir dos cosas con una sola acción.
• piezas fijas — één con acentos para leer uno y no un; in één klap fijo; slaan es fuerte, sloeg, geslagen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Ik heb twee vliegen in één klap geslagen. | He matado dos pájaros de un tiro. |
| 2 | inversión | Zo sla je twee vliegen in één klap. | Así matas dos pájaros de un tiro. |
| 3 | subordinada | Als ik nu ga, sla ik twee vliegen in één klap. | Si voy ahora, mato dos pájaros de un tiro. |

🎯 En qué contexto se usa:

• organizar recados juntos, aprovechar un viaje
• proponer un plan eficiente en el trabajo
• registro neutro, se oye a diario

🔑 El truco que casi nunca falla: los pájaros españoles son moscas en neerlandés, y el tiro es un manotazo.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'matar dos pájaros de un tiro');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'matar dos pájaros de un tiro' LIMIT 1), 'nl_NL', 'twee vliegen in één klap slaan', 'tuee flíjen in een klap slaan', '• [perf.] Ik heb twee vliegen in één klap geslagen. — He matado dos pájaros de un tiro.
• [inv.] Zo sla je twee vliegen in één klap. — Así matas dos pájaros de un tiro.
• [bijzin] Als ik nu ga, sla ik twee vliegen in één klap. — Si voy ahora, mato dos pájaros de un tiro.
• [vraag] Sla je zo niet twee vliegen in één klap? — ¿Así no matas dos pájaros de un tiro?
• [can.] Met de fiets sla je twee vliegen in één klap. — Con la bici matas dos pájaros de un tiro.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'He matado dos pájaros de un tiro.', 'SENTENCE', 'Ejemplo de "twee vliegen in één klap slaan" (perf.)', 'TWEE VLIEGEN IN ÉÉN KLAP SLAAN = matar dos pájaros de un tiro, conseguir dos cosas con una sola acción.

🧩 Expresión fija — twee vliegen in één klap slaan:

• literal — matar dos moscas de un golpe.
• significa — conseguir dos cosas con una sola acción.
• piezas fijas — één con acentos para leer uno y no un; in één klap fijo; slaan es fuerte, sloeg, geslagen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Ik heb twee vliegen in één klap geslagen. | He matado dos pájaros de un tiro. |
| 2 | inversión | Zo sla je twee vliegen in één klap. | Así matas dos pájaros de un tiro. |
| 3 | subordinada | Als ik nu ga, sla ik twee vliegen in één klap. | Si voy ahora, mato dos pájaros de un tiro. |

🎯 En qué contexto se usa:

• organizar recados juntos, aprovechar un viaje
• proponer un plan eficiente en el trabajo
• registro neutro, se oye a diario

🔑 El truco que casi nunca falla: los pájaros españoles son moscas en neerlandés, y el tiro es un manotazo.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'He matado dos pájaros de un tiro.' AND notes = 'Ejemplo de "twee vliegen in één klap slaan" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'He matado dos pájaros de un tiro.' AND notes = 'Ejemplo de "twee vliegen in één klap slaan" (perf.)' LIMIT 1), 'nl_NL', 'Ik heb twee vliegen in één klap geslagen.', 'ik heb tue flijen in één klap jeslajen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'matar dos pájaros de un tiro' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'He matado dos pájaros de un tiro.' AND notes = 'Ejemplo de "twee vliegen in één klap slaan" (perf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'matar dos pájaros de un tiro' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'matar dos pájaros de un tiro' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He matado dos pájaros de un tiro.' AND notes = 'Ejemplo de "twee vliegen in één klap slaan" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'He matado dos pájaros de un tiro.' AND notes = 'Ejemplo de "twee vliegen in één klap slaan" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 017. más vale tarde que nunca → beter laat dan nooit
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'más vale tarde que nunca', 'PHRASE', 'frases hechas: beter laat dan nooit', 'BETER LAAT DAN NOOIT = más vale tarde que nunca, es preferible hacer algo tarde a no hacerlo.

🧩 Expresión fija — beter laat dan nooit:

• literal — mejor tarde que nunca.
• significa — es preferible hacer algo tarde a no hacerlo.
• piezas fijas — refrán cerrado, sin verbo, no se toca.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Beter laat dan nooit! | ¡Más vale tarde que nunca! |
| 2 | principal | Hij komt eindelijk, beter laat dan nooit. | Por fin viene, más vale tarde que nunca. |
| 3 | perfecto | Ik heb mijn rijbewijs op mijn vijftigste gehaald, beter laat dan nooit. | Me he sacado el carné a los cincuenta, más vale tarde que nunca. |

🎯 En qué contexto se usa:

• cuando alguien llega tarde o por fin hace algo pendiente
• en tono amable o irónico
• también para hablar de uno mismo, el carné a los cincuenta

🔑 El truco que casi nunca falla: palabra por palabra igual, solo que mejor es beter.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'más vale tarde que nunca');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'más vale tarde que nunca' LIMIT 1), 'nl_NL', 'beter laat dan nooit', 'béter laat dan noit', '• [uitdr.] Beter laat dan nooit! — ¡Más vale tarde que nunca!
• [can.] Hij komt eindelijk, beter laat dan nooit. — Por fin viene, más vale tarde que nunca.
• [perf.] Ik heb mijn rijbewijs op mijn vijftigste gehaald, beter laat dan nooit. — Me he sacado el carné a los cincuenta, más vale tarde que nunca.
• [bijzin] Ze zei dat het beter laat dan nooit was. — Dijo que más valía tarde que nunca.
• [vraag] Beter laat dan nooit, toch? — Más vale tarde que nunca, ¿no?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Más vale tarde que nunca!', 'SENTENCE', 'Ejemplo de "beter laat dan nooit" (uitdr.)', 'BETER LAAT DAN NOOIT = más vale tarde que nunca, es preferible hacer algo tarde a no hacerlo.

🧩 Expresión fija — beter laat dan nooit:

• literal — mejor tarde que nunca.
• significa — es preferible hacer algo tarde a no hacerlo.
• piezas fijas — refrán cerrado, sin verbo, no se toca.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Beter laat dan nooit! | ¡Más vale tarde que nunca! |
| 2 | principal | Hij komt eindelijk, beter laat dan nooit. | Por fin viene, más vale tarde que nunca. |
| 3 | perfecto | Ik heb mijn rijbewijs op mijn vijftigste gehaald, beter laat dan nooit. | Me he sacado el carné a los cincuenta, más vale tarde que nunca. |

🎯 En qué contexto se usa:

• cuando alguien llega tarde o por fin hace algo pendiente
• en tono amable o irónico
• también para hablar de uno mismo, el carné a los cincuenta

🔑 El truco que casi nunca falla: palabra por palabra igual, solo que mejor es beter.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Más vale tarde que nunca!' AND notes = 'Ejemplo de "beter laat dan nooit" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Más vale tarde que nunca!' AND notes = 'Ejemplo de "beter laat dan nooit" (uitdr.)' LIMIT 1), 'nl_NL', 'Beter laat dan nooit!', 'beter laat dan noit', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'más vale tarde que nunca' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Más vale tarde que nunca!' AND notes = 'Ejemplo de "beter laat dan nooit" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'más vale tarde que nunca' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'más vale tarde que nunca' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Más vale tarde que nunca!' AND notes = 'Ejemplo de "beter laat dan nooit" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Más vale tarde que nunca!' AND notes = 'Ejemplo de "beter laat dan nooit" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 018. no hay mal que por bien no venga → elk nadeel heb z'n voordeel
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no hay mal que por bien no venga', 'PHRASE', 'frases hechas: elk nadeel heb z''n voordeel', 'ELK NADEEL HEB Z''N VOORDEEL = no hay mal que por bien no venga, de algo malo también sale algo bueno.

🧩 Expresión fija — elk nadeel heb z''n voordeel:

• literal — cada desventaja tiene su ventaja.
• significa — de algo malo también sale algo bueno.
• piezas fijas — frase de Johan Cruijff con heb sin -t a propósito, mal dicha y famosa; z''n es zijn.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Elk nadeel heb z''n voordeel. | No hay mal que por bien no venga. |
| 2 | principal | De trein rijdt niet, maar elk nadeel heb z''n voordeel. | El tren no circula, pero no hay mal que por bien no venga. |
| 3 | perfecto | Ik ben mijn baan kwijtgeraakt, maar elk nadeel heb z''n voordeel. | He perdido el trabajo, pero no hay mal que por bien no venga. |

🎯 En qué contexto se usa:

• consolar a alguien tras un contratiempo
• tono de humor, todo neerlandés reconoce la frase de Cruijff
• ⚠️ el heb sin t solo vale aquí, en cualquier otra frase es heeft

🔑 El truco que casi nunca falla: dila con el error de Cruijff, heb, o pierde la gracia.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no hay mal que por bien no venga');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'no hay mal que por bien no venga' LIMIT 1), 'nl_NL', 'elk nadeel heb z''n voordeel', 'elk nádeel hep sen fórdeel', '• [uitdr.] Elk nadeel heb z''n voordeel. — No hay mal que por bien no venga.
• [can.] De trein rijdt niet, maar elk nadeel heb z''n voordeel. — El tren no circula, pero no hay mal que por bien no venga.
• [perf.] Ik ben mijn baan kwijtgeraakt, maar elk nadeel heb z''n voordeel. — He perdido el trabajo, pero no hay mal que por bien no venga.
• [can.] Mijn vader zegt altijd, elk nadeel heb z''n voordeel. — Mi padre siempre dice que no hay mal que por bien no venga.
• [uitdr.] Geen ongeluk zo groot of er is een geluk bij. — No hay desgracia tan grande que no traiga algo bueno.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No hay mal que por bien no venga.', 'SENTENCE', 'Ejemplo de "elk nadeel heb z''n voordeel" (uitdr.)', 'ELK NADEEL HEB Z''N VOORDEEL = no hay mal que por bien no venga, de algo malo también sale algo bueno.

🧩 Expresión fija — elk nadeel heb z''n voordeel:

• literal — cada desventaja tiene su ventaja.
• significa — de algo malo también sale algo bueno.
• piezas fijas — frase de Johan Cruijff con heb sin -t a propósito, mal dicha y famosa; z''n es zijn.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Elk nadeel heb z''n voordeel. | No hay mal que por bien no venga. |
| 2 | principal | De trein rijdt niet, maar elk nadeel heb z''n voordeel. | El tren no circula, pero no hay mal que por bien no venga. |
| 3 | perfecto | Ik ben mijn baan kwijtgeraakt, maar elk nadeel heb z''n voordeel. | He perdido el trabajo, pero no hay mal que por bien no venga. |

🎯 En qué contexto se usa:

• consolar a alguien tras un contratiempo
• tono de humor, todo neerlandés reconoce la frase de Cruijff
• ⚠️ el heb sin t solo vale aquí, en cualquier otra frase es heeft

🔑 El truco que casi nunca falla: dila con el error de Cruijff, heb, o pierde la gracia.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No hay mal que por bien no venga.' AND notes = 'Ejemplo de "elk nadeel heb z''n voordeel" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'No hay mal que por bien no venga.' AND notes = 'Ejemplo de "elk nadeel heb z''n voordeel" (uitdr.)' LIMIT 1), 'nl_NL', 'Elk nadeel heb z''n voordeel.', 'elk nadel heb s''n fordel', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'no hay mal que por bien no venga' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No hay mal que por bien no venga.' AND notes = 'Ejemplo de "elk nadeel heb z''n voordeel" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no hay mal que por bien no venga' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no hay mal que por bien no venga' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No hay mal que por bien no venga.' AND notes = 'Ejemplo de "elk nadeel heb z''n voordeel" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No hay mal que por bien no venga.' AND notes = 'Ejemplo de "elk nadeel heb z''n voordeel" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 019. en boca cerrada no entran moscas → spreken is zilver, zwijgen is goud
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'en boca cerrada no entran moscas', 'PHRASE', 'frases hechas: spreken is zilver, zwijgen is goud', 'SPREKEN IS ZILVER, ZWIJGEN IS GOUD = en boca cerrada no entran moscas, a veces es mejor callarse.

🧩 Expresión fija — spreken is zilver, zwijgen is goud:

• literal — hablar es plata, callar es oro.
• significa — a veces es mejor callarse.
• piezas fijas — refrán cerrado de dos mitades con is; no se toca.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Spreken is zilver, zwijgen is goud. | En boca cerrada no entran moscas. |
| 2 | principal | Ik zeg niks, spreken is zilver, zwijgen is goud. | No digo nada, en boca cerrada no entran moscas. |
| 3 | imperfecto | Ik hield mijn mond, want spreken is zilver, zwijgen is goud. | Me callé, porque en boca cerrada no entran moscas. |

🎯 En qué contexto se usa:

• aconsejar prudencia antes de opinar
• reuniones tensas, discusiones familiares
• para justificar tu silencio, Ik zeg niks, spreken is zilver, zwijgen is goud

🔑 El truco que casi nunca falla: en neerlandés no hay moscas, hay metales, y callar vale oro.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'en boca cerrada no entran moscas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'en boca cerrada no entran moscas' LIMIT 1), 'nl_NL', 'spreken is zilver, zwijgen is goud', 'spréken is sílver, suéijen is jaut', '• [uitdr.] Spreken is zilver, zwijgen is goud. — En boca cerrada no entran moscas.
• [can.] Ik zeg niks, spreken is zilver, zwijgen is goud. — No digo nada, en boca cerrada no entran moscas.
• [imperf.] Ik hield mijn mond, want spreken is zilver, zwijgen is goud. — Me callé, porque en boca cerrada no entran moscas.
• [geb.] Houd je mond maar. — Mejor cállate.
• [bijzin] Soms is het beter als je zwijgt. — A veces es mejor que te calles.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'En boca cerrada no entran moscas.', 'SENTENCE', 'Ejemplo de "spreken is zilver, zwijgen is goud" (uitdr.)', 'SPREKEN IS ZILVER, ZWIJGEN IS GOUD = en boca cerrada no entran moscas, a veces es mejor callarse.

🧩 Expresión fija — spreken is zilver, zwijgen is goud:

• literal — hablar es plata, callar es oro.
• significa — a veces es mejor callarse.
• piezas fijas — refrán cerrado de dos mitades con is; no se toca.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Spreken is zilver, zwijgen is goud. | En boca cerrada no entran moscas. |
| 2 | principal | Ik zeg niks, spreken is zilver, zwijgen is goud. | No digo nada, en boca cerrada no entran moscas. |
| 3 | imperfecto | Ik hield mijn mond, want spreken is zilver, zwijgen is goud. | Me callé, porque en boca cerrada no entran moscas. |

🎯 En qué contexto se usa:

• aconsejar prudencia antes de opinar
• reuniones tensas, discusiones familiares
• para justificar tu silencio, Ik zeg niks, spreken is zilver, zwijgen is goud

🔑 El truco que casi nunca falla: en neerlandés no hay moscas, hay metales, y callar vale oro.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'En boca cerrada no entran moscas.' AND notes = 'Ejemplo de "spreken is zilver, zwijgen is goud" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'En boca cerrada no entran moscas.' AND notes = 'Ejemplo de "spreken is zilver, zwijgen is goud" (uitdr.)' LIMIT 1), 'nl_NL', 'Spreken is zilver, zwijgen is goud.', 'spreken is silfer, sueijen is jaut', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'en boca cerrada no entran moscas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'En boca cerrada no entran moscas.' AND notes = 'Ejemplo de "spreken is zilver, zwijgen is goud" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'en boca cerrada no entran moscas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'en boca cerrada no entran moscas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En boca cerrada no entran moscas.' AND notes = 'Ejemplo de "spreken is zilver, zwijgen is goud" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En boca cerrada no entran moscas.' AND notes = 'Ejemplo de "spreken is zilver, zwijgen is goud" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 020. a caballo regalado no se le mira el diente → een gegeven paard niet in de bek kijken
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'a caballo regalado no se le mira el diente', 'PHRASE', 'frases hechas: een gegeven paard niet in de bek kijken', 'EEN GEGEVEN PAARD NIET IN DE BEK KIJKEN = a caballo regalado no se le mira el diente, no se critica un regalo.

🧩 Expresión fija — een gegeven paard niet in de bek kijken:

• literal — a un caballo regalado no se le mira la boca.
• significa — no se critica un regalo.
• piezas fijas — het paard, gegeven es participio usado como adjetivo; de bek es la boca de animal, nunca de mond; kijken es fuerte, keek, gekeken.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Je moet een gegeven paard niet in de bek kijken. | A caballo regalado no se le mira el diente. |
| 2 | principal | Ik kijk een gegeven paard niet in de bek. | Yo a caballo regalado no le miro el diente. |
| 3 | perfecto | Hij heeft een gegeven paard in de bek gekeken. | Le ha mirado el diente al caballo regalado. |

🎯 En qué contexto se usa:

• agradecer un regalo imperfecto
• reprochar a quien critica lo que le han dado gratis
• suele ir con je moet o je mag niet

🔑 El truco que casi nunca falla: igual que el español, pero la boca del caballo es bek, nunca mond.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'a caballo regalado no se le mira el diente');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'a caballo regalado no se le mira el diente' LIMIT 1), 'nl_NL', 'een gegeven paard niet in de bek kijken', 'en jejéfen paart nit in de bek kéiken', '• [geb.] Je moet een gegeven paard niet in de bek kijken. — A caballo regalado no se le mira el diente.
• [can.] Ik kijk een gegeven paard niet in de bek. — Yo a caballo regalado no le miro el diente.
• [perf.] Hij heeft een gegeven paard in de bek gekeken. — Le ha mirado el diente al caballo regalado.
• [bijzin] Mijn moeder zegt dat je een gegeven paard niet in de bek kijkt. — Mi madre dice que a caballo regalado no se le mira el diente.
• [vraag] Kijk je een gegeven paard in de bek? — ¿Le miras el diente al caballo regalado?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'A caballo regalado no se le mira el diente.', 'SENTENCE', 'Ejemplo de "een gegeven paard niet in de bek kijken" (geb.)', 'EEN GEGEVEN PAARD NIET IN DE BEK KIJKEN = a caballo regalado no se le mira el diente, no se critica un regalo.

🧩 Expresión fija — een gegeven paard niet in de bek kijken:

• literal — a un caballo regalado no se le mira la boca.
• significa — no se critica un regalo.
• piezas fijas — het paard, gegeven es participio usado como adjetivo; de bek es la boca de animal, nunca de mond; kijken es fuerte, keek, gekeken.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Je moet een gegeven paard niet in de bek kijken. | A caballo regalado no se le mira el diente. |
| 2 | principal | Ik kijk een gegeven paard niet in de bek. | Yo a caballo regalado no le miro el diente. |
| 3 | perfecto | Hij heeft een gegeven paard in de bek gekeken. | Le ha mirado el diente al caballo regalado. |

🎯 En qué contexto se usa:

• agradecer un regalo imperfecto
• reprochar a quien critica lo que le han dado gratis
• suele ir con je moet o je mag niet

🔑 El truco que casi nunca falla: igual que el español, pero la boca del caballo es bek, nunca mond.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'A caballo regalado no se le mira el diente.' AND notes = 'Ejemplo de "een gegeven paard niet in de bek kijken" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'A caballo regalado no se le mira el diente.' AND notes = 'Ejemplo de "een gegeven paard niet in de bek kijken" (geb.)' LIMIT 1), 'nl_NL', 'Je moet een gegeven paard niet in de bek kijken.', 'ie mut en jejefen paart nit in de bek keiken', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'a caballo regalado no se le mira el diente' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'A caballo regalado no se le mira el diente.' AND notes = 'Ejemplo de "een gegeven paard niet in de bek kijken" (geb.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a caballo regalado no se le mira el diente' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a caballo regalado no se le mira el diente' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A caballo regalado no se le mira el diente.' AND notes = 'Ejemplo de "een gegeven paard niet in de bek kijken" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A caballo regalado no se le mira el diente.' AND notes = 'Ejemplo de "een gegeven paard niet in de bek kijken" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 021. cruzar los dedos por alguien → duimen voor iemand
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cruzar los dedos por alguien', 'PHRASE', 'frases hechas: duimen voor iemand', 'DUIMEN VOOR IEMAND = cruzar los dedos por alguien, desear suerte a alguien.

🧩 Expresión fija — duimen voor iemand:

• literal — hacer pulgares por alguien.
• significa — desear suerte a alguien.
• piezas fijas — duimen voor + persona o cosa; duimen es débil, geduimd con hebben; en los Países Bajos no se cruzan los dedos, se aprietan los pulgares.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik duim voor je. | Cruzo los dedos por ti. |
| 2 | perfecto | We hebben de hele dag voor je geduimd. | Hemos cruzado los dedos por ti todo el día. |
| 3 | imperativo | Duim voor me! | ¡Cruza los dedos por mí! |

🎯 En qué contexto se usa:

• antes de un examen, una entrevista, una operación
• la fórmula de siempre, Ik duim voor je
• para pedirlo, Duim je voor me?

🔑 El truco que casi nunca falla: en Holanda la suerte va en el pulgar, de duim, no en los dedos cruzados.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'cruzar los dedos por alguien');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'cruzar los dedos por alguien' LIMIT 1), 'nl_NL', 'duimen voor iemand', 'dóimen foor íemant', '• [can.] Ik duim voor je. — Cruzo los dedos por ti.
• [perf.] We hebben de hele dag voor je geduimd. — Hemos cruzado los dedos por ti todo el día.
• [geb.] Duim voor me! — ¡Cruza los dedos por mí!
• [bijzin] Ik hoop dat je voor me duimt. — Espero que cruces los dedos por mí.
• [vraag] Duim je voor me? — ¿Cruzas los dedos por mí?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Cruzo los dedos por ti.', 'SENTENCE', 'Ejemplo de "duimen voor iemand" (can.)', 'DUIMEN VOOR IEMAND = cruzar los dedos por alguien, desear suerte a alguien.

🧩 Expresión fija — duimen voor iemand:

• literal — hacer pulgares por alguien.
• significa — desear suerte a alguien.
• piezas fijas — duimen voor + persona o cosa; duimen es débil, geduimd con hebben; en los Países Bajos no se cruzan los dedos, se aprietan los pulgares.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik duim voor je. | Cruzo los dedos por ti. |
| 2 | perfecto | We hebben de hele dag voor je geduimd. | Hemos cruzado los dedos por ti todo el día. |
| 3 | imperativo | Duim voor me! | ¡Cruza los dedos por mí! |

🎯 En qué contexto se usa:

• antes de un examen, una entrevista, una operación
• la fórmula de siempre, Ik duim voor je
• para pedirlo, Duim je voor me?

🔑 El truco que casi nunca falla: en Holanda la suerte va en el pulgar, de duim, no en los dedos cruzados.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cruzo los dedos por ti.' AND notes = 'Ejemplo de "duimen voor iemand" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Cruzo los dedos por ti.' AND notes = 'Ejemplo de "duimen voor iemand" (can.)' LIMIT 1), 'nl_NL', 'Ik duim voor je.', 'ik döim for ie', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'cruzar los dedos por alguien' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Cruzo los dedos por ti.' AND notes = 'Ejemplo de "duimen voor iemand" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cruzar los dedos por alguien' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cruzar los dedos por alguien' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cruzo los dedos por ti.' AND notes = 'Ejemplo de "duimen voor iemand" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cruzo los dedos por ti.' AND notes = 'Ejemplo de "duimen voor iemand" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 022. ojos que no ven, corazón que no siente → wat niet weet, wat niet deert
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ojos que no ven, corazón que no siente', 'PHRASE', 'frases hechas: wat niet weet, wat niet deert', 'WAT NIET WEET, WAT NIET DEERT = ojos que no ven, corazón que no siente, lo que uno ignora no le duele.

🧩 Expresión fija — wat niet weet, wat niet deert:

• literal — lo que no se sabe, no hace daño.
• significa — lo que uno ignora no le duele.
• piezas fijas — refrán cerrado; deren es antiguo, hacer daño, y solo vive aquí.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Wat niet weet, wat niet deert. | Ojos que no ven, corazón que no siente. |
| 2 | principal | Ik vertel het hem niet, wat niet weet, wat niet deert. | No se lo cuento, ojos que no ven, corazón que no siente. |
| 3 | imperfecto | Ze zei niks tegen haar man, wat niet weet, wat niet deert. | No le dijo nada a su marido, ojos que no ven, corazón que no siente. |

🎯 En qué contexto se usa:

• decidir no contar algo para no hacer daño
• justificar con humor un secreto pequeño
• registro neutro, de uso diario

🔑 El truco que casi nunca falla: las dos mitades empiezan por wat niet, como las dos del español por que no.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ojos que no ven, corazón que no siente');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ojos que no ven, corazón que no siente' LIMIT 1), 'nl_NL', 'wat niet weet, wat niet deert', 'vat nit veet, vat nit deert', '• [uitdr.] Wat niet weet, wat niet deert. — Ojos que no ven, corazón que no siente.
• [can.] Ik vertel het hem niet, wat niet weet, wat niet deert. — No se lo cuento, ojos que no ven, corazón que no siente.
• [imperf.] Ze zei niks tegen haar man, wat niet weet, wat niet deert. — No le dijo nada a su marido, ojos que no ven, corazón que no siente.
• [vraag] Wat niet weet, wat niet deert, toch? — Ojos que no ven, corazón que no siente, ¿no?
• [perf.] Hij heeft het nooit geweten, en wat niet weet, wat niet deert. — Nunca lo ha sabido, y ojos que no ven, corazón que no siente.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ojos que no ven, corazón que no siente.', 'SENTENCE', 'Ejemplo de "wat niet weet, wat niet deert" (uitdr.)', 'WAT NIET WEET, WAT NIET DEERT = ojos que no ven, corazón que no siente, lo que uno ignora no le duele.

🧩 Expresión fija — wat niet weet, wat niet deert:

• literal — lo que no se sabe, no hace daño.
• significa — lo que uno ignora no le duele.
• piezas fijas — refrán cerrado; deren es antiguo, hacer daño, y solo vive aquí.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Wat niet weet, wat niet deert. | Ojos que no ven, corazón que no siente. |
| 2 | principal | Ik vertel het hem niet, wat niet weet, wat niet deert. | No se lo cuento, ojos que no ven, corazón que no siente. |
| 3 | imperfecto | Ze zei niks tegen haar man, wat niet weet, wat niet deert. | No le dijo nada a su marido, ojos que no ven, corazón que no siente. |

🎯 En qué contexto se usa:

• decidir no contar algo para no hacer daño
• justificar con humor un secreto pequeño
• registro neutro, de uso diario

🔑 El truco que casi nunca falla: las dos mitades empiezan por wat niet, como las dos del español por que no.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ojos que no ven, corazón que no siente.' AND notes = 'Ejemplo de "wat niet weet, wat niet deert" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Ojos que no ven, corazón que no siente.' AND notes = 'Ejemplo de "wat niet weet, wat niet deert" (uitdr.)' LIMIT 1), 'nl_NL', 'Wat niet weet, wat niet deert.', 'vat nit vet, vat nit dert', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ojos que no ven, corazón que no siente' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Ojos que no ven, corazón que no siente.' AND notes = 'Ejemplo de "wat niet weet, wat niet deert" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ojos que no ven, corazón que no siente' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ojos que no ven, corazón que no siente' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ojos que no ven, corazón que no siente.' AND notes = 'Ejemplo de "wat niet weet, wat niet deert" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ojos que no ven, corazón que no siente.' AND notes = 'Ejemplo de "wat niet weet, wat niet deert" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 023. más vale pájaro en mano que ciento volando → beter één vogel in de hand dan tien in de lucht
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'más vale pájaro en mano que ciento volando', 'PHRASE', 'frases hechas: beter één vogel in de hand dan tien in de lucht', 'BETER ÉÉN VOGEL IN DE HAND DAN TIEN IN DE LUCHT = más vale pájaro en mano que ciento volando, mejor lo seguro que lo prometido.

🧩 Expresión fija — beter één vogel in de hand dan tien in de lucht:

• literal — mejor un pájaro en la mano que diez en el aire.
• significa — mejor lo seguro que lo prometido.
• piezas fijas — refrán cerrado; één con acentos; de hand, de lucht.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Beter één vogel in de hand dan tien in de lucht. | Más vale pájaro en mano que ciento volando. |
| 2 | principal | Ik neem deze baan, beter één vogel in de hand dan tien in de lucht. | Acepto este trabajo, más vale pájaro en mano que ciento volando. |
| 3 | pregunta | Waarom wacht je nog? Beter één vogel in de hand dan tien in de lucht. | ¿Por qué esperas? Más vale pájaro en mano que ciento volando. |

🎯 En qué contexto se usa:

• aceptar una oferta segura en vez de esperar otra mejor
• negociaciones, ofertas de trabajo, compras
• registro neutro

🔑 El truco que casi nunca falla: el ciento español se queda en diez en neerlandés.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'más vale pájaro en mano que ciento volando');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'más vale pájaro en mano que ciento volando' LIMIT 1), 'nl_NL', 'beter één vogel in de hand dan tien in de lucht', 'béter een fójel in de hant dan tin in de lujt', '• [uitdr.] Beter één vogel in de hand dan tien in de lucht. — Más vale pájaro en mano que ciento volando.
• [can.] Ik neem deze baan, beter één vogel in de hand dan tien in de lucht. — Acepto este trabajo, más vale pájaro en mano que ciento volando.
• [vraag] Waarom wacht je nog? Beter één vogel in de hand dan tien in de lucht. — ¿Por qué esperas? Más vale pájaro en mano que ciento volando.
• [perf.] Hij heeft het eerste bod geaccepteerd. — Ha aceptado la primera oferta.
• [bijzin] Ik denk dat het beter is om op zeker te spelen. — Creo que es mejor ir a lo seguro.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Más vale pájaro en mano que ciento volando.', 'SENTENCE', 'Ejemplo de "beter één vogel in de hand dan tien in de lucht" (uitdr.)', 'BETER ÉÉN VOGEL IN DE HAND DAN TIEN IN DE LUCHT = más vale pájaro en mano que ciento volando, mejor lo seguro que lo prometido.

🧩 Expresión fija — beter één vogel in de hand dan tien in de lucht:

• literal — mejor un pájaro en la mano que diez en el aire.
• significa — mejor lo seguro que lo prometido.
• piezas fijas — refrán cerrado; één con acentos; de hand, de lucht.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Beter één vogel in de hand dan tien in de lucht. | Más vale pájaro en mano que ciento volando. |
| 2 | principal | Ik neem deze baan, beter één vogel in de hand dan tien in de lucht. | Acepto este trabajo, más vale pájaro en mano que ciento volando. |
| 3 | pregunta | Waarom wacht je nog? Beter één vogel in de hand dan tien in de lucht. | ¿Por qué esperas? Más vale pájaro en mano que ciento volando. |

🎯 En qué contexto se usa:

• aceptar una oferta segura en vez de esperar otra mejor
• negociaciones, ofertas de trabajo, compras
• registro neutro

🔑 El truco que casi nunca falla: el ciento español se queda en diez en neerlandés.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Más vale pájaro en mano que ciento volando.' AND notes = 'Ejemplo de "beter één vogel in de hand dan tien in de lucht" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Más vale pájaro en mano que ciento volando.' AND notes = 'Ejemplo de "beter één vogel in de hand dan tien in de lucht" (uitdr.)' LIMIT 1), 'nl_NL', 'Beter één vogel in de hand dan tien in de lucht.', 'beter één fojel in de hant dan tin in de lüjt', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'más vale pájaro en mano que ciento volando' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Más vale pájaro en mano que ciento volando.' AND notes = 'Ejemplo de "beter één vogel in de hand dan tien in de lucht" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'más vale pájaro en mano que ciento volando' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'más vale pájaro en mano que ciento volando' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Más vale pájaro en mano que ciento volando.' AND notes = 'Ejemplo de "beter één vogel in de hand dan tien in de lucht" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Más vale pájaro en mano que ciento volando.' AND notes = 'Ejemplo de "beter één vogel in de hand dan tien in de lucht" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 024. cada loco con su tema → ieder zijn meug
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cada loco con su tema', 'PHRASE', 'frases hechas: ieder zijn meug', 'IEDER ZIJN MEUG = cada loco con su tema, cada uno tiene sus gustos y manías.

🧩 Expresión fija — ieder zijn meug:

• literal — a cada uno su gusto, meug es una palabra antigua.
• significa — cada uno tiene sus gustos y manías.
• piezas fijas — refrán cerrado, sin verbo; meug solo existe aquí.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Ieder zijn meug. | Cada loco con su tema. |
| 2 | principal | Hij eet pindakaas met kaas, ieder zijn meug. | Come crema de cacahuete con queso, cada loco con su tema. |
| 3 | principal | Ik vind het raar, maar ieder zijn meug. | Me parece raro, pero cada loco con su tema. |

🎯 En qué contexto se usa:

• aceptar con tolerancia los gustos raros de otro
• tono irónico, dicho con encogimiento de hombros
• pariente, over smaak valt niet te twisten, sobre gustos no hay nada escrito

🔑 El truco que casi nunca falla: meug solo vive aquí, y se dice encogiendo los hombros.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'cada loco con su tema');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'cada loco con su tema' LIMIT 1), 'nl_NL', 'ieder zijn meug', 'íder sein möj', '• [uitdr.] Ieder zijn meug. — Cada loco con su tema.
• [can.] Hij eet pindakaas met kaas, ieder zijn meug. — Come crema de cacahuete con queso, cada loco con su tema.
• [can.] Ik vind het raar, maar ieder zijn meug. — Me parece raro, pero cada loco con su tema.
• [imperf.] Ze ging elke zondag vissen, ieder zijn meug. — Iba a pescar cada domingo, cada loco con su tema.
• [uitdr.] Over smaak valt niet te twisten. — Sobre gustos no hay nada escrito.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Cada loco con su tema.', 'SENTENCE', 'Ejemplo de "ieder zijn meug" (uitdr.)', 'IEDER ZIJN MEUG = cada loco con su tema, cada uno tiene sus gustos y manías.

🧩 Expresión fija — ieder zijn meug:

• literal — a cada uno su gusto, meug es una palabra antigua.
• significa — cada uno tiene sus gustos y manías.
• piezas fijas — refrán cerrado, sin verbo; meug solo existe aquí.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Ieder zijn meug. | Cada loco con su tema. |
| 2 | principal | Hij eet pindakaas met kaas, ieder zijn meug. | Come crema de cacahuete con queso, cada loco con su tema. |
| 3 | principal | Ik vind het raar, maar ieder zijn meug. | Me parece raro, pero cada loco con su tema. |

🎯 En qué contexto se usa:

• aceptar con tolerancia los gustos raros de otro
• tono irónico, dicho con encogimiento de hombros
• pariente, over smaak valt niet te twisten, sobre gustos no hay nada escrito

🔑 El truco que casi nunca falla: meug solo vive aquí, y se dice encogiendo los hombros.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cada loco con su tema.' AND notes = 'Ejemplo de "ieder zijn meug" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada loco con su tema.' AND notes = 'Ejemplo de "ieder zijn meug" (uitdr.)' LIMIT 1), 'nl_NL', 'Ieder zijn meug.', 'ider sein möj', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'cada loco con su tema' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Cada loco con su tema.' AND notes = 'Ejemplo de "ieder zijn meug" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cada loco con su tema' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cada loco con su tema' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada loco con su tema.' AND notes = 'Ejemplo de "ieder zijn meug" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cada loco con su tema.' AND notes = 'Ejemplo de "ieder zijn meug" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 025. abarcar demasiado → te veel hooi op je vork nemen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'abarcar demasiado', 'PHRASE', 'frases hechas: te veel hooi op je vork nemen', 'TE VEEL HOOI OP JE VORK NEMEN = abarcar demasiado, comprometerse con más cosas de las que uno puede hacer.

🧩 Expresión fija — te veel hooi op je vork nemen:

• literal — coger demasiado heno con la horca.
• significa — comprometerse con más cosas de las que uno puede hacer.
• piezas fijas — het hooi sin artículo; je cambia según el sujeto, mijn, zijn, haar; nemen es fuerte, nam, genomen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je neemt te veel hooi op je vork. | Abarcas demasiado. |
| 2 | perfecto | Ik heb te veel hooi op mijn vork genomen. | He abarcado demasiado. |
| 3 | imperfecto | Ze nam altijd te veel hooi op haar vork. | Siempre abarcaba demasiado. |

🎯 En qué contexto se usa:

• estrés por demasiadas tareas o proyectos
• advertir a alguien, Neem niet te veel hooi op je vork
• es el refrán español quien mucho abarca poco aprieta

🔑 El truco que casi nunca falla: la horca solo aguanta un poco de heno, y la persona un poco de trabajo.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'abarcar demasiado');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'abarcar demasiado' LIMIT 1), 'nl_NL', 'te veel hooi op je vork nemen', 'te feel hoi op ie fork némen', '• [can.] Je neemt te veel hooi op je vork. — Abarcas demasiado.
• [perf.] Ik heb te veel hooi op mijn vork genomen. — He abarcado demasiado.
• [imperf.] Ze nam altijd te veel hooi op haar vork. — Siempre abarcaba demasiado.
• [geb.] Neem niet te veel hooi op je vork. — No abarques demasiado.
• [bijzin] Ik ben bang dat hij te veel hooi op zijn vork neemt. — Me temo que abarca demasiado.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Abarcas demasiado.', 'SENTENCE', 'Ejemplo de "te veel hooi op je vork nemen" (can.)', 'TE VEEL HOOI OP JE VORK NEMEN = abarcar demasiado, comprometerse con más cosas de las que uno puede hacer.

🧩 Expresión fija — te veel hooi op je vork nemen:

• literal — coger demasiado heno con la horca.
• significa — comprometerse con más cosas de las que uno puede hacer.
• piezas fijas — het hooi sin artículo; je cambia según el sujeto, mijn, zijn, haar; nemen es fuerte, nam, genomen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je neemt te veel hooi op je vork. | Abarcas demasiado. |
| 2 | perfecto | Ik heb te veel hooi op mijn vork genomen. | He abarcado demasiado. |
| 3 | imperfecto | Ze nam altijd te veel hooi op haar vork. | Siempre abarcaba demasiado. |

🎯 En qué contexto se usa:

• estrés por demasiadas tareas o proyectos
• advertir a alguien, Neem niet te veel hooi op je vork
• es el refrán español quien mucho abarca poco aprieta

🔑 El truco que casi nunca falla: la horca solo aguanta un poco de heno, y la persona un poco de trabajo.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Abarcas demasiado.' AND notes = 'Ejemplo de "te veel hooi op je vork nemen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Abarcas demasiado.' AND notes = 'Ejemplo de "te veel hooi op je vork nemen" (can.)' LIMIT 1), 'nl_NL', 'Je neemt te veel hooi op je vork.', 'ie nemt te fel hoi op ie fork', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'abarcar demasiado' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Abarcas demasiado.' AND notes = 'Ejemplo de "te veel hooi op je vork nemen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'abarcar demasiado' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'abarcar demasiado' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Abarcas demasiado.' AND notes = 'Ejemplo de "te veel hooi op je vork nemen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Abarcas demasiado.' AND notes = 'Ejemplo de "te veel hooi op je vork nemen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 026. llamar al pan, pan y al vino, vino → het beestje bij zijn naam noemen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'llamar al pan, pan y al vino, vino', 'PHRASE', 'frases hechas: het beestje bij zijn naam noemen', 'HET BEESTJE BIJ ZIJN NAAM NOEMEN = llamar al pan, pan y al vino, vino, decir las cosas como son, sin eufemismos.

🧩 Expresión fija — het beestje bij zijn naam noemen:

• literal — llamar al bichito por su nombre.
• significa — decir las cosas como son, sin eufemismos.
• piezas fijas — het beestje, bij zijn naam; noemen es débil, genoemd con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Laten we het beestje bij zijn naam noemen. | Llamemos al pan, pan y al vino, vino. |
| 2 | principal | Ik noem het beestje gewoon bij zijn naam. | Yo llamo al pan, pan y al vino, vino. |
| 3 | perfecto | De minister heeft het beestje bij zijn naam genoemd. | El ministro ha llamado al pan, pan y al vino, vino. |

🎯 En qué contexto se usa:

• hablar claro sobre un problema en el trabajo o en casa
• antes de decir algo incómodo, Laten we het beestje bij zijn naam noemen
• registro neutro, también en política y prensa

🔑 El truco que casi nunca falla: en neerlandés no hay pan ni vino, hay un bichito con su nombre.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'llamar al pan, pan y al vino, vino');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'llamar al pan, pan y al vino, vino' LIMIT 1), 'nl_NL', 'het beestje bij zijn naam noemen', 'et béstie bei sein naam númen', '• [geb.] Laten we het beestje bij zijn naam noemen. — Llamemos al pan, pan y al vino, vino.
• [can.] Ik noem het beestje gewoon bij zijn naam. — Yo llamo al pan, pan y al vino, vino.
• [perf.] De minister heeft het beestje bij zijn naam genoemd. — El ministro ha llamado al pan, pan y al vino, vino.
• [bijzin] Ik waardeer het dat je het beestje bij zijn naam noemt. — Valoro que llames al pan, pan y al vino, vino.
• [vraag] Mag ik het beestje bij zijn naam noemen? — ¿Puedo llamar al pan, pan y al vino, vino?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Llamemos al pan, pan y al vino, vino.', 'SENTENCE', 'Ejemplo de "het beestje bij zijn naam noemen" (geb.)', 'HET BEESTJE BIJ ZIJN NAAM NOEMEN = llamar al pan, pan y al vino, vino, decir las cosas como son, sin eufemismos.

🧩 Expresión fija — het beestje bij zijn naam noemen:

• literal — llamar al bichito por su nombre.
• significa — decir las cosas como son, sin eufemismos.
• piezas fijas — het beestje, bij zijn naam; noemen es débil, genoemd con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Laten we het beestje bij zijn naam noemen. | Llamemos al pan, pan y al vino, vino. |
| 2 | principal | Ik noem het beestje gewoon bij zijn naam. | Yo llamo al pan, pan y al vino, vino. |
| 3 | perfecto | De minister heeft het beestje bij zijn naam genoemd. | El ministro ha llamado al pan, pan y al vino, vino. |

🎯 En qué contexto se usa:

• hablar claro sobre un problema en el trabajo o en casa
• antes de decir algo incómodo, Laten we het beestje bij zijn naam noemen
• registro neutro, también en política y prensa

🔑 El truco que casi nunca falla: en neerlandés no hay pan ni vino, hay un bichito con su nombre.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Llamemos al pan, pan y al vino, vino.' AND notes = 'Ejemplo de "het beestje bij zijn naam noemen" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Llamemos al pan, pan y al vino, vino.' AND notes = 'Ejemplo de "het beestje bij zijn naam noemen" (geb.)' LIMIT 1), 'nl_NL', 'Laten we het beestje bij zijn naam noemen.', 'laten ve het bestie bei sein naam numen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'llamar al pan, pan y al vino, vino' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Llamemos al pan, pan y al vino, vino.' AND notes = 'Ejemplo de "het beestje bij zijn naam noemen" (geb.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'llamar al pan, pan y al vino, vino' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'llamar al pan, pan y al vino, vino' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Llamemos al pan, pan y al vino, vino.' AND notes = 'Ejemplo de "het beestje bij zijn naam noemen" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Llamemos al pan, pan y al vino, vino.' AND notes = 'Ejemplo de "het beestje bij zijn naam noemen" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 027. estar entre la espada y la pared → tussen hamer en aambeeld zitten
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estar entre la espada y la pared', 'PHRASE', 'frases hechas: tussen hamer en aambeeld zitten', 'TUSSEN HAMER EN AAMBEELD ZITTEN = estar entre la espada y la pared, estar en un dilema sin salida buena.

🧩 Expresión fija — tussen hamer en aambeeld zitten:

• literal — estar entre martillo y yunque.
• significa — estar en un dilema sin salida buena.
• piezas fijas — sin artículos, hamer en aambeeld; zitten es fuerte, zat, gezeten con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik zit tussen hamer en aambeeld. | Estoy entre la espada y la pared. |
| 2 | perfecto | Ze heeft maanden tussen hamer en aambeeld gezeten. | Ha estado meses entre la espada y la pared. |
| 3 | subordinada | Je begrijpt dat ik tussen hamer en aambeeld zit. | Entiendes que estoy entre la espada y la pared. |

🎯 En qué contexto se usa:

• dilemas en el trabajo, entre el jefe y el cliente
• conflictos familiares en los que no puedes contentar a nadie
• parecido, met je rug tegen de muur staan, estar acorralado

🔑 El truco que casi nunca falla: sin artículos, igual que en el refrán, martillo y yunque a secas.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estar entre la espada y la pared');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'estar entre la espada y la pared' LIMIT 1), 'nl_NL', 'tussen hamer en aambeeld zitten', 'tússen hámer en ámbeelt sítten', '• [can.] Ik zit tussen hamer en aambeeld. — Estoy entre la espada y la pared.
• [perf.] Ze heeft maanden tussen hamer en aambeeld gezeten. — Ha estado meses entre la espada y la pared.
• [bijzin] Je begrijpt dat ik tussen hamer en aambeeld zit. — Entiendes que estoy entre la espada y la pared.
• [uitdr.] Hij staat met zijn rug tegen de muur. — Está acorralado.
• [vraag] Zit je tussen hamer en aambeeld? — ¿Estás entre la espada y la pared?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Estoy entre la espada y la pared.', 'SENTENCE', 'Ejemplo de "tussen hamer en aambeeld zitten" (can.)', 'TUSSEN HAMER EN AAMBEELD ZITTEN = estar entre la espada y la pared, estar en un dilema sin salida buena.

🧩 Expresión fija — tussen hamer en aambeeld zitten:

• literal — estar entre martillo y yunque.
• significa — estar en un dilema sin salida buena.
• piezas fijas — sin artículos, hamer en aambeeld; zitten es fuerte, zat, gezeten con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik zit tussen hamer en aambeeld. | Estoy entre la espada y la pared. |
| 2 | perfecto | Ze heeft maanden tussen hamer en aambeeld gezeten. | Ha estado meses entre la espada y la pared. |
| 3 | subordinada | Je begrijpt dat ik tussen hamer en aambeeld zit. | Entiendes que estoy entre la espada y la pared. |

🎯 En qué contexto se usa:

• dilemas en el trabajo, entre el jefe y el cliente
• conflictos familiares en los que no puedes contentar a nadie
• parecido, met je rug tegen de muur staan, estar acorralado

🔑 El truco que casi nunca falla: sin artículos, igual que en el refrán, martillo y yunque a secas.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Estoy entre la espada y la pared.' AND notes = 'Ejemplo de "tussen hamer en aambeeld zitten" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy entre la espada y la pared.' AND notes = 'Ejemplo de "tussen hamer en aambeeld zitten" (can.)' LIMIT 1), 'nl_NL', 'Ik zit tussen hamer en aambeeld.', 'ik sit tüsen hamer en aambelt', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'estar entre la espada y la pared' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Estoy entre la espada y la pared.' AND notes = 'Ejemplo de "tussen hamer en aambeeld zitten" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar entre la espada y la pared' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar entre la espada y la pared' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy entre la espada y la pared.' AND notes = 'Ejemplo de "tussen hamer en aambeeld zitten" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy entre la espada y la pared.' AND notes = 'Ejemplo de "tussen hamer en aambeeld zitten" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 028. hablar por los codos → praten als een waterval
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hablar por los codos', 'PHRASE', 'frases hechas: praten als een waterval', 'PRATEN ALS EEN WATERVAL = hablar por los codos, hablar muchísimo, sin parar.

🧩 Expresión fija — praten als een waterval:

• literal — hablar como una cascada.
• significa — hablar muchísimo, sin parar.
• piezas fijas — de waterval con een; praten es débil, praatte, gepraat con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Mijn buurvrouw praat als een waterval. | Mi vecina habla por los codos. |
| 2 | perfecto | Hij heeft de hele avond als een waterval gepraat. | Ha hablado por los codos toda la noche. |
| 3 | imperfecto | Als kind praatte ik als een waterval. | De niño hablaba por los codos. |

🎯 En qué contexto se usa:

• describir a alguien charlatán, a menudo con cariño
• niños, vecinos, compañeros de viaje
• más fuerte, iemand de oren van het hoofd kletsen

🔑 El truco que casi nunca falla: en neerlandés no hay codos, hay agua que no para.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hablar por los codos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'hablar por los codos' LIMIT 1), 'nl_NL', 'praten als een waterval', 'práten als en váterfal', '• [can.] Mijn buurvrouw praat als een waterval. — Mi vecina habla por los codos.
• [perf.] Hij heeft de hele avond als een waterval gepraat. — Ha hablado por los codos toda la noche.
• [imperf.] Als kind praatte ik als een waterval. — De niño hablaba por los codos.
• [bijzin] Ik weet dat je als een waterval praat als je zenuwachtig bent. — Sé que hablas por los codos cuando estás nervioso.
• [uitdr.] Ze kletst je de oren van het hoofd. — Te habla hasta dejarte sordo.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Mi vecina habla por los codos.', 'SENTENCE', 'Ejemplo de "praten als een waterval" (can.)', 'PRATEN ALS EEN WATERVAL = hablar por los codos, hablar muchísimo, sin parar.

🧩 Expresión fija — praten als een waterval:

• literal — hablar como una cascada.
• significa — hablar muchísimo, sin parar.
• piezas fijas — de waterval con een; praten es débil, praatte, gepraat con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Mijn buurvrouw praat als een waterval. | Mi vecina habla por los codos. |
| 2 | perfecto | Hij heeft de hele avond als een waterval gepraat. | Ha hablado por los codos toda la noche. |
| 3 | imperfecto | Als kind praatte ik als een waterval. | De niño hablaba por los codos. |

🎯 En qué contexto se usa:

• describir a alguien charlatán, a menudo con cariño
• niños, vecinos, compañeros de viaje
• más fuerte, iemand de oren van het hoofd kletsen

🔑 El truco que casi nunca falla: en neerlandés no hay codos, hay agua que no para.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi vecina habla por los codos.' AND notes = 'Ejemplo de "praten als een waterval" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi vecina habla por los codos.' AND notes = 'Ejemplo de "praten als een waterval" (can.)' LIMIT 1), 'nl_NL', 'Mijn buurvrouw praat als een waterval.', 'mein bürfrauu praat als en vaterfal', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'hablar por los codos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi vecina habla por los codos.' AND notes = 'Ejemplo de "praten als een waterval" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hablar por los codos' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hablar por los codos' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi vecina habla por los codos.' AND notes = 'Ejemplo de "praten als een waterval" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi vecina habla por los codos.' AND notes = 'Ejemplo de "praten als een waterval" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 029. dormir como un tronco → slapen als een roos
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'dormir como un tronco', 'PHRASE', 'frases hechas: slapen als een roos', 'SLAPEN ALS EEN ROOS = dormir como un tronco, dormir profundamente y bien.

🧩 Expresión fija — slapen als een roos:

• literal — dormir como una rosa.
• significa — dormir profundamente y bien.
• piezas fijas — de roos con een; slapen es fuerte, sliep, geslapen con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperfecto | Ik sliep als een roos. | Dormí como un tronco. |
| 2 | perfecto | De baby heeft als een roos geslapen. | El bebé ha dormido como un tronco. |
| 3 | inversión | Na het sporten slaap ik als een roos. | Después de hacer deporte duermo como un tronco. |

🎯 En qué contexto se usa:

• contar que has descansado, después de un día cansado
• bebés y niños que duermen tranquilos
• más profundo y pesado, slapen als een os, como un buey

🔑 El truco que casi nunca falla: el tronco español es una rosa en neerlandés, dormir tranquilo y bonito.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'dormir como un tronco');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'dormir como un tronco' LIMIT 1), 'nl_NL', 'slapen als een roos', 'slápen als en roos', '• [imperf.] Ik sliep als een roos. — Dormí como un tronco.
• [perf.] De baby heeft als een roos geslapen. — El bebé ha dormido como un tronco.
• [inv.] Na het sporten slaap ik als een roos. — Después de hacer deporte duermo como un tronco.
• [vraag] Heb je goed geslapen? Als een roos! — ¿Has dormido bien? ¡Como un tronco!
• [uitdr.] Hij slaapt als een os. — Duerme como un lirón.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Dormí como un tronco.', 'SENTENCE', 'Ejemplo de "slapen als een roos" (imperf.)', 'SLAPEN ALS EEN ROOS = dormir como un tronco, dormir profundamente y bien.

🧩 Expresión fija — slapen als een roos:

• literal — dormir como una rosa.
• significa — dormir profundamente y bien.
• piezas fijas — de roos con een; slapen es fuerte, sliep, geslapen con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperfecto | Ik sliep als een roos. | Dormí como un tronco. |
| 2 | perfecto | De baby heeft als een roos geslapen. | El bebé ha dormido como un tronco. |
| 3 | inversión | Na het sporten slaap ik als een roos. | Después de hacer deporte duermo como un tronco. |

🎯 En qué contexto se usa:

• contar que has descansado, después de un día cansado
• bebés y niños que duermen tranquilos
• más profundo y pesado, slapen als een os, como un buey

🔑 El truco que casi nunca falla: el tronco español es una rosa en neerlandés, dormir tranquilo y bonito.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Dormí como un tronco.' AND notes = 'Ejemplo de "slapen als een roos" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Dormí como un tronco.' AND notes = 'Ejemplo de "slapen als een roos" (imperf.)' LIMIT 1), 'nl_NL', 'Ik sliep als een roos.', 'ik slip als en ros', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'dormir como un tronco' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Dormí como un tronco.' AND notes = 'Ejemplo de "slapen als een roos" (imperf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'dormir como un tronco' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'dormir como un tronco' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dormí como un tronco.' AND notes = 'Ejemplo de "slapen als een roos" (imperf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Dormí como un tronco.' AND notes = 'Ejemplo de "slapen als een roos" (imperf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 030. buscarle tres pies al gato → spijkers op laag water zoeken
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'buscarle tres pies al gato', 'PHRASE', 'frases hechas: spijkers op laag water zoeken', 'SPIJKERS OP LAAG WATER ZOEKEN = buscarle tres pies al gato, buscar pegas donde no las hay.

🧩 Expresión fija — spijkers op laag water zoeken:

• literal — buscar clavos en agua baja.
• significa — buscar pegas donde no las hay.
• piezas fijas — spijkers en plural sin artículo, op laag water; zoeken es irregular, zocht, gezocht.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je zoekt spijkers op laag water. | Le buscas tres pies al gato. |
| 2 | perfecto | De controleur heeft spijkers op laag water gezocht. | El inspector le ha buscado tres pies al gato. |
| 3 | imperativo | Zoek geen spijkers op laag water. | No le busques tres pies al gato. |

🎯 En qué contexto se usa:

• criticar a alguien quisquilloso
• revisiones de trabajo, inspecciones, discusiones de pareja
• casi siempre en reproche, Zoek geen spijkers op laag water

🔑 El truco que casi nunca falla: con marea baja todo se ve, buscar clavos ahí es buscar pegas tontas.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'buscarle tres pies al gato');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'buscarle tres pies al gato' LIMIT 1), 'nl_NL', 'spijkers op laag water zoeken', 'spéikers op laaj váter súken', '• [can.] Je zoekt spijkers op laag water. — Le buscas tres pies al gato.
• [perf.] De controleur heeft spijkers op laag water gezocht. — El inspector le ha buscado tres pies al gato.
• [geb.] Zoek geen spijkers op laag water. — No le busques tres pies al gato.
• [bijzin] Ik vind dat hij spijkers op laag water zoekt. — Me parece que le busca tres pies al gato.
• [imperf.] Ze zocht altijd spijkers op laag water. — Siempre le buscaba tres pies al gato.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Le buscas tres pies al gato.', 'SENTENCE', 'Ejemplo de "spijkers op laag water zoeken" (can.)', 'SPIJKERS OP LAAG WATER ZOEKEN = buscarle tres pies al gato, buscar pegas donde no las hay.

🧩 Expresión fija — spijkers op laag water zoeken:

• literal — buscar clavos en agua baja.
• significa — buscar pegas donde no las hay.
• piezas fijas — spijkers en plural sin artículo, op laag water; zoeken es irregular, zocht, gezocht.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je zoekt spijkers op laag water. | Le buscas tres pies al gato. |
| 2 | perfecto | De controleur heeft spijkers op laag water gezocht. | El inspector le ha buscado tres pies al gato. |
| 3 | imperativo | Zoek geen spijkers op laag water. | No le busques tres pies al gato. |

🎯 En qué contexto se usa:

• criticar a alguien quisquilloso
• revisiones de trabajo, inspecciones, discusiones de pareja
• casi siempre en reproche, Zoek geen spijkers op laag water

🔑 El truco que casi nunca falla: con marea baja todo se ve, buscar clavos ahí es buscar pegas tontas.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Le buscas tres pies al gato.' AND notes = 'Ejemplo de "spijkers op laag water zoeken" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Le buscas tres pies al gato.' AND notes = 'Ejemplo de "spijkers op laag water zoeken" (can.)' LIMIT 1), 'nl_NL', 'Je zoekt spijkers op laag water.', 'ie sukt speikers op laaj vater', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'buscarle tres pies al gato' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Le buscas tres pies al gato.' AND notes = 'Ejemplo de "spijkers op laag water zoeken" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'buscarle tres pies al gato' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'buscarle tres pies al gato' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Le buscas tres pies al gato.' AND notes = 'Ejemplo de "spijkers op laag water zoeken" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Le buscas tres pies al gato.' AND notes = 'Ejemplo de "spijkers op laag water zoeken" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 031. ser uña y carne → twee handen op één buik zijn
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ser uña y carne', 'PHRASE', 'frases hechas: twee handen op één buik zijn', 'TWEE HANDEN OP ÉÉN BUIK ZIJN = ser uña y carne, ser inseparables, estar siempre de acuerdo.

🧩 Expresión fija — twee handen op één buik zijn:

• literal — ser dos manos sobre una barriga.
• significa — ser inseparables, estar siempre de acuerdo.
• piezas fijas — één con acentos; de buik; zijn se conjuga en plural, zijn, waren.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Die twee zijn twee handen op één buik. | Esos dos son uña y carne. |
| 2 | perfecto | Ze zijn altijd twee handen op één buik geweest. | Siempre han sido uña y carne. |
| 3 | imperfecto | Als kinderen waren we twee handen op één buik. | De niños éramos uña y carne. |

🎯 En qué contexto se usa:

• amigos o hermanos inseparables
• a veces con matiz de complicidad, los dos van a una
• más neutro, de dikste vrienden zijn

🔑 El truco que casi nunca falla: dos manos en la misma barriga, nadie las separa.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ser uña y carne');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ser uña y carne' LIMIT 1), 'nl_NL', 'twee handen op één buik zijn', 'tuee hánden op een böik sein', '• [can.] Die twee zijn twee handen op één buik. — Esos dos son uña y carne.
• [perf.] Ze zijn altijd twee handen op één buik geweest. — Siempre han sido uña y carne.
• [imperf.] Als kinderen waren we twee handen op één buik. — De niños éramos uña y carne.
• [bijzin] Iedereen weet dat ze twee handen op één buik zijn. — Todo el mundo sabe que son uña y carne.
• [uitdr.] Ze zijn de dikste vrienden. — Son amigos íntimos.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Esos dos son uña y carne.', 'SENTENCE', 'Ejemplo de "twee handen op één buik zijn" (can.)', 'TWEE HANDEN OP ÉÉN BUIK ZIJN = ser uña y carne, ser inseparables, estar siempre de acuerdo.

🧩 Expresión fija — twee handen op één buik zijn:

• literal — ser dos manos sobre una barriga.
• significa — ser inseparables, estar siempre de acuerdo.
• piezas fijas — één con acentos; de buik; zijn se conjuga en plural, zijn, waren.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Die twee zijn twee handen op één buik. | Esos dos son uña y carne. |
| 2 | perfecto | Ze zijn altijd twee handen op één buik geweest. | Siempre han sido uña y carne. |
| 3 | imperfecto | Als kinderen waren we twee handen op één buik. | De niños éramos uña y carne. |

🎯 En qué contexto se usa:

• amigos o hermanos inseparables
• a veces con matiz de complicidad, los dos van a una
• más neutro, de dikste vrienden zijn

🔑 El truco que casi nunca falla: dos manos en la misma barriga, nadie las separa.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Esos dos son uña y carne.' AND notes = 'Ejemplo de "twee handen op één buik zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Esos dos son uña y carne.' AND notes = 'Ejemplo de "twee handen op één buik zijn" (can.)' LIMIT 1), 'nl_NL', 'Die twee zijn twee handen op één buik.', 'di tue sein tue handen op één böik', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ser uña y carne' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Esos dos son uña y carne.' AND notes = 'Ejemplo de "twee handen op één buik zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ser uña y carne' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ser uña y carne' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esos dos son uña y carne.' AND notes = 'Ejemplo de "twee handen op één buik zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esos dos son uña y carne.' AND notes = 'Ejemplo de "twee handen op één buik zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 032. estar en el quinto pino → waar de vos en de haas elkaar goedenacht zeggen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estar en el quinto pino', 'PHRASE', 'frases hechas: waar de vos en de haas elkaar goedenacht zeggen', 'WAAR DE VOS EN DE HAAS ELKAAR GOEDENACHT ZEGGEN = estar en el quinto pino, en un sitio lejísimos y perdido.

🧩 Expresión fija — waar de vos en de haas elkaar goedenacht zeggen:

• literal — donde el zorro y la liebre se dan las buenas noches.
• significa — en un sitio lejísimos y perdido.
• piezas fijas — funciona como lugar detrás del verbo, Ze woont waar de vos en de haas…; de vos, de haas.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ze woont waar de vos en de haas elkaar goedenacht zeggen. | Vive en el quinto pino. |
| 2 | perfecto | We zijn verdwaald waar de vos en de haas elkaar goedenacht zeggen. | Nos hemos perdido en el quinto pino. |
| 3 | pregunta | Woon je echt waar de vos en de haas elkaar goedenacht zeggen? | ¿De verdad vives en el quinto pino? |

🎯 En qué contexto se usa:

• describir un pueblo o una casa muy aislados
• con humor, entre amigos
• más neutro, aan het eind van de wereld, en el fin del mundo

🔑 El truco que casi nunca falla: si está tan lejos que solo quedan animales, es donde el zorro y la liebre.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estar en el quinto pino');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'estar en el quinto pino' LIMIT 1), 'nl_NL', 'waar de vos en de haas elkaar goedenacht zeggen', 'vaar de fos en de haas élkar judenájt séjen', '• [can.] Ze woont waar de vos en de haas elkaar goedenacht zeggen. — Vive en el quinto pino.
• [perf.] We zijn verdwaald waar de vos en de haas elkaar goedenacht zeggen. — Nos hemos perdido en el quinto pino.
• [vraag] Woon je echt waar de vos en de haas elkaar goedenacht zeggen? — ¿De verdad vives en el quinto pino?
• [uitdr.] Dat is aan het eind van de wereld. — Eso está en el fin del mundo.
• [bijzin] Ik wist niet dat het hotel zo ver weg was. — No sabía que el hotel estaba tan lejos.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Vive en el quinto pino.', 'SENTENCE', 'Ejemplo de "waar de vos en de haas elkaar goedenacht zeggen" (can.)', 'WAAR DE VOS EN DE HAAS ELKAAR GOEDENACHT ZEGGEN = estar en el quinto pino, en un sitio lejísimos y perdido.

🧩 Expresión fija — waar de vos en de haas elkaar goedenacht zeggen:

• literal — donde el zorro y la liebre se dan las buenas noches.
• significa — en un sitio lejísimos y perdido.
• piezas fijas — funciona como lugar detrás del verbo, Ze woont waar de vos en de haas…; de vos, de haas.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ze woont waar de vos en de haas elkaar goedenacht zeggen. | Vive en el quinto pino. |
| 2 | perfecto | We zijn verdwaald waar de vos en de haas elkaar goedenacht zeggen. | Nos hemos perdido en el quinto pino. |
| 3 | pregunta | Woon je echt waar de vos en de haas elkaar goedenacht zeggen? | ¿De verdad vives en el quinto pino? |

🎯 En qué contexto se usa:

• describir un pueblo o una casa muy aislados
• con humor, entre amigos
• más neutro, aan het eind van de wereld, en el fin del mundo

🔑 El truco que casi nunca falla: si está tan lejos que solo quedan animales, es donde el zorro y la liebre.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Vive en el quinto pino.' AND notes = 'Ejemplo de "waar de vos en de haas elkaar goedenacht zeggen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Vive en el quinto pino.' AND notes = 'Ejemplo de "waar de vos en de haas elkaar goedenacht zeggen" (can.)' LIMIT 1), 'nl_NL', 'Ze woont waar de vos en de haas elkaar goedenacht zeggen.', 'se vont vaar de fos en de haas elkaar judenajt sejjen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'estar en el quinto pino' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Vive en el quinto pino.' AND notes = 'Ejemplo de "waar de vos en de haas elkaar goedenacht zeggen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar en el quinto pino' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar en el quinto pino' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vive en el quinto pino.' AND notes = 'Ejemplo de "waar de vos en de haas elkaar goedenacht zeggen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vive en el quinto pino.' AND notes = 'Ejemplo de "waar de vos en de haas elkaar goedenacht zeggen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 033. salir el tiro por la culata → als een boemerang terugkomen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'salir el tiro por la culata', 'PHRASE', 'frases hechas: als een boemerang terugkomen', 'ALS EEN BOEMERANG TERUGKOMEN = salir el tiro por la culata, un plan perjudica a quien lo hizo.

🧩 Expresión fija — als een boemerang terugkomen:

• literal — volver como un bumerán.
• significa — un plan perjudica a quien lo hizo.
• piezas fijas — de boemerang con een; terugkomen es separable y va con zijn, komt terug, is teruggekomen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Zijn grap is als een boemerang teruggekomen. | Con la broma le ha salido el tiro por la culata. |
| 2 | principal | Die leugen komt als een boemerang terug. | Con esa mentira te sale el tiro por la culata. |
| 3 | subordinada | Pas op dat het niet als een boemerang terugkomt. | Cuidado, que no te salga el tiro por la culata. |

🎯 En qué contexto se usa:

• planes, mentiras o bromas que se vuelven contra su autor
• política y prensa, decisiones que salen caras
• más neutro, het pakt verkeerd uit, sale mal

🔑 El truco que casi nunca falla: lo que lanzas vuelve a ti, como un bumerán.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'salir el tiro por la culata');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'salir el tiro por la culata' LIMIT 1), 'nl_NL', 'als een boemerang terugkomen', 'als en búmerang terújkomen', '• [perf.] Zijn grap is als een boemerang teruggekomen. — Con la broma le ha salido el tiro por la culata.
• [can.] Die leugen komt als een boemerang terug. — Con esa mentira te sale el tiro por la culata.
• [bijzin] Pas op dat het niet als een boemerang terugkomt. — Cuidado, que no te salga el tiro por la culata.
• [uitdr.] Het plan pakte verkeerd uit. — El plan salió mal.
• [imperf.] Zijn plan kwam als een boemerang terug. — Su plan le salió por la culata.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Con la broma le ha salido el tiro por la culata.', 'SENTENCE', 'Ejemplo de "als een boemerang terugkomen" (perf.)', 'ALS EEN BOEMERANG TERUGKOMEN = salir el tiro por la culata, un plan perjudica a quien lo hizo.

🧩 Expresión fija — als een boemerang terugkomen:

• literal — volver como un bumerán.
• significa — un plan perjudica a quien lo hizo.
• piezas fijas — de boemerang con een; terugkomen es separable y va con zijn, komt terug, is teruggekomen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Zijn grap is als een boemerang teruggekomen. | Con la broma le ha salido el tiro por la culata. |
| 2 | principal | Die leugen komt als een boemerang terug. | Con esa mentira te sale el tiro por la culata. |
| 3 | subordinada | Pas op dat het niet als een boemerang terugkomt. | Cuidado, que no te salga el tiro por la culata. |

🎯 En qué contexto se usa:

• planes, mentiras o bromas que se vuelven contra su autor
• política y prensa, decisiones que salen caras
• más neutro, het pakt verkeerd uit, sale mal

🔑 El truco que casi nunca falla: lo que lanzas vuelve a ti, como un bumerán.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Con la broma le ha salido el tiro por la culata.' AND notes = 'Ejemplo de "als een boemerang terugkomen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Con la broma le ha salido el tiro por la culata.' AND notes = 'Ejemplo de "als een boemerang terugkomen" (perf.)' LIMIT 1), 'nl_NL', 'Zijn grap is als een boemerang teruggekomen.', 'sein jrap is als en bumerang terüjjekomen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'salir el tiro por la culata' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Con la broma le ha salido el tiro por la culata.' AND notes = 'Ejemplo de "als een boemerang terugkomen" (perf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'salir el tiro por la culata' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'salir el tiro por la culata' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Con la broma le ha salido el tiro por la culata.' AND notes = 'Ejemplo de "als een boemerang terugkomen" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Con la broma le ha salido el tiro por la culata.' AND notes = 'Ejemplo de "als een boemerang terugkomen" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 034. no dar pie con bola → er niets van bakken
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no dar pie con bola', 'PHRASE', 'frases hechas: er niets van bakken', 'ER NIETS VAN BAKKEN = no dar pie con bola, hacerlo todo mal, no acertar ni una.

🧩 Expresión fija — er niets van bakken:

• literal — no hornear nada de ello.
• significa — hacerlo todo mal, no acertar ni una.
• piezas fijas — er … van fijo; coloquial con niks; bakken es débil, bakte, gebakken con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik bak er vandaag niets van. | Hoy no doy pie con bola. |
| 2 | perfecto | Het elftal heeft er niets van gebakken. | El equipo no ha dado pie con bola. |
| 3 | inversión | Op het examen bakte ik er niks van. | En el examen no di pie con bola. |

🎯 En qué contexto se usa:

• días en los que todo sale mal
• autocrítica con humor, Ik bak er vandaag niets van
• deporte, un equipo que juega fatal

🔑 El truco que casi nunca falla: como un pastelero que no saca nada bueno del horno.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no dar pie con bola');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'no dar pie con bola' LIMIT 1), 'nl_NL', 'er niets van bakken', 'er nits fan bákken', '• [can.] Ik bak er vandaag niets van. — Hoy no doy pie con bola.
• [perf.] Het elftal heeft er niets van gebakken. — El equipo no ha dado pie con bola.
• [inv.] Op het examen bakte ik er niks van. — En el examen no di pie con bola.
• [bijzin] Ik geef toe dat ik er niets van bak. — Admito que no doy pie con bola.
• [vraag] Waarom bak je er niets van? — ¿Por qué no das pie con bola?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Hoy no doy pie con bola.', 'SENTENCE', 'Ejemplo de "er niets van bakken" (can.)', 'ER NIETS VAN BAKKEN = no dar pie con bola, hacerlo todo mal, no acertar ni una.

🧩 Expresión fija — er niets van bakken:

• literal — no hornear nada de ello.
• significa — hacerlo todo mal, no acertar ni una.
• piezas fijas — er … van fijo; coloquial con niks; bakken es débil, bakte, gebakken con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik bak er vandaag niets van. | Hoy no doy pie con bola. |
| 2 | perfecto | Het elftal heeft er niets van gebakken. | El equipo no ha dado pie con bola. |
| 3 | inversión | Op het examen bakte ik er niks van. | En el examen no di pie con bola. |

🎯 En qué contexto se usa:

• días en los que todo sale mal
• autocrítica con humor, Ik bak er vandaag niets van
• deporte, un equipo que juega fatal

🔑 El truco que casi nunca falla: como un pastelero que no saca nada bueno del horno.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Hoy no doy pie con bola.' AND notes = 'Ejemplo de "er niets van bakken" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Hoy no doy pie con bola.' AND notes = 'Ejemplo de "er niets van bakken" (can.)' LIMIT 1), 'nl_NL', 'Ik bak er vandaag niets van.', 'ik bak er fandaaj nits fan', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'no dar pie con bola' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Hoy no doy pie con bola.' AND notes = 'Ejemplo de "er niets van bakken" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no dar pie con bola' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no dar pie con bola' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hoy no doy pie con bola.' AND notes = 'Ejemplo de "er niets van bakken" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hoy no doy pie con bola.' AND notes = 'Ejemplo de "er niets van bakken" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 035. estar como pez en el agua → zich als een vis in het water voelen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estar como pez en el agua', 'PHRASE', 'frases hechas: zich als een vis in het water voelen', 'ZICH ALS EEN VIS IN HET WATER VOELEN = estar como pez en el agua, estar muy cómodo en un sitio o situación.

🧩 Expresión fija — zich als een vis in het water voelen:

• literal — sentirse como un pez en el agua.
• significa — estar muy cómodo en un sitio o situación.
• piezas fijas — zich voelen es reflexivo, me, je, zich; het water; voelen es débil, gevoeld con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik voel me hier als een vis in het water. | Aquí estoy como pez en el agua. |
| 2 | perfecto | Hij heeft zich in Spanje als een vis in het water gevoeld. | En España ha estado como pez en el agua. |
| 3 | subordinada | Je ziet dat ze zich als een vis in het water voelt. | Se ve que está como pez en el agua. |

🎯 En qué contexto se usa:

• sentirse cómodo en un sitio nuevo, un trabajo, una ciudad
• en pregunta, Voel je je al als een vis in het water?
• casi igual, in je element zijn

🔑 El truco que casi nunca falla: igual que el español, pero el verbo es reflexivo, zich voelen.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estar como pez en el agua');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'estar como pez en el agua' LIMIT 1), 'nl_NL', 'zich als een vis in het water voelen', 'sij als en fis in et váter fúlen', '• [can.] Ik voel me hier als een vis in het water. — Aquí estoy como pez en el agua.
• [perf.] Hij heeft zich in Spanje als een vis in het water gevoeld. — En España ha estado como pez en el agua.
• [bijzin] Je ziet dat ze zich als een vis in het water voelt. — Se ve que está como pez en el agua.
• [vraag] Voel je je al als een vis in het water? — ¿Ya estás como pez en el agua?
• [uitdr.] Op het podium is hij in zijn element. — En el escenario está en su salsa.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Aquí estoy como pez en el agua.', 'SENTENCE', 'Ejemplo de "zich als een vis in het water voelen" (can.)', 'ZICH ALS EEN VIS IN HET WATER VOELEN = estar como pez en el agua, estar muy cómodo en un sitio o situación.

🧩 Expresión fija — zich als een vis in het water voelen:

• literal — sentirse como un pez en el agua.
• significa — estar muy cómodo en un sitio o situación.
• piezas fijas — zich voelen es reflexivo, me, je, zich; het water; voelen es débil, gevoeld con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik voel me hier als een vis in het water. | Aquí estoy como pez en el agua. |
| 2 | perfecto | Hij heeft zich in Spanje als een vis in het water gevoeld. | En España ha estado como pez en el agua. |
| 3 | subordinada | Je ziet dat ze zich als een vis in het water voelt. | Se ve que está como pez en el agua. |

🎯 En qué contexto se usa:

• sentirse cómodo en un sitio nuevo, un trabajo, una ciudad
• en pregunta, Voel je je al als een vis in het water?
• casi igual, in je element zijn

🔑 El truco que casi nunca falla: igual que el español, pero el verbo es reflexivo, zich voelen.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Aquí estoy como pez en el agua.' AND notes = 'Ejemplo de "zich als een vis in het water voelen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí estoy como pez en el agua.' AND notes = 'Ejemplo de "zich als een vis in het water voelen" (can.)' LIMIT 1), 'nl_NL', 'Ik voel me hier als een vis in het water.', 'ik ful me hir als en fis in het vater', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'estar como pez en el agua' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Aquí estoy como pez en el agua.' AND notes = 'Ejemplo de "zich als een vis in het water voelen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar como pez en el agua' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar como pez en el agua' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí estoy como pez en el agua.' AND notes = 'Ejemplo de "zich als een vis in het water voelen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí estoy como pez en el agua.' AND notes = 'Ejemplo de "zich als een vis in het water voelen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 036. estar en su salsa → in je element zijn
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estar en su salsa', 'PHRASE', 'frases hechas: in je element zijn', 'IN JE ELEMENT ZIJN = estar en su salsa, estar haciendo justo lo que mejor sabes y disfrutarlo.

🧩 Expresión fija — in je element zijn:

• literal — estar en tu elemento.
• significa — estar haciendo justo lo que mejor sabes y disfrutarlo.
• piezas fijas — het element; je cambia según el sujeto, in mijn, in zijn, in haar element.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Mijn vader is in zijn element in de keuken. | Mi padre está en su salsa en la cocina. |
| 2 | perfecto | Ze is de hele avond in haar element geweest. | Ha estado en su salsa toda la noche. |
| 3 | subordinada | Je merkt dat hij in zijn element is. | Se nota que está en su salsa. |

🎯 En qué contexto se usa:

• alguien que disfruta lo que mejor sabe hacer, la cocina, el escenario
• elogio neutro, sirve en el trabajo
• casi igual, zich als een vis in het water voelen

🔑 El truco que casi nunca falla: la salsa española es el elemento neerlandés, y cambia el posesivo.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estar en su salsa');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'estar en su salsa' LIMIT 1), 'nl_NL', 'in je element zijn', 'in ie élement sein', '• [can.] Mijn vader is in zijn element in de keuken. — Mi padre está en su salsa en la cocina.
• [perf.] Ze is de hele avond in haar element geweest. — Ha estado en su salsa toda la noche.
• [bijzin] Je merkt dat hij in zijn element is. — Se nota que está en su salsa.
• [inv.] Op het feest was ik helemaal in mijn element. — En la fiesta estaba en mi salsa.
• [vraag] Ben je hier in je element? — ¿Aquí estás en tu salsa?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Mi padre está en su salsa en la cocina.', 'SENTENCE', 'Ejemplo de "in je element zijn" (can.)', 'IN JE ELEMENT ZIJN = estar en su salsa, estar haciendo justo lo que mejor sabes y disfrutarlo.

🧩 Expresión fija — in je element zijn:

• literal — estar en tu elemento.
• significa — estar haciendo justo lo que mejor sabes y disfrutarlo.
• piezas fijas — het element; je cambia según el sujeto, in mijn, in zijn, in haar element.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Mijn vader is in zijn element in de keuken. | Mi padre está en su salsa en la cocina. |
| 2 | perfecto | Ze is de hele avond in haar element geweest. | Ha estado en su salsa toda la noche. |
| 3 | subordinada | Je merkt dat hij in zijn element is. | Se nota que está en su salsa. |

🎯 En qué contexto se usa:

• alguien que disfruta lo que mejor sabe hacer, la cocina, el escenario
• elogio neutro, sirve en el trabajo
• casi igual, zich als een vis in het water voelen

🔑 El truco que casi nunca falla: la salsa española es el elemento neerlandés, y cambia el posesivo.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi padre está en su salsa en la cocina.' AND notes = 'Ejemplo de "in je element zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi padre está en su salsa en la cocina.' AND notes = 'Ejemplo de "in je element zijn" (can.)' LIMIT 1), 'nl_NL', 'Mijn vader is in zijn element in de keuken.', 'mein fader is in sein element in de köken', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'estar en su salsa' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi padre está en su salsa en la cocina.' AND notes = 'Ejemplo de "in je element zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar en su salsa' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar en su salsa' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi padre está en su salsa en la cocina.' AND notes = 'Ejemplo de "in je element zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi padre está en su salsa en la cocina.' AND notes = 'Ejemplo de "in je element zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 037. las desgracias nunca vienen solas → een ongeluk komt zelden alleen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las desgracias nunca vienen solas', 'PHRASE', 'frases hechas: een ongeluk komt zelden alleen', 'EEN ONGELUK KOMT ZELDEN ALLEEN = las desgracias nunca vienen solas, cuando pasa algo malo suelen venir más.

🧩 Expresión fija — een ongeluk komt zelden alleen:

• literal — una desgracia rara vez viene sola.
• significa — cuando pasa algo malo suelen venir más.
• piezas fijas — refrán cerrado en singular; het ongeluk, aquí con een.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Een ongeluk komt zelden alleen. | Las desgracias nunca vienen solas. |
| 2 | principal | Eerst de auto en nu de wasmachine, een ongeluk komt zelden alleen. | Primero el coche y ahora la lavadora, las desgracias nunca vienen solas. |
| 3 | perfecto | Ik ben gevallen en mijn telefoon is kapot, een ongeluk komt zelden alleen. | Me he caído y se me ha roto el móvil, las desgracias nunca vienen solas. |

🎯 En qué contexto se usa:

• una serie de contratiempos seguidos
• consolar o quejarse con resignación
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés va en singular, una desgracia rara vez viene sola.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'las desgracias nunca vienen solas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'las desgracias nunca vienen solas' LIMIT 1), 'nl_NL', 'een ongeluk komt zelden alleen', 'en ónjeluk komt sélden alléen', '• [uitdr.] Een ongeluk komt zelden alleen. — Las desgracias nunca vienen solas.
• [can.] Eerst de auto en nu de wasmachine, een ongeluk komt zelden alleen. — Primero el coche y ahora la lavadora, las desgracias nunca vienen solas.
• [perf.] Ik ben gevallen en mijn telefoon is kapot, een ongeluk komt zelden alleen. — Me he caído y se me ha roto el móvil, las desgracias nunca vienen solas.
• [bijzin] Mijn oma zei altijd dat een ongeluk zelden alleen komt. — Mi abuela siempre decía que las desgracias nunca vienen solas.
• [vraag] Een ongeluk komt zelden alleen, hè? — Las desgracias nunca vienen solas, ¿eh?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Las desgracias nunca vienen solas.', 'SENTENCE', 'Ejemplo de "een ongeluk komt zelden alleen" (uitdr.)', 'EEN ONGELUK KOMT ZELDEN ALLEEN = las desgracias nunca vienen solas, cuando pasa algo malo suelen venir más.

🧩 Expresión fija — een ongeluk komt zelden alleen:

• literal — una desgracia rara vez viene sola.
• significa — cuando pasa algo malo suelen venir más.
• piezas fijas — refrán cerrado en singular; het ongeluk, aquí con een.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Een ongeluk komt zelden alleen. | Las desgracias nunca vienen solas. |
| 2 | principal | Eerst de auto en nu de wasmachine, een ongeluk komt zelden alleen. | Primero el coche y ahora la lavadora, las desgracias nunca vienen solas. |
| 3 | perfecto | Ik ben gevallen en mijn telefoon is kapot, een ongeluk komt zelden alleen. | Me he caído y se me ha roto el móvil, las desgracias nunca vienen solas. |

🎯 En qué contexto se usa:

• una serie de contratiempos seguidos
• consolar o quejarse con resignación
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés va en singular, una desgracia rara vez viene sola.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Las desgracias nunca vienen solas.' AND notes = 'Ejemplo de "een ongeluk komt zelden alleen" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Las desgracias nunca vienen solas.' AND notes = 'Ejemplo de "een ongeluk komt zelden alleen" (uitdr.)' LIMIT 1), 'nl_NL', 'Een ongeluk komt zelden alleen.', 'en ongelük komt selden alen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'las desgracias nunca vienen solas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Las desgracias nunca vienen solas.' AND notes = 'Ejemplo de "een ongeluk komt zelden alleen" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las desgracias nunca vienen solas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las desgracias nunca vienen solas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Las desgracias nunca vienen solas.' AND notes = 'Ejemplo de "een ongeluk komt zelden alleen" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Las desgracias nunca vienen solas.' AND notes = 'Ejemplo de "een ongeluk komt zelden alleen" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 038. a buenas horas, mangas verdes → mosterd na de maaltijd
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'a buenas horas, mangas verdes', 'PHRASE', 'frases hechas: mosterd na de maaltijd', 'MOSTERD NA DE MAALTIJD = a buenas horas, mangas verdes, ayuda o solución que llega cuando ya no sirve.

🧩 Expresión fija — mosterd na de maaltijd:

• literal — mostaza después de la comida.
• significa — ayuda o solución que llega cuando ya no sirve.
• piezas fijas — de mosterd sin artículo, na de maaltijd; suele ir con zijn, Dat is mosterd na de maaltijd.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Dat is mosterd na de maaltijd. | A buenas horas, mangas verdes. |
| 2 | principal | Je excuses zijn mosterd na de maaltijd. | Tus disculpas llegan a buenas horas, mangas verdes. |
| 3 | perfecto | De hulp is als mosterd na de maaltijd gekomen. | La ayuda ha llegado a buenas horas, mangas verdes. |

🎯 En qué contexto se usa:

• disculpas, ayudas o respuestas que llegan tarde
• ironía, con un punto de reproche
• registro neutro, sale mucho en prensa

🔑 El truco que casi nunca falla: la mostaza después de comer ya no sirve para nada.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'a buenas horas, mangas verdes');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'a buenas horas, mangas verdes' LIMIT 1), 'nl_NL', 'mosterd na de maaltijd', 'móstert na de máalteit', '• [uitdr.] Dat is mosterd na de maaltijd. — A buenas horas, mangas verdes.
• [can.] Je excuses zijn mosterd na de maaltijd. — Tus disculpas llegan a buenas horas, mangas verdes.
• [perf.] De hulp is als mosterd na de maaltijd gekomen. — La ayuda ha llegado a buenas horas, mangas verdes.
• [bijzin] Ik vind dat zijn advies mosterd na de maaltijd is. — Me parece que su consejo llega a buenas horas, mangas verdes.
• [imperf.] Het antwoord kwam pas na een maand, echt mosterd na de maaltijd. — La respuesta llegó al mes, a buenas horas, mangas verdes.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'A buenas horas, mangas verdes.', 'SENTENCE', 'Ejemplo de "mosterd na de maaltijd" (uitdr.)', 'MOSTERD NA DE MAALTIJD = a buenas horas, mangas verdes, ayuda o solución que llega cuando ya no sirve.

🧩 Expresión fija — mosterd na de maaltijd:

• literal — mostaza después de la comida.
• significa — ayuda o solución que llega cuando ya no sirve.
• piezas fijas — de mosterd sin artículo, na de maaltijd; suele ir con zijn, Dat is mosterd na de maaltijd.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Dat is mosterd na de maaltijd. | A buenas horas, mangas verdes. |
| 2 | principal | Je excuses zijn mosterd na de maaltijd. | Tus disculpas llegan a buenas horas, mangas verdes. |
| 3 | perfecto | De hulp is als mosterd na de maaltijd gekomen. | La ayuda ha llegado a buenas horas, mangas verdes. |

🎯 En qué contexto se usa:

• disculpas, ayudas o respuestas que llegan tarde
• ironía, con un punto de reproche
• registro neutro, sale mucho en prensa

🔑 El truco que casi nunca falla: la mostaza después de comer ya no sirve para nada.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'A buenas horas, mangas verdes.' AND notes = 'Ejemplo de "mosterd na de maaltijd" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'A buenas horas, mangas verdes.' AND notes = 'Ejemplo de "mosterd na de maaltijd" (uitdr.)' LIMIT 1), 'nl_NL', 'Dat is mosterd na de maaltijd.', 'dat is mostert na de maalteit', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'a buenas horas, mangas verdes' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'A buenas horas, mangas verdes.' AND notes = 'Ejemplo de "mosterd na de maaltijd" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a buenas horas, mangas verdes' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a buenas horas, mangas verdes' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A buenas horas, mangas verdes.' AND notes = 'Ejemplo de "mosterd na de maaltijd" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A buenas horas, mangas verdes.' AND notes = 'Ejemplo de "mosterd na de maaltijd" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 039. dar gato por liebre → iemand een kat in de zak verkopen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'dar gato por liebre', 'PHRASE', 'frases hechas: iemand een kat in de zak verkopen', 'IEMAND EEN KAT IN DE ZAK VERKOPEN = dar gato por liebre, engañar vendiendo algo peor de lo que parece.

🧩 Expresión fija — iemand een kat in de zak verkopen:

• literal — venderle a alguien un gato en el saco.
• significa — engañar vendiendo algo peor de lo que parece.
• piezas fijas — de kat, in de zak; verkopen es inseparable, verkocht con hebben y sin ge-.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Ze hebben me een kat in de zak verkocht. | Me han dado gato por liebre. |
| 2 | principal | Die verkoper verkoopt je een kat in de zak. | Ese vendedor te da gato por liebre. |
| 3 | subordinada | Pas op dat ze je geen kat in de zak verkopen. | Cuidado que no te den gato por liebre. |

🎯 En qué contexto se usa:

• compras engañosas, coches de segunda mano, pisos
• para avisar, Pas op dat ze je geen kat in de zak verkopen
• registro neutro

🔑 El truco que casi nunca falla: en los dos idiomas hay un gato, en neerlandés metido en un saco.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'dar gato por liebre');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'dar gato por liebre' LIMIT 1), 'nl_NL', 'iemand een kat in de zak verkopen', 'íemant en kat in de sak ferkópen', '• [perf.] Ze hebben me een kat in de zak verkocht. — Me han dado gato por liebre.
• [can.] Die verkoper verkoopt je een kat in de zak. — Ese vendedor te da gato por liebre.
• [bijzin] Pas op dat ze je geen kat in de zak verkopen. — Cuidado que no te den gato por liebre.
• [vraag] Heeft hij je een kat in de zak verkocht? — ¿Te ha dado gato por liebre?
• [imperf.] Met die tweedehands auto kocht ik een kat in de zak. — Con ese coche de segunda mano me dieron gato por liebre.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me han dado gato por liebre.', 'SENTENCE', 'Ejemplo de "iemand een kat in de zak verkopen" (perf.)', 'IEMAND EEN KAT IN DE ZAK VERKOPEN = dar gato por liebre, engañar vendiendo algo peor de lo que parece.

🧩 Expresión fija — iemand een kat in de zak verkopen:

• literal — venderle a alguien un gato en el saco.
• significa — engañar vendiendo algo peor de lo que parece.
• piezas fijas — de kat, in de zak; verkopen es inseparable, verkocht con hebben y sin ge-.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Ze hebben me een kat in de zak verkocht. | Me han dado gato por liebre. |
| 2 | principal | Die verkoper verkoopt je een kat in de zak. | Ese vendedor te da gato por liebre. |
| 3 | subordinada | Pas op dat ze je geen kat in de zak verkopen. | Cuidado que no te den gato por liebre. |

🎯 En qué contexto se usa:

• compras engañosas, coches de segunda mano, pisos
• para avisar, Pas op dat ze je geen kat in de zak verkopen
• registro neutro

🔑 El truco que casi nunca falla: en los dos idiomas hay un gato, en neerlandés metido en un saco.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me han dado gato por liebre.' AND notes = 'Ejemplo de "iemand een kat in de zak verkopen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Me han dado gato por liebre.' AND notes = 'Ejemplo de "iemand een kat in de zak verkopen" (perf.)' LIMIT 1), 'nl_NL', 'Ze hebben me een kat in de zak verkocht.', 'se heben me en kat in de sak ferkojt', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'dar gato por liebre' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me han dado gato por liebre.' AND notes = 'Ejemplo de "iemand een kat in de zak verkopen" (perf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'dar gato por liebre' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'dar gato por liebre' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me han dado gato por liebre.' AND notes = 'Ejemplo de "iemand een kat in de zak verkopen" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me han dado gato por liebre.' AND notes = 'Ejemplo de "iemand een kat in de zak verkopen" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 040. la gota que colma el vaso → de druppel die de emmer doet overlopen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la gota que colma el vaso', 'PHRASE', 'frases hechas: de druppel die de emmer doet overlopen', 'DE DRUPPEL DIE DE EMMER DOET OVERLOPEN = la gota que colma el vaso, lo último que hace estallar a alguien.

🧩 Expresión fija — de druppel die de emmer doet overlopen:

• literal — la gota que hace desbordar el cubo.
• significa — lo último que hace estallar a alguien.
• piezas fijas — de druppel, de emmer; doen + infinitivo, doet overlopen; suele ir con zijn, Dat was de druppel….

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Dat was de druppel die de emmer deed overlopen. | Esa fue la gota que colmó el vaso. |
| 2 | principal | Dit is de druppel die de emmer doet overlopen. | Esta es la gota que colma el vaso. |
| 3 | perfecto | Zijn opmerking is de druppel geweest. | Su comentario ha sido la gota que colma el vaso. |

🎯 En qué contexto se usa:

• explicar por qué explotas o por qué dejas algo
• quejas en el trabajo o en la pareja
• parecido y más corto, nu is de maat vol, ya está bien

🔑 El truco que casi nunca falla: el vaso español es un cubo neerlandés, de emmer.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la gota que colma el vaso');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la gota que colma el vaso' LIMIT 1), 'nl_NL', 'de druppel die de emmer doet overlopen', 'de drúpel di de émer dut óferlopen', '• [uitdr.] Dat was de druppel die de emmer deed overlopen. — Esa fue la gota que colmó el vaso.
• [can.] Dit is de druppel die de emmer doet overlopen. — Esta es la gota que colma el vaso.
• [perf.] Zijn opmerking is de druppel geweest. — Su comentario ha sido la gota que colma el vaso.
• [bijzin] Ik denk dat dit de druppel is die de emmer doet overlopen. — Creo que esta es la gota que colma el vaso.
• [uitdr.] Nu is de maat vol. — Ya está bien, se acabó.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Esa fue la gota que colmó el vaso.', 'SENTENCE', 'Ejemplo de "de druppel die de emmer doet overlopen" (uitdr.)', 'DE DRUPPEL DIE DE EMMER DOET OVERLOPEN = la gota que colma el vaso, lo último que hace estallar a alguien.

🧩 Expresión fija — de druppel die de emmer doet overlopen:

• literal — la gota que hace desbordar el cubo.
• significa — lo último que hace estallar a alguien.
• piezas fijas — de druppel, de emmer; doen + infinitivo, doet overlopen; suele ir con zijn, Dat was de druppel….

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Dat was de druppel die de emmer deed overlopen. | Esa fue la gota que colmó el vaso. |
| 2 | principal | Dit is de druppel die de emmer doet overlopen. | Esta es la gota que colma el vaso. |
| 3 | perfecto | Zijn opmerking is de druppel geweest. | Su comentario ha sido la gota que colma el vaso. |

🎯 En qué contexto se usa:

• explicar por qué explotas o por qué dejas algo
• quejas en el trabajo o en la pareja
• parecido y más corto, nu is de maat vol, ya está bien

🔑 El truco que casi nunca falla: el vaso español es un cubo neerlandés, de emmer.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Esa fue la gota que colmó el vaso.' AND notes = 'Ejemplo de "de druppel die de emmer doet overlopen" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Esa fue la gota que colmó el vaso.' AND notes = 'Ejemplo de "de druppel die de emmer doet overlopen" (uitdr.)' LIMIT 1), 'nl_NL', 'Dat was de druppel die de emmer deed overlopen.', 'dat vas de drüpel di de emer det oferlopen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'la gota que colma el vaso' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Esa fue la gota que colmó el vaso.' AND notes = 'Ejemplo de "de druppel die de emmer doet overlopen" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la gota que colma el vaso' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la gota que colma el vaso' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esa fue la gota que colmó el vaso.' AND notes = 'Ejemplo de "de druppel die de emmer doet overlopen" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esa fue la gota que colmó el vaso.' AND notes = 'Ejemplo de "de druppel die de emmer doet overlopen" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 041. coger el toro por los cuernos → de koe bij de hoorns vatten
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'coger el toro por los cuernos', 'PHRASE', 'frases hechas: de koe bij de hoorns vatten', 'DE KOE BIJ DE HOORNS VATTEN = coger el toro por los cuernos, afrontar un problema de frente.

🧩 Expresión fija — de koe bij de hoorns vatten:

• literal — agarrar la vaca por los cuernos.
• significa — afrontar un problema de frente.
• piezas fijas — de koe, de hoorns; vatten es débil, gevat con hebben, y no se cambia por pakken.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Je moet de koe bij de hoorns vatten. | Tienes que coger el toro por los cuernos. |
| 2 | perfecto | Ik heb de koe bij de hoorns gevat en ontslag genomen. | He cogido el toro por los cuernos y me he despedido. |
| 3 | principal | Zij vat de koe altijd bij de hoorns. | Ella siempre coge el toro por los cuernos. |

🎯 En qué contexto se usa:

• afrontar un problema que se venía evitando
• tono decidido, para animar, Je moet de koe bij de hoorns vatten
• registro neutro

🔑 El truco que casi nunca falla: el toro español es una vaca neerlandesa, y el verbo es vatten, no pakken.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'coger el toro por los cuernos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'coger el toro por los cuernos' LIMIT 1), 'nl_NL', 'de koe bij de hoorns vatten', 'de ku bei de hórens fátten', '• [geb.] Je moet de koe bij de hoorns vatten. — Tienes que coger el toro por los cuernos.
• [perf.] Ik heb de koe bij de hoorns gevat en ontslag genomen. — He cogido el toro por los cuernos y me he despedido.
• [can.] Zij vat de koe altijd bij de hoorns. — Ella siempre coge el toro por los cuernos.
• [bijzin] Het wordt tijd dat we de koe bij de hoorns vatten. — Ya va siendo hora de coger el toro por los cuernos.
• [vraag] Durf je de koe bij de hoorns te vatten? — ¿Te atreves a coger el toro por los cuernos?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Tienes que coger el toro por los cuernos.', 'SENTENCE', 'Ejemplo de "de koe bij de hoorns vatten" (geb.)', 'DE KOE BIJ DE HOORNS VATTEN = coger el toro por los cuernos, afrontar un problema de frente.

🧩 Expresión fija — de koe bij de hoorns vatten:

• literal — agarrar la vaca por los cuernos.
• significa — afrontar un problema de frente.
• piezas fijas — de koe, de hoorns; vatten es débil, gevat con hebben, y no se cambia por pakken.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Je moet de koe bij de hoorns vatten. | Tienes que coger el toro por los cuernos. |
| 2 | perfecto | Ik heb de koe bij de hoorns gevat en ontslag genomen. | He cogido el toro por los cuernos y me he despedido. |
| 3 | principal | Zij vat de koe altijd bij de hoorns. | Ella siempre coge el toro por los cuernos. |

🎯 En qué contexto se usa:

• afrontar un problema que se venía evitando
• tono decidido, para animar, Je moet de koe bij de hoorns vatten
• registro neutro

🔑 El truco que casi nunca falla: el toro español es una vaca neerlandesa, y el verbo es vatten, no pakken.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Tienes que coger el toro por los cuernos.' AND notes = 'Ejemplo de "de koe bij de hoorns vatten" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Tienes que coger el toro por los cuernos.' AND notes = 'Ejemplo de "de koe bij de hoorns vatten" (geb.)' LIMIT 1), 'nl_NL', 'Je moet de koe bij de hoorns vatten.', 'ie mut de ku bei de horns faten', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'coger el toro por los cuernos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Tienes que coger el toro por los cuernos.' AND notes = 'Ejemplo de "de koe bij de hoorns vatten" (geb.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'coger el toro por los cuernos' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'coger el toro por los cuernos' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tienes que coger el toro por los cuernos.' AND notes = 'Ejemplo de "de koe bij de hoorns vatten" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tienes que coger el toro por los cuernos.' AND notes = 'Ejemplo de "de koe bij de hoorns vatten" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 042. ir al grano → ter zake komen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ir al grano', 'PHRASE', 'frases hechas: ter zake komen', 'TER ZAKE KOMEN = ir al grano, decir lo importante sin rodeos.

🧩 Expresión fija — ter zake komen:

• literal — venir al asunto.
• significa — decir lo importante sin rodeos.
• piezas fijas — ter zake es un genitivo antiguo y no se toca; komen va con zijn, kwam, is gekomen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Kom ter zake, alsjeblieft. | Ve al grano, por favor. |
| 2 | principal | Ik kom meteen ter zake. | Voy directamente al grano. |
| 3 | perfecto | Ze is snel ter zake gekomen. | Ha ido rápido al grano. |

🎯 En qué contexto se usa:

• reuniones y conversaciones largas
• pedirlo, Kom ter zake, alsjeblieft, un poco seco
• elogio, spijkers met koppen slaan, ir al grano y hacer cosas concretas

🔑 El truco que casi nunca falla: ter zake se dice de un tirón, como si fuera una sola palabra.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ir al grano');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ir al grano' LIMIT 1), 'nl_NL', 'ter zake komen', 'ter sáke kómen', '• [geb.] Kom ter zake, alsjeblieft. — Ve al grano, por favor.
• [can.] Ik kom meteen ter zake. — Voy directamente al grano.
• [perf.] Ze is snel ter zake gekomen. — Ha ido rápido al grano.
• [bijzin] Ik zou het fijn vinden als je ter zake kwam. — Me gustaría que fueras al grano.
• [uitdr.] Hij slaat spijkers met koppen. — Va al grano y hace cosas concretas.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ve al grano, por favor.', 'SENTENCE', 'Ejemplo de "ter zake komen" (geb.)', 'TER ZAKE KOMEN = ir al grano, decir lo importante sin rodeos.

🧩 Expresión fija — ter zake komen:

• literal — venir al asunto.
• significa — decir lo importante sin rodeos.
• piezas fijas — ter zake es un genitivo antiguo y no se toca; komen va con zijn, kwam, is gekomen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Kom ter zake, alsjeblieft. | Ve al grano, por favor. |
| 2 | principal | Ik kom meteen ter zake. | Voy directamente al grano. |
| 3 | perfecto | Ze is snel ter zake gekomen. | Ha ido rápido al grano. |

🎯 En qué contexto se usa:

• reuniones y conversaciones largas
• pedirlo, Kom ter zake, alsjeblieft, un poco seco
• elogio, spijkers met koppen slaan, ir al grano y hacer cosas concretas

🔑 El truco que casi nunca falla: ter zake se dice de un tirón, como si fuera una sola palabra.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ve al grano, por favor.' AND notes = 'Ejemplo de "ter zake komen" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Ve al grano, por favor.' AND notes = 'Ejemplo de "ter zake komen" (geb.)' LIMIT 1), 'nl_NL', 'Kom ter zake, alsjeblieft.', 'kom ter sake, alsieblift', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ir al grano' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Ve al grano, por favor.' AND notes = 'Ejemplo de "ter zake komen" (geb.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ir al grano' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ir al grano' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ve al grano, por favor.' AND notes = 'Ejemplo de "ter zake komen" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ve al grano, por favor.' AND notes = 'Ejemplo de "ter zake komen" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 043. estar sin blanca → platzak zijn
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estar sin blanca', 'PHRASE', 'frases hechas: platzak zijn', 'PLATZAK ZIJN = estar sin blanca, no tener dinero.

🧩 Expresión fija — platzak zijn:

• literal — tener el bolsillo plano.
• significa — no tener dinero.
• piezas fijas — platzak es adjetivo y va con zijn, sin artículo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben platzak. | Estoy sin blanca. |
| 2 | imperfecto | Aan het eind van de maand was ik altijd platzak. | A final de mes siempre estaba sin blanca. |
| 3 | perfecto | Hij is platzak van het festival thuisgekomen. | Ha vuelto a casa del festival sin blanca. |

🎯 En qué contexto se usa:

• fin de mes, después de las vacaciones
• excusa para no salir, Ik kan niet mee, ik ben platzak
• sinónimo coloquial, blut zijn

🔑 El truco que casi nunca falla: el bolsillo plano, platzak, no tiene nada dentro.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estar sin blanca');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'estar sin blanca' LIMIT 1), 'nl_NL', 'platzak zijn', 'plátsak sein', '• [can.] Ik ben platzak. — Estoy sin blanca.
• [imperf.] Aan het eind van de maand was ik altijd platzak. — A final de mes siempre estaba sin blanca.
• [perf.] Hij is platzak van het festival thuisgekomen. — Ha vuelto a casa del festival sin blanca.
• [bijzin] Ik kan niet mee omdat ik platzak ben. — No puedo ir porque estoy sin blanca.
• [uitdr.] Ik ben blut. — Estoy pelado.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Estoy sin blanca.', 'SENTENCE', 'Ejemplo de "platzak zijn" (can.)', 'PLATZAK ZIJN = estar sin blanca, no tener dinero.

🧩 Expresión fija — platzak zijn:

• literal — tener el bolsillo plano.
• significa — no tener dinero.
• piezas fijas — platzak es adjetivo y va con zijn, sin artículo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben platzak. | Estoy sin blanca. |
| 2 | imperfecto | Aan het eind van de maand was ik altijd platzak. | A final de mes siempre estaba sin blanca. |
| 3 | perfecto | Hij is platzak van het festival thuisgekomen. | Ha vuelto a casa del festival sin blanca. |

🎯 En qué contexto se usa:

• fin de mes, después de las vacaciones
• excusa para no salir, Ik kan niet mee, ik ben platzak
• sinónimo coloquial, blut zijn

🔑 El truco que casi nunca falla: el bolsillo plano, platzak, no tiene nada dentro.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Estoy sin blanca.' AND notes = 'Ejemplo de "platzak zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy sin blanca.' AND notes = 'Ejemplo de "platzak zijn" (can.)' LIMIT 1), 'nl_NL', 'Ik ben platzak.', 'ik ben platsak', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'estar sin blanca' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Estoy sin blanca.' AND notes = 'Ejemplo de "platzak zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar sin blanca' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar sin blanca' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy sin blanca.' AND notes = 'Ejemplo de "platzak zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy sin blanca.' AND notes = 'Ejemplo de "platzak zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 044. tirar la casa por la ventana → geld over de balk gooien
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tirar la casa por la ventana', 'PHRASE', 'frases hechas: geld over de balk gooien', 'GELD OVER DE BALK GOOIEN = tirar la casa por la ventana, gastar mucho dinero sin medida.

🧩 Expresión fija — geld over de balk gooien:

• literal — tirar dinero por encima de la viga.
• significa — gastar mucho dinero sin medida.
• piezas fijas — het geld sin artículo, o con posesivo, zijn geld; over de balk; gooien es débil, gegooid.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij gooit zijn geld over de balk. | Tira la casa por la ventana. |
| 2 | perfecto | Voor de bruiloft hebben ze het geld over de balk gegooid. | Para la boda han tirado la casa por la ventana. |
| 3 | subordinada | Ik wil niet dat je geld over de balk gooit. | No quiero que tires la casa por la ventana. |

🎯 En qué contexto se usa:

• criticar gastos excesivos
• ⚠️ si es para celebrar algo a lo grande se dice de bloemetjes buitenzetten
• registro neutro

🔑 El truco que casi nunca falla: el dinero vuela por encima de la viga del techo y no vuelve.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'tirar la casa por la ventana');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'tirar la casa por la ventana' LIMIT 1), 'nl_NL', 'geld over de balk gooien', 'jelt ófer de balk jóien', '• [can.] Hij gooit zijn geld over de balk. — Tira la casa por la ventana.
• [perf.] Voor de bruiloft hebben ze het geld over de balk gegooid. — Para la boda han tirado la casa por la ventana.
• [bijzin] Ik wil niet dat je geld over de balk gooit. — No quiero que tires la casa por la ventana.
• [uitdr.] Vanavond zetten we de bloemetjes buiten. — Esta noche lo celebramos por todo lo alto.
• [geb.] Gooi je geld niet over de balk. — No tires el dinero.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Tira la casa por la ventana.', 'SENTENCE', 'Ejemplo de "geld over de balk gooien" (can.)', 'GELD OVER DE BALK GOOIEN = tirar la casa por la ventana, gastar mucho dinero sin medida.

🧩 Expresión fija — geld over de balk gooien:

• literal — tirar dinero por encima de la viga.
• significa — gastar mucho dinero sin medida.
• piezas fijas — het geld sin artículo, o con posesivo, zijn geld; over de balk; gooien es débil, gegooid.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij gooit zijn geld over de balk. | Tira la casa por la ventana. |
| 2 | perfecto | Voor de bruiloft hebben ze het geld over de balk gegooid. | Para la boda han tirado la casa por la ventana. |
| 3 | subordinada | Ik wil niet dat je geld over de balk gooit. | No quiero que tires la casa por la ventana. |

🎯 En qué contexto se usa:

• criticar gastos excesivos
• ⚠️ si es para celebrar algo a lo grande se dice de bloemetjes buitenzetten
• registro neutro

🔑 El truco que casi nunca falla: el dinero vuela por encima de la viga del techo y no vuelve.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Tira la casa por la ventana.' AND notes = 'Ejemplo de "geld over de balk gooien" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Tira la casa por la ventana.' AND notes = 'Ejemplo de "geld over de balk gooien" (can.)' LIMIT 1), 'nl_NL', 'Hij gooit zijn geld over de balk.', 'hei joit sein jelt ofer de balk', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'tirar la casa por la ventana' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Tira la casa por la ventana.' AND notes = 'Ejemplo de "geld over de balk gooien" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tirar la casa por la ventana' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tirar la casa por la ventana' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tira la casa por la ventana.' AND notes = 'Ejemplo de "geld over de balk gooien" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tira la casa por la ventana.' AND notes = 'Ejemplo de "geld over de balk gooien" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 045. ponerse rojo como un tomate → zo rood als een tomaat worden
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ponerse rojo como un tomate', 'PHRASE', 'frases hechas: zo rood als een tomaat worden', 'ZO ROOD ALS EEN TOMAAT WORDEN = ponerse rojo como un tomate, sonrojarse mucho.

🧩 Expresión fija — zo rood als een tomaat worden:

• literal — ponerse tan rojo como un tomate.
• significa — sonrojarse mucho.
• piezas fijas — zo … als para la comparación; worden es ponerse y va con zijn, werd, is geworden.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperfecto | Ik werd zo rood als een tomaat. | Me puse rojo como un tomate. |
| 2 | principal | Hij wordt altijd zo rood als een tomaat. | Siempre se pone rojo como un tomate. |
| 3 | perfecto | Ze is zo rood als een tomaat geworden. | Se ha puesto roja como un tomate. |

🎯 En qué contexto se usa:

• vergüenza, piropos, meteduras de pata
• niños y adolescentes
• más corto, een kleur krijgen, sonrojarse

🔑 El truco que casi nunca falla: igual que el español, y worden hace de ponerse.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ponerse rojo como un tomate');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse rojo como un tomate' LIMIT 1), 'nl_NL', 'zo rood als een tomaat worden', 'so root als en tomáat vórden', '• [imperf.] Ik werd zo rood als een tomaat. — Me puse rojo como un tomate.
• [can.] Hij wordt altijd zo rood als een tomaat. — Siempre se pone rojo como un tomate.
• [perf.] Ze is zo rood als een tomaat geworden. — Se ha puesto roja como un tomate.
• [bijzin] Ik merkte dat ik zo rood als een tomaat werd. — Noté que me ponía rojo como un tomate.
• [uitdr.] Ze kreeg een kleur. — Se sonrojó.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me puse rojo como un tomate.', 'SENTENCE', 'Ejemplo de "zo rood als een tomaat worden" (imperf.)', 'ZO ROOD ALS EEN TOMAAT WORDEN = ponerse rojo como un tomate, sonrojarse mucho.

🧩 Expresión fija — zo rood als een tomaat worden:

• literal — ponerse tan rojo como un tomate.
• significa — sonrojarse mucho.
• piezas fijas — zo … als para la comparación; worden es ponerse y va con zijn, werd, is geworden.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperfecto | Ik werd zo rood als een tomaat. | Me puse rojo como un tomate. |
| 2 | principal | Hij wordt altijd zo rood als een tomaat. | Siempre se pone rojo como un tomate. |
| 3 | perfecto | Ze is zo rood als een tomaat geworden. | Se ha puesto roja como un tomate. |

🎯 En qué contexto se usa:

• vergüenza, piropos, meteduras de pata
• niños y adolescentes
• más corto, een kleur krijgen, sonrojarse

🔑 El truco que casi nunca falla: igual que el español, y worden hace de ponerse.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me puse rojo como un tomate.' AND notes = 'Ejemplo de "zo rood als een tomaat worden" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Me puse rojo como un tomate.' AND notes = 'Ejemplo de "zo rood als een tomaat worden" (imperf.)' LIMIT 1), 'nl_NL', 'Ik werd zo rood als een tomaat.', 'ik vert so rot als en tomaat', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse rojo como un tomate' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me puse rojo como un tomate.' AND notes = 'Ejemplo de "zo rood als een tomaat worden" (imperf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse rojo como un tomate' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse rojo como un tomate' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me puse rojo como un tomate.' AND notes = 'Ejemplo de "zo rood als een tomaat worden" (imperf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me puse rojo como un tomate.' AND notes = 'Ejemplo de "zo rood als een tomaat worden" (imperf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 046. estar hecho polvo → doodop zijn
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estar hecho polvo', 'PHRASE', 'frases hechas: doodop zijn', 'DOODOP ZIJN = estar hecho polvo, estar agotado.

🧩 Expresión fija — doodop zijn:

• literal — estar gastado hasta la muerte.
• significa — estar agotado.
• piezas fijas — doodop es adjetivo y va con zijn.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben doodop. | Estoy hecho polvo. |
| 2 | imperfecto | Na de verhuizing was ik doodop. | Después de la mudanza estaba hecho polvo. |
| 3 | perfecto | Hij is de hele week doodop geweest. | Ha estado hecho polvo toda la semana. |

🎯 En qué contexto se usa:

• cansancio después del trabajo, una mudanza, el deporte
• registro coloquial pero válido con todos
• sinónimos, kapot zijn, bekaf zijn

🔑 El truco que casi nunca falla: dood más op, gastado hasta morir.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estar hecho polvo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'estar hecho polvo' LIMIT 1), 'nl_NL', 'doodop zijn', 'dótop sein', '• [can.] Ik ben doodop. — Estoy hecho polvo.
• [imperf.] Na de verhuizing was ik doodop. — Después de la mudanza estaba hecho polvo.
• [perf.] Hij is de hele week doodop geweest. — Ha estado hecho polvo toda la semana.
• [bijzin] Ik ga naar bed omdat ik doodop ben. — Me voy a la cama porque estoy hecho polvo.
• [uitdr.] Ik ben kapot. — Estoy reventado.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Estoy hecho polvo.', 'SENTENCE', 'Ejemplo de "doodop zijn" (can.)', 'DOODOP ZIJN = estar hecho polvo, estar agotado.

🧩 Expresión fija — doodop zijn:

• literal — estar gastado hasta la muerte.
• significa — estar agotado.
• piezas fijas — doodop es adjetivo y va con zijn.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben doodop. | Estoy hecho polvo. |
| 2 | imperfecto | Na de verhuizing was ik doodop. | Después de la mudanza estaba hecho polvo. |
| 3 | perfecto | Hij is de hele week doodop geweest. | Ha estado hecho polvo toda la semana. |

🎯 En qué contexto se usa:

• cansancio después del trabajo, una mudanza, el deporte
• registro coloquial pero válido con todos
• sinónimos, kapot zijn, bekaf zijn

🔑 El truco que casi nunca falla: dood más op, gastado hasta morir.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Estoy hecho polvo.' AND notes = 'Ejemplo de "doodop zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy hecho polvo.' AND notes = 'Ejemplo de "doodop zijn" (can.)' LIMIT 1), 'nl_NL', 'Ik ben doodop.', 'ik ben dodop', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'estar hecho polvo' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Estoy hecho polvo.' AND notes = 'Ejemplo de "doodop zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar hecho polvo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar hecho polvo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy hecho polvo.' AND notes = 'Ejemplo de "doodop zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy hecho polvo.' AND notes = 'Ejemplo de "doodop zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 047. me importa un pimiento → het kan me geen moer schelen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me importa un pimiento', 'PHRASE', 'frases hechas: het kan me geen moer schelen', 'HET KAN ME GEEN MOER SCHELEN = me importa un pimiento, no me importa nada.

🧩 Expresión fija — het kan me geen moer schelen:

• literal — no me puede importar ni una tuerca.
• significa — no me importa nada.
• piezas fijas — het vacío de sujeto; la persona en me, je, hem; schelen en infinitivo detrás de kunnen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Het kan me geen moer schelen. | Me importa un pimiento. |
| 2 | imperfecto | Het kon hem geen moer schelen. | Le importaba un pimiento. |
| 3 | subordinada | Ik zei dat het me geen moer kon schelen. | Dije que me importaba un pimiento. |

🎯 En qué contexto se usa:

• desinterés o enfado
• ⚠️ geen moer es coloquial, en el trabajo mejor het kan me niet schelen
• más fuerte todavía, geen bal

🔑 El truco que casi nunca falla: het kan me … schelen, y lo que pongas en medio sube el tono, niet, geen moer, geen bal.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'me importa un pimiento');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'me importa un pimiento' LIMIT 1), 'nl_NL', 'het kan me geen moer schelen', 'et kan me jeen mur sjélen', '• [can.] Het kan me geen moer schelen. — Me importa un pimiento.
• [imperf.] Het kon hem geen moer schelen. — Le importaba un pimiento.
• [bijzin] Ik zei dat het me geen moer kon schelen. — Dije que me importaba un pimiento.
• [uitdr.] Het kan me niet schelen. — Me da igual.
• [vraag] Kan het je echt geen moer schelen? — ¿De verdad te importa un pimiento?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me importa un pimiento.', 'SENTENCE', 'Ejemplo de "het kan me geen moer schelen" (can.)', 'HET KAN ME GEEN MOER SCHELEN = me importa un pimiento, no me importa nada.

🧩 Expresión fija — het kan me geen moer schelen:

• literal — no me puede importar ni una tuerca.
• significa — no me importa nada.
• piezas fijas — het vacío de sujeto; la persona en me, je, hem; schelen en infinitivo detrás de kunnen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Het kan me geen moer schelen. | Me importa un pimiento. |
| 2 | imperfecto | Het kon hem geen moer schelen. | Le importaba un pimiento. |
| 3 | subordinada | Ik zei dat het me geen moer kon schelen. | Dije que me importaba un pimiento. |

🎯 En qué contexto se usa:

• desinterés o enfado
• ⚠️ geen moer es coloquial, en el trabajo mejor het kan me niet schelen
• más fuerte todavía, geen bal

🔑 El truco que casi nunca falla: het kan me … schelen, y lo que pongas en medio sube el tono, niet, geen moer, geen bal.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me importa un pimiento.' AND notes = 'Ejemplo de "het kan me geen moer schelen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Me importa un pimiento.' AND notes = 'Ejemplo de "het kan me geen moer schelen" (can.)' LIMIT 1), 'nl_NL', 'Het kan me geen moer schelen.', 'het kan me jen mur sjelen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'me importa un pimiento' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me importa un pimiento.' AND notes = 'Ejemplo de "het kan me geen moer schelen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me importa un pimiento' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me importa un pimiento' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me importa un pimiento.' AND notes = 'Ejemplo de "het kan me geen moer schelen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me importa un pimiento.' AND notes = 'Ejemplo de "het kan me geen moer schelen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 048. hacer la vista gorda → een oogje dichtknijpen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hacer la vista gorda', 'PHRASE', 'frases hechas: een oogje dichtknijpen', 'EEN OOGJE DICHTKNIJPEN = hacer la vista gorda, tolerar una falta fingiendo no verla.

🧩 Expresión fija — een oogje dichtknijpen:

• literal — cerrar apretando un ojito.
• significa — tolerar una falta fingiendo no verla.
• piezas fijas — het oogje con een; dichtknijpen es separable y fuerte, knijpt dicht, kneep dicht, heeft dichtgeknepen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | De leraar knijpt een oogje dicht. | El profesor hace la vista gorda. |
| 2 | perfecto | Deze keer heb ik een oogje dichtgeknepen. | Esta vez he hecho la vista gorda. |
| 3 | imperativo | Knijp een oogje dicht, het is zijn verjaardag. | Haz la vista gorda, es su cumpleaños. |

🎯 En qué contexto se usa:

• profesores, padres o jefes que toleran pequeñas faltas
• para pedirlo, Knijp een oogje dicht
• registro neutro

🔑 El truco que casi nunca falla: en español engordas la vista, en neerlandés cierras un ojito.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hacer la vista gorda');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'hacer la vista gorda' LIMIT 1), 'nl_NL', 'een oogje dichtknijpen', 'en ójie díjtkneipen', '• [can.] De leraar knijpt een oogje dicht. — El profesor hace la vista gorda.
• [perf.] Deze keer heb ik een oogje dichtgeknepen. — Esta vez he hecho la vista gorda.
• [geb.] Knijp een oogje dicht, het is zijn verjaardag. — Haz la vista gorda, es su cumpleaños.
• [bijzin] Ik hoop dat de politie een oogje dichtknijpt. — Espero que la policía haga la vista gorda.
• [imperf.] Mijn moeder kneep vaak een oogje dicht. — Mi madre hacía a menudo la vista gorda.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'El profesor hace la vista gorda.', 'SENTENCE', 'Ejemplo de "een oogje dichtknijpen" (can.)', 'EEN OOGJE DICHTKNIJPEN = hacer la vista gorda, tolerar una falta fingiendo no verla.

🧩 Expresión fija — een oogje dichtknijpen:

• literal — cerrar apretando un ojito.
• significa — tolerar una falta fingiendo no verla.
• piezas fijas — het oogje con een; dichtknijpen es separable y fuerte, knijpt dicht, kneep dicht, heeft dichtgeknepen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | De leraar knijpt een oogje dicht. | El profesor hace la vista gorda. |
| 2 | perfecto | Deze keer heb ik een oogje dichtgeknepen. | Esta vez he hecho la vista gorda. |
| 3 | imperativo | Knijp een oogje dicht, het is zijn verjaardag. | Haz la vista gorda, es su cumpleaños. |

🎯 En qué contexto se usa:

• profesores, padres o jefes que toleran pequeñas faltas
• para pedirlo, Knijp een oogje dicht
• registro neutro

🔑 El truco que casi nunca falla: en español engordas la vista, en neerlandés cierras un ojito.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El profesor hace la vista gorda.' AND notes = 'Ejemplo de "een oogje dichtknijpen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'El profesor hace la vista gorda.' AND notes = 'Ejemplo de "een oogje dichtknijpen" (can.)' LIMIT 1), 'nl_NL', 'De leraar knijpt een oogje dicht.', 'de leraar kneipt en ojie dijt', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'hacer la vista gorda' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'El profesor hace la vista gorda.' AND notes = 'Ejemplo de "een oogje dichtknijpen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hacer la vista gorda' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hacer la vista gorda' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El profesor hace la vista gorda.' AND notes = 'Ejemplo de "een oogje dichtknijpen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El profesor hace la vista gorda.' AND notes = 'Ejemplo de "een oogje dichtknijpen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 049. tenerlo en la punta de la lengua → op het puntje van je tong liggen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tenerlo en la punta de la lengua', 'PHRASE', 'frases hechas: op het puntje van je tong liggen', 'OP HET PUNTJE VAN JE TONG LIGGEN = tenerlo en la punta de la lengua, casi recordar una palabra sin que salga.

🧩 Expresión fija — op het puntje van je tong liggen:

• literal — estar tumbado en la puntita de tu lengua.
• significa — casi recordar una palabra sin que salga.
• piezas fijas — el sujeto es la palabra, Het ligt op het puntje van mijn tong; liggen es fuerte, lag, gelegen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Het ligt op het puntje van mijn tong. | Lo tengo en la punta de la lengua. |
| 2 | imperfecto | Zijn naam lag op het puntje van mijn tong. | Tenía su nombre en la punta de la lengua. |
| 3 | perfecto | Het heeft de hele dag op het puntje van mijn tong gelegen. | Lo he tenido todo el día en la punta de la lengua. |

🎯 En qué contexto se usa:

• olvidar un nombre, una palabra, un título
• muy útil al aprender un idioma
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés lo que está en la punta es la palabra, no tú.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'tenerlo en la punta de la lengua');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'tenerlo en la punta de la lengua' LIMIT 1), 'nl_NL', 'op het puntje van je tong liggen', 'op et púntie fan ie tong líjen', '• [can.] Het ligt op het puntje van mijn tong. — Lo tengo en la punta de la lengua.
• [imperf.] Zijn naam lag op het puntje van mijn tong. — Tenía su nombre en la punta de la lengua.
• [perf.] Het heeft de hele dag op het puntje van mijn tong gelegen. — Lo he tenido todo el día en la punta de la lengua.
• [vraag] Ligt het op het puntje van je tong? — ¿Lo tienes en la punta de la lengua?
• [bijzin] Het is vervelend als een woord op het puntje van je tong ligt. — Es un fastidio tener una palabra en la punta de la lengua.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Lo tengo en la punta de la lengua.', 'SENTENCE', 'Ejemplo de "op het puntje van je tong liggen" (can.)', 'OP HET PUNTJE VAN JE TONG LIGGEN = tenerlo en la punta de la lengua, casi recordar una palabra sin que salga.

🧩 Expresión fija — op het puntje van je tong liggen:

• literal — estar tumbado en la puntita de tu lengua.
• significa — casi recordar una palabra sin que salga.
• piezas fijas — el sujeto es la palabra, Het ligt op het puntje van mijn tong; liggen es fuerte, lag, gelegen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Het ligt op het puntje van mijn tong. | Lo tengo en la punta de la lengua. |
| 2 | imperfecto | Zijn naam lag op het puntje van mijn tong. | Tenía su nombre en la punta de la lengua. |
| 3 | perfecto | Het heeft de hele dag op het puntje van mijn tong gelegen. | Lo he tenido todo el día en la punta de la lengua. |

🎯 En qué contexto se usa:

• olvidar un nombre, una palabra, un título
• muy útil al aprender un idioma
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés lo que está en la punta es la palabra, no tú.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Lo tengo en la punta de la lengua.' AND notes = 'Ejemplo de "op het puntje van je tong liggen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo tengo en la punta de la lengua.' AND notes = 'Ejemplo de "op het puntje van je tong liggen" (can.)' LIMIT 1), 'nl_NL', 'Het ligt op het puntje van mijn tong.', 'het lijt op het püntie fan mein tong', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'tenerlo en la punta de la lengua' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Lo tengo en la punta de la lengua.' AND notes = 'Ejemplo de "op het puntje van je tong liggen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tenerlo en la punta de la lengua' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tenerlo en la punta de la lengua' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo tengo en la punta de la lengua.' AND notes = 'Ejemplo de "op het puntje van je tong liggen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo tengo en la punta de la lengua.' AND notes = 'Ejemplo de "op het puntje van je tong liggen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 050. ponerse en la piel de otro → zich in iemand verplaatsen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ponerse en la piel de otro', 'PHRASE', 'frases hechas: zich in iemand verplaatsen', 'ZICH IN IEMAND VERPLAATSEN = ponerse en la piel de otro, imaginar lo que siente otra persona.

🧩 Expresión fija — zich in iemand verplaatsen:

• literal — desplazarse dentro de alguien.
• significa — imaginar lo que siente otra persona.
• piezas fijas — zich es reflexivo; in + persona; verplaatsen es inseparable, verplaatst sin ge- con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Probeer je in haar te verplaatsen. | Intenta ponerte en su piel. |
| 2 | principal | Ik verplaats me in de klant. | Me pongo en la piel del cliente. |
| 3 | perfecto | Hij heeft zich nooit in mij verplaatst. | Nunca se ha puesto en mi piel. |

🎯 En qué contexto se usa:

• empatía en discusiones, con clientes, con hijos
• para pedirlo, Probeer je in haar te verplaatsen
• con el pellejo ajeno, ik zou niet in zijn schoenen willen staan

🔑 El truco que casi nunca falla: en neerlandés te desplazas dentro de la otra persona.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ponerse en la piel de otro');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse en la piel de otro' LIMIT 1), 'nl_NL', 'zich in iemand verplaatsen', 'sij in íemant ferpláatsen', '• [geb.] Probeer je in haar te verplaatsen. — Intenta ponerte en su piel.
• [can.] Ik verplaats me in de klant. — Me pongo en la piel del cliente.
• [perf.] Hij heeft zich nooit in mij verplaatst. — Nunca se ha puesto en mi piel.
• [bijzin] Het is moeilijk als je je niet in een ander kunt verplaatsen. — Es difícil si no puedes ponerte en la piel de otro.
• [uitdr.] Ik zou niet in zijn schoenen willen staan. — No me gustaría estar en su pellejo.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Intenta ponerte en su piel.', 'SENTENCE', 'Ejemplo de "zich in iemand verplaatsen" (geb.)', 'ZICH IN IEMAND VERPLAATSEN = ponerse en la piel de otro, imaginar lo que siente otra persona.

🧩 Expresión fija — zich in iemand verplaatsen:

• literal — desplazarse dentro de alguien.
• significa — imaginar lo que siente otra persona.
• piezas fijas — zich es reflexivo; in + persona; verplaatsen es inseparable, verplaatst sin ge- con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Probeer je in haar te verplaatsen. | Intenta ponerte en su piel. |
| 2 | principal | Ik verplaats me in de klant. | Me pongo en la piel del cliente. |
| 3 | perfecto | Hij heeft zich nooit in mij verplaatst. | Nunca se ha puesto en mi piel. |

🎯 En qué contexto se usa:

• empatía en discusiones, con clientes, con hijos
• para pedirlo, Probeer je in haar te verplaatsen
• con el pellejo ajeno, ik zou niet in zijn schoenen willen staan

🔑 El truco que casi nunca falla: en neerlandés te desplazas dentro de la otra persona.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Intenta ponerte en su piel.' AND notes = 'Ejemplo de "zich in iemand verplaatsen" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Intenta ponerte en su piel.' AND notes = 'Ejemplo de "zich in iemand verplaatsen" (geb.)' LIMIT 1), 'nl_NL', 'Probeer je in haar te verplaatsen.', 'prober ie in haar te ferplaatsen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse en la piel de otro' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Intenta ponerte en su piel.' AND notes = 'Ejemplo de "zich in iemand verplaatsen" (geb.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse en la piel de otro' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse en la piel de otro' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Intenta ponerte en su piel.' AND notes = 'Ejemplo de "zich in iemand verplaatsen" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Intenta ponerte en su piel.' AND notes = 'Ejemplo de "zich in iemand verplaatsen" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 051. sacar las castañas del fuego → de kastanjes uit het vuur halen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'sacar las castañas del fuego', 'PHRASE', 'frases hechas: de kastanjes uit het vuur halen', 'DE KASTANJES UIT HET VUUR HALEN = sacar las castañas del fuego, resolverle un problema a otro, asumiendo el riesgo.

🧩 Expresión fija — de kastanjes uit het vuur halen:

• literal — sacar las castañas del fuego.
• significa — resolverle un problema a otro, asumiendo el riesgo.
• piezas fijas — de kastanjes, uit het vuur; la persona salvada con voor, voor iemand; halen es débil, gehaald.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik haal niet steeds voor jou de kastanjes uit het vuur. | No voy a sacarte siempre las castañas del fuego. |
| 2 | perfecto | Zijn collega heeft de kastanjes uit het vuur gehaald. | Su compañero le ha sacado las castañas del fuego. |
| 3 | subordinada | Hij verwacht dat ik de kastanjes uit het vuur haal. | Espera que le saque las castañas del fuego. |

🎯 En qué contexto se usa:

• compañeros que arreglan lo que otro rompió
• quejarse de hacerlo siempre tú
• registro neutro, igual que en español

🔑 El truco que casi nunca falla: igual que el español, y la persona salvada va con voor.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'sacar las castañas del fuego');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'sacar las castañas del fuego' LIMIT 1), 'nl_NL', 'de kastanjes uit het vuur halen', 'de kastánjes öit et füür hálen', '• [can.] Ik haal niet steeds voor jou de kastanjes uit het vuur. — No voy a sacarte siempre las castañas del fuego.
• [perf.] Zijn collega heeft de kastanjes uit het vuur gehaald. — Su compañero le ha sacado las castañas del fuego.
• [bijzin] Hij verwacht dat ik de kastanjes uit het vuur haal. — Espera que le saque las castañas del fuego.
• [vraag] Wie haalt de kastanjes uit het vuur? — ¿Quién saca las castañas del fuego?
• [imperf.] Mijn vader haalde altijd voor ons de kastanjes uit het vuur. — Mi padre siempre nos sacaba las castañas del fuego.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No voy a sacarte siempre las castañas del fuego.', 'SENTENCE', 'Ejemplo de "de kastanjes uit het vuur halen" (can.)', 'DE KASTANJES UIT HET VUUR HALEN = sacar las castañas del fuego, resolverle un problema a otro, asumiendo el riesgo.

🧩 Expresión fija — de kastanjes uit het vuur halen:

• literal — sacar las castañas del fuego.
• significa — resolverle un problema a otro, asumiendo el riesgo.
• piezas fijas — de kastanjes, uit het vuur; la persona salvada con voor, voor iemand; halen es débil, gehaald.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik haal niet steeds voor jou de kastanjes uit het vuur. | No voy a sacarte siempre las castañas del fuego. |
| 2 | perfecto | Zijn collega heeft de kastanjes uit het vuur gehaald. | Su compañero le ha sacado las castañas del fuego. |
| 3 | subordinada | Hij verwacht dat ik de kastanjes uit het vuur haal. | Espera que le saque las castañas del fuego. |

🎯 En qué contexto se usa:

• compañeros que arreglan lo que otro rompió
• quejarse de hacerlo siempre tú
• registro neutro, igual que en español

🔑 El truco que casi nunca falla: igual que el español, y la persona salvada va con voor.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No voy a sacarte siempre las castañas del fuego.' AND notes = 'Ejemplo de "de kastanjes uit het vuur halen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'No voy a sacarte siempre las castañas del fuego.' AND notes = 'Ejemplo de "de kastanjes uit het vuur halen" (can.)' LIMIT 1), 'nl_NL', 'Ik haal niet steeds voor jou de kastanjes uit het vuur.', 'ik haal nit steds for iau de kastanies öit het für', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'sacar las castañas del fuego' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No voy a sacarte siempre las castañas del fuego.' AND notes = 'Ejemplo de "de kastanjes uit het vuur halen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'sacar las castañas del fuego' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'sacar las castañas del fuego' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No voy a sacarte siempre las castañas del fuego.' AND notes = 'Ejemplo de "de kastanjes uit het vuur halen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No voy a sacarte siempre las castañas del fuego.' AND notes = 'Ejemplo de "de kastanjes uit het vuur halen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 052. tener la sartén por el mango → de touwtjes in handen hebben
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tener la sartén por el mango', 'PHRASE', 'frases hechas: de touwtjes in handen hebben', 'DE TOUWTJES IN HANDEN HEBBEN = tener la sartén por el mango, ser quien manda y controla.

🧩 Expresión fija — de touwtjes in handen hebben:

• literal — tener las cuerditas en las manos.
• significa — ser quien manda y controla.
• piezas fijas — de touwtjes en diminutivo plural; in handen sin artículo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Mijn moeder heeft de touwtjes in handen. | Mi madre tiene la sartén por el mango. |
| 2 | perfecto | Hij heeft altijd de touwtjes in handen gehad. | Siempre ha tenido la sartén por el mango. |
| 3 | subordinada | Het is duidelijk dat zij de touwtjes in handen heeft. | Está claro que ella tiene la sartén por el mango. |

🎯 En qué contexto se usa:

• quién manda en una empresa, un proyecto o una casa
• en pregunta, Wie heeft hier de touwtjes in handen?
• en casa, de broek aanhebben, llevar los pantalones

🔑 El truco que casi nunca falla: quien sujeta los hilos de la marioneta es quien manda.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'tener la sartén por el mango');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'tener la sartén por el mango' LIMIT 1), 'nl_NL', 'de touwtjes in handen hebben', 'de táutjes in hánden hébben', '• [can.] Mijn moeder heeft de touwtjes in handen. — Mi madre tiene la sartén por el mango.
• [perf.] Hij heeft altijd de touwtjes in handen gehad. — Siempre ha tenido la sartén por el mango.
• [bijzin] Het is duidelijk dat zij de touwtjes in handen heeft. — Está claro que ella tiene la sartén por el mango.
• [vraag] Wie heeft hier de touwtjes in handen? — ¿Quién tiene aquí la sartén por el mango?
• [uitdr.] Zij heeft de broek aan. — Ella es la que lleva los pantalones.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Mi madre tiene la sartén por el mango.', 'SENTENCE', 'Ejemplo de "de touwtjes in handen hebben" (can.)', 'DE TOUWTJES IN HANDEN HEBBEN = tener la sartén por el mango, ser quien manda y controla.

🧩 Expresión fija — de touwtjes in handen hebben:

• literal — tener las cuerditas en las manos.
• significa — ser quien manda y controla.
• piezas fijas — de touwtjes en diminutivo plural; in handen sin artículo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Mijn moeder heeft de touwtjes in handen. | Mi madre tiene la sartén por el mango. |
| 2 | perfecto | Hij heeft altijd de touwtjes in handen gehad. | Siempre ha tenido la sartén por el mango. |
| 3 | subordinada | Het is duidelijk dat zij de touwtjes in handen heeft. | Está claro que ella tiene la sartén por el mango. |

🎯 En qué contexto se usa:

• quién manda en una empresa, un proyecto o una casa
• en pregunta, Wie heeft hier de touwtjes in handen?
• en casa, de broek aanhebben, llevar los pantalones

🔑 El truco que casi nunca falla: quien sujeta los hilos de la marioneta es quien manda.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi madre tiene la sartén por el mango.' AND notes = 'Ejemplo de "de touwtjes in handen hebben" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi madre tiene la sartén por el mango.' AND notes = 'Ejemplo de "de touwtjes in handen hebben" (can.)' LIMIT 1), 'nl_NL', 'Mijn moeder heeft de touwtjes in handen.', 'mein muder heft de tauuties in handen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'tener la sartén por el mango' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi madre tiene la sartén por el mango.' AND notes = 'Ejemplo de "de touwtjes in handen hebben" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tener la sartén por el mango' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tener la sartén por el mango' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi madre tiene la sartén por el mango.' AND notes = 'Ejemplo de "de touwtjes in handen hebben" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi madre tiene la sartén por el mango.' AND notes = 'Ejemplo de "de touwtjes in handen hebben" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 053. no tener ni idea → geen flauw idee hebben
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no tener ni idea', 'PHRASE', 'frases hechas: geen flauw idee hebben', 'GEEN FLAUW IDEE HEBBEN = no tener ni idea, no saber nada de algo.

🧩 Expresión fija — geen flauw idee hebben:

• literal — no tener ni una idea flojita.
• significa — no saber nada de algo.
• piezas fijas — het idee con geen; flauw delante, sin -e porque va con geen y es het-woord.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik heb geen flauw idee. | No tengo ni idea. |
| 2 | imperfecto | Hij had geen flauw idee waar hij was. | No tenía ni idea de dónde estaba. |
| 3 | pregunta | Weet jij hoe laat het is? Geen flauw idee. | ¿Sabes qué hora es? Ni idea. |

🎯 En qué contexto se usa:

• preguntas sin respuesta, de uso diario
• solo, como respuesta, Geen flauw idee!
• más corto, Geen idee!

🔑 El truco que casi nunca falla: la idea española es flauw, flojita, en neerlandés.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no tener ni idea');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener ni idea' LIMIT 1), 'nl_NL', 'geen flauw idee hebben', 'jeen flau idée hébben', '• [can.] Ik heb geen flauw idee. — No tengo ni idea.
• [imperf.] Hij had geen flauw idee waar hij was. — No tenía ni idea de dónde estaba.
• [vraag] Weet jij hoe laat het is? Geen flauw idee. — ¿Sabes qué hora es? Ni idea.
• [bijzin] Ik moet toegeven dat ik geen flauw idee heb. — Tengo que admitir que no tengo ni idea.
• [uitdr.] Geen idee! — ¡Ni idea!');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No tengo ni idea.', 'SENTENCE', 'Ejemplo de "geen flauw idee hebben" (can.)', 'GEEN FLAUW IDEE HEBBEN = no tener ni idea, no saber nada de algo.

🧩 Expresión fija — geen flauw idee hebben:

• literal — no tener ni una idea flojita.
• significa — no saber nada de algo.
• piezas fijas — het idee con geen; flauw delante, sin -e porque va con geen y es het-woord.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik heb geen flauw idee. | No tengo ni idea. |
| 2 | imperfecto | Hij had geen flauw idee waar hij was. | No tenía ni idea de dónde estaba. |
| 3 | pregunta | Weet jij hoe laat het is? Geen flauw idee. | ¿Sabes qué hora es? Ni idea. |

🎯 En qué contexto se usa:

• preguntas sin respuesta, de uso diario
• solo, como respuesta, Geen flauw idee!
• más corto, Geen idee!

🔑 El truco que casi nunca falla: la idea española es flauw, flojita, en neerlandés.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No tengo ni idea.' AND notes = 'Ejemplo de "geen flauw idee hebben" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'No tengo ni idea.' AND notes = 'Ejemplo de "geen flauw idee hebben" (can.)' LIMIT 1), 'nl_NL', 'Ik heb geen flauw idee.', 'ik heb jen flauu ide', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener ni idea' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No tengo ni idea.' AND notes = 'Ejemplo de "geen flauw idee hebben" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener ni idea' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener ni idea' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No tengo ni idea.' AND notes = 'Ejemplo de "geen flauw idee hebben" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No tengo ni idea.' AND notes = 'Ejemplo de "geen flauw idee hebben" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 054. estar de brazos cruzados → met de armen over elkaar zitten
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estar de brazos cruzados', 'PHRASE', 'frases hechas: met de armen over elkaar zitten', 'MET DE ARMEN OVER ELKAAR ZITTEN = estar de brazos cruzados, no hacer nada ante algo que pide actuar.

🧩 Expresión fija — met de armen over elkaar zitten:

• literal — estar sentado con los brazos uno sobre otro.
• significa — no hacer nada ante algo que pide actuar.
• piezas fijas — de armen, over elkaar; zitten es fuerte, zat, gezeten; también con blijven zitten.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij zit de hele dag met de armen over elkaar. | Está todo el día de brazos cruzados. |
| 2 | imperativo | Blijf niet met de armen over elkaar zitten. | No te quedes de brazos cruzados. |
| 3 | perfecto | De regering heeft met de armen over elkaar gezeten. | El gobierno se ha quedado de brazos cruzados. |

🎯 En qué contexto se usa:

• criticar la pasividad de alguien o de un gobierno
• para animar, Blijf niet met de armen over elkaar zitten
• registro neutro

🔑 El truco que casi nunca falla: igual que el español, sentado y con un brazo sobre otro.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estar de brazos cruzados');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'estar de brazos cruzados' LIMIT 1), 'nl_NL', 'met de armen over elkaar zitten', 'met de ármen ófer élkar sítten', '• [can.] Hij zit de hele dag met de armen over elkaar. — Está todo el día de brazos cruzados.
• [geb.] Blijf niet met de armen over elkaar zitten. — No te quedes de brazos cruzados.
• [perf.] De regering heeft met de armen over elkaar gezeten. — El gobierno se ha quedado de brazos cruzados.
• [bijzin] Ik vind het erg dat jullie met de armen over elkaar zitten. — Me parece fatal que estéis de brazos cruzados.
• [vraag] Waarom zit je met de armen over elkaar? — ¿Por qué estás de brazos cruzados?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Está todo el día de brazos cruzados.', 'SENTENCE', 'Ejemplo de "met de armen over elkaar zitten" (can.)', 'MET DE ARMEN OVER ELKAAR ZITTEN = estar de brazos cruzados, no hacer nada ante algo que pide actuar.

🧩 Expresión fija — met de armen over elkaar zitten:

• literal — estar sentado con los brazos uno sobre otro.
• significa — no hacer nada ante algo que pide actuar.
• piezas fijas — de armen, over elkaar; zitten es fuerte, zat, gezeten; también con blijven zitten.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij zit de hele dag met de armen over elkaar. | Está todo el día de brazos cruzados. |
| 2 | imperativo | Blijf niet met de armen over elkaar zitten. | No te quedes de brazos cruzados. |
| 3 | perfecto | De regering heeft met de armen over elkaar gezeten. | El gobierno se ha quedado de brazos cruzados. |

🎯 En qué contexto se usa:

• criticar la pasividad de alguien o de un gobierno
• para animar, Blijf niet met de armen over elkaar zitten
• registro neutro

🔑 El truco que casi nunca falla: igual que el español, sentado y con un brazo sobre otro.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Está todo el día de brazos cruzados.' AND notes = 'Ejemplo de "met de armen over elkaar zitten" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Está todo el día de brazos cruzados.' AND notes = 'Ejemplo de "met de armen over elkaar zitten" (can.)' LIMIT 1), 'nl_NL', 'Hij zit de hele dag met de armen over elkaar.', 'hei sit de hele daj met de armen ofer elkaar', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'estar de brazos cruzados' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Está todo el día de brazos cruzados.' AND notes = 'Ejemplo de "met de armen over elkaar zitten" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar de brazos cruzados' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar de brazos cruzados' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Está todo el día de brazos cruzados.' AND notes = 'Ejemplo de "met de armen over elkaar zitten" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Está todo el día de brazos cruzados.' AND notes = 'Ejemplo de "met de armen over elkaar zitten" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 055. a la vuelta de la esquina → om de hoek
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'a la vuelta de la esquina', 'PHRASE', 'frases hechas: om de hoek', 'OM DE HOEK = a la vuelta de la esquina, muy cerca, en el espacio.

🧩 Expresión fija — om de hoek:

• literal — alrededor de la esquina.
• significa — muy cerca, en el espacio.
• piezas fijas — de hoek; para el tiempo no se usa om de hoek sino voor de deur staan.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | De supermarkt is om de hoek. | El supermercado está a la vuelta de la esquina. |
| 2 | expresión | De kerst staat voor de deur. | La Navidad está a la vuelta de la esquina. |
| 3 | imperfecto | Mijn oma woonde om de hoek. | Mi abuela vivía a la vuelta de la esquina. |

🎯 En qué contexto se usa:

• lugares cercanos, la tienda, la farmacia
• ⚠️ para fechas próximas se dice voor de deur staan, De zomer staat voor de deur
• registro neutro

🔑 El truco que casi nunca falla: lugar, om de hoek, fecha, voor de deur staan.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'a la vuelta de la esquina');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'a la vuelta de la esquina' LIMIT 1), 'nl_NL', 'om de hoek', 'om de huk', '• [can.] De supermarkt is om de hoek. — El supermercado está a la vuelta de la esquina.
• [uitdr.] De kerst staat voor de deur. — La Navidad está a la vuelta de la esquina.
• [imperf.] Mijn oma woonde om de hoek. — Mi abuela vivía a la vuelta de la esquina.
• [vraag] Is er een apotheek om de hoek? — ¿Hay una farmacia a la vuelta de la esquina?
• [bijzin] Ik weet dat de examens voor de deur staan. — Sé que los exámenes están a la vuelta de la esquina.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'El supermercado está a la vuelta de la esquina.', 'SENTENCE', 'Ejemplo de "om de hoek" (can.)', 'OM DE HOEK = a la vuelta de la esquina, muy cerca, en el espacio.

🧩 Expresión fija — om de hoek:

• literal — alrededor de la esquina.
• significa — muy cerca, en el espacio.
• piezas fijas — de hoek; para el tiempo no se usa om de hoek sino voor de deur staan.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | De supermarkt is om de hoek. | El supermercado está a la vuelta de la esquina. |
| 2 | expresión | De kerst staat voor de deur. | La Navidad está a la vuelta de la esquina. |
| 3 | imperfecto | Mijn oma woonde om de hoek. | Mi abuela vivía a la vuelta de la esquina. |

🎯 En qué contexto se usa:

• lugares cercanos, la tienda, la farmacia
• ⚠️ para fechas próximas se dice voor de deur staan, De zomer staat voor de deur
• registro neutro

🔑 El truco que casi nunca falla: lugar, om de hoek, fecha, voor de deur staan.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El supermercado está a la vuelta de la esquina.' AND notes = 'Ejemplo de "om de hoek" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'El supermercado está a la vuelta de la esquina.' AND notes = 'Ejemplo de "om de hoek" (can.)' LIMIT 1), 'nl_NL', 'De supermarkt is om de hoek.', 'de süpermarkt is om de huk', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'a la vuelta de la esquina' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'El supermercado está a la vuelta de la esquina.' AND notes = 'Ejemplo de "om de hoek" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a la vuelta de la esquina' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a la vuelta de la esquina' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El supermercado está a la vuelta de la esquina.' AND notes = 'Ejemplo de "om de hoek" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El supermercado está a la vuelta de la esquina.' AND notes = 'Ejemplo de "om de hoek" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 056. de tal palo, tal astilla → de appel valt niet ver van de boom
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'de tal palo, tal astilla', 'PHRASE', 'frases hechas: de appel valt niet ver van de boom', 'DE APPEL VALT NIET VER VAN DE BOOM = de tal palo, tal astilla, los hijos se parecen a los padres.

🧩 Expresión fija — de appel valt niet ver van de boom:

• literal — la manzana no cae lejos del árbol.
• significa — los hijos se parecen a los padres.
• piezas fijas — refrán cerrado; de appel, de boom.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | De appel valt niet ver van de boom. | De tal palo, tal astilla. |
| 2 | principal | Hij kookt net als zijn vader, de appel valt niet ver van de boom. | Cocina igual que su padre, de tal palo, tal astilla. |
| 3 | imperfecto | Ze was net zo koppig als haar moeder, de appel valt niet ver van de boom. | Era igual de terca que su madre, de tal palo, tal astilla. |

🎯 En qué contexto se usa:

• parecidos entre padres e hijos, para bien o para mal
• tono de humor o de reproche
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés no hay palo, hay un manzano.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'de tal palo, tal astilla');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'de tal palo, tal astilla' LIMIT 1), 'nl_NL', 'de appel valt niet ver van de boom', 'de ápel falt nit fer fan de boom', '• [uitdr.] De appel valt niet ver van de boom. — De tal palo, tal astilla.
• [can.] Hij kookt net als zijn vader, de appel valt niet ver van de boom. — Cocina igual que su padre, de tal palo, tal astilla.
• [imperf.] Ze was net zo koppig als haar moeder, de appel valt niet ver van de boom. — Era igual de terca que su madre, de tal palo, tal astilla.
• [bijzin] Je ziet wel dat de appel niet ver van de boom valt. — Ya se ve que de tal palo, tal astilla.
• [vraag] De appel valt niet ver van de boom, hè? — De tal palo, tal astilla, ¿eh?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'De tal palo, tal astilla.', 'SENTENCE', 'Ejemplo de "de appel valt niet ver van de boom" (uitdr.)', 'DE APPEL VALT NIET VER VAN DE BOOM = de tal palo, tal astilla, los hijos se parecen a los padres.

🧩 Expresión fija — de appel valt niet ver van de boom:

• literal — la manzana no cae lejos del árbol.
• significa — los hijos se parecen a los padres.
• piezas fijas — refrán cerrado; de appel, de boom.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | De appel valt niet ver van de boom. | De tal palo, tal astilla. |
| 2 | principal | Hij kookt net als zijn vader, de appel valt niet ver van de boom. | Cocina igual que su padre, de tal palo, tal astilla. |
| 3 | imperfecto | Ze was net zo koppig als haar moeder, de appel valt niet ver van de boom. | Era igual de terca que su madre, de tal palo, tal astilla. |

🎯 En qué contexto se usa:

• parecidos entre padres e hijos, para bien o para mal
• tono de humor o de reproche
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés no hay palo, hay un manzano.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'De tal palo, tal astilla.' AND notes = 'Ejemplo de "de appel valt niet ver van de boom" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'De tal palo, tal astilla.' AND notes = 'Ejemplo de "de appel valt niet ver van de boom" (uitdr.)' LIMIT 1), 'nl_NL', 'De appel valt niet ver van de boom.', 'de apel falt nit fer fan de bom', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'de tal palo, tal astilla' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'De tal palo, tal astilla.' AND notes = 'Ejemplo de "de appel valt niet ver van de boom" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'de tal palo, tal astilla' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'de tal palo, tal astilla' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'De tal palo, tal astilla.' AND notes = 'Ejemplo de "de appel valt niet ver van de boom" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'De tal palo, tal astilla.' AND notes = 'Ejemplo de "de appel valt niet ver van de boom" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 057. el que la sigue la consigue → de aanhouder wint
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el que la sigue la consigue', 'PHRASE', 'frases hechas: de aanhouder wint', 'DE AANHOUDER WINT = el que la sigue la consigue, insistiendo se consigue.

🧩 Expresión fija — de aanhouder wint:

• literal — el que persiste gana.
• significa — insistiendo se consigue.
• piezas fijas — refrán cerrado; de aanhouder viene de aanhouden, persistir.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | De aanhouder wint. | El que la sigue la consigue. |
| 2 | perfecto | Ik heb na tien keer de baan gekregen, de aanhouder wint. | Me han dado el trabajo a la décima, el que la sigue la consigue. |
| 3 | imperativo | Blijf het proberen, de aanhouder wint. | Sigue intentándolo, el que la sigue la consigue. |

🎯 En qué contexto se usa:

• animar a alguien a seguir intentándolo
• contar un éxito tras muchos intentos
• registro neutro

🔑 El truco que casi nunca falla: aanhouden es no soltar, y quien no suelta gana.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el que la sigue la consigue');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el que la sigue la consigue' LIMIT 1), 'nl_NL', 'de aanhouder wint', 'de áanhauder vint', '• [uitdr.] De aanhouder wint. — El que la sigue la consigue.
• [perf.] Ik heb na tien keer de baan gekregen, de aanhouder wint. — Me han dado el trabajo a la décima, el que la sigue la consigue.
• [geb.] Blijf het proberen, de aanhouder wint. — Sigue intentándolo, el que la sigue la consigue.
• [bijzin] Mijn trainer zegt altijd dat de aanhouder wint. — Mi entrenador siempre dice que el que la sigue la consigue.
• [geb.] Geef niet op. — No te rindas.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'El que la sigue la consigue.', 'SENTENCE', 'Ejemplo de "de aanhouder wint" (uitdr.)', 'DE AANHOUDER WINT = el que la sigue la consigue, insistiendo se consigue.

🧩 Expresión fija — de aanhouder wint:

• literal — el que persiste gana.
• significa — insistiendo se consigue.
• piezas fijas — refrán cerrado; de aanhouder viene de aanhouden, persistir.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | De aanhouder wint. | El que la sigue la consigue. |
| 2 | perfecto | Ik heb na tien keer de baan gekregen, de aanhouder wint. | Me han dado el trabajo a la décima, el que la sigue la consigue. |
| 3 | imperativo | Blijf het proberen, de aanhouder wint. | Sigue intentándolo, el que la sigue la consigue. |

🎯 En qué contexto se usa:

• animar a alguien a seguir intentándolo
• contar un éxito tras muchos intentos
• registro neutro

🔑 El truco que casi nunca falla: aanhouden es no soltar, y quien no suelta gana.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El que la sigue la consigue.' AND notes = 'Ejemplo de "de aanhouder wint" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'El que la sigue la consigue.' AND notes = 'Ejemplo de "de aanhouder wint" (uitdr.)' LIMIT 1), 'nl_NL', 'De aanhouder wint.', 'de aanhauder vint', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'el que la sigue la consigue' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'El que la sigue la consigue.' AND notes = 'Ejemplo de "de aanhouder wint" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el que la sigue la consigue' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el que la sigue la consigue' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El que la sigue la consigue.' AND notes = 'Ejemplo de "de aanhouder wint" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El que la sigue la consigue.' AND notes = 'Ejemplo de "de aanhouder wint" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 058. no es oro todo lo que reluce → het is niet alles goud wat er blinkt
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no es oro todo lo que reluce', 'PHRASE', 'frases hechas: het is niet alles goud wat er blinkt', 'HET IS NIET ALLES GOUD WAT ER BLINKT = no es oro todo lo que reluce, las apariencias engañan.

🧩 Expresión fija — het is niet alles goud wat er blinkt:

• literal — no es todo oro lo que brilla.
• significa — las apariencias engañan.
• piezas fijas — refrán cerrado con er de relleno delante de blinkt; blinken es fuerte, blonk, geblonken.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Het is niet alles goud wat er blinkt. | No es oro todo lo que reluce. |
| 2 | principal | Die baan lijkt mooi, maar het is niet alles goud wat er blinkt. | Ese trabajo parece bonito, pero no es oro todo lo que reluce. |
| 3 | perfecto | Ik heb geleerd dat het niet alles goud is wat er blinkt. | He aprendido que no es oro todo lo que reluce. |

🎯 En qué contexto se usa:

• desconfiar de ofertas, trabajos o personas demasiado bonitos
• advertir a alguien con experiencia
• registro neutro

🔑 El truco que casi nunca falla: igual que el español, con er de relleno antes de blinkt.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no es oro todo lo que reluce');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'no es oro todo lo que reluce' LIMIT 1), 'nl_NL', 'het is niet alles goud wat er blinkt', 'et is nit álles jaut vat er blinkt', '• [uitdr.] Het is niet alles goud wat er blinkt. — No es oro todo lo que reluce.
• [can.] Die baan lijkt mooi, maar het is niet alles goud wat er blinkt. — Ese trabajo parece bonito, pero no es oro todo lo que reluce.
• [perf.] Ik heb geleerd dat het niet alles goud is wat er blinkt. — He aprendido que no es oro todo lo que reluce.
• [imperf.] Het huis was mooi, maar het was niet alles goud wat er blonk. — La casa era bonita, pero no era oro todo lo que relucía.
• [vraag] Weet je dat het niet alles goud is wat er blinkt? — ¿Sabes que no es oro todo lo que reluce?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No es oro todo lo que reluce.', 'SENTENCE', 'Ejemplo de "het is niet alles goud wat er blinkt" (uitdr.)', 'HET IS NIET ALLES GOUD WAT ER BLINKT = no es oro todo lo que reluce, las apariencias engañan.

🧩 Expresión fija — het is niet alles goud wat er blinkt:

• literal — no es todo oro lo que brilla.
• significa — las apariencias engañan.
• piezas fijas — refrán cerrado con er de relleno delante de blinkt; blinken es fuerte, blonk, geblonken.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Het is niet alles goud wat er blinkt. | No es oro todo lo que reluce. |
| 2 | principal | Die baan lijkt mooi, maar het is niet alles goud wat er blinkt. | Ese trabajo parece bonito, pero no es oro todo lo que reluce. |
| 3 | perfecto | Ik heb geleerd dat het niet alles goud is wat er blinkt. | He aprendido que no es oro todo lo que reluce. |

🎯 En qué contexto se usa:

• desconfiar de ofertas, trabajos o personas demasiado bonitos
• advertir a alguien con experiencia
• registro neutro

🔑 El truco que casi nunca falla: igual que el español, con er de relleno antes de blinkt.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No es oro todo lo que reluce.' AND notes = 'Ejemplo de "het is niet alles goud wat er blinkt" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'No es oro todo lo que reluce.' AND notes = 'Ejemplo de "het is niet alles goud wat er blinkt" (uitdr.)' LIMIT 1), 'nl_NL', 'Het is niet alles goud wat er blinkt.', 'het is nit ales jaut vat er blinkt', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'no es oro todo lo que reluce' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No es oro todo lo que reluce.' AND notes = 'Ejemplo de "het is niet alles goud wat er blinkt" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no es oro todo lo que reluce' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no es oro todo lo que reluce' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No es oro todo lo que reluce.' AND notes = 'Ejemplo de "het is niet alles goud wat er blinkt" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No es oro todo lo que reluce.' AND notes = 'Ejemplo de "het is niet alles goud wat er blinkt" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 059. a quien madruga, Dios le ayuda → de morgenstond heeft goud in de mond
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'a quien madruga, Dios le ayuda', 'PHRASE', 'frases hechas: de morgenstond heeft goud in de mond', 'DE MORGENSTOND HEEFT GOUD IN DE MOND = a quien madruga, Dios le ayuda, madrugar trae ventajas.

🧩 Expresión fija — de morgenstond heeft goud in de mond:

• literal — la hora de la mañana tiene oro en la boca.
• significa — madrugar trae ventajas.
• piezas fijas — refrán cerrado; de morgenstond, het goud sin artículo, in de mond.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | De morgenstond heeft goud in de mond. | A quien madruga, Dios le ayuda. |
| 2 | principal | Ik sta om zes uur op, de morgenstond heeft goud in de mond. | Me levanto a las seis, a quien madruga, Dios le ayuda. |
| 3 | imperfecto | Mijn opa stond altijd vroeg op, want de morgenstond heeft goud in de mond. | Mi abuelo siempre madrugaba, porque a quien madruga, Dios le ayuda. |

🎯 En qué contexto se usa:

• animar a alguien a levantarse temprano
• justificar tu madrugón
• tono de abuelo, refrán muy conocido

🔑 El truco que casi nunca falla: en neerlandés quien ayuda no es Dios, es el oro de la mañana.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'a quien madruga, Dios le ayuda');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'a quien madruga, Dios le ayuda' LIMIT 1), 'nl_NL', 'de morgenstond heeft goud in de mond', 'de mórjenstont heeft jaut in de mont', '• [uitdr.] De morgenstond heeft goud in de mond. — A quien madruga, Dios le ayuda.
• [can.] Ik sta om zes uur op, de morgenstond heeft goud in de mond. — Me levanto a las seis, a quien madruga, Dios le ayuda.
• [imperf.] Mijn opa stond altijd vroeg op, want de morgenstond heeft goud in de mond. — Mi abuelo siempre madrugaba, porque a quien madruga, Dios le ayuda.
• [perf.] Ik ben vroeg begonnen en ik ben al klaar. — He empezado temprano y ya he terminado.
• [bijzin] Hij zegt dat de morgenstond goud in de mond heeft. — Dice que a quien madruga, Dios le ayuda.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'A quien madruga, Dios le ayuda.', 'SENTENCE', 'Ejemplo de "de morgenstond heeft goud in de mond" (uitdr.)', 'DE MORGENSTOND HEEFT GOUD IN DE MOND = a quien madruga, Dios le ayuda, madrugar trae ventajas.

🧩 Expresión fija — de morgenstond heeft goud in de mond:

• literal — la hora de la mañana tiene oro en la boca.
• significa — madrugar trae ventajas.
• piezas fijas — refrán cerrado; de morgenstond, het goud sin artículo, in de mond.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | De morgenstond heeft goud in de mond. | A quien madruga, Dios le ayuda. |
| 2 | principal | Ik sta om zes uur op, de morgenstond heeft goud in de mond. | Me levanto a las seis, a quien madruga, Dios le ayuda. |
| 3 | imperfecto | Mijn opa stond altijd vroeg op, want de morgenstond heeft goud in de mond. | Mi abuelo siempre madrugaba, porque a quien madruga, Dios le ayuda. |

🎯 En qué contexto se usa:

• animar a alguien a levantarse temprano
• justificar tu madrugón
• tono de abuelo, refrán muy conocido

🔑 El truco que casi nunca falla: en neerlandés quien ayuda no es Dios, es el oro de la mañana.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'A quien madruga, Dios le ayuda.' AND notes = 'Ejemplo de "de morgenstond heeft goud in de mond" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'A quien madruga, Dios le ayuda.' AND notes = 'Ejemplo de "de morgenstond heeft goud in de mond" (uitdr.)' LIMIT 1), 'nl_NL', 'De morgenstond heeft goud in de mond.', 'de morjenstont heft jaut in de mont', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'a quien madruga, Dios le ayuda' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'A quien madruga, Dios le ayuda.' AND notes = 'Ejemplo de "de morgenstond heeft goud in de mond" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a quien madruga, Dios le ayuda' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'a quien madruga, Dios le ayuda' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A quien madruga, Dios le ayuda.' AND notes = 'Ejemplo de "de morgenstond heeft goud in de mond" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'A quien madruga, Dios le ayuda.' AND notes = 'Ejemplo de "de morgenstond heeft goud in de mond" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 060. perro ladrador, poco mordedor → blaffende honden bijten niet
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'perro ladrador, poco mordedor', 'PHRASE', 'frases hechas: blaffende honden bijten niet', 'BLAFFENDE HONDEN BIJTEN NIET = perro ladrador, poco mordedor, quien amenaza mucho no suele hacer nada.

🧩 Expresión fija — blaffende honden bijten niet:

• literal — los perros que ladran no muerden.
• significa — quien amenaza mucho no suele hacer nada.
• piezas fijas — refrán cerrado en plural; blaffende es participio de presente.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Blaffende honden bijten niet. | Perro ladrador, poco mordedor. |
| 2 | principal | Hij schreeuwt veel, maar blaffende honden bijten niet. | Grita mucho, pero perro ladrador, poco mordedor. |
| 3 | imperfecto | De baas dreigde met ontslag, maar blaffende honden bijten niet. | El jefe amenazaba con despidos, pero perro ladrador, poco mordedor. |

🎯 En qué contexto se usa:

• amenazas vacías de un jefe, un vecino, un político
• tranquilizar a alguien asustado
• registro neutro

🔑 El truco que casi nunca falla: en plural, perros que ladran no muerden.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'perro ladrador, poco mordedor');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'perro ladrador, poco mordedor' LIMIT 1), 'nl_NL', 'blaffende honden bijten niet', 'bláfende hónden béiten nit', '• [uitdr.] Blaffende honden bijten niet. — Perro ladrador, poco mordedor.
• [can.] Hij schreeuwt veel, maar blaffende honden bijten niet. — Grita mucho, pero perro ladrador, poco mordedor.
• [imperf.] De baas dreigde met ontslag, maar blaffende honden bijten niet. — El jefe amenazaba con despidos, pero perro ladrador, poco mordedor.
• [bijzin] Maak je geen zorgen, want blaffende honden bijten niet. — No te preocupes, que perro ladrador, poco mordedor.
• [vraag] Blaffende honden bijten niet, toch? — Perro ladrador, poco mordedor, ¿no?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Perro ladrador, poco mordedor.', 'SENTENCE', 'Ejemplo de "blaffende honden bijten niet" (uitdr.)', 'BLAFFENDE HONDEN BIJTEN NIET = perro ladrador, poco mordedor, quien amenaza mucho no suele hacer nada.

🧩 Expresión fija — blaffende honden bijten niet:

• literal — los perros que ladran no muerden.
• significa — quien amenaza mucho no suele hacer nada.
• piezas fijas — refrán cerrado en plural; blaffende es participio de presente.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Blaffende honden bijten niet. | Perro ladrador, poco mordedor. |
| 2 | principal | Hij schreeuwt veel, maar blaffende honden bijten niet. | Grita mucho, pero perro ladrador, poco mordedor. |
| 3 | imperfecto | De baas dreigde met ontslag, maar blaffende honden bijten niet. | El jefe amenazaba con despidos, pero perro ladrador, poco mordedor. |

🎯 En qué contexto se usa:

• amenazas vacías de un jefe, un vecino, un político
• tranquilizar a alguien asustado
• registro neutro

🔑 El truco que casi nunca falla: en plural, perros que ladran no muerden.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Perro ladrador, poco mordedor.' AND notes = 'Ejemplo de "blaffende honden bijten niet" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Perro ladrador, poco mordedor.' AND notes = 'Ejemplo de "blaffende honden bijten niet" (uitdr.)' LIMIT 1), 'nl_NL', 'Blaffende honden bijten niet.', 'blafende honden beiten nit', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'perro ladrador, poco mordedor' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Perro ladrador, poco mordedor.' AND notes = 'Ejemplo de "blaffende honden bijten niet" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'perro ladrador, poco mordedor' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'perro ladrador, poco mordedor' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Perro ladrador, poco mordedor.' AND notes = 'Ejemplo de "blaffende honden bijten niet" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Perro ladrador, poco mordedor.' AND notes = 'Ejemplo de "blaffende honden bijten niet" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 061. poner el grito en el cielo → moord en brand schreeuwen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'poner el grito en el cielo', 'PHRASE', 'frases hechas: moord en brand schreeuwen', 'MOORD EN BRAND SCHREEUWEN = poner el grito en el cielo, protestar de forma exagerada.

🧩 Expresión fija — moord en brand schreeuwen:

• literal — gritar asesinato e incendio.
• significa — protestar de forma exagerada.
• piezas fijas — moord en brand sin artículos; schreeuwen es débil, geschreeuwd con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | De buren schreeuwen moord en brand. | Los vecinos ponen el grito en el cielo. |
| 2 | perfecto | Toen hij de rekening zag, heeft hij moord en brand geschreeuwd. | Cuando vio la cuenta, puso el grito en el cielo. |
| 3 | imperfecto | Mijn moeder schreeuwde moord en brand. | Mi madre puso el grito en el cielo. |

🎯 En qué contexto se usa:

• quejas exageradas por una factura, una multa, una nota
• vecinos, padres, clientes enfadados
• registro neutro, algo irónico

🔑 El truco que casi nunca falla: en español gritas al cielo, en neerlandés gritas asesinato y fuego.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'poner el grito en el cielo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'poner el grito en el cielo' LIMIT 1), 'nl_NL', 'moord en brand schreeuwen', 'mort en brant sjréuen', '• [can.] De buren schreeuwen moord en brand. — Los vecinos ponen el grito en el cielo.
• [perf.] Toen hij de rekening zag, heeft hij moord en brand geschreeuwd. — Cuando vio la cuenta, puso el grito en el cielo.
• [imperf.] Mijn moeder schreeuwde moord en brand. — Mi madre puso el grito en el cielo.
• [bijzin] Ik wist dat je moord en brand zou schreeuwen. — Sabía que pondrías el grito en el cielo.
• [vraag] Waarom schreeuw je moord en brand? — ¿Por qué pones el grito en el cielo?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Los vecinos ponen el grito en el cielo.', 'SENTENCE', 'Ejemplo de "moord en brand schreeuwen" (can.)', 'MOORD EN BRAND SCHREEUWEN = poner el grito en el cielo, protestar de forma exagerada.

🧩 Expresión fija — moord en brand schreeuwen:

• literal — gritar asesinato e incendio.
• significa — protestar de forma exagerada.
• piezas fijas — moord en brand sin artículos; schreeuwen es débil, geschreeuwd con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | De buren schreeuwen moord en brand. | Los vecinos ponen el grito en el cielo. |
| 2 | perfecto | Toen hij de rekening zag, heeft hij moord en brand geschreeuwd. | Cuando vio la cuenta, puso el grito en el cielo. |
| 3 | imperfecto | Mijn moeder schreeuwde moord en brand. | Mi madre puso el grito en el cielo. |

🎯 En qué contexto se usa:

• quejas exageradas por una factura, una multa, una nota
• vecinos, padres, clientes enfadados
• registro neutro, algo irónico

🔑 El truco que casi nunca falla: en español gritas al cielo, en neerlandés gritas asesinato y fuego.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los vecinos ponen el grito en el cielo.' AND notes = 'Ejemplo de "moord en brand schreeuwen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Los vecinos ponen el grito en el cielo.' AND notes = 'Ejemplo de "moord en brand schreeuwen" (can.)' LIMIT 1), 'nl_NL', 'De buren schreeuwen moord en brand.', 'de büren sjreöuen mort en brant', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'poner el grito en el cielo' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Los vecinos ponen el grito en el cielo.' AND notes = 'Ejemplo de "moord en brand schreeuwen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'poner el grito en el cielo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'poner el grito en el cielo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Los vecinos ponen el grito en el cielo.' AND notes = 'Ejemplo de "moord en brand schreeuwen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Los vecinos ponen el grito en el cielo.' AND notes = 'Ejemplo de "moord en brand schreeuwen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 062. hacerse el sueco → Oost-Indisch doof zijn
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hacerse el sueco', 'PHRASE', 'frases hechas: Oost-Indisch doof zijn', 'OOST-INDISCH DOOF ZIJN = hacerse el sueco, fingir que no se oye o no se entiende.

🧩 Expresión fija — Oost-Indisch doof zijn:

• literal — estar sordo de las Indias Orientales.
• significa — fingir que no se oye o no se entiende.
• piezas fijas — Oost-Indisch con mayúscula y guion; zijn se conjuga.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij is Oost-Indisch doof. | Se hace el sueco. |
| 2 | imperfecto | Als ik om hulp vroeg, was hij Oost-Indisch doof. | Cuando pedía ayuda, se hacía el sueco. |
| 3 | perfecto | De gemeente is Oost-Indisch doof geweest. | El ayuntamiento se ha hecho el sueco. |

🎯 En qué contexto se usa:

• alguien que ignora una petición a propósito
• hijos que no oyen cuando toca recoger
• registro neutro, con ironía

🔑 El truco que casi nunca falla: el sueco español es un sordo de las Indias en neerlandés.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hacerse el sueco');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'hacerse el sueco' LIMIT 1), 'nl_NL', 'Oost-Indisch doof zijn', 'oost índis doof sein', '• [can.] Hij is Oost-Indisch doof. — Se hace el sueco.
• [imperf.] Als ik om hulp vroeg, was hij Oost-Indisch doof. — Cuando pedía ayuda, se hacía el sueco.
• [perf.] De gemeente is Oost-Indisch doof geweest. — El ayuntamiento se ha hecho el sueco.
• [bijzin] Ik merk dat je Oost-Indisch doof bent. — Noto que te haces el sueco.
• [vraag] Ben je Oost-Indisch doof? — ¿Te haces el sueco?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Se hace el sueco.', 'SENTENCE', 'Ejemplo de "Oost-Indisch doof zijn" (can.)', 'OOST-INDISCH DOOF ZIJN = hacerse el sueco, fingir que no se oye o no se entiende.

🧩 Expresión fija — Oost-Indisch doof zijn:

• literal — estar sordo de las Indias Orientales.
• significa — fingir que no se oye o no se entiende.
• piezas fijas — Oost-Indisch con mayúscula y guion; zijn se conjuga.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij is Oost-Indisch doof. | Se hace el sueco. |
| 2 | imperfecto | Als ik om hulp vroeg, was hij Oost-Indisch doof. | Cuando pedía ayuda, se hacía el sueco. |
| 3 | perfecto | De gemeente is Oost-Indisch doof geweest. | El ayuntamiento se ha hecho el sueco. |

🎯 En qué contexto se usa:

• alguien que ignora una petición a propósito
• hijos que no oyen cuando toca recoger
• registro neutro, con ironía

🔑 El truco que casi nunca falla: el sueco español es un sordo de las Indias en neerlandés.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Se hace el sueco.' AND notes = 'Ejemplo de "Oost-Indisch doof zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Se hace el sueco.' AND notes = 'Ejemplo de "Oost-Indisch doof zijn" (can.)' LIMIT 1), 'nl_NL', 'Hij is Oost-Indisch doof.', 'hei is ost-indisj dof', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'hacerse el sueco' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Se hace el sueco.' AND notes = 'Ejemplo de "Oost-Indisch doof zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hacerse el sueco' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hacerse el sueco' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Se hace el sueco.' AND notes = 'Ejemplo de "Oost-Indisch doof zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Se hace el sueco.' AND notes = 'Ejemplo de "Oost-Indisch doof zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 063. hablando del rey de Roma → als je het over de duivel hebt
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hablando del rey de Roma', 'PHRASE', 'frases hechas: als je het over de duivel hebt', 'ALS JE HET OVER DE DUIVEL HEBT = hablando del rey de Roma, aparece justo la persona de la que se hablaba.

🧩 Expresión fija — als je het over de duivel hebt:

• literal — si hablas del diablo.
• significa — aparece justo la persona de la que se hablaba.
• piezas fijas — het hebben over, hablar de; la frase completa sigue con trap je op zijn staart, le pisas la cola.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Als je het over de duivel hebt, trap je op zijn staart. | Hablando del rey de Roma, por la puerta asoma. |
| 2 | principal | Daar is Jan, als je het over de duivel hebt. | Ahí está Jan, hablando del rey de Roma. |
| 3 | perfecto | Kijk wie er binnen is gekomen, als je het over de duivel hebt. | Mira quién ha entrado, hablando del rey de Roma. |

🎯 En qué contexto se usa:

• cuando entra la persona de la que estabais hablando
• tono de broma, entre amigos y compañeros
• se dice a menudo solo la primera mitad

🔑 El truco que casi nunca falla: en neerlandés no es un rey, es el diablo, y le pisas la cola.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hablando del rey de Roma');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'hablando del rey de Roma' LIMIT 1), 'nl_NL', 'als je het over de duivel hebt', 'als ie et ófer de dóifel hept', '• [uitdr.] Als je het over de duivel hebt, trap je op zijn staart. — Hablando del rey de Roma, por la puerta asoma.
• [can.] Daar is Jan, als je het over de duivel hebt. — Ahí está Jan, hablando del rey de Roma.
• [perf.] Kijk wie er binnen is gekomen, als je het over de duivel hebt. — Mira quién ha entrado, hablando del rey de Roma.
• [imperf.] We hadden het net over haar en toen kwam ze binnen. — Justo hablábamos de ella y entonces entró.
• [vraag] Als je het over de duivel hebt, hè? — Hablando del rey de Roma, ¿eh?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Hablando del rey de Roma, por la puerta asoma.', 'SENTENCE', 'Ejemplo de "als je het over de duivel hebt" (uitdr.)', 'ALS JE HET OVER DE DUIVEL HEBT = hablando del rey de Roma, aparece justo la persona de la que se hablaba.

🧩 Expresión fija — als je het over de duivel hebt:

• literal — si hablas del diablo.
• significa — aparece justo la persona de la que se hablaba.
• piezas fijas — het hebben over, hablar de; la frase completa sigue con trap je op zijn staart, le pisas la cola.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Als je het over de duivel hebt, trap je op zijn staart. | Hablando del rey de Roma, por la puerta asoma. |
| 2 | principal | Daar is Jan, als je het over de duivel hebt. | Ahí está Jan, hablando del rey de Roma. |
| 3 | perfecto | Kijk wie er binnen is gekomen, als je het over de duivel hebt. | Mira quién ha entrado, hablando del rey de Roma. |

🎯 En qué contexto se usa:

• cuando entra la persona de la que estabais hablando
• tono de broma, entre amigos y compañeros
• se dice a menudo solo la primera mitad

🔑 El truco que casi nunca falla: en neerlandés no es un rey, es el diablo, y le pisas la cola.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Hablando del rey de Roma, por la puerta asoma.' AND notes = 'Ejemplo de "als je het over de duivel hebt" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Hablando del rey de Roma, por la puerta asoma.' AND notes = 'Ejemplo de "als je het over de duivel hebt" (uitdr.)' LIMIT 1), 'nl_NL', 'Als je het over de duivel hebt, trap je op zijn staart.', 'als ie het ofer de döifel hebt, trap ie op sein staart', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'hablando del rey de Roma' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Hablando del rey de Roma, por la puerta asoma.' AND notes = 'Ejemplo de "als je het over de duivel hebt" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hablando del rey de Roma' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hablando del rey de Roma' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hablando del rey de Roma, por la puerta asoma.' AND notes = 'Ejemplo de "als je het over de duivel hebt" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hablando del rey de Roma, por la puerta asoma.' AND notes = 'Ejemplo de "als je het over de duivel hebt" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 064. aquí hay gato encerrado → er zit een luchtje aan
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'aquí hay gato encerrado', 'PHRASE', 'frases hechas: er zit een luchtje aan', 'ER ZIT EEN LUCHTJE AAN = aquí hay gato encerrado, algo es sospechoso.

🧩 Expresión fija — er zit een luchtje aan:

• literal — tiene un olorcillo pegado.
• significa — algo es sospechoso.
• piezas fijas — er … aan, y con la cosa nombrada aan iets, Er zit een luchtje aan die deal; het luchtje en diminutivo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Er zit een luchtje aan. | Aquí hay gato encerrado. |
| 2 | imperfecto | Er zat een luchtje aan die aanbieding. | Esa oferta tenía gato encerrado. |
| 3 | subordinada | Ik denk dat er een luchtje aan zit. | Creo que aquí hay gato encerrado. |

🎯 En qué contexto se usa:

• sospechar de un negocio, una oferta, una explicación
• registro neutro, también en prensa
• más suave, daar klopt iets niet, ahí hay algo que no cuadra

🔑 El truco que casi nunca falla: en español se esconde un gato, en neerlandés algo huele raro.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'aquí hay gato encerrado');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'aquí hay gato encerrado' LIMIT 1), 'nl_NL', 'er zit een luchtje aan', 'er sit en lújtie áan', '• [can.] Er zit een luchtje aan. — Aquí hay gato encerrado.
• [imperf.] Er zat een luchtje aan die aanbieding. — Esa oferta tenía gato encerrado.
• [bijzin] Ik denk dat er een luchtje aan zit. — Creo que aquí hay gato encerrado.
• [vraag] Zit er een luchtje aan? — ¿Hay gato encerrado?
• [uitdr.] Daar klopt iets niet. — Ahí hay algo que no cuadra.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Aquí hay gato encerrado.', 'SENTENCE', 'Ejemplo de "er zit een luchtje aan" (can.)', 'ER ZIT EEN LUCHTJE AAN = aquí hay gato encerrado, algo es sospechoso.

🧩 Expresión fija — er zit een luchtje aan:

• literal — tiene un olorcillo pegado.
• significa — algo es sospechoso.
• piezas fijas — er … aan, y con la cosa nombrada aan iets, Er zit een luchtje aan die deal; het luchtje en diminutivo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Er zit een luchtje aan. | Aquí hay gato encerrado. |
| 2 | imperfecto | Er zat een luchtje aan die aanbieding. | Esa oferta tenía gato encerrado. |
| 3 | subordinada | Ik denk dat er een luchtje aan zit. | Creo que aquí hay gato encerrado. |

🎯 En qué contexto se usa:

• sospechar de un negocio, una oferta, una explicación
• registro neutro, también en prensa
• más suave, daar klopt iets niet, ahí hay algo que no cuadra

🔑 El truco que casi nunca falla: en español se esconde un gato, en neerlandés algo huele raro.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Aquí hay gato encerrado.' AND notes = 'Ejemplo de "er zit een luchtje aan" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí hay gato encerrado.' AND notes = 'Ejemplo de "er zit een luchtje aan" (can.)' LIMIT 1), 'nl_NL', 'Er zit een luchtje aan.', 'er sit en lüjtie aan', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'aquí hay gato encerrado' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Aquí hay gato encerrado.' AND notes = 'Ejemplo de "er zit een luchtje aan" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'aquí hay gato encerrado' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'aquí hay gato encerrado' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí hay gato encerrado.' AND notes = 'Ejemplo de "er zit een luchtje aan" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí hay gato encerrado.' AND notes = 'Ejemplo de "er zit een luchtje aan" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 065. verlo todo de color de rosa → door een roze bril kijken
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'verlo todo de color de rosa', 'PHRASE', 'frases hechas: door een roze bril kijken', 'DOOR EEN ROZE BRIL KIJKEN = verlo todo de color de rosa, ser demasiado optimista, idealizar.

🧩 Expresión fija — door een roze bril kijken:

• literal — mirar a través de unas gafas rosas.
• significa — ser demasiado optimista, idealizar.
• piezas fijas — de bril con een; roze no lleva -e extra; kijken es fuerte, keek, gekeken.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je kijkt door een roze bril. | Lo ves todo de color de rosa. |
| 2 | imperfecto | Toen ik verliefd was, keek ik door een roze bril. | Cuando estaba enamorado, lo veía todo de color de rosa. |
| 3 | perfecto | Hij heeft altijd door een roze bril gekeken. | Siempre lo ha visto todo de color de rosa. |

🎯 En qué contexto se usa:

• enamorados, gente recién llegada a un trabajo o a un país
• advertencia, Kijk niet door een roze bril
• registro neutro

🔑 El truco que casi nunca falla: el color de rosa es un par de gafas, de bril.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'verlo todo de color de rosa');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'verlo todo de color de rosa' LIMIT 1), 'nl_NL', 'door een roze bril kijken', 'door en róse bril kéiken', '• [can.] Je kijkt door een roze bril. — Lo ves todo de color de rosa.
• [imperf.] Toen ik verliefd was, keek ik door een roze bril. — Cuando estaba enamorado, lo veía todo de color de rosa.
• [perf.] Hij heeft altijd door een roze bril gekeken. — Siempre lo ha visto todo de color de rosa.
• [bijzin] Het probleem is dat ze door een roze bril kijkt. — El problema es que lo ve todo de color de rosa.
• [geb.] Kijk niet door een roze bril. — No lo veas todo de color de rosa.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Lo ves todo de color de rosa.', 'SENTENCE', 'Ejemplo de "door een roze bril kijken" (can.)', 'DOOR EEN ROZE BRIL KIJKEN = verlo todo de color de rosa, ser demasiado optimista, idealizar.

🧩 Expresión fija — door een roze bril kijken:

• literal — mirar a través de unas gafas rosas.
• significa — ser demasiado optimista, idealizar.
• piezas fijas — de bril con een; roze no lleva -e extra; kijken es fuerte, keek, gekeken.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je kijkt door een roze bril. | Lo ves todo de color de rosa. |
| 2 | imperfecto | Toen ik verliefd was, keek ik door een roze bril. | Cuando estaba enamorado, lo veía todo de color de rosa. |
| 3 | perfecto | Hij heeft altijd door een roze bril gekeken. | Siempre lo ha visto todo de color de rosa. |

🎯 En qué contexto se usa:

• enamorados, gente recién llegada a un trabajo o a un país
• advertencia, Kijk niet door een roze bril
• registro neutro

🔑 El truco que casi nunca falla: el color de rosa es un par de gafas, de bril.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Lo ves todo de color de rosa.' AND notes = 'Ejemplo de "door een roze bril kijken" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo ves todo de color de rosa.' AND notes = 'Ejemplo de "door een roze bril kijken" (can.)' LIMIT 1), 'nl_NL', 'Je kijkt door een roze bril.', 'ie keikt dor en rose bril', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'verlo todo de color de rosa' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Lo ves todo de color de rosa.' AND notes = 'Ejemplo de "door een roze bril kijken" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'verlo todo de color de rosa' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'verlo todo de color de rosa' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo ves todo de color de rosa.' AND notes = 'Ejemplo de "door een roze bril kijken" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo ves todo de color de rosa.' AND notes = 'Ejemplo de "door een roze bril kijken" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 066. pagar el pato → de klos zijn
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pagar el pato', 'PHRASE', 'frases hechas: de klos zijn', 'DE KLOS ZIJN = pagar el pato, cargar con la culpa o el castigo de algo.

🧩 Expresión fija — de klos zijn:

• literal — ser el carrete.
• significa — cargar con la culpa o el castigo de algo.
• piezas fijas — de klos siempre con de y con zijn.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben altijd de klos. | Siempre pago yo el pato. |
| 2 | perfecto | De stagiair is de klos geweest. | El becario ha pagado el pato. |
| 3 | imperfecto | Als er iets kapot was, was ik de klos. | Si algo se rompía, yo pagaba el pato. |

🎯 En qué contexto se usa:

• cuando a uno le cae la culpa de lo que hicieron otros
• trabajo, colegio, familia
• registro coloquial pero neutro

🔑 El truco que casi nunca falla: sin pato y sin pagar, de klos y siempre con zijn.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pagar el pato');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'pagar el pato' LIMIT 1), 'nl_NL', 'de klos zijn', 'de klos sein', '• [can.] Ik ben altijd de klos. — Siempre pago yo el pato.
• [perf.] De stagiair is de klos geweest. — El becario ha pagado el pato.
• [imperf.] Als er iets kapot was, was ik de klos. — Si algo se rompía, yo pagaba el pato.
• [bijzin] Ik wil niet dat jij de klos bent. — No quiero que pagues tú el pato.
• [vraag] Wie is de klos? — ¿Quién paga el pato?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Siempre pago yo el pato.', 'SENTENCE', 'Ejemplo de "de klos zijn" (can.)', 'DE KLOS ZIJN = pagar el pato, cargar con la culpa o el castigo de algo.

🧩 Expresión fija — de klos zijn:

• literal — ser el carrete.
• significa — cargar con la culpa o el castigo de algo.
• piezas fijas — de klos siempre con de y con zijn.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben altijd de klos. | Siempre pago yo el pato. |
| 2 | perfecto | De stagiair is de klos geweest. | El becario ha pagado el pato. |
| 3 | imperfecto | Als er iets kapot was, was ik de klos. | Si algo se rompía, yo pagaba el pato. |

🎯 En qué contexto se usa:

• cuando a uno le cae la culpa de lo que hicieron otros
• trabajo, colegio, familia
• registro coloquial pero neutro

🔑 El truco que casi nunca falla: sin pato y sin pagar, de klos y siempre con zijn.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Siempre pago yo el pato.' AND notes = 'Ejemplo de "de klos zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Siempre pago yo el pato.' AND notes = 'Ejemplo de "de klos zijn" (can.)' LIMIT 1), 'nl_NL', 'Ik ben altijd de klos.', 'ik ben alteit de klos', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'pagar el pato' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Siempre pago yo el pato.' AND notes = 'Ejemplo de "de klos zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pagar el pato' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pagar el pato' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Siempre pago yo el pato.' AND notes = 'Ejemplo de "de klos zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Siempre pago yo el pato.' AND notes = 'Ejemplo de "de klos zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 067. jugarse el cuello → je nek uitsteken
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'jugarse el cuello', 'PHRASE', 'frases hechas: je nek uitsteken', 'JE NEK UITSTEKEN = jugarse el cuello, arriesgarse por alguien o por una idea.

🧩 Expresión fija — je nek uitsteken:

• literal — sacar el cuello.
• significa — arriesgarse por alguien o por una idea.
• piezas fijas — je cambia según el sujeto, mijn, zijn, haar nek; uitsteken es separable y fuerte, stak uit, heeft uitgestoken.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik steek mijn nek niet uit. | Yo no me juego el cuello. |
| 2 | perfecto | Ze heeft haar nek voor mij uitgestoken. | Se ha jugado el cuello por mí. |
| 3 | subordinada | Ik waardeer het dat je je nek uitsteekt. | Valoro que te juegues el cuello. |

🎯 En qué contexto se usa:

• defender a un compañero ante el jefe
• comprometerse con una opinión arriesgada
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés no te lo juegas, sacas el cuello fuera.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'jugarse el cuello');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'jugarse el cuello' LIMIT 1), 'nl_NL', 'je nek uitsteken', 'ie nek öitsteken', '• [can.] Ik steek mijn nek niet uit. — Yo no me juego el cuello.
• [perf.] Ze heeft haar nek voor mij uitgestoken. — Se ha jugado el cuello por mí.
• [bijzin] Ik waardeer het dat je je nek uitsteekt. — Valoro que te juegues el cuello.
• [vraag] Wie durft zijn nek uit te steken? — ¿Quién se atreve a jugarse el cuello?
• [imperf.] Hij stak zijn nek uit voor zijn team. — Se jugó el cuello por su equipo.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Yo no me juego el cuello.', 'SENTENCE', 'Ejemplo de "je nek uitsteken" (can.)', 'JE NEK UITSTEKEN = jugarse el cuello, arriesgarse por alguien o por una idea.

🧩 Expresión fija — je nek uitsteken:

• literal — sacar el cuello.
• significa — arriesgarse por alguien o por una idea.
• piezas fijas — je cambia según el sujeto, mijn, zijn, haar nek; uitsteken es separable y fuerte, stak uit, heeft uitgestoken.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik steek mijn nek niet uit. | Yo no me juego el cuello. |
| 2 | perfecto | Ze heeft haar nek voor mij uitgestoken. | Se ha jugado el cuello por mí. |
| 3 | subordinada | Ik waardeer het dat je je nek uitsteekt. | Valoro que te juegues el cuello. |

🎯 En qué contexto se usa:

• defender a un compañero ante el jefe
• comprometerse con una opinión arriesgada
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés no te lo juegas, sacas el cuello fuera.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Yo no me juego el cuello.' AND notes = 'Ejemplo de "je nek uitsteken" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Yo no me juego el cuello.' AND notes = 'Ejemplo de "je nek uitsteken" (can.)' LIMIT 1), 'nl_NL', 'Ik steek mijn nek niet uit.', 'ik stek mein nek nit öit', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'jugarse el cuello' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Yo no me juego el cuello.' AND notes = 'Ejemplo de "je nek uitsteken" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'jugarse el cuello' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'jugarse el cuello' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Yo no me juego el cuello.' AND notes = 'Ejemplo de "je nek uitsteken" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Yo no me juego el cuello.' AND notes = 'Ejemplo de "je nek uitsteken" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 068. ir de punta en blanco → op je paasbest zijn
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ir de punta en blanco', 'PHRASE', 'frases hechas: op je paasbest zijn', 'OP JE PAASBEST ZIJN = ir de punta en blanco, ir muy bien vestido.

🧩 Expresión fija — op je paasbest zijn:

• literal — estar en tu mejor de Pascua.
• significa — ir muy bien vestido.
• piezas fijas — je cambia según el sujeto, op mijn, op zijn paasbest; het paasbest viene de Pasen, Pascua.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je bent op je paasbest. | Vas de punta en blanco. |
| 2 | imperfecto | Iedereen was op zijn paasbest. | Todo el mundo iba de punta en blanco. |
| 3 | perfecto | Hij heeft zich op zijn paasbest gekleed. | Se ha vestido de punta en blanco. |

🎯 En qué contexto se usa:

• bodas, entrevistas, fiestas
• piropo o broma, Waarom ben je op je paasbest?
• registro neutro

🔑 El truco que casi nunca falla: la mejor ropa del año era la de Pascua, Pasen.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ir de punta en blanco');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ir de punta en blanco' LIMIT 1), 'nl_NL', 'op je paasbest zijn', 'op ie páasbest sein', '• [can.] Je bent op je paasbest. — Vas de punta en blanco.
• [imperf.] Iedereen was op zijn paasbest. — Todo el mundo iba de punta en blanco.
• [perf.] Hij heeft zich op zijn paasbest gekleed. — Se ha vestido de punta en blanco.
• [bijzin] Ik zie dat je op je paasbest bent. — Veo que vas de punta en blanco.
• [vraag] Waarom ben je op je paasbest? — ¿Por qué vas de punta en blanco?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Vas de punta en blanco.', 'SENTENCE', 'Ejemplo de "op je paasbest zijn" (can.)', 'OP JE PAASBEST ZIJN = ir de punta en blanco, ir muy bien vestido.

🧩 Expresión fija — op je paasbest zijn:

• literal — estar en tu mejor de Pascua.
• significa — ir muy bien vestido.
• piezas fijas — je cambia según el sujeto, op mijn, op zijn paasbest; het paasbest viene de Pasen, Pascua.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je bent op je paasbest. | Vas de punta en blanco. |
| 2 | imperfecto | Iedereen was op zijn paasbest. | Todo el mundo iba de punta en blanco. |
| 3 | perfecto | Hij heeft zich op zijn paasbest gekleed. | Se ha vestido de punta en blanco. |

🎯 En qué contexto se usa:

• bodas, entrevistas, fiestas
• piropo o broma, Waarom ben je op je paasbest?
• registro neutro

🔑 El truco que casi nunca falla: la mejor ropa del año era la de Pascua, Pasen.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Vas de punta en blanco.' AND notes = 'Ejemplo de "op je paasbest zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Vas de punta en blanco.' AND notes = 'Ejemplo de "op je paasbest zijn" (can.)' LIMIT 1), 'nl_NL', 'Je bent op je paasbest.', 'ie bent op ie paasbest', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ir de punta en blanco' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Vas de punta en blanco.' AND notes = 'Ejemplo de "op je paasbest zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ir de punta en blanco' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ir de punta en blanco' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vas de punta en blanco.' AND notes = 'Ejemplo de "op je paasbest zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vas de punta en blanco.' AND notes = 'Ejemplo de "op je paasbest zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 069. consultarlo con la almohada → er een nachtje over slapen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'consultarlo con la almohada', 'PHRASE', 'frases hechas: er een nachtje over slapen', 'ER EEN NACHTJE OVER SLAPEN = consultarlo con la almohada, aplazar una decisión hasta el día siguiente.

🧩 Expresión fija — er een nachtje over slapen:

• literal — dormir una nochecita sobre ello.
• significa — aplazar una decisión hasta el día siguiente.
• piezas fijas — er … over, het nachtje con een; slapen es fuerte, sliep, geslapen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik slaap er een nachtje over. | Lo consulto con la almohada. |
| 2 | perfecto | Ik heb er een nachtje over geslapen. | Lo he consultado con la almohada. |
| 3 | imperativo | Slaap er een nachtje over. | Consúltalo con la almohada. |

🎯 En qué contexto se usa:

• ofertas de trabajo, compras grandes, decisiones de pareja
• para ganar tiempo con educación, Mag ik er een nachtje over slapen?
• registro neutro, vale con clientes

🔑 El truco que casi nunca falla: duermes una nochecita encima de la decisión.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'consultarlo con la almohada');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'consultarlo con la almohada' LIMIT 1), 'nl_NL', 'er een nachtje over slapen', 'er en nájtie ófer slápen', '• [can.] Ik slaap er een nachtje over. — Lo consulto con la almohada.
• [perf.] Ik heb er een nachtje over geslapen. — Lo he consultado con la almohada.
• [geb.] Slaap er een nachtje over. — Consúltalo con la almohada.
• [bijzin] Hij zegt dat hij er een nachtje over wil slapen. — Dice que quiere consultarlo con la almohada.
• [vraag] Mag ik er een nachtje over slapen? — ¿Puedo consultarlo con la almohada?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Lo consulto con la almohada.', 'SENTENCE', 'Ejemplo de "er een nachtje over slapen" (can.)', 'ER EEN NACHTJE OVER SLAPEN = consultarlo con la almohada, aplazar una decisión hasta el día siguiente.

🧩 Expresión fija — er een nachtje over slapen:

• literal — dormir una nochecita sobre ello.
• significa — aplazar una decisión hasta el día siguiente.
• piezas fijas — er … over, het nachtje con een; slapen es fuerte, sliep, geslapen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik slaap er een nachtje over. | Lo consulto con la almohada. |
| 2 | perfecto | Ik heb er een nachtje over geslapen. | Lo he consultado con la almohada. |
| 3 | imperativo | Slaap er een nachtje over. | Consúltalo con la almohada. |

🎯 En qué contexto se usa:

• ofertas de trabajo, compras grandes, decisiones de pareja
• para ganar tiempo con educación, Mag ik er een nachtje over slapen?
• registro neutro, vale con clientes

🔑 El truco que casi nunca falla: duermes una nochecita encima de la decisión.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Lo consulto con la almohada.' AND notes = 'Ejemplo de "er een nachtje over slapen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo consulto con la almohada.' AND notes = 'Ejemplo de "er een nachtje over slapen" (can.)' LIMIT 1), 'nl_NL', 'Ik slaap er een nachtje over.', 'ik slaap er en najtie ofer', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'consultarlo con la almohada' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Lo consulto con la almohada.' AND notes = 'Ejemplo de "er een nachtje over slapen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'consultarlo con la almohada' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'consultarlo con la almohada' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo consulto con la almohada.' AND notes = 'Ejemplo de "er een nachtje over slapen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo consulto con la almohada.' AND notes = 'Ejemplo de "er een nachtje over slapen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 070. cortar por lo sano → korte metten maken met
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cortar por lo sano', 'PHRASE', 'frases hechas: korte metten maken met', 'KORTE METTEN MAKEN MET = cortar por lo sano, acabar con algo de forma rápida y drástica.

🧩 Expresión fija — korte metten maken met:

• literal — hacer maitines cortos con.
• significa — acabar con algo de forma rápida y drástica.
• piezas fijas — met + cosa obligatorio; de metten, el rezo de maitines; maken es débil, gemaakt.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | De directeur heeft korte metten gemaakt met de fraude. | El director ha cortado por lo sano con el fraude. |
| 2 | principal | Ik maak korte metten met mijn schulden. | Corto por lo sano con mis deudas. |
| 3 | imperfecto | Mijn moeder maakte korte metten met ruzie. | Mi madre cortaba por lo sano con las peleas. |

🎯 En qué contexto se usa:

• acabar con un problema, una costumbre, un abuso
• directores, gobiernos, padres que dicen basta
• para la decisión difícil, de knoop doorhakken

🔑 El truco que casi nunca falla: met es obligatorio, korte metten maken met iets.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'cortar por lo sano');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'cortar por lo sano' LIMIT 1), 'nl_NL', 'korte metten maken met', 'kórte métten máken met', '• [perf.] De directeur heeft korte metten gemaakt met de fraude. — El director ha cortado por lo sano con el fraude.
• [can.] Ik maak korte metten met mijn schulden. — Corto por lo sano con mis deudas.
• [imperf.] Mijn moeder maakte korte metten met ruzie. — Mi madre cortaba por lo sano con las peleas.
• [bijzin] Het wordt tijd dat we er korte metten mee maken. — Ya es hora de cortar por lo sano con eso.
• [uitdr.] Ik heb de knoop doorgehakt. — Por fin me he decidido.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'El director ha cortado por lo sano con el fraude.', 'SENTENCE', 'Ejemplo de "korte metten maken met" (perf.)', 'KORTE METTEN MAKEN MET = cortar por lo sano, acabar con algo de forma rápida y drástica.

🧩 Expresión fija — korte metten maken met:

• literal — hacer maitines cortos con.
• significa — acabar con algo de forma rápida y drástica.
• piezas fijas — met + cosa obligatorio; de metten, el rezo de maitines; maken es débil, gemaakt.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | De directeur heeft korte metten gemaakt met de fraude. | El director ha cortado por lo sano con el fraude. |
| 2 | principal | Ik maak korte metten met mijn schulden. | Corto por lo sano con mis deudas. |
| 3 | imperfecto | Mijn moeder maakte korte metten met ruzie. | Mi madre cortaba por lo sano con las peleas. |

🎯 En qué contexto se usa:

• acabar con un problema, una costumbre, un abuso
• directores, gobiernos, padres que dicen basta
• para la decisión difícil, de knoop doorhakken

🔑 El truco que casi nunca falla: met es obligatorio, korte metten maken met iets.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El director ha cortado por lo sano con el fraude.' AND notes = 'Ejemplo de "korte metten maken met" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'El director ha cortado por lo sano con el fraude.' AND notes = 'Ejemplo de "korte metten maken met" (perf.)' LIMIT 1), 'nl_NL', 'De directeur heeft korte metten gemaakt met de fraude.', 'de direktör heft korte meten jemaakt met de fraude', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'cortar por lo sano' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'El director ha cortado por lo sano con el fraude.' AND notes = 'Ejemplo de "korte metten maken met" (perf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cortar por lo sano' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cortar por lo sano' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El director ha cortado por lo sano con el fraude.' AND notes = 'Ejemplo de "korte metten maken met" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El director ha cortado por lo sano con el fraude.' AND notes = 'Ejemplo de "korte metten maken met" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 071. vender la piel del oso antes de cazarlo → de huid niet verkopen voordat de beer geschoten is
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'vender la piel del oso antes de cazarlo', 'PHRASE', 'frases hechas: de huid niet verkopen voordat de beer geschoten is', 'DE HUID NIET VERKOPEN VOORDAT DE BEER GESCHOTEN IS = vender la piel del oso antes de cazarlo, no dar algo por hecho antes de tiempo.

🧩 Expresión fija — de huid niet verkopen voordat de beer geschoten is:

• literal — no vender la piel antes de que el oso esté cazado.
• significa — no dar algo por hecho antes de tiempo.
• piezas fijas — de huid, de beer; la segunda mitad en pasiva, geschoten is; verkopen sin ge-.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Je moet de huid niet verkopen voordat de beer geschoten is. | No hay que vender la piel del oso antes de cazarlo. |
| 2 | principal | Hij verkoopt de huid al voordat de beer geschoten is. | Ya vende la piel del oso antes de cazarlo. |
| 3 | imperfecto | Ze verkocht de huid voordat de beer geschoten was. | Vendió la piel del oso antes de cazarlo. |

🎯 En qué contexto se usa:

• celebrar antes de tiempo, un partido, un contrato
• advertir a alguien demasiado confiado
• más corto, Juich niet te vroeg

🔑 El truco que casi nunca falla: idéntico al español, con la segunda mitad en pasiva.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'vender la piel del oso antes de cazarlo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'vender la piel del oso antes de cazarlo' LIMIT 1), 'nl_NL', 'de huid niet verkopen voordat de beer geschoten is', 'de höit nit ferkópen fóordat de beer jesjóten is', '• [geb.] Je moet de huid niet verkopen voordat de beer geschoten is. — No hay que vender la piel del oso antes de cazarlo.
• [can.] Hij verkoopt de huid al voordat de beer geschoten is. — Ya vende la piel del oso antes de cazarlo.
• [imperf.] Ze verkocht de huid voordat de beer geschoten was. — Vendió la piel del oso antes de cazarlo.
• [bijzin] Ik zeg alleen dat je de huid niet moet verkopen voordat de beer geschoten is. — Solo digo que no hay que vender la piel del oso antes de cazarlo.
• [geb.] Juich niet te vroeg. — No cantes victoria antes de tiempo.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No hay que vender la piel del oso antes de cazarlo.', 'SENTENCE', 'Ejemplo de "de huid niet verkopen voordat de beer geschoten is" (geb.)', 'DE HUID NIET VERKOPEN VOORDAT DE BEER GESCHOTEN IS = vender la piel del oso antes de cazarlo, no dar algo por hecho antes de tiempo.

🧩 Expresión fija — de huid niet verkopen voordat de beer geschoten is:

• literal — no vender la piel antes de que el oso esté cazado.
• significa — no dar algo por hecho antes de tiempo.
• piezas fijas — de huid, de beer; la segunda mitad en pasiva, geschoten is; verkopen sin ge-.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Je moet de huid niet verkopen voordat de beer geschoten is. | No hay que vender la piel del oso antes de cazarlo. |
| 2 | principal | Hij verkoopt de huid al voordat de beer geschoten is. | Ya vende la piel del oso antes de cazarlo. |
| 3 | imperfecto | Ze verkocht de huid voordat de beer geschoten was. | Vendió la piel del oso antes de cazarlo. |

🎯 En qué contexto se usa:

• celebrar antes de tiempo, un partido, un contrato
• advertir a alguien demasiado confiado
• más corto, Juich niet te vroeg

🔑 El truco que casi nunca falla: idéntico al español, con la segunda mitad en pasiva.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No hay que vender la piel del oso antes de cazarlo.' AND notes = 'Ejemplo de "de huid niet verkopen voordat de beer geschoten is" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'No hay que vender la piel del oso antes de cazarlo.' AND notes = 'Ejemplo de "de huid niet verkopen voordat de beer geschoten is" (geb.)' LIMIT 1), 'nl_NL', 'Je moet de huid niet verkopen voordat de beer geschoten is.', 'ie mut de höit nit ferkopen fordat de ber jesjoten is', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'vender la piel del oso antes de cazarlo' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No hay que vender la piel del oso antes de cazarlo.' AND notes = 'Ejemplo de "de huid niet verkopen voordat de beer geschoten is" (geb.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'vender la piel del oso antes de cazarlo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'vender la piel del oso antes de cazarlo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No hay que vender la piel del oso antes de cazarlo.' AND notes = 'Ejemplo de "de huid niet verkopen voordat de beer geschoten is" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No hay que vender la piel del oso antes de cazarlo.' AND notes = 'Ejemplo de "de huid niet verkopen voordat de beer geschoten is" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 072. estar con el agua al cuello → het water staat je tot aan de lippen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estar con el agua al cuello', 'PHRASE', 'frases hechas: het water staat je tot aan de lippen', 'HET WATER STAAT JE TOT AAN DE LIPPEN = estar con el agua al cuello, estar en una situación muy apurada.

🧩 Expresión fija — het water staat je tot aan de lippen:

• literal — el agua te llega hasta los labios.
• significa — estar en una situación muy apurada.
• piezas fijas — el sujeto es het water y la persona va en me, je, hem; staan es fuerte, stond, gestaan.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Het water staat me tot aan de lippen. | Estoy con el agua al cuello. |
| 2 | imperfecto | Het water stond hem tot aan de lippen. | Estaba con el agua al cuello. |
| 3 | perfecto | Het water heeft ons maanden tot aan de lippen gestaan. | Hemos estado meses con el agua al cuello. |

🎯 En qué contexto se usa:

• deudas, trabajo acumulado, problemas económicos
• empresas al borde de la quiebra
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés el agua sube un poco más, hasta los labios, y el sujeto es el agua.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estar con el agua al cuello');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'estar con el agua al cuello' LIMIT 1), 'nl_NL', 'het water staat je tot aan de lippen', 'et váter staat ie tot an de lípen', '• [can.] Het water staat me tot aan de lippen. — Estoy con el agua al cuello.
• [imperf.] Het water stond hem tot aan de lippen. — Estaba con el agua al cuello.
• [perf.] Het water heeft ons maanden tot aan de lippen gestaan. — Hemos estado meses con el agua al cuello.
• [bijzin] Ik weet dat het water je tot aan de lippen staat. — Sé que estás con el agua al cuello.
• [vraag] Staat het water je tot aan de lippen? — ¿Estás con el agua al cuello?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Estoy con el agua al cuello.', 'SENTENCE', 'Ejemplo de "het water staat je tot aan de lippen" (can.)', 'HET WATER STAAT JE TOT AAN DE LIPPEN = estar con el agua al cuello, estar en una situación muy apurada.

🧩 Expresión fija — het water staat je tot aan de lippen:

• literal — el agua te llega hasta los labios.
• significa — estar en una situación muy apurada.
• piezas fijas — el sujeto es het water y la persona va en me, je, hem; staan es fuerte, stond, gestaan.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Het water staat me tot aan de lippen. | Estoy con el agua al cuello. |
| 2 | imperfecto | Het water stond hem tot aan de lippen. | Estaba con el agua al cuello. |
| 3 | perfecto | Het water heeft ons maanden tot aan de lippen gestaan. | Hemos estado meses con el agua al cuello. |

🎯 En qué contexto se usa:

• deudas, trabajo acumulado, problemas económicos
• empresas al borde de la quiebra
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés el agua sube un poco más, hasta los labios, y el sujeto es el agua.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Estoy con el agua al cuello.' AND notes = 'Ejemplo de "het water staat je tot aan de lippen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy con el agua al cuello.' AND notes = 'Ejemplo de "het water staat je tot aan de lippen" (can.)' LIMIT 1), 'nl_NL', 'Het water staat me tot aan de lippen.', 'het vater staat me tot aan de lipen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'estar con el agua al cuello' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Estoy con el agua al cuello.' AND notes = 'Ejemplo de "het water staat je tot aan de lippen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar con el agua al cuello' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar con el agua al cuello' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy con el agua al cuello.' AND notes = 'Ejemplo de "het water staat je tot aan de lippen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy con el agua al cuello.' AND notes = 'Ejemplo de "het water staat je tot aan de lippen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 073. dar la lata → aan iemands kop zeuren
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'dar la lata', 'PHRASE', 'frases hechas: aan iemands kop zeuren', 'AAN IEMANDS KOP ZEUREN = dar la lata, insistir de forma pesada.

🧩 Expresión fija — aan iemands kop zeuren:

• literal — dar la tabarra en la cabeza de alguien.
• significa — insistir de forma pesada.
• piezas fijas — aan + kop con posesivo, aan mijn kop; zeuren es débil, gezeurd; coloquial.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | De kinderen zeuren aan mijn kop. | Los niños me dan la lata. |
| 2 | imperativo | Zeur niet aan mijn kop! | ¡No me des la lata! |
| 3 | perfecto | Hij heeft de hele dag aan mijn kop gezeurd. | Me ha dado la lata todo el día. |

🎯 En qué contexto se usa:

• niños que insisten para conseguir algo
• ⚠️ kop es coloquial, con desconocidos mejor zeuren a secas
• para cortar, Zeur niet aan mijn kop!

🔑 El truco que casi nunca falla: zeuren es dar la tabarra, y se la das en la cabeza del otro.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'dar la lata');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'dar la lata' LIMIT 1), 'nl_NL', 'aan iemands kop zeuren', 'an íemants kop sören', '• [can.] De kinderen zeuren aan mijn kop. — Los niños me dan la lata.
• [geb.] Zeur niet aan mijn kop! — ¡No me des la lata!
• [perf.] Hij heeft de hele dag aan mijn kop gezeurd. — Me ha dado la lata todo el día.
• [bijzin] Ik word gek als je aan mijn kop zeurt. — Me vuelvo loco cuando me das la lata.
• [imperf.] Ze zeurde aan zijn kop over een hond. — Le daba la lata con lo de un perro.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Los niños me dan la lata.', 'SENTENCE', 'Ejemplo de "aan iemands kop zeuren" (can.)', 'AAN IEMANDS KOP ZEUREN = dar la lata, insistir de forma pesada.

🧩 Expresión fija — aan iemands kop zeuren:

• literal — dar la tabarra en la cabeza de alguien.
• significa — insistir de forma pesada.
• piezas fijas — aan + kop con posesivo, aan mijn kop; zeuren es débil, gezeurd; coloquial.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | De kinderen zeuren aan mijn kop. | Los niños me dan la lata. |
| 2 | imperativo | Zeur niet aan mijn kop! | ¡No me des la lata! |
| 3 | perfecto | Hij heeft de hele dag aan mijn kop gezeurd. | Me ha dado la lata todo el día. |

🎯 En qué contexto se usa:

• niños que insisten para conseguir algo
• ⚠️ kop es coloquial, con desconocidos mejor zeuren a secas
• para cortar, Zeur niet aan mijn kop!

🔑 El truco que casi nunca falla: zeuren es dar la tabarra, y se la das en la cabeza del otro.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los niños me dan la lata.' AND notes = 'Ejemplo de "aan iemands kop zeuren" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Los niños me dan la lata.' AND notes = 'Ejemplo de "aan iemands kop zeuren" (can.)' LIMIT 1), 'nl_NL', 'De kinderen zeuren aan mijn kop.', 'de kinderen sören aan mein kop', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'dar la lata' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Los niños me dan la lata.' AND notes = 'Ejemplo de "aan iemands kop zeuren" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'dar la lata' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'dar la lata' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Los niños me dan la lata.' AND notes = 'Ejemplo de "aan iemands kop zeuren" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Los niños me dan la lata.' AND notes = 'Ejemplo de "aan iemands kop zeuren" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 074. poner de los nervios a alguien → iemand op de zenuwen werken
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'poner de los nervios a alguien', 'PHRASE', 'frases hechas: iemand op de zenuwen werken', 'IEMAND OP DE ZENUWEN WERKEN = poner de los nervios a alguien, irritar mucho.

🧩 Expresión fija — iemand op de zenuwen werken:

• literal — trabajarle a alguien en los nervios.
• significa — irritar mucho.
• piezas fijas — la persona es objeto, Hij werkt me op de zenuwen; de zenuwen en plural; werken es débil, gewerkt.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dat geluid werkt me op de zenuwen. | Ese ruido me pone de los nervios. |
| 2 | imperfecto | Mijn collega werkte me op de zenuwen. | Mi compañero me ponía de los nervios. |
| 3 | perfecto | Die man heeft me de hele reis op de zenuwen gewerkt. | Ese hombre me ha puesto de los nervios todo el viaje. |

🎯 En qué contexto se usa:

• ruidos, compañeros pesados, situaciones que irritan
• en pregunta, Werk ik je op de zenuwen?
• registro neutro

🔑 El truco que casi nunca falla: la cosa que molesta trabaja sobre tus nervios.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'poner de los nervios a alguien');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'poner de los nervios a alguien' LIMIT 1), 'nl_NL', 'iemand op de zenuwen werken', 'íemant op de sénuen vérken', '• [can.] Dat geluid werkt me op de zenuwen. — Ese ruido me pone de los nervios.
• [imperf.] Mijn collega werkte me op de zenuwen. — Mi compañero me ponía de los nervios.
• [perf.] Die man heeft me de hele reis op de zenuwen gewerkt. — Ese hombre me ha puesto de los nervios todo el viaje.
• [bijzin] Ik zeg niks omdat het je op de zenuwen werkt. — No digo nada porque te pone de los nervios.
• [vraag] Werk ik je op de zenuwen? — ¿Te pongo de los nervios?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ese ruido me pone de los nervios.', 'SENTENCE', 'Ejemplo de "iemand op de zenuwen werken" (can.)', 'IEMAND OP DE ZENUWEN WERKEN = poner de los nervios a alguien, irritar mucho.

🧩 Expresión fija — iemand op de zenuwen werken:

• literal — trabajarle a alguien en los nervios.
• significa — irritar mucho.
• piezas fijas — la persona es objeto, Hij werkt me op de zenuwen; de zenuwen en plural; werken es débil, gewerkt.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dat geluid werkt me op de zenuwen. | Ese ruido me pone de los nervios. |
| 2 | imperfecto | Mijn collega werkte me op de zenuwen. | Mi compañero me ponía de los nervios. |
| 3 | perfecto | Die man heeft me de hele reis op de zenuwen gewerkt. | Ese hombre me ha puesto de los nervios todo el viaje. |

🎯 En qué contexto se usa:

• ruidos, compañeros pesados, situaciones que irritan
• en pregunta, Werk ik je op de zenuwen?
• registro neutro

🔑 El truco que casi nunca falla: la cosa que molesta trabaja sobre tus nervios.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ese ruido me pone de los nervios.' AND notes = 'Ejemplo de "iemand op de zenuwen werken" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Ese ruido me pone de los nervios.' AND notes = 'Ejemplo de "iemand op de zenuwen werken" (can.)' LIMIT 1), 'nl_NL', 'Dat geluid werkt me op de zenuwen.', 'dat jelöit verkt me op de senüuen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'poner de los nervios a alguien' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Ese ruido me pone de los nervios.' AND notes = 'Ejemplo de "iemand op de zenuwen werken" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'poner de los nervios a alguien' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'poner de los nervios a alguien' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ese ruido me pone de los nervios.' AND notes = 'Ejemplo de "iemand op de zenuwen werken" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ese ruido me pone de los nervios.' AND notes = 'Ejemplo de "iemand op de zenuwen werken" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 075. tener enchufe → een kruiwagen hebben
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tener enchufe', 'PHRASE', 'frases hechas: een kruiwagen hebben', 'EEN KRUIWAGEN HEBBEN = tener enchufe, tener contactos que te colocan.

🧩 Expresión fija — een kruiwagen hebben:

• literal — tener una carretilla.
• significa — tener contactos que te colocan.
• piezas fijas — de kruiwagen con een; también via een kruiwagen, por enchufe.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij heeft een kruiwagen. | Tiene enchufe. |
| 2 | perfecto | Ze heeft die baan via een kruiwagen gekregen. | Ha conseguido ese trabajo por enchufe. |
| 3 | subordinada | Iedereen weet dat hij een kruiwagen heeft. | Todo el mundo sabe que tiene enchufe. |

🎯 En qué contexto se usa:

• conseguir trabajo o una plaza por contactos
• crítica o queja, casi nunca elogio
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés no te enchufan, te llevan en carretilla.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'tener enchufe');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'tener enchufe' LIMIT 1), 'nl_NL', 'een kruiwagen hebben', 'en kröiwajen hébben', '• [can.] Hij heeft een kruiwagen. — Tiene enchufe.
• [perf.] Ze heeft die baan via een kruiwagen gekregen. — Ha conseguido ese trabajo por enchufe.
• [bijzin] Iedereen weet dat hij een kruiwagen heeft. — Todo el mundo sabe que tiene enchufe.
• [vraag] Heb je een kruiwagen nodig? — ¿Necesitas enchufe?
• [imperf.] Zonder kruiwagen kwam je er niet in. — Sin enchufe no entrabas.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Tiene enchufe.', 'SENTENCE', 'Ejemplo de "een kruiwagen hebben" (can.)', 'EEN KRUIWAGEN HEBBEN = tener enchufe, tener contactos que te colocan.

🧩 Expresión fija — een kruiwagen hebben:

• literal — tener una carretilla.
• significa — tener contactos que te colocan.
• piezas fijas — de kruiwagen con een; también via een kruiwagen, por enchufe.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij heeft een kruiwagen. | Tiene enchufe. |
| 2 | perfecto | Ze heeft die baan via een kruiwagen gekregen. | Ha conseguido ese trabajo por enchufe. |
| 3 | subordinada | Iedereen weet dat hij een kruiwagen heeft. | Todo el mundo sabe que tiene enchufe. |

🎯 En qué contexto se usa:

• conseguir trabajo o una plaza por contactos
• crítica o queja, casi nunca elogio
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés no te enchufan, te llevan en carretilla.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Tiene enchufe.' AND notes = 'Ejemplo de "een kruiwagen hebben" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Tiene enchufe.' AND notes = 'Ejemplo de "een kruiwagen hebben" (can.)' LIMIT 1), 'nl_NL', 'Hij heeft een kruiwagen.', 'hei heft en kröiuajen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'tener enchufe' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Tiene enchufe.' AND notes = 'Ejemplo de "een kruiwagen hebben" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tener enchufe' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tener enchufe' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tiene enchufe.' AND notes = 'Ejemplo de "een kruiwagen hebben" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tiene enchufe.' AND notes = 'Ejemplo de "een kruiwagen hebben" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 076. hacer su agosto → je slag slaan
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hacer su agosto', 'PHRASE', 'frases hechas: je slag slaan', 'JE SLAG SLAAN = hacer su agosto, sacar mucho beneficio aprovechando una ocasión.

🧩 Expresión fija — je slag slaan:

• literal — dar tu golpe.
• significa — sacar mucho beneficio aprovechando una ocasión.
• piezas fijas — je cambia según el sujeto, zijn, haar, hun slag; slaan es fuerte, sloeg, geslagen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | De winkels slaan hun slag met de uitverkoop. | Las tiendas hacen su agosto con las rebajas. |
| 2 | perfecto | De taxi''s hebben tijdens de staking hun slag geslagen. | Los taxis han hecho su agosto durante la huelga. |
| 3 | imperfecto | Hij sloeg zijn slag met de verkoop van paraplu''s. | Hizo su agosto vendiendo paraguas. |

🎯 En qué contexto se usa:

• negocios que aprovechan una ocasión, rebajas, huelgas, olas de calor
• registro neutro, sale en prensa
• a veces con crítica de oportunismo

🔑 El truco que casi nunca falla: en neerlandés no hay mes, hay un golpe a tiempo.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hacer su agosto');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'hacer su agosto' LIMIT 1), 'nl_NL', 'je slag slaan', 'ie slaj slaan', '• [can.] De winkels slaan hun slag met de uitverkoop. — Las tiendas hacen su agosto con las rebajas.
• [perf.] De taxi''s hebben tijdens de staking hun slag geslagen. — Los taxis han hecho su agosto durante la huelga.
• [imperf.] Hij sloeg zijn slag met de verkoop van paraplu''s. — Hizo su agosto vendiendo paraguas.
• [bijzin] Ik zie dat je je slag slaat. — Veo que haces tu agosto.
• [vraag] Wie slaat er zijn slag? — ¿Quién hace su agosto?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Las tiendas hacen su agosto con las rebajas.', 'SENTENCE', 'Ejemplo de "je slag slaan" (can.)', 'JE SLAG SLAAN = hacer su agosto, sacar mucho beneficio aprovechando una ocasión.

🧩 Expresión fija — je slag slaan:

• literal — dar tu golpe.
• significa — sacar mucho beneficio aprovechando una ocasión.
• piezas fijas — je cambia según el sujeto, zijn, haar, hun slag; slaan es fuerte, sloeg, geslagen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | De winkels slaan hun slag met de uitverkoop. | Las tiendas hacen su agosto con las rebajas. |
| 2 | perfecto | De taxi''s hebben tijdens de staking hun slag geslagen. | Los taxis han hecho su agosto durante la huelga. |
| 3 | imperfecto | Hij sloeg zijn slag met de verkoop van paraplu''s. | Hizo su agosto vendiendo paraguas. |

🎯 En qué contexto se usa:

• negocios que aprovechan una ocasión, rebajas, huelgas, olas de calor
• registro neutro, sale en prensa
• a veces con crítica de oportunismo

🔑 El truco que casi nunca falla: en neerlandés no hay mes, hay un golpe a tiempo.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Las tiendas hacen su agosto con las rebajas.' AND notes = 'Ejemplo de "je slag slaan" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Las tiendas hacen su agosto con las rebajas.' AND notes = 'Ejemplo de "je slag slaan" (can.)' LIMIT 1), 'nl_NL', 'De winkels slaan hun slag met de uitverkoop.', 'de vinkels slaan hün slaj met de öitferkop', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'hacer su agosto' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Las tiendas hacen su agosto con las rebajas.' AND notes = 'Ejemplo de "je slag slaan" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hacer su agosto' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hacer su agosto' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Las tiendas hacen su agosto con las rebajas.' AND notes = 'Ejemplo de "je slag slaan" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Las tiendas hacen su agosto con las rebajas.' AND notes = 'Ejemplo de "je slag slaan" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 077. venir como anillo al dedo → goed van pas komen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'venir como anillo al dedo', 'PHRASE', 'frases hechas: goed van pas komen', 'GOED VAN PAS KOMEN = venir como anillo al dedo, llegar justo en el momento oportuno.

🧩 Expresión fija — goed van pas komen:

• literal — venir bien a propósito.
• significa — llegar justo en el momento oportuno.
• piezas fijas — van pas fijo; el sujeto es la cosa y la persona en me, je, hem; komen va con zijn.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dat geld komt me goed van pas. | Ese dinero me viene como anillo al dedo. |
| 2 | perfecto | Je hulp is goed van pas gekomen. | Tu ayuda ha venido como anillo al dedo. |
| 3 | imperfecto | De paraplu kwam goed van pas. | El paraguas vino como anillo al dedo. |

🎯 En qué contexto se usa:

• dinero, ayudas, objetos que llegan justo cuando hacen falta
• agradecer, Dat komt goed van pas
• para ropa que sienta perfecta, als gegoten zitten

🔑 El truco que casi nunca falla: van pas es a propósito, y el sujeto es lo que viene bien.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'venir como anillo al dedo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'venir como anillo al dedo' LIMIT 1), 'nl_NL', 'goed van pas komen', 'jut fan pas kómen', '• [can.] Dat geld komt me goed van pas. — Ese dinero me viene como anillo al dedo.
• [perf.] Je hulp is goed van pas gekomen. — Tu ayuda ha venido como anillo al dedo.
• [imperf.] De paraplu kwam goed van pas. — El paraguas vino como anillo al dedo.
• [bijzin] Ik denk dat dit goed van pas komt. — Creo que esto vendrá como anillo al dedo.
• [uitdr.] Die jas zit als gegoten. — Esa chaqueta te queda como un guante.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ese dinero me viene como anillo al dedo.', 'SENTENCE', 'Ejemplo de "goed van pas komen" (can.)', 'GOED VAN PAS KOMEN = venir como anillo al dedo, llegar justo en el momento oportuno.

🧩 Expresión fija — goed van pas komen:

• literal — venir bien a propósito.
• significa — llegar justo en el momento oportuno.
• piezas fijas — van pas fijo; el sujeto es la cosa y la persona en me, je, hem; komen va con zijn.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dat geld komt me goed van pas. | Ese dinero me viene como anillo al dedo. |
| 2 | perfecto | Je hulp is goed van pas gekomen. | Tu ayuda ha venido como anillo al dedo. |
| 3 | imperfecto | De paraplu kwam goed van pas. | El paraguas vino como anillo al dedo. |

🎯 En qué contexto se usa:

• dinero, ayudas, objetos que llegan justo cuando hacen falta
• agradecer, Dat komt goed van pas
• para ropa que sienta perfecta, als gegoten zitten

🔑 El truco que casi nunca falla: van pas es a propósito, y el sujeto es lo que viene bien.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ese dinero me viene como anillo al dedo.' AND notes = 'Ejemplo de "goed van pas komen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Ese dinero me viene como anillo al dedo.' AND notes = 'Ejemplo de "goed van pas komen" (can.)' LIMIT 1), 'nl_NL', 'Dat geld komt me goed van pas.', 'dat jelt komt me jut fan pas', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'venir como anillo al dedo' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Ese dinero me viene como anillo al dedo.' AND notes = 'Ejemplo de "goed van pas komen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'venir como anillo al dedo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'venir como anillo al dedo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ese dinero me viene como anillo al dedo.' AND notes = 'Ejemplo de "goed van pas komen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ese dinero me viene como anillo al dedo.' AND notes = 'Ejemplo de "goed van pas komen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 078. ser harina de otro costal → dat is andere koek
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ser harina de otro costal', 'PHRASE', 'frases hechas: dat is andere koek', 'DAT IS ANDERE KOEK = ser harina de otro costal, eso es otra cosa, más difícil o distinta.

🧩 Expresión fija — dat is andere koek:

• literal — eso es otro bizcocho.
• significa — eso es otra cosa, más difícil o distinta.
• piezas fijas — de koek sin artículo detrás de andere; casi siempre con dat is.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Dat is andere koek. | Eso es harina de otro costal. |
| 2 | principal | Fietsen is makkelijk, maar autorijden is andere koek. | Ir en bici es fácil, pero conducir es harina de otro costal. |
| 3 | imperfecto | Het examen was andere koek. | El examen era harina de otro costal. |

🎯 En qué contexto se usa:

• pasar de algo fácil a algo difícil
• registro coloquial pero neutro
• más neutro, dat is een ander verhaal

🔑 El truco que casi nunca falla: la harina española ya está horneada en neerlandés, koek.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ser harina de otro costal');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ser harina de otro costal' LIMIT 1), 'nl_NL', 'dat is andere koek', 'dat is ándere kuk', '• [uitdr.] Dat is andere koek. — Eso es harina de otro costal.
• [can.] Fietsen is makkelijk, maar autorijden is andere koek. — Ir en bici es fácil, pero conducir es harina de otro costal.
• [imperf.] Het examen was andere koek. — El examen era harina de otro costal.
• [bijzin] Ik zeg alleen dat dat andere koek is. — Solo digo que eso es harina de otro costal.
• [uitdr.] Dat is een ander verhaal. — Esa es otra historia.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Eso es harina de otro costal.', 'SENTENCE', 'Ejemplo de "dat is andere koek" (uitdr.)', 'DAT IS ANDERE KOEK = ser harina de otro costal, eso es otra cosa, más difícil o distinta.

🧩 Expresión fija — dat is andere koek:

• literal — eso es otro bizcocho.
• significa — eso es otra cosa, más difícil o distinta.
• piezas fijas — de koek sin artículo detrás de andere; casi siempre con dat is.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Dat is andere koek. | Eso es harina de otro costal. |
| 2 | principal | Fietsen is makkelijk, maar autorijden is andere koek. | Ir en bici es fácil, pero conducir es harina de otro costal. |
| 3 | imperfecto | Het examen was andere koek. | El examen era harina de otro costal. |

🎯 En qué contexto se usa:

• pasar de algo fácil a algo difícil
• registro coloquial pero neutro
• más neutro, dat is een ander verhaal

🔑 El truco que casi nunca falla: la harina española ya está horneada en neerlandés, koek.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Eso es harina de otro costal.' AND notes = 'Ejemplo de "dat is andere koek" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso es harina de otro costal.' AND notes = 'Ejemplo de "dat is andere koek" (uitdr.)' LIMIT 1), 'nl_NL', 'Dat is andere koek.', 'dat is andere kuk', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ser harina de otro costal' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Eso es harina de otro costal.' AND notes = 'Ejemplo de "dat is andere koek" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ser harina de otro costal' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ser harina de otro costal' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso es harina de otro costal.' AND notes = 'Ejemplo de "dat is andere koek" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso es harina de otro costal.' AND notes = 'Ejemplo de "dat is andere koek" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 079. llevarse como el perro y el gato → als kat en hond leven
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'llevarse como el perro y el gato', 'PHRASE', 'frases hechas: als kat en hond leven', 'ALS KAT EN HOND LEVEN = llevarse como el perro y el gato, pelearse constantemente.

🧩 Expresión fija — als kat en hond leven:

• literal — vivir como gato y perro.
• significa — pelearse constantemente.
• piezas fijas — kat en hond sin artículos y en este orden; leven es débil, geleefd.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Mijn broers leven als kat en hond. | Mis hermanos se llevan como el perro y el gato. |
| 2 | imperfecto | Vroeger leefden mijn ouders als kat en hond. | Antes mis padres se llevaban como el perro y el gato. |
| 3 | perfecto | Ze hebben jaren als kat en hond geleefd. | Se han llevado años como el perro y el gato. |

🎯 En qué contexto se usa:

• hermanos, vecinos, parejas que discuten siempre
• registro neutro, con humor
• también met elkaar overhoop liggen, estar a la gresca

🔑 El truco que casi nunca falla: el orden se invierte, primero el gato y luego el perro.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'llevarse como el perro y el gato');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'llevarse como el perro y el gato' LIMIT 1), 'nl_NL', 'als kat en hond leven', 'als kat en hont léfen', '• [can.] Mijn broers leven als kat en hond. — Mis hermanos se llevan como el perro y el gato.
• [imperf.] Vroeger leefden mijn ouders als kat en hond. — Antes mis padres se llevaban como el perro y el gato.
• [perf.] Ze hebben jaren als kat en hond geleefd. — Se han llevado años como el perro y el gato.
• [bijzin] Ik snap niet waarom jullie als kat en hond leven. — No entiendo por qué os lleváis como el perro y el gato.
• [vraag] Leven jullie als kat en hond? — ¿Os lleváis como el perro y el gato?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Mis hermanos se llevan como el perro y el gato.', 'SENTENCE', 'Ejemplo de "als kat en hond leven" (can.)', 'ALS KAT EN HOND LEVEN = llevarse como el perro y el gato, pelearse constantemente.

🧩 Expresión fija — als kat en hond leven:

• literal — vivir como gato y perro.
• significa — pelearse constantemente.
• piezas fijas — kat en hond sin artículos y en este orden; leven es débil, geleefd.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Mijn broers leven als kat en hond. | Mis hermanos se llevan como el perro y el gato. |
| 2 | imperfecto | Vroeger leefden mijn ouders als kat en hond. | Antes mis padres se llevaban como el perro y el gato. |
| 3 | perfecto | Ze hebben jaren als kat en hond geleefd. | Se han llevado años como el perro y el gato. |

🎯 En qué contexto se usa:

• hermanos, vecinos, parejas que discuten siempre
• registro neutro, con humor
• también met elkaar overhoop liggen, estar a la gresca

🔑 El truco que casi nunca falla: el orden se invierte, primero el gato y luego el perro.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mis hermanos se llevan como el perro y el gato.' AND notes = 'Ejemplo de "als kat en hond leven" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Mis hermanos se llevan como el perro y el gato.' AND notes = 'Ejemplo de "als kat en hond leven" (can.)' LIMIT 1), 'nl_NL', 'Mijn broers leven als kat en hond.', 'mein brurs lefen als kat en hont', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'llevarse como el perro y el gato' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mis hermanos se llevan como el perro y el gato.' AND notes = 'Ejemplo de "als kat en hond leven" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'llevarse como el perro y el gato' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'llevarse como el perro y el gato' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mis hermanos se llevan como el perro y el gato.' AND notes = 'Ejemplo de "als kat en hond leven" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mis hermanos se llevan como el perro y el gato.' AND notes = 'Ejemplo de "als kat en hond leven" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 080. quedarse de piedra → met stomheid geslagen zijn
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'quedarse de piedra', 'PHRASE', 'frases hechas: met stomheid geslagen zijn', 'MET STOMHEID GESLAGEN ZIJN = quedarse de piedra, quedarse sin reacción por la sorpresa.

🧩 Expresión fija — met stomheid geslagen zijn:

• literal — estar golpeado de mudez.
• significa — quedarse sin reacción por la sorpresa.
• piezas fijas — de stomheid, la mudez; geslagen es participio de slaan y va con zijn.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperfecto | Ik was met stomheid geslagen. | Me quedé de piedra. |
| 2 | principal | Iedereen is met stomheid geslagen. | Todo el mundo se queda de piedra. |
| 3 | subordinada | Ik zag dat hij met stomheid geslagen was. | Vi que se había quedado de piedra. |

🎯 En qué contexto se usa:

• noticias inesperadas, buenas o malas
• registro neutro, algo literario
• más coloquial, met de mond vol tanden staan, quedarse sin palabras

🔑 El truco que casi nunca falla: en neerlandés no eres piedra, te quedas mudo de golpe.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'quedarse de piedra');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'quedarse de piedra' LIMIT 1), 'nl_NL', 'met stomheid geslagen zijn', 'met stómheit jesláyen sein', '• [imperf.] Ik was met stomheid geslagen. — Me quedé de piedra.
• [can.] Iedereen is met stomheid geslagen. — Todo el mundo se queda de piedra.
• [bijzin] Ik zag dat hij met stomheid geslagen was. — Vi que se había quedado de piedra.
• [uitdr.] Ze stond met de mond vol tanden. — Se quedó sin palabras.
• [vraag] Was je niet met stomheid geslagen? — ¿No te quedaste de piedra?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me quedé de piedra.', 'SENTENCE', 'Ejemplo de "met stomheid geslagen zijn" (imperf.)', 'MET STOMHEID GESLAGEN ZIJN = quedarse de piedra, quedarse sin reacción por la sorpresa.

🧩 Expresión fija — met stomheid geslagen zijn:

• literal — estar golpeado de mudez.
• significa — quedarse sin reacción por la sorpresa.
• piezas fijas — de stomheid, la mudez; geslagen es participio de slaan y va con zijn.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperfecto | Ik was met stomheid geslagen. | Me quedé de piedra. |
| 2 | principal | Iedereen is met stomheid geslagen. | Todo el mundo se queda de piedra. |
| 3 | subordinada | Ik zag dat hij met stomheid geslagen was. | Vi que se había quedado de piedra. |

🎯 En qué contexto se usa:

• noticias inesperadas, buenas o malas
• registro neutro, algo literario
• más coloquial, met de mond vol tanden staan, quedarse sin palabras

🔑 El truco que casi nunca falla: en neerlandés no eres piedra, te quedas mudo de golpe.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me quedé de piedra.' AND notes = 'Ejemplo de "met stomheid geslagen zijn" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Me quedé de piedra.' AND notes = 'Ejemplo de "met stomheid geslagen zijn" (imperf.)' LIMIT 1), 'nl_NL', 'Ik was met stomheid geslagen.', 'ik vas met stomheit jeslajen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'quedarse de piedra' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me quedé de piedra.' AND notes = 'Ejemplo de "met stomheid geslagen zijn" (imperf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'quedarse de piedra' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'quedarse de piedra' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me quedé de piedra.' AND notes = 'Ejemplo de "met stomheid geslagen zijn" (imperf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me quedé de piedra.' AND notes = 'Ejemplo de "met stomheid geslagen zijn" (imperf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 081. por si las moscas → voor de zekerheid
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'por si las moscas', 'PHRASE', 'frases hechas: voor de zekerheid', 'VOOR DE ZEKERHEID = por si las moscas, por precaución.

🧩 Expresión fija — voor de zekerheid:

• literal — para la seguridad.
• significa — por precaución.
• piezas fijas — de zekerheid con de; va al final o en medio de la frase.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik neem een paraplu mee, voor de zekerheid. | Me llevo un paraguas, por si las moscas. |
| 2 | perfecto | Ik heb voor de zekerheid een kopie gemaakt. | He hecho una copia por si las moscas. |
| 3 | inversión | Voor de zekerheid belde ik nog een keer. | Por si las moscas llamé otra vez. |

🎯 En qué contexto se usa:

• paraguas, copias de seguridad, llamadas de confirmación
• registro neutro, de uso diario
• como expresión, het zekere voor het onzekere nemen, ir a lo seguro

🔑 El truco que casi nunca falla: las moscas españolas son seguridad neerlandesa, de zekerheid.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'por si las moscas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'por si las moscas' LIMIT 1), 'nl_NL', 'voor de zekerheid', 'foor de sékerheit', '• [can.] Ik neem een paraplu mee, voor de zekerheid. — Me llevo un paraguas, por si las moscas.
• [perf.] Ik heb voor de zekerheid een kopie gemaakt. — He hecho una copia por si las moscas.
• [inv.] Voor de zekerheid belde ik nog een keer. — Por si las moscas llamé otra vez.
• [can.] Ik bel je, voor de zekerheid. — Te llamo, por si las moscas.
• [uitdr.] Ik neem het zekere voor het onzekere. — Voy a lo seguro.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me llevo un paraguas, por si las moscas.', 'SENTENCE', 'Ejemplo de "voor de zekerheid" (can.)', 'VOOR DE ZEKERHEID = por si las moscas, por precaución.

🧩 Expresión fija — voor de zekerheid:

• literal — para la seguridad.
• significa — por precaución.
• piezas fijas — de zekerheid con de; va al final o en medio de la frase.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik neem een paraplu mee, voor de zekerheid. | Me llevo un paraguas, por si las moscas. |
| 2 | perfecto | Ik heb voor de zekerheid een kopie gemaakt. | He hecho una copia por si las moscas. |
| 3 | inversión | Voor de zekerheid belde ik nog een keer. | Por si las moscas llamé otra vez. |

🎯 En qué contexto se usa:

• paraguas, copias de seguridad, llamadas de confirmación
• registro neutro, de uso diario
• como expresión, het zekere voor het onzekere nemen, ir a lo seguro

🔑 El truco que casi nunca falla: las moscas españolas son seguridad neerlandesa, de zekerheid.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me llevo un paraguas, por si las moscas.' AND notes = 'Ejemplo de "voor de zekerheid" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Me llevo un paraguas, por si las moscas.' AND notes = 'Ejemplo de "voor de zekerheid" (can.)' LIMIT 1), 'nl_NL', 'Ik neem een paraplu mee, voor de zekerheid.', 'ik nem en paraplü me, for de sekerheit', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'por si las moscas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me llevo un paraguas, por si las moscas.' AND notes = 'Ejemplo de "voor de zekerheid" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'por si las moscas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'por si las moscas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me llevo un paraguas, por si las moscas.' AND notes = 'Ejemplo de "voor de zekerheid" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me llevo un paraguas, por si las moscas.' AND notes = 'Ejemplo de "voor de zekerheid" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 082. no tener ni pies ni cabeza → kant noch wal raken
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no tener ni pies ni cabeza', 'PHRASE', 'frases hechas: kant noch wal raken', 'KANT NOCH WAL RAKEN = no tener ni pies ni cabeza, ser absurdo, sin sentido.

🧩 Expresión fija — kant noch wal raken:

• literal — no tocar ni la orilla ni el muelle.
• significa — ser absurdo, sin sentido.
• piezas fijas — noch es formal, ni; el sujeto es la cosa, Het verhaal raakt kant noch wal; raken es débil.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dit verhaal raakt kant noch wal. | Esta historia no tiene ni pies ni cabeza. |
| 2 | imperfecto | Zijn uitleg raakte kant noch wal. | Su explicación no tenía ni pies ni cabeza. |
| 3 | subordinada | Ik vind dat het plan kant noch wal raakt. | Me parece que el plan no tiene ni pies ni cabeza. |

🎯 En qué contexto se usa:

• planes, explicaciones o historias absurdas
• registro neutro, también por escrito
• más coloquial, er zit kop noch staart aan

🔑 El truco que casi nunca falla: un barco que no toca ni orilla ni muelle no está en ninguna parte.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no tener ni pies ni cabeza');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener ni pies ni cabeza' LIMIT 1), 'nl_NL', 'kant noch wal raken', 'kant noj val ráken', '• [can.] Dit verhaal raakt kant noch wal. — Esta historia no tiene ni pies ni cabeza.
• [imperf.] Zijn uitleg raakte kant noch wal. — Su explicación no tenía ni pies ni cabeza.
• [bijzin] Ik vind dat het plan kant noch wal raakt. — Me parece que el plan no tiene ni pies ni cabeza.
• [uitdr.] Er zit kop noch staart aan. — No tiene ni pies ni cabeza.
• [perf.] Wat hij heeft gezegd, raakt kant noch wal. — Lo que ha dicho no tiene ni pies ni cabeza.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Esta historia no tiene ni pies ni cabeza.', 'SENTENCE', 'Ejemplo de "kant noch wal raken" (can.)', 'KANT NOCH WAL RAKEN = no tener ni pies ni cabeza, ser absurdo, sin sentido.

🧩 Expresión fija — kant noch wal raken:

• literal — no tocar ni la orilla ni el muelle.
• significa — ser absurdo, sin sentido.
• piezas fijas — noch es formal, ni; el sujeto es la cosa, Het verhaal raakt kant noch wal; raken es débil.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dit verhaal raakt kant noch wal. | Esta historia no tiene ni pies ni cabeza. |
| 2 | imperfecto | Zijn uitleg raakte kant noch wal. | Su explicación no tenía ni pies ni cabeza. |
| 3 | subordinada | Ik vind dat het plan kant noch wal raakt. | Me parece que el plan no tiene ni pies ni cabeza. |

🎯 En qué contexto se usa:

• planes, explicaciones o historias absurdas
• registro neutro, también por escrito
• más coloquial, er zit kop noch staart aan

🔑 El truco que casi nunca falla: un barco que no toca ni orilla ni muelle no está en ninguna parte.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Esta historia no tiene ni pies ni cabeza.' AND notes = 'Ejemplo de "kant noch wal raken" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta historia no tiene ni pies ni cabeza.' AND notes = 'Ejemplo de "kant noch wal raken" (can.)' LIMIT 1), 'nl_NL', 'Dit verhaal raakt kant noch wal.', 'dit ferhaal raakt kant noj val', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener ni pies ni cabeza' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Esta historia no tiene ni pies ni cabeza.' AND notes = 'Ejemplo de "kant noch wal raken" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener ni pies ni cabeza' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener ni pies ni cabeza' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta historia no tiene ni pies ni cabeza.' AND notes = 'Ejemplo de "kant noch wal raken" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esta historia no tiene ni pies ni cabeza.' AND notes = 'Ejemplo de "kant noch wal raken" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 083. de buenas a primeras → zomaar ineens
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'de buenas a primeras', 'PHRASE', 'frases hechas: zomaar ineens', 'ZOMAAR INEENS = de buenas a primeras, de repente y sin aviso.

🧩 Expresión fija — zomaar ineens:

• literal — así sin más, de repente.
• significa — de repente y sin aviso.
• piezas fijas — dos adverbios juntos, zomaar más ineens; van detrás del verbo conjugado.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperfecto | Hij stond zomaar ineens voor de deur. | Se plantó en la puerta de buenas a primeras. |
| 2 | perfecto | Ze is zomaar ineens vertrokken. | Se ha ido de buenas a primeras. |
| 3 | principal | Je kunt niet zomaar ineens stoppen. | No puedes dejarlo de buenas a primeras. |

🎯 En qué contexto se usa:

• cambios repentinos de planes o de humor
• contar algo sorprendente
• también uit het niets, de la nada

🔑 El truco que casi nunca falla: zomaar es porque sí, ineens es de golpe, juntos es sin aviso.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'de buenas a primeras');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'de buenas a primeras' LIMIT 1), 'nl_NL', 'zomaar ineens', 'sómaar inéens', '• [imperf.] Hij stond zomaar ineens voor de deur. — Se plantó en la puerta de buenas a primeras.
• [perf.] Ze is zomaar ineens vertrokken. — Se ha ido de buenas a primeras.
• [can.] Je kunt niet zomaar ineens stoppen. — No puedes dejarlo de buenas a primeras.
• [bijzin] Ik snap niet waarom het zomaar ineens kapot is. — No entiendo por qué se ha roto de buenas a primeras.
• [uitdr.] Het kwam uit het niets. — Salió de la nada.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Se plantó en la puerta de buenas a primeras.', 'SENTENCE', 'Ejemplo de "zomaar ineens" (imperf.)', 'ZOMAAR INEENS = de buenas a primeras, de repente y sin aviso.

🧩 Expresión fija — zomaar ineens:

• literal — así sin más, de repente.
• significa — de repente y sin aviso.
• piezas fijas — dos adverbios juntos, zomaar más ineens; van detrás del verbo conjugado.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperfecto | Hij stond zomaar ineens voor de deur. | Se plantó en la puerta de buenas a primeras. |
| 2 | perfecto | Ze is zomaar ineens vertrokken. | Se ha ido de buenas a primeras. |
| 3 | principal | Je kunt niet zomaar ineens stoppen. | No puedes dejarlo de buenas a primeras. |

🎯 En qué contexto se usa:

• cambios repentinos de planes o de humor
• contar algo sorprendente
• también uit het niets, de la nada

🔑 El truco que casi nunca falla: zomaar es porque sí, ineens es de golpe, juntos es sin aviso.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Se plantó en la puerta de buenas a primeras.' AND notes = 'Ejemplo de "zomaar ineens" (imperf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Se plantó en la puerta de buenas a primeras.' AND notes = 'Ejemplo de "zomaar ineens" (imperf.)' LIMIT 1), 'nl_NL', 'Hij stond zomaar ineens voor de deur.', 'hei stont somaar inens for de dör', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'de buenas a primeras' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Se plantó en la puerta de buenas a primeras.' AND notes = 'Ejemplo de "zomaar ineens" (imperf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'de buenas a primeras' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'de buenas a primeras' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Se plantó en la puerta de buenas a primeras.' AND notes = 'Ejemplo de "zomaar ineens" (imperf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Se plantó en la puerta de buenas a primeras.' AND notes = 'Ejemplo de "zomaar ineens" (imperf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 084. tocar madera → afkloppen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tocar madera', 'PHRASE', 'frases hechas: afkloppen', 'AFKLOPPEN = tocar madera, pedir que no se tuerza la buena suerte.

🧩 Expresión fija — afkloppen:

• literal — golpear para quitar.
• significa — pedir que no se tuerza la buena suerte.
• piezas fijas — separable, klop af, heeft afgeklopt; se golpea la mesa con los nudillos; muy típico con even, even afkloppen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben nog nooit ziek geweest, even afkloppen. | Nunca he estado enfermo, toco madera. |
| 2 | imperativo | Klop het maar af! | ¡Toca madera! |
| 3 | perfecto | Ze heeft drie keer op de tafel afgeklopt. | Ha tocado madera tres veces en la mesa. |

🎯 En qué contexto se usa:

• al hablar de algo bueno, la salud, el trabajo, el coche
• solo como exclamación, Afkloppen!
• registro neutro

🔑 El truco que casi nunca falla: af más kloppen, golpear la madera para quitar la mala suerte.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'tocar madera');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'tocar madera' LIMIT 1), 'nl_NL', 'afkloppen', 'áfkloppen', '• [can.] Ik ben nog nooit ziek geweest, even afkloppen. — Nunca he estado enfermo, toco madera.
• [geb.] Klop het maar af! — ¡Toca madera!
• [perf.] Ze heeft drie keer op de tafel afgeklopt. — Ha tocado madera tres veces en la mesa.
• [bijzin] Hij klopt altijd af als hij iets goeds zegt. — Siempre toca madera cuando dice algo bueno.
• [uitdr.] Afkloppen! — ¡Toco madera!');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Nunca he estado enfermo, toco madera.', 'SENTENCE', 'Ejemplo de "afkloppen" (can.)', 'AFKLOPPEN = tocar madera, pedir que no se tuerza la buena suerte.

🧩 Expresión fija — afkloppen:

• literal — golpear para quitar.
• significa — pedir que no se tuerza la buena suerte.
• piezas fijas — separable, klop af, heeft afgeklopt; se golpea la mesa con los nudillos; muy típico con even, even afkloppen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben nog nooit ziek geweest, even afkloppen. | Nunca he estado enfermo, toco madera. |
| 2 | imperativo | Klop het maar af! | ¡Toca madera! |
| 3 | perfecto | Ze heeft drie keer op de tafel afgeklopt. | Ha tocado madera tres veces en la mesa. |

🎯 En qué contexto se usa:

• al hablar de algo bueno, la salud, el trabajo, el coche
• solo como exclamación, Afkloppen!
• registro neutro

🔑 El truco que casi nunca falla: af más kloppen, golpear la madera para quitar la mala suerte.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Nunca he estado enfermo, toco madera.' AND notes = 'Ejemplo de "afkloppen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Nunca he estado enfermo, toco madera.' AND notes = 'Ejemplo de "afkloppen" (can.)' LIMIT 1), 'nl_NL', 'Ik ben nog nooit ziek geweest, even afkloppen.', 'ik ben noj noit sik jeuest, efen afklopen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'tocar madera' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Nunca he estado enfermo, toco madera.' AND notes = 'Ejemplo de "afkloppen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tocar madera' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'tocar madera' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Nunca he estado enfermo, toco madera.' AND notes = 'Ejemplo de "afkloppen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Nunca he estado enfermo, toco madera.' AND notes = 'Ejemplo de "afkloppen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 085. echar leña al fuego → olie op het vuur gooien
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'echar leña al fuego', 'PHRASE', 'frases hechas: olie op het vuur gooien', 'OLIE OP HET VUUR GOOIEN = echar leña al fuego, empeorar un conflicto.

🧩 Expresión fija — olie op het vuur gooien:

• literal — echar aceite al fuego.
• significa — empeorar un conflicto.
• piezas fijas — de olie sin artículo, op het vuur; gooien es débil, gegooid.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Gooi geen olie op het vuur. | No eches leña al fuego. |
| 2 | principal | Met die opmerking gooi je olie op het vuur. | Con ese comentario echas leña al fuego. |
| 3 | perfecto | De pers heeft olie op het vuur gegooid. | La prensa ha echado leña al fuego. |

🎯 En qué contexto se usa:

• discusiones familiares o de pareja
• política y prensa, comentarios que encienden
• para pedir calma, Gooi geen olie op het vuur

🔑 El truco que casi nunca falla: la leña española es aceite en neerlandés.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'echar leña al fuego');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'echar leña al fuego' LIMIT 1), 'nl_NL', 'olie op het vuur gooien', 'óli op et füür jóien', '• [geb.] Gooi geen olie op het vuur. — No eches leña al fuego.
• [can.] Met die opmerking gooi je olie op het vuur. — Con ese comentario echas leña al fuego.
• [perf.] De pers heeft olie op het vuur gegooid. — La prensa ha echado leña al fuego.
• [bijzin] Ik wil niet dat je olie op het vuur gooit. — No quiero que eches leña al fuego.
• [imperf.] Zijn tweet gooide olie op het vuur. — Su tuit echó leña al fuego.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No eches leña al fuego.', 'SENTENCE', 'Ejemplo de "olie op het vuur gooien" (geb.)', 'OLIE OP HET VUUR GOOIEN = echar leña al fuego, empeorar un conflicto.

🧩 Expresión fija — olie op het vuur gooien:

• literal — echar aceite al fuego.
• significa — empeorar un conflicto.
• piezas fijas — de olie sin artículo, op het vuur; gooien es débil, gegooid.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Gooi geen olie op het vuur. | No eches leña al fuego. |
| 2 | principal | Met die opmerking gooi je olie op het vuur. | Con ese comentario echas leña al fuego. |
| 3 | perfecto | De pers heeft olie op het vuur gegooid. | La prensa ha echado leña al fuego. |

🎯 En qué contexto se usa:

• discusiones familiares o de pareja
• política y prensa, comentarios que encienden
• para pedir calma, Gooi geen olie op het vuur

🔑 El truco que casi nunca falla: la leña española es aceite en neerlandés.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No eches leña al fuego.' AND notes = 'Ejemplo de "olie op het vuur gooien" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'No eches leña al fuego.' AND notes = 'Ejemplo de "olie op het vuur gooien" (geb.)' LIMIT 1), 'nl_NL', 'Gooi geen olie op het vuur.', 'joi jen oli op het für', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'echar leña al fuego' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No eches leña al fuego.' AND notes = 'Ejemplo de "olie op het vuur gooien" (geb.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'echar leña al fuego' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'echar leña al fuego' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No eches leña al fuego.' AND notes = 'Ejemplo de "olie op het vuur gooien" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No eches leña al fuego.' AND notes = 'Ejemplo de "olie op het vuur gooien" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 086. ponerse las botas → zich te goed doen aan
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ponerse las botas', 'PHRASE', 'frases hechas: zich te goed doen aan', 'ZICH TE GOED DOEN AAN = ponerse las botas, comer o disfrutar algo en abundancia.

🧩 Expresión fija — zich te goed doen aan:

• literal — hacerse bien a sí mismo con.
• significa — comer o disfrutar algo en abundancia.
• piezas fijas — zich es reflexivo, me, je, zich; aan + la comida; doen es fuerte, deed, gedaan.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik doe me te goed aan de taart. | Me pongo las botas con la tarta. |
| 2 | perfecto | We hebben ons te goed gedaan aan het buffet. | Nos hemos puesto las botas en el bufé. |
| 3 | imperfecto | De kinderen deden zich te goed aan het snoep. | Los niños se pusieron las botas con las golosinas. |

🎯 En qué contexto se usa:

• comidas abundantes, bufés, celebraciones
• invitar, Doe je te goed!
• registro neutro y educado

🔑 El truco que casi nunca falla: te goed doen es darse un gusto, y aan marca la comida.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ponerse las botas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse las botas' LIMIT 1), 'nl_NL', 'zich te goed doen aan', 'sij te jut dun an', '• [can.] Ik doe me te goed aan de taart. — Me pongo las botas con la tarta.
• [perf.] We hebben ons te goed gedaan aan het buffet. — Nos hemos puesto las botas en el bufé.
• [imperf.] De kinderen deden zich te goed aan het snoep. — Los niños se pusieron las botas con las golosinas.
• [geb.] Doe je te goed! — ¡Ponte las botas!
• [bijzin] Ik zag dat hij zich te goed deed aan de kaas. — Vi que se ponía las botas con el queso.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me pongo las botas con la tarta.', 'SENTENCE', 'Ejemplo de "zich te goed doen aan" (can.)', 'ZICH TE GOED DOEN AAN = ponerse las botas, comer o disfrutar algo en abundancia.

🧩 Expresión fija — zich te goed doen aan:

• literal — hacerse bien a sí mismo con.
• significa — comer o disfrutar algo en abundancia.
• piezas fijas — zich es reflexivo, me, je, zich; aan + la comida; doen es fuerte, deed, gedaan.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik doe me te goed aan de taart. | Me pongo las botas con la tarta. |
| 2 | perfecto | We hebben ons te goed gedaan aan het buffet. | Nos hemos puesto las botas en el bufé. |
| 3 | imperfecto | De kinderen deden zich te goed aan het snoep. | Los niños se pusieron las botas con las golosinas. |

🎯 En qué contexto se usa:

• comidas abundantes, bufés, celebraciones
• invitar, Doe je te goed!
• registro neutro y educado

🔑 El truco que casi nunca falla: te goed doen es darse un gusto, y aan marca la comida.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me pongo las botas con la tarta.' AND notes = 'Ejemplo de "zich te goed doen aan" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Me pongo las botas con la tarta.' AND notes = 'Ejemplo de "zich te goed doen aan" (can.)' LIMIT 1), 'nl_NL', 'Ik doe me te goed aan de taart.', 'ik du me te jut aan de taart', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse las botas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me pongo las botas con la tarta.' AND notes = 'Ejemplo de "zich te goed doen aan" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse las botas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ponerse las botas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me pongo las botas con la tarta.' AND notes = 'Ejemplo de "zich te goed doen aan" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me pongo las botas con la tarta.' AND notes = 'Ejemplo de "zich te goed doen aan" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 087. no tener dos dedos de frente → het buskruit niet uitgevonden hebben
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no tener dos dedos de frente', 'PHRASE', 'frases hechas: het buskruit niet uitgevonden hebben', 'HET BUSKRUIT NIET UITGEVONDEN HEBBEN = no tener dos dedos de frente, ser poco listo.

🧩 Expresión fija — het buskruit niet uitgevonden hebben:

• literal — no haber inventado la pólvora.
• significa — ser poco listo.
• piezas fijas — het buskruit; uitvinden es separable y fuerte, uitgevonden; siempre en perfecto.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij heeft het buskruit niet uitgevonden. | No tiene dos dedos de frente. |
| 2 | imperfecto | Die jongen had het buskruit niet uitgevonden. | Ese chico no tenía dos dedos de frente. |
| 3 | subordinada | Ik denk dat ze het buskruit niet heeft uitgevonden. | Creo que no tiene dos dedos de frente. |

🎯 En qué contexto se usa:

• ⚠️ es ofensivo, solo de broma o a espaldas de alguien
• describir a alguien poco espabilado
• más suave, hij is niet de slimste

🔑 El truco que casi nunca falla: el español también dice no ha inventado la pólvora, y va siempre en perfecto.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no tener dos dedos de frente');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener dos dedos de frente' LIMIT 1), 'nl_NL', 'het buskruit niet uitgevonden hebben', 'et búskröit nit öitjefónden hébben', '• [can.] Hij heeft het buskruit niet uitgevonden. — No tiene dos dedos de frente.
• [imperf.] Die jongen had het buskruit niet uitgevonden. — Ese chico no tenía dos dedos de frente.
• [bijzin] Ik denk dat ze het buskruit niet heeft uitgevonden. — Creo que no tiene dos dedos de frente.
• [uitdr.] Hij is niet de slimste. — No es el más listo.
• [vraag] Heeft hij het buskruit uitgevonden? — ¿Ha inventado la pólvora?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No tiene dos dedos de frente.', 'SENTENCE', 'Ejemplo de "het buskruit niet uitgevonden hebben" (can.)', 'HET BUSKRUIT NIET UITGEVONDEN HEBBEN = no tener dos dedos de frente, ser poco listo.

🧩 Expresión fija — het buskruit niet uitgevonden hebben:

• literal — no haber inventado la pólvora.
• significa — ser poco listo.
• piezas fijas — het buskruit; uitvinden es separable y fuerte, uitgevonden; siempre en perfecto.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij heeft het buskruit niet uitgevonden. | No tiene dos dedos de frente. |
| 2 | imperfecto | Die jongen had het buskruit niet uitgevonden. | Ese chico no tenía dos dedos de frente. |
| 3 | subordinada | Ik denk dat ze het buskruit niet heeft uitgevonden. | Creo que no tiene dos dedos de frente. |

🎯 En qué contexto se usa:

• ⚠️ es ofensivo, solo de broma o a espaldas de alguien
• describir a alguien poco espabilado
• más suave, hij is niet de slimste

🔑 El truco que casi nunca falla: el español también dice no ha inventado la pólvora, y va siempre en perfecto.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No tiene dos dedos de frente.' AND notes = 'Ejemplo de "het buskruit niet uitgevonden hebben" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'No tiene dos dedos de frente.' AND notes = 'Ejemplo de "het buskruit niet uitgevonden hebben" (can.)' LIMIT 1), 'nl_NL', 'Hij heeft het buskruit niet uitgevonden.', 'hei heft het büskröit nit öitjefonden', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener dos dedos de frente' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No tiene dos dedos de frente.' AND notes = 'Ejemplo de "het buskruit niet uitgevonden hebben" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener dos dedos de frente' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no tener dos dedos de frente' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No tiene dos dedos de frente.' AND notes = 'Ejemplo de "het buskruit niet uitgevonden hebben" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No tiene dos dedos de frente.' AND notes = 'Ejemplo de "het buskruit niet uitgevonden hebben" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 088. no nací ayer → niet van gisteren zijn
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no nací ayer', 'PHRASE', 'frases hechas: niet van gisteren zijn', 'NIET VAN GISTEREN ZIJN = no nací ayer, tener experiencia, no dejarse engañar.

🧩 Expresión fija — niet van gisteren zijn:

• literal — no ser de ayer.
• significa — tener experiencia, no dejarse engañar.
• piezas fijas — van gisteren detrás de zijn; se conjuga en presente, Ik ben niet van gisteren.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben niet van gisteren. | No nací ayer. |
| 2 | principal | Ze is niet van gisteren. | Ella no nació ayer. |
| 3 | subordinada | Je weet toch dat ik niet van gisteren ben. | Ya sabes que no nací ayer. |

🎯 En qué contexto se usa:

• cuando intentan engañarte o venderte algo
• con orgullo de tu experiencia
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés no naces, eres de ayer, y va en presente.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no nací ayer');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'no nací ayer' LIMIT 1), 'nl_NL', 'niet van gisteren zijn', 'nit fan jísteren sein', '• [can.] Ik ben niet van gisteren. — No nací ayer.
• [can.] Ze is niet van gisteren. — Ella no nació ayer.
• [bijzin] Je weet toch dat ik niet van gisteren ben. — Ya sabes que no nací ayer.
• [vraag] Denk je dat ik van gisteren ben? — ¿Crees que nací ayer?
• [imperf.] De agent was niet van gisteren. — El policía no había nacido ayer.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No nací ayer.', 'SENTENCE', 'Ejemplo de "niet van gisteren zijn" (can.)', 'NIET VAN GISTEREN ZIJN = no nací ayer, tener experiencia, no dejarse engañar.

🧩 Expresión fija — niet van gisteren zijn:

• literal — no ser de ayer.
• significa — tener experiencia, no dejarse engañar.
• piezas fijas — van gisteren detrás de zijn; se conjuga en presente, Ik ben niet van gisteren.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben niet van gisteren. | No nací ayer. |
| 2 | principal | Ze is niet van gisteren. | Ella no nació ayer. |
| 3 | subordinada | Je weet toch dat ik niet van gisteren ben. | Ya sabes que no nací ayer. |

🎯 En qué contexto se usa:

• cuando intentan engañarte o venderte algo
• con orgullo de tu experiencia
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés no naces, eres de ayer, y va en presente.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No nací ayer.' AND notes = 'Ejemplo de "niet van gisteren zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'No nací ayer.' AND notes = 'Ejemplo de "niet van gisteren zijn" (can.)' LIMIT 1), 'nl_NL', 'Ik ben niet van gisteren.', 'ik ben nit fan jisteren', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'no nací ayer' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No nací ayer.' AND notes = 'Ejemplo de "niet van gisteren zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no nací ayer' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no nací ayer' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No nací ayer.' AND notes = 'Ejemplo de "niet van gisteren zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No nací ayer.' AND notes = 'Ejemplo de "niet van gisteren zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 089. recibir calabazas → een blauwtje lopen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'recibir calabazas', 'PHRASE', 'frases hechas: een blauwtje lopen', 'EEN BLAUWTJE LOPEN = recibir calabazas, ser rechazado en el amor.

🧩 Expresión fija — een blauwtje lopen:

• literal — correr un azulito.
• significa — ser rechazado en el amor.
• piezas fijas — het blauwtje con een; lopen va aquí con hebben, heeft een blauwtje gelopen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Hij heeft een blauwtje gelopen. | Le han dado calabazas. |
| 2 | imperfecto | Ik liep een blauwtje bij haar. | Ella me dio calabazas. |
| 3 | subordinada | Hij is bang dat hij een blauwtje loopt. | Tiene miedo de que le den calabazas. |

🎯 En qué contexto se usa:

• rechazos amorosos, invitaciones que no se aceptan
• contarlo con humor sobre uno mismo
• más neutro, afgewezen worden

🔑 El truco que casi nunca falla: las calabazas españolas son un azulito neerlandés, y se corren.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'recibir calabazas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'recibir calabazas' LIMIT 1), 'nl_NL', 'een blauwtje lopen', 'en bláutie lópen', '• [perf.] Hij heeft een blauwtje gelopen. — Le han dado calabazas.
• [imperf.] Ik liep een blauwtje bij haar. — Ella me dio calabazas.
• [bijzin] Hij is bang dat hij een blauwtje loopt. — Tiene miedo de que le den calabazas.
• [vraag] Heb je een blauwtje gelopen? — ¿Te han dado calabazas?
• [uitdr.] Ze heeft hem afgewezen. — Lo ha rechazado.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Le han dado calabazas.', 'SENTENCE', 'Ejemplo de "een blauwtje lopen" (perf.)', 'EEN BLAUWTJE LOPEN = recibir calabazas, ser rechazado en el amor.

🧩 Expresión fija — een blauwtje lopen:

• literal — correr un azulito.
• significa — ser rechazado en el amor.
• piezas fijas — het blauwtje con een; lopen va aquí con hebben, heeft een blauwtje gelopen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Hij heeft een blauwtje gelopen. | Le han dado calabazas. |
| 2 | imperfecto | Ik liep een blauwtje bij haar. | Ella me dio calabazas. |
| 3 | subordinada | Hij is bang dat hij een blauwtje loopt. | Tiene miedo de que le den calabazas. |

🎯 En qué contexto se usa:

• rechazos amorosos, invitaciones que no se aceptan
• contarlo con humor sobre uno mismo
• más neutro, afgewezen worden

🔑 El truco que casi nunca falla: las calabazas españolas son un azulito neerlandés, y se corren.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Le han dado calabazas.' AND notes = 'Ejemplo de "een blauwtje lopen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Le han dado calabazas.' AND notes = 'Ejemplo de "een blauwtje lopen" (perf.)' LIMIT 1), 'nl_NL', 'Hij heeft een blauwtje gelopen.', 'hei heft en blauutie jelopen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'recibir calabazas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Le han dado calabazas.' AND notes = 'Ejemplo de "een blauwtje lopen" (perf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'recibir calabazas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'recibir calabazas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Le han dado calabazas.' AND notes = 'Ejemplo de "een blauwtje lopen" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Le han dado calabazas.' AND notes = 'Ejemplo de "een blauwtje lopen" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 090. ir sobre ruedas → op rolletjes lopen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ir sobre ruedas', 'PHRASE', 'frases hechas: op rolletjes lopen', 'OP ROLLETJES LOPEN = ir sobre ruedas, salir todo bien y sin problemas.

🧩 Expresión fija — op rolletjes lopen:

• literal — andar sobre rueditas.
• significa — salir todo bien y sin problemas.
• piezas fijas — de rolletjes en diminutivo plural; lopen va aquí con hebben, heeft op rolletjes gelopen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Alles loopt op rolletjes. | Todo va sobre ruedas. |
| 2 | perfecto | Het project heeft op rolletjes gelopen. | El proyecto ha ido sobre ruedas. |
| 3 | imperfecto | De verhuizing liep op rolletjes. | La mudanza fue sobre ruedas. |

🎯 En qué contexto se usa:

• proyectos, mudanzas, viajes que salen bien
• tranquilizar, Alles loopt op rolletjes
• registro neutro

🔑 El truco que casi nunca falla: las ruedas españolas son rueditas neerlandesas.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ir sobre ruedas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ir sobre ruedas' LIMIT 1), 'nl_NL', 'op rolletjes lopen', 'op rólletjes lópen', '• [can.] Alles loopt op rolletjes. — Todo va sobre ruedas.
• [perf.] Het project heeft op rolletjes gelopen. — El proyecto ha ido sobre ruedas.
• [imperf.] De verhuizing liep op rolletjes. — La mudanza fue sobre ruedas.
• [bijzin] Ik ben blij dat het op rolletjes loopt. — Me alegro de que vaya sobre ruedas.
• [vraag] Loopt het op rolletjes? — ¿Va sobre ruedas?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Todo va sobre ruedas.', 'SENTENCE', 'Ejemplo de "op rolletjes lopen" (can.)', 'OP ROLLETJES LOPEN = ir sobre ruedas, salir todo bien y sin problemas.

🧩 Expresión fija — op rolletjes lopen:

• literal — andar sobre rueditas.
• significa — salir todo bien y sin problemas.
• piezas fijas — de rolletjes en diminutivo plural; lopen va aquí con hebben, heeft op rolletjes gelopen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Alles loopt op rolletjes. | Todo va sobre ruedas. |
| 2 | perfecto | Het project heeft op rolletjes gelopen. | El proyecto ha ido sobre ruedas. |
| 3 | imperfecto | De verhuizing liep op rolletjes. | La mudanza fue sobre ruedas. |

🎯 En qué contexto se usa:

• proyectos, mudanzas, viajes que salen bien
• tranquilizar, Alles loopt op rolletjes
• registro neutro

🔑 El truco que casi nunca falla: las ruedas españolas son rueditas neerlandesas.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Todo va sobre ruedas.' AND notes = 'Ejemplo de "op rolletjes lopen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo va sobre ruedas.' AND notes = 'Ejemplo de "op rolletjes lopen" (can.)' LIMIT 1), 'nl_NL', 'Alles loopt op rolletjes.', 'ales lopt op roleties', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ir sobre ruedas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Todo va sobre ruedas.' AND notes = 'Ejemplo de "op rolletjes lopen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ir sobre ruedas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ir sobre ruedas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo va sobre ruedas.' AND notes = 'Ejemplo de "op rolletjes lopen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Todo va sobre ruedas.' AND notes = 'Ejemplo de "op rolletjes lopen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 091. caer en la cuenta → het kwartje valt
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'caer en la cuenta', 'PHRASE', 'frases hechas: het kwartje valt', 'HET KWARTJE VALT = caer en la cuenta, entender algo de repente, a veces tarde.

🧩 Expresión fija — het kwartje valt:

• literal — cae la moneda de veinticinco céntimos.
• significa — entender algo de repente, a veces tarde.
• piezas fijas — el sujeto es het kwartje y la persona va con bij, Het kwartje viel bij hem; vallen va con zijn.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Het kwartje is gevallen. | Por fin he caído en la cuenta. |
| 2 | inversión | Bij hem viel het kwartje pas na een uur. | Él cayó en la cuenta al cabo de una hora. |
| 3 | subordinada | Ik zag dat het kwartje viel. | Vi que caía en la cuenta. |

🎯 En qué contexto se usa:

• entender una broma o una situación con retraso
• en pregunta, Is het kwartje gevallen?
• registro neutro

🔑 El truco que casi nunca falla: como en una máquina antigua, cae la moneda y se enciende la luz.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'caer en la cuenta');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'caer en la cuenta' LIMIT 1), 'nl_NL', 'het kwartje valt', 'et kuártie falt', '• [perf.] Het kwartje is gevallen. — Por fin he caído en la cuenta.
• [inv.] Bij hem viel het kwartje pas na een uur. — Él cayó en la cuenta al cabo de una hora.
• [bijzin] Ik zag dat het kwartje viel. — Vi que caía en la cuenta.
• [vraag] Is het kwartje gevallen? — ¿Has caído en la cuenta?
• [uitdr.] Nu snap ik het. — Ahora lo entiendo.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Por fin he caído en la cuenta.', 'SENTENCE', 'Ejemplo de "het kwartje valt" (perf.)', 'HET KWARTJE VALT = caer en la cuenta, entender algo de repente, a veces tarde.

🧩 Expresión fija — het kwartje valt:

• literal — cae la moneda de veinticinco céntimos.
• significa — entender algo de repente, a veces tarde.
• piezas fijas — el sujeto es het kwartje y la persona va con bij, Het kwartje viel bij hem; vallen va con zijn.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | Het kwartje is gevallen. | Por fin he caído en la cuenta. |
| 2 | inversión | Bij hem viel het kwartje pas na een uur. | Él cayó en la cuenta al cabo de una hora. |
| 3 | subordinada | Ik zag dat het kwartje viel. | Vi que caía en la cuenta. |

🎯 En qué contexto se usa:

• entender una broma o una situación con retraso
• en pregunta, Is het kwartje gevallen?
• registro neutro

🔑 El truco que casi nunca falla: como en una máquina antigua, cae la moneda y se enciende la luz.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Por fin he caído en la cuenta.' AND notes = 'Ejemplo de "het kwartje valt" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Por fin he caído en la cuenta.' AND notes = 'Ejemplo de "het kwartje valt" (perf.)' LIMIT 1), 'nl_NL', 'Het kwartje is gevallen.', 'het kuartie is jefalen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'caer en la cuenta' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Por fin he caído en la cuenta.' AND notes = 'Ejemplo de "het kwartje valt" (perf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'caer en la cuenta' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'caer en la cuenta' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Por fin he caído en la cuenta.' AND notes = 'Ejemplo de "het kwartje valt" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Por fin he caído en la cuenta.' AND notes = 'Ejemplo de "het kwartje valt" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 092. ¡ni hablar! → geen sprake van
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡ni hablar!', 'PHRASE', 'frases hechas: geen sprake van', 'GEEN SPRAKE VAN = ¡ni hablar!, negativa rotunda.

🧩 Expresión fija — geen sprake van:

• literal — no hay conversación de ello.
• significa — negativa rotunda.
• piezas fijas — de sprake, aquí sin artículo; en frase completa, Er is geen sprake van dat….

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Geen sprake van! | ¡Ni hablar! |
| 2 | principal | Er is geen sprake van dat ik ga. | Ni hablar de que vaya yo. |
| 3 | imperfecto | Er was geen sprake van een feest. | De fiesta, ni hablar. |

🎯 En qué contexto se usa:

• negar rotundamente una petición
• padres con hijos, jefes con empleados
• registro neutro, firme

🔑 El truco que casi nunca falla: no hay ni conversación, sprake, sobre el tema.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡ni hablar!');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡ni hablar!' LIMIT 1), 'nl_NL', 'geen sprake van', 'jeen spráke fan', '• [uitdr.] Geen sprake van! — ¡Ni hablar!
• [can.] Er is geen sprake van dat ik ga. — Ni hablar de que vaya yo.
• [imperf.] Er was geen sprake van een feest. — De fiesta, ni hablar.
• [vraag] Mag ik de auto lenen? Geen sprake van. — ¿Me dejas el coche? Ni hablar.
• [bijzin] Hij zei dat er geen sprake van was. — Dijo que ni hablar.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Ni hablar!', 'SENTENCE', 'Ejemplo de "geen sprake van" (uitdr.)', 'GEEN SPRAKE VAN = ¡ni hablar!, negativa rotunda.

🧩 Expresión fija — geen sprake van:

• literal — no hay conversación de ello.
• significa — negativa rotunda.
• piezas fijas — de sprake, aquí sin artículo; en frase completa, Er is geen sprake van dat….

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Geen sprake van! | ¡Ni hablar! |
| 2 | principal | Er is geen sprake van dat ik ga. | Ni hablar de que vaya yo. |
| 3 | imperfecto | Er was geen sprake van een feest. | De fiesta, ni hablar. |

🎯 En qué contexto se usa:

• negar rotundamente una petición
• padres con hijos, jefes con empleados
• registro neutro, firme

🔑 El truco que casi nunca falla: no hay ni conversación, sprake, sobre el tema.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Ni hablar!' AND notes = 'Ejemplo de "geen sprake van" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Ni hablar!' AND notes = 'Ejemplo de "geen sprake van" (uitdr.)' LIMIT 1), 'nl_NL', 'Geen sprake van!', 'jen sprake fan', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = '¡ni hablar!' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Ni hablar!' AND notes = 'Ejemplo de "geen sprake van" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡ni hablar!' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡ni hablar!' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Ni hablar!' AND notes = 'Ejemplo de "geen sprake van" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Ni hablar!' AND notes = 'Ejemplo de "geen sprake van" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 093. ¡manos a la obra! → aan de slag
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡manos a la obra!', 'PHRASE', 'frases hechas: aan de slag', 'AAN DE SLAG = ¡manos a la obra!, empezar a trabajar.

🧩 Expresión fija — aan de slag:

• literal — al golpe.
• significa — empezar a trabajar.
• piezas fijas — de slag; con verbo, aan de slag gaan, va con zijn, is aan de slag gegaan.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Aan de slag! | ¡Manos a la obra! |
| 2 | principal | We gaan nu aan de slag. | Ahora nos ponemos manos a la obra. |
| 3 | perfecto | Ze is meteen aan de slag gegaan. | Se ha puesto manos a la obra enseguida. |

🎯 En qué contexto se usa:

• empezar una tarea en grupo
• animarte a ti mismo, Aan de slag!
• también empezar un trabajo nuevo, Ik ga daar maandag aan de slag

🔑 El truco que casi nunca falla: de slag es el golpe, a dar golpes de trabajo.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡manos a la obra!');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡manos a la obra!' LIMIT 1), 'nl_NL', 'aan de slag', 'an de slaj', '• [uitdr.] Aan de slag! — ¡Manos a la obra!
• [can.] We gaan nu aan de slag. — Ahora nos ponemos manos a la obra.
• [perf.] Ze is meteen aan de slag gegaan. — Se ha puesto manos a la obra enseguida.
• [bijzin] Het wordt tijd dat we aan de slag gaan. — Ya es hora de ponernos manos a la obra.
• [vraag] Zullen we aan de slag gaan? — ¿Nos ponemos manos a la obra?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Manos a la obra!', 'SENTENCE', 'Ejemplo de "aan de slag" (uitdr.)', 'AAN DE SLAG = ¡manos a la obra!, empezar a trabajar.

🧩 Expresión fija — aan de slag:

• literal — al golpe.
• significa — empezar a trabajar.
• piezas fijas — de slag; con verbo, aan de slag gaan, va con zijn, is aan de slag gegaan.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Aan de slag! | ¡Manos a la obra! |
| 2 | principal | We gaan nu aan de slag. | Ahora nos ponemos manos a la obra. |
| 3 | perfecto | Ze is meteen aan de slag gegaan. | Se ha puesto manos a la obra enseguida. |

🎯 En qué contexto se usa:

• empezar una tarea en grupo
• animarte a ti mismo, Aan de slag!
• también empezar un trabajo nuevo, Ik ga daar maandag aan de slag

🔑 El truco que casi nunca falla: de slag es el golpe, a dar golpes de trabajo.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Manos a la obra!' AND notes = 'Ejemplo de "aan de slag" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Manos a la obra!' AND notes = 'Ejemplo de "aan de slag" (uitdr.)' LIMIT 1), 'nl_NL', 'Aan de slag!', 'aan de slaj', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = '¡manos a la obra!' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Manos a la obra!' AND notes = 'Ejemplo de "aan de slag" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡manos a la obra!' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡manos a la obra!' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Manos a la obra!' AND notes = 'Ejemplo de "aan de slag" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Manos a la obra!' AND notes = 'Ejemplo de "aan de slag" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 094. poner toda la carne en el asador → alles op alles zetten
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'poner toda la carne en el asador', 'PHRASE', 'frases hechas: alles op alles zetten', 'ALLES OP ALLES ZETTEN = poner toda la carne en el asador, hacer el máximo esfuerzo.

🧩 Expresión fija — alles op alles zetten:

• literal — poner todo sobre todo.
• significa — hacer el máximo esfuerzo.
• piezas fijas — alles op alles fijo; zetten es débil, gezet con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij zet alles op alles om te winnen. | Pone toda la carne en el asador para ganar. |
| 2 | perfecto | Ik heb alles op alles gezet. | He puesto toda la carne en el asador. |
| 3 | imperfecto | Het team zette alles op alles. | El equipo puso toda la carne en el asador. |

🎯 En qué contexto se usa:

• competiciones, exámenes, proyectos decisivos
• animar a un equipo, Zet alles op alles!
• registro neutro

🔑 El truco que casi nunca falla: todo sobre todo, no queda nada guardado.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'poner toda la carne en el asador');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'poner toda la carne en el asador' LIMIT 1), 'nl_NL', 'alles op alles zetten', 'álles op álles sétten', '• [can.] Hij zet alles op alles om te winnen. — Pone toda la carne en el asador para ganar.
• [perf.] Ik heb alles op alles gezet. — He puesto toda la carne en el asador.
• [imperf.] Het team zette alles op alles. — El equipo puso toda la carne en el asador.
• [bijzin] Ik beloof dat ik alles op alles zet. — Prometo que pondré toda la carne en el asador.
• [geb.] Zet alles op alles! — ¡Pon toda la carne en el asador!');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Pone toda la carne en el asador para ganar.', 'SENTENCE', 'Ejemplo de "alles op alles zetten" (can.)', 'ALLES OP ALLES ZETTEN = poner toda la carne en el asador, hacer el máximo esfuerzo.

🧩 Expresión fija — alles op alles zetten:

• literal — poner todo sobre todo.
• significa — hacer el máximo esfuerzo.
• piezas fijas — alles op alles fijo; zetten es débil, gezet con hebben.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij zet alles op alles om te winnen. | Pone toda la carne en el asador para ganar. |
| 2 | perfecto | Ik heb alles op alles gezet. | He puesto toda la carne en el asador. |
| 3 | imperfecto | Het team zette alles op alles. | El equipo puso toda la carne en el asador. |

🎯 En qué contexto se usa:

• competiciones, exámenes, proyectos decisivos
• animar a un equipo, Zet alles op alles!
• registro neutro

🔑 El truco que casi nunca falla: todo sobre todo, no queda nada guardado.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Pone toda la carne en el asador para ganar.' AND notes = 'Ejemplo de "alles op alles zetten" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Pone toda la carne en el asador para ganar.' AND notes = 'Ejemplo de "alles op alles zetten" (can.)' LIMIT 1), 'nl_NL', 'Hij zet alles op alles om te winnen.', 'hei set ales op ales om te vinen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'poner toda la carne en el asador' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Pone toda la carne en el asador para ganar.' AND notes = 'Ejemplo de "alles op alles zetten" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'poner toda la carne en el asador' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'poner toda la carne en el asador' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Pone toda la carne en el asador para ganar.' AND notes = 'Ejemplo de "alles op alles zetten" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Pone toda la carne en el asador para ganar.' AND notes = 'Ejemplo de "alles op alles zetten" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 095. pillar a alguien con las manos en la masa → iemand op heterdaad betrappen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pillar a alguien con las manos en la masa', 'PHRASE', 'frases hechas: iemand op heterdaad betrappen', 'IEMAND OP HETERDAAD BETRAPPEN = pillar a alguien con las manos en la masa, sorprender a alguien justo haciendo algo malo.

🧩 Expresión fija — iemand op heterdaad betrappen:

• literal — pillar a alguien en el hecho caliente.
• significa — sorprender a alguien justo haciendo algo malo.
• piezas fijas — op heterdaad fijo; betrappen es inseparable, betrapt sin ge-; muy frecuente en pasiva, is betrapt.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | De dief is op heterdaad betrapt. | Han pillado al ladrón con las manos en la masa. |
| 2 | imperfecto | Mijn moeder betrapte me op heterdaad. | Mi madre me pilló con las manos en la masa. |
| 3 | principal | De politie betrapt hem op heterdaad. | La policía lo pilla con las manos en la masa. |

🎯 En qué contexto se usa:

• robos, trampas, niños pillados con las galletas
• lenguaje de noticias y de policía
• registro neutro

🔑 El truco que casi nunca falla: heterdaad es el hecho caliente, como pillar a alguien en caliente.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pillar a alguien con las manos en la masa');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'pillar a alguien con las manos en la masa' LIMIT 1), 'nl_NL', 'iemand op heterdaad betrappen', 'íemant op hétterdaat betrápen', '• [perf.] De dief is op heterdaad betrapt. — Han pillado al ladrón con las manos en la masa.
• [imperf.] Mijn moeder betrapte me op heterdaad. — Mi madre me pilló con las manos en la masa.
• [can.] De politie betrapt hem op heterdaad. — La policía lo pilla con las manos en la masa.
• [bijzin] Ik weet niet hoe ze hem op heterdaad hebben betrapt. — No sé cómo lo han pillado con las manos en la masa.
• [vraag] Ben je op heterdaad betrapt? — ¿Te han pillado con las manos en la masa?');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Han pillado al ladrón con las manos en la masa.', 'SENTENCE', 'Ejemplo de "iemand op heterdaad betrappen" (perf.)', 'IEMAND OP HETERDAAD BETRAPPEN = pillar a alguien con las manos en la masa, sorprender a alguien justo haciendo algo malo.

🧩 Expresión fija — iemand op heterdaad betrappen:

• literal — pillar a alguien en el hecho caliente.
• significa — sorprender a alguien justo haciendo algo malo.
• piezas fijas — op heterdaad fijo; betrappen es inseparable, betrapt sin ge-; muy frecuente en pasiva, is betrapt.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | perfecto | De dief is op heterdaad betrapt. | Han pillado al ladrón con las manos en la masa. |
| 2 | imperfecto | Mijn moeder betrapte me op heterdaad. | Mi madre me pilló con las manos en la masa. |
| 3 | principal | De politie betrapt hem op heterdaad. | La policía lo pilla con las manos en la masa. |

🎯 En qué contexto se usa:

• robos, trampas, niños pillados con las galletas
• lenguaje de noticias y de policía
• registro neutro

🔑 El truco que casi nunca falla: heterdaad es el hecho caliente, como pillar a alguien en caliente.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Han pillado al ladrón con las manos en la masa.' AND notes = 'Ejemplo de "iemand op heterdaad betrappen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Han pillado al ladrón con las manos en la masa.' AND notes = 'Ejemplo de "iemand op heterdaad betrappen" (perf.)' LIMIT 1), 'nl_NL', 'De dief is op heterdaad betrapt.', 'de dif is op heterdaat betrapt', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'pillar a alguien con las manos en la masa' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Han pillado al ladrón con las manos en la masa.' AND notes = 'Ejemplo de "iemand op heterdaad betrappen" (perf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pillar a alguien con las manos en la masa' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pillar a alguien con las manos en la masa' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Han pillado al ladrón con las manos en la masa.' AND notes = 'Ejemplo de "iemand op heterdaad betrappen" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Han pillado al ladrón con las manos en la masa.' AND notes = 'Ejemplo de "iemand op heterdaad betrappen" (perf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 096. estar más claro que el agua → zo klaar als een klontje zijn
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estar más claro que el agua', 'PHRASE', 'frases hechas: zo klaar als een klontje zijn', 'ZO KLAAR ALS EEN KLONTJE ZIJN = estar más claro que el agua, ser evidente.

🧩 Expresión fija — zo klaar als een klontje zijn:

• literal — ser tan claro como un terrón de azúcar.
• significa — ser evidente.
• piezas fijas — zo … als; het klontje con een; zijn se conjuga.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Het is zo klaar als een klontje. | Está más claro que el agua. |
| 2 | imperfecto | De oplossing was zo klaar als een klontje. | La solución estaba más clara que el agua. |
| 3 | subordinada | Ik vind dat het zo klaar als een klontje is. | A mí me parece más claro que el agua. |

🎯 En qué contexto se usa:

• algo evidente en una discusión o un problema
• registro coloquial pero neutro
• más formal, dat spreekt voor zich

🔑 El truco que casi nunca falla: klaar en neerlandés es claro, y klaar y klontje empiezan igual.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estar más claro que el agua');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'estar más claro que el agua' LIMIT 1), 'nl_NL', 'zo klaar als een klontje zijn', 'so klaar als en klóntie sein', '• [can.] Het is zo klaar als een klontje. — Está más claro que el agua.
• [imperf.] De oplossing was zo klaar als een klontje. — La solución estaba más clara que el agua.
• [bijzin] Ik vind dat het zo klaar als een klontje is. — A mí me parece más claro que el agua.
• [vraag] Is dat niet zo klaar als een klontje? — ¿No está más claro que el agua?
• [uitdr.] Dat spreekt voor zich. — Eso es evidente.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Está más claro que el agua.', 'SENTENCE', 'Ejemplo de "zo klaar als een klontje zijn" (can.)', 'ZO KLAAR ALS EEN KLONTJE ZIJN = estar más claro que el agua, ser evidente.

🧩 Expresión fija — zo klaar als een klontje zijn:

• literal — ser tan claro como un terrón de azúcar.
• significa — ser evidente.
• piezas fijas — zo … als; het klontje con een; zijn se conjuga.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Het is zo klaar als een klontje. | Está más claro que el agua. |
| 2 | imperfecto | De oplossing was zo klaar als een klontje. | La solución estaba más clara que el agua. |
| 3 | subordinada | Ik vind dat het zo klaar als een klontje is. | A mí me parece más claro que el agua. |

🎯 En qué contexto se usa:

• algo evidente en una discusión o un problema
• registro coloquial pero neutro
• más formal, dat spreekt voor zich

🔑 El truco que casi nunca falla: klaar en neerlandés es claro, y klaar y klontje empiezan igual.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Está más claro que el agua.' AND notes = 'Ejemplo de "zo klaar als een klontje zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Está más claro que el agua.' AND notes = 'Ejemplo de "zo klaar als een klontje zijn" (can.)' LIMIT 1), 'nl_NL', 'Het is zo klaar als een klontje.', 'het is so klaar als en klontie', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'estar más claro que el agua' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Está más claro que el agua.' AND notes = 'Ejemplo de "zo klaar als een klontje zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar más claro que el agua' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estar más claro que el agua' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Está más claro que el agua.' AND notes = 'Ejemplo de "zo klaar als een klontje zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Está más claro que el agua.' AND notes = 'Ejemplo de "zo klaar als een klontje zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 097. ser más terco que una mula → zo koppig als een ezel zijn
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ser más terco que una mula', 'PHRASE', 'frases hechas: zo koppig als een ezel zijn', 'ZO KOPPIG ALS EEN EZEL ZIJN = ser más terco que una mula, ser muy testarudo.

🧩 Expresión fija — zo koppig als een ezel zijn:

• literal — ser tan testarudo como un burro.
• significa — ser muy testarudo.
• piezas fijas — zo … als; de ezel con een; koppig viene de de kop, la cabeza.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Mijn zoon is zo koppig als een ezel. | Mi hijo es más terco que una mula. |
| 2 | imperfecto | Mijn opa was zo koppig als een ezel. | Mi abuelo era más terco que una mula. |
| 3 | perfecto | Ze is altijd zo koppig als een ezel geweest. | Siempre ha sido más terca que una mula. |

🎯 En qué contexto se usa:

• describir a alguien que no cambia de opinión
• niños, abuelos, parejas
• registro neutro, con humor

🔑 El truco que casi nunca falla: la mula española es un burro neerlandés, y koppig viene de kop, cabezota.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ser más terco que una mula');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'ser más terco que una mula' LIMIT 1), 'nl_NL', 'zo koppig als een ezel zijn', 'so kópej als en ésel sein', '• [can.] Mijn zoon is zo koppig als een ezel. — Mi hijo es más terco que una mula.
• [imperf.] Mijn opa was zo koppig als een ezel. — Mi abuelo era más terco que una mula.
• [perf.] Ze is altijd zo koppig als een ezel geweest. — Siempre ha sido más terca que una mula.
• [bijzin] Ik weet dat je zo koppig als een ezel bent. — Sé que eres más terco que una mula.
• [uitdr.] Een ezel stoot zich geen twee keer aan dezelfde steen. — Un burro no tropieza dos veces con la misma piedra.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Mi hijo es más terco que una mula.', 'SENTENCE', 'Ejemplo de "zo koppig als een ezel zijn" (can.)', 'ZO KOPPIG ALS EEN EZEL ZIJN = ser más terco que una mula, ser muy testarudo.

🧩 Expresión fija — zo koppig als een ezel zijn:

• literal — ser tan testarudo como un burro.
• significa — ser muy testarudo.
• piezas fijas — zo … als; de ezel con een; koppig viene de de kop, la cabeza.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Mijn zoon is zo koppig als een ezel. | Mi hijo es más terco que una mula. |
| 2 | imperfecto | Mijn opa was zo koppig als een ezel. | Mi abuelo era más terco que una mula. |
| 3 | perfecto | Ze is altijd zo koppig als een ezel geweest. | Siempre ha sido más terca que una mula. |

🎯 En qué contexto se usa:

• describir a alguien que no cambia de opinión
• niños, abuelos, parejas
• registro neutro, con humor

🔑 El truco que casi nunca falla: la mula española es un burro neerlandés, y koppig viene de kop, cabezota.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi hijo es más terco que una mula.' AND notes = 'Ejemplo de "zo koppig als een ezel zijn" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi hijo es más terco que una mula.' AND notes = 'Ejemplo de "zo koppig als een ezel zijn" (can.)' LIMIT 1), 'nl_NL', 'Mijn zoon is zo koppig als een ezel.', 'mein son is so kopij als en esel', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'ser más terco que una mula' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Mi hijo es más terco que una mula.' AND notes = 'Ejemplo de "zo koppig als een ezel zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ser más terco que una mula' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ser más terco que una mula' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi hijo es más terco que una mula.' AND notes = 'Ejemplo de "zo koppig als een ezel zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi hijo es más terco que una mula.' AND notes = 'Ejemplo de "zo koppig als een ezel zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 098. andarse con rodeos → om de hete brij heen draaien
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'andarse con rodeos', 'PHRASE', 'frases hechas: om de hete brij heen draaien', 'OM DE HETE BRIJ HEEN DRAAIEN = andarse con rodeos, evitar el tema principal.

🧩 Expresión fija — om de hete brij heen draaien:

• literal — dar vueltas alrededor de la papilla caliente.
• significa — evitar el tema principal.
• piezas fijas — om … heen rodea a de hete brij; draaien es débil, heeft om de hete brij heen gedraaid.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Draai niet om de hete brij heen. | No te andes con rodeos. |
| 2 | principal | Hij draait om de hete brij heen. | Se anda con rodeos. |
| 3 | perfecto | De minister heeft om de hete brij heen gedraaid. | El ministro se ha andado con rodeos. |

🎯 En qué contexto se usa:

• evasivas en reuniones, entrevistas, conversaciones difíciles
• para pedir claridad, Draai niet om de hete brij heen
• registro neutro, frecuente en prensa

🔑 El truco que casi nunca falla: el gato da vueltas a la papilla porque quema, igual que tú al tema.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'andarse con rodeos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'andarse con rodeos' LIMIT 1), 'nl_NL', 'om de hete brij heen draaien', 'om de héte brei heen dráaien', '• [geb.] Draai niet om de hete brij heen. — No te andes con rodeos.
• [can.] Hij draait om de hete brij heen. — Se anda con rodeos.
• [perf.] De minister heeft om de hete brij heen gedraaid. — El ministro se ha andado con rodeos.
• [bijzin] Ik merk dat je om de hete brij heen draait. — Noto que te andas con rodeos.
• [imperf.] Ze draaide de hele avond om de hete brij heen. — Se anduvo con rodeos toda la noche.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No te andes con rodeos.', 'SENTENCE', 'Ejemplo de "om de hete brij heen draaien" (geb.)', 'OM DE HETE BRIJ HEEN DRAAIEN = andarse con rodeos, evitar el tema principal.

🧩 Expresión fija — om de hete brij heen draaien:

• literal — dar vueltas alrededor de la papilla caliente.
• significa — evitar el tema principal.
• piezas fijas — om … heen rodea a de hete brij; draaien es débil, heeft om de hete brij heen gedraaid.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Draai niet om de hete brij heen. | No te andes con rodeos. |
| 2 | principal | Hij draait om de hete brij heen. | Se anda con rodeos. |
| 3 | perfecto | De minister heeft om de hete brij heen gedraaid. | El ministro se ha andado con rodeos. |

🎯 En qué contexto se usa:

• evasivas en reuniones, entrevistas, conversaciones difíciles
• para pedir claridad, Draai niet om de hete brij heen
• registro neutro, frecuente en prensa

🔑 El truco que casi nunca falla: el gato da vueltas a la papilla porque quema, igual que tú al tema.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No te andes con rodeos.' AND notes = 'Ejemplo de "om de hete brij heen draaien" (geb.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'No te andes con rodeos.' AND notes = 'Ejemplo de "om de hete brij heen draaien" (geb.)' LIMIT 1), 'nl_NL', 'Draai niet om de hete brij heen.', 'draai nit om de hete brei hen', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'andarse con rodeos' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No te andes con rodeos.' AND notes = 'Ejemplo de "om de hete brij heen draaien" (geb.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'andarse con rodeos' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'andarse con rodeos' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No te andes con rodeos.' AND notes = 'Ejemplo de "om de hete brij heen draaien" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No te andes con rodeos.' AND notes = 'Ejemplo de "om de hete brij heen draaien" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 099. irse por las ramas → van de hak op de tak springen
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'irse por las ramas', 'PHRASE', 'frases hechas: van de hak op de tak springen', 'VAN DE HAK OP DE TAK SPRINGEN = irse por las ramas, cambiar de tema sin orden, divagar.

🧩 Expresión fija — van de hak op de tak springen:

• literal — saltar del talón a la rama.
• significa — cambiar de tema sin orden, divagar.
• piezas fijas — van de hak op de tak fijo; springen es fuerte y va con hebben o zijn, sprong, gesprongen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je springt van de hak op de tak. | Te vas por las ramas. |
| 2 | imperfecto | De spreker sprong van de hak op de tak. | El orador se iba por las ramas. |
| 3 | perfecto | Ik ben weer van de hak op de tak gesprongen. | Me he vuelto a ir por las ramas. |

🎯 En qué contexto se usa:

• conversaciones o charlas desordenadas
• autocrítica, Ik spring weer van de hak op de tak
• registro neutro

🔑 El truco que casi nunca falla: hak y tak riman, como quien salta de tema en tema.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'irse por las ramas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'irse por las ramas' LIMIT 1), 'nl_NL', 'van de hak op de tak springen', 'fan de hak op de tak springen', '• [can.] Je springt van de hak op de tak. — Te vas por las ramas.
• [imperf.] De spreker sprong van de hak op de tak. — El orador se iba por las ramas.
• [perf.] Ik ben weer van de hak op de tak gesprongen. — Me he vuelto a ir por las ramas.
• [bijzin] Ik vind het lastig als je van de hak op de tak springt. — Me cuesta seguirte cuando te vas por las ramas.
• [geb.] Spring niet van de hak op de tak. — No te vayas por las ramas.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Te vas por las ramas.', 'SENTENCE', 'Ejemplo de "van de hak op de tak springen" (can.)', 'VAN DE HAK OP DE TAK SPRINGEN = irse por las ramas, cambiar de tema sin orden, divagar.

🧩 Expresión fija — van de hak op de tak springen:

• literal — saltar del talón a la rama.
• significa — cambiar de tema sin orden, divagar.
• piezas fijas — van de hak op de tak fijo; springen es fuerte y va con hebben o zijn, sprong, gesprongen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je springt van de hak op de tak. | Te vas por las ramas. |
| 2 | imperfecto | De spreker sprong van de hak op de tak. | El orador se iba por las ramas. |
| 3 | perfecto | Ik ben weer van de hak op de tak gesprongen. | Me he vuelto a ir por las ramas. |

🎯 En qué contexto se usa:

• conversaciones o charlas desordenadas
• autocrítica, Ik spring weer van de hak op de tak
• registro neutro

🔑 El truco que casi nunca falla: hak y tak riman, como quien salta de tema en tema.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Te vas por las ramas.' AND notes = 'Ejemplo de "van de hak op de tak springen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Te vas por las ramas.' AND notes = 'Ejemplo de "van de hak op de tak springen" (can.)' LIMIT 1), 'nl_NL', 'Je springt van de hak op de tak.', 'ie springt fan de hak op de tak', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'irse por las ramas' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Te vas por las ramas.' AND notes = 'Ejemplo de "van de hak op de tak springen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'irse por las ramas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'irse por las ramas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Te vas por las ramas.' AND notes = 'Ejemplo de "van de hak op de tak springen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Te vas por las ramas.' AND notes = 'Ejemplo de "van de hak op de tak springen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 100. el mundo es un pañuelo → de wereld is klein
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el mundo es un pañuelo', 'PHRASE', 'frases hechas: de wereld is klein', 'DE WERELD IS KLEIN = el mundo es un pañuelo, encontrarse por casualidad con alguien conocido.

🧩 Expresión fija — de wereld is klein:

• literal — el mundo es pequeño.
• significa — encontrarse por casualidad con alguien conocido.
• piezas fijas — refrán cerrado; de wereld.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | De wereld is klein! | ¡El mundo es un pañuelo! |
| 2 | principal | Jij hier? De wereld is klein. | ¿Tú aquí? El mundo es un pañuelo. |
| 3 | imperfecto | Hij bleek mijn buurman te zijn, de wereld is klein. | Resultó ser mi vecino, el mundo es un pañuelo. |

🎯 En qué contexto se usa:

• encuentros casuales en otra ciudad o país
• descubrir conocidos en común
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés no hay pañuelo, el mundo simplemente es pequeño.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el mundo es un pañuelo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el mundo es un pañuelo' LIMIT 1), 'nl_NL', 'de wereld is klein', 'de vérelt is klein', '• [uitdr.] De wereld is klein! — ¡El mundo es un pañuelo!
• [can.] Jij hier? De wereld is klein. — ¿Tú aquí? El mundo es un pañuelo.
• [imperf.] Hij bleek mijn buurman te zijn, de wereld is klein. — Resultó ser mi vecino, el mundo es un pañuelo.
• [perf.] Ik ben in Tokio mijn collega tegengekomen. — Me he encontrado a mi compañero en Tokio.
• [bijzin] Ik zeg altijd dat de wereld klein is. — Siempre digo que el mundo es un pañuelo.');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡El mundo es un pañuelo!', 'SENTENCE', 'Ejemplo de "de wereld is klein" (uitdr.)', 'DE WERELD IS KLEIN = el mundo es un pañuelo, encontrarse por casualidad con alguien conocido.

🧩 Expresión fija — de wereld is klein:

• literal — el mundo es pequeño.
• significa — encontrarse por casualidad con alguien conocido.
• piezas fijas — refrán cerrado; de wereld.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | De wereld is klein! | ¡El mundo es un pañuelo! |
| 2 | principal | Jij hier? De wereld is klein. | ¿Tú aquí? El mundo es un pañuelo. |
| 3 | imperfecto | Hij bleek mijn buurman te zijn, de wereld is klein. | Resultó ser mi vecino, el mundo es un pañuelo. |

🎯 En qué contexto se usa:

• encuentros casuales en otra ciudad o país
• descubrir conocidos en común
• registro neutro

🔑 El truco que casi nunca falla: en neerlandés no hay pañuelo, el mundo simplemente es pequeño.

📚 Uitdrukking o spreekwoord, cómo se usa una frase hecha:

| # | tipo | qué es | ejemplo |
|---|---|---|---|
| 1 | **uitdrukking** | locución con verbo, se conjuga y encaja en tu frase | een oogje dichtknijpen |
| 2 | **spreekwoord** | refrán cerrado, no se toca ni una palabra | de aanhouder wint |
| 3 | **zegswijze** | fórmula suelta, sin verbo propio | voor de zekerheid |

• el posesivo — en las locuciones je es un comodín y cambia con el sujeto, Ik neem te veel hooi op mijn vork, Hij neemt te veel hooi op zijn vork.
• el verbo — va donde toca, segundo en la principal y al final en la subordinada, … omdat hij een oogje dichtknijpt.
• la traducción — casi nunca palabra por palabra, cada lengua elige animales y objetos distintos, el ojo de la cara es una costilla y el toro es una vaca.
• el registro — mira la línea del contexto, hay frases de abuelo, de prensa y de bar, y no todas valen con el jefe.

🔑 El truco que casi nunca falla: si la frase lleva je, cámbialo por el posesivo del sujeto, y si es un refrán, no toques nada.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡El mundo es un pañuelo!' AND notes = 'Ejemplo de "de wereld is klein" (uitdr.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡El mundo es un pañuelo!' AND notes = 'Ejemplo de "de wereld is klein" (uitdr.)' LIMIT 1), 'nl_NL', 'De wereld is klein!', 'de verelt is klein', NULL);

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'el mundo es un pañuelo' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡El mundo es un pañuelo!' AND notes = 'Ejemplo de "de wereld is klein" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el mundo es un pañuelo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el mundo es un pañuelo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡El mundo es un pañuelo!' AND notes = 'Ejemplo de "de wereld is klein" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'frases hechas - uitdrukkingen en spreekwoorden'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡El mundo es un pañuelo!' AND notes = 'Ejemplo de "de wereld is klein" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
