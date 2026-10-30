-- Learn Languages App - Migration
-- Migration: 20261029000001-grupo-kim-boodschappen
-- Description: Eduardo: "vamos a crear grupos kim con todas estas palabras ... ojo revisa que no
--   existan", sobre las listas de vocabulario de Learn Dutch with Kim (Flashcards in Quizlet).
--   Seleccion aprobada por frecuencia (wordfreq, Zipf): entran los niveles A, B y C y, del D,
--   solo lo practico u holandes (de pinpas, de kassabon dentro de la tarjeta del tique).
--
--   Primer grupo de la tanda de sustantivos: 'kim - boodschappen', 32 tarjetas WORD. Ninguna existia
--   en el mazo (cruce por words_lang.text normalizado sin articulo). Se fusionan sinonimos en una
--   sola tarjeta: de bon / het bonnetje / de kassabon (el tique), de groenteboer / de groenteman
--   (el frutero) y het blik / het blikje (la lata). Quedan fuera, por compuestos o raros:
--   het boodschappenlijstje (sale de boodschappen + het lijstje) y de visboer.
--
--   het vlees, het brood, de boter y 'de groenteboer, de groenteman' los enlazaran los grupos
--   kim de eten y de groente en fruit por su words_lang.text: no cambiar esos textos.
--
--   Cada tarjeta: articulo dentro de la respuesta (§3.1), pronunciacion para lector español,
--   5 frases etiquetadas en words_lang.notes (§3.7) y una ayuda corta con la regla, el plural y
--   el truco de genero o de uso cuando lo hay (§3.5). Va al grupo y a 'generic'.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'kim - boodschappen', 'Vocabulario de la compra de la lista Boodschappen de Learn Dutch with Kim: la tienda, la caja, el dinero y lo que se mete en la bolsa. Cada sustantivo se estudia con su de o het pegado, y las tiendas se nombran por el oficio, como en Holanda (naar de bakker, naar de slager). Lleva las tres maneras de decir el tique y la tarjeta con la que se paga casi todo, de pinpas', 'Boodschappen - Flashcards in Quizlet - Learn Dutch with Kim - https://quizlet.com/_982km5'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'kim - boodschappen');

-- =============================================================================
-- 2. Las tarjetas (WORD)
-- =============================================================================
-- el dinero → het geld
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el dinero', 'WORD', 'kim - boodschappen: het geld',
'het geld = el dinero, incontable y sin plural en el uso normal.

🔑 El truco que casi nunca falla: se cuenta con veel y weinig, como un líquido — veel geld, weinig geld.

📌 Lo que se hace con el dinero:
• geld uitgeven — gastar dinero
• geld opnemen — sacar dinero del banco
• geld pinnen — sacarlo del cajero con la tarjeta
• geld terugkrijgen — que te devuelvan el cambio'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el dinero' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el dinero' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'het geld', 'het jelt',
'• [can.] Ik heb geen geld bij me. — No llevo dinero encima.
• [perf.] We hebben te veel geld uitgegeven. — Hemos gastado demasiado dinero.
• [vraag] Heb je genoeg geld voor de boodschappen? — ¿Tienes bastante dinero para la compra?
• [bijzin] Ik weet niet waar mijn geld gebleven is. — No sé dónde ha ido a parar mi dinero.
• [uitdr.] Tijd is geld. — El tiempo es oro.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el dinero' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el dinero' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el producto, el artículo → het artikel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el producto, el artículo', 'WORD', 'kim - boodschappen: het artikel',
'het artikel = el artículo, el producto · plural de artikelen.

🧠 La imagen de la palabra: es la misma que en español, y como en español vale para el producto de la tienda y para el artículo del periódico.

⚠️ El artículo gramatical no es artikel sino het lidwoord — de, het y een son lidwoorden.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el producto, el artículo' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el producto, el artículo' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'het artikel', 'het artíkel',
'• [can.] Dit artikel is in de aanbieding. — Este producto está de oferta.
• [perf.] Ik heb drie artikelen teruggebracht. — He devuelto tres artículos.
• [vraag] Waar vind ik dit artikel? — ¿Dónde encuentro este producto?
• [bijzin] De kassa zegt dat het artikel niet in het systeem staat. — La caja dice que el artículo no está en el sistema.
• [inv.] In de krant stond een lang artikel over de prijzen. — En el periódico salía un artículo largo sobre los precios.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el producto, el artículo' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el producto, el artículo' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el precio → de prijs
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el precio', 'WORD', 'kim - boodschappen: de prijs',
'de prijs = el precio · plural de prijzen, con la s que se vuelve z.

⚠️ De prijs es también el premio — een prijs winnen es ganar un premio.

