-- Learn Languages App - Migration
-- Migration: 20261029000002-grupo-kim-eten
-- Description: Eduardo: "vamos a crear grupos kim con todas estas palabras ... ojo revisa que no
--   existan", con la seleccion por frecuencia aprobada (2026-10-29: "procedamos asi").
--
--   Grupo 'kim - eten', del set Eten en drinken de Learn Dutch with Kim (Quizlet _982j3t).
--   De las 34 entradas de Kim: ninguna existia en el mazo como WORD; 30 se crean aqui con su
--   articulo en la respuesta (§3.1), pronunciacion y 5 frases en notes (§3.7). Las otras 3
--   (het vlees, het brood, de boter) las crea la migracion 01 (kim - boodschappen) y aqui solo
--   se enlazan. Het zout se crea aqui y lo enlaza despues kim - koken. Bier/biertje y
--   patat/friet van en una sola tarjeta con las dos formas. Corregido el vegetarë r roto del
--   PDF: de vegetariër.
--
--   Las ayudas son cortas: la regla con su plural, el atajo de genero cuando lo hay (diminutivo
--   -je → het, infinitivo sustantivado → het, compuesto → genero de la ultima pieza) y truco solo
--   donde es real (het eten / eten, het ijs helado y hielo, de vis pez y pescado, avondeten / diner,
--   patat / friet).

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'kim - eten', 'Comida y bebida basicas del set Eten en drinken de Kim: lo que se pide en un cafe, lo que hay en la nevera y los platos tipicos holandeses (de stamppot, de stroopwafel, de boterham). Cada sustantivo se estudia con su articulo pegado: casi todos son de-woorden, y los het-woorden son pocos y se repiten mucho (het eten, het ijs, het ei, het zout, het ontbijt y los diminutivos en -je). Het vlees, het brood y de boter vienen del grupo kim - boodschappen.', 'Eten en drinken - Flashcards in Quizlet - Learn Dutch with Kim - https://quizlet.com/_982j3t'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'kim - eten');

-- =============================================================================
-- 2. Las 30 tarjetas WORD
-- =============================================================================
-- 2.1 het eten
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la comida', 'WORD', 'kim - eten: het eten', 'het eten = la comida — sin plural en este sentido.

🔑 El truco que casi nunca falla — con het delante es la comida, sin articulo es el verbo comer.
• Het eten is klaar. — La comida esta lista.
• Wij eten om zes uur. — Cenamos a las seis.

💡 Es un infinitivo sustantivado, y todo infinitivo sustantivado es het, igual que het drinken o het koken.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la comida' AND notes = 'kim - eten: het eten');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'la comida' AND notes = 'kim - eten: het eten' LIMIT 1), 'nl_NL', 'het eten', 'het éeten', '• [can.] Het eten is klaar, kom aan tafel. — La comida está lista, ven a la mesa.
• [perf.] Wie heeft het eten gemaakt? — ¿Quién ha hecho la comida?
• [inv.] Na het eten gaan we wandelen. — Después de comer vamos a pasear.
• [bijzin] Ik weet niet of het eten hier goed is. — No sé si la comida aquí es buena.
• [uitdr.] Eet smakelijk! — ¡Que aproveche!'
WHERE (SELECT id FROM words_es WHERE text = 'la comida' AND notes = 'kim - eten: het eten' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la comida' AND notes = 'kim - eten: het eten' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'la comida' AND notes = 'kim - eten: het eten' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la comida' AND notes = 'kim - eten: het eten' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'la comida' AND notes = 'kim - eten: het eten' LIMIT 1) IS NOT NULL;

-- 2.2 de koffie
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el café', 'WORD', 'kim - eten: de koffie', 'de koffie = el café — sin plural; para pedir uno se dice een koffie o een kopje koffie.

📌 Regla de bolsillo:
• ¿Lo pides en un bar? → Een koffie, alstublieft.
• ¿Con leche? → koffie verkeerd, literalmente café equivocado, con mucha leche.
• ¿Quedar a tomar algo? → koffie drinken, aunque luego sea un té.

🧠 Koffie verkeerd se llama equivocado porque lleva mas leche que cafe: la proporcion al reves.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el café' AND notes = 'kim - eten: de koffie');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el café' AND notes = 'kim - eten: de koffie' LIMIT 1), 'nl_NL', 'de koffie', 'de kófi', '• [can.] Ik drink elke ochtend twee koppen koffie. — Me tomo dos tazas de café cada mañana.
• [vraag] Wil je koffie of thee? — ¿Quieres café o té?
• [perf.] We hebben samen koffie gedronken. — Hemos tomado un café juntos.
• [geb.] Zet jij even koffie? — ¿Haces tú un café?
• [uitdr.] Dat is geen zuivere koffie. — Eso me huele mal, algo no cuadra.'
WHERE (SELECT id FROM words_es WHERE text = 'el café' AND notes = 'kim - eten: de koffie' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el café' AND notes = 'kim - eten: de koffie' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el café' AND notes = 'kim - eten: de koffie' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el café' AND notes = 'kim - eten: de koffie' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el café' AND notes = 'kim - eten: de koffie' LIMIT 1) IS NOT NULL;

-- 2.3 de wijn
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el vino', 'WORD', 'kim - eten: de wijn', 'de wijn = el vino — plural de wijnen.

• rode wijn — vino tinto, literalmente vino rojo.
• witte wijn — vino blanco.
• een glas wijn — una copa de vino.

🔑 El truco que casi nunca falla — la ij suena ei, como en mijn y zijn: wijn rima con mijn.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el vino' AND notes = 'kim - eten: de wijn');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el vino' AND notes = 'kim - eten: de wijn' LIMIT 1), 'nl_NL', 'de wijn', 'de wein', '• [can.] Bij vis drink ik graag witte wijn. — Con el pescado me gusta tomar vino blanco.
• [vraag] Heb je een fles rode wijn meegenomen? — ¿Has traído una botella de vino tinto?
• [perf.] Ik heb te veel wijn gedronken. — He bebido demasiado vino.
• [inv.] In Spanje is de wijn goedkoop. — En España el vino es barato.
• [bijzin] Hij zegt dat deze wijn uit Rioja komt. — Dice que este vino es de La Rioja.'
WHERE (SELECT id FROM words_es WHERE text = 'el vino' AND notes = 'kim - eten: de wijn' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el vino' AND notes = 'kim - eten: de wijn' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el vino' AND notes = 'kim - eten: de wijn' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el vino' AND notes = 'kim - eten: de wijn' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el vino' AND notes = 'kim - eten: de wijn' LIMIT 1) IS NOT NULL;

