-- Learn Languages App - Migration
-- Migration: 20261029000005-grupo-kim-koken
-- Description: Eduardo: "vamos a crear grupos kin con todas estas palabras ... ojo revisa que no
--   existan", sobre las listas de Quizlet de Learn Dutch with Kim. Seleccion aprobada por frecuencia
--   (wordfreq Zipf): entran los niveles A, B y C; del D se descartan los compuestos que se forman
--   con piezas ya estudiadas.
--
--   Grupo 'kim - koken en keuken' (lista Koken en keuken, quizlet.com/_982qjv). 30 tarjetas WORD
--   nuevas, cada una con articulo en la respuesta (§3.1), pronunciacion, 5 frases en notes (§3.7) y
--   ayuda corta con plural. Sinonimos fundidos en una tarjeta: de vaatwasser, de afwasmachine.
--   Descartados del nivel D: de wasbak, de koekenpan (en la ayuda de de pan), het koffiezetapparaat,
--   het (gas)fornuis, de keukenkast, de keukendoek (en la ayuda de de handdoek, como de theedoek).
--   Ninguna existia en el mazo (cruce por words_lang.text el 2026-10-29).
--
--   Bloques compartidos (§3.3): '🍽️ Bord, schaal o schotel' (bord, schaal, schotel) y
--   '☕ Kopje o mok' (kopje, mok). De afwas lleva la expresion fija de afwas doen (§3.10).
--   Het zout y de peper se ENLAZAN desde las migraciones 02 (eten) y 04 (groente en fruit): si aun
--   no existen, el enlace no inserta nada.

PRAGMA foreign_keys = ON;

-- 1. El grupo

INSERT INTO word_groups (title, description, source)
SELECT 'kim - koken en keuken', 'Vocabulario de la cocina de la lista de Kim: utensilios, aparatos y vajilla, cada uno con su de/het y su plural. Incluye las parejas que se confunden, het bord frente a de schaal y de schotel, y het kopje frente a de mok, y la expresion fija de afwas doen. Het zout y de peper se enlazan desde los grupos de eten y de groente en fruit.', 'Koken en keuken - Flashcards in Quizlet - Learn Dutch with Kim - https://quizlet.com/_982qjv'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'kim - koken en keuken');

-- 2. Las 30 tarjetas WORD

-- 2.1 het water
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el agua', 'WORD', 'kim - koken en keuken: het water', 'het water = el agua. Incontable, sin plural en el uso diario.

• het — como casi todo líquido o materia sin forma: het water, het bier, het zout, het vlees.
• het kraanwater — el agua del grifo, que en Holanda se bebe sin problema.
• een karaf kraanwater — lo que se pide en el restaurante para no pagar agua embotellada.

💡 Als een vis in het water = como pez en el agua, la misma imagen que en español.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el agua' AND notes = 'kim - koken en keuken: het water');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el agua' AND notes = 'kim - koken en keuken: het water' LIMIT 1), 'nl_NL', 'het water', 'et váater', '• [can.] Ik drink elke dag twee liter water. — Bebo dos litros de agua al día.
• [vraag] Mag ik een glas water? — ¿Me da un vaso de agua?
• [perf.] Heb je de planten al water gegeven? — ¿Ya has regado las plantas?
• [bijzin] Ik doe de pasta erin zodra het water kookt. — Echo la pasta en cuanto hierve el agua.
• [uitdr.] Hij voelt zich als een vis in het water. — Está como pez en el agua.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el agua' AND notes = 'kim - koken en keuken: het water' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el agua' AND notes = 'kim - koken en keuken: het water' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.2 de keuken
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la cocina', 'WORD', 'kim - koken en keuken: de keuken', 'de keuken = la cocina, el cuarto y también el estilo de comida. Plural keukens.

• de Spaanse keuken — la cocina española, como estilo.
• in de keuken — en la cocina, el sitio.

⚠️ La cocina es de keuken, pero cocinar es koken: ik kook in de keuken. No confundir el sitio con la acción.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la cocina' AND notes = 'kim - koken en keuken: de keuken');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la cocina' AND notes = 'kim - koken en keuken: de keuken' LIMIT 1), 'nl_NL', 'de keuken', 'de køken', '• [can.] De keuken is klein maar gezellig. — La cocina es pequeña pero acogedora.
• [inv.] In de keuken staat altijd koffie klaar. — En la cocina siempre hay café preparado.
• [perf.] We hebben vorig jaar een nieuwe keuken laten plaatsen. — El año pasado nos pusieron una cocina nueva.
• [vraag] Houd je van de Italiaanse keuken? — ¿Te gusta la cocina italiana?
• [bijzin] Ik weet niet of hij in de keuken is. — No sé si está en la cocina.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la cocina' AND notes = 'kim - koken en keuken: de keuken' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la cocina' AND notes = 'kim - koken en keuken: de keuken' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.3 het glas
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el vaso', 'WORD', 'kim - koken en keuken: het glas', 'het glas = el vaso, la copa y también el vidrio como material. Plural glazen.

• el plural cambia la s por z — het glas, de glazen; igual que het gras, de grazen.
• het glas como material es incontable — een fles van glas, una botella de vidrio.