💡 Para preguntar un precio lo natural es Hoeveel kost dit? más que Wat is de prijs?'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el precio' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el precio' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de prijs', 'de preis',
'• [can.] De prijs staat op het etiket. — El precio está en la etiqueta.
• [perf.] De prijzen zijn flink gestegen. — Los precios han subido bastante.
• [vraag] Wat is de prijs van deze kaas? — ¿Cuál es el precio de este queso?
• [bijzin] Ik koop het niet omdat de prijs te hoog is. — No lo compro porque el precio es demasiado alto.
• [uitdr.] Voor geen prijs! — ¡Ni por todo el oro del mundo!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el precio' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el precio' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el euro → de euro
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el euro', 'WORD', 'kim - boodschappen: de euro',
'de euro = el euro · plural de euro''s, pero detrás de un número va en singular — vijf euro, nunca «vijf euro''s».

🔑 El truco que casi nunca falla: número + euro, cent, kilo o uur va en singular — tien euro, twee uur. Euro''s solo para las monedas sueltas, Ik heb nog wat euro''s.

🔤 Escritura y sonido: se dice ööro, con la eu cerrada de de deur.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el euro' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el euro' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de euro', 'de öro',
'• [can.] Het kost vijf euro. — Cuesta cinco euros.
• [perf.] Ik heb twintig euro betaald. — He pagado veinte euros.
• [vraag] Heb je een euro voor het winkelwagentje? — ¿Tienes un euro para el carrito?
• [bijzin] Hij zegt dat het maar twee euro kost. — Dice que solo cuesta dos euros.
• [inv.] Met de euro is alles duurder geworden. — Con el euro todo se ha encarecido.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el euro' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el euro' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el mercado → de markt
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el mercado', 'WORD', 'kim - boodschappen: de markt',
'de markt = el mercado · plural de markten.

🔑 El truco que casi nunca falla: en el mercado es op de markt, nunca «in de markt» — se está sobre la plaza, no dentro de un edificio.

💡 El día de mercado va sin artículo — Morgen is er markt, mañana hay mercado.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el mercado' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el mercado' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de markt', 'de markt',
'• [can.] Op zaterdag is er markt op het plein. — Los sábados hay mercado en la plaza.
• [perf.] Ik heb op de markt vis gekocht. — He comprado pescado en el mercado.
• [inv.] Op de markt is het fruit goedkoper. — En el mercado la fruta es más barata.
• [vraag] Ga je mee naar de markt? — ¿Vienes al mercado?
• [bijzin] Ik ga altijd vroeg, omdat de markt om één uur sluit. — Siempre voy pronto, porque el mercado cierra a la una.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el mercado' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el mercado' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- la tienda → de winkel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la tienda', 'WORD', 'kim - boodschappen: de winkel',
'de winkel = la tienda · plural de winkels.

🧠 La imagen de la palabra: winkel era el rincón, la esquina — la tienda de la esquina. De ahí winkelen, ir de tiendas, y het winkelcentrum, el centro comercial.

⚠️ In de winkel es dentro de la tienda; naar de winkel, ir a la tienda.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la tienda' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la tienda' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de winkel', 'de winkel',
'• [can.] De winkel gaat om negen uur open. — La tienda abre a las nueve.
• [perf.] Die winkel is vorig jaar dichtgegaan. — Esa tienda cerró el año pasado.
• [vraag] Is deze winkel op zondag open? — ¿Esta tienda abre los domingos?
• [bijzin] Ik weet een winkel waar ze dat verkopen. — Conozco una tienda donde venden eso.
• [uitdr.] We gaan lekker winkelen in de stad. — Nos vamos de tiendas por el centro.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la tienda' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la tienda' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- la carne → het vlees
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la carne', 'WORD', 'kim - boodschappen: het vlees',
'het vlees = la carne, incontable y sin plural.

🔑 El truco que casi nunca falla: un compuesto toma el artículo de su última pieza, así que todas las carnes en -vlees son het.

📌 Las carnes en la tienda:
• het rundvlees — la ternera
• het varkensvlees — el cerdo
• het gehakt — la carne picada
• de kip — el pollo, que no lleva vlees'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la carne' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la carne' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'het vlees', 'het flees',
'• [can.] Ik eet bijna geen vlees. — Casi no como carne.
• [perf.] Ik heb het vlees bij de slager gekocht. — He comprado la carne en la carnicería.
• [vraag] Is dit vlees nog goed? — ¿Esta carne todavía está buena?
• [bijzin] Ze zegt dat het vlees te taai is. — Dice que la carne está demasiado dura.
• [uitdr.] Hij is vlees noch vis. — No es ni chicha ni limonada.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la carne' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la carne' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el cliente → de klant
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el cliente', 'WORD', 'kim - boodschappen: de klant',
'de klant = el cliente · plural de klanten.