-- 2.4 de thee
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el té', 'WORD', 'kim - eten: de thee', 'de thee = el té — sin plural; la th suena t, sin soplo.

• een kopje thee — una taza de té.
• thee zetten — hacer té, igual que koffie zetten.
• muntthee — té de menta, la que se pone en todos los cafes holandeses.

⚠️ No se pronuncia como el ingles: thee es tee, con t seca.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el té' AND notes = 'kim - eten: de thee');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el té' AND notes = 'kim - eten: de thee' LIMIT 1), 'nl_NL', 'de thee', 'de tee', '• [can.] ''s Avonds drink ik thee zonder suiker. — Por la noche tomo té sin azúcar.
• [geb.] Zet even thee voor de gasten. — Haz té para los invitados.
• [perf.] Heb je de thee al gezet? — ¿Ya has hecho el té?
• [vraag] Neem je melk in je thee? — ¿Le pones leche al té?
• [inv.] Bij oma drinken we altijd thee. — En casa de la abuela siempre tomamos té.'
WHERE (SELECT id FROM words_es WHERE text = 'el té' AND notes = 'kim - eten: de thee' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el té' AND notes = 'kim - eten: de thee' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el té' AND notes = 'kim - eten: de thee' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el té' AND notes = 'kim - eten: de thee' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el té' AND notes = 'kim - eten: de thee' LIMIT 1) IS NOT NULL;

-- 2.5 het bier, het biertje
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la cerveza, la cervecita', 'WORD', 'kim - eten: het bier, het biertje', 'het bier = la cerveza — y het biertje, la cerveza que se pide en un bar.

📐 El diminutivo es siempre het, asi que biertje no cambia el genero de bier.
• Een biertje, graag. — Una cerveza, por favor.
• Zullen we een biertje drinken? — ¿Nos tomamos una cerveza?

🧠 En Holanda el diminutivo es lo normal para lo que se pide de uno en uno: een biertje, een kopje, een broodje.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la cerveza, la cervecita' AND notes = 'kim - eten: het bier, het biertje');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'la cerveza, la cervecita' AND notes = 'kim - eten: het bier, het biertje' LIMIT 1), 'nl_NL', 'het bier, het biertje', 'het biir, het bíirtie', '• [can.] Na het werk drink ik graag een biertje. — Después del trabajo me gusta tomarme una cerveza.
• [vraag] Wil je nog een biertje? — ¿Quieres otra cerveza?
• [perf.] We hebben op het terras een biertje gedronken. — Nos hemos tomado una cerveza en la terraza.
• [inv.] In België is het bier heel sterk. — En Bélgica la cerveza es muy fuerte.
• [bijzin] Ik weet niet of er nog bier in de koelkast staat. — No sé si queda cerveza en la nevera.'
WHERE (SELECT id FROM words_es WHERE text = 'la cerveza, la cervecita' AND notes = 'kim - eten: het bier, het biertje' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la cerveza, la cervecita' AND notes = 'kim - eten: het bier, het biertje' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'la cerveza, la cervecita' AND notes = 'kim - eten: het bier, het biertje' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la cerveza, la cervecita' AND notes = 'kim - eten: het bier, het biertje' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'la cerveza, la cervecita' AND notes = 'kim - eten: het bier, het biertje' LIMIT 1) IS NOT NULL;

-- 2.6 de vis
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el pescado', 'WORD', 'kim - eten: de vis', 'de vis = el pescado y el pez — plural de vissen.

🔑 El truco que casi nunca falla — el neerlandes no distingue pez de pescado: de vis vale para los dos.
• Er zwemmen vissen in de vijver. — Hay peces en el estanque.
• Ik eet vis op vrijdag. — Como pescado los viernes.

💡 De visboer es el pescadero y de haring, el arenque crudo que se come en la calle.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el pescado' AND notes = 'kim - eten: de vis');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el pescado' AND notes = 'kim - eten: de vis' LIMIT 1), 'nl_NL', 'de vis', 'de fis', '• [can.] Ik eet twee keer per week vis. — Como pescado dos veces por semana.
• [perf.] Hij heeft een grote vis gevangen. — Ha pescado un pez grande.
• [vraag] Eet je liever vis of vlees? — ¿Prefieres pescado o carne?
• [bijzin] Het restaurant is bekend omdat de vis zo vers is. — El restaurante es famoso porque el pescado es muy fresco.
• [uitdr.] Hij voelt zich als een vis in het water. — Se siente como pez en el agua.'
WHERE (SELECT id FROM words_es WHERE text = 'el pescado' AND notes = 'kim - eten: de vis' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el pescado' AND notes = 'kim - eten: de vis' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el pescado' AND notes = 'kim - eten: de vis' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el pescado' AND notes = 'kim - eten: de vis' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el pescado' AND notes = 'kim - eten: de vis' LIMIT 1) IS NOT NULL;

-- 2.7 het ontbijt
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el desayuno', 'WORD', 'kim - eten: het ontbijt', 'het ontbijt = el desayuno — plural de ontbijten, poco usado.

🧠 Ont- es quitar y bijten es morder: ontbijten es romper el ayuno, igual que el ingles breakfast.
• het ontbijt — el desayuno, sustantivo.
• ontbijten — desayunar, verbo sin ge- en el participio: ik heb ontbeten.

• Wat eet je bij het ontbijt? — ¿Qué tomas para desayunar?'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el desayuno' AND notes = 'kim - eten: het ontbijt');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el desayuno' AND notes = 'kim - eten: het ontbijt' LIMIT 1), 'nl_NL', 'het ontbijt', 'het ontbéit', '• [can.] Het ontbijt staat om acht uur klaar. — El desayuno está listo a las ocho.
• [vraag] Wat eet je meestal bij het ontbijt? — ¿Qué sueles tomar para desayunar?
• [perf.] Ik heb vandaag geen tijd voor ontbijt gehad. — Hoy no he tenido tiempo de desayunar.
• [inv.] In het hotel is het ontbijt inbegrepen. — En el hotel el desayuno está incluido.
• [uitdr.] Het ontbijt is de belangrijkste maaltijd van de dag. — El desayuno es la comida más importante del día.'
WHERE (SELECT id FROM words_es WHERE text = 'el desayuno' AND notes = 'kim - eten: het ontbijt' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el desayuno' AND notes = 'kim - eten: het ontbijt' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el desayuno' AND notes = 'kim - eten: het ontbijt' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el desayuno' AND notes = 'kim - eten: het ontbijt' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el desayuno' AND notes = 'kim - eten: het ontbijt' LIMIT 1) IS NOT NULL;

