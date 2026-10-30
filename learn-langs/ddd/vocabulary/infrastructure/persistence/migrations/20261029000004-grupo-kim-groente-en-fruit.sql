-- Learn Languages App - Migration
-- Migration: 20261029000004-grupo-kim-groente-en-fruit
-- Description: Eduardo: "vamos a crear grupos kim con todas estas palabras ... ojo revisa que no
--   existan". Lista Groenten en fruit de Kim (44 entradas, quizlet.com/_982rw7), filtrada por
--   frecuencia (wordfreq) con su OK del 2026-10-29: entran A+B+C mas champignon, aubergine y
--   spruitjes; fuera witlof, andijvie, pepertje y groentekraam. Ninguna existia en el mazo.
--
--   39 tarjetas WORD nuevas, cada una con articulo en la respuesta (§3.1), 5 ejemplos en notes
--   (§3.7) y ayuda corta con plural. Bloques compartidos: '🪜 La escalera de pesos del mercado'
--   (gram, ons, pond, kilo) en las 4 de peso y '🥕 De groente o de groenten' (con het fruit vs de
--   vrucht) en fruit y groente. de peper se crea aqui con texto exacto 'de peper' y la enlaza
--   koken; de groenteboer, de groenteman la crea la 01 y aqui solo se enlaza (si existe).

PRAGMA foreign_keys = ON;

INSERT INTO word_groups (title, description, source)
SELECT 'kim - groente en fruit', 'Frutas, verduras y pesos del mercado, de la lista Groenten en fruit de Kim. Cada sustantivo se estudia con su articulo (casi todos son de-woorden; het fruit, het ons y het pond son la excepcion) y con su plural, que es como se piden en la tienda. Incluye la escalera de pesos del mercado holandes: gram, ons, pond y kilo.', 'Groenten en fruit - Flashcards in Quizlet - Learn Dutch with Kim - https://quizlet.com/_982rw7'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'kim - groente en fruit');

-- het ons
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la onza, cien gramos', 'WORD', 'kim - groente en fruit: het ons', 'het ons = cien gramos en la tienda, y es het-woord. Plural tras numero, ons: drie ons.

⚠️ No es la onza inglesa de 28 gramos: en Holanda un ons son 100 gramos justos

💡 Ojo con el homografo ons, nuestro o nos: Hij ziet ons. Por el articulo se distinguen, het ons es el peso.

🪜 La escalera de pesos del mercado:

| peso | neerlandes | se pide asi |
|---|---|---|
| 1 g | de gram | 250 gram boter |
| 100 g | het ons | een ons ham |
| 500 g | het pond | een pond gehakt |
| 1000 g | de kilo | een kilo appels |

• tras un numero el peso no lleva plural — twee kilo, drie ons, vijf pond, nunca «twee kilo''s».
• y la mercancia va detras sin van — een ons kaas, no «een ons van kaas».'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la onza, cien gramos' AND notes = 'kim - groente en fruit: het ons');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la onza, cien gramos' AND notes = 'kim - groente en fruit: het ons' LIMIT 1), 'nl_NL', 'het ons', 'het ons', '• [can.] Ik wil graag een ons kaas. — Quiero cien gramos de queso, por favor.
• [perf.] Ik heb twee ons ham gekocht. — He comprado doscientos gramos de jamón.
• [vraag] Mag het een ons meer zijn? — ¿Le pongo cien gramos más?
• [inv.] Voor de salade heb ik een ons noten nodig. — Para la ensalada necesito cien gramos de nueces.
• [bijzin] Ik weet niet of een ons genoeg is. — No sé si cien gramos son suficientes.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la onza, cien gramos' AND notes = 'kim - groente en fruit: het ons' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la onza, cien gramos' AND notes = 'kim - groente en fruit: het ons' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de kilo
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el kilo', 'WORD', 'kim - groente en fruit: de kilo', 'de kilo = el kilo. Plural de kilo''s, pero tras un numero se queda en kilo: twee kilo aardappels.

💡 Es la forma corta de het kilogram, y al acortarse cambia a de

🪜 La escalera de pesos del mercado:

| peso | neerlandes | se pide asi |
|---|---|---|
| 1 g | de gram | 250 gram boter |
| 100 g | het ons | een ons ham |
| 500 g | het pond | een pond gehakt |
| 1000 g | de kilo | een kilo appels |

• tras un numero el peso no lleva plural — twee kilo, drie ons, vijf pond, nunca «twee kilo''s».
• y la mercancia va detras sin van — een ons kaas, no «een ons van kaas».'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el kilo' AND notes = 'kim - groente en fruit: de kilo');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el kilo' AND notes = 'kim - groente en fruit: de kilo' LIMIT 1), 'nl_NL', 'de kilo', 'de kíilo', '• [can.] Een kilo appels kost drie euro. — Un kilo de manzanas cuesta tres euros.
• [perf.] Ik ben twee kilo afgevallen. — He adelgazado dos kilos.
• [vraag] Hoeveel kost een kilo tomaten? — ¿Cuánto cuesta un kilo de tomates?
• [inv.] Op de markt koop ik altijd een kilo uien. — En el mercado siempre compro un kilo de cebollas.
• [uitdr.] Hij weegt een paar kilo te veel. — Le sobran unos kilos.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el kilo' AND notes = 'kim - groente en fruit: de kilo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el kilo' AND notes = 'kim - groente en fruit: de kilo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- het fruit
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la fruta', 'WORD', 'kim - groente en fruit: het fruit', 'het fruit = la fruta, incontable y het-woord: nunca «een fruit» ni «fruiten».