💡 Para la mujer existe de klante, pero casi no se usa — de klant vale para los dos.

⚠️ Klant zijn bij es ser cliente de una tienda — Ik ben klant bij de Jumbo.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el cliente' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el cliente' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de klant', 'de klant',
'• [can.] Er staan veel klanten bij de kassa. — Hay muchos clientes en la caja.
• [perf.] De verkoper heeft de klant goed geholpen. — El vendedor ha atendido bien al cliente.
• [vraag] Wie is de volgende klant? — ¿Quién es el siguiente cliente?
• [inv.] Bij deze bakker ben ik al jaren klant. — Soy cliente de esta panadería desde hace años.
• [uitdr.] De klant is koning. — El cliente siempre tiene razón.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cliente' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cliente' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- la bolsa, el bolso → de tas
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la bolsa, el bolso', 'WORD', 'kim - boodschappen: de tas',
'de tas = la bolsa, el bolso · plural de tassen, con la s doblada para que la a siga corta.

💡 En la caja te preguntan Wilt u een tas? — en Holanda la bolsa se paga, así que se lleva la propia.

📌 Las bolsas con nombre propio:
• de handtas — el bolso de mano
• de rugzak — la mochila
• de plastic tas — la bolsa de plástico'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la bolsa, el bolso' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la bolsa, el bolso' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de tas', 'de tas',
'• [can.] Mijn tas is te zwaar. — Mi bolso pesa demasiado.
• [perf.] Ik heb mijn tas in de tram laten liggen. — Me he dejado el bolso en el tranvía.
• [vraag] Heeft u een tas nodig? — ¿Necesita una bolsa?
• [geb.] Zet je tas maar hier neer. — Deja el bolso aquí.
• [bijzin] Ik zoek de tas die ik gisteren gekocht heb. — Busco la bolsa que compré ayer.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la bolsa, el bolso' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la bolsa, el bolso' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el pan → het brood
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el pan', 'WORD', 'kim - boodschappen: het brood',
'het brood = el pan · plural de broden, que son los panes enteros.

🔤 Escritura y sonido: se escribe brood pero suena broot — la d final siempre se dice t.

📌 En la panadería:
• een heel brood — un pan entero
• een half brood — medio pan, que se vende así
• gesneden — en rebanadas, lo normal en Holanda
• de boterham — la rebanada, el bocadillo holandés'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el pan' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el pan' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'het brood', 'het broot',
'• [can.] Ik koop elke ochtend vers brood. — Compro pan fresco cada mañana.
• [perf.] Heb je brood gehaald? — ¿Has comprado pan?
• [vraag] Wilt u het brood gesneden? — ¿Quiere el pan cortado?
• [inv.] ''s Ochtends eten we brood met kaas. — Por la mañana comemos pan con queso.
• [uitdr.] Dat is zijn dagelijks brood. — Ese es su pan de cada día.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el pan' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el pan' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el descuento → de korting
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el descuento', 'WORD', 'kim - boodschappen: de korting',
'de korting = el descuento · plural de kortingen.

🔑 El truco que casi nunca falla: las palabras en -ing son de.

🧠 La imagen de la palabra: viene de kort, corto — el precio se acorta.

⚠️ Korting krijgen es que te lo hagan y korting geven, hacerlo tú; sobre un producto va con op — tien procent korting op alle kaas.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el descuento' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el descuento' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de korting', 'de kórting',
'• [can.] Studenten krijgen tien procent korting. — Los estudiantes tienen un diez por ciento de descuento.
• [perf.] Ik heb korting gekregen omdat de doos kapot was. — Me han hecho descuento porque la caja estaba rota.
• [vraag] Krijg ik korting als ik er twee koop? — ¿Me hacen descuento si compro dos?
• [bijzin] Ik wist niet dat er korting op zat. — No sabía que tenía descuento.
• [inv.] Met deze kaart krijg je korting. — Con esta tarjeta te hacen descuento.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el descuento' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el descuento' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- la compra → de boodschappen
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la compra', 'WORD', 'kim - boodschappen: de boodschappen',
'de boodschappen = la compra · se usa en plural; en singular, de boodschap es el recado o el mensaje.

🔑 El truco que casi nunca falla: la compra se hace con doen — boodschappen doen, nunca «boodschappen maken».

💡 Een boodschap achterlaten es dejar un mensaje en el contestador.

🚨 Een kleine of grote boodschap doen es, coloquial, ir al baño — mejor no decirlo en la tienda.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la compra' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la compra' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de boodschappen', 'de bóotsxapen',
'• [can.] Ik doe de boodschappen op zaterdag. — Hago la compra los sábados.
• [perf.] Heb jij de boodschappen al gedaan? — ¿Ya has hecho tú la compra?
• [vraag] Zal ik de boodschappen doen? — ¿Hago yo la compra?
• [bijzin] Ik bel je zodra ik klaar ben met de boodschappen. — Te llamo en cuanto termine la compra.
• [geb.] Zet de boodschappen maar in de koelkast. — Mete la compra en la nevera.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la compra' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la compra' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el supermercado → de supermarkt
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el supermercado', 'WORD', 'kim - boodschappen: de supermarkt',
'de supermarkt = el supermercado · plural de supermarkten.