📌 Regla de bolsillo:
• ¿Bebida fría o vino? → het glas.
• ¿Bebida caliente con asa? → het kopje o de mok.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el vaso' AND notes = 'kim - koken en keuken: het glas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el vaso' AND notes = 'kim - koken en keuken: het glas' LIMIT 1), 'nl_NL', 'het glas', 'et jlas', '• [can.] Het glas is leeg. — El vaso está vacío.
• [perf.] Ik heb een glas laten vallen. — Se me ha caído un vaso.
• [vraag] Wil je een glas wijn? — ¿Quieres una copa de vino?
• [geb.] Pak even een glas uit de kast. — Coge un vaso del armario.
• [uitdr.] Laten we het glas heffen op de bruid! — ¡Levantemos la copa por la novia!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el vaso' AND notes = 'kim - koken en keuken: het glas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el vaso' AND notes = 'kim - koken en keuken: het glas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.4 de schaal
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el cuenco, la fuente', 'WORD', 'kim - koken en keuken: de schaal', 'de schaal = el cuenco o la fuente de servir. Plural schalen.

• de schaal es también la escala — op grote schaal, a gran escala.
• de weegschaal — la balanza, la báscula.
• de schaal van een ei — la cáscara de un huevo.

🍽️ Bord, schaal o schotel:

| # | palabra | qué es | ejemplo |
|---|---|---|---|
| 1 | het bord | el plato individual, del que comes tú | Ik eet van mijn bord. |
| 2 | de schaal | el cuenco o la fuente de la que se sirven todos | De aardappels zitten in de schaal. |
| 3 | de schotel | el platillo de la taza, la fuente de horno o el plato cocinado | Het kopje staat op een schoteltje. |

📌 Regla de bolsillo:
• ¿Comes de él? → het bord.
• ¿Se sirve de él para todos? → de schaal.
• ¿Va debajo de la taza o al horno? → de schotel.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el cuenco, la fuente' AND notes = 'kim - koken en keuken: de schaal');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuenco, la fuente' AND notes = 'kim - koken en keuken: de schaal' LIMIT 1), 'nl_NL', 'de schaal', 'de sxaal', '• [can.] De soep staat in een grote schaal op tafel. — La sopa está en una fuente grande en la mesa.
• [perf.] Ik heb de sla in een schaal gedaan. — He puesto la lechuga en un cuenco.
• [geb.] Zet de schaal maar in de koelkast. — Mete la fuente en la nevera.
• [vraag] Weet je waar de glazen schaal staat? — ¿Sabes dónde está la fuente de cristal?
• [inv.] Op deze schaal zie je hoe groot het land is. — En esta escala ves lo grande que es el país.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuenco, la fuente' AND notes = 'kim - koken en keuken: de schaal' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuenco, la fuente' AND notes = 'kim - koken en keuken: de schaal' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.5 het bord
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el plato', 'WORD', 'kim - koken en keuken: het bord', 'het bord = el plato del que se come. Plural borden.

• het bord es también el cartel o la pizarra — het verkeersbord, het schoolbord.
• la d final suena t — bort.

🍽️ Bord, schaal o schotel:

| # | palabra | qué es | ejemplo |
|---|---|---|---|
| 1 | het bord | el plato individual, del que comes tú | Ik eet van mijn bord. |
| 2 | de schaal | el cuenco o la fuente de la que se sirven todos | De aardappels zitten in de schaal. |
| 3 | de schotel | el platillo de la taza, la fuente de horno o el plato cocinado | Het kopje staat op een schoteltje. |

📌 Regla de bolsillo:
• ¿Comes de él? → het bord.
• ¿Se sirve de él para todos? → de schaal.
• ¿Va debajo de la taza o al horno? → de schotel.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el plato' AND notes = 'kim - koken en keuken: het bord');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el plato' AND notes = 'kim - koken en keuken: het bord' LIMIT 1), 'nl_NL', 'het bord', 'et bort', '• [can.] Er ligt nog eten op je bord. — Todavía te queda comida en el plato.
• [geb.] Zet de borden maar op tafel. — Pon los platos en la mesa.
• [perf.] Wie heeft dit bord gebroken? — ¿Quién ha roto este plato?
• [bijzin] Ik ruim af zodra iedereen zijn bord leeg heeft. — Recojo en cuanto todos han vaciado el plato.
• [uitdr.] Ze heeft veel op haar bord. — Tiene mucho entre manos.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el plato' AND notes = 'kim - koken en keuken: het bord' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el plato' AND notes = 'kim - koken en keuken: het bord' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.6 het recept
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la receta', 'WORD', 'kim - koken en keuken: het recept', 'het recept = la receta, de cocina y también la del médico. Plural recepten.

• se escribe con c y la c suena s — recept, resépt.
• een recept volgen — seguir una receta.
• op recept — con receta médica.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la receta' AND notes = 'kim - koken en keuken: het recept');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la receta' AND notes = 'kim - koken en keuken: het recept' LIMIT 1), 'nl_NL', 'het recept', 'et resépt', '• [can.] Dit recept is van mijn oma. — Esta receta es de mi abuela.
• [perf.] Ik heb het recept online gevonden. — He encontrado la receta en internet.
• [vraag] Mag ik het recept van die taart? — ¿Me das la receta de esa tarta?
• [bijzin] Ik kook altijd zonder dat ik een recept volg. — Siempre cocino sin seguir ninguna receta.
• [inv.] Voor dit medicijn heb je een recept nodig. — Para este medicamento necesitas receta.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la receta' AND notes = 'kim - koken en keuken: het recept' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la receta' AND notes = 'kim - koken en keuken: het recept' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.7 de fles
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la botella', 'WORD', 'kim - koken en keuken: de fles', 'de fles = la botella. Plural flessen, con doble s.