🥕 De groente o de groenten:
• de groente — la verdura como categoria o una sola pieza: Welke groente eet je graag?
• de groenten — el plural, las verduras que compras o pones en el plato: Ik koop groenten op de markt.
• het fruit — incontable, nunca «fruiten»: Ik eet elke dag fruit.
• de vrucht — una fruta concreta o el fruto, y si es contable: een vrucht, twee vruchten.
📌 Regla de bolsillo: ¿hablas de fruta en general? → het fruit; ¿cuentas piezas o tipos? → de vrucht, de vruchten.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la fruta' AND notes = 'kim - groente en fruit: het fruit');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la fruta' AND notes = 'kim - groente en fruit: het fruit' LIMIT 1), 'nl_NL', 'het fruit', 'het fréut', '• [can.] Ik eet elke dag fruit. — Como fruta todos los días.
• [perf.] Heb je fruit gekocht? — ¿Has comprado fruta?
• [inv.] Na het eten eten we wat fruit. — Después de comer tomamos algo de fruta.
• [bijzin] De dokter zegt dat ik meer fruit moet eten. — El médico dice que tengo que comer más fruta.
• [geb.] Neem een stuk fruit mee naar school. — Llévate una pieza de fruta al colegio.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la fruta' AND notes = 'kim - groente en fruit: het fruit' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la fruta' AND notes = 'kim - groente en fruit: het fruit' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de sla
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la lechuga', 'WORD', 'kim - groente en fruit: de sla', 'de sla = la lechuga y tambien la ensalada: el mismo sustantivo para la planta y el plato.

• een krop sla — una lechuga entera, una cabeza
• een salade — el plato elaborado con varios ingredientes, mas formal
🔑 El truco que casi nunca falla: si va en la lista de la compra es de sla, si va en la carta del restaurante suele ser de salade.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la lechuga' AND notes = 'kim - groente en fruit: de sla');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la lechuga' AND notes = 'kim - groente en fruit: de sla' LIMIT 1), 'nl_NL', 'de sla', 'de sla', '• [can.] Ik koop een krop sla. — Compro una lechuga.
• [perf.] Ik heb de sla al gewassen. — Ya he lavado la lechuga.
• [vraag] Wil je sla bij de vis? — ¿Quieres ensalada con el pescado?
• [inv.] Bij het avondeten eten we altijd sla. — En la cena siempre comemos ensalada.
• [geb.] Snij de sla in kleine stukjes. — Corta la lechuga en trozos pequeños.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la lechuga' AND notes = 'kim - groente en fruit: de sla' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la lechuga' AND notes = 'kim - groente en fruit: de sla' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- het pond
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'medio kilo, la libra', 'WORD', 'kim - groente en fruit: het pond', 'het pond = medio kilo, 500 gramos, y es het-woord. Tras numero no cambia: twee pond.

💡 Tambien es la libra esterlina, het Britse pond, pero en el mercado siempre son 500 gramos

🪜 La escalera de pesos del mercado:

| peso | neerlandes | se pide asi |
|---|---|---|
| 1 g | de gram | 250 gram boter |
| 100 g | het ons | een ons ham |
| 500 g | het pond | een pond gehakt |
| 1000 g | de kilo | een kilo appels |

• tras un numero el peso no lleva plural — twee kilo, drie ons, vijf pond, nunca «twee kilo''s».
• y la mercancia va detras sin van — een ons kaas, no «een ons van kaas».'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'medio kilo, la libra' AND notes = 'kim - groente en fruit: het pond');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'medio kilo, la libra' AND notes = 'kim - groente en fruit: het pond' LIMIT 1), 'nl_NL', 'het pond', 'het pont', '• [can.] Een pond gehakt, alstublieft. — Medio kilo de carne picada, por favor.
• [perf.] Ik heb een pond aardbeien gekocht. — He comprado medio kilo de fresas.
• [vraag] Is een pond genoeg voor vier personen? — ¿Es medio kilo suficiente para cuatro personas?
• [inv.] Voor de soep gebruik ik een pond wortels. — Para la sopa uso medio kilo de zanahorias.
• [bijzin] Ze vraagt of ik een pond kaas wil. — Me pregunta si quiero medio kilo de queso.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'medio kilo, la libra' AND notes = 'kim - groente en fruit: het pond' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'medio kilo, la libra' AND notes = 'kim - groente en fruit: het pond' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de gram
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el gramo', 'WORD', 'kim - groente en fruit: de gram', 'de gram = el gramo. Tras numero se queda en gram: 250 gram boter.

🪜 La escalera de pesos del mercado:

| peso | neerlandes | se pide asi |
|---|---|---|
| 1 g | de gram | 250 gram boter |
| 100 g | het ons | een ons ham |
| 500 g | het pond | een pond gehakt |
| 1000 g | de kilo | een kilo appels |

• tras un numero el peso no lleva plural — twee kilo, drie ons, vijf pond, nunca «twee kilo''s».
• y la mercancia va detras sin van — een ons kaas, no «een ons van kaas».'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el gramo' AND notes = 'kim - groente en fruit: de gram');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el gramo' AND notes = 'kim - groente en fruit: de gram' LIMIT 1), 'nl_NL', 'de gram', 'de jram', '• [can.] Het recept vraagt 200 gram bloem. — La receta pide doscientos gramos de harina.
• [perf.] Ik heb 300 gram rijst gekookt. — He cocido trescientos gramos de arroz.
• [vraag] Hoeveel gram suiker moet erin? — ¿Cuántos gramos de azúcar lleva?
• [inv.] Per persoon reken je 100 gram pasta. — Por persona se calculan cien gramos de pasta.
• [geb.] Weeg eerst 250 gram boter af. — Pesa primero doscientos cincuenta gramos de mantequilla.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el gramo' AND notes = 'kim - groente en fruit: de gram' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el gramo' AND notes = 'kim - groente en fruit: de gram' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de appel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la manzana', 'WORD', 'kim - groente en fruit: de appel', 'de appel = la manzana. Plural de appels.

🧠 La imagen: de aqui sale de sinaasappel, la naranja, literalmente manzana de China
• appeltaart — la tarta de manzana, el postre holandes por excelencia'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la manzana' AND notes = 'kim - groente en fruit: de appel');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la manzana' AND notes = 'kim - groente en fruit: de appel' LIMIT 1), 'nl_NL', 'de appel', 'de ápel', '• [can.] Ik eet elke ochtend een appel. — Cada mañana me como una manzana.
• [perf.] Oma heeft een appeltaart gebakken. — La abuela ha hecho una tarta de manzana.
• [vraag] Wil je een appel of een peer? — ¿Quieres una manzana o una pera?
• [inv.] In de herfst plukken we appels. — En otoño cogemos manzanas.
• [uitdr.] De appel valt niet ver van de boom. — De tal palo, tal astilla.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la manzana' AND notes = 'kim - groente en fruit: de appel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la manzana' AND notes = 'kim - groente en fruit: de appel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de ui
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la cebolla', 'WORD', 'kim - groente en fruit: de ui', 'de ui = la cebolla. Plural de uien.