-- 2.8 de smaak
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el sabor', 'WORD', 'kim - eten: de smaak', 'de smaak = el sabor y el gusto — plural de smaken.

📌 Regla de bolsillo:
• ¿Lo que sabe la comida? → de smaak, het smaakt goed.
• ¿Tu estilo o preferencia? → de smaak, ze heeft een goede smaak.
• ¿Un gusto personal? → Over smaak valt niet te twisten.

• Het smaakt lekker. — Está rico.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el sabor' AND notes = 'kim - eten: de smaak');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el sabor' AND notes = 'kim - eten: de smaak' LIMIT 1), 'nl_NL', 'de smaak', 'de smaak', '• [can.] Deze soep heeft een rare smaak. — Esta sopa tiene un sabor raro.
• [vraag] Welke smaak ijs wil je? — ¿De qué sabor quieres el helado?
• [perf.] Het eten heeft goed gesmaakt. — La comida ha estado muy rica.
• [bijzin] Ik vind dat hij een goede smaak heeft. — Creo que tiene buen gusto.
• [uitdr.] Over smaak valt niet te twisten. — Sobre gustos no hay nada escrito.'
WHERE (SELECT id FROM words_es WHERE text = 'el sabor' AND notes = 'kim - eten: de smaak' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el sabor' AND notes = 'kim - eten: de smaak' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el sabor' AND notes = 'kim - eten: de smaak' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el sabor' AND notes = 'kim - eten: de smaak' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el sabor' AND notes = 'kim - eten: de smaak' LIMIT 1) IS NOT NULL;

-- 2.9 de lunch
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el almuerzo', 'WORD', 'kim - eten: de lunch', 'de lunch = el almuerzo, la comida de mediodia — plural de lunches.

⚠️ En Holanda la lunch es ligera, a las doce o la una: un bocadillo y un vaso de leche, no la comida fuerte española.
• lunchen — almorzar, ik heb geluncht.
• de lunchpauze — la pausa de la comida.

💡 La comida caliente del dia es de avond, het avondeten, hacia las seis.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el almuerzo' AND notes = 'kim - eten: de lunch');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el almuerzo' AND notes = 'kim - eten: de lunch' LIMIT 1), 'nl_NL', 'de lunch', 'de lunsh', '• [can.] Ik neem mijn lunch altijd mee naar het werk. — Siempre me llevo el almuerzo al trabajo.
• [vraag] Zullen we samen gaan lunchen? — ¿Vamos a comer juntos?
• [perf.] We hebben in de kantine geluncht. — Hemos comido en la cantina.
• [inv.] Tijdens de lunch lees ik de krant. — Durante el almuerzo leo el periódico.
• [bijzin] Hij belt terug nadat hij zijn lunch heeft gegeten. — Te llama después de haber almorzado.'
WHERE (SELECT id FROM words_es WHERE text = 'el almuerzo' AND notes = 'kim - eten: de lunch' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el almuerzo' AND notes = 'kim - eten: de lunch' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el almuerzo' AND notes = 'kim - eten: de lunch' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el almuerzo' AND notes = 'kim - eten: de lunch' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el almuerzo' AND notes = 'kim - eten: de lunch' LIMIT 1) IS NOT NULL;

-- 2.10 het ijs
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el helado, el hielo', 'WORD', 'kim - eten: het ijs', 'het ijs = el helado y tambien el hielo — sin plural.

🔑 El truco que casi nunca falla — si se come es helado, si flota en la bebida o cubre un canal es hielo.
• Een ijsje, alsjeblieft. — Un helado, por favor.
• Er ligt ijs op de gracht. — Hay hielo en el canal.

💡 Para un helado de uno se dice het ijsje, con el diminutivo que siempre es het.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el helado, el hielo' AND notes = 'kim - eten: het ijs');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el helado, el hielo' AND notes = 'kim - eten: het ijs' LIMIT 1), 'nl_NL', 'het ijs', 'het eis', '• [can.] In de zomer eten we veel ijs. — En verano comemos mucho helado.
• [vraag] Wil je een ijsje? — ¿Quieres un helado?
• [perf.] Het ijs is gesmolten. — El helado se ha derretido.
• [inv.] Bij min tien graden ligt er ijs op het water. — A diez bajo cero hay hielo en el agua.
• [uitdr.] Hij begeeft zich op glad ijs. — Está pisando terreno resbaladizo.'
WHERE (SELECT id FROM words_es WHERE text = 'el helado, el hielo' AND notes = 'kim - eten: het ijs' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el helado, el hielo' AND notes = 'kim - eten: het ijs' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el helado, el hielo' AND notes = 'kim - eten: het ijs' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el helado, el hielo' AND notes = 'kim - eten: het ijs' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el helado, el hielo' AND notes = 'kim - eten: het ijs' LIMIT 1) IS NOT NULL;

-- 2.11 de kaas
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el queso', 'WORD', 'kim - eten: de kaas', 'de kaas = el queso — plural de kazen, con una sola a porque la silaba queda abierta.

• jonge kaas / oude kaas — queso tierno / queso curado.
• een plakje kaas — una loncha de queso.
• een broodje kaas — un bocadillo de queso.

