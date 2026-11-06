-- Learn Languages App - Migration
-- Migration: 20261105000004-grupo-jerga-juvenil
-- Description: Eduardo (2026-11-05): «ok, las expresiones de los jovenes dejalas en otro grupo», tras pedir
--   «que cuando me suelten expresiones niños, adolecentes y/o adultos las pueda entender hoy en día».
--
--   Grupo nuevo 'jerga juvenil - jongerentaal en straattaal' con 40 expresiones del habla de hoy: spreektaal de todos (het valt mee,
--   balen, Doe normaal), jongerentaal con anglicismos (cringe, chill, flexen, vet, ziek) y straattaal
--   (wollah, mattie, doekoe). Mismo patrón que el grupo 55 tras §3.11: la PHRASE es una frase de uso
--   diario, y la ayuda lleva 🔤 construcción original, 📖 palabra a palabra, 🧩, 🎯 contexto y registro
--   (con ⚠️ cuando suena chulo o raro en boca de un adulto), 🔑 truco y el bloque compartido
--   '🛹 Spreektaal, jongerentaal o straattaal, quién dice qué'. Más una SENTENCE de ejemplo por expresión,
--   con relación EXAMPLE. Todas también en generic. Ya estaban en el mazo y no se repiten: ik ga ervandoor
--   (243), Hou op! (586) e Ik word gek van dit lawaai (693). Generada con gen4.py desde data4.py.

PRAGMA foreign_keys = ON;

INSERT INTO word_groups (title, description, source)
SELECT 'jerga juvenil - jongerentaal en straattaal',
       'Cómo hablan hoy niños, adolescentes y adultos en confianza: Doe normaal, balen, het valt mee, cringe, chill, wollah. Cada tarjeta dice quién lo dice, en qué situación y cuándo mejor no usarlo.',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal');

-- 01. doe normaal
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡No te pases, que solo era una broma!', 'PHRASE', 'jerga: doe normaal', 'DOE NORMAAL = no te pases, compórtate, compórtate, no exageres, no te pases.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no te pases, compórtate = doe normaal.
• en esta tarjeta — imperativo doe, sin sujeto; de usted sería Doet u normaal, pero casi nunca se dice de usted.

📖 Palabra a palabra:

• doen — hacer, aquí comportarse.
• normaal — normal.

🧩 Expresión fija — doe normaal:

• literal — haz normal.
• significa — compórtate, no exageres, no te pases.
• piezas fijas — doe es el imperativo de doen y normaal no cambia; muy a menudo con nou eens, Doe nou eens normaal.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Doe normaal, man! | ¡No te pases, tío! |
| 2 | imperativo | Doe nou eens normaal tegen je zus. | Compórtate de una vez con tu hermana. |
| 3 | perfecto | Hij heeft de hele avond niet normaal gedaan. | No se ha comportado en toda la noche. |

🎯 En qué contexto se usa:

• la frase nacional, la dicen padres, profesores y adolescentes
• para frenar a quien exagera, grita o se pone pesado
• ⚠️ suena a reproche, a un desconocido le puede sentar mal

🔑 El truco que casi nunca falla: si en español dirías no te pases o tranqui, es Doe normaal.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: doe normaal' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: doe normaal' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Doe normaal, het was maar een grapje!', 'du normaal, het vas maar en jrapie', '• [geb.] Doe normaal, man! — ¡No te pases, tío!
• [geb.] Doe nou eens normaal tegen je zus. — Compórtate de una vez con tu hermana.
• [perf.] Hij heeft de hele avond niet normaal gedaan. — No se ha comportado en toda la noche.
• [bijzin] Ik vind dat je normaal moet doen. — Creo que tienes que comportarte.
• [uitdr.] Doe normaal, dan doe je al gek genoeg. — Sé normal, que eso ya es bastante raro.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡No te pases, tío!', 'SENTENCE', 'Ejemplo de "doe normaal" (geb.)', 'DOE NORMAAL = no te pases, compórtate, compórtate, no exageres, no te pases.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no te pases, compórtate = doe normaal.
• en esta tarjeta — imperativo doe, sin sujeto; de usted sería Doet u normaal, pero casi nunca se dice de usted.

📖 Palabra a palabra:

• doen — hacer, aquí comportarse.
• normaal — normal.

🧩 Expresión fija — doe normaal:

• literal — haz normal.
• significa — compórtate, no exageres, no te pases.
• piezas fijas — doe es el imperativo de doen y normaal no cambia; muy a menudo con nou eens, Doe nou eens normaal.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Doe normaal, man! | ¡No te pases, tío! |
| 2 | imperativo | Doe nou eens normaal tegen je zus. | Compórtate de una vez con tu hermana. |
| 3 | perfecto | Hij heeft de hele avond niet normaal gedaan. | No se ha comportado en toda la noche. |

🎯 En qué contexto se usa:

• la frase nacional, la dicen padres, profesores y adolescentes
• para frenar a quien exagera, grita o se pone pesado
• ⚠️ suena a reproche, a un desconocido le puede sentar mal