• een fles wijn — una botella de vino, sin van.
• het statiegeld — el depósito que pagas por la botella y te devuelven al llevarla al súper.
• de babyfles — el biberón.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la botella' AND notes = 'kim - koken en keuken: de fles');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la botella' AND notes = 'kim - koken en keuken: de fles' LIMIT 1), 'nl_NL', 'de fles', 'de fles', '• [can.] De fles is half vol. — La botella está medio llena.
• [vraag] Zullen we een fles wijn openmaken? — ¿Abrimos una botella de vino?
• [perf.] Ik heb de lege flessen teruggebracht naar de supermarkt. — He devuelto las botellas vacías al supermercado.
• [geb.] Doe de dop weer op de fles. — Vuelve a poner el tapón a la botella.
• [bijzin] Ik weet niet hoeveel flessen we nodig hebben. — No sé cuántas botellas necesitamos.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la botella' AND notes = 'kim - koken en keuken: de fles' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la botella' AND notes = 'kim - koken en keuken: de fles' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.8 de pan
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la olla, la cazuela', 'WORD', 'kim - koken en keuken: de pan', 'de pan = la olla o cazuela, cualquier recipiente con mango para el fuego. Plural pannen.

• de koekenpan — la sartén.
• het deksel — la tapa.

⚠️ Falso amigo: el pan es het brood, nunca pan.

💡 de pan uit rijzen = dispararse, crecer sin control, como la masa que se sale de la olla.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la olla, la cazuela' AND notes = 'kim - koken en keuken: de pan');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la olla, la cazuela' AND notes = 'kim - koken en keuken: de pan' LIMIT 1), 'nl_NL', 'de pan', 'de pan', '• [can.] De pan staat op het vuur. — La olla está en el fuego.
• [perf.] Ik heb de soep in een grote pan gemaakt. — He hecho la sopa en una olla grande.
• [geb.] Doe het deksel op de pan. — Pon la tapa a la olla.
• [vraag] Is de pan nog heet? — ¿Sigue caliente la olla?
• [uitdr.] De prijzen rijzen de pan uit. — Los precios se disparan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la olla, la cazuela' AND notes = 'kim - koken en keuken: de pan' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la olla, la cazuela' AND notes = 'kim - koken en keuken: de pan' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.9 het mes
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el cuchillo', 'WORD', 'kim - koken en keuken: het mes', 'het mes = el cuchillo. Plural messen, con doble s.

• mes en vork — cuchillo y tenedor, en el mismo orden que en español.
• scherp ↔ bot — afilado ↔ sin filo.

⚠️ Falso amigo: el mes del calendario es de maand.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el cuchillo' AND notes = 'kim - koken en keuken: het mes');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuchillo' AND notes = 'kim - koken en keuken: het mes' LIMIT 1), 'nl_NL', 'het mes', 'et mes', '• [can.] Dit mes is niet scherp. — Este cuchillo no está afilado.
• [perf.] Ik heb me met het mes in mijn vinger gesneden. — Me he cortado el dedo con el cuchillo.
• [geb.] Leg het mes rechts van het bord. — Pon el cuchillo a la derecha del plato.
• [vraag] Heb je een scherp mes voor het vlees? — ¿Tienes un cuchillo afilado para la carne?
• [uitdr.] Het mes snijdt aan twee kanten. — Tiene doble ventaja.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuchillo' AND notes = 'kim - koken en keuken: het mes' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuchillo' AND notes = 'kim - koken en keuken: het mes' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.10 de kok
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el cocinero', 'WORD', 'kim - koken en keuken: de kok', 'de kok = el cocinero. Plural koks.

• viene de koken, cocinar — el que kookt es de kok.
• profesión sin artículo — Hij is kok, igual que Ik ben leraar.
• de kokkin — la cocinera, poco usado; hoy se dice kok también para ella.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el cocinero' AND notes = 'kim - koken en keuken: de kok');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el cocinero' AND notes = 'kim - koken en keuken: de kok' LIMIT 1), 'nl_NL', 'de kok', 'de kok', '• [can.] Mijn broer is kok in een restaurant. — Mi hermano es cocinero en un restaurante.
• [perf.] De kok heeft vandaag vis klaargemaakt. — El cocinero ha preparado pescado hoy.
• [vraag] Wie is hier de kok? — ¿Quién cocina aquí?
• [bijzin] Ik denk dat hij een goede kok is. — Creo que es un buen cocinero.
• [uitdr.] Veel koks bederven de brij. — Muchas manos en un plato hacen mucho garabato.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cocinero' AND notes = 'kim - koken en keuken: de kok' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cocinero' AND notes = 'kim - koken en keuken: de kok' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.11 het kopje
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la taza', 'WORD', 'kim - koken en keuken: het kopje', 'het kopje = la taza. Plural kopjes.

• es el diminutivo de de kop, y todo diminutivo en -je es het.
• een kopje koffie — una taza de café, sin van.
• de kop sola es la taza grande, el titular o la cabeza de un animal.

☕ Kopje o mok:

| # | palabra | qué es | ejemplo |
|---|---|---|---|
| 1 | het kopje | la taza pequeña con platillo, la de las visitas | Een kopje koffie bij oma. |
| 2 | de mok | el tazón grande sin platillo, el de casa o la oficina | Een mok thee achter de computer. |