🧠 Kaas es la palabra de los holandeses: en el futbol a los aficionados se les llama kaaskoppen, cabezas de queso.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el queso' AND notes = 'kim - eten: de kaas');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el queso' AND notes = 'kim - eten: de kaas' LIMIT 1), 'nl_NL', 'de kaas', 'de kaas', '• [can.] Op mijn brood eet ik graag jonge kaas. — En el pan me gusta el queso tierno.
• [vraag] Hoeveel kost deze kaas per kilo? — ¿Cuánto cuesta este queso el kilo?
• [perf.] Ik heb op de markt Goudse kaas gekocht. — He comprado queso de Gouda en el mercado.
• [inv.] In Nederland eet men veel kaas. — En Holanda se come mucho queso.
• [uitdr.] Hij laat zich de kaas niet van het brood eten. — No se deja tomar el pelo.'
WHERE (SELECT id FROM words_es WHERE text = 'el queso' AND notes = 'kim - eten: de kaas' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el queso' AND notes = 'kim - eten: de kaas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el queso' AND notes = 'kim - eten: de kaas' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el queso' AND notes = 'kim - eten: de kaas' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el queso' AND notes = 'kim - eten: de kaas' LIMIT 1) IS NOT NULL;

-- 2.12 de melk
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la leche', 'WORD', 'kim - eten: de melk', 'de melk = la leche — sin plural.

• volle melk — leche entera.
• halfvolle melk — leche semidesnatada, la mas comun.
• karnemelk — suero de mantequilla, la bebida tipica del almuerzo holandes.

🔑 El truco que casi nunca falla — melk se pronuncia con la e corta y la l bien dicha: melk, nunca «milk».'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la leche' AND notes = 'kim - eten: de melk');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'la leche' AND notes = 'kim - eten: de melk' LIMIT 1), 'nl_NL', 'de melk', 'de melk', '• [can.] De kinderen drinken melk bij de lunch. — Los niños toman leche en el almuerzo.
• [vraag] Is er nog melk in de koelkast? — ¿Queda leche en la nevera?
• [perf.] Ik ben vergeten melk te kopen. — Se me ha olvidado comprar leche.
• [geb.] Doe de melk even terug in de koelkast. — Vuelve a meter la leche en la nevera.
• [bijzin] Hij drinkt geen koffie omdat hij geen melk verdraagt. — No toma café porque no tolera la leche.'
WHERE (SELECT id FROM words_es WHERE text = 'la leche' AND notes = 'kim - eten: de melk' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la leche' AND notes = 'kim - eten: de melk' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'la leche' AND notes = 'kim - eten: de melk' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la leche' AND notes = 'kim - eten: de melk' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'la leche' AND notes = 'kim - eten: de melk' LIMIT 1) IS NOT NULL;

-- 2.13 de kip
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el pollo, la gallina', 'WORD', 'kim - eten: de kip', 'de kip = el pollo para comer y la gallina viva — plural de kippen.

🔑 El truco que casi nunca falla — como con de vis, el neerlandes usa una sola palabra para el animal y la carne.
• De kip legt een ei. — La gallina pone un huevo.
• Vanavond eten we kip. — Esta noche cenamos pollo.

💡 Kipfilet es la pechuga de pollo, lo que mas se compra en el super.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el pollo, la gallina' AND notes = 'kim - eten: de kip');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el pollo, la gallina' AND notes = 'kim - eten: de kip' LIMIT 1), 'nl_NL', 'de kip', 'de kip', '• [can.] Vanavond eten we kip met rijst. — Esta noche cenamos pollo con arroz.
• [perf.] Ik heb de kip in de oven gezet. — He metido el pollo en el horno.
• [vraag] Hoeveel kippen heeft je opa? — ¿Cuántas gallinas tiene tu abuelo?
• [inv.] Op de boerderij lopen de kippen los. — En la granja las gallinas andan sueltas.
• [uitdr.] Hij is er als de kippen bij. — Se apunta enseguida, no deja pasar la ocasión.'
WHERE (SELECT id FROM words_es WHERE text = 'el pollo, la gallina' AND notes = 'kim - eten: de kip' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el pollo, la gallina' AND notes = 'kim - eten: de kip' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el pollo, la gallina' AND notes = 'kim - eten: de kip' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el pollo, la gallina' AND notes = 'kim - eten: de kip' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el pollo, la gallina' AND notes = 'kim - eten: de kip' LIMIT 1) IS NOT NULL;

-- 2.14 de soep
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la sopa', 'WORD', 'kim - eten: de soep', 'de soep = la sopa — plural de soepen; la oe suena u.

• erwtensoep — la sopa de guisantes espesa del invierno holandes, tambien llamada snert.
• tomatensoep — sopa de tomate.

🧠 Soep y el español sopa vienen de la misma raiz germanica: la oe neerlandesa es siempre u, como en boek o goed.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la sopa' AND notes = 'kim - eten: de soep');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'la sopa' AND notes = 'kim - eten: de soep' LIMIT 1), 'nl_NL', 'de soep', 'de sup', '• [can.] In de winter maak ik vaak soep. — En invierno hago sopa a menudo.
• [vraag] Is de soep nog warm? — ¿La sopa sigue caliente?
• [perf.] Mijn moeder heeft erwtensoep gemaakt. — Mi madre ha hecho sopa de guisantes.
• [inv.] Als voorgerecht nemen we soep. — De primero tomamos sopa.
• [uitdr.] De soep wordt niet zo heet gegeten als ze wordt opgediend. — No es para tanto, no es tan grave como parece.'
WHERE (SELECT id FROM words_es WHERE text = 'la sopa' AND notes = 'kim - eten: de soep' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la sopa' AND notes = 'kim - eten: de soep' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'la sopa' AND notes = 'kim - eten: de soep' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la sopa' AND notes = 'kim - eten: de soep' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'la sopa' AND notes = 'kim - eten: de soep' LIMIT 1) IS NOT NULL;

-- 2.15 de taart
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la tarta, el pastel', 'WORD', 'kim - eten: de taart', 'de taart = la tarta, el pastel grande — plural de taarten.

📌 Regla de bolsillo:
• ¿Tarta entera, de cumpleaños? → de taart, de verjaardagstaart.
• ¿Un trozo? → een stuk taart.
• ¿Pastelito individual? → het gebakje.

🧠 Taart y tarta se parecen: la doble aa es solo la a larga.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la tarta, el pastel' AND notes = 'kim - eten: de taart');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'la tarta, el pastel' AND notes = 'kim - eten: de taart' LIMIT 1), 'nl_NL', 'de taart', 'de taart', '• [can.] Op verjaardagen eten we altijd taart. — En los cumpleaños siempre comemos tarta.
• [vraag] Wil je een stuk appeltaart? — ¿Quieres un trozo de tarta de manzana?
• [perf.] Mijn zus heeft een taart gebakken. — Mi hermana ha hecho una tarta.
• [inv.] Bij de koffie hoort een stuk taart. — Con el café va un trozo de tarta.
• [bijzin] Ik weet niet wie de laatste taart heeft opgegeten. — No sé quién se ha comido la última tarta.'
WHERE (SELECT id FROM words_es WHERE text = 'la tarta, el pastel' AND notes = 'kim - eten: de taart' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la tarta, el pastel' AND notes = 'kim - eten: de taart' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'la tarta, el pastel' AND notes = 'kim - eten: de taart' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la tarta, el pastel' AND notes = 'kim - eten: de taart' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'la tarta, el pastel' AND notes = 'kim - eten: de taart' LIMIT 1) IS NOT NULL;