🔑 El truco que casi nunca falla: si en español dirías no te pases o tranqui, es Doe normaal.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡No te pases, tío!' AND notes = 'Ejemplo de "doe normaal" (geb.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡No te pases, tío!' AND notes = 'Ejemplo de "doe normaal" (geb.)' LIMIT 1), 'nl_NL', 'Doe normaal, man!', 'du normaal, man', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: doe normaal' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡No te pases, tío!' AND notes = 'Ejemplo de "doe normaal" (geb.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: doe normaal' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: doe normaal' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡No te pases, tío!' AND notes = 'Ejemplo de "doe normaal" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡No te pases, tío!' AND notes = 'Ejemplo de "doe normaal" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 02. effe dimmen
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Baja el tono, que los vecinos están durmiendo!', 'PHRASE', 'jerga: effe dimmen', 'EFFE DIMMEN = baja el tono, relájate, cálmate, baja la voz o el entusiasmo.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — baja el tono, relájate = effe dimmen.
• en esta tarjeta — va sola al principio, sin verbo conjugado; slapen en presente ya es están durmiendo.

📖 Palabra a palabra:

• effe — forma hablada de even, un momento, un poco.
• dimmen — bajar la intensidad de las luces, del inglés to dim.

🧩 Expresión fija — effe dimmen:

• literal — bajar un poco las luces.
• significa — cálmate, baja la voz o el entusiasmo.
• piezas fijas — effe es even tal como se pronuncia; dimmen es un infinitivo usado como orden.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Effe dimmen, jongens! | ¡Bajad el tono, chicos! |
| 2 | imperativo | Even dimmen, het is pas maandag. | Relájate, que solo es lunes. |
| 3 | perfecto | Ik heb hem gezegd dat hij effe moest dimmen. | Le he dicho que bajara el tono. |

🎯 En qué contexto se usa:

• a alguien que grita, presume o se emociona de más
• entre amigos y en familia, con humor
• por escrito se pone Even dimmen

🔑 El truco que casi nunca falla: dimmen es bajar las luces, y aquí bajas el volumen de la persona.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: effe dimmen' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: effe dimmen' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Effe dimmen, de buren slapen!', 'efe dimen, de büren slapen', '• [geb.] Effe dimmen, jongens! — ¡Bajad el tono, chicos!
• [geb.] Even dimmen, het is pas maandag. — Relájate, que solo es lunes.
• [perf.] Ik heb hem gezegd dat hij effe moest dimmen. — Le he dicho que bajara el tono.
• [bijzin] Het wordt tijd dat je even dimt. — Ya es hora de que bajes el tono.
• [can.] Hij moet echt effe dimmen. — De verdad tiene que relajarse.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Bajad el tono, chicos!', 'SENTENCE', 'Ejemplo de "effe dimmen" (geb.)', 'EFFE DIMMEN = baja el tono, relájate, cálmate, baja la voz o el entusiasmo.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — baja el tono, relájate = effe dimmen.
• en esta tarjeta — va sola al principio, sin verbo conjugado; slapen en presente ya es están durmiendo.

📖 Palabra a palabra:

• effe — forma hablada de even, un momento, un poco.
• dimmen — bajar la intensidad de las luces, del inglés to dim.

🧩 Expresión fija — effe dimmen:

• literal — bajar un poco las luces.
• significa — cálmate, baja la voz o el entusiasmo.
• piezas fijas — effe es even tal como se pronuncia; dimmen es un infinitivo usado como orden.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Effe dimmen, jongens! | ¡Bajad el tono, chicos! |
| 2 | imperativo | Even dimmen, het is pas maandag. | Relájate, que solo es lunes. |
| 3 | perfecto | Ik heb hem gezegd dat hij effe moest dimmen. | Le he dicho que bajara el tono. |

🎯 En qué contexto se usa:

• a alguien que grita, presume o se emociona de más
• entre amigos y en familia, con humor
• por escrito se pone Even dimmen

🔑 El truco que casi nunca falla: dimmen es bajar las luces, y aquí bajas el volumen de la persona.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Bajad el tono, chicos!' AND notes = 'Ejemplo de "effe dimmen" (geb.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Bajad el tono, chicos!' AND notes = 'Ejemplo de "effe dimmen" (geb.)' LIMIT 1), 'nl_NL', 'Effe dimmen, jongens!', 'efe dimen, iongens', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: effe dimmen' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Bajad el tono, chicos!' AND notes = 'Ejemplo de "effe dimmen" (geb.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: effe dimmen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: effe dimmen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Bajad el tono, chicos!' AND notes = 'Ejemplo de "effe dimmen" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Bajad el tono, chicos!' AND notes = 'Ejemplo de "effe dimmen" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 03. doe even rustig
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Tranquilo, que no pasa nada.', 'PHRASE', 'jerga: doe even rustig', 'DOE EVEN RUSTIG = tranquilo, cálmate, cálmate.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — tranquilo, cálmate = doe even rustig.
• en esta tarjeta — imperativo doe; er is niks aan de hand es otra frase hecha, no pasa nada.

📖 Palabra a palabra:

• rustig — tranquilo, de de rust, la calma.
• even — un momento; suaviza cualquier orden.

🧩 Expresión fija — doe even rustig:

• literal — haz un momento tranquilo.
• significa — cálmate.
• piezas fijas — doe más even más rustig; even suaviza la orden.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Doe even rustig, joh. | Tranquilo, hombre. |
| 2 | imperativo | Doe rustig aan met het bier. | Tómatelo con calma con la cerveza. |
| 3 | perfecto | Ik heb deze week rustig aan gedaan. | Esta semana me lo he tomado con calma. |

🎯 En qué contexto se usa:

• calmar a alguien nervioso o enfadado
• más suave que Doe normaal
• vale con casi todo el mundo, menos con el jefe

🔑 El truco que casi nunca falla: rustig es tranquilo, y even le quita dureza a cualquier orden.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: doe even rustig' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: doe even rustig' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Doe even rustig, er is niks aan de hand.', 'du efen rüstij, er is niks aan de hant', '• [geb.] Doe even rustig, joh. — Tranquilo, hombre.
• [geb.] Doe rustig aan met het bier. — Tómatelo con calma con la cerveza.
• [perf.] Ik heb deze week rustig aan gedaan. — Esta semana me lo he tomado con calma.
• [bijzin] Ik zei dat hij rustig moest doen. — Le dije que se calmara.
• [uitdr.] Rustig aan! — ¡Con calma!');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Tranquilo, hombre.', 'SENTENCE', 'Ejemplo de "doe even rustig" (geb.)', 'DOE EVEN RUSTIG = tranquilo, cálmate, cálmate.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — tranquilo, cálmate = doe even rustig.
• en esta tarjeta — imperativo doe; er is niks aan de hand es otra frase hecha, no pasa nada.

📖 Palabra a palabra:

• rustig — tranquilo, de de rust, la calma.
• even — un momento; suaviza cualquier orden.

🧩 Expresión fija — doe even rustig:

• literal — haz un momento tranquilo.
• significa — cálmate.
• piezas fijas — doe más even más rustig; even suaviza la orden.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Doe even rustig, joh. | Tranquilo, hombre. |
| 2 | imperativo | Doe rustig aan met het bier. | Tómatelo con calma con la cerveza. |
| 3 | perfecto | Ik heb deze week rustig aan gedaan. | Esta semana me lo he tomado con calma. |

🎯 En qué contexto se usa:

• calmar a alguien nervioso o enfadado
• más suave que Doe normaal
• vale con casi todo el mundo, menos con el jefe

🔑 El truco que casi nunca falla: rustig es tranquilo, y even le quita dureza a cualquier orden.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Tranquilo, hombre.' AND notes = 'Ejemplo de "doe even rustig" (geb.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Tranquilo, hombre.' AND notes = 'Ejemplo de "doe even rustig" (geb.)' LIMIT 1), 'nl_NL', 'Doe even rustig, joh.', 'du efen rüstij, ioh', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: doe even rustig' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Tranquilo, hombre.' AND notes = 'Ejemplo de "doe even rustig" (geb.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: doe even rustig' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: doe even rustig' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Tranquilo, hombre.' AND notes = 'Ejemplo de "doe even rustig" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Tranquilo, hombre.' AND notes = 'Ejemplo de "doe even rustig" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 04. kappen met iets
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Para ya con el móvil!', 'PHRASE', 'jerga: kappen met iets', 'KAPPEN MET IETS = para ya, déjalo, deja de hacer eso.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — para ya, déjalo = kappen met iets.
• en esta tarjeta — con la cosa nombrada, ermee pasa a met más la cosa; nou eens da impaciencia.

📖 Palabra a palabra:

• kappen — cortar, talar árboles; hablado, dejar algo.
• ermee — con ello, er más met.

🧩 Expresión fija — kappen met iets:

• literal — corta con ello.
• significa — deja de hacer eso.
• piezas fijas — kappen met iets, dejar algo; ermee cuando ya se sabe qué; kappen es débil, gekapt.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Kap ermee! | ¡Para ya! |
| 2 | perfecto | Ik ben met roken gekapt. | He dejado de fumar. |
| 3 | imperativo | Kappen nu! | ¡Para ahora mismo! |

🎯 En qué contexto se usa:

• padres con hijos, amigos que se pinchan
• Kappen! solo, para cortar una broma pesada
• también dejar algo del todo, Ik ben met roken gekapt

🔑 El truco que casi nunca falla: kappen es cortar, y cortas con la cosa.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: kappen met iets' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: kappen met iets' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Kap nou eens met die telefoon!', 'kap nau ens met di telefon', '• [geb.] Kap ermee! — ¡Para ya!
• [perf.] Ik ben met roken gekapt. — He dejado de fumar.
• [geb.] Kappen nu! — ¡Para ahora mismo!
• [bijzin] Ik wil dat je ermee kapt. — Quiero que lo dejes.
• [vraag] Kun je ermee kappen? — ¿Puedes parar?');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Para ya!', 'SENTENCE', 'Ejemplo de "kappen met iets" (geb.)', 'KAPPEN MET IETS = para ya, déjalo, deja de hacer eso.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — para ya, déjalo = kappen met iets.
• en esta tarjeta — con la cosa nombrada, ermee pasa a met más la cosa; nou eens da impaciencia.

📖 Palabra a palabra:

• kappen — cortar, talar árboles; hablado, dejar algo.
• ermee — con ello, er más met.

🧩 Expresión fija — kappen met iets:

• literal — corta con ello.
• significa — deja de hacer eso.
• piezas fijas — kappen met iets, dejar algo; ermee cuando ya se sabe qué; kappen es débil, gekapt.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Kap ermee! | ¡Para ya! |
| 2 | perfecto | Ik ben met roken gekapt. | He dejado de fumar. |
| 3 | imperativo | Kappen nu! | ¡Para ahora mismo! |

🎯 En qué contexto se usa:

• padres con hijos, amigos que se pinchan
• Kappen! solo, para cortar una broma pesada
• también dejar algo del todo, Ik ben met roken gekapt

🔑 El truco que casi nunca falla: kappen es cortar, y cortas con la cosa.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Para ya!' AND notes = 'Ejemplo de "kappen met iets" (geb.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Para ya!' AND notes = 'Ejemplo de "kappen met iets" (geb.)' LIMIT 1), 'nl_NL', 'Kap ermee!', 'kap erme', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: kappen met iets' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Para ya!' AND notes = 'Ejemplo de "kappen met iets" (geb.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: kappen met iets' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: kappen met iets' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Para ya!' AND notes = 'Ejemplo de "kappen met iets" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Para ya!' AND notes = 'Ejemplo de "kappen met iets" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 05. nergens op slaan
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Lo que dice no tiene ningún sentido. (él)', 'PHRASE', 'jerga: nergens op slaan', 'NERGENS OP SLAAN = no tener sentido, ser absurdo, no tener sentido.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no tener sentido = nergens op slaan.
• en esta tarjeta — el sujeto es lo dicho, la subordinada con wat, y slaat va justo detrás.

📖 Palabra a palabra:

• slaan op — referirse a, Waar slaat dat op? ¿A qué viene eso?.
• nergens — en ninguna parte, a nada.

🧩 Expresión fija — nergens op slaan:

• literal — no golpear en ninguna parte.
• significa — ser absurdo, no tener sentido.
• piezas fijas — slaan op, referirse a; nergens, a nada; el sujeto es la cosa.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dat slaat nergens op. | Eso no tiene sentido. |
| 2 | pregunta | Waar slaat dat op? | ¿A qué viene eso? |
| 3 | imperfecto | Zijn excuus sloeg nergens op. | Su excusa no tenía ningún sentido. |

🎯 En qué contexto se usa:

• planes, excusas o comentarios absurdos
• Waar slaat dat op? para quien suelta algo fuera de lugar
• de todas las edades, muy de hoy

🔑 El truco que casi nunca falla: si en español dirías no tiene sentido o a qué viene eso, es slaan op.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: nergens op slaan' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: nergens op slaan' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Wat hij zegt, slaat nergens op.', 'vat hei sejt, slaat nerjens op', '• [can.] Dat slaat nergens op. — Eso no tiene sentido.
• [vraag] Waar slaat dat op? — ¿A qué viene eso?
• [imperf.] Zijn excuus sloeg nergens op. — Su excusa no tenía ningún sentido.
• [bijzin] Ik vind dat het nergens op slaat. — Me parece que no tiene sentido.
• [perf.] Wat je net hebt gezegd, slaat nergens op. — Lo que acabas de decir no tiene sentido.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Eso no tiene sentido.', 'SENTENCE', 'Ejemplo de "nergens op slaan" (can.)', 'NERGENS OP SLAAN = no tener sentido, ser absurdo, no tener sentido.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no tener sentido = nergens op slaan.
• en esta tarjeta — el sujeto es lo dicho, la subordinada con wat, y slaat va justo detrás.

📖 Palabra a palabra:

• slaan op — referirse a, Waar slaat dat op? ¿A qué viene eso?.
• nergens — en ninguna parte, a nada.

🧩 Expresión fija — nergens op slaan:

• literal — no golpear en ninguna parte.
• significa — ser absurdo, no tener sentido.
• piezas fijas — slaan op, referirse a; nergens, a nada; el sujeto es la cosa.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dat slaat nergens op. | Eso no tiene sentido. |
| 2 | pregunta | Waar slaat dat op? | ¿A qué viene eso? |
| 3 | imperfecto | Zijn excuus sloeg nergens op. | Su excusa no tenía ningún sentido. |

🎯 En qué contexto se usa:

• planes, excusas o comentarios absurdos
• Waar slaat dat op? para quien suelta algo fuera de lugar
• de todas las edades, muy de hoy

🔑 El truco que casi nunca falla: si en español dirías no tiene sentido o a qué viene eso, es slaan op.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Eso no tiene sentido.' AND notes = 'Ejemplo de "nergens op slaan" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso no tiene sentido.' AND notes = 'Ejemplo de "nergens op slaan" (can.)' LIMIT 1), 'nl_NL', 'Dat slaat nergens op.', 'dat slaat nerjens op', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: nergens op slaan' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Eso no tiene sentido.' AND notes = 'Ejemplo de "nergens op slaan" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: nergens op slaan' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: nergens op slaan' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Eso no tiene sentido.' AND notes = 'Ejemplo de "nergens op slaan" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Eso no tiene sentido.' AND notes = 'Ejemplo de "nergens op slaan" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 06. er klaar mee zijn
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Estoy harto de este trabajo.', 'PHRASE', 'jerga: er klaar mee zijn', 'ER KLAAR MEE ZIJN = estar harto, pasar de algo, estar harto, no aguantar más.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar harto, pasar de algo = er klaar mee zijn.
• en esta tarjeta — con la cosa nombrada, er … mee pasa a met más la cosa; helemaal refuerza.

📖 Palabra a palabra:

• klaar — listo, terminado.
• er … mee — con ello.

🧩 Expresión fija — er klaar mee zijn:

• literal — estar listo con ello.
• significa — estar harto, no aguantar más.
• piezas fijas — er … mee, o met iets; klaar es terminado y el hartazgo lo pone el tono.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben er klaar mee. | Estoy harto. |
| 2 | principal | Ze is helemaal klaar met haar ex. | Está harta de su ex. |
| 3 | imperfecto | Na drie jaar was ik er klaar mee. | Después de tres años estaba harto. |

🎯 En qué contexto se usa:

• hartazgo con una persona, un trabajo o una situación
• muy de hoy, en jóvenes y adultos
• ⚠️ Ik ben klaar a secas es he terminado, sin enfado

🔑 El truco que casi nunca falla: si suena a ya está bien, es klaar mee, si suena a he acabado los deberes, es klaar a secas.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: er klaar mee zijn' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: er klaar mee zijn' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Ik ben helemaal klaar met dit werk.', 'ik ben helemaal klaar met dit verk', '• [can.] Ik ben er klaar mee. — Estoy harto.
• [can.] Ze is helemaal klaar met haar ex. — Está harta de su ex.
• [imperf.] Na drie jaar was ik er klaar mee. — Después de tres años estaba harto.
• [bijzin] Ik snap dat je er klaar mee bent. — Entiendo que estés harto.
• [vraag] Ben je er nu al klaar mee? — ¿Ya estás harto?');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Estoy harto.', 'SENTENCE', 'Ejemplo de "er klaar mee zijn" (can.)', 'ER KLAAR MEE ZIJN = estar harto, pasar de algo, estar harto, no aguantar más.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar harto, pasar de algo = er klaar mee zijn.
• en esta tarjeta — con la cosa nombrada, er … mee pasa a met más la cosa; helemaal refuerza.

📖 Palabra a palabra:

• klaar — listo, terminado.
• er … mee — con ello.

🧩 Expresión fija — er klaar mee zijn:

• literal — estar listo con ello.
• significa — estar harto, no aguantar más.
• piezas fijas — er … mee, o met iets; klaar es terminado y el hartazgo lo pone el tono.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben er klaar mee. | Estoy harto. |
| 2 | principal | Ze is helemaal klaar met haar ex. | Está harta de su ex. |
| 3 | imperfecto | Na drie jaar was ik er klaar mee. | Después de tres años estaba harto. |

🎯 En qué contexto se usa:

• hartazgo con una persona, un trabajo o una situación
• muy de hoy, en jóvenes y adultos
• ⚠️ Ik ben klaar a secas es he terminado, sin enfado

🔑 El truco que casi nunca falla: si suena a ya está bien, es klaar mee, si suena a he acabado los deberes, es klaar a secas.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Estoy harto.' AND notes = 'Ejemplo de "er klaar mee zijn" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy harto.' AND notes = 'Ejemplo de "er klaar mee zijn" (can.)' LIMIT 1), 'nl_NL', 'Ik ben er klaar mee.', 'ik ben er klaar me', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: er klaar mee zijn' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Estoy harto.' AND notes = 'Ejemplo de "er klaar mee zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: er klaar mee zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: er klaar mee zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Estoy harto.' AND notes = 'Ejemplo de "er klaar mee zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Estoy harto.' AND notes = 'Ejemplo de "er klaar mee zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 07. boeien
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me da igual lo que piensen.', 'PHRASE', 'jerga: boeien', 'BOEIEN = me da igual, y a mí qué, me da igual.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — me da igual, y a mí qué = boeien.
• en esta tarjeta — boeien con het de sujeto, como interesar; la persona va en me y lo que no importa detrás.

📖 Palabra a palabra:

• boeien — cautivar, interesar; een boeiend boek es un libro apasionante.
• Boeien! — solo y con ironía, es me la trae floja.

🧩 Expresión fija — boeien:

• literal — cautivar, interesar.
• significa — me da igual.
• piezas fijas — Het boeit me niet en una frase; Boeien! solo, con ironía.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Boeien! | ¡Me da igual! |
| 2 | principal | Het boeit me echt niks. | Me importa nada. |
| 3 | imperfecto | Het boeide hem niet. | Le daba igual. |

🎯 En qué contexto se usa:

• ⚠️ Boeien! a secas suena chulo y desinteresado, muy de adolescentes
• Het boeit me niet es más neutro
• en lenguaje cuidado boeiend es interesante, sin ironía

🔑 El truco que casi nunca falla: boeiend es interesante, y Boeien! con ironía es justo lo contrario.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: boeien' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: boeien' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Het boeit me niet wat ze denken.', 'het boeit me nit vat se denken', '• [uitdr.] Boeien! — ¡Me da igual!
• [can.] Het boeit me echt niks. — Me importa nada.
• [imperf.] Het boeide hem niet. — Le daba igual.
• [bijzin] Ik zei dat het me niet boeide. — Dije que me daba igual.
• [can.] Dit boek is heel boeiend. — Este libro es muy interesante.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Me da igual!', 'SENTENCE', 'Ejemplo de "boeien" (uitdr.)', 'BOEIEN = me da igual, y a mí qué, me da igual.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — me da igual, y a mí qué = boeien.
• en esta tarjeta — boeien con het de sujeto, como interesar; la persona va en me y lo que no importa detrás.

📖 Palabra a palabra:

• boeien — cautivar, interesar; een boeiend boek es un libro apasionante.
• Boeien! — solo y con ironía, es me la trae floja.

🧩 Expresión fija — boeien:

• literal — cautivar, interesar.
• significa — me da igual.
• piezas fijas — Het boeit me niet en una frase; Boeien! solo, con ironía.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Boeien! | ¡Me da igual! |
| 2 | principal | Het boeit me echt niks. | Me importa nada. |
| 3 | imperfecto | Het boeide hem niet. | Le daba igual. |

🎯 En qué contexto se usa:

• ⚠️ Boeien! a secas suena chulo y desinteresado, muy de adolescentes
• Het boeit me niet es más neutro
• en lenguaje cuidado boeiend es interesante, sin ironía

🔑 El truco que casi nunca falla: boeiend es interesante, y Boeien! con ironía es justo lo contrario.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Me da igual!' AND notes = 'Ejemplo de "boeien" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Me da igual!' AND notes = 'Ejemplo de "boeien" (uitdr.)' LIMIT 1), 'nl_NL', 'Boeien!', 'boeien', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: boeien' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Me da igual!' AND notes = 'Ejemplo de "boeien" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: boeien' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: boeien' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Me da igual!' AND notes = 'Ejemplo de "boeien" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Me da igual!' AND notes = 'Ejemplo de "boeien" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 08. niet normaal
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Esta tarta está buenísima.', 'PHRASE', 'jerga: niet normaal', 'NIET NORMAAL = increíble, una pasada, increíble, exagerado, para bien o para mal.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — increíble, una pasada = niet normaal.
• en esta tarjeta — niet normaal va delante del adjetivo y lo refuerza, como súper.

📖 Palabra a palabra:

• normaal — normal; niet normaal es fuera de lo normal.

🧩 Expresión fija — niet normaal:

• literal — no normal.
• significa — increíble, exagerado, para bien o para mal.
• piezas fijas — niet normaal más adjetivo, niet normaal lekker; solo, Niet normaal!.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Niet normaal! | ¡Increíble! |
| 2 | principal | Het is hier niet normaal druk. | Aquí hay una locura de gente. |
| 3 | imperfecto | Het concert was niet normaal goed. | El concierto fue una pasada. |

🎯 En qué contexto se usa:

• muy de jóvenes y adultos jóvenes para exagerar
• para bien y para mal, Het is niet normaal druk, hay una locura de gente
• registro coloquial

🔑 El truco que casi nunca falla: si en español pondrías súper o una pasada, pon niet normaal delante del adjetivo.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: niet normaal' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: niet normaal' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Deze taart is niet normaal lekker.', 'dese taart is nit normaal leker', '• [uitdr.] Niet normaal! — ¡Increíble!
• [can.] Het is hier niet normaal druk. — Aquí hay una locura de gente.
• [imperf.] Het concert was niet normaal goed. — El concierto fue una pasada.
• [bijzin] Ik vind het niet normaal hoe duur het is. — Me parece increíble lo caro que es.
• [perf.] Ik heb niet normaal gelachen. — Me he reído un montón.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Increíble!', 'SENTENCE', 'Ejemplo de "niet normaal" (uitdr.)', 'NIET NORMAAL = increíble, una pasada, increíble, exagerado, para bien o para mal.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — increíble, una pasada = niet normaal.
• en esta tarjeta — niet normaal va delante del adjetivo y lo refuerza, como súper.

📖 Palabra a palabra:

• normaal — normal; niet normaal es fuera de lo normal.

🧩 Expresión fija — niet normaal:

• literal — no normal.
• significa — increíble, exagerado, para bien o para mal.
• piezas fijas — niet normaal más adjetivo, niet normaal lekker; solo, Niet normaal!.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Niet normaal! | ¡Increíble! |
| 2 | principal | Het is hier niet normaal druk. | Aquí hay una locura de gente. |
| 3 | imperfecto | Het concert was niet normaal goed. | El concierto fue una pasada. |

🎯 En qué contexto se usa:

• muy de jóvenes y adultos jóvenes para exagerar
• para bien y para mal, Het is niet normaal druk, hay una locura de gente
• registro coloquial

🔑 El truco que casi nunca falla: si en español pondrías súper o una pasada, pon niet normaal delante del adjetivo.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Increíble!' AND notes = 'Ejemplo de "niet normaal" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Increíble!' AND notes = 'Ejemplo de "niet normaal" (uitdr.)' LIMIT 1), 'nl_NL', 'Niet normaal!', 'nit normaal', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: niet normaal' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Increíble!' AND notes = 'Ejemplo de "niet normaal" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: niet normaal' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: niet normaal' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Increíble!' AND notes = 'Ejemplo de "niet normaal" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Increíble!' AND notes = 'Ejemplo de "niet normaal" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 09. balen van iets
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Qué rabia que no puedas venir!', 'PHRASE', 'jerga: balen van iets', 'BALEN VAN IETS = fastidiarse, qué rabia, fastidiarse, llevarse un chasco.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — fastidiarse, qué rabia = balen van iets.
• en esta tarjeta — Balen solo hace de exclamación y la subordinada con dat dice por qué.

📖 Palabra a palabra:

• balen — fastidiarse; casi no tiene otro sentido.
• ervan — de ello, er más van.

🧩 Expresión fija — balen van iets:

• literal — estar harto de algo.
• significa — fastidiarse, llevarse un chasco.
• piezas fijas — balen van iets, o ervan; balen es débil, gebaald.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Balen! | ¡Qué rabia! |
| 2 | principal | Ik baal ervan. | Me fastidia. |
| 3 | perfecto | Hij heeft echt gebaald van die uitslag. | Le ha fastidiado mucho ese resultado. |

🎯 En qué contexto se usa:

• planes que se cancelan, partidos perdidos, notas malas
• Balen! solo, qué rabia, de todas las edades
• también Wat een baalweek, qué semana más mala

🔑 El truco que casi nunca falla: balen van es fastidiarse por algo, y Balen! solo es qué rabia.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: balen van iets' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: balen van iets' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Balen dat je niet kunt komen!', 'balen dat ie nit künt komen', '• [uitdr.] Balen! — ¡Qué rabia!
• [can.] Ik baal ervan. — Me fastidia.
• [perf.] Hij heeft echt gebaald van die uitslag. — Le ha fastidiado mucho ese resultado.
• [bijzin] Ik snap dat je ervan baalt. — Entiendo que te fastidie.
• [imperf.] Ze baalde van het weer. — Le fastidió el tiempo.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Qué rabia!', 'SENTENCE', 'Ejemplo de "balen van iets" (uitdr.)', 'BALEN VAN IETS = fastidiarse, qué rabia, fastidiarse, llevarse un chasco.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — fastidiarse, qué rabia = balen van iets.
• en esta tarjeta — Balen solo hace de exclamación y la subordinada con dat dice por qué.

📖 Palabra a palabra:

• balen — fastidiarse; casi no tiene otro sentido.
• ervan — de ello, er más van.

🧩 Expresión fija — balen van iets:

• literal — estar harto de algo.
• significa — fastidiarse, llevarse un chasco.
• piezas fijas — balen van iets, o ervan; balen es débil, gebaald.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Balen! | ¡Qué rabia! |
| 2 | principal | Ik baal ervan. | Me fastidia. |
| 3 | perfecto | Hij heeft echt gebaald van die uitslag. | Le ha fastidiado mucho ese resultado. |

🎯 En qué contexto se usa:

• planes que se cancelan, partidos perdidos, notas malas
• Balen! solo, qué rabia, de todas las edades
• también Wat een baalweek, qué semana más mala

🔑 El truco que casi nunca falla: balen van es fastidiarse por algo, y Balen! solo es qué rabia.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Qué rabia!' AND notes = 'Ejemplo de "balen van iets" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Qué rabia!' AND notes = 'Ejemplo de "balen van iets" (uitdr.)' LIMIT 1), 'nl_NL', 'Balen!', 'balen', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: balen van iets' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Qué rabia!' AND notes = 'Ejemplo de "balen van iets" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: balen van iets' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: balen van iets' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Qué rabia!' AND notes = 'Ejemplo de "balen van iets" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Qué rabia!' AND notes = 'Ejemplo de "balen van iets" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 10. het niet zien zitten
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No me veo capaz de correr la maratón.', 'PHRASE', 'jerga: het niet zien zitten', 'HET NIET ZIEN ZITTEN = no verlo claro, no apetecer, no verlo claro, no tener ganas ni confianza.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no verlo claro, no apetecer = het niet zien zitten.
• en esta tarjeta — het anticipa lo que no ves claro, y om … te más infinitivo va al final.

📖 Palabra a palabra:

• zien — ver.
• zitten — estar sentado; aquí estar bien colocado, funcionar.

🧩 Expresión fija — het niet zien zitten:

• literal — no verlo sentado.
• significa — no verlo claro, no tener ganas ni confianza.
• piezas fijas — het … zien zitten; con una persona y wel, iemand wel zien zitten, es que te gusta.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik zie het niet zitten. | No lo veo claro. |
| 2 | principal | Ik zie hem wel zitten. | Él me gusta. |
| 3 | imperfecto | Ze zag het niet zitten om alleen te gaan. | No le apetecía ir sola. |

🎯 En qué contexto se usa:

• dudas antes de un plan, un examen o una cita
• ⚠️ Ik zie hem wel zitten es él me gusta, flirteo
• de todas las edades

🔑 El truco que casi nunca falla: con het es no verlo claro, con una persona y wel es que te gusta.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: het niet zien zitten' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: het niet zien zitten' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Ik zie het niet zitten om de marathon te lopen.', 'ik si het nit siten om de marathon te lopen', '• [can.] Ik zie het niet zitten. — No lo veo claro.
• [can.] Ik zie hem wel zitten. — Él me gusta.
• [imperf.] Ze zag het niet zitten om alleen te gaan. — No le apetecía ir sola.
• [bijzin] Ik begrijp dat je het niet ziet zitten. — Entiendo que no lo veas claro.
• [vraag] Zie je het zitten? — ¿Lo ves claro?');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No lo veo claro.', 'SENTENCE', 'Ejemplo de "het niet zien zitten" (can.)', 'HET NIET ZIEN ZITTEN = no verlo claro, no apetecer, no verlo claro, no tener ganas ni confianza.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no verlo claro, no apetecer = het niet zien zitten.
• en esta tarjeta — het anticipa lo que no ves claro, y om … te más infinitivo va al final.

📖 Palabra a palabra:

• zien — ver.
• zitten — estar sentado; aquí estar bien colocado, funcionar.

🧩 Expresión fija — het niet zien zitten:

• literal — no verlo sentado.
• significa — no verlo claro, no tener ganas ni confianza.
• piezas fijas — het … zien zitten; con una persona y wel, iemand wel zien zitten, es que te gusta.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik zie het niet zitten. | No lo veo claro. |
| 2 | principal | Ik zie hem wel zitten. | Él me gusta. |
| 3 | imperfecto | Ze zag het niet zitten om alleen te gaan. | No le apetecía ir sola. |

🎯 En qué contexto se usa:

• dudas antes de un plan, un examen o una cita
• ⚠️ Ik zie hem wel zitten es él me gusta, flirteo
• de todas las edades

🔑 El truco que casi nunca falla: con het es no verlo claro, con una persona y wel es que te gusta.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No lo veo claro.' AND notes = 'Ejemplo de "het niet zien zitten" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'No lo veo claro.' AND notes = 'Ejemplo de "het niet zien zitten" (can.)' LIMIT 1), 'nl_NL', 'Ik zie het niet zitten.', 'ik si het nit siten', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: het niet zien zitten' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No lo veo claro.' AND notes = 'Ejemplo de "het niet zien zitten" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: het niet zien zitten' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: het niet zien zitten' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'No lo veo claro.' AND notes = 'Ejemplo de "het niet zien zitten" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'No lo veo claro.' AND notes = 'Ejemplo de "het niet zien zitten" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 11. vet
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Qué guay, tus zapatillas nuevas!', 'PHRASE', 'jerga: vet', 'VET = guay, guay, chulo.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — guay = vet.
• en esta tarjeta — wat más adjetivo es qué más adjetivo, Wat vet.

📖 Palabra a palabra:

• vet — gordo, grasiento en el sentido normal; het vet es la grasa.

🧩 Expresión fija — vet:

• literal — gordo, grasiento.
• significa — guay, chulo.
• piezas fijas — vet solo, wat vet, o el superlativo supervet.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Vet! | ¡Guay! |
| 2 | principal | Dat is echt vet. | Eso es muy guay. |
| 3 | imperfecto | Het feest was supervet. | La fiesta fue guay a tope. |

🎯 En qué contexto se usa:

• la palabra de aprobación de niños y adolescentes
• los adultos dicen más gaaf o leuk
• superlativo de jóvenes, supervet

🔑 El truco que casi nunca falla: lo que en español es guay, en neerlandés joven es vet.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: vet' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: vet' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Wat vet, je nieuwe sneakers!', 'vat fet, ie niöue sneakers', '• [uitdr.] Vet! — ¡Guay!
• [can.] Dat is echt vet. — Eso es muy guay.
• [imperf.] Het feest was supervet. — La fiesta fue guay a tope.
• [bijzin] Ik vind het vet dat je meegaat. — Me parece guay que vengas.
• [vraag] Is dat niet vet? — ¿No es guay?');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Guay!', 'SENTENCE', 'Ejemplo de "vet" (uitdr.)', 'VET = guay, guay, chulo.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — guay = vet.
• en esta tarjeta — wat más adjetivo es qué más adjetivo, Wat vet.

📖 Palabra a palabra:

• vet — gordo, grasiento en el sentido normal; het vet es la grasa.

🧩 Expresión fija — vet:

• literal — gordo, grasiento.
• significa — guay, chulo.
• piezas fijas — vet solo, wat vet, o el superlativo supervet.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Vet! | ¡Guay! |
| 2 | principal | Dat is echt vet. | Eso es muy guay. |
| 3 | imperfecto | Het feest was supervet. | La fiesta fue guay a tope. |

🎯 En qué contexto se usa:

• la palabra de aprobación de niños y adolescentes
• los adultos dicen más gaaf o leuk
• superlativo de jóvenes, supervet

🔑 El truco que casi nunca falla: lo que en español es guay, en neerlandés joven es vet.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Guay!' AND notes = 'Ejemplo de "vet" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Guay!' AND notes = 'Ejemplo de "vet" (uitdr.)' LIMIT 1), 'nl_NL', 'Vet!', 'fet', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: vet' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Guay!' AND notes = 'Ejemplo de "vet" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: vet' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: vet' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Guay!' AND notes = 'Ejemplo de "vet" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Guay!' AND notes = 'Ejemplo de "vet" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 12. echt ziek
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'El gol de ayer fue brutal.', 'PHRASE', 'jerga: echt ziek', 'ECHT ZIEK = brutal, impresionante, entre jóvenes, brutal, impresionante.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — brutal, impresionante = echt ziek.
• en esta tarjeta — ziek va detrás de zijn, con echt para reforzar.

📖 Palabra a palabra:

• ziek — enfermo, el sentido normal de siempre.
• echt — de verdad, muy; el refuerzo de todo.

🧩 Expresión fija — echt ziek:

• literal — enfermo.
• significa — entre jóvenes, brutal, impresionante.
• piezas fijas — solo detrás del verbo, Dat is ziek, con echt delante.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dat is echt ziek! | ¡Eso es brutal! |
| 2 | imperfecto | Het concert was ziek. | El concierto fue brutal. |
| 3 | principal | Ik ben ziek. | Estoy enfermo. |

🎯 En qué contexto se usa:

• ⚠️ solo jóvenes y solo para cosas, nunca hablando de alguien enfermo
• también negativo, Dat is ziek, eso es enfermizo, retorcido
• el tono lo decide, ilusión o asco

🔑 El truco que casi nunca falla: si lo dice un chaval con ilusión es brutal, si lo dice un adulto con asco es enfermizo.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: echt ziek' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: echt ziek' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Die goal van gisteren was echt ziek.', 'di joal fan jisteren vas ejt sik', '• [can.] Dat is echt ziek! — ¡Eso es brutal!
• [imperf.] Het concert was ziek. — El concierto fue brutal.
• [can.] Ik ben ziek. — Estoy enfermo.
• [bijzin] Hij zegt dat de nieuwe game ziek is. — Dice que el juego nuevo es brutal.
• [uitdr.] Wat een zieke actie! — ¡Qué jugada más brutal!');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Eso es brutal!', 'SENTENCE', 'Ejemplo de "echt ziek" (can.)', 'ECHT ZIEK = brutal, impresionante, entre jóvenes, brutal, impresionante.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — brutal, impresionante = echt ziek.
• en esta tarjeta — ziek va detrás de zijn, con echt para reforzar.

📖 Palabra a palabra:

• ziek — enfermo, el sentido normal de siempre.
• echt — de verdad, muy; el refuerzo de todo.

🧩 Expresión fija — echt ziek:

• literal — enfermo.
• significa — entre jóvenes, brutal, impresionante.
• piezas fijas — solo detrás del verbo, Dat is ziek, con echt delante.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dat is echt ziek! | ¡Eso es brutal! |
| 2 | imperfecto | Het concert was ziek. | El concierto fue brutal. |
| 3 | principal | Ik ben ziek. | Estoy enfermo. |

🎯 En qué contexto se usa:

• ⚠️ solo jóvenes y solo para cosas, nunca hablando de alguien enfermo
• también negativo, Dat is ziek, eso es enfermizo, retorcido
• el tono lo decide, ilusión o asco

🔑 El truco que casi nunca falla: si lo dice un chaval con ilusión es brutal, si lo dice un adulto con asco es enfermizo.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Eso es brutal!' AND notes = 'Ejemplo de "echt ziek" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Eso es brutal!' AND notes = 'Ejemplo de "echt ziek" (can.)' LIMIT 1), 'nl_NL', 'Dat is echt ziek!', 'dat is ejt sik', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: echt ziek' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Eso es brutal!' AND notes = 'Ejemplo de "echt ziek" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: echt ziek' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: echt ziek' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Eso es brutal!' AND notes = 'Ejemplo de "echt ziek" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Eso es brutal!' AND notes = 'Ejemplo de "echt ziek" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 13. chillen
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Esta tarde voy a relajarme con mis amigos. (inv)', 'PHRASE', 'jerga: chillen', 'CHILLEN = relajarse, estar tranqui, relajarse, pasar el rato.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — relajarse, estar tranqui = chillen.
• en esta tarjeta — con gaan, chillen va en infinitivo; tras vanmiddag, ga ik.

📖 Palabra a palabra:

• chill — tranquilo, agradable, del inglés.
• chillen — relajarse, pasar el rato.

🧩 Expresión fija — chillen:

• literal — del inglés to chill.
• significa — relajarse, pasar el rato.
• piezas fijas — chill como adjetivo, Dat is chill; chillen como verbo débil, gechilld.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Laten we even chillen. | Vamos a relajarnos un rato. |
| 2 | principal | Dat is chill. | Eso está genial. |
| 3 | perfecto | We hebben de hele dag gechilld. | Hemos estado de relax todo el día. |

🎯 En qué contexto se usa:

• planes tranquilos entre amigos
• de adolescentes y jóvenes, y ya también adultos
• Chill! solo, perfecto, genial

🔑 El truco que casi nunca falla: el inglés chill entra entero y se conjuga como un verbo neerlandés.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: chillen' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: chillen' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Vanmiddag ga ik chillen met mijn vrienden.', 'fanmidaj ja ik jilen met mein frinden', '• [geb.] Laten we even chillen. — Vamos a relajarnos un rato.
• [can.] Dat is chill. — Eso está genial.
• [perf.] We hebben de hele dag gechilld. — Hemos estado de relax todo el día.
• [bijzin] Ik vind het chill dat je komt. — Me parece genial que vengas.
• [vraag] Ga je mee chillen? — ¿Te vienes a pasar el rato?');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Vamos a relajarnos un rato.', 'SENTENCE', 'Ejemplo de "chillen" (geb.)', 'CHILLEN = relajarse, estar tranqui, relajarse, pasar el rato.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — relajarse, estar tranqui = chillen.
• en esta tarjeta — con gaan, chillen va en infinitivo; tras vanmiddag, ga ik.

📖 Palabra a palabra:

• chill — tranquilo, agradable, del inglés.
• chillen — relajarse, pasar el rato.

🧩 Expresión fija — chillen:

• literal — del inglés to chill.
• significa — relajarse, pasar el rato.
• piezas fijas — chill como adjetivo, Dat is chill; chillen como verbo débil, gechilld.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperativo | Laten we even chillen. | Vamos a relajarnos un rato. |
| 2 | principal | Dat is chill. | Eso está genial. |
| 3 | perfecto | We hebben de hele dag gechilld. | Hemos estado de relax todo el día. |

🎯 En qué contexto se usa:

• planes tranquilos entre amigos
• de adolescentes y jóvenes, y ya también adultos
• Chill! solo, perfecto, genial

🔑 El truco que casi nunca falla: el inglés chill entra entero y se conjuga como un verbo neerlandés.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Vamos a relajarnos un rato.' AND notes = 'Ejemplo de "chillen" (geb.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Vamos a relajarnos un rato.' AND notes = 'Ejemplo de "chillen" (geb.)' LIMIT 1), 'nl_NL', 'Laten we even chillen.', 'laten ve efen jilen', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: chillen' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Vamos a relajarnos un rato.' AND notes = 'Ejemplo de "chillen" (geb.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: chillen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: chillen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Vamos a relajarnos un rato.' AND notes = 'Ejemplo de "chillen" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Vamos a relajarnos un rato.' AND notes = 'Ejemplo de "chillen" (geb.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 14. cringe
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ese vídeo da vergüenza ajena.', 'PHRASE', 'jerga: cringe', 'CRINGE = dar vergüenza ajena, que da vergüenza ajena.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — dar vergüenza ajena = cringe.
• en esta tarjeta — cringe va detrás de zijn, y zo lo refuerza.

📖 Palabra a palabra:

• cringe — vergüenza ajena, del inglés.
• zo — tan, muy; refuerza el adjetivo.

🧩 Expresión fija — cringe:

• literal — del inglés to cringe, encogerse.
• significa — que da vergüenza ajena.
• piezas fijas — como adjetivo, Dat is cringe; como verbo, cringen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dat is zo cringe. | Eso da muchísima vergüenza ajena. |
| 2 | imperfecto | Mijn vader danste en het was zo cringe. | Mi padre bailaba y daba muchísima vergüenza ajena. |
| 3 | principal | Ik cringe als ik dat zie. | Me muero de vergüenza ajena cuando lo veo. |

🎯 En qué contexto se usa:

• vídeos, padres que bailan, mensajes de amor exagerados
• sobre todo adolescentes
• los adultos dicen plaatsvervangende schaamte

🔑 El truco que casi nunca falla: si en español es vergüenza ajena, el adolescente dice cringe.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: cringe' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: cringe' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Die video is zo cringe.', 'di fideo is so kringe', '• [can.] Dat is zo cringe. — Eso da muchísima vergüenza ajena.
• [imperf.] Mijn vader danste en het was zo cringe. — Mi padre bailaba y daba muchísima vergüenza ajena.
• [can.] Ik cringe als ik dat zie. — Me muero de vergüenza ajena cuando lo veo.
• [bijzin] Ze vindt het cringe dat ik haar foto deel. — Le da vergüenza que comparta su foto.
• [uitdr.] Ik voel plaatsvervangende schaamte. — Siento vergüenza ajena.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Eso da muchísima vergüenza ajena.', 'SENTENCE', 'Ejemplo de "cringe" (can.)', 'CRINGE = dar vergüenza ajena, que da vergüenza ajena.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — dar vergüenza ajena = cringe.
• en esta tarjeta — cringe va detrás de zijn, y zo lo refuerza.

📖 Palabra a palabra:

• cringe — vergüenza ajena, del inglés.
• zo — tan, muy; refuerza el adjetivo.

🧩 Expresión fija — cringe:

• literal — del inglés to cringe, encogerse.
• significa — que da vergüenza ajena.
• piezas fijas — como adjetivo, Dat is cringe; como verbo, cringen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Dat is zo cringe. | Eso da muchísima vergüenza ajena. |
| 2 | imperfecto | Mijn vader danste en het was zo cringe. | Mi padre bailaba y daba muchísima vergüenza ajena. |
| 3 | principal | Ik cringe als ik dat zie. | Me muero de vergüenza ajena cuando lo veo. |

🎯 En qué contexto se usa:

• vídeos, padres que bailan, mensajes de amor exagerados
• sobre todo adolescentes
• los adultos dicen plaatsvervangende schaamte

🔑 El truco que casi nunca falla: si en español es vergüenza ajena, el adolescente dice cringe.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Eso da muchísima vergüenza ajena.' AND notes = 'Ejemplo de "cringe" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Eso da muchísima vergüenza ajena.' AND notes = 'Ejemplo de "cringe" (can.)' LIMIT 1), 'nl_NL', 'Dat is zo cringe.', 'dat is so kringe', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: cringe' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Eso da muchísima vergüenza ajena.' AND notes = 'Ejemplo de "cringe" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: cringe' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: cringe' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Eso da muchísima vergüenza ajena.' AND notes = 'Ejemplo de "cringe" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Eso da muchísima vergüenza ajena.' AND notes = 'Ejemplo de "cringe" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 15. flexen
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Siempre está fardando de su coche nuevo. (él)', 'PHRASE', 'jerga: flexen', 'FLEXEN = fardar, presumir, presumir, fardar.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — fardar, presumir = flexen.
• en esta tarjeta — lopen te más infinitivo es andar haciendo algo; flexen met más lo que se presume.

📖 Palabra a palabra:

• flexen — fardar, del inglés.
• lopen te — andar haciendo algo, Hij loopt te zeuren.

🧩 Expresión fija — flexen:

• literal — del inglés to flex, sacar músculo.
• significa — presumir, fardar.
• piezas fijas — flexen met iets; débil, geflext.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij is weer aan het flexen. | Ya está fardando otra vez. |
| 2 | perfecto | Ze heeft op Instagram geflext met haar tas. | Ha fardado de bolso en Instagram. |
| 3 | imperativo | Stop met flexen. | Deja de fardar. |

🎯 En qué contexto se usa:

• redes sociales, ropa, coches, notas
• de jóvenes; el adulto dice opscheppen
• casi siempre como crítica

🔑 El truco que casi nunca falla: flexen es sacar músculo, presumes como quien enseña el bíceps.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: flexen' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: flexen' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Hij loopt altijd te flexen met zijn nieuwe auto.', 'hei lopt alteit te fleksen met sein niöue auto', '• [can.] Hij is weer aan het flexen. — Ya está fardando otra vez.
• [perf.] Ze heeft op Instagram geflext met haar tas. — Ha fardado de bolso en Instagram.
• [geb.] Stop met flexen. — Deja de fardar.
• [bijzin] Ik haat het als mensen flexen. — Odio que la gente farde.
• [uitdr.] Hij schept altijd op. — Siempre presume.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ya está fardando otra vez.', 'SENTENCE', 'Ejemplo de "flexen" (can.)', 'FLEXEN = fardar, presumir, presumir, fardar.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — fardar, presumir = flexen.
• en esta tarjeta — lopen te más infinitivo es andar haciendo algo; flexen met más lo que se presume.

📖 Palabra a palabra:

• flexen — fardar, del inglés.
• lopen te — andar haciendo algo, Hij loopt te zeuren.

🧩 Expresión fija — flexen:

• literal — del inglés to flex, sacar músculo.
• significa — presumir, fardar.
• piezas fijas — flexen met iets; débil, geflext.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij is weer aan het flexen. | Ya está fardando otra vez. |
| 2 | perfecto | Ze heeft op Instagram geflext met haar tas. | Ha fardado de bolso en Instagram. |
| 3 | imperativo | Stop met flexen. | Deja de fardar. |

🎯 En qué contexto se usa:

• redes sociales, ropa, coches, notas
• de jóvenes; el adulto dice opscheppen
• casi siempre como crítica

🔑 El truco que casi nunca falla: flexen es sacar músculo, presumes como quien enseña el bíceps.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ya está fardando otra vez.' AND notes = 'Ejemplo de "flexen" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya está fardando otra vez.' AND notes = 'Ejemplo de "flexen" (can.)' LIMIT 1), 'nl_NL', 'Hij is weer aan het flexen.', 'hei is ver aan het fleksen', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: flexen' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Ya está fardando otra vez.' AND notes = 'Ejemplo de "flexen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: flexen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: flexen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Ya está fardando otra vez.' AND notes = 'Ejemplo de "flexen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Ya está fardando otra vez.' AND notes = 'Ejemplo de "flexen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 16. lekker bezig
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Bien hecho, ya has terminado los deberes!', 'PHRASE', 'jerga: lekker bezig', 'LEKKER BEZIG = bien hecho, bien hecho, sigue así; también irónico.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — bien hecho = lekker bezig.
• en esta tarjeta — la fórmula va sola delante; af zijn es estar terminado.

📖 Palabra a palabra:

• lekker — rico, sabroso; hablado refuerza casi todo, lekker weer, buen tiempo.
• bezig — ocupado, haciendo algo.

🧩 Expresión fija — lekker bezig:

• literal — rico ocupado.
• significa — bien hecho, sigue así; también irónico.
• piezas fijas — lekker más bezig, sin verbo; con verbo, Je bent lekker bezig.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Lekker bezig! | ¡Bien hecho! |
| 2 | principal | Je bent lekker bezig. | Lo estás haciendo genial. |
| 3 | imperfecto | Hij was lekker bezig in de tuin. | Estaba a gusto trabajando en el jardín. |

🎯 En qué contexto se usa:

• animar o felicitar a quien lo hace bien
• ⚠️ con ironía es vaya tela, cuando alguien lo hace mal
• de todas las edades

🔑 El truco que casi nunca falla: lekker es el comodín de lo bueno, y bezig es estar en ello.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: lekker bezig' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: lekker bezig' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Lekker bezig, je huiswerk is al af!', 'leker besij, ie höisuerk is al af', '• [uitdr.] Lekker bezig! — ¡Bien hecho!
• [can.] Je bent lekker bezig. — Lo estás haciendo genial.
• [imperf.] Hij was lekker bezig in de tuin. — Estaba a gusto trabajando en el jardín.
• [bijzin] Ik zie dat je lekker bezig bent. — Veo que vas muy bien.
• [uitdr.] Nou, lekker bezig, alles is kapot. — Vaya, muy bien, está todo roto.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Bien hecho!', 'SENTENCE', 'Ejemplo de "lekker bezig" (uitdr.)', 'LEKKER BEZIG = bien hecho, bien hecho, sigue así; también irónico.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — bien hecho = lekker bezig.
• en esta tarjeta — la fórmula va sola delante; af zijn es estar terminado.

📖 Palabra a palabra:

• lekker — rico, sabroso; hablado refuerza casi todo, lekker weer, buen tiempo.
• bezig — ocupado, haciendo algo.

🧩 Expresión fija — lekker bezig:

• literal — rico ocupado.
• significa — bien hecho, sigue así; también irónico.
• piezas fijas — lekker más bezig, sin verbo; con verbo, Je bent lekker bezig.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Lekker bezig! | ¡Bien hecho! |
| 2 | principal | Je bent lekker bezig. | Lo estás haciendo genial. |
| 3 | imperfecto | Hij was lekker bezig in de tuin. | Estaba a gusto trabajando en el jardín. |

🎯 En qué contexto se usa:

• animar o felicitar a quien lo hace bien
• ⚠️ con ironía es vaya tela, cuando alguien lo hace mal
• de todas las edades

🔑 El truco que casi nunca falla: lekker es el comodín de lo bueno, y bezig es estar en ello.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Bien hecho!' AND notes = 'Ejemplo de "lekker bezig" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Bien hecho!' AND notes = 'Ejemplo de "lekker bezig" (uitdr.)' LIMIT 1), 'nl_NL', 'Lekker bezig!', 'leker besij', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: lekker bezig' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Bien hecho!' AND notes = 'Ejemplo de "lekker bezig" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: lekker bezig' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: lekker bezig' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Bien hecho!' AND notes = 'Ejemplo de "lekker bezig" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Bien hecho!' AND notes = 'Ejemplo de "lekker bezig" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 17. lekker belangrijk
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Que tiene un coche nuevo? ¡Y a mí qué! (él)', 'PHRASE', 'jerga: lekker belangrijk', 'LEKKER BELANGRIJK = y a mí qué, como si importara, eso no importa nada, con ironía.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — y a mí qué, como si importara = lekker belangrijk.
• en esta tarjeta — fórmula fija detrás de la pregunta, sin verbo.

📖 Palabra a palabra:

• belangrijk — importante.

🧩 Expresión fija — lekker belangrijk:

• literal — rico importante.
• significa — eso no importa nada, con ironía.
• piezas fijas — siempre lekker más belangrijk, y siempre irónico.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Lekker belangrijk! | ¡Y a mí qué! |
| 2 | principal | Hij heeft gewonnen. Lekker belangrijk. | Ha ganado. Como si importara. |
| 3 | imperfecto | Ze was op tv, lekker belangrijk. | Salió en la tele, como si importara. |

🎯 En qué contexto se usa:

• quitar importancia con desdén a lo que otro presume
• ⚠️ suena chulo, con jefes y desconocidos mejor no
• de adolescentes y adultos

🔑 El truco que casi nunca falla: el lekker irónico le da la vuelta al adjetivo, importante pasa a no importa nada.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: lekker belangrijk' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: lekker belangrijk' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Heeft hij een nieuwe auto? Lekker belangrijk!', 'heft hei en niöue auto leker belangreik', '• [uitdr.] Lekker belangrijk! — ¡Y a mí qué!
• [can.] Hij heeft gewonnen. Lekker belangrijk. — Ha ganado. Como si importara.
• [imperf.] Ze was op tv, lekker belangrijk. — Salió en la tele, como si importara.
• [bijzin] Ik zei dat het lekker belangrijk was. — Dije que me daba igual.
• [vraag] Lekker belangrijk, toch? — Como si importara, ¿no?');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Y a mí qué!', 'SENTENCE', 'Ejemplo de "lekker belangrijk" (uitdr.)', 'LEKKER BELANGRIJK = y a mí qué, como si importara, eso no importa nada, con ironía.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — y a mí qué, como si importara = lekker belangrijk.
• en esta tarjeta — fórmula fija detrás de la pregunta, sin verbo.

📖 Palabra a palabra:

• belangrijk — importante.

🧩 Expresión fija — lekker belangrijk:

• literal — rico importante.
• significa — eso no importa nada, con ironía.
• piezas fijas — siempre lekker más belangrijk, y siempre irónico.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Lekker belangrijk! | ¡Y a mí qué! |
| 2 | principal | Hij heeft gewonnen. Lekker belangrijk. | Ha ganado. Como si importara. |
| 3 | imperfecto | Ze was op tv, lekker belangrijk. | Salió en la tele, como si importara. |

🎯 En qué contexto se usa:

• quitar importancia con desdén a lo que otro presume
• ⚠️ suena chulo, con jefes y desconocidos mejor no
• de adolescentes y adultos

🔑 El truco que casi nunca falla: el lekker irónico le da la vuelta al adjetivo, importante pasa a no importa nada.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Y a mí qué!' AND notes = 'Ejemplo de "lekker belangrijk" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Y a mí qué!' AND notes = 'Ejemplo de "lekker belangrijk" (uitdr.)' LIMIT 1), 'nl_NL', 'Lekker belangrijk!', 'leker belangreik', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: lekker belangrijk' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Y a mí qué!' AND notes = 'Ejemplo de "lekker belangrijk" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: lekker belangrijk' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: lekker belangrijk' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Y a mí qué!' AND notes = 'Ejemplo de "lekker belangrijk" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Y a mí qué!' AND notes = 'Ejemplo de "lekker belangrijk" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 18. wat een gedoe
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Qué lío con tanto papeleo!', 'PHRASE', 'jerga: wat een gedoe', 'WAT EEN GEDOE = qué lío, qué lío, qué follón.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — qué lío = wat een gedoe.
• en esta tarjeta — met más la causa del lío.

📖 Palabra a palabra:

• het gedoe — el lío, el follón, de doen, hacer.

🧩 Expresión fija — wat een gedoe:

• literal — qué hacer y deshacer.
• significa — qué lío, qué follón.
• piezas fijas — het gedoe; wat een más sustantivo es qué más sustantivo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Wat een gedoe! | ¡Qué lío! |
| 2 | principal | Ik heb geen zin in gedoe. | No quiero líos. |
| 3 | imperfecto | Het was een hoop gedoe. | Fue un montón de follón. |

🎯 En qué contexto se usa:

• burocracia, mudanzas, problemas con una aplicación
• de todas las edades
• también Ik heb geen zin in gedoe, no quiero líos

🔑 El truco que casi nunca falla: wat een más cosa es qué más cosa, y gedoe es todo lo que hay que hacer.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: wat een gedoe' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wat een gedoe' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Wat een gedoe met al dat papierwerk!', 'vat en jedu met al dat papiruerk', '• [uitdr.] Wat een gedoe! — ¡Qué lío!
• [can.] Ik heb geen zin in gedoe. — No quiero líos.
• [imperf.] Het was een hoop gedoe. — Fue un montón de follón.
• [bijzin] Ik weet dat het gedoe is. — Sé que es un lío.
• [perf.] Het heeft veel gedoe gekost. — Ha costado mucho lío.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Qué lío!', 'SENTENCE', 'Ejemplo de "wat een gedoe" (uitdr.)', 'WAT EEN GEDOE = qué lío, qué lío, qué follón.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — qué lío = wat een gedoe.
• en esta tarjeta — met más la causa del lío.

📖 Palabra a palabra:

• het gedoe — el lío, el follón, de doen, hacer.

🧩 Expresión fija — wat een gedoe:

• literal — qué hacer y deshacer.
• significa — qué lío, qué follón.
• piezas fijas — het gedoe; wat een más sustantivo es qué más sustantivo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Wat een gedoe! | ¡Qué lío! |
| 2 | principal | Ik heb geen zin in gedoe. | No quiero líos. |
| 3 | imperfecto | Het was een hoop gedoe. | Fue un montón de follón. |

🎯 En qué contexto se usa:

• burocracia, mudanzas, problemas con una aplicación
• de todas las edades
• también Ik heb geen zin in gedoe, no quiero líos

🔑 El truco que casi nunca falla: wat een más cosa es qué más cosa, y gedoe es todo lo que hay que hacer.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Qué lío!' AND notes = 'Ejemplo de "wat een gedoe" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Qué lío!' AND notes = 'Ejemplo de "wat een gedoe" (uitdr.)' LIMIT 1), 'nl_NL', 'Wat een gedoe!', 'vat en jedu', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wat een gedoe' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Qué lío!' AND notes = 'Ejemplo de "wat een gedoe" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wat een gedoe' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wat een gedoe' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Qué lío!' AND notes = 'Ejemplo de "wat een gedoe" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Qué lío!' AND notes = 'Ejemplo de "wat een gedoe" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 19. dubbel liggen
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me partí de risa con su chiste.', 'PHRASE', 'jerga: dubbel liggen', 'DUBBEL LIGGEN = partirse de risa, reírse muchísimo.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — partirse de risa = dubbel liggen.
• en esta tarjeta — liggen en imperfecto, lag; om más lo que hace gracia.

📖 Palabra a palabra:

• dubbel — doble, doblado.
• liggen — estar tumbado.

🧩 Expresión fija — dubbel liggen:

• literal — estar tumbado doblado.
• significa — reírse muchísimo.
• piezas fijas — dubbel liggen, a menudo van het lachen; liggen es fuerte, lag, gelegen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperfecto | Ik lag dubbel. | Me partí de risa. |
| 2 | principal | Ze ligt dubbel van het lachen. | Se parte de risa. |
| 3 | perfecto | We hebben dubbel gelegen. | Nos hemos partido de risa. |

🎯 En qué contexto se usa:

• chistes, vídeos, anécdotas
• de todas las edades
• más fuerte, Ik ga dood van het lachen

🔑 El truco que casi nunca falla: te ríes tanto que te doblas.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: dubbel liggen' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: dubbel liggen' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Ik lag dubbel om zijn grap.', 'ik laj dübel om sein jrap', '• [imperf.] Ik lag dubbel. — Me partí de risa.
• [can.] Ze ligt dubbel van het lachen. — Se parte de risa.
• [perf.] We hebben dubbel gelegen. — Nos hemos partido de risa.
• [bijzin] Ik zag dat hij dubbel lag. — Vi que se partía de risa.
• [uitdr.] Ik ga dood van het lachen. — Me muero de risa.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me partí de risa.', 'SENTENCE', 'Ejemplo de "dubbel liggen" (imperf.)', 'DUBBEL LIGGEN = partirse de risa, reírse muchísimo.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — partirse de risa = dubbel liggen.
• en esta tarjeta — liggen en imperfecto, lag; om más lo que hace gracia.

📖 Palabra a palabra:

• dubbel — doble, doblado.
• liggen — estar tumbado.

🧩 Expresión fija — dubbel liggen:

• literal — estar tumbado doblado.
• significa — reírse muchísimo.
• piezas fijas — dubbel liggen, a menudo van het lachen; liggen es fuerte, lag, gelegen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | imperfecto | Ik lag dubbel. | Me partí de risa. |
| 2 | principal | Ze ligt dubbel van het lachen. | Se parte de risa. |
| 3 | perfecto | We hebben dubbel gelegen. | Nos hemos partido de risa. |

🎯 En qué contexto se usa:

• chistes, vídeos, anécdotas
• de todas las edades
• más fuerte, Ik ga dood van het lachen

🔑 El truco que casi nunca falla: te ríes tanto que te doblas.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me partí de risa.' AND notes = 'Ejemplo de "dubbel liggen" (imperf.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Me partí de risa.' AND notes = 'Ejemplo de "dubbel liggen" (imperf.)' LIMIT 1), 'nl_NL', 'Ik lag dubbel.', 'ik laj dübel', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: dubbel liggen' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me partí de risa.' AND notes = 'Ejemplo de "dubbel liggen" (imperf.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: dubbel liggen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: dubbel liggen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Me partí de risa.' AND notes = 'Ejemplo de "dubbel liggen" (imperf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Me partí de risa.' AND notes = 'Ejemplo de "dubbel liggen" (imperf.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 20. doodgaan van
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Si me ve así, me muero de vergüenza. (él, inv)', 'PHRASE', 'jerga: doodgaan van', 'DOODGAAN VAN = morirse de algo, exagerar una emoción, morirse de algo.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — morirse de algo = doodgaan van.
• en esta tarjeta — tras la subordinada, ga ik; doodgaan se separa, ga … dood, y van marca la causa.

📖 Palabra a palabra:

• doodgaan — morirse, de dood, muerto, más gaan.
• de schaamte — la vergüenza.

🧩 Expresión fija — doodgaan van:

• literal — ir muerto.
• significa — exagerar una emoción, morirse de algo.
• piezas fijas — doodgaan van más la causa; separable, ging dood, is doodgegaan.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ga dood van de honger. | Me muero de hambre. |
| 2 | expresión | Ik ga dood! | ¡Me muero! |
| 3 | imperfecto | Ik ging bijna dood van het lachen. | Casi me muero de risa. |

🎯 En qué contexto se usa:

• exagerar risa, vergüenza, hambre o calor
• de todas las edades, muy de jóvenes
• Ik ga dood! solo, no puedo más de risa

🔑 El truco que casi nunca falla: igual que el español me muero de, con van para la causa.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: doodgaan van' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: doodgaan van' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Als hij me zo ziet, ga ik dood van schaamte.', 'als hei me so sit, ja ik dot fan sjaamte', '• [can.] Ik ga dood van de honger. — Me muero de hambre.
• [uitdr.] Ik ga dood! — ¡Me muero!
• [imperf.] Ik ging bijna dood van het lachen. — Casi me muero de risa.
• [bijzin] Ik denk dat ik doodga van de hitte. — Creo que me muero de calor.
• [vraag] Ga je dood van de kou? — ¿Te mueres de frío?');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me muero de hambre.', 'SENTENCE', 'Ejemplo de "doodgaan van" (can.)', 'DOODGAAN VAN = morirse de algo, exagerar una emoción, morirse de algo.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — morirse de algo = doodgaan van.
• en esta tarjeta — tras la subordinada, ga ik; doodgaan se separa, ga … dood, y van marca la causa.

📖 Palabra a palabra:

• doodgaan — morirse, de dood, muerto, más gaan.
• de schaamte — la vergüenza.

🧩 Expresión fija — doodgaan van:

• literal — ir muerto.
• significa — exagerar una emoción, morirse de algo.
• piezas fijas — doodgaan van más la causa; separable, ging dood, is doodgegaan.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ga dood van de honger. | Me muero de hambre. |
| 2 | expresión | Ik ga dood! | ¡Me muero! |
| 3 | imperfecto | Ik ging bijna dood van het lachen. | Casi me muero de risa. |

🎯 En qué contexto se usa:

• exagerar risa, vergüenza, hambre o calor
• de todas las edades, muy de jóvenes
• Ik ga dood! solo, no puedo más de risa

🔑 El truco que casi nunca falla: igual que el español me muero de, con van para la causa.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me muero de hambre.' AND notes = 'Ejemplo de "doodgaan van" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Me muero de hambre.' AND notes = 'Ejemplo de "doodgaan van" (can.)' LIMIT 1), 'nl_NL', 'Ik ga dood van de honger.', 'ik ja dot fan de honger', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: doodgaan van' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Me muero de hambre.' AND notes = 'Ejemplo de "doodgaan van" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: doodgaan van' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: doodgaan van' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Me muero de hambre.' AND notes = 'Ejemplo de "doodgaan van" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Me muero de hambre.' AND notes = 'Ejemplo de "doodgaan van" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 21. gast
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Tío, ¿qué estás haciendo?', 'PHRASE', 'jerga: gast', 'GAST = tío, colega, tío, para llamar a un amigo o hablar de alguien.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — tío, colega = gast.
• en esta tarjeta — gast va suelto al principio, como llamada; wat doe je en presente ya es qué estás haciendo.

📖 Palabra a palabra:

• de gast — el invitado, el huésped en el uso normal; hablado, el tío, el tipo, een rare gast, un tipo raro.

🧩 Expresión fija — gast:

• literal — huésped, invitado.
• significa — tío, para llamar a un amigo o hablar de alguien.
• piezas fijas — de gast; como llamada va sin artículo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Gast, kom op! | ¡Tío, venga! |
| 2 | principal | Die gast is grappig. | Ese tío es gracioso. |
| 3 | imperfecto | Er stond een rare gast voor de deur. | Había un tipo raro en la puerta. |

🎯 En qué contexto se usa:

• entre amigos, sobre todo chicos jóvenes
• para hablar de alguien, Die gast is gek
• ⚠️ el uso normal sigue vivo, de gasten van het hotel

🔑 El truco que casi nunca falla: como el español tío, sirve para llamar y para hablar de alguien.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: gast' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: gast' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Gast, wat doe je?', 'jast, vat du ie', '• [uitdr.] Gast, kom op! — ¡Tío, venga!
• [can.] Die gast is grappig. — Ese tío es gracioso.
• [imperf.] Er stond een rare gast voor de deur. — Había un tipo raro en la puerta.
• [can.] Het hotel heeft honderd gasten. — El hotel tiene cien huéspedes.
• [vraag] Wie is die gast? — ¿Quién es ese tío?');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Tío, venga!', 'SENTENCE', 'Ejemplo de "gast" (uitdr.)', 'GAST = tío, colega, tío, para llamar a un amigo o hablar de alguien.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — tío, colega = gast.
• en esta tarjeta — gast va suelto al principio, como llamada; wat doe je en presente ya es qué estás haciendo.

📖 Palabra a palabra:

• de gast — el invitado, el huésped en el uso normal; hablado, el tío, el tipo, een rare gast, un tipo raro.

🧩 Expresión fija — gast:

• literal — huésped, invitado.
• significa — tío, para llamar a un amigo o hablar de alguien.
• piezas fijas — de gast; como llamada va sin artículo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Gast, kom op! | ¡Tío, venga! |
| 2 | principal | Die gast is grappig. | Ese tío es gracioso. |
| 3 | imperfecto | Er stond een rare gast voor de deur. | Había un tipo raro en la puerta. |

🎯 En qué contexto se usa:

• entre amigos, sobre todo chicos jóvenes
• para hablar de alguien, Die gast is gek
• ⚠️ el uso normal sigue vivo, de gasten van het hotel

🔑 El truco que casi nunca falla: como el español tío, sirve para llamar y para hablar de alguien.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Tío, venga!' AND notes = 'Ejemplo de "gast" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Tío, venga!' AND notes = 'Ejemplo de "gast" (uitdr.)' LIMIT 1), 'nl_NL', 'Gast, kom op!', 'jast, kom op', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: gast' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Tío, venga!' AND notes = 'Ejemplo de "gast" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: gast' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: gast' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Tío, venga!' AND notes = 'Ejemplo de "gast" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Tío, venga!' AND notes = 'Ejemplo de "gast" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 22. de mattie
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Es mi mejor colega. (él)', 'PHRASE', 'jerga: de mattie', 'DE MATTIE = colega, amigo, colega, amigo íntimo.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — colega, amigo = de mattie.
• en esta tarjeta — mattie va como cualquier sustantivo, con posesivo.

📖 Palabra a palabra:

• de mattie — el colega, del sranan, la lengua de Surinam.

🧩 Expresión fija — de mattie:

• literal — del sranan mati, amigo.
• significa — colega, amigo íntimo.
• piezas fijas — de mattie, plural matties.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij is mijn mattie. | Es mi colega. (él) |
| 2 | expresión | Hé mattie, alles goed? | Eh, colega, ¿todo bien? |
| 3 | imperfecto | Ik was met mijn matties in de stad. | Estaba con mis colegas en el centro. |

🎯 En qué contexto se usa:

• straattaal nacida en las ciudades, de jóvenes de todos los orígenes
• Mattie! para saludar
• ⚠️ en boca de un adulto suena a querer hacerse el joven

🔑 El truco que casi nunca falla: mattie viene de Surinam y significa lo mismo que colega.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: de mattie' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: de mattie' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Hij is mijn beste mattie.', 'hei is mein beste mati', '• [can.] Hij is mijn mattie. — Es mi colega. (él)
• [uitdr.] Hé mattie, alles goed? — Eh, colega, ¿todo bien?
• [imperf.] Ik was met mijn matties in de stad. — Estaba con mis colegas en el centro.
• [bijzin] Ik weet dat jullie matties zijn. — Sé que sois colegas.
• [vraag] Ga je mee, mattie? — ¿Te vienes, colega?');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Es mi colega. (él)', 'SENTENCE', 'Ejemplo de "de mattie" (can.)', 'DE MATTIE = colega, amigo, colega, amigo íntimo.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — colega, amigo = de mattie.
• en esta tarjeta — mattie va como cualquier sustantivo, con posesivo.

📖 Palabra a palabra:

• de mattie — el colega, del sranan, la lengua de Surinam.

🧩 Expresión fija — de mattie:

• literal — del sranan mati, amigo.
• significa — colega, amigo íntimo.
• piezas fijas — de mattie, plural matties.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Hij is mijn mattie. | Es mi colega. (él) |
| 2 | expresión | Hé mattie, alles goed? | Eh, colega, ¿todo bien? |
| 3 | imperfecto | Ik was met mijn matties in de stad. | Estaba con mis colegas en el centro. |

🎯 En qué contexto se usa:

• straattaal nacida en las ciudades, de jóvenes de todos los orígenes
• Mattie! para saludar
• ⚠️ en boca de un adulto suena a querer hacerse el joven

🔑 El truco que casi nunca falla: mattie viene de Surinam y significa lo mismo que colega.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Es mi colega. (él)' AND notes = 'Ejemplo de "de mattie" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Es mi colega. (él)' AND notes = 'Ejemplo de "de mattie" (can.)' LIMIT 1), 'nl_NL', 'Hij is mijn mattie.', 'hei is mein mati', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: de mattie' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Es mi colega. (él)' AND notes = 'Ejemplo de "de mattie" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: de mattie' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: de mattie' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Es mi colega. (él)' AND notes = 'Ejemplo de "de mattie" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Es mi colega. (él)' AND notes = 'Ejemplo de "de mattie" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 23. wollah
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Te lo juro, no he sido yo.', 'PHRASE', 'jerga: wollah', 'WOLLAH = te lo juro, te lo juro, en serio.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — te lo juro = wollah.
• en esta tarjeta — wollah va suelto delante, como juramento.

📖 Palabra a palabra:

• wollah — te lo juro, del árabe marroquí.

🧩 Expresión fija — wollah:

• literal — del árabe wallah, por Dios.
• significa — te lo juro, en serio.
• piezas fijas — invariable, delante o detrás de la frase.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Wollah, het is waar. | Te lo juro, es verdad. |
| 2 | pregunta | Wollah? | ¿En serio? |
| 3 | imperfecto | Wollah, ik was thuis. | Te lo juro, estaba en casa. |

🎯 En qué contexto se usa:

• straattaal de jóvenes, muy extendida en los colegios
• para reforzar que algo es verdad
• en pregunta, Wollah? ¿En serio?

🔑 El truco que casi nunca falla: si un chaval jura algo, lo abre con wollah.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: wollah' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wollah' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Wollah, ik was het niet.', 'volah, ik vas het nit', '• [uitdr.] Wollah, het is waar. — Te lo juro, es verdad.
• [vraag] Wollah? — ¿En serio?
• [imperf.] Wollah, ik was thuis. — Te lo juro, estaba en casa.
• [can.] Ik zweer het. — Lo juro.
• [bijzin] Hij zweert dat hij het niet weet. — Jura que no lo sabe.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Te lo juro, es verdad.', 'SENTENCE', 'Ejemplo de "wollah" (uitdr.)', 'WOLLAH = te lo juro, te lo juro, en serio.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — te lo juro = wollah.
• en esta tarjeta — wollah va suelto delante, como juramento.

📖 Palabra a palabra:

• wollah — te lo juro, del árabe marroquí.

🧩 Expresión fija — wollah:

• literal — del árabe wallah, por Dios.
• significa — te lo juro, en serio.
• piezas fijas — invariable, delante o detrás de la frase.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Wollah, het is waar. | Te lo juro, es verdad. |
| 2 | pregunta | Wollah? | ¿En serio? |
| 3 | imperfecto | Wollah, ik was thuis. | Te lo juro, estaba en casa. |

🎯 En qué contexto se usa:

• straattaal de jóvenes, muy extendida en los colegios
• para reforzar que algo es verdad
• en pregunta, Wollah? ¿En serio?

🔑 El truco que casi nunca falla: si un chaval jura algo, lo abre con wollah.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Te lo juro, es verdad.' AND notes = 'Ejemplo de "wollah" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Te lo juro, es verdad.' AND notes = 'Ejemplo de "wollah" (uitdr.)' LIMIT 1), 'nl_NL', 'Wollah, het is waar.', 'volah, het is vaar', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wollah' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Te lo juro, es verdad.' AND notes = 'Ejemplo de "wollah" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wollah' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wollah' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Te lo juro, es verdad.' AND notes = 'Ejemplo de "wollah" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Te lo juro, es verdad.' AND notes = 'Ejemplo de "wollah" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 24. de doekoe
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No tengo pasta para el cine.', 'PHRASE', 'jerga: de doekoe', 'DE DOEKOE = la pasta, el dinero, dinero, pasta.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — la pasta, el dinero = de doekoe.
• en esta tarjeta — doekoe va sin artículo, como geld.

📖 Palabra a palabra:

• de doekoe — la pasta, del sranan; la palabra normal es het geld.

🧩 Expresión fija — de doekoe:

• literal — del sranan, dinero.
• significa — dinero, pasta.
• piezas fijas — de doekoe, casi siempre sin artículo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik heb geen doekoe. | No tengo pasta. |
| 2 | principal | Hij verdient veel doekoe. | Gana mucha pasta. |
| 3 | imperfecto | Ik had geen doekoe meer. | Ya no me quedaba pasta. |

🎯 En qué contexto se usa:

• straattaal de jóvenes
• ⚠️ de adulto suena raro, los adultos dicen geld o poen
• muy presente en el rap

🔑 El truco que casi nunca falla: doekoe es para geld lo que pasta para dinero.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: de doekoe' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: de doekoe' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Ik heb geen doekoe voor de bioscoop.', 'ik heb jen duku for de bioskop', '• [can.] Ik heb geen doekoe. — No tengo pasta.
• [can.] Hij verdient veel doekoe. — Gana mucha pasta.
• [imperf.] Ik had geen doekoe meer. — Ya no me quedaba pasta.
• [bijzin] Ik weet niet waar hij die doekoe vandaan haalt. — No sé de dónde saca esa pasta.
• [uitdr.] Ik zit krap bij kas. — Ando justo de dinero.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No tengo pasta.', 'SENTENCE', 'Ejemplo de "de doekoe" (can.)', 'DE DOEKOE = la pasta, el dinero, dinero, pasta.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — la pasta, el dinero = de doekoe.
• en esta tarjeta — doekoe va sin artículo, como geld.

📖 Palabra a palabra:

• de doekoe — la pasta, del sranan; la palabra normal es het geld.

🧩 Expresión fija — de doekoe:

• literal — del sranan, dinero.
• significa — dinero, pasta.
• piezas fijas — de doekoe, casi siempre sin artículo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik heb geen doekoe. | No tengo pasta. |
| 2 | principal | Hij verdient veel doekoe. | Gana mucha pasta. |
| 3 | imperfecto | Ik had geen doekoe meer. | Ya no me quedaba pasta. |

🎯 En qué contexto se usa:

• straattaal de jóvenes
• ⚠️ de adulto suena raro, los adultos dicen geld o poen
• muy presente en el rap

🔑 El truco que casi nunca falla: doekoe es para geld lo que pasta para dinero.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No tengo pasta.' AND notes = 'Ejemplo de "de doekoe" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'No tengo pasta.' AND notes = 'Ejemplo de "de doekoe" (can.)' LIMIT 1), 'nl_NL', 'Ik heb geen doekoe.', 'ik heb jen duku', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: de doekoe' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No tengo pasta.' AND notes = 'Ejemplo de "de doekoe" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: de doekoe' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: de doekoe' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'No tengo pasta.' AND notes = 'Ejemplo de "de doekoe" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'No tengo pasta.' AND notes = 'Ejemplo de "de doekoe" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 25. dat meen je niet
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Que te ha tocado la lotería? ¡No me digas!', 'PHRASE', 'jerga: dat meen je niet', 'DAT MEEN JE NIET = no me digas, no me lo creo, no me digas.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no me digas = dat meen je niet.
• en esta tarjeta — fórmula fija detrás de la noticia.

📖 Palabra a palabra:

• menen — decir algo en serio, querer decir, Ik meen het, lo digo en serio.

🧩 Expresión fija — dat meen je niet:

• literal — eso no lo dices en serio.
• significa — no me lo creo, no me digas.
• piezas fijas — menen es débil, gemeend; dat va delante y je detrás del verbo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Dat meen je niet! | ¡No me digas! |
| 2 | pregunta | Meen je dat? | ¿Lo dices en serio? |
| 3 | principal | Ik meen het. | Lo digo en serio. |

🎯 En qué contexto se usa:

• sorpresa ante una noticia, buena o mala
• de todas las edades
• también Meen je dat? ¿Lo dices en serio?

🔑 El truco que casi nunca falla: menen es decirlo en serio, y la sorpresa niega que lo digas en serio.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: dat meen je niet' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: dat meen je niet' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Heb je de loterij gewonnen? Dat meen je niet!', 'heb ie de loterei jeuonen dat men ie nit', '• [uitdr.] Dat meen je niet! — ¡No me digas!
• [vraag] Meen je dat? — ¿Lo dices en serio?
• [can.] Ik meen het. — Lo digo en serio.
• [imperf.] Ze meende het echt. — Lo decía en serio.
• [bijzin] Ik weet niet of hij het meent. — No sé si lo dice en serio.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡No me digas!', 'SENTENCE', 'Ejemplo de "dat meen je niet" (uitdr.)', 'DAT MEEN JE NIET = no me digas, no me lo creo, no me digas.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no me digas = dat meen je niet.
• en esta tarjeta — fórmula fija detrás de la noticia.

📖 Palabra a palabra:

• menen — decir algo en serio, querer decir, Ik meen het, lo digo en serio.

🧩 Expresión fija — dat meen je niet:

• literal — eso no lo dices en serio.
• significa — no me lo creo, no me digas.
• piezas fijas — menen es débil, gemeend; dat va delante y je detrás del verbo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Dat meen je niet! | ¡No me digas! |
| 2 | pregunta | Meen je dat? | ¿Lo dices en serio? |
| 3 | principal | Ik meen het. | Lo digo en serio. |

🎯 En qué contexto se usa:

• sorpresa ante una noticia, buena o mala
• de todas las edades
• también Meen je dat? ¿Lo dices en serio?

🔑 El truco que casi nunca falla: menen es decirlo en serio, y la sorpresa niega que lo digas en serio.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡No me digas!' AND notes = 'Ejemplo de "dat meen je niet" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡No me digas!' AND notes = 'Ejemplo de "dat meen je niet" (uitdr.)' LIMIT 1), 'nl_NL', 'Dat meen je niet!', 'dat men ie nit', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: dat meen je niet' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡No me digas!' AND notes = 'Ejemplo de "dat meen je niet" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: dat meen je niet' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: dat meen je niet' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡No me digas!' AND notes = 'Ejemplo de "dat meen je niet" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡No me digas!' AND notes = 'Ejemplo de "dat meen je niet" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 26. serieus
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿En serio? ¿Has vuelto a perder las llaves?', 'PHRASE', 'jerga: serieus', 'SERIEUS = en serio, en serio, con sorpresa o fastidio.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — en serio = serieus.
• en esta tarjeta — Serieus? va suelto delante; kwijt zijn es haber perdido algo.

📖 Palabra a palabra:

• serieus — serio, en serio.
• kwijt — perdido, Ik ben mijn telefoon kwijt.

🧩 Expresión fija — serieus:

• literal — serio.
• significa — en serio, con sorpresa o fastidio.
• piezas fijas — invariable; también adverbio, Ik meen het serieus.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pregunta | Serieus? | ¿En serio? |
| 2 | principal | Ik meen het serieus. | Lo digo en serio. |
| 3 | imperfecto | Was hij serieus? | ¿Lo decía en serio? |

🎯 En qué contexto se usa:

• sorpresa o fastidio, muy de jóvenes
• con tono cansado es otra vez no
• de todas las edades

🔑 El truco que casi nunca falla: igual que en español, pero se oye la s final.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: serieus' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: serieus' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Serieus? Ben je je sleutels weer kwijt?', 'seriös ben ie ie slötels ver kueit', '• [vraag] Serieus? — ¿En serio?
• [can.] Ik meen het serieus. — Lo digo en serio.
• [imperf.] Was hij serieus? — ¿Lo decía en serio?
• [bijzin] Ik weet niet of ze het serieus bedoelt. — No sé si lo dice en serio.
• [uitdr.] Echt waar? — ¿De verdad?');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿En serio?', 'SENTENCE', 'Ejemplo de "serieus" (vraag)', 'SERIEUS = en serio, en serio, con sorpresa o fastidio.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — en serio = serieus.
• en esta tarjeta — Serieus? va suelto delante; kwijt zijn es haber perdido algo.

📖 Palabra a palabra:

• serieus — serio, en serio.
• kwijt — perdido, Ik ben mijn telefoon kwijt.

🧩 Expresión fija — serieus:

• literal — serio.
• significa — en serio, con sorpresa o fastidio.
• piezas fijas — invariable; también adverbio, Ik meen het serieus.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pregunta | Serieus? | ¿En serio? |
| 2 | principal | Ik meen het serieus. | Lo digo en serio. |
| 3 | imperfecto | Was hij serieus? | ¿Lo decía en serio? |

🎯 En qué contexto se usa:

• sorpresa o fastidio, muy de jóvenes
• con tono cansado es otra vez no
• de todas las edades

🔑 El truco que casi nunca falla: igual que en español, pero se oye la s final.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿En serio?' AND notes = 'Ejemplo de "serieus" (vraag)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¿En serio?' AND notes = 'Ejemplo de "serieus" (vraag)' LIMIT 1), 'nl_NL', 'Serieus?', 'seriös', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: serieus' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿En serio?' AND notes = 'Ejemplo de "serieus" (vraag)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: serieus' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: serieus' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¿En serio?' AND notes = 'Ejemplo de "serieus" (vraag)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¿En serio?' AND notes = 'Ejemplo de "serieus" (vraag)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 27. hoe dan
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Y eso cómo? ¡Si ya has terminado!', 'PHRASE', 'jerga: hoe dan', 'HOE DAN = y eso cómo, cómo es posible.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — y eso cómo = hoe dan.
• en esta tarjeta — hoe dan va solo, como exclamación de asombro.

📖 Palabra a palabra:

• hoe — cómo.
• dan — entonces; en preguntas mete asombro o impaciencia, Wat dan?.

🧩 Expresión fija — hoe dan:

• literal — cómo entonces.
• significa — cómo es posible.
• piezas fijas — invariable, con tono de pregunta asombrada.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pregunta | Hoe dan? | ¿Y eso cómo? |
| 2 | pregunta | Wat dan? | ¿Qué pasa? |
| 3 | pregunta | Waarom dan? | ¿Y por qué? |

🎯 En qué contexto se usa:

• jóvenes ante algo que no se explican
• también burla, cuando algo parece imposible
• de moda en los últimos años

🔑 El truco que casi nunca falla: el dan de las preguntas mete asombro, Hoe dan, Wat dan, Waarom dan.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: hoe dan' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: hoe dan' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Hoe dan? Je bent al klaar!', 'hu dan ie bent al klaar', '• [vraag] Hoe dan? — ¿Y eso cómo?
• [vraag] Wat dan? — ¿Qué pasa?
• [vraag] Waarom dan? — ¿Y por qué?
• [can.] Ik snap niet hoe dat kan. — No entiendo cómo es posible.
• [imperf.] Hoe deed je dat dan? — ¿Y cómo lo hiciste?');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Y eso cómo?', 'SENTENCE', 'Ejemplo de "hoe dan" (vraag)', 'HOE DAN = y eso cómo, cómo es posible.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — y eso cómo = hoe dan.
• en esta tarjeta — hoe dan va solo, como exclamación de asombro.

📖 Palabra a palabra:

• hoe — cómo.
• dan — entonces; en preguntas mete asombro o impaciencia, Wat dan?.

🧩 Expresión fija — hoe dan:

• literal — cómo entonces.
• significa — cómo es posible.
• piezas fijas — invariable, con tono de pregunta asombrada.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pregunta | Hoe dan? | ¿Y eso cómo? |
| 2 | pregunta | Wat dan? | ¿Qué pasa? |
| 3 | pregunta | Waarom dan? | ¿Y por qué? |

🎯 En qué contexto se usa:

• jóvenes ante algo que no se explican
• también burla, cuando algo parece imposible
• de moda en los últimos años

🔑 El truco que casi nunca falla: el dan de las preguntas mete asombro, Hoe dan, Wat dan, Waarom dan.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Y eso cómo?' AND notes = 'Ejemplo de "hoe dan" (vraag)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¿Y eso cómo?' AND notes = 'Ejemplo de "hoe dan" (vraag)' LIMIT 1), 'nl_NL', 'Hoe dan?', 'hu dan', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: hoe dan' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿Y eso cómo?' AND notes = 'Ejemplo de "hoe dan" (vraag)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: hoe dan' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: hoe dan' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¿Y eso cómo?' AND notes = 'Ejemplo de "hoe dan" (vraag)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¿Y eso cómo?' AND notes = 'Ejemplo de "hoe dan" (vraag)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 28. zeker weten
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Vienes a la fiesta? ¡Ya te digo!', 'PHRASE', 'jerga: zeker weten', 'ZEKER WETEN = ya te digo, claro que sí, por supuesto, sin duda.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ya te digo, claro que sí = zeker weten.
• en esta tarjeta — fórmula fija como respuesta.

📖 Palabra a palabra:

• zeker — seguro, sin duda.
• weten — saber.

🧩 Expresión fija — zeker weten:

• literal — saber seguro.
• significa — por supuesto, sin duda.
• piezas fijas — invariable, sin verbo conjugado.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Zeker weten! | ¡Ya te digo! |
| 2 | pregunta | Weet je het zeker? | ¿Estás seguro? |
| 3 | principal | Ik weet het zeker. | Estoy seguro. |

🎯 En qué contexto se usa:

• respuesta con ganas a una propuesta
• de todas las edades
• también Weet je het zeker? ¿Estás seguro?

🔑 El truco que casi nunca falla: si responderías claro que sí con ganas, Zeker weten.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: zeker weten' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: zeker weten' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Kom je naar het feest? Zeker weten!', 'kom ie naar het fest seker veten', '• [uitdr.] Zeker weten! — ¡Ya te digo!
• [vraag] Weet je het zeker? — ¿Estás seguro?
• [can.] Ik weet het zeker. — Estoy seguro.
• [imperf.] Hij wist het zeker. — Estaba seguro.
• [can.] Ik wil het zeker weten. — Quiero estar seguro.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Ya te digo!', 'SENTENCE', 'Ejemplo de "zeker weten" (uitdr.)', 'ZEKER WETEN = ya te digo, claro que sí, por supuesto, sin duda.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — ya te digo, claro que sí = zeker weten.
• en esta tarjeta — fórmula fija como respuesta.

📖 Palabra a palabra:

• zeker — seguro, sin duda.
• weten — saber.

🧩 Expresión fija — zeker weten:

• literal — saber seguro.
• significa — por supuesto, sin duda.
• piezas fijas — invariable, sin verbo conjugado.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Zeker weten! | ¡Ya te digo! |
| 2 | pregunta | Weet je het zeker? | ¿Estás seguro? |
| 3 | principal | Ik weet het zeker. | Estoy seguro. |

🎯 En qué contexto se usa:

• respuesta con ganas a una propuesta
• de todas las edades
• también Weet je het zeker? ¿Estás seguro?

🔑 El truco que casi nunca falla: si responderías claro que sí con ganas, Zeker weten.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Ya te digo!' AND notes = 'Ejemplo de "zeker weten" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Ya te digo!' AND notes = 'Ejemplo de "zeker weten" (uitdr.)' LIMIT 1), 'nl_NL', 'Zeker weten!', 'seker veten', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: zeker weten' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Ya te digo!' AND notes = 'Ejemplo de "zeker weten" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: zeker weten' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: zeker weten' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Ya te digo!' AND notes = 'Ejemplo de "zeker weten" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Ya te digo!' AND notes = 'Ejemplo de "zeker weten" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 29. nee joh
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Estás enfadado? ¡Qué va!', 'PHRASE', 'jerga: nee joh', 'NEE JOH = qué va, hombre, qué va, para nada, en tono amable.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — qué va, hombre = nee joh.
• en esta tarjeta — joh va detrás de nee y le da tono amistoso.

📖 Palabra a palabra:

• joh — partícula de confianza, como hombre o tío en español.

🧩 Expresión fija — nee joh:

• literal — no, tú.
• significa — qué va, para nada, en tono amable.
• piezas fijas — joh es una partícula sin traducción y va detrás.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Nee joh! | ¡Qué va! |
| 2 | expresión | Ach joh, maakt niet uit. | Bah, hombre, da igual. |
| 3 | principal | Joh, wat leuk je te zien! | ¡Hombre, qué alegría verte! |

🎯 En qué contexto se usa:

• negar de forma amistosa
• Ach joh, no pasa nada, para quitar hierro
• de todas las edades, entre conocidos

🔑 El truco que casi nunca falla: joh es el hombre del español, Nee joh es qué va, hombre.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: nee joh' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: nee joh' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Ben je boos? Nee joh!', 'ben ie bos ne ioh', '• [uitdr.] Nee joh! — ¡Qué va!
• [uitdr.] Ach joh, maakt niet uit. — Bah, hombre, da igual.
• [can.] Joh, wat leuk je te zien! — ¡Hombre, qué alegría verte!
• [vraag] Echt joh? — ¿En serio, tío?
• [uitdr.] Ja joh, natuurlijk! — ¡Pues claro, hombre!');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Qué va!', 'SENTENCE', 'Ejemplo de "nee joh" (uitdr.)', 'NEE JOH = qué va, hombre, qué va, para nada, en tono amable.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — qué va, hombre = nee joh.
• en esta tarjeta — joh va detrás de nee y le da tono amistoso.

📖 Palabra a palabra:

• joh — partícula de confianza, como hombre o tío en español.

🧩 Expresión fija — nee joh:

• literal — no, tú.
• significa — qué va, para nada, en tono amable.
• piezas fijas — joh es una partícula sin traducción y va detrás.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Nee joh! | ¡Qué va! |
| 2 | expresión | Ach joh, maakt niet uit. | Bah, hombre, da igual. |
| 3 | principal | Joh, wat leuk je te zien! | ¡Hombre, qué alegría verte! |

🎯 En qué contexto se usa:

• negar de forma amistosa
• Ach joh, no pasa nada, para quitar hierro
• de todas las edades, entre conocidos

🔑 El truco que casi nunca falla: joh es el hombre del español, Nee joh es qué va, hombre.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Qué va!' AND notes = 'Ejemplo de "nee joh" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Qué va!' AND notes = 'Ejemplo de "nee joh" (uitdr.)' LIMIT 1), 'nl_NL', 'Nee joh!', 'ne ioh', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: nee joh' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Qué va!' AND notes = 'Ejemplo de "nee joh" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: nee joh' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: nee joh' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Qué va!' AND notes = 'Ejemplo de "nee joh" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Qué va!' AND notes = 'Ejemplo de "nee joh" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 30. meevallen
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'El examen no ha sido para tanto.', 'PHRASE', 'jerga: meevallen', 'MEEVALLEN = no ser para tanto, salir mejor de lo que esperabas.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no ser para tanto = meevallen.
• en esta tarjeta — meevallen es separable y va con zijn, is meegevallen; el sujeto es la cosa.

📖 Palabra a palabra:

• meevallen — salir mejor de lo esperado, mee, con, más vallen, caer.
• de meevaller — la sorpresa buena.

🧩 Expresión fija — meevallen:

• literal — caer a favor.
• significa — salir mejor de lo que esperabas.
• piezas fijas — separable, valt mee, viel mee, is meegevallen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Het valt mee. | No es para tanto. |
| 2 | imperfecto | De pijn viel mee. | El dolor no fue para tanto. |
| 3 | pregunta | Valt het mee? | ¿No es para tanto? |

🎯 En qué contexto se usa:

• exámenes, médicos, precios, el tiempo
• de todas las edades, a diario
• lo contrario es tegenvallen

🔑 El truco que casi nunca falla: mee es a favor y tegen en contra, meevallen sale bien y tegenvallen decepciona.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: meevallen' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: meevallen' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Het examen is meegevallen.', 'het eksamen is mejefalen', '• [can.] Het valt mee. — No es para tanto.
• [imperf.] De pijn viel mee. — El dolor no fue para tanto.
• [vraag] Valt het mee? — ¿No es para tanto?
• [bijzin] Ik hoop dat het meevalt. — Espero que no sea para tanto.
• [uitdr.] Dat is een meevaller. — Eso es una suerte.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No es para tanto.', 'SENTENCE', 'Ejemplo de "meevallen" (can.)', 'MEEVALLEN = no ser para tanto, salir mejor de lo que esperabas.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no ser para tanto = meevallen.
• en esta tarjeta — meevallen es separable y va con zijn, is meegevallen; el sujeto es la cosa.

📖 Palabra a palabra:

• meevallen — salir mejor de lo esperado, mee, con, más vallen, caer.
• de meevaller — la sorpresa buena.

🧩 Expresión fija — meevallen:

• literal — caer a favor.
• significa — salir mejor de lo que esperabas.
• piezas fijas — separable, valt mee, viel mee, is meegevallen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Het valt mee. | No es para tanto. |
| 2 | imperfecto | De pijn viel mee. | El dolor no fue para tanto. |
| 3 | pregunta | Valt het mee? | ¿No es para tanto? |

🎯 En qué contexto se usa:

• exámenes, médicos, precios, el tiempo
• de todas las edades, a diario
• lo contrario es tegenvallen

🔑 El truco que casi nunca falla: mee es a favor y tegen en contra, meevallen sale bien y tegenvallen decepciona.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No es para tanto.' AND notes = 'Ejemplo de "meevallen" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'No es para tanto.' AND notes = 'Ejemplo de "meevallen" (can.)' LIMIT 1), 'nl_NL', 'Het valt mee.', 'het falt me', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: meevallen' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No es para tanto.' AND notes = 'Ejemplo de "meevallen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: meevallen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: meevallen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'No es para tanto.' AND notes = 'Ejemplo de "meevallen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'No es para tanto.' AND notes = 'Ejemplo de "meevallen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 31. tegenvallen
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'La película me ha decepcionado.', 'PHRASE', 'jerga: tegenvallen', 'TEGENVALLEN = decepcionar, decepcionar, salir peor de lo esperado.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — decepcionar = tegenvallen.
• en esta tarjeta — tegenvallen va con zijn; quien se decepciona va en me.

📖 Palabra a palabra:

• tegenvallen — decepcionar, tegen, contra, más vallen.
• de tegenvaller — el revés, el chasco.

🧩 Expresión fija — tegenvallen:

• literal — caer en contra.
• significa — decepcionar, salir peor de lo esperado.
• piezas fijas — separable, valt tegen, viel tegen, is tegengevallen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Het valt tegen. | Decepciona. |
| 2 | principal | Je valt me tegen. | Me decepcionas. |
| 3 | imperfecto | Het hotel viel tegen. | El hotel decepcionó. |

🎯 En qué contexto se usa:

• planes, restaurantes, notas, personas
• de todas las edades
• Je valt me tegen, me decepcionas, suena duro

🔑 El truco que casi nunca falla: lo que cae en tu contra te decepciona.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: tegenvallen' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: tegenvallen' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'De film is me tegengevallen.', 'de film is me tejengefalen', '• [can.] Het valt tegen. — Decepciona.
• [can.] Je valt me tegen. — Me decepcionas.
• [imperf.] Het hotel viel tegen. — El hotel decepcionó.
• [bijzin] Ik vind dat het tegenvalt. — Me parece que decepciona.
• [uitdr.] Wat een tegenvaller! — ¡Qué chasco!');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Decepciona.', 'SENTENCE', 'Ejemplo de "tegenvallen" (can.)', 'TEGENVALLEN = decepcionar, decepcionar, salir peor de lo esperado.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — decepcionar = tegenvallen.
• en esta tarjeta — tegenvallen va con zijn; quien se decepciona va en me.

📖 Palabra a palabra:

• tegenvallen — decepcionar, tegen, contra, más vallen.
• de tegenvaller — el revés, el chasco.

🧩 Expresión fija — tegenvallen:

• literal — caer en contra.
• significa — decepcionar, salir peor de lo esperado.
• piezas fijas — separable, valt tegen, viel tegen, is tegengevallen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Het valt tegen. | Decepciona. |
| 2 | principal | Je valt me tegen. | Me decepcionas. |
| 3 | imperfecto | Het hotel viel tegen. | El hotel decepcionó. |

🎯 En qué contexto se usa:

• planes, restaurantes, notas, personas
• de todas las edades
• Je valt me tegen, me decepcionas, suena duro

🔑 El truco que casi nunca falla: lo que cae en tu contra te decepciona.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Decepciona.' AND notes = 'Ejemplo de "tegenvallen" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Decepciona.' AND notes = 'Ejemplo de "tegenvallen" (can.)' LIMIT 1), 'nl_NL', 'Het valt tegen.', 'het falt tejen', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: tegenvallen' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Decepciona.' AND notes = 'Ejemplo de "tegenvallen" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: tegenvallen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: tegenvallen' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Decepciona.' AND notes = 'Ejemplo de "tegenvallen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Decepciona.' AND notes = 'Ejemplo de "tegenvallen" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 32. gesloopt zijn
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Después del partido estoy destrozado. (inv)', 'PHRASE', 'jerga: gesloopt zijn', 'GESLOOPT ZIJN = estar destrozado, estar agotado.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar destrozado = gesloopt zijn.
• en esta tarjeta — tras na de wedstrijd, ben ik; gesloopt es el participio de slopen.

📖 Palabra a palabra:

• slopen — demoler, derribar; de sloop es el derribo.

🧩 Expresión fija — gesloopt zijn:

• literal — estar demolido.
• significa — estar agotado.
• piezas fijas — gesloopt como adjetivo detrás de zijn.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben gesloopt. | Estoy destrozado. |
| 2 | imperfecto | Na de verhuizing was ik gesloopt. | Después de la mudanza estaba destrozado. |
| 3 | principal | Die training sloopt me. | Ese entrenamiento me destroza. |

🎯 En qué contexto se usa:

• cansancio físico tras el deporte, una fiesta o el trabajo
• jóvenes y adultos jóvenes
• sinónimos, kapot, kapot moe, doodop

🔑 El truco que casi nunca falla: te han demolido como a un edificio viejo.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: gesloopt zijn' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: gesloopt zijn' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Na de wedstrijd ben ik gesloopt.', 'na de vedstreit ben ik jeslopt', '• [can.] Ik ben gesloopt. — Estoy destrozado.
• [imperf.] Na de verhuizing was ik gesloopt. — Después de la mudanza estaba destrozado.
• [can.] Die training sloopt me. — Ese entrenamiento me destroza.
• [bijzin] Ik ga slapen omdat ik gesloopt ben. — Me voy a dormir porque estoy destrozado.
• [perf.] Ze hebben het oude huis gesloopt. — Han derribado la casa vieja.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Estoy destrozado.', 'SENTENCE', 'Ejemplo de "gesloopt zijn" (can.)', 'GESLOOPT ZIJN = estar destrozado, estar agotado.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — estar destrozado = gesloopt zijn.
• en esta tarjeta — tras na de wedstrijd, ben ik; gesloopt es el participio de slopen.

📖 Palabra a palabra:

• slopen — demoler, derribar; de sloop es el derribo.

🧩 Expresión fija — gesloopt zijn:

• literal — estar demolido.
• significa — estar agotado.
• piezas fijas — gesloopt como adjetivo detrás de zijn.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben gesloopt. | Estoy destrozado. |
| 2 | imperfecto | Na de verhuizing was ik gesloopt. | Después de la mudanza estaba destrozado. |
| 3 | principal | Die training sloopt me. | Ese entrenamiento me destroza. |

🎯 En qué contexto se usa:

• cansancio físico tras el deporte, una fiesta o el trabajo
• jóvenes y adultos jóvenes
• sinónimos, kapot, kapot moe, doodop

🔑 El truco que casi nunca falla: te han demolido como a un edificio viejo.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Estoy destrozado.' AND notes = 'Ejemplo de "gesloopt zijn" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Estoy destrozado.' AND notes = 'Ejemplo de "gesloopt zijn" (can.)' LIMIT 1), 'nl_NL', 'Ik ben gesloopt.', 'ik ben jeslopt', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: gesloopt zijn' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Estoy destrozado.' AND notes = 'Ejemplo de "gesloopt zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: gesloopt zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: gesloopt zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Estoy destrozado.' AND notes = 'Ejemplo de "gesloopt zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Estoy destrozado.' AND notes = 'Ejemplo de "gesloopt zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 33. het niet meer trekken
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No aguanto más este calor.', 'PHRASE', 'jerga: het niet meer trekken', 'HET NIET MEER TREKKEN = no poder más, no aguantar, ya no aguantar.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no poder más, no aguantar = het niet meer trekken.
• en esta tarjeta — lo que no aguantas ocupa el sitio de het, die hitte.

📖 Palabra a palabra:

• trekken — tirar de, arrastrar, y hablado aguantar.
• niet meer — ya no.

🧩 Expresión fija — het niet meer trekken:

• literal — ya no tirar de ello.
• significa — ya no aguantar.
• piezas fijas — trekken más objeto más niet meer; trekken es fuerte, trok, getrokken.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik trek het niet meer. | No puedo más. |
| 2 | imperfecto | Ze trok het niet meer en ging weg. | No aguantaba más y se fue. |
| 3 | subordinada | Ik begrijp dat je het niet meer trekt. | Entiendo que no puedas más. |

🎯 En qué contexto se usa:

• estrés, calor, ruido, una persona pesada
• jóvenes y adultos
• más neutro, Ik houd het niet meer vol

🔑 El truco que casi nunca falla: ya no puedes tirar del carro, ik trek het niet meer.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: het niet meer trekken' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: het niet meer trekken' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Ik trek die hitte niet meer.', 'ik trek di hite nit mer', '• [can.] Ik trek het niet meer. — No puedo más.
• [imperf.] Ze trok het niet meer en ging weg. — No aguantaba más y se fue.
• [bijzin] Ik begrijp dat je het niet meer trekt. — Entiendo que no puedas más.
• [can.] Ik trek hem niet. — No lo soporto.
• [uitdr.] Ik houd het niet meer vol. — No aguanto más.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No puedo más.', 'SENTENCE', 'Ejemplo de "het niet meer trekken" (can.)', 'HET NIET MEER TREKKEN = no poder más, no aguantar, ya no aguantar.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no poder más, no aguantar = het niet meer trekken.
• en esta tarjeta — lo que no aguantas ocupa el sitio de het, die hitte.

📖 Palabra a palabra:

• trekken — tirar de, arrastrar, y hablado aguantar.
• niet meer — ya no.

🧩 Expresión fija — het niet meer trekken:

• literal — ya no tirar de ello.
• significa — ya no aguantar.
• piezas fijas — trekken más objeto más niet meer; trekken es fuerte, trok, getrokken.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik trek het niet meer. | No puedo más. |
| 2 | imperfecto | Ze trok het niet meer en ging weg. | No aguantaba más y se fue. |
| 3 | subordinada | Ik begrijp dat je het niet meer trekt. | Entiendo que no puedas más. |

🎯 En qué contexto se usa:

• estrés, calor, ruido, una persona pesada
• jóvenes y adultos
• más neutro, Ik houd het niet meer vol

🔑 El truco que casi nunca falla: ya no puedes tirar del carro, ik trek het niet meer.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No puedo más.' AND notes = 'Ejemplo de "het niet meer trekken" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'No puedo más.' AND notes = 'Ejemplo de "het niet meer trekken" (can.)' LIMIT 1), 'nl_NL', 'Ik trek het niet meer.', 'ik trek het nit mer', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: het niet meer trekken' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'No puedo más.' AND notes = 'Ejemplo de "het niet meer trekken" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: het niet meer trekken' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: het niet meer trekken' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'No puedo más.' AND notes = 'Ejemplo de "het niet meer trekken" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'No puedo más.' AND notes = 'Ejemplo de "het niet meer trekken" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 34. heftig
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'La noticia del accidente es muy fuerte.', 'PHRASE', 'jerga: heftig', 'HEFTIG = qué fuerte, impactante, impactante, duro, intenso.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — qué fuerte, impactante = heftig.
• en esta tarjeta — heftig va detrás de zijn, con echt.

📖 Palabra a palabra:

• heftig — intenso, violento; también una tormenta o una pelea.

🧩 Expresión fija — heftig:

• literal — violento, intenso.
• significa — impactante, duro, intenso.
• piezas fijas — adjetivo; solo, Heftig! es qué fuerte.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Heftig! | ¡Qué fuerte! |
| 2 | principal | Die film is heftig. | Esa película es muy dura. |
| 3 | imperfecto | Het was een heftige week. | Fue una semana intensa. |

🎯 En qué contexto se usa:

• noticias duras, películas intensas, experiencias fuertes
• Heftig! solo, como qué fuerte
• de todas las edades

🔑 El truco que casi nunca falla: el qué fuerte español ante una noticia dura es heftig.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: heftig' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: heftig' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Het nieuws over het ongeluk is echt heftig.', 'het niöus ofer het ongelük is ejt heftij', '• [uitdr.] Heftig! — ¡Qué fuerte!
• [can.] Die film is heftig. — Esa película es muy dura.
• [imperf.] Het was een heftige week. — Fue una semana intensa.
• [bijzin] Ik vind het heftig wat er is gebeurd. — Me parece muy fuerte lo que ha pasado.
• [imperf.] Ze reageerde heftig. — Reaccionó con violencia.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Qué fuerte!', 'SENTENCE', 'Ejemplo de "heftig" (uitdr.)', 'HEFTIG = qué fuerte, impactante, impactante, duro, intenso.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — qué fuerte, impactante = heftig.
• en esta tarjeta — heftig va detrás de zijn, con echt.

📖 Palabra a palabra:

• heftig — intenso, violento; también una tormenta o una pelea.

🧩 Expresión fija — heftig:

• literal — violento, intenso.
• significa — impactante, duro, intenso.
• piezas fijas — adjetivo; solo, Heftig! es qué fuerte.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Heftig! | ¡Qué fuerte! |
| 2 | principal | Die film is heftig. | Esa película es muy dura. |
| 3 | imperfecto | Het was een heftige week. | Fue una semana intensa. |

🎯 En qué contexto se usa:

• noticias duras, películas intensas, experiencias fuertes
• Heftig! solo, como qué fuerte
• de todas las edades

🔑 El truco que casi nunca falla: el qué fuerte español ante una noticia dura es heftig.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Qué fuerte!' AND notes = 'Ejemplo de "heftig" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Qué fuerte!' AND notes = 'Ejemplo de "heftig" (uitdr.)' LIMIT 1), 'nl_NL', 'Heftig!', 'heftij', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: heftig' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Qué fuerte!' AND notes = 'Ejemplo de "heftig" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: heftig' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: heftig' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Qué fuerte!' AND notes = 'Ejemplo de "heftig" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Qué fuerte!' AND notes = 'Ejemplo de "heftig" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 35. bizar
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Es flipante lo que ha pasado!', 'PHRASE', 'jerga: bizar', 'BIZAR = qué flipe, surrealista, increíble, surrealista.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — qué flipe, surrealista = bizar.
• en esta tarjeta — het anticipa la subordinada con wat.

📖 Palabra a palabra:

• bizar — extraño, surrealista; acento en la última sílaba.

🧩 Expresión fija — bizar:

• literal — extraño.
• significa — increíble, surrealista.
• piezas fijas — adjetivo; Bizar! solo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Bizar! | ¡Qué flipe! |
| 2 | principal | Dat is echt bizar. | Eso es flipante. |
| 3 | imperfecto | Het was een bizarre dag. | Fue un día surrealista. |

🎯 En qué contexto se usa:

• sucesos raros, coincidencias, noticias absurdas
• de todas las edades, muy frecuente
• también para bien, bizar goed, increíblemente bueno

🔑 El truco que casi nunca falla: bizar no es valiente, es raro, como el bizarro mal usado en español.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: bizar' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: bizar' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Het is bizar wat er is gebeurd!', 'het is bisar vat er is jebört', '• [uitdr.] Bizar! — ¡Qué flipe!
• [can.] Dat is echt bizar. — Eso es flipante.
• [imperf.] Het was een bizarre dag. — Fue un día surrealista.
• [bijzin] Ik vind het bizar dat niemand iets zei. — Me parece increíble que nadie dijera nada.
• [imperf.] Het concert was bizar goed. — El concierto fue increíblemente bueno.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Qué flipe!', 'SENTENCE', 'Ejemplo de "bizar" (uitdr.)', 'BIZAR = qué flipe, surrealista, increíble, surrealista.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — qué flipe, surrealista = bizar.
• en esta tarjeta — het anticipa la subordinada con wat.

📖 Palabra a palabra:

• bizar — extraño, surrealista; acento en la última sílaba.

🧩 Expresión fija — bizar:

• literal — extraño.
• significa — increíble, surrealista.
• piezas fijas — adjetivo; Bizar! solo.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Bizar! | ¡Qué flipe! |
| 2 | principal | Dat is echt bizar. | Eso es flipante. |
| 3 | imperfecto | Het was een bizarre dag. | Fue un día surrealista. |

🎯 En qué contexto se usa:

• sucesos raros, coincidencias, noticias absurdas
• de todas las edades, muy frecuente
• también para bien, bizar goed, increíblemente bueno

🔑 El truco que casi nunca falla: bizar no es valiente, es raro, como el bizarro mal usado en español.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Qué flipe!' AND notes = 'Ejemplo de "bizar" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Qué flipe!' AND notes = 'Ejemplo de "bizar" (uitdr.)' LIMIT 1), 'nl_NL', 'Bizar!', 'bisar', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: bizar' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Qué flipe!' AND notes = 'Ejemplo de "bizar" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: bizar' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: bizar' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Qué flipe!' AND notes = 'Ejemplo de "bizar" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Qué flipe!' AND notes = 'Ejemplo de "bizar" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 36. wat een flauwekul
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Qué tontería, eso no es verdad!', 'PHRASE', 'jerga: wat een flauwekul', 'WAT EEN FLAUWEKUL = qué tontería, tontería, chorrada.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — qué tontería = wat een flauwekul.
• en esta tarjeta — wat een más sustantivo.

📖 Palabra a palabra:

• de flauwekul — la tontería, de flauw, soso; sinónimo de onzin.

🧩 Expresión fija — wat een flauwekul:

• literal — tontería sosa.
• significa — tontería, chorrada.
• piezas fijas — de flauwekul, sin plural.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Wat een flauwekul! | ¡Qué tontería! |
| 2 | principal | Dat is flauwekul. | Eso es una tontería. |
| 3 | imperfecto | Hij praatte flauwekul. | Decía tonterías. |

🎯 En qué contexto se usa:

• rechazar algo absurdo que alguien dice
• de todas las edades, algo más de adulto
• más corto, Onzin!

🔑 El truco que casi nunca falla: flauw es soso, y la flauwekul es la charla sosa sin sentido.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: wat een flauwekul' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wat een flauwekul' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Wat een flauwekul, dat is niet waar!', 'vat en flauuekül, dat is nit vaar', '• [uitdr.] Wat een flauwekul! — ¡Qué tontería!
• [can.] Dat is flauwekul. — Eso es una tontería.
• [imperf.] Hij praatte flauwekul. — Decía tonterías.
• [bijzin] Ik vind het flauwekul dat je moet betalen. — Me parece una tontería que tengas que pagar.
• [uitdr.] Onzin! — ¡Tonterías!');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Qué tontería!', 'SENTENCE', 'Ejemplo de "wat een flauwekul" (uitdr.)', 'WAT EEN FLAUWEKUL = qué tontería, tontería, chorrada.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — qué tontería = wat een flauwekul.
• en esta tarjeta — wat een más sustantivo.

📖 Palabra a palabra:

• de flauwekul — la tontería, de flauw, soso; sinónimo de onzin.

🧩 Expresión fija — wat een flauwekul:

• literal — tontería sosa.
• significa — tontería, chorrada.
• piezas fijas — de flauwekul, sin plural.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | Wat een flauwekul! | ¡Qué tontería! |
| 2 | principal | Dat is flauwekul. | Eso es una tontería. |
| 3 | imperfecto | Hij praatte flauwekul. | Decía tonterías. |

🎯 En qué contexto se usa:

• rechazar algo absurdo que alguien dice
• de todas las edades, algo más de adulto
• más corto, Onzin!

🔑 El truco que casi nunca falla: flauw es soso, y la flauwekul es la charla sosa sin sentido.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Qué tontería!' AND notes = 'Ejemplo de "wat een flauwekul" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Qué tontería!' AND notes = 'Ejemplo de "wat een flauwekul" (uitdr.)' LIMIT 1), 'nl_NL', 'Wat een flauwekul!', 'vat en flauuekül', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wat een flauwekul' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Qué tontería!' AND notes = 'Ejemplo de "wat een flauwekul" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wat een flauwekul' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wat een flauwekul' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Qué tontería!' AND notes = 'Ejemplo de "wat een flauwekul" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Qué tontería!' AND notes = 'Ejemplo de "wat een flauwekul" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 37. een held zijn
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Gracias por traerme la comida, ¡eres un crack!', 'PHRASE', 'jerga: een held zijn', 'EEN HELD ZIJN = eres un crack, eres un crack, gracias.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — eres un crack = een held zijn.
• en esta tarjeta — zijn se conjuga bent con je.

📖 Palabra a palabra:

• de held — el héroe.

🧩 Expresión fija — een held zijn:

• literal — eres un héroe.
• significa — eres un crack, gracias.
• piezas fijas — de held, con een.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je bent een held! | ¡Eres un crack! |
| 2 | principal | Jij bent mijn held. | Eres mi héroe. |
| 3 | imperfecto | Hij was die dag de held van de klas. | Ese día fue el héroe de la clase. |

🎯 En qué contexto se usa:

• agradecer con cariño un favor pequeño
• de todas las edades, muy frecuente
• irónico, Wat een held, cuando alguien es cobarde

🔑 El truco que casi nunca falla: por cualquier favor, el neerlandés te llama héroe.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: een held zijn' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: een held zijn' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Bedankt voor het eten, je bent een held!', 'bedankt for het eten, ie bent en helt', '• [can.] Je bent een held! — ¡Eres un crack!
• [can.] Jij bent mijn held. — Eres mi héroe.
• [imperf.] Hij was die dag de held van de klas. — Ese día fue el héroe de la clase.
• [bijzin] Ik vind dat je een held bent. — Creo que eres un crack.
• [uitdr.] Wat een held! — ¡Qué valiente!');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Eres un crack!', 'SENTENCE', 'Ejemplo de "een held zijn" (can.)', 'EEN HELD ZIJN = eres un crack, eres un crack, gracias.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — eres un crack = een held zijn.
• en esta tarjeta — zijn se conjuga bent con je.

📖 Palabra a palabra:

• de held — el héroe.

🧩 Expresión fija — een held zijn:

• literal — eres un héroe.
• significa — eres un crack, gracias.
• piezas fijas — de held, con een.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Je bent een held! | ¡Eres un crack! |
| 2 | principal | Jij bent mijn held. | Eres mi héroe. |
| 3 | imperfecto | Hij was die dag de held van de klas. | Ese día fue el héroe de la clase. |

🎯 En qué contexto se usa:

• agradecer con cariño un favor pequeño
• de todas las edades, muy frecuente
• irónico, Wat een held, cuando alguien es cobarde

🔑 El truco que casi nunca falla: por cualquier favor, el neerlandés te llama héroe.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Eres un crack!' AND notes = 'Ejemplo de "een held zijn" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Eres un crack!' AND notes = 'Ejemplo de "een held zijn" (can.)' LIMIT 1), 'nl_NL', 'Je bent een held!', 'ie bent en helt', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: een held zijn' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Eres un crack!' AND notes = 'Ejemplo de "een held zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: een held zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: een held zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Eres un crack!' AND notes = 'Ejemplo de "een held zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Eres un crack!' AND notes = 'Ejemplo de "een held zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 38. my bad
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Perdona, culpa mía, se me olvidó.', 'PHRASE', 'jerga: my bad', 'MY BAD = culpa mía, culpa mía.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — culpa mía = my bad.
• en esta tarjeta — my bad va en inglés y sin cambios.

📖 Palabra a palabra:

• my bad — culpa mía, en inglés tal cual.

🧩 Expresión fija — my bad:

• literal — del inglés, mi fallo.
• significa — culpa mía.
• piezas fijas — invariable, en inglés.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | My bad! | ¡Culpa mía! |
| 2 | principal | Het is mijn schuld. | Es culpa mía. |
| 3 | imperfecto | Het was mijn fout. | Fue error mío. |

🎯 En qué contexto se usa:

• jóvenes, en el colegio y jugando
• ⚠️ en el trabajo suena demasiado informal, mejor Sorry, mijn fout
• en los chats, sorry mb

🔑 El truco que casi nunca falla: el joven neerlandés pide perdón en inglés.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: my bad' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: my bad' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Sorry, my bad, ik was het vergeten.', 'sorri, mi bat, ik vas het ferjeten', '• [uitdr.] My bad! — ¡Culpa mía!
• [can.] Het is mijn schuld. — Es culpa mía.
• [imperf.] Het was mijn fout. — Fue error mío.
• [bijzin] Ik geef toe dat het mijn fout is. — Admito que es error mío.
• [uitdr.] Sorry, mijn fout. — Perdona, error mío.');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Culpa mía!', 'SENTENCE', 'Ejemplo de "my bad" (uitdr.)', 'MY BAD = culpa mía, culpa mía.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — culpa mía = my bad.
• en esta tarjeta — my bad va en inglés y sin cambios.

📖 Palabra a palabra:

• my bad — culpa mía, en inglés tal cual.

🧩 Expresión fija — my bad:

• literal — del inglés, mi fallo.
• significa — culpa mía.
• piezas fijas — invariable, en inglés.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | expresión | My bad! | ¡Culpa mía! |
| 2 | principal | Het is mijn schuld. | Es culpa mía. |
| 3 | imperfecto | Het was mijn fout. | Fue error mío. |

🎯 En qué contexto se usa:

• jóvenes, en el colegio y jugando
• ⚠️ en el trabajo suena demasiado informal, mejor Sorry, mijn fout
• en los chats, sorry mb

🔑 El truco que casi nunca falla: el joven neerlandés pide perdón en inglés.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Culpa mía!' AND notes = 'Ejemplo de "my bad" (uitdr.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¡Culpa mía!' AND notes = 'Ejemplo de "my bad" (uitdr.)' LIMIT 1), 'nl_NL', 'My bad!', 'mi bat', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: my bad' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¡Culpa mía!' AND notes = 'Ejemplo de "my bad" (uitdr.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: my bad' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: my bad' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Culpa mía!' AND notes = 'Ejemplo de "my bad" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¡Culpa mía!' AND notes = 'Ejemplo de "my bad" (uitdr.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 39. wat heb jij
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Qué te pasa hoy? Estás muy callado.', 'PHRASE', 'jerga: wat heb jij', 'WAT HEB JIJ = qué te pasa, qué te pasa, a menudo con reproche.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — qué te pasa = wat heb jij.
• en esta tarjeta — pregunta con hebben, el verbo delante del sujeto.

📖 Palabra a palabra:

• hebben — tener; aquí pasarle algo a alguien.

🧩 Expresión fija — wat heb jij:

• literal — qué tienes tú.
• significa — qué te pasa, a menudo con reproche.
• piezas fijas — wat más hebben más jij; con jij acentuado suena a reproche.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pregunta | Wat heb jij? | ¿Qué te pasa? |
| 2 | pregunta | Wat is er? | ¿Qué pasa? |
| 3 | pregunta | Wat had hij gisteren? | ¿Qué le pasaba ayer? |

🎯 En qué contexto se usa:

• cuando alguien está raro, borde o callado
• ⚠️ con tono duro es a ti qué te pasa
• más amable, Wat is er?

🔑 El truco que casi nunca falla: si en español preguntas qué te pasa, el neerlandés pregunta qué tienes.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: wat heb jij' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wat heb jij' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Wat heb jij vandaag? Je bent zo stil.', 'vat heb iei fandaaj ie bent so stil', '• [vraag] Wat heb jij? — ¿Qué te pasa?
• [vraag] Wat is er? — ¿Qué pasa?
• [vraag] Wat had hij gisteren? — ¿Qué le pasaba ayer?
• [bijzin] Ik weet niet wat ze heeft. — No sé qué le pasa.
• [vraag] Is er iets? — ¿Pasa algo?');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Qué te pasa?', 'SENTENCE', 'Ejemplo de "wat heb jij" (vraag)', 'WAT HEB JIJ = qué te pasa, qué te pasa, a menudo con reproche.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — qué te pasa = wat heb jij.
• en esta tarjeta — pregunta con hebben, el verbo delante del sujeto.

📖 Palabra a palabra:

• hebben — tener; aquí pasarle algo a alguien.

🧩 Expresión fija — wat heb jij:

• literal — qué tienes tú.
• significa — qué te pasa, a menudo con reproche.
• piezas fijas — wat más hebben más jij; con jij acentuado suena a reproche.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | pregunta | Wat heb jij? | ¿Qué te pasa? |
| 2 | pregunta | Wat is er? | ¿Qué pasa? |
| 3 | pregunta | Wat had hij gisteren? | ¿Qué le pasaba ayer? |

🎯 En qué contexto se usa:

• cuando alguien está raro, borde o callado
• ⚠️ con tono duro es a ti qué te pasa
• más amable, Wat is er?

🔑 El truco que casi nunca falla: si en español preguntas qué te pasa, el neerlandés pregunta qué tienes.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Qué te pasa?' AND notes = 'Ejemplo de "wat heb jij" (vraag)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¿Qué te pasa?' AND notes = 'Ejemplo de "wat heb jij" (vraag)' LIMIT 1), 'nl_NL', 'Wat heb jij?', 'vat heb iei', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wat heb jij' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = '¿Qué te pasa?' AND notes = 'Ejemplo de "wat heb jij" (vraag)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wat heb jij' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: wat heb jij' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¿Qué te pasa?' AND notes = 'Ejemplo de "wat heb jij" (vraag)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = '¿Qué te pasa?' AND notes = 'Ejemplo de "wat heb jij" (vraag)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 40. er niet uit zijn
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Todavía no sé si aceptar el trabajo.', 'PHRASE', 'jerga: er niet uit zijn', 'ER NIET UIT ZIJN = no decidirse, no haberse decidido todavía.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no decidirse = er niet uit zijn.
• en esta tarjeta — er … uit con of más subordinada detrás, y aanneem al final.

📖 Palabra a palabra:

• uit — fuera; aquí salir de la duda.

🧩 Expresión fija — er niet uit zijn:

• literal — no estar fuera de ello.
• significa — no haberse decidido todavía.
• piezas fijas — er … uit zijn; eruit komen es llegar a una decisión.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben er nog niet uit. | Todavía no me he decidido. |
| 2 | principal | We komen er wel uit. | Ya lo resolveremos. |
| 3 | imperfecto | Ze was er niet uit. | No se decidía. |

🎯 En qué contexto se usa:

• decisiones pendientes, compras, viajes
• de todas las edades
• We komen er wel uit, ya lo resolveremos

🔑 El truco que casi nunca falla: estás dentro de la duda y todavía no has salido, er niet uit.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'jerga: er niet uit zijn' AND word_type = 'PHRASE');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: er niet uit zijn' AND word_type = 'PHRASE' LIMIT 1), 'nl_NL', 'Ik ben er nog niet uit of ik de baan aanneem.', 'ik ben er noj nit öit of ik de baan aanem', '• [can.] Ik ben er nog niet uit. — Todavía no me he decidido.
• [can.] We komen er wel uit. — Ya lo resolveremos.
• [imperf.] Ze was er niet uit. — No se decidía.
• [geb.] Laat het me weten als je eruit bent. — Avísame cuando te decidas.
• [perf.] Zijn jullie eruit gekomen? — ¿Os habéis decidido?');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Todavía no me he decidido.', 'SENTENCE', 'Ejemplo de "er niet uit zijn" (can.)', 'ER NIET UIT ZIJN = no decidirse, no haberse decidido todavía.

🔤 La construcción original y cómo entra en la frase:

• frase hecha — no decidirse = er niet uit zijn.
• en esta tarjeta — er … uit con of más subordinada detrás, y aanneem al final.

📖 Palabra a palabra:

• uit — fuera; aquí salir de la duda.

🧩 Expresión fija — er niet uit zijn:

• literal — no estar fuera de ello.
• significa — no haberse decidido todavía.
• piezas fijas — er … uit zijn; eruit komen es llegar a una decisión.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik ben er nog niet uit. | Todavía no me he decidido. |
| 2 | principal | We komen er wel uit. | Ya lo resolveremos. |
| 3 | imperfecto | Ze was er niet uit. | No se decidía. |

🎯 En qué contexto se usa:

• decisiones pendientes, compras, viajes
• de todas las edades
• We komen er wel uit, ya lo resolveremos

🔑 El truco que casi nunca falla: estás dentro de la duda y todavía no has salido, er niet uit.

🛹 Spreektaal, jongerentaal o straattaal, quién dice qué:

| # | registro | quién lo dice | ejemplo |
|---|---|---|---|
| 1 | **spreektaal** | todo el mundo, en confianza | het valt mee, balen |
| 2 | **jongerentaal** | adolescentes y jóvenes, con mucho inglés | cringe, chill, vet |
| 3 | **straattaal** | jóvenes de ciudad, del sranan, el árabe marroquí y el papiamento | wollah, mattie, doekoe |

• entenderlo — siempre, es lo que oirás en el tren, en el colegio y en las series.
• usarlo — con cuidado, un adulto que dice wollah o doekoe suena a querer hacerse el joven.
• con el jefe o de usted — nada de esto, usa la alternativa neutra que da cada tarjeta.
• effe, joh, hè — palabritas habladas que dan tono, effe es even, joh es hombre y hè es eh.

🔑 El truco que casi nunca falla: antes de usar una frase, mira en qué fila de la tabla cae, la 1 vale para todos y la 3 solo entre jóvenes.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Todavía no me he decidido.' AND notes = 'Ejemplo de "er niet uit zijn" (can.)');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'Todavía no me he decidido.' AND notes = 'Ejemplo de "er niet uit zijn" (can.)' LIMIT 1), 'nl_NL', 'Ik ben er nog niet uit.', 'ik ben er noj nit öit', NULL);
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: er niet uit zijn' AND word_type = 'PHRASE' LIMIT 1),
        (SELECT id FROM words_es WHERE text = 'Todavía no me he decidido.' AND notes = 'Ejemplo de "er niet uit zijn" (can.)' LIMIT 1), 'EXAMPLE');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: er niet uit zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE notes = 'jerga: er niet uit zijn' AND word_type = 'PHRASE' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Todavía no me he decidido.' AND notes = 'Ejemplo de "er niet uit zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'jerga juvenil - jongerentaal en straattaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id) VALUES ((SELECT id FROM words_es WHERE text = 'Todavía no me he decidido.' AND notes = 'Ejemplo de "er niet uit zijn" (can.)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