🔑 El truco que casi nunca falla: ¿lleva platillo? → kopje · ¿tazón grande sin platillo? → mok.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la taza' AND notes = 'kim - koken en keuken: het kopje');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la taza' AND notes = 'kim - koken en keuken: het kopje' LIMIT 1), 'nl_NL', 'het kopje', 'et kópie', '• [can.] Ik drink elke ochtend een kopje koffie. — Todas las mañanas me tomo una taza de café.
• [vraag] Wil je een kopje thee? — ¿Quieres una taza de té?
• [perf.] Ik heb al drie kopjes koffie gehad. — Ya me he tomado tres tazas de café.
• [geb.] Zet de kopjes maar in de vaatwasser. — Mete las tazas en el lavavajillas.
• [bijzin] Kom langs voor een kopje koffie als je tijd hebt. — Pásate a tomar un café si tienes tiempo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la taza' AND notes = 'kim - koken en keuken: het kopje' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la taza' AND notes = 'kim - koken en keuken: het kopje' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.12 de maaltijd
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'cada comida del día', 'WORD', 'kim - koken en keuken: de maaltijd', 'de maaltijd = la comida como acto, cada una de las del día. Plural maaltijden.

• el compuesto toma el género de la última pieza — de tijd → de maaltijd.
• de warme maaltijd — la comida caliente, que en Holanda es la cena, hacia las seis.

📌 Regla de bolsillo:
• ¿La comida como alimento? → het eten.
• ¿La comida como momento, desayuno, almuerzo o cena? → de maaltijd.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'cada comida del día' AND notes = 'kim - koken en keuken: de maaltijd');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'cada comida del día' AND notes = 'kim - koken en keuken: de maaltijd' LIMIT 1), 'nl_NL', 'de maaltijd', 'de máaltait', '• [can.] Het ontbijt is de belangrijkste maaltijd van de dag. — El desayuno es la comida más importante del día.
• [perf.] We hebben samen een warme maaltijd gegeten. — Hemos tomado juntos una comida caliente.
• [vraag] Hoeveel maaltijden eet jij per dag? — ¿Cuántas comidas haces al día?
• [inv.] Om zes uur eten we de warme maaltijd. — A las seis tomamos la comida caliente.
• [uitdr.] Eet smakelijk, geniet van je maaltijd! — ¡Que aproveche, disfruta de la comida!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cada comida del día' AND notes = 'kim - koken en keuken: de maaltijd' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'cada comida del día' AND notes = 'kim - koken en keuken: de maaltijd' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.13 de liter
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el litro', 'WORD', 'kim - koken en keuken: de liter', 'de liter = el litro. Plural liters, pero tras un número va en singular.

• twee liter melk — dos litros de leche, en singular y sin van.
• een halve liter — medio litro · anderhalve liter — litro y medio.

📌 Regla de bolsillo: número + medida = singular — drie liter, vijf kilo, tien euro.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el litro' AND notes = 'kim - koken en keuken: de liter');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el litro' AND notes = 'kim - koken en keuken: de liter' LIMIT 1), 'nl_NL', 'de liter', 'de líter', '• [can.] Een liter melk kost ongeveer een euro. — Un litro de leche cuesta más o menos un euro.
• [perf.] Ik heb vandaag al anderhalve liter water gedronken. — Hoy ya he bebido litro y medio de agua.
• [vraag] Hoeveel liter past erin? — ¿Cuántos litros caben?
• [geb.] Doe er een halve liter water bij. — Añade medio litro de agua.
• [bijzin] De auto verbruikt zes liter als je rustig rijdt. — El coche gasta seis litros si conduces tranquilo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el litro' AND notes = 'kim - koken en keuken: de liter' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el litro' AND notes = 'kim - koken en keuken: de liter' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.14 de koelkast
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la nevera, el frigorífico', 'WORD', 'kim - koken en keuken: de koelkast', 'de koelkast = la nevera. Plural koelkasten.

🧠 La imagen:
• koel, fresco + de kast, el armario — el armario fresco; el compuesto toma el de de kast.

• in de koelkast zetten — meter en la nevera, con zetten porque lo que se mete queda de pie.
• ↔ de vriezer — el congelador.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la nevera, el frigorífico' AND notes = 'kim - koken en keuken: de koelkast');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la nevera, el frigorífico' AND notes = 'kim - koken en keuken: de koelkast' LIMIT 1), 'nl_NL', 'de koelkast', 'de kúlkast', '• [can.] De melk staat in de koelkast. — La leche está en la nevera.
• [geb.] Doe de koelkast dicht! — ¡Cierra la nevera!
• [perf.] Heb je de boter in de koelkast gezet? — ¿Has metido la mantequilla en la nevera?
• [vraag] Is er nog bier in de koelkast? — ¿Queda cerveza en la nevera?
• [bijzin] Ik zie dat de koelkast bijna leeg is. — Veo que la nevera está casi vacía.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la nevera, el frigorífico' AND notes = 'kim - koken en keuken: de koelkast' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la nevera, el frigorífico' AND notes = 'kim - koken en keuken: de koelkast' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.15 de oven
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el horno', 'WORD', 'kim - koken en keuken: de oven', 'de oven = el horno. Plural ovens.