💡 El sonido ui no existe en español: labios redondeados como para decir u y la boca en posicion de e
• een rode ui — una cebolla morada'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la cebolla' AND notes = 'kim - groente en fruit: de ui');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la cebolla' AND notes = 'kim - groente en fruit: de ui' LIMIT 1), 'nl_NL', 'de ui', 'de éu', '• [can.] Ik snij een ui voor de soep. — Corto una cebolla para la sopa.
• [perf.] Ik heb gehuild van de uien. — He llorado por las cebollas.
• [vraag] Doe je ui in de salade? — ¿Le pones cebolla a la ensalada?
• [inv.] Eerst bak je de ui in wat boter. — Primero fríes la cebolla en un poco de mantequilla.
• [geb.] Snij de uien heel fijn. — Corta las cebollas muy finas.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la cebolla' AND notes = 'kim - groente en fruit: de ui' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la cebolla' AND notes = 'kim - groente en fruit: de ui' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de groente
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la verdura', 'WORD', 'kim - groente en fruit: de groente', 'de groente = la verdura. Plural de groenten, que tambien se escribe groentes.

🥕 De groente o de groenten:
• de groente — la verdura como categoria o una sola pieza: Welke groente eet je graag?
• de groenten — el plural, las verduras que compras o pones en el plato: Ik koop groenten op de markt.
• het fruit — incontable, nunca «fruiten»: Ik eet elke dag fruit.
• de vrucht — una fruta concreta o el fruto, y si es contable: een vrucht, twee vruchten.
📌 Regla de bolsillo: ¿hablas de fruta en general? → het fruit; ¿cuentas piezas o tipos? → de vrucht, de vruchten.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la verdura' AND notes = 'kim - groente en fruit: de groente');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la verdura' AND notes = 'kim - groente en fruit: de groente' LIMIT 1), 'nl_NL', 'de groente', 'de jrúunte', '• [can.] Groenten zijn gezond. — Las verduras son sanas.
• [perf.] Heb je de groenten al gesneden? — ¿Ya has cortado las verduras?
• [vraag] Welke groente eet je het liefst? — ¿Qué verdura te gusta más?
• [inv.] Op zaterdag koop ik groenten op de markt. — Los sábados compro verdura en el mercado.
• [bijzin] Mijn zoon zegt dat hij geen groente lust. — Mi hijo dice que no le gusta la verdura.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la verdura' AND notes = 'kim - groente en fruit: de groente' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la verdura' AND notes = 'kim - groente en fruit: de groente' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de noot
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el fruto seco, la nuez', 'WORD', 'kim - groente en fruit: de noot', 'de noot = el fruto seco o la nuez. Plural de noten.

• de walnoot — la nuez propiamente dicha
• de pinda — el cacahuete, que no se llama noot
💡 Tambien es la nota musical: de muzieknoot'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el fruto seco, la nuez' AND notes = 'kim - groente en fruit: de noot');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el fruto seco, la nuez' AND notes = 'kim - groente en fruit: de noot' LIMIT 1), 'nl_NL', 'de noot', 'de noot', '• [can.] Ik eet een handje noten als snack. — Como un puñado de frutos secos de merienda.
• [perf.] Ze heeft noten in de taart gedaan. — Ha puesto nueces en la tarta.
• [vraag] Ben je allergisch voor noten? — ¿Eres alérgico a los frutos secos?
• [inv.] In de salade doe ik altijd wat noten. — En la ensalada siempre pongo unos frutos secos.
• [uitdr.] Dat is een harde noot om te kraken. — Es un hueso duro de roer.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el fruto seco, la nuez' AND notes = 'kim - groente en fruit: de noot' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el fruto seco, la nuez' AND notes = 'kim - groente en fruit: de noot' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de kruiden
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las hierbas, las especias', 'WORD', 'kim - groente en fruit: de kruiden', 'de kruiden = las hierbas y especias, el plural de het kruid. Plural siempre de.

📌 Atajo de genero: los plurales van siempre con de, aunque el singular sea het kruid'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'las hierbas, las especias' AND notes = 'kim - groente en fruit: de kruiden');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'las hierbas, las especias' AND notes = 'kim - groente en fruit: de kruiden' LIMIT 1), 'nl_NL', 'de kruiden', 'de kréuden', '• [can.] Deze soep heeft te weinig kruiden. — Esta sopa tiene pocas especias.
• [perf.] Ik heb verse kruiden uit de tuin gehaald. — He cogido hierbas frescas del jardín.
• [vraag] Welke kruiden gebruik je voor de saus? — ¿Qué especias usas para la salsa?
• [inv.] Aan het eind voeg je de kruiden toe. — Al final añades las hierbas.
• [geb.] Doe er wat kruiden bij. — Échale unas especias.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las hierbas, las especias' AND notes = 'kim - groente en fruit: de kruiden' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las hierbas, las especias' AND notes = 'kim - groente en fruit: de kruiden' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de peer
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la pera', 'WORD', 'kim - groente en fruit: de peer', 'de peer = la pera. Plural de peren.

💡 Tambien es la bombilla, por la forma: de gloeipeer, aunque lo normal es de lamp
• met de gebakken peren zitten — cargar con el muerto, quedarse con el problema'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la pera' AND notes = 'kim - groente en fruit: de peer');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la pera' AND notes = 'kim - groente en fruit: de peer' LIMIT 1), 'nl_NL', 'de peer', 'de peer', '• [can.] Deze peer is lekker zoet. — Esta pera está muy dulce.
• [perf.] Ik heb twee peren gegeten. — Me he comido dos peras.
• [vraag] Zijn de peren al rijp? — ¿Ya están maduras las peras?
• [inv.] In de herfst zijn peren goedkoop. — En otoño las peras son baratas.
• [uitdr.] Nu zitten wij met de gebakken peren. — Ahora nos toca a nosotros cargar con el muerto.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la pera' AND notes = 'kim - groente en fruit: de peer' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la pera' AND notes = 'kim - groente en fruit: de peer' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de wortel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la zanahoria', 'WORD', 'kim - groente en fruit: de wortel', 'de wortel = la zanahoria y tambien la raiz. Plural de wortels.