-- 2.16 het ei
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el huevo', 'WORD', 'kim - eten: het ei', 'het ei = el huevo — plural irregular de eieren.

⚠️ El plural lleva -eren, como het kind → de kinderen: no es «de eien».
• een gekookt ei — un huevo cocido.
• een gebakken ei — un huevo frito.
• het eitje — el huevito, otra vez het por el diminutivo.

🔑 El truco que casi nunca falla — los pocos plurales en -eren son het-woorden: het ei, het kind, het lam, het blad.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el huevo' AND notes = 'kim - eten: het ei');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el huevo' AND notes = 'kim - eten: het ei' LIMIT 1), 'nl_NL', 'het ei', 'het ei', '• [can.] Ik eet elke ochtend een gekookt ei. — Me como un huevo cocido cada mañana.
• [vraag] Hoeveel eieren heb je nodig? — ¿Cuántos huevos necesitas?
• [perf.] Ik heb twee eieren gebakken. — He frito dos huevos.
• [inv.] Met Pasen zoeken de kinderen eieren. — En Pascua los niños buscan huevos.
• [uitdr.] Dat is een eitje. — Eso está chupado, es facilísimo.'
WHERE (SELECT id FROM words_es WHERE text = 'el huevo' AND notes = 'kim - eten: het ei' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el huevo' AND notes = 'kim - eten: het ei' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el huevo' AND notes = 'kim - eten: het ei' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el huevo' AND notes = 'kim - eten: het ei' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el huevo' AND notes = 'kim - eten: het ei' LIMIT 1) IS NOT NULL;

-- 2.17 het zout
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la sal', 'WORD', 'kim - eten: het zout', 'het zout = la sal — sin plural en la cocina.

⚠️ Es het, aunque en español sea femenino: el genero no se traduce, se aprende pegado.
• zout en peper — sal y pimienta, en ese orden.
• zout — salado, como adjetivo: de soep is te zout.

🔑 El truco que casi nunca falla — ou suena au: zout se dice saut.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la sal' AND notes = 'kim - eten: het zout');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'la sal' AND notes = 'kim - eten: het zout' LIMIT 1), 'nl_NL', 'het zout', 'het saut', '• [can.] Er zit te veel zout in de soep. — La sopa tiene demasiada sal.
• [vraag] Kun je me het zout even geven? — ¿Me pasas la sal?
• [perf.] Heb je al zout in het water gedaan? — ¿Ya has echado sal al agua?
• [geb.] Doe er een snufje zout bij. — Añade una pizca de sal.
• [uitdr.] Ik neem het met een korreltje zout. — Me lo tomo con cautela, sin creérmelo del todo.'
WHERE (SELECT id FROM words_es WHERE text = 'la sal' AND notes = 'kim - eten: het zout' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la sal' AND notes = 'kim - eten: het zout' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'la sal' AND notes = 'kim - eten: het zout' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la sal' AND notes = 'kim - eten: het zout' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'la sal' AND notes = 'kim - eten: het zout' LIMIT 1) IS NOT NULL;

-- 2.18 de suiker
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el azúcar', 'WORD', 'kim - eten: de suiker', 'de suiker = el azucar — plural de suikers, solo para tipos de azucar.

• suiker in de koffie — azucar en el cafe.
• het suikerklontje — el terron de azucar, het por el diminutivo.
• suikervrij — sin azucar.

🔑 El truco que casi nunca falla — ui suena como una ói muy cerrada: suiker se dice sóiker.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el azúcar' AND notes = 'kim - eten: de suiker');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el azúcar' AND notes = 'kim - eten: de suiker' LIMIT 1), 'nl_NL', 'de suiker', 'de sóiker', '• [can.] Ik drink thee zonder suiker. — Tomo el té sin azúcar.
• [vraag] Neem je suiker in je koffie? — ¿Le echas azúcar al café?
• [perf.] Ik heb te veel suiker in het deeg gedaan. — He echado demasiado azúcar a la masa.
• [inv.] In frisdrank zit veel suiker. — Los refrescos llevan mucho azúcar.
• [bijzin] De dokter zegt dat ik minder suiker moet eten. — El médico dice que tengo que comer menos azúcar.'
WHERE (SELECT id FROM words_es WHERE text = 'el azúcar' AND notes = 'kim - eten: de suiker' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el azúcar' AND notes = 'kim - eten: de suiker' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el azúcar' AND notes = 'kim - eten: de suiker' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el azúcar' AND notes = 'kim - eten: de suiker' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el azúcar' AND notes = 'kim - eten: de suiker' LIMIT 1) IS NOT NULL;

-- 2.19 de chocolade
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el chocolate', 'WORD', 'kim - eten: de chocolade', 'de chocolade = el chocolate — sin plural; en la calle se oye tambien de chocola.

• chocolademelk — chocolate con leche para beber, frio o caliente.
• een reep chocolade — una tableta de chocolate.
• de hagelslag — los fideos de chocolate que se echan sobre el pan.

🔑 El truco que casi nunca falla — la ch inicial suena sh, como en el frances: shokoláade.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el chocolate' AND notes = 'kim - eten: de chocolade');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el chocolate' AND notes = 'kim - eten: de chocolade' LIMIT 1), 'nl_NL', 'de chocolade', 'de shokoláade', '• [can.] Ik eet elke dag een stukje chocolade. — Me como un trocito de chocolate cada día.
• [vraag] Wil je warme chocolademelk? — ¿Quieres chocolate caliente?
• [perf.] De kinderen hebben alle chocolade opgegeten. — Los niños se han comido todo el chocolate.
• [inv.] In België maken ze de beste chocolade. — En Bélgica hacen el mejor chocolate.
• [bijzin] Ik kan niet stoppen als ik chocolade eet. — No puedo parar cuando como chocolate.'
WHERE (SELECT id FROM words_es WHERE text = 'el chocolate' AND notes = 'kim - eten: de chocolade' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el chocolate' AND notes = 'kim - eten: de chocolade' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el chocolate' AND notes = 'kim - eten: de chocolade' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el chocolate' AND notes = 'kim - eten: de chocolade' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el chocolate' AND notes = 'kim - eten: de chocolade' LIMIT 1) IS NOT NULL;

-- 2.20 de pizza
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la pizza', 'WORD', 'kim - eten: de pizza', 'de pizza = la pizza — plural de pizza''s, con apostrofo.

📐 Las palabras que acaban en a, i, o, u o y hacen el plural con ''s: pizza''s, oma''s, auto''s, baby''s.
• een pizza bestellen — pedir una pizza.
• Zullen we pizza eten? — ¿Comemos pizza?