• la v suena casi f — óofen.
• vers uit de oven — recién salido del horno.
• de oven aanzetten / uitzetten — encender / apagar el horno.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el horno' AND notes = 'kim - koken en keuken: de oven');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el horno' AND notes = 'kim - koken en keuken: de oven' LIMIT 1), 'nl_NL', 'de oven', 'de óofen', '• [can.] De pizza zit in de oven. — La pizza está en el horno.
• [perf.] Ik heb de oven voorverwarmd. — He precalentado el horno.
• [geb.] Zet de oven op 180 graden. — Pon el horno a 180 grados.
• [vraag] Staat de oven nog aan? — ¿Sigue encendido el horno?
• [bijzin] Haal de taart eruit als de oven piept. — Saca la tarta cuando pite el horno.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el horno' AND notes = 'kim - koken en keuken: de oven' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el horno' AND notes = 'kim - koken en keuken: de oven' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.16 de kraan
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el grifo', 'WORD', 'kim - koken en keuken: de kraan', 'de kraan = el grifo, y también la grúa. Plural kranen, con una sola a.

🧠 La imagen:
• de kraanvogel es la grulla, el ave de cuello largo; el grifo y la grúa son los dos un cuello largo que gira.

• de kraan opendraaien / dichtdraaien — abrir / cerrar el grifo, girándolo.
• het kraanwater — el agua del grifo.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el grifo' AND notes = 'kim - koken en keuken: de kraan');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el grifo' AND notes = 'kim - koken en keuken: de kraan' LIMIT 1), 'nl_NL', 'de kraan', 'de kraan', '• [can.] De kraan lekt. — El grifo gotea.
• [geb.] Draai de kraan dicht, alsjeblieft. — Cierra el grifo, por favor.
• [perf.] Wie heeft de kraan open laten staan? — ¿Quién ha dejado el grifo abierto?
• [inv.] Op de bouwplaats staat een enorme kraan. — En la obra hay una grúa enorme.
• [bijzin] Je kunt hier water uit de kraan drinken, omdat het heel schoon is. — Aquí puedes beber agua del grifo porque está muy limpia.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el grifo' AND notes = 'kim - koken en keuken: de kraan' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el grifo' AND notes = 'kim - koken en keuken: de kraan' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.17 de handdoek
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la toalla', 'WORD', 'kim - koken en keuken: de handdoek', 'de handdoek = la toalla. Plural handdoeken.

🧠 La imagen:
• de hand + de doek, el paño — el paño para las manos.

• de theedoek — el paño de cocina, el de secar los platos.
• de handdoek in de ring gooien — tirar la toalla, la misma imagen del boxeo que en español.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la toalla' AND notes = 'kim - koken en keuken: de handdoek');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la toalla' AND notes = 'kim - koken en keuken: de handdoek' LIMIT 1), 'nl_NL', 'de handdoek', 'de hándduk', '• [can.] Er hangt een schone handdoek in de badkamer. — Hay una toalla limpia en el baño.
• [geb.] Neem een handdoek mee naar het strand. — Llévate una toalla a la playa.
• [perf.] Ik heb alle handdoeken gewassen. — He lavado todas las toallas.
• [vraag] Waar liggen de handdoeken? — ¿Dónde están las toallas?
• [uitdr.] Na drie rondes gooide hij de handdoek in de ring. — Al tercer asalto tiró la toalla.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la toalla' AND notes = 'kim - koken en keuken: de handdoek' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la toalla' AND notes = 'kim - koken en keuken: de handdoek' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.18 de lepel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la cuchara', 'WORD', 'kim - koken en keuken: de lepel', 'de lepel = la cuchara. Plural lepels.

• het lepeltje — la cucharilla, en het porque es diminutivo.
• de eetlepel / de theelepel — la cucharada sopera / la cucharadita de las recetas, abreviadas el y tl.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la cuchara' AND notes = 'kim - koken en keuken: de lepel');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la cuchara' AND notes = 'kim - koken en keuken: de lepel' LIMIT 1), 'nl_NL', 'de lepel', 'de léepel', '• [can.] Soep eet je met een lepel. — La sopa se come con cuchara.
• [geb.] Geef me even een lepel. — Pásame una cuchara.
• [perf.] Ik heb twee lepels suiker in mijn thee gedaan. — Me he echado dos cucharadas de azúcar en el té.
• [vraag] Heb je een lepeltje voor de yoghurt? — ¿Tienes una cucharilla para el yogur?
• [bijzin] Roer met een houten lepel, zodat de pan niet krast. — Remueve con una cuchara de madera para que no se raye la olla.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la cuchara' AND notes = 'kim - koken en keuken: de lepel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la cuchara' AND notes = 'kim - koken en keuken: de lepel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.19 de vork
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el tenedor', 'WORD', 'kim - koken en keuken: de vork', 'de vork = el tenedor. Plural vorken.

• la v inicial suena casi f — fork.
• links de vork, rechts het mes — como en España.

💡 weten hoe de vork in de steel zit = saber cómo están las cosas de verdad, literalmente cómo encaja el tenedor en el mango.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el tenedor' AND notes = 'kim - koken en keuken: de vork');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el tenedor' AND notes = 'kim - koken en keuken: de vork' LIMIT 1), 'nl_NL', 'de vork', 'de fork', '• [can.] Ik eet met mes en vork. — Como con cuchillo y tenedor.
• [geb.] Leg de vork links van het bord. — Pon el tenedor a la izquierda del plato.
• [perf.] Ik heb mijn vork laten vallen. — Se me ha caído el tenedor.
• [vraag] Mag ik een schone vork? — ¿Me trae un tenedor limpio?
• [uitdr.] Nu weet ik hoe de vork in de steel zit. — Ahora sé de qué va el asunto.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tenedor' AND notes = 'kim - koken en keuken: de vork' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tenedor' AND notes = 'kim - koken en keuken: de vork' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.20 de vriezer
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el congelador', 'WORD', 'kim - koken en keuken: de vriezer', 'de vriezer = el congelador. Plural vriezers.