🔑 El truco que casi nunca falla: un compuesto toma el artículo de su última pieza — super + de markt da de supermarkt.

⚠️ Se va naar de supermarkt y se compra in de supermarkt — al revés que el mercado al aire libre, que es op de markt.

💡 En la calle se dice la marca y no la palabra — Ik ga even naar de Appie, que es el Albert Heijn, o naar de Jumbo.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el supermercado' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el supermercado' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de supermarkt', 'de sýpermarkt',
'• [can.] De supermarkt is tot tien uur open. — El supermercado está abierto hasta las diez.
• [perf.] Ik ben net naar de supermarkt geweest. — Acabo de ir al supermercado.
• [vraag] Welke supermarkt is het goedkoopst? — ¿Qué supermercado es el más barato?
• [inv.] In de supermarkt betaal je meestal met je pinpas. — En el supermercado normalmente se paga con la tarjeta.
• [bijzin] Ik ga naar de supermarkt die om de hoek zit. — Voy al supermercado que está a la vuelta de la esquina.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el supermercado' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el supermercado' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el panadero, la panadería → de bakker
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el panadero, la panadería', 'WORD', 'kim - boodschappen: de bakker',
'de bakker = el panadero y también la panadería · plural de bakkers.

🔑 El truco que casi nunca falla: en Holanda la tienda se nombra por el oficio — naar de bakker, naar de slager, naar de groenteboer es ir a la panadería, a la carnicería, a la frutería.

💡 La tienda como edificio es de bakkerij, pero en la calle casi nadie la llama así.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el panadero, la panadería' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el panadero, la panadería' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de bakker', 'de baker',
'• [can.] De bakker op de hoek heeft lekker brood. — La panadería de la esquina tiene un pan muy rico.
• [perf.] Ik heb bij de bakker een taart besteld. — He encargado una tarta en la panadería.
• [vraag] Ga jij even naar de bakker? — ¿Vas un momento a la panadería?
• [bijzin] Ik weet niet of de bakker op maandag open is. — No sé si la panadería abre los lunes.
• [inv.] Bij de bakker kopen we elke zondag croissants. — En la panadería compramos cruasanes cada domingo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el panadero, la panadería' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el panadero, la panadería' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- la bolsa de plástico → de plastic tas
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la bolsa de plástico', 'WORD', 'kim - boodschappen: de plastic tas',
'de plastic tas = la bolsa de plástico · plural de plastic tassen.

⚠️ Plastic va delante y no cambia nunca — de plastic tas, een plastic tas, sin la -e de los adjetivos.

🔤 Escritura y sonido: se escribe plastic y se dice plestik, con e.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la bolsa de plástico' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la bolsa de plástico' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de plastic tas', 'de plestik tas',
'• [can.] Een plastic tas kost tien cent. — Una bolsa de plástico cuesta diez céntimos.
• [perf.] Ik ben mijn tas vergeten, dus ik heb een plastic tas gekocht. — Se me ha olvidado la bolsa, así que he comprado una de plástico.
• [vraag] Wilt u er een plastic tas bij? — ¿Quiere también una bolsa de plástico?
• [geb.] Gooi die plastic tas niet weg. — No tires esa bolsa de plástico.
• [bijzin] Ik neem een eigen tas mee omdat plastic tassen niet meer gratis zijn. — Llevo mi propia bolsa porque las de plástico ya no son gratis.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la bolsa de plástico' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la bolsa de plástico' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el céntimo → de cent
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el céntimo', 'WORD', 'kim - boodschappen: de cent',
'de cent = el céntimo · plural de centen, pero tras un número va en singular — vijftig cent.

💡 En Holanda la caja redondea a cinco céntimos al pagar en efectivo, y las monedas de 1 y 2 cent casi no circulan.

💡 De centen, en plural y coloquial, es la pasta — Hij heeft centen, tiene dinero.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el céntimo' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el céntimo' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de cent', 'de sent',
'• [can.] Dat kost negenennegentig cent. — Eso cuesta noventa y nueve céntimos.
• [perf.] Ze hebben de prijs met tien cent verhoogd. — Han subido el precio diez céntimos.
• [vraag] Heeft u vijf cent voor mij? — ¿Me da cinco céntimos?
• [bijzin] De kassa rondt af, zodat je geen losse centen terugkrijgt. — La caja redondea, así que no te devuelven céntimos sueltos.
• [uitdr.] Ik heb geen cent meer. — No me queda ni un céntimo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el céntimo' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el céntimo' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- la oferta → de aanbieding
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la oferta', 'WORD', 'kim - boodschappen: de aanbieding',
'de aanbieding = la oferta · plural de aanbiedingen.