💡 Pizza es de, como casi todas las palabras extranjeras que entran al idioma.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la pizza' AND notes = 'kim - eten: de pizza');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'la pizza' AND notes = 'kim - eten: de pizza' LIMIT 1), 'nl_NL', 'de pizza', 'de pítsa', '• [can.] Op vrijdag eten we vaak pizza. — Los viernes cenamos pizza a menudo.
• [vraag] Zullen we een pizza bestellen? — ¿Pedimos una pizza?
• [perf.] We hebben drie pizza''s besteld. — Hemos pedido tres pizzas.
• [inv.] Bij die pizzeria is de pizza heel dun. — En esa pizzería la pizza es muy fina.
• [bijzin] Hij vraagt of de pizza al bezorgd is. — Pregunta si ya han traído la pizza.'
WHERE (SELECT id FROM words_es WHERE text = 'la pizza' AND notes = 'kim - eten: de pizza' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la pizza' AND notes = 'kim - eten: de pizza' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'la pizza' AND notes = 'kim - eten: de pizza' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la pizza' AND notes = 'kim - eten: de pizza' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'la pizza' AND notes = 'kim - eten: de pizza' LIMIT 1) IS NOT NULL;

-- 2.21 de rijst
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el arroz', 'WORD', 'kim - eten: de rijst', 'de rijst = el arroz — sin plural.

• gekookte rijst — arroz hervido.
• rijst met kip — arroz con pollo.
• de rijsttafel — la mesa de arroz indonesia, herencia colonial que se come en toda Holanda.

🔑 El truco que casi nunca falla — ij suena ei: rijst se dice reist, como reizen, viajar.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el arroz' AND notes = 'kim - eten: de rijst');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el arroz' AND notes = 'kim - eten: de rijst' LIMIT 1), 'nl_NL', 'de rijst', 'de reist', '• [can.] Bij de kip eten we rijst. — Con el pollo comemos arroz.
• [vraag] Hoe lang moet de rijst koken? — ¿Cuánto tiempo tiene que cocer el arroz?
• [perf.] De rijst is aangebrand. — Se ha quemado el arroz.
• [inv.] In Azië eet men elke dag rijst. — En Asia se come arroz todos los días.
• [bijzin] Ik weet niet of er nog rijst in de kast staat. — No sé si queda arroz en el armario.'
WHERE (SELECT id FROM words_es WHERE text = 'el arroz' AND notes = 'kim - eten: de rijst' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el arroz' AND notes = 'kim - eten: de rijst' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el arroz' AND notes = 'kim - eten: de rijst' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el arroz' AND notes = 'kim - eten: de rijst' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el arroz' AND notes = 'kim - eten: de rijst' LIMIT 1) IS NOT NULL;

-- 2.22 het avondeten
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la cena', 'WORD', 'kim - eten: het avondeten', 'het avondeten = la cena — sin plural; es het porque manda la ultima pieza, het eten.

📐 En un compuesto el genero lo da la ultima palabra: de avond + het eten → het avondeten.

📌 Regla de bolsillo:
• ¿La cena de casa, la de diario? → het avondeten.
• ¿Una cena formal o de gala? → het diner.
• ¿El verbo? → avondeten o dineren, aunque lo normal es simplemente eten.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la cena' AND notes = 'kim - eten: het avondeten');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'la cena' AND notes = 'kim - eten: het avondeten' LIMIT 1), 'nl_NL', 'het avondeten', 'het áafont-eeten', '• [can.] Het avondeten is om zes uur. — La cena es a las seis.
• [vraag] Wat eten we als avondeten? — ¿Qué cenamos?
• [perf.] Ik heb het avondeten al klaargemaakt. — Ya he preparado la cena.
• [inv.] Na het avondeten kijken we tv. — Después de cenar vemos la tele.
• [bijzin] Bel me even voordat het avondeten klaar is. — Llámame antes de que esté lista la cena.'
WHERE (SELECT id FROM words_es WHERE text = 'la cena' AND notes = 'kim - eten: het avondeten' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la cena' AND notes = 'kim - eten: het avondeten' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'la cena' AND notes = 'kim - eten: het avondeten' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la cena' AND notes = 'kim - eten: het avondeten' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'la cena' AND notes = 'kim - eten: het avondeten' LIMIT 1) IS NOT NULL;

-- 2.23 het koekje
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la galleta', 'WORD', 'kim - eten: het koekje', 'het koekje = la galleta — plural de koekjes.

🔑 El truco que casi nunca falla — todo diminutivo en -je es het, aunque la palabra base sea de: de koek → het koekje.
• een koekje bij de koffie — una galleta con el cafe.
• de koektrommel — la lata de las galletas.

🧠 Del neerlandes koekje viene el ingles cookie: los colonos holandeses lo llevaron a Nueva York.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la galleta' AND notes = 'kim - eten: het koekje');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'la galleta' AND notes = 'kim - eten: het koekje' LIMIT 1), 'nl_NL', 'het koekje', 'het kúukie', '• [can.] Bij de koffie krijg je een koekje. — Con el café te dan una galleta.
• [vraag] Mag ik nog een koekje? — ¿Puedo coger otra galleta?
• [perf.] Wie heeft alle koekjes opgegeten? — ¿Quién se ha comido todas las galletas?
• [geb.] Pak maar een koekje uit de trommel. — Coge una galleta de la lata.
• [uitdr.] Dat is een koekje van eigen deeg. — Le han dado de su propia medicina.'
WHERE (SELECT id FROM words_es WHERE text = 'la galleta' AND notes = 'kim - eten: het koekje' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la galleta' AND notes = 'kim - eten: het koekje' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'la galleta' AND notes = 'kim - eten: het koekje' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la galleta' AND notes = 'kim - eten: het koekje' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'la galleta' AND notes = 'kim - eten: het koekje' LIMIT 1) IS NOT NULL;

-- 2.24 het toetje
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el postre', 'WORD', 'kim - eten: het toetje', 'het toetje = el postre — plural de toetjes; het por el diminutivo en -je.

• als toetje — de postre.
• het nagerecht — el postre en la carta de un restaurante, palabra mas formal.

🪜 La escalera de la cena: het voorgerecht → het hoofdgerecht → het nagerecht, que en casa se llama het toetje.