• viene de vriezen, helar — invriezen es congelar, ontdooien es descongelar.
• el aparato que hace algo y acaba en -er suele ser de — de vriezer, de wekker, de computer.
• ↔ de koelkast — la nevera.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el congelador' AND notes = 'kim - koken en keuken: de vriezer');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el congelador' AND notes = 'kim - koken en keuken: de vriezer' LIMIT 1), 'nl_NL', 'de vriezer', 'de fríiser', '• [can.] Het ijs zit in de vriezer. — El helado está en el congelador.
• [perf.] Ik heb het vlees in de vriezer gelegd. — He metido la carne en el congelador.
• [geb.] Haal de erwtjes uit de vriezer. — Saca los guisantes del congelador.
• [vraag] Is er nog plek in de vriezer? — ¿Queda sitio en el congelador?
• [bijzin] Ik weet niet of de vriezer nog werkt. — No sé si el congelador sigue funcionando.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el congelador' AND notes = 'kim - koken en keuken: de vriezer' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el congelador' AND notes = 'kim - koken en keuken: de vriezer' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.21 de schotel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el platillo, la fuente de horno', 'WORD', 'kim - koken en keuken: de schotel', 'de schotel = el platillo, la fuente de horno y también el plato cocinado. Plural schotels.

• het schoteltje — el platillo de la taza, en het porque es diminutivo.
• de ovenschotel — el plato al horno, el gratinado.
• de schotel — también la antena parabólica.

🍽️ Bord, schaal o schotel:

| # | palabra | qué es | ejemplo |
|---|---|---|---|
| 1 | het bord | el plato individual, del que comes tú | Ik eet van mijn bord. |
| 2 | de schaal | el cuenco o la fuente de la que se sirven todos | De aardappels zitten in de schaal. |
| 3 | de schotel | el platillo de la taza, la fuente de horno o el plato cocinado | Het kopje staat op een schoteltje. |

📌 Regla de bolsillo:
• ¿Comes de él? → het bord.
• ¿Se sirve de él para todos? → de schaal.
• ¿Va debajo de la taza o al horno? → de schotel.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el platillo, la fuente de horno' AND notes = 'kim - koken en keuken: de schotel');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el platillo, la fuente de horno' AND notes = 'kim - koken en keuken: de schotel' LIMIT 1), 'nl_NL', 'de schotel', 'de sxóotel', '• [can.] Het kopje staat op een schoteltje. — La taza está sobre un platillo.
• [perf.] Ik heb een ovenschotel met kip gemaakt. — He hecho un gratinado de pollo al horno.
• [vraag] Wat is de schotel van de dag? — ¿Cuál es el plato del día?
• [geb.] Zet de schotel voorzichtig in de oven. — Mete la fuente con cuidado en el horno.
• [uitdr.] Ze zeggen dat ze een vliegende schotel hebben gezien. — Dicen que han visto un platillo volante.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el platillo, la fuente de horno' AND notes = 'kim - koken en keuken: de schotel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el platillo, la fuente de horno' AND notes = 'kim - koken en keuken: de schotel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.22 de magnetron
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el microondas', 'WORD', 'kim - koken en keuken: de magnetron', 'de magnetron = el microondas. Plural magnetrons.

• la g suena como la j española — májnetron.
• de magnetronmaaltijd — el plato precocinado para el microondas.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el microondas' AND notes = 'kim - koken en keuken: de magnetron');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el microondas' AND notes = 'kim - koken en keuken: de magnetron' LIMIT 1), 'nl_NL', 'de magnetron', 'de májnetron', '• [can.] De magnetron is kapot. — El microondas está roto.
• [perf.] Ik heb de soep in de magnetron opgewarmd. — He calentado la sopa en el microondas.
• [geb.] Zet het bord twee minuten in de magnetron. — Mete el plato dos minutos en el microondas.
• [vraag] Mag metaal in de magnetron? — ¿Se puede meter metal en el microondas?
• [bijzin] Ik kook bijna nooit meer sinds ik een magnetron heb. — Casi no cocino desde que tengo microondas.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el microondas' AND notes = 'kim - koken en keuken: de magnetron' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el microondas' AND notes = 'kim - koken en keuken: de magnetron' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.23 de lucifer
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la cerilla', 'WORD', 'kim - koken en keuken: de lucifer', 'de lucifer = la cerilla. Plural lucifers.

🧠 La imagen:
• En latín lucifer es el que lleva la luz, el mismo nombre del ángel caído.

• een doosje lucifers — una caja de cerillas.
• de aansteker — el mechero.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la cerilla' AND notes = 'kim - koken en keuken: de lucifer');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la cerilla' AND notes = 'kim - koken en keuken: de lucifer' LIMIT 1), 'nl_NL', 'de lucifer', 'de lúsifer', '• [can.] Ik heb geen lucifers meer. — Ya no me quedan cerillas.
• [perf.] Hij heeft een lucifer aangestoken. — Ha encendido una cerilla.
• [vraag] Heb je een doosje lucifers? — ¿Tienes una caja de cerillas?
• [geb.] Steek de kaars aan met een lucifer. — Enciende la vela con una cerilla.
• [bijzin] Kinderen mogen niet met lucifers spelen, omdat het gevaarlijk is. — Los niños no deben jugar con cerillas porque es peligroso.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la cerilla' AND notes = 'kim - koken en keuken: de lucifer' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la cerilla' AND notes = 'kim - koken en keuken: de lucifer' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.24 het kookboek
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el libro de cocina', 'WORD', 'kim - koken en keuken: het kookboek', 'het kookboek = el libro de cocina. Plural kookboeken.