🔑 El truco que casi nunca falla: de oferta es in de aanbieding, con in y con artículo — nunca «op aanbieding».

🧠 La imagen de la palabra: viene de aanbieden, ofrecer, y como todas las -ing es de.

💡 1 + 1 gratis y 2e halve prijs son las ofertas que verás escritas en el súper.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la oferta' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la oferta' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de aanbieding', 'de aanbíding',
'• [can.] De kaas is in de aanbieding. — El queso está de oferta.
• [perf.] Ik heb drie pakken koffie in de aanbieding gekocht. — He comprado tres paquetes de café de oferta.
• [vraag] Wat is er deze week in de aanbieding? — ¿Qué hay de oferta esta semana?
• [inv.] Deze week is de wijn in de aanbieding. — Esta semana el vino está de oferta.
• [bijzin] Ik koop het alleen als het in de aanbieding is. — Solo lo compro si está de oferta.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la oferta' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la oferta' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el tique, el recibo → de bon, het bonnetje, de kassabon
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el tique, el recibo', 'WORD', 'kim - boodschappen: de bon, het bonnetje, de kassabon',
'de bon, het bonnetje, de kassabon = el tique, el recibo · tres nombres para lo mismo.

📌 Regla de bolsillo:
• ¿En la caja, hablando normal? → het bonnetje, el que más se oye.
• ¿Algo más neutro o escrito? → de kassabon.
• ¿Corto y rápido? → de bon, que también es el vale o el cupón de descuento.

🔑 El truco que casi nunca falla: el diminutivo en -je es siempre het — de bon, pero het bonnetje.

💡 En la caja te preguntan Wilt u de bon? y lo normal es contestar Nee, hoeft niet.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el tique, el recibo' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el tique, el recibo' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de bon, het bonnetje, de kassabon', 'de bon, het bónetye, de kásabon',
'• [can.] Bewaar de bon voor als je het wilt ruilen. — Guarda el tique por si lo quieres cambiar.
• [perf.] Ik heb het bonnetje weggegooid. — He tirado el tique.
• [vraag] Wilt u het bonnetje? — ¿Quiere el tique?
• [bijzin] Je kunt het alleen terugbrengen als je de kassabon nog hebt. — Solo puedes devolverlo si todavía tienes el tique de caja.
• [uitdr.] De bon hoeft niet. — No necesito el tique.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tique, el recibo' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tique, el recibo' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el vendedor, el dependiente → de verkoper
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el vendedor, el dependiente', 'WORD', 'kim - boodschappen: de verkoper',
'de verkoper = el vendedor, el dependiente · plural de verkopers; la mujer es de verkoopster.

🧠 La imagen de la palabra: verkopen, vender, + -er, el que lo hace — igual que de koper, el comprador. Las personas en -er son de.

🔤 Escritura y sonido: se escribe verkoper con una o pero verkoopster con dos, porque ahí la sílaba se cierra.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el vendedor, el dependiente' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el vendedor, el dependiente' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de verkoper', 'de ferkóoper',
'• [can.] De verkoper helpt een andere klant. — El dependiente está atendiendo a otro cliente.
• [perf.] De verkoper heeft me een goede prijs gegeven. — El vendedor me ha hecho un buen precio.
• [vraag] Kunt u de verkoper even roepen? — ¿Puede llamar al dependiente un momento?
• [bijzin] Ik vraag het aan de verkoopster die daar staat. — Se lo pregunto a la dependienta que está allí.
• [inv.] Op de markt praten de verkopers heel hard. — En el mercado los vendedores hablan muy alto.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el vendedor, el dependiente' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el vendedor, el dependiente' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- la mantequilla → de boter
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la mantequilla', 'WORD', 'kim - boodschappen: de boter',
'de boter = la mantequilla, incontable y sin plural.

🧠 La imagen de la palabra: de ella sale de boterham, la rebanada de pan con mantequilla que es el almuerzo holandés.

💡 Para untar se dice smeren — boter op je brood smeren.

💡 Boter bij de vis es, literalmente, mantequilla con el pescado — pagar en el momento de recibir.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la mantequilla' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la mantequilla' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de boter', 'de bóoter',
'• [can.] Ik doe boter op mijn brood. — Me pongo mantequilla en el pan.
• [perf.] Heb je boter gekocht? — ¿Has comprado mantequilla?
• [vraag] Bak je het in boter of in olie? — ¿Lo fríes con mantequilla o con aceite?
• [geb.] Zet de boter terug in de koelkast. — Vuelve a meter la mantequilla en la nevera.
• [uitdr.] Het is boter bij de vis. — Se paga en el acto.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la mantequilla' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la mantequilla' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el monedero, la cartera → de portemonnee
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el monedero, la cartera', 'WORD', 'kim - boodschappen: de portemonnee',
'de portemonnee = el monedero, la cartera · plural de portemonnees.