🧠 La imagen: la zanahoria es una raiz, por eso es la misma palabra, y de wortel van een boom es la raiz de un arbol
• de worteltjes — las zanahorias pequeñas, en diminutivo con het: het worteltje'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la zanahoria' AND notes = 'kim - groente en fruit: de wortel');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la zanahoria' AND notes = 'kim - groente en fruit: de wortel' LIMIT 1), 'nl_NL', 'de wortel', 'de wórtel', '• [can.] Konijnen eten graag wortels. — A los conejos les gustan las zanahorias.
• [perf.] Ik heb de wortels geschild. — He pelado las zanahorias.
• [vraag] Doe je wortel in de stamppot? — ¿Le pones zanahoria al stamppot?
• [inv.] Voor de soep snij ik eerst de wortels. — Para la sopa primero corto las zanahorias.
• [uitdr.] Het probleem moet je bij de wortel aanpakken. — El problema hay que atacarlo de raíz.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la zanahoria' AND notes = 'kim - groente en fruit: de wortel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la zanahoria' AND notes = 'kim - groente en fruit: de wortel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de banaan
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el plátano', 'WORD', 'kim - groente en fruit: de banaan', 'de banaan = el platano. Plural de bananen, con una sola a porque la silaba queda abierta.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el plátano' AND notes = 'kim - groente en fruit: de banaan');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el plátano' AND notes = 'kim - groente en fruit: de banaan' LIMIT 1), 'nl_NL', 'de banaan', 'de banáan', '• [can.] Ik neem een banaan mee naar het werk. — Me llevo un plátano al trabajo.
• [perf.] Wie heeft de laatste banaan opgegeten? — ¿Quién se ha comido el último plátano?
• [vraag] Zijn de bananen nog groen? — ¿Todavía están verdes los plátanos?
• [inv.] Bij het ontbijt eet ik vaak een banaan. — En el desayuno me como a menudo un plátano.
• [bijzin] Ik koop bananen omdat ze goedkoop zijn. — Compro plátanos porque son baratos.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el plátano' AND notes = 'kim - groente en fruit: de banaan' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el plátano' AND notes = 'kim - groente en fruit: de banaan' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de tomaat
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el tomate', 'WORD', 'kim - groente en fruit: de tomaat', 'de tomaat = el tomate. Plural de tomaten, con una sola a al abrirse la silaba.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el tomate' AND notes = 'kim - groente en fruit: de tomaat');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el tomate' AND notes = 'kim - groente en fruit: de tomaat' LIMIT 1), 'nl_NL', 'de tomaat', 'de tomáat', '• [can.] Deze tomaten komen uit Spanje. — Estos tomates vienen de España.
• [perf.] Ik heb tomaten in de tuin geplant. — He plantado tomates en el jardín.
• [vraag] Hoeveel kosten de tomaten? — ¿Cuánto cuestan los tomates?
• [inv.] Voor de saus heb ik vier tomaten nodig. — Para la salsa necesito cuatro tomates.
• [geb.] Snij de tomaat in plakjes. — Corta el tomate en rodajas.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tomate' AND notes = 'kim - groente en fruit: de tomaat' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tomate' AND notes = 'kim - groente en fruit: de tomaat' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de citroen
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el limón', 'WORD', 'kim - groente en fruit: de citroen', 'de citroen = el limon. Plural de citroenen.

⚠️ Falso amigo para el hispanohablante: no es el citron frances ni el pomelo, es el limon de siempre
• de limoen — la lima, verde y mas pequeña'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el limón' AND notes = 'kim - groente en fruit: de citroen');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el limón' AND notes = 'kim - groente en fruit: de citroen' LIMIT 1), 'nl_NL', 'de citroen', 'de sitrún', '• [can.] Ik doe een schijfje citroen in de thee. — Pongo una rodaja de limón en el té.
• [perf.] Heb je citroen over de vis gedaan? — ¿Le has echado limón al pescado?
• [vraag] Wil je citroen bij je water? — ¿Quieres limón en el agua?
• [inv.] Voor deze taart gebruik je twee citroenen. — Para esta tarta se usan dos limones.
• [uitdr.] Hij is zo zuur als een citroen. — Es más agrio que un limón.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el limón' AND notes = 'kim - groente en fruit: de citroen' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el limón' AND notes = 'kim - groente en fruit: de citroen' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de aardappel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la patata', 'WORD', 'kim - groente en fruit: de aardappel', 'de aardappel = la patata. Plural de aardappels o aardappelen.

🧠 La imagen: literalmente manzana de tierra, aarde + appel, igual que la pomme de terre francesa'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la patata' AND notes = 'kim - groente en fruit: de aardappel');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la patata' AND notes = 'kim - groente en fruit: de aardappel' LIMIT 1), 'nl_NL', 'de aardappel', 'de áardapel', '• [can.] Nederlanders eten veel aardappels. — Los holandeses comen muchas patatas.
• [perf.] Ik heb de aardappels al geschild. — Ya he pelado las patatas.
• [vraag] Hoe lang moeten de aardappels koken? — ¿Cuánto tienen que cocer las patatas?
• [inv.] Bij de vis eten we gekookte aardappels. — Con el pescado comemos patatas cocidas.
• [bijzin] Ik weet niet of we nog aardappels hebben. — No sé si nos quedan patatas.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la patata' AND notes = 'kim - groente en fruit: de aardappel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la patata' AND notes = 'kim - groente en fruit: de aardappel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de peper
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la pimienta, la guindilla', 'WORD', 'kim - groente en fruit: de peper', 'de peper = la pimienta y tambien la guindilla, el pimiento picante. Plural de pepers.