• el compuesto toma el género de la última pieza — het boek → het kookboek.
• por eso el relativo es dat — het kookboek dat ik zoek, no «die».

🔑 El truco que casi nunca falla: en un compuesto, mira solo la última palabra; ella decide el de/het.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el libro de cocina' AND notes = 'kim - koken en keuken: het kookboek');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el libro de cocina' AND notes = 'kim - koken en keuken: het kookboek' LIMIT 1), 'nl_NL', 'het kookboek', 'et kóokbuk', '• [can.] Dit kookboek heeft heel makkelijke recepten. — Este libro de cocina tiene recetas muy fáciles.
• [perf.] Ik heb een Spaans kookboek gekregen. — Me han regalado un libro de cocina español.
• [vraag] Welk kookboek gebruik jij? — ¿Qué libro de cocina usas?
• [inv.] Zonder kookboek kook ik nooit. — Sin libro de cocina nunca cocino.
• [bijzin] Ik zoek een kookboek dat alleen vegetarische recepten heeft. — Busco un libro de cocina que solo tenga recetas vegetarianas.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el libro de cocina' AND notes = 'kim - koken en keuken: het kookboek' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el libro de cocina' AND notes = 'kim - koken en keuken: het kookboek' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.25 de afwas
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'los platos por fregar', 'WORD', 'kim - koken en keuken: de afwas', 'de afwas = los platos por fregar, la vajilla sucia. Sin plural.

🧩 Expresión fija — de afwas doen:
• literal — hacer la friega
• significa — fregar los platos
• piezas fijas — de afwas siempre con de, y doen es el verbo que se conjuga

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik doe de afwas. | Friego los platos. |
| 2 | perfecto, con hebben | Ik heb de afwas gedaan. | He fregado los platos. |
| 3 | subordinada | Hij belt terwijl ik de afwas doe. | Llama mientras friego. |

• el verbo es afwassen, separable — Ik was af, ik heb afgewassen.

🔑 El truco que casi nunca falla: fregar es de afwas doen, igual que hacer la compra es boodschappen doen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'los platos por fregar' AND notes = 'kim - koken en keuken: de afwas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'los platos por fregar' AND notes = 'kim - koken en keuken: de afwas' LIMIT 1), 'nl_NL', 'de afwas', 'de áfwas', '• [can.] Na het eten doe ik de afwas. — Después de comer friego los platos.
• [perf.] Heb jij de afwas al gedaan? — ¿Ya has fregado los platos?
• [inv.] Vanavond doet mijn zoon de afwas. — Esta noche friega mi hijo.
• [bijzin] Ik kijk tv terwijl hij de afwas doet. — Veo la tele mientras él friega.
• [vraag] Wie doet vandaag de afwas? — ¿Quién friega hoy?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los platos por fregar' AND notes = 'kim - koken en keuken: de afwas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los platos por fregar' AND notes = 'kim - koken en keuken: de afwas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.26 de mok
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el tazón, la taza grande', 'WORD', 'kim - koken en keuken: de mok', 'de mok = el tazón, la taza grande sin platillo. Plural mokken, con doble k.

☕ Kopje o mok:

| # | palabra | qué es | ejemplo |
|---|---|---|---|
| 1 | het kopje | la taza pequeña con platillo, la de las visitas | Een kopje koffie bij oma. |
| 2 | de mok | el tazón grande sin platillo, el de casa o la oficina | Een mok thee achter de computer. |

🔑 El truco que casi nunca falla: ¿lleva platillo? → kopje · ¿tazón grande sin platillo? → mok.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el tazón, la taza grande' AND notes = 'kim - koken en keuken: de mok');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el tazón, la taza grande' AND notes = 'kim - koken en keuken: de mok' LIMIT 1), 'nl_NL', 'de mok', 'de mok', '• [can.] Ik drink thee uit een grote mok. — Bebo té en un tazón grande.
• [perf.] Ik heb een mok met mijn naam gekregen. — Me han regalado una taza con mi nombre.
• [vraag] Is dit jouw mok? — ¿Es esta tu taza?
• [geb.] Zet je mok niet naast de laptop. — No pongas la taza al lado del portátil.
• [bijzin] Ik weet niet wie mijn mok heeft gepakt. — No sé quién ha cogido mi taza.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tazón, la taza grande' AND notes = 'kim - koken en keuken: de mok' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tazón, la taza grande' AND notes = 'kim - koken en keuken: de mok' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.27 het bestek
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'los cubiertos', 'WORD', 'kim - koken en keuken: het bestek', 'het bestek = los cubiertos, todos juntos. Es un colectivo en singular.

⚠️ En español es plural, en neerlandés singular — het bestek ligt in de la, nunca «liggen».