🧠 La imagen de la palabra: es el francés porte-monnaie, lleva-monedas, y por eso se escribe con doble n y doble e.

💡 Para la cartera de billetes también se oye de portefeuille, pero de portemonnee vale para las dos.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el monedero, la cartera' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el monedero, la cartera' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de portemonnee', 'de portemonée',
'• [can.] Mijn portemonnee zit in mijn tas. — Llevo el monedero en el bolso.
• [perf.] Ik ben mijn portemonnee kwijtgeraakt. — He perdido la cartera.
• [vraag] Heb je je portemonnee bij je? — ¿Llevas la cartera encima?
• [bijzin] Ik merkte pas bij de kassa dat ik mijn portemonnee vergeten was. — No me di cuenta hasta la caja de que me había olvidado la cartera.
• [inv.] Gelukkig zat er weinig geld in mijn portemonnee. — Por suerte llevaba poco dinero en la cartera.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el monedero, la cartera' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el monedero, la cartera' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- la lista → het lijstje
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la lista', 'WORD', 'kim - boodschappen: het lijstje',
'het lijstje = la lista, la listita · plural de lijstjes.

🔑 El truco que casi nunca falla: el diminutivo en -je es siempre het — de lijst, pero het lijstje.

💡 El diminutivo no quiere decir que sea pequeña — het boodschappenlijstje es la lista de la compra, sin más.

⚠️ Estar en la lista es op het lijstje staan, con op y con staan.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la lista' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la lista' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'het lijstje', 'het leistye',
'• [can.] Ik maak altijd een lijstje voor de supermarkt. — Siempre hago una lista para el súper.
• [perf.] Ik heb het lijstje thuis laten liggen. — Me he dejado la lista en casa.
• [vraag] Staat melk op het lijstje? — ¿Está la leche en la lista?
• [geb.] Zet eieren maar op het lijstje. — Apunta huevos en la lista.
• [bijzin] Ik koop alleen wat er op het lijstje staat. — Solo compro lo que está en la lista.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la lista' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la lista' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- la caja registradora → de kassa
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la caja registradora', 'WORD', 'kim - boodschappen: de kassa',
'de kassa = la caja donde se paga · plural de kassa''s.

🔑 El truco que casi nunca falla: en la caja es bij de kassa, con bij — nunca «in de kassa».

💡 La caja de autoservicio es de zelfscankassa, y la cajera, de caissière.

⚠️ La caja como objeto es de doos; de kassa es solo donde se paga.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la caja registradora' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la caja registradora' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de kassa', 'de kasa',
'• [can.] Er staat een lange rij bij de kassa. — Hay una cola larga en la caja.
• [perf.] Ik heb al bij de kassa betaald. — Ya he pagado en caja.
• [vraag] Waar is de kassa? — ¿Dónde está la caja?
• [geb.] Betaalt u maar bij de kassa. — Pague en caja.
• [bijzin] Ik wacht tot de tweede kassa opengaat. — Espero a que abran la segunda caja.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la caja registradora' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la caja registradora' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- la tarjeta de crédito → de creditcard
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la tarjeta de crédito', 'WORD', 'kim - boodschappen: de creditcard',
'de creditcard = la tarjeta de crédito · plural de creditcards.

⚠️ En Holanda se paga con de pinpas, la de débito — la creditcard es para internet y los viajes, y muchos súper no la aceptan.

🔑 El truco que casi nunca falla: met + medio de pago va sin artículo — met creditcard, met pin, contant.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la tarjeta de crédito' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la tarjeta de crédito' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de creditcard', 'de kréditkart',
'• [can.] Veel kleine winkels accepteren geen creditcard. — Muchas tiendas pequeñas no aceptan tarjeta de crédito.
• [perf.] Ik heb de vlucht met mijn creditcard betaald. — He pagado el vuelo con la tarjeta de crédito.
• [vraag] Kan ik met creditcard betalen? — ¿Puedo pagar con tarjeta de crédito?
• [inv.] In Nederland betaal je bijna nooit met een creditcard. — En Holanda casi nunca se paga con tarjeta de crédito.
• [bijzin] Ik weet niet of ze hier een creditcard nemen. — No sé si aquí aceptan tarjeta de crédito.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la tarjeta de crédito' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la tarjeta de crédito' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el carnicero, la carnicería → de slager
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el carnicero, la carnicería', 'WORD', 'kim - boodschappen: de slager',
'de slager = el carnicero y también la carnicería · plural de slagers.