• zout en peper — sal y pimienta, en este orden
• de rode peper — la guindilla roja, en diminutivo het pepertje
⚠️ El pimiento morron no es peper sino de paprika'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la pimienta, la guindilla' AND notes = 'kim - groente en fruit: de peper');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la pimienta, la guindilla' AND notes = 'kim - groente en fruit: de peper' LIMIT 1), 'nl_NL', 'de peper', 'de péeper', '• [can.] Doe wat zout en peper op het vlees. — Echa un poco de sal y pimienta a la carne.
• [perf.] Ik heb te veel peper in de soep gedaan. — Le he echado demasiada pimienta a la sopa.
• [vraag] Is deze peper erg heet? — ¿Pica mucho esta guindilla?
• [inv.] In dit gerecht zit een rode peper. — Este plato lleva una guindilla roja.
• [uitdr.] Hij is zo duur als peper. — Es carísimo.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la pimienta, la guindilla' AND notes = 'kim - groente en fruit: de peper' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la pimienta, la guindilla' AND notes = 'kim - groente en fruit: de peper' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de knoflook
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el ajo', 'WORD', 'kim - groente en fruit: de knoflook', 'de knoflook = el ajo, incontable en la cocina.

• een teentje knoflook — un diente de ajo, literalmente un dedito del pie
• een bol knoflook — una cabeza de ajos'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el ajo' AND notes = 'kim - groente en fruit: de knoflook');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el ajo' AND notes = 'kim - groente en fruit: de knoflook' LIMIT 1), 'nl_NL', 'de knoflook', 'de knóflook', '• [can.] Ik doe veel knoflook in de saus. — Pongo mucho ajo en la salsa.
• [perf.] Je hebt knoflook gegeten, hè? — Has comido ajo, ¿eh?
• [vraag] Hoeveel teentjes knoflook moeten erin? — ¿Cuántos dientes de ajo lleva?
• [inv.] Eerst bak je de knoflook in olie. — Primero fríes el ajo en aceite.
• [geb.] Pers twee teentjes knoflook. — Machaca dos dientes de ajo.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el ajo' AND notes = 'kim - groente en fruit: de knoflook' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el ajo' AND notes = 'kim - groente en fruit: de knoflook' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de boon
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la judía, la alubia', 'WORD', 'kim - groente en fruit: de boon', 'de boon = la judia o alubia. Plural de bonen.

• sperziebonen — judias verdes · bruine bonen — alubias pintas · de koffieboon — el grano de cafe
• zijn eigen boontjes doppen — apañarselas solo'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la judía, la alubia' AND notes = 'kim - groente en fruit: de boon');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la judía, la alubia' AND notes = 'kim - groente en fruit: de boon' LIMIT 1), 'nl_NL', 'de boon', 'de boon', '• [can.] Ik eet graag bonen met rijst. — Me gusta comer alubias con arroz.
• [perf.] Ik heb sperziebonen gekocht. — He comprado judías verdes.
• [vraag] Hoe lang moeten de bonen weken? — ¿Cuánto tiempo tienen que estar en remojo las alubias?
• [inv.] Bij de aardappels eten we bonen. — Con las patatas comemos judías.
• [uitdr.] Hij moet zijn eigen boontjes doppen. — Se las tiene que apañar solo.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la judía, la alubia' AND notes = 'kim - groente en fruit: de boon' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la judía, la alubia' AND notes = 'kim - groente en fruit: de boon' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de pompoen
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la calabaza', 'WORD', 'kim - groente en fruit: de pompoen', 'de pompoen = la calabaza. Plural de pompoenen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la calabaza' AND notes = 'kim - groente en fruit: de pompoen');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la calabaza' AND notes = 'kim - groente en fruit: de pompoen' LIMIT 1), 'nl_NL', 'de pompoen', 'de pompún', '• [can.] Pompoensoep is lekker in de herfst. — La crema de calabaza está rica en otoño.
• [perf.] De kinderen hebben een pompoen uitgehold. — Los niños han vaciado una calabaza.
• [vraag] Hoe snij je een pompoen? — ¿Cómo se corta una calabaza?
• [inv.] In oktober zie je overal pompoenen. — En octubre se ven calabazas por todas partes.
• [bijzin] Ik weet niet of de pompoen al gaar is. — No sé si la calabaza ya está hecha.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la calabaza' AND notes = 'kim - groente en fruit: de pompoen' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la calabaza' AND notes = 'kim - groente en fruit: de pompoen' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de zoete aardappel, de bataat
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el boniato, la batata', 'WORD', 'kim - groente en fruit: de zoete aardappel, de bataat', 'de zoete aardappel = el boniato, literalmente patata dulce. Mas formal de bataat. Plural zoete aardappels, bataten.

💡 El adjetivo lleva -e delante de un de-woord: zoete, no «zoet aardappel»'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el boniato, la batata' AND notes = 'kim - groente en fruit: de zoete aardappel, de bataat');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el boniato, la batata' AND notes = 'kim - groente en fruit: de zoete aardappel, de bataat' LIMIT 1), 'nl_NL', 'de zoete aardappel, de bataat', 'de súute áardapel, de batáat', '• [can.] Zoete aardappel is gezonder dan friet. — El boniato es más sano que las patatas fritas.
• [perf.] Ik heb zoete aardappels in de oven gedaan. — He metido boniatos en el horno.
• [vraag] Heb je wel eens bataat gegeten? — ¿Has comido alguna vez batata?
• [inv.] In deze soep gebruik ik zoete aardappel. — En esta sopa uso boniato.
• [geb.] Schil de zoete aardappels eerst. — Pela primero los boniatos.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el boniato, la batata' AND notes = 'kim - groente en fruit: de zoete aardappel, de bataat' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el boniato, la batata' AND notes = 'kim - groente en fruit: de zoete aardappel, de bataat' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de avocado
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el aguacate', 'WORD', 'kim - groente en fruit: de avocado', 'de avocado = el aguacate. Plural de avocado''s, con apostrofo porque acaba en vocal larga.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el aguacate' AND notes = 'kim - groente en fruit: de avocado');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el aguacate' AND notes = 'kim - groente en fruit: de avocado' LIMIT 1), 'nl_NL', 'de avocado', 'de afokáado', '• [can.] Deze avocado is nog hard. — Este aguacate todavía está duro.
• [perf.] Ik heb een avocado op mijn brood gedaan. — Me he puesto aguacate en el pan.
• [vraag] Is de avocado al rijp? — ¿Ya está maduro el aguacate?
• [inv.] Voor guacamole heb je drie avocado''s nodig. — Para el guacamole necesitas tres aguacates.
• [bijzin] Ik koop avocado''s als ze in de aanbieding zijn. — Compro aguacates cuando están de oferta.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el aguacate' AND notes = 'kim - groente en fruit: de avocado' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el aguacate' AND notes = 'kim - groente en fruit: de avocado' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de ananas
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la piña', 'WORD', 'kim - groente en fruit: de ananas', 'de ananas = la piña. Plural de ananassen.