🧠 Toetje viene de toe, encima o ademas: lo que va de propina despues de la comida.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el postre' AND notes = 'kim - eten: het toetje');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el postre' AND notes = 'kim - eten: het toetje' LIMIT 1), 'nl_NL', 'het toetje', 'het túutie', '• [can.] Als toetje eten we vla. — De postre comemos natillas.
• [vraag] Wat is het toetje vandaag? — ¿Qué hay de postre hoy?
• [perf.] De kinderen hebben hun toetje al op. — Los niños ya se han terminado el postre.
• [inv.] Na het eten krijg je een toetje. — Después de comer te dan postre.
• [bijzin] Je krijgt pas een toetje als je bord leeg is. — Solo tienes postre cuando hayas dejado el plato vacío.'
WHERE (SELECT id FROM words_es WHERE text = 'el postre' AND notes = 'kim - eten: het toetje' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el postre' AND notes = 'kim - eten: het toetje' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el postre' AND notes = 'kim - eten: het toetje' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el postre' AND notes = 'kim - eten: het toetje' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el postre' AND notes = 'kim - eten: het toetje' LIMIT 1) IS NOT NULL;

-- 2.25 de boterham
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la rebanada de pan, el sándwich', 'WORD', 'kim - eten: de boterham', 'de boterham = la rebanada de pan con algo encima, la comida del mediodia holandes — plural de boterhammen.

⚠️ No es un sandwich cerrado: es una rebanada con boter y algo encima, kaas, ham o hagelslag.
• een boterham met kaas — pan con queso.
• het broodje — el panecillo, el bocadillo de verdad.

🧠 Boter es mantequilla y ham, jamon: el pan con mantequilla y lo que haya encima.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la rebanada de pan, el sándwich' AND notes = 'kim - eten: de boterham');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'la rebanada de pan, el sándwich' AND notes = 'kim - eten: de boterham' LIMIT 1), 'nl_NL', 'de boterham', 'de bóoterham', '• [can.] Ik eet twee boterhammen met kaas bij de lunch. — Para comer me tomo dos rebanadas de pan con queso.
• [vraag] Wil je een boterham met pindakaas? — ¿Quieres pan con crema de cacahuete?
• [perf.] Ik heb mijn boterhammen thuis laten liggen. — Me he dejado los bocadillos en casa.
• [geb.] Smeer even een boterham voor je broertje. — Prepárale una rebanada de pan a tu hermanito.
• [uitdr.] Hij verdient er een goede boterham mee. — Se gana bien la vida con eso.'
WHERE (SELECT id FROM words_es WHERE text = 'la rebanada de pan, el sándwich' AND notes = 'kim - eten: de boterham' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la rebanada de pan, el sándwich' AND notes = 'kim - eten: de boterham' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'la rebanada de pan, el sándwich' AND notes = 'kim - eten: de boterham' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'la rebanada de pan, el sándwich' AND notes = 'kim - eten: de boterham' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'la rebanada de pan, el sándwich' AND notes = 'kim - eten: de boterham' LIMIT 1) IS NOT NULL;

-- 2.26 de patat, de friet
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las patatas fritas', 'WORD', 'kim - eten: de patat, de friet', 'de patat = las patatas fritas — en el norte de Holanda patat, en el sur y en Belgica friet o frietjes.

📌 Regla de bolsillo:
• ¿Estas en Amsterdam o el norte? → patat.
• ¿En Brabante, Limburgo o Belgica? → friet.
• ¿Con mayonesa? → patatje met, y con todo, patatje oorlog, la patata guerra.

⚠️ Las patatas fritas de bolsa no son patat: son chips.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'las patatas fritas' AND notes = 'kim - eten: de patat, de friet');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'las patatas fritas' AND notes = 'kim - eten: de patat, de friet' LIMIT 1), 'nl_NL', 'de patat, de friet', 'de patát, de friit', '• [can.] Op zaterdag eten we patat. — Los sábados comemos patatas fritas.
• [vraag] Wil je mayonaise op je friet? — ¿Quieres mayonesa en las patatas?
• [perf.] We hebben bij de snackbar patat gehaald. — Hemos comprado patatas fritas en la freiduría.
• [inv.] In België zeggen ze friet. — En Bélgica dicen friet.
• [uitdr.] Een patatje met, alstublieft. — Unas patatas con mayonesa, por favor.'
WHERE (SELECT id FROM words_es WHERE text = 'las patatas fritas' AND notes = 'kim - eten: de patat, de friet' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'las patatas fritas' AND notes = 'kim - eten: de patat, de friet' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'las patatas fritas' AND notes = 'kim - eten: de patat, de friet' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'las patatas fritas' AND notes = 'kim - eten: de patat, de friet' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'las patatas fritas' AND notes = 'kim - eten: de patat, de friet' LIMIT 1) IS NOT NULL;

-- 2.27 de stamppot
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el puré de patata con verdura', 'WORD', 'kim - eten: de stamppot', 'de stamppot = el pure de patata con verdura chafada, el plato del invierno holandes — plural de stamppotten.

• boerenkool stamppot — con col rizada, el mas tipico.
• hutspot — con zanahoria y cebolla.
• met een rookworst — con la salchicha ahumada, siempre.

🧠 Stampen es machacar y de pot, la olla: lo que se machaca en la olla.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el puré de patata con verdura' AND notes = 'kim - eten: de stamppot');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el puré de patata con verdura' AND notes = 'kim - eten: de stamppot' LIMIT 1), 'nl_NL', 'de stamppot', 'de stámpot', '• [can.] In de winter eten we vaak stamppot. — En invierno comemos stamppot a menudo.
• [vraag] Hoe maak je stamppot boerenkool? — ¿Cómo se hace el stamppot de col rizada?
• [perf.] Mijn schoonmoeder heeft stamppot met rookworst gemaakt. — Mi suegra ha hecho stamppot con salchicha ahumada.
• [inv.] Bij koud weer smaakt stamppot het best. — Con frío el stamppot sabe mejor.
• [bijzin] Hij zegt dat hij nog nooit stamppot heeft gegeten. — Dice que nunca ha comido stamppot.'
WHERE (SELECT id FROM words_es WHERE text = 'el puré de patata con verdura' AND notes = 'kim - eten: de stamppot' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el puré de patata con verdura' AND notes = 'kim - eten: de stamppot' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el puré de patata con verdura' AND notes = 'kim - eten: de stamppot' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el puré de patata con verdura' AND notes = 'kim - eten: de stamppot' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el puré de patata con verdura' AND notes = 'kim - eten: de stamppot' LIMIT 1) IS NOT NULL;