🔑 El truco que casi nunca falla: la tienda se nombra por el oficio — naar de slager es ir a la carnicería.

💡 La frase clásica del carnicero holandés es Mag het een onsje meer zijn? — un onsje son cien gramos, así que es ¿le pongo un poco más?'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el carnicero, la carnicería' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el carnicero, la carnicería' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de slager', 'de slajer',
'• [can.] De slager heeft vandaag vers gehakt. — La carnicería tiene hoy carne picada fresca.
• [perf.] Ik heb bij de slager een kilo gehakt gehaald. — He comprado un kilo de carne picada en la carnicería.
• [vraag] Is de slager op maandag open? — ¿La carnicería abre los lunes?
• [bijzin] Ik koop vlees liever bij de slager, omdat het daar beter is. — Prefiero comprar la carne en la carnicería, porque allí es mejor.
• [uitdr.] Mag het een onsje meer zijn? — ¿Le pongo un poquito más?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el carnicero, la carnicería' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el carnicero, la carnicería' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- la lata → het blik, het blikje
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la lata', 'WORD', 'kim - boodschappen: het blik, het blikje',
'het blik, het blikje = la lata · plurales de blikken y de blikjes.

📌 Regla de bolsillo:
• ¿Lata de conserva, tomate, sopa? → het blik, y en lata es in blik, sin artículo.
• ¿Lata de bebida, refresco, cerveza? → het blikje.

🔑 El truco que casi nunca falla: el diminutivo en -je es siempre het, igual que su palabra madre het blik.

⚠️ De blik, con de, es la mirada — een blik werpen, echar un vistazo.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la lata' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la lata' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'het blik, het blikje', 'het blik, het blikye',
'• [can.] Ik koop tomaten in blik. — Compro tomate en lata.
• [perf.] Hij heeft drie blikjes bier gedronken. — Se ha bebido tres latas de cerveza.
• [vraag] Heb je een blikopener? — ¿Tienes un abrelatas?
• [geb.] Gooi het lege blikje in de prullenbak. — Tira la lata vacía a la papelera.
• [bijzin] Ik neem soep in blik mee omdat die lang goed blijft. — Me llevo sopa en lata porque dura mucho.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la lata' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la lata' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el horario de apertura → de openingstijden
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el horario de apertura', 'WORD', 'kim - boodschappen: de openingstijden',
'de openingstijden = el horario de apertura · se usa casi siempre en plural.

🧠 La imagen de la palabra: de opening + de tijden, las horas de abrir; la s del medio solo une las dos piezas.

🔑 El truco que casi nunca falla: los plurales son siempre de.

💡 En la puerta verás ma t/m vr, de lunes a viernes — t/m es tot en met, hasta e incluido.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el horario de apertura' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el horario de apertura' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de openingstijden', 'de óopeningsteiden',
'• [can.] De openingstijden staan op de deur. — El horario está en la puerta.
• [perf.] De supermarkt heeft de openingstijden veranderd. — El súper ha cambiado el horario.
• [vraag] Wat zijn de openingstijden op zondag? — ¿Cuál es el horario del domingo?
• [bijzin] Kijk even op de website wat de openingstijden zijn. — Mira en la web cuál es el horario.
• [inv.] Op feestdagen gelden andere openingstijden. — Los festivos hay otro horario.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el horario de apertura' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el horario de apertura' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el champú → de shampoo
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el champú', 'WORD', 'kim - boodschappen: de shampoo',
'de shampoo = el champú · plural de shampoos.

🔤 Escritura y sonido: se escribe como en inglés pero se dice shampóo, con el acento al final.

💡 Op zijn es acabarse — De shampoo is op, se ha acabado el champú. Sirve para todo lo que se gasta.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el champú' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el champú' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de shampoo', 'de shampóo',
'• [can.] Deze shampoo is goed voor droog haar. — Este champú es bueno para el pelo seco.
• [perf.] Ik heb nieuwe shampoo gekocht. — He comprado champú nuevo.
• [vraag] Waar staat de shampoo? — ¿Dónde está el champú?
• [bijzin] Ik zie dat de shampoo bijna op is. — Veo que el champú está casi acabado.
• [geb.] Zet shampoo maar op het lijstje. — Apunta champú en la lista.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el champú' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el champú' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- la pasta de dientes → de tandpasta
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la pasta de dientes', 'WORD', 'kim - boodschappen: de tandpasta',
'de tandpasta = la pasta de dientes · plural de tandpasta''s.

🧠 La imagen de la palabra: de tand, el diente, + de pasta — al revés que en español, primero va el diente.