💡 La palabra viene del tupi, igual que el ananas frances o el italiano: en español es la excepcion'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la piña' AND notes = 'kim - groente en fruit: de ananas');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la piña' AND notes = 'kim - groente en fruit: de ananas' LIMIT 1), 'nl_NL', 'de ananas', 'de ánanas', '• [can.] Ik hou van verse ananas. — Me encanta la piña fresca.
• [perf.] Hij heeft ananas op de pizza gedaan. — Ha puesto piña en la pizza.
• [vraag] Hoe zie je of een ananas rijp is? — ¿Cómo se ve si una piña está madura?
• [inv.] Als toetje eten we ananas. — De postre comemos piña.
• [geb.] Snij de ananas in stukjes. — Corta la piña en trocitos.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la piña' AND notes = 'kim - groente en fruit: de ananas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la piña' AND notes = 'kim - groente en fruit: de ananas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de komkommer
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el pepino', 'WORD', 'kim - groente en fruit: de komkommer', 'de komkommer = el pepino. Plural de komkommers.

• de komkommertijd — la temporada sin noticias del verano, literalmente tiempo de pepinos'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el pepino' AND notes = 'kim - groente en fruit: de komkommer');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el pepino' AND notes = 'kim - groente en fruit: de komkommer' LIMIT 1), 'nl_NL', 'de komkommer', 'de komkómer', '• [can.] Ik doe komkommer in de salade. — Pongo pepino en la ensalada.
• [perf.] Ik heb een komkommer gekocht. — He comprado un pepino.
• [vraag] Schil je de komkommer? — ¿Pelas el pepino?
• [inv.] Op mijn boterham leg ik plakjes komkommer. — En el bocadillo pongo rodajas de pepino.
• [uitdr.] In de zomer is het komkommertijd. — En verano no hay noticias.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el pepino' AND notes = 'kim - groente en fruit: de komkommer' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el pepino' AND notes = 'kim - groente en fruit: de komkommer' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de broccoli
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el brócoli', 'WORD', 'kim - groente en fruit: de broccoli', 'de broccoli = el brocoli, incontable en la cocina.

• een roosje broccoli — un arbolito, literalmente una rosita'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el brócoli' AND notes = 'kim - groente en fruit: de broccoli');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el brócoli' AND notes = 'kim - groente en fruit: de broccoli' LIMIT 1), 'nl_NL', 'de broccoli', 'de brókoli', '• [can.] Broccoli is erg gezond. — El brócoli es muy sano.
• [perf.] Ik heb de broccoli te lang gekookt. — He cocido el brócoli demasiado tiempo.
• [vraag] Lust je broccoli? — ¿Te gusta el brócoli?
• [inv.] Bij de kip eten we broccoli. — Con el pollo comemos brócoli.
• [geb.] Kook de broccoli vijf minuten. — Cuece el brócoli cinco minutos.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el brócoli' AND notes = 'kim - groente en fruit: de broccoli' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el brócoli' AND notes = 'kim - groente en fruit: de broccoli' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de paprika
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el pimiento', 'WORD', 'kim - groente en fruit: de paprika', 'de paprika = el pimiento morron. Plural de paprika''s.

• een rode, gele of groene paprika — un pimiento rojo, amarillo o verde
• het paprikapoeder — el pimenton
⚠️ El picante es de peper, no de paprika'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el pimiento' AND notes = 'kim - groente en fruit: de paprika');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el pimiento' AND notes = 'kim - groente en fruit: de paprika' LIMIT 1), 'nl_NL', 'de paprika', 'de páaprika', '• [can.] Een rode paprika is zoeter dan een groene. — Un pimiento rojo es más dulce que uno verde.
• [perf.] Ik heb de paprika''s gevuld met rijst. — He rellenado los pimientos de arroz.
• [vraag] Doe je paprika in de saus? — ¿Le pones pimiento a la salsa?
• [inv.] Op de markt kosten drie paprika''s twee euro. — En el mercado tres pimientos cuestan dos euros.
• [geb.] Snij de paprika in reepjes. — Corta el pimiento en tiras.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el pimiento' AND notes = 'kim - groente en fruit: de paprika' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el pimiento' AND notes = 'kim - groente en fruit: de paprika' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de druif
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la uva', 'WORD', 'kim - groente en fruit: de druif', 'de druif = la uva. Plural de druiven: la f pasa a v al añadir -en.

📌 Regla de bolsillo: f al final, v en el plural, como de brief → brieven'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la uva' AND notes = 'kim - groente en fruit: de druif');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la uva' AND notes = 'kim - groente en fruit: de druif' LIMIT 1), 'nl_NL', 'de druif', 'de dréif', '• [can.] Deze druiven zijn zonder pit. — Estas uvas no tienen pepitas.
• [perf.] We hebben druiven gegeten bij de kaas. — Hemos comido uvas con el queso.
• [vraag] Wil je witte of blauwe druiven? — ¿Quieres uvas blancas o negras?
• [inv.] Van druiven maak je wijn. — De las uvas se hace vino.
• [uitdr.] De druiven zijn zuur. — Están verdes, dijo la zorra.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la uva' AND notes = 'kim - groente en fruit: de druif' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la uva' AND notes = 'kim - groente en fruit: de druif' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de spinazie
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las espinacas', 'WORD', 'kim - groente en fruit: de spinazie', 'de spinazie = las espinacas, singular e incontable en neerlandes.