-- 2.28 de stroopwafel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el gofre holandés de sirope', 'WORD', 'kim - eten: de stroopwafel', 'de stroopwafel = el gofre fino relleno de sirope de caramelo — plural de stroopwafels.

🧠 De stroop es el sirope y de wafel, el gofre: se lee tal cual, gofre de sirope.
• Leg hem op je koffie — ponlo encima de la taza para que el vapor ablande el sirope.
• De stroopwafel komt uit Gouda.

💡 La de recien hecha del mercado se llama een verse stroopwafel.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el gofre holandés de sirope' AND notes = 'kim - eten: de stroopwafel');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el gofre holandés de sirope' AND notes = 'kim - eten: de stroopwafel' LIMIT 1), 'nl_NL', 'de stroopwafel', 'de stróopwaafel', '• [can.] Bij de koffie eet ik een stroopwafel. — Con el café me como un stroopwafel.
• [vraag] Heb je ooit een verse stroopwafel gegeten? — ¿Has comido alguna vez un stroopwafel recién hecho?
• [perf.] Ik heb stroopwafels voor mijn familie in Spanje gekocht. — He comprado stroopwafels para mi familia en España.
• [inv.] Op de markt verkopen ze verse stroopwafels. — En el mercado venden stroopwafels recién hechos.
• [geb.] Leg je stroopwafel even op je kopje. — Pon el stroopwafel encima de la taza.'
WHERE (SELECT id FROM words_es WHERE text = 'el gofre holandés de sirope' AND notes = 'kim - eten: de stroopwafel' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el gofre holandés de sirope' AND notes = 'kim - eten: de stroopwafel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el gofre holandés de sirope' AND notes = 'kim - eten: de stroopwafel' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el gofre holandés de sirope' AND notes = 'kim - eten: de stroopwafel' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el gofre holandés de sirope' AND notes = 'kim - eten: de stroopwafel' LIMIT 1) IS NOT NULL;

-- 2.29 de vegetariër
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el vegetariano', 'WORD', 'kim - eten: de vegetariër', 'de vegetariër = el vegetariano, la persona — plural de vegetariërs.

📌 Regla de bolsillo:
• ¿La persona? → de vegetariër.
• ¿El adjetivo, la comida? → vegetarisch, een vegetarische maaltijd.
• ¿Lo dices de ti? → Ik ben vegetariër, sin articulo, como las profesiones.

⚠️ La diéresis de ë marca que la i y la e se pronuncian separadas: ri-er.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el vegetariano' AND notes = 'kim - eten: de vegetariër');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el vegetariano' AND notes = 'kim - eten: de vegetariër' LIMIT 1), 'nl_NL', 'de vegetariër', 'de feejetaarí-er', '• [can.] Mijn zus is vegetariër. — Mi hermana es vegetariana.
• [vraag] Hebben jullie iets voor vegetariërs? — ¿Tenéis algo para vegetarianos?
• [perf.] Ik ben vorig jaar vegetariër geworden. — Me hice vegetariano el año pasado.
• [inv.] Als vegetariër eet ik geen vlees en geen vis. — Como vegetariano no como ni carne ni pescado.
• [bijzin] Ik wist niet dat hij vegetariër was. — No sabía que era vegetariano.'
WHERE (SELECT id FROM words_es WHERE text = 'el vegetariano' AND notes = 'kim - eten: de vegetariër' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el vegetariano' AND notes = 'kim - eten: de vegetariër' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el vegetariano' AND notes = 'kim - eten: de vegetariër' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el vegetariano' AND notes = 'kim - eten: de vegetariër' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el vegetariano' AND notes = 'kim - eten: de vegetariër' LIMIT 1) IS NOT NULL;

-- 2.30 de veganist
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el vegano', 'WORD', 'kim - eten: de veganist', 'de veganist = el vegano, la persona — plural de veganisten.

📌 Regla de bolsillo:
• ¿La persona? → de veganist.
• ¿El adjetivo? → veganistisch o vegan, een vegan burger.
• ¿Lo dices de ti? → Ik ben veganist, sin articulo.

🔑 El truco que casi nunca falla — las personas en -ist son de: de veganist, de toerist, de pianist.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el vegano' AND notes = 'kim - eten: de veganist');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT (SELECT id FROM words_es WHERE text = 'el vegano' AND notes = 'kim - eten: de veganist' LIMIT 1), 'nl_NL', 'de veganist', 'de feejanist', '• [can.] Mijn vriend is veganist. — Mi amigo es vegano.
• [vraag] Eet een veganist ook geen honing? — ¿Un vegano tampoco come miel?
• [perf.] Ze is twee jaar geleden veganist geworden. — Se hizo vegana hace dos años.
• [inv.] Als veganist eet hij geen kaas. — Como vegano no come queso.
• [bijzin] Het restaurant heeft een menu voor wie veganist is. — El restaurante tiene un menú para quien es vegano.'
WHERE (SELECT id FROM words_es WHERE text = 'el vegano' AND notes = 'kim - eten: de veganist' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el vegano' AND notes = 'kim - eten: de veganist' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - eten')
WHERE (SELECT id FROM words_es WHERE text = 'el vegano' AND notes = 'kim - eten: de veganist' LIMIT 1) IS NOT NULL;

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT (SELECT id FROM words_es WHERE text = 'el vegano' AND notes = 'kim - eten: de veganist' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic')
WHERE (SELECT id FROM words_es WHERE text = 'el vegano' AND notes = 'kim - eten: de veganist' LIMIT 1) IS NOT NULL;

-- =============================================================================
-- 3. Enlaces a tarjetas de kim - boodschappen (si aun no existen, no inserta nada)
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT l.word_es_id, (SELECT id FROM word_groups WHERE title = 'kim - eten')
FROM words_lang l JOIN words_es e ON e.id = l.word_es_id
WHERE l.lang_code = 'nl_NL' AND l.text = 'het vlees' AND e.word_type = 'WORD';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT l.word_es_id, (SELECT id FROM word_groups WHERE title = 'kim - eten')
FROM words_lang l JOIN words_es e ON e.id = l.word_es_id
WHERE l.lang_code = 'nl_NL' AND l.text = 'het brood' AND e.word_type = 'WORD';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT l.word_es_id, (SELECT id FROM word_groups WHERE title = 'kim - eten')
FROM words_lang l JOIN words_es e ON e.id = l.word_es_id
WHERE l.lang_code = 'nl_NL' AND l.text = 'de boter' AND e.word_type = 'WORD';