• para uno solo se dice la pieza — het mes, de vork, de lepel.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'los cubiertos' AND notes = 'kim - koken en keuken: het bestek');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'los cubiertos' AND notes = 'kim - koken en keuken: het bestek' LIMIT 1), 'nl_NL', 'het bestek', 'et bestek', '• [can.] Het bestek ligt in de la. — Los cubiertos están en el cajón.
• [geb.] Leg het bestek naast de borden. — Pon los cubiertos al lado de los platos.
• [perf.] Ik heb het bestek al afgewassen. — Ya he fregado los cubiertos.
• [vraag] Waar is het bestek? — ¿Dónde están los cubiertos?
• [bijzin] Ik weet niet of er genoeg bestek is. — No sé si hay suficientes cubiertos.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los cubiertos' AND notes = 'kim - koken en keuken: het bestek' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los cubiertos' AND notes = 'kim - koken en keuken: het bestek' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.28 de vaatwasser, de afwasmachine
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el lavavajillas', 'WORD', 'kim - koken en keuken: de vaatwasser, de afwasmachine', 'de vaatwasser = de afwasmachine = el lavavajillas. Plurales vaatwassers y afwasmachines.

• de vaatwasser es la más habitual; de afwasmachine se entiende igual.
• inruimen / uitruimen — cargar / vaciar el lavavajillas.

🧠 La imagen:
• de vaat es la vajilla, en la palabra antigua — la vaatwasser es la que lava la vajilla.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el lavavajillas' AND notes = 'kim - koken en keuken: de vaatwasser, de afwasmachine');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el lavavajillas' AND notes = 'kim - koken en keuken: de vaatwasser, de afwasmachine' LIMIT 1), 'nl_NL', 'de vaatwasser, de afwasmachine', 'de fáatwaser, de áfwasmasjiene', '• [can.] De vaatwasser staat aan. — El lavavajillas está en marcha.
• [geb.] Ruim de vaatwasser even uit. — Vacía el lavavajillas.
• [perf.] Heb je de vaatwasser al ingeruimd? — ¿Ya has cargado el lavavajillas?
• [bijzin] Sinds we een afwasmachine hebben, doe ik nooit meer de afwas. — Desde que tenemos lavavajillas ya no friego nunca.
• [vraag] Mag deze pan in de vaatwasser? — ¿Se puede meter esta olla en el lavavajillas?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el lavavajillas' AND notes = 'kim - koken en keuken: de vaatwasser, de afwasmachine' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el lavavajillas' AND notes = 'kim - koken en keuken: de vaatwasser, de afwasmachine' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.29 het aanrecht
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la encimera', 'WORD', 'kim - koken en keuken: het aanrecht', 'het aanrecht = la encimera de la cocina, con el fregadero. Plural aanrechten.

• op het aanrecht — encima de la encimera.
• de gootsteen — la pila del fregadero.

⚠️ Aquí no hay regla para el het, se aprende con el artículo pegado'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la encimera' AND notes = 'kim - koken en keuken: het aanrecht');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la encimera' AND notes = 'kim - koken en keuken: het aanrecht' LIMIT 1), 'nl_NL', 'het aanrecht', 'et áanrejt', '• [can.] De boodschappen staan op het aanrecht. — La compra está en la encimera.
• [geb.] Maak het aanrecht even schoon. — Limpia la encimera.
• [perf.] Ik heb de messen op het aanrecht gelegd. — He dejado los cuchillos en la encimera.
• [vraag] Waarom staat de melk nog op het aanrecht? — ¿Por qué sigue la leche en la encimera?
• [bijzin] Ik begin pas met koken als het aanrecht leeg is. — No empiezo a cocinar hasta que la encimera está vacía.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la encimera' AND notes = 'kim - koken en keuken: het aanrecht' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la encimera' AND notes = 'kim - koken en keuken: het aanrecht' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2.30 de keukentafel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la mesa de la cocina', 'WORD', 'kim - koken en keuken: de keukentafel', 'de keukentafel = la mesa de la cocina. Plural keukentafels.

• el compuesto toma el género de la última pieza — de tafel → de keukentafel.

📌 Regla de bolsillo:
• ¿Sentado a la mesa, comiendo o trabajando? → aan tafel.
• ¿Algo encima de la mesa? → op tafel.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la mesa de la cocina' AND notes = 'kim - koken en keuken: de keukentafel');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la mesa de la cocina' AND notes = 'kim - koken en keuken: de keukentafel' LIMIT 1), 'nl_NL', 'de keukentafel', 'de køkentáafel', '• [can.] We eten aan de keukentafel. — Comemos en la mesa de la cocina.
• [perf.] Ik heb mijn sleutels op de keukentafel laten liggen. — Me he dejado las llaves en la mesa de la cocina.
• [inv.] Aan de keukentafel maken de kinderen hun huiswerk. — En la mesa de la cocina hacen los niños los deberes.
• [vraag] Zitten we aan de keukentafel of in de kamer? — ¿Nos sentamos en la mesa de la cocina o en el salón?
• [bijzin] Ik werk thuis, omdat de keukentafel groot genoeg is. — Trabajo en casa porque la mesa de la cocina es bastante grande.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la mesa de la cocina' AND notes = 'kim - koken en keuken: de keukentafel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la mesa de la cocina' AND notes = 'kim - koken en keuken: de keukentafel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 3. Enlaces a tarjetas de otros grupos kim (no se crean aqui)
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT l.word_es_id, (SELECT id FROM word_groups WHERE title = 'kim - koken en keuken')
FROM words_lang l JOIN words_es e ON e.id = l.word_es_id
WHERE l.lang_code = 'nl_NL' AND e.word_type = 'WORD' AND l.text IN ('het zout', 'de peper');