⚠️ El español usa plural y el neerlandes singular: de spinazie is lekker, no «zijn»'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'las espinacas' AND notes = 'kim - groente en fruit: de spinazie');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'las espinacas' AND notes = 'kim - groente en fruit: de spinazie' LIMIT 1), 'nl_NL', 'de spinazie', 'de spináasi', '• [can.] Spinazie zit vol ijzer. — Las espinacas están llenas de hierro.
• [perf.] Ik heb spinazie met een ei gemaakt. — He hecho espinacas con un huevo.
• [vraag] Eet je kind spinazie? — ¿Tu hijo come espinacas?
• [inv.] Bij de vis serveer ik spinazie. — Con el pescado sirvo espinacas.
• [bijzin] Popeye wordt sterk omdat hij spinazie eet. — Popeye se hace fuerte porque come espinacas.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las espinacas' AND notes = 'kim - groente en fruit: de spinazie' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las espinacas' AND notes = 'kim - groente en fruit: de spinazie' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de aardbei
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la fresa', 'WORD', 'kim - groente en fruit: de aardbei', 'de aardbei = la fresa. Plural de aardbeien.

🧠 La imagen: literalmente baya de tierra, aarde + bes, porque crece pegada al suelo'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la fresa' AND notes = 'kim - groente en fruit: de aardbei');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la fresa' AND notes = 'kim - groente en fruit: de aardbei' LIMIT 1), 'nl_NL', 'de aardbei', 'de áardbei', '• [can.] Aardbeien zijn het lekkerst in juni. — Las fresas están más ricas en junio.
• [perf.] We hebben aardbeien geplukt. — Hemos cogido fresas.
• [vraag] Wil je slagroom op je aardbeien? — ¿Quieres nata en las fresas?
• [inv.] In de zomer eten we veel aardbeien. — En verano comemos muchas fresas.
• [bijzin] Ik koop aardbeien als ze goedkoop zijn. — Compro fresas cuando están baratas.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la fresa' AND notes = 'kim - groente en fruit: de aardbei' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la fresa' AND notes = 'kim - groente en fruit: de aardbei' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de perzik
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el melocotón', 'WORD', 'kim - groente en fruit: de perzik', 'de perzik = el melocoton. Plural de perziken.

🧠 La imagen: viene del latin persicum, fruta de Persia'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el melocotón' AND notes = 'kim - groente en fruit: de perzik');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el melocotón' AND notes = 'kim - groente en fruit: de perzik' LIMIT 1), 'nl_NL', 'de perzik', 'de pérsik', '• [can.] Deze perzik is heel zacht. — Este melocotón está muy blando.
• [perf.] Ik heb een perzik gegeten. — Me he comido un melocotón.
• [vraag] Zijn de perziken rijp? — ¿Están maduros los melocotones?
• [inv.] In de zomer koop ik perziken op de markt. — En verano compro melocotones en el mercado.
• [geb.] Was de perziken voor je ze eet. — Lava los melocotones antes de comértelos.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el melocotón' AND notes = 'kim - groente en fruit: de perzik' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el melocotón' AND notes = 'kim - groente en fruit: de perzik' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de bloemkool
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la coliflor', 'WORD', 'kim - groente en fruit: de bloemkool', 'de bloemkool = la coliflor. Plural de bloemkolen.

🧠 La imagen: literalmente col flor, de bloem + de kool, igual que en español'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la coliflor' AND notes = 'kim - groente en fruit: de bloemkool');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la coliflor' AND notes = 'kim - groente en fruit: de bloemkool' LIMIT 1), 'nl_NL', 'de bloemkool', 'de blúumkool', '• [can.] Bloemkool met kaassaus is typisch Nederlands. — La coliflor con salsa de queso es típica de Holanda.
• [perf.] Ik heb een bloemkool gekocht. — He comprado una coliflor.
• [vraag] Hoe lang moet bloemkool koken? — ¿Cuánto tiene que cocer la coliflor?
• [inv.] Bij de aardappels eten we bloemkool. — Con las patatas comemos coliflor.
• [geb.] Snij de bloemkool in roosjes. — Corta la coliflor en arbolitos.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la coliflor' AND notes = 'kim - groente en fruit: de bloemkool' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la coliflor' AND notes = 'kim - groente en fruit: de bloemkool' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de sinaasappel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la naranja', 'WORD', 'kim - groente en fruit: de sinaasappel', 'de sinaasappel = la naranja. Plural de sinaasappels.

🧠 La imagen: literalmente manzana de China, China + appel, porque llegaba desde alli
• het sinaasappelsap — el zumo de naranja, het porque sap es het-woord
• oranje — el color naranja, otra palabra'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la naranja' AND notes = 'kim - groente en fruit: de sinaasappel');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la naranja' AND notes = 'kim - groente en fruit: de sinaasappel' LIMIT 1), 'nl_NL', 'de sinaasappel', 'de síinasapel', '• [can.] Ik pers elke ochtend sinaasappels. — Exprimo naranjas todas las mañanas.
• [perf.] Ik heb twee sinaasappels gegeten. — Me he comido dos naranjas.
• [vraag] Komen deze sinaasappels uit Valencia? — ¿Estas naranjas vienen de Valencia?
• [inv.] In de winter eten we veel sinaasappels. — En invierno comemos muchas naranjas.
• [bijzin] Ik koop sinaasappels omdat ze vol vitamine C zitten. — Compro naranjas porque están llenas de vitamina C.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la naranja' AND notes = 'kim - groente en fruit: de sinaasappel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la naranja' AND notes = 'kim - groente en fruit: de sinaasappel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de kiwi
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el kiwi', 'WORD', 'kim - groente en fruit: de kiwi', 'de kiwi = el kiwi. Plural de kiwi''s, con apostrofo porque acaba en vocal.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el kiwi' AND notes = 'kim - groente en fruit: de kiwi');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el kiwi' AND notes = 'kim - groente en fruit: de kiwi' LIMIT 1), 'nl_NL', 'de kiwi', 'de kíui', '• [can.] Een kiwi heeft veel vitamine C. — Un kiwi tiene mucha vitamina C.
• [perf.] Ik heb een kiwi bij het ontbijt gegeten. — Me he comido un kiwi en el desayuno.
• [vraag] Schil je de kiwi of eet je hem met schil? — ¿Pelas el kiwi o te lo comes con piel?
• [inv.] Op de markt kosten vijf kiwi''s een euro. — En el mercado cinco kiwis cuestan un euro.
• [geb.] Snij de kiwi doormidden. — Corta el kiwi por la mitad.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el kiwi' AND notes = 'kim - groente en fruit: de kiwi' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el kiwi' AND notes = 'kim - groente en fruit: de kiwi' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de courgette
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el calabacín', 'WORD', 'kim - groente en fruit: de courgette', 'de courgette = el calabacin. Plural de courgettes. Se pronuncia a la francesa.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el calabacín' AND notes = 'kim - groente en fruit: de courgette');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el calabacín' AND notes = 'kim - groente en fruit: de courgette' LIMIT 1), 'nl_NL', 'de courgette', 'de kurshéte', '• [can.] Ik grill de courgette. — Hago el calabacín a la plancha.
• [perf.] Ik heb courgette in de pasta gedaan. — He puesto calabacín en la pasta.
• [vraag] Hoeveel courgettes heb je nodig? — ¿Cuántos calabacines necesitas?
• [inv.] In de zomer groeien de courgettes snel. — En verano los calabacines crecen deprisa.
• [geb.] Snij de courgette in plakken. — Corta el calabacín en rodajas.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el calabacín' AND notes = 'kim - groente en fruit: de courgette' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el calabacín' AND notes = 'kim - groente en fruit: de courgette' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de limoen
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la lima', 'WORD', 'kim - groente en fruit: de limoen', 'de limoen = la lima. Plural de limoenen.