🔑 El truco que casi nunca falla: un compuesto toma el artículo de su última pieza — de pasta, así que de tandpasta.

💡 En Holanda se compra sobre todo en de drogist, la droguería, más que en el súper.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la pasta de dientes' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la pasta de dientes' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de tandpasta', 'de tántpasta',
'• [can.] De tandpasta ligt in de badkamer. — La pasta de dientes está en el baño.
• [perf.] Heb je tandpasta meegenomen? — ¿Has traído pasta de dientes?
• [vraag] Welke tandpasta gebruik jij? — ¿Qué pasta de dientes usas?
• [bijzin] Ik ga naar de drogist omdat de tandpasta op is. — Voy a la droguería porque se ha acabado la pasta de dientes.
• [inv.] Bij de drogist is tandpasta goedkoper. — En la droguería la pasta de dientes es más barata.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la pasta de dientes' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la pasta de dientes' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el billete de diez euros → het tientje
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el billete de diez euros', 'WORD', 'kim - boodschappen: het tientje',
'het tientje = el billete de diez euros, o diez euros sin más · plural de tientjes.

🧠 La imagen de la palabra: es el diminutivo de tien, diez, y por ser -je es het.

📌 El dinero dicho en la calle:
• een tientje — diez euros
• een briefje van twintig — un billete de veinte
• een briefje van vijftig — un billete de cincuenta
• een paar euro — unos pocos euros'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el billete de diez euros' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el billete de diez euros' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'het tientje', 'het tíntye',
'• [can.] Ik heb alleen een tientje bij me. — Solo llevo un billete de diez.
• [perf.] Hij heeft me een tientje geleend. — Me ha prestado diez euros.
• [vraag] Kun je een tientje wisselen? — ¿Me cambias un billete de diez?
• [bijzin] Ik denk dat het samen ongeveer een tientje kost. — Creo que todo junto cuesta unos diez euros.
• [uitdr.] Dat scheelt een tientje. — Eso son diez euros de diferencia.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el billete de diez euros' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el billete de diez euros' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- la tarjeta de débito → de pinpas
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la tarjeta de débito', 'WORD', 'kim - boodschappen: de pinpas',
'de pinpas = la tarjeta de débito, la del banco · plural de pinpassen.

🧠 La imagen de la palabra: de pin, el número PIN, + de pas, la tarjeta. De ahí el verbo pinnen, pagar con tarjeta o sacar del cajero.

📌 La familia de pinnen:
• pinnen — pagar con tarjeta o sacar dinero
• de pinautomaat — el cajero automático
• Pinnen of contant? — ¿tarjeta o efectivo?
• Alleen pinnen — solo se acepta tarjeta'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la tarjeta de débito' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la tarjeta de débito' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de pinpas', 'de pínpas',
'• [can.] Ik betaal altijd met mijn pinpas. — Siempre pago con la tarjeta.
• [perf.] Ik heb mijn pinpas laten blokkeren. — He bloqueado la tarjeta.
• [vraag] Kan ik hier pinnen? — ¿Puedo pagar con tarjeta aquí?
• [bijzin] De automaat zegt dat mijn pinpas verlopen is. — El cajero dice que la tarjeta ha caducado.
• [geb.] Houdt u uw pinpas tegen het apparaat. — Acerque la tarjeta al datáfono.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la tarjeta de débito' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la tarjeta de débito' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- el frutero, la frutería → de groenteboer, de groenteman
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el frutero, la frutería', 'WORD', 'kim - boodschappen: de groenteboer, de groenteman',
'de groenteboer, de groenteman = el frutero y la frutería · plurales de groenteboeren y de groentemannen.

🔑 El truco que casi nunca falla: la tienda se nombra por el oficio — naar de groenteboer es ir a la frutería.

🧠 La imagen de la palabra: de groente, la verdura, + de boer, el campesino — el que vende lo del campo. Igual se forma de visboer, el pescadero.

💡 Los dos nombres valen igual; groenteman suena algo más de ciudad.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el frutero, la frutería' AND word_type = 'WORD');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el frutero, la frutería' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de groenteboer, de groenteman', 'de jrúntebur, de jrúnteman',
'• [can.] De groenteboer heeft mooie tomaten. — La frutería tiene unos tomates muy bonitos.
• [perf.] Ik heb bij de groenteboer appels gekocht. — He comprado manzanas en la frutería.
• [vraag] Staat de groenteman zaterdag op de markt? — ¿El frutero pone puesto en el mercado el sábado?
• [inv.] Bij de groenteboer is het fruit verser. — En la frutería la fruta está más fresca.
• [bijzin] Ik ga naar de groenteman, omdat de supermarkt geen goede peren heeft. — Voy a la frutería porque el súper no tiene peras buenas.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el frutero, la frutería' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - boodschappen'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el frutero, la frutería' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