⚠️ Trampa para el hispanohablante: limoen suena a limon pero es la lima; el limon es de citroen
🔑 El truco que casi nunca falla: limoen es la pequeña y verde, citroen la grande y amarilla.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la lima' AND notes = 'kim - groente en fruit: de limoen');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la lima' AND notes = 'kim - groente en fruit: de limoen' LIMIT 1), 'nl_NL', 'de limoen', 'de limún', '• [can.] Voor een mojito heb je limoen nodig. — Para un mojito necesitas lima.
• [perf.] Ik heb limoen over de vis geknepen. — He exprimido lima sobre el pescado.
• [vraag] Is dit een limoen of een citroen? — ¿Esto es una lima o un limón?
• [inv.] In de guacamole doe ik limoensap. — En el guacamole pongo zumo de lima.
• [geb.] Rasp de schil van de limoen. — Ralla la piel de la lima.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la lima' AND notes = 'kim - groente en fruit: de limoen' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la lima' AND notes = 'kim - groente en fruit: de limoen' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de champignon
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el champiñón', 'WORD', 'kim - groente en fruit: de champignon', 'de champignon = el champiñon. Plural de champignons, que es como se usa casi siempre.

• de paddenstoel — la seta en general, la del bosque'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el champiñón' AND notes = 'kim - groente en fruit: de champignon');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el champiñón' AND notes = 'kim - groente en fruit: de champignon' LIMIT 1), 'nl_NL', 'de champignon', 'de shampiñón', '• [can.] Ik doe champignons in de omelet. — Pongo champiñones en la tortilla.
• [perf.] Ik heb de champignons gebakken. — He frito los champiñones.
• [vraag] Lust je champignons? — ¿Te gustan los champiñones?
• [inv.] Op de pizza leggen we champignons. — En la pizza ponemos champiñones.
• [geb.] Was de champignons niet, maar veeg ze schoon. — No laves los champiñones, límpialos con un paño.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el champiñón' AND notes = 'kim - groente en fruit: de champignon' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el champiñón' AND notes = 'kim - groente en fruit: de champignon' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de aubergine
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la berenjena', 'WORD', 'kim - groente en fruit: de aubergine', 'de aubergine = la berenjena. Plural de aubergines. Se pronuncia a la francesa.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la berenjena' AND notes = 'kim - groente en fruit: de aubergine');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la berenjena' AND notes = 'kim - groente en fruit: de aubergine' LIMIT 1), 'nl_NL', 'de aubergine', 'de obershíine', '• [can.] Aubergine is lekker op de barbecue. — La berenjena está rica a la barbacoa.
• [perf.] Ik heb een aubergine in de oven gedaan. — He metido una berenjena en el horno.
• [vraag] Moet je de aubergine schillen? — ¿Hay que pelar la berenjena?
• [inv.] Voor moussaka heb je aubergines nodig. — Para la musaca necesitas berenjenas.
• [geb.] Snij de aubergine in plakken. — Corta la berenjena en rodajas.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la berenjena' AND notes = 'kim - groente en fruit: de aubergine' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la berenjena' AND notes = 'kim - groente en fruit: de aubergine' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de spruitjes
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las coles de Bruselas', 'WORD', 'kim - groente en fruit: de spruitjes', 'de spruitjes = las coles de Bruselas, en plural. Singular het spruitje.

📌 Atajo de genero: el diminutivo en -je es het spruitje, pero el plural vuelve a de'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'las coles de Bruselas' AND notes = 'kim - groente en fruit: de spruitjes');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'las coles de Bruselas' AND notes = 'kim - groente en fruit: de spruitjes' LIMIT 1), 'nl_NL', 'de spruitjes', 'de spréutyes', '• [can.] Veel kinderen lusten geen spruitjes. — A muchos niños no les gustan las coles de Bruselas.
• [perf.] Oma heeft spruitjes gekookt. — La abuela ha cocido coles de Bruselas.
• [vraag] Eet je spruitjes met kerst? — ¿Comes coles de Bruselas en Navidad?
• [inv.] In de winter eten we vaak spruitjes. — En invierno comemos a menudo coles de Bruselas.
• [bijzin] Ik weet dat je geen spruitjes lust. — Sé que no te gustan las coles de Bruselas.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las coles de Bruselas' AND notes = 'kim - groente en fruit: de spruitjes' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las coles de Bruselas' AND notes = 'kim - groente en fruit: de spruitjes' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- enlace (no crea): de groenteboer, de groenteman, creada por la 01
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT l.word_es_id, (SELECT id FROM word_groups WHERE title = 'kim - groente en fruit')
FROM words_lang l
WHERE l.lang_code = 'nl_NL' AND l.text = 'de groenteboer, de groenteman';
