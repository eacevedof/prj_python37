-- Learn Languages App - Migration
-- Migration: 20261020000002-grupo-11-dentro-fuera-arriba-abajo
-- Description: Eduardo: "crea grupo con frases habladas muy comunes con: hacia adentro, hacia fuera,
--   hacia atras, hacia adelante, adelante, dentro (indoors), abajo (below), debajo de (beneath),
--   hacia arriba (upwards), revisa si no tenemos algun grupo parecido para extenderlo".
--
--   Existia el grupo 11 «bewegingen-richtingen» (22 tarjetas, del video de Kim): solo palabras
--   sueltas y ninguna frase. Tenia omhoog (244), vooruit (250) y achteruit (251), pero no binnen /
--   buiten, naar binnen / naar buiten, boven / beneden, onder ni naar voren / naar achteren. No se
--   crea otro grupo: se amplia el 11 y su descripcion. El titulo no cambia.
--
--   1. 14 tarjetas madre PHRASE nuevas con sus 5 frases en notes: binnen, buiten, naar binnen,
--      naar buiten, boven, beneden, naar boven, naar beneden, onder, onderaan, naar voren,
--      naar achteren, achterom kijken y ga je gang. La de binnen lleva la ficha de binnenkomen.
--   2. 35 frases SENTENCE habladas, colgadas de su madre con EXAMPLE (tambien de 244, 250 y 251).
--      Marcas: (inv) en 2, (presente) en 1, (el) en 1.
--   3. Bloque compartido «🛗 Dentro, fuera, arriba y abajo» en las 49 nuevas y en 244, 245, 250 y
--      251: tabla de 15 formas, el truco de estar o ir (naar), regla de bolsillo de los pisos, los
--      tres «¡adelante!» (Kom binnen / Ga je gang / Vooruit) y cuatro trampas.
--   4. Tres bloques 🧩 de expresion fija nuevos: ga je gang, het gaat achteruit met, onder nul.
--
--   5. Se suman al grupo, sin bloque, 476 (Kom maar binnen!), 911 (We gaan even naar buiten), 1072
--      (De kinderen zijn buiten aan het spelen) y 1115 (Ik stond onder de douche).
--
--   «¡Adelante, pasa!» no se crea: ya existe la 476. Tarjetas nuevas sin audio.

PRAGMA foreign_keys = ON;

UPDATE word_groups
SET description = 'Adverbios de movimiento y direccion (B1/B2): doorheen, omheen, overheen, binnendoor, onderdoor, tussendoor, rechtdoor, ervandoor, omhoog/omlaag, op/af, linksaf/rechtsaf, vooruit/achteruit y familia -langs. Y desde 2026-10-20 estar o ir: binnen/naar binnen, buiten/naar buiten, boven/naar boven, beneden/naar beneden, onder/eronder/onderaan, naar voren/naar achteren, achterom y ga je gang, con frases habladas.',
    updated_at = datetime('now')
WHERE title = 'bewegingen-richtingen';


-- 1) Tarjetas madre

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'dentro, bajo techo', 'PHRASE', 'dirección: binnen = dentro (estar)', 'BINNEN = dentro, ESTAR bajo techo: sin movimiento, sin naar. We blijven binnen = nos quedamos dentro.

📐 Conjugacion de binnenkomen (fuerte · separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | kom binnen | kwam binnen |
| jij / je | komt binnen | kwam binnen |
| u | komt binnen | kwam binnen |
| hij / zij / het | komt binnen | kwam binnen |
| wij | komen binnen | kwamen binnen |
| jullie | komen binnen | kwamen binnen |
| zij (plural) | komen binnen | kwamen binnen |

• participio — binnengekomen, con zijn y con el ge- DENTRO, porque binnen- es partícula separable: Hij is net binnengekomen.
• al invertir, jij pierde la -t: Kom jij ook binnen? — no «komt jij».
• preposicion — no rige preposición fija. El sitio va delante de la partícula: Hij kwam de kamer binnen.
• antónimo — naar buiten gaan (o buitengaan), salir. Lo tienes como tarjeta: hacia fuera.
• sustantivo — de binnenkomst, la entrada o la llegada.
• expresión hecha — Dat kwam hard binnen = eso me llegó al alma.

| dónde | qué pasa | ejemplo |
|---|---|---|
| principal | la partícula se va **al final** | Hij **komt** de kamer **binnen**. |
| perfecto | el `ge-` se cuela **dentro** | Hij is **binnengekomen**. |
| subordinada | las piezas **se reúnen** | … omdat hij net **binnenkomt**. |
| con `te` | el `te` va **en medio** | Hij probeert **binnen te komen**. |

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'dentro, bajo techo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'dentro, bajo techo' LIMIT 1), 'nl_NL', 'binnen', 'bínen', '• [can.] We blijven vandaag binnen. — Hoy nos quedamos dentro.
• [perf.] Ik heb de hele dag binnen gezeten. — He estado todo el día dentro.
• [inv.] Binnen is het lekker warm. — Dentro se está calentito.
• [geb.] Kom binnen! — ¡Adelante, pasa!
• [bijzin] Ik weet niet of hij al binnen is. — No sé si ya está dentro.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'dentro, bajo techo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'dentro, bajo techo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'fuera, al aire libre', 'PHRASE', 'dirección: buiten = fuera (estar)', 'BUITEN = fuera, ESTAR al aire libre: sin movimiento, sin naar. De kinderen spelen buiten = los niños juegan fuera.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'fuera, al aire libre');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'fuera, al aire libre' LIMIT 1), 'nl_NL', 'buiten', 'bóiten', '• [can.] De kinderen spelen buiten. — Los niños juegan fuera.
• [perf.] We hebben buiten gegeten. — Hemos comido fuera, al aire libre.
• [inv.] Buiten is het koud. — Fuera hace frío.
• [vraag] Zit je buiten? — ¿Estás sentado fuera?
• [bijzin] Neem een jas mee, omdat het buiten koud is. — Llévate abrigo, porque fuera hace frío.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'fuera, al aire libre' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'fuera, al aire libre' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hacia dentro', 'PHRASE', 'dirección: naar binnen = hacia dentro (ir)', 'NAAR BINNEN = hacia dentro, IR: entrar o meter algo. Lleva naar porque hay movimiento hacia el sitio.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hacia dentro');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia dentro' LIMIT 1), 'nl_NL', 'naar binnen', 'naar bínen', '• [can.] We gaan naar binnen. — Entramos.
• [perf.] Ze is naar binnen gerend. — Ha entrado corriendo.
• [geb.] Breng de stoelen naar binnen. — Mete las sillas para dentro.
• [inv.] Door het raam kijkt hij naar binnen. — Por la ventana mira hacia dentro.
• [bijzin] Ik zag dat hij naar binnen ging. — Vi que entraba.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia dentro' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia dentro' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hacia fuera', 'PHRASE', 'dirección: naar buiten = hacia fuera (ir)', 'NAAR BUITEN = hacia fuera, IR: salir o mirar afuera. Es el antónimo de binnenkomen: naar buiten gaan = salir.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hacia fuera');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia fuera' LIMIT 1), 'nl_NL', 'naar buiten', 'naar bóiten', '• [can.] Ik ga even naar buiten. — Salgo un momento.
• [perf.] De hond is naar buiten gelopen. — El perro se ha salido.
• [geb.] Kijk naar buiten! — ¡Mira afuera!
• [vraag] Gaan jullie naar buiten? — ¿Salís?
• [bijzin] Als het droog is, gaan we naar buiten. — Si no llueve, salimos.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia fuera' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia fuera' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'arriba, en el piso de arriba', 'PHRASE', 'dirección: boven = arriba (estar)', 'BOVEN = arriba, ESTAR en el piso de arriba. Sin movimiento: Mijn kamer is boven.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'arriba, en el piso de arriba');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'arriba, en el piso de arriba' LIMIT 1), 'nl_NL', 'boven', 'bófen', '• [can.] Mijn kamer is boven. — Mi habitación está arriba.
• [vraag] Is er iemand boven? — ¿Hay alguien arriba?
• [perf.] Hij heeft de hele avond boven gezeten. — Ha estado toda la tarde arriba.
• [inv.] Boven is de badkamer. — Arriba está el baño.
• [uitdr.] de bovenburen — los vecinos de arriba.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'arriba, en el piso de arriba' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'arriba, en el piso de arriba' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'abajo, en el piso de abajo', 'PHRASE', 'dirección: beneden = abajo (estar)', 'BENEDEN = abajo, ESTAR en el piso de abajo o en la planta baja. En un edificio es beneden, no onder.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'abajo, en el piso de abajo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'abajo, en el piso de abajo' LIMIT 1), 'nl_NL', 'beneden', 'benéden', '• [can.] Ik wacht beneden op je. — Te espero abajo.
• [vraag] Is de keuken beneden? — ¿La cocina está abajo?
• [perf.] Ik heb beneden geslapen. — He dormido abajo.
• [inv.] Beneden woont een oude man. — Abajo vive un señor mayor.
• [uitdr.] de benedenburen — los vecinos de abajo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'abajo, en el piso de abajo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'abajo, en el piso de abajo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'al piso de arriba', 'PHRASE', 'dirección: naar boven = subir de piso (ir)', 'NAAR BOVEN = al piso de arriba, IR: subir. Para la dirección vertical sin pisos (mirar, manos, precios) se usa omhoog.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'al piso de arriba');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'al piso de arriba' LIMIT 1), 'nl_NL', 'naar boven', 'naar bófen', '• [can.] Ik ga naar boven. — Me subo.
• [geb.] Breng de koffers naar boven. — Sube las maletas arriba.
• [perf.] Ze is naar boven gegaan. — Se ha ido arriba.
• [bijzin] Ik hoorde dat hij naar boven liep. — Oí que subía.
• [vraag] Kom je naar boven? — ¿Subes?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'al piso de arriba' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'al piso de arriba' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'al piso de abajo', 'PHRASE', 'dirección: naar beneden = bajar de piso (ir)', 'NAAR BENEDEN = al piso de abajo, IR: bajar. Es lo que gritas desde arriba: Ik kom zo naar beneden!

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'al piso de abajo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'al piso de abajo' LIMIT 1), 'nl_NL', 'naar beneden', 'naar benéden', '• [can.] Ik kom zo naar beneden. — Ahora bajo.
• [geb.] Kom naar beneden, het eten is klaar. — Baja, que la cena está lista.
• [perf.] De kat is naar beneden gesprongen. — El gato ha saltado abajo.
• [vraag] Ga je naar beneden? — ¿Bajas?
• [bijzin] Bel me als je naar beneden komt. — Llámame cuando bajes.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'al piso de abajo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'al piso de abajo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'debajo de', 'PHRASE', 'dirección: onder = debajo de (+ sustantivo)', 'ONDER = debajo de, y siempre pide algo detrás: onder de tafel, onder ons. Si ya se sabe de qué, eronder.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'debajo de');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'debajo de' LIMIT 1), 'nl_NL', 'onder', 'ónder', '• [can.] De kat zit onder het bed. — El gato está debajo de la cama.
• [imperf.] De sleutels lagen onder het kussen. — Las llaves estaban debajo del cojín.
• [vraag] Heb je eronder gekeken? — ¿Has mirado debajo?
• [inv.] Onder de brug staat water. — Debajo del puente hay agua.
• [uitdr.] vijf graden onder nul — cinco grados bajo cero.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'debajo de' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'debajo de' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'abajo del todo', 'PHRASE', 'dirección: onderaan = abajo del todo', 'ONDERAAN = abajo del todo de una página, una lista o un formulario. Su pareja es bovenaan, arriba del todo.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'abajo del todo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'abajo del todo' LIMIT 1), 'nl_NL', 'onderaan', 'onderáan', '• [can.] Uw naam staat onderaan. — Su nombre está abajo del todo.
• [geb.] Zet uw handtekening onderaan. — Firme abajo del todo.
• [perf.] Ik heb het onderaan de brief gezet. — Lo he puesto al final de la carta.
• [vraag] Staat het bovenaan of onderaan? — ¿Está arriba del todo o abajo del todo?
• [uitdr.] onderaan de ladder — en lo más bajo del escalafón.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'abajo del todo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'abajo del todo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hacia la parte de delante', 'PHRASE', 'dirección: naar voren = al frente', 'NAAR VOREN = hacia la parte de delante de un sitio: al frente de la clase, del escenario, de la fila. vooruit es avanzar en la dirección en que miras.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hacia la parte de delante');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia la parte de delante' LIMIT 1), 'nl_NL', 'naar voren', 'naar fóren', '• [geb.] Doe een stap naar voren. — Da un paso al frente.
• [can.] Hij komt naar voren. — Sale al frente.
• [perf.] Ze is naar voren gelopen. — Ha ido hacia delante.
• [geb.] Ga wat verder naar voren zitten. — Siéntate más adelante.
• [uitdr.] iets naar voren brengen — plantear algo, sacarlo a relucir.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia la parte de delante' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia la parte de delante' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hacia la parte de atrás', 'PHRASE', 'dirección: naar achteren = al fondo', 'NAAR ACHTEREN = hacia la parte de atrás de un sitio o hacia atrás con el cuerpo. achteruit es recular, ir marcha atrás.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hacia la parte de atrás');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia la parte de atrás' LIMIT 1), 'nl_NL', 'naar achteren', 'naar ájteren', '• [geb.] Ga een beetje naar achteren. — Échate un poco hacia atrás.
• [can.] Hij leunt naar achteren. — Se echa hacia atrás.
• [perf.] Hij is naar achteren gelopen. — Se ha ido al fondo.
• [vraag] Kun je je stoel naar achteren zetten? — ¿Puedes echar tu silla para atrás?
• [bijzin] Ik zag dat ze naar achteren viel. — Vi que se caía hacia atrás.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia la parte de atrás' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia la parte de atrás' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'mirar atrás', 'PHRASE', 'dirección: achterom kijken = mirar atrás', 'ACHTEROM KIJKEN = mirar atrás girando la cabeza. kijken es transitivo directo y no rige preposición; achterom es la dirección.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'mirar atrás');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'mirar atrás' LIMIT 1), 'nl_NL', 'achterom kijken', 'ájterom kéiken', '• [geb.] Kijk niet achterom. — No mires atrás.
• [can.] Hij kijkt steeds achterom. — No para de mirar atrás.
• [perf.] Ik heb nooit achterom gekeken. — Nunca he mirado atrás.
• [bijzin] Ze liep weg zonder achterom te kijken. — Se fue sin mirar atrás.
• [uitdr.] achterom lopen — ir por la parte de atrás de la casa.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'mirar atrás' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'mirar atrás' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'adelante, hazlo', 'PHRASE', 'dirección: ga je gang = adelante (permiso)', 'GA JE GANG = adelante, tú mismo: el «¡adelante!» que da permiso.

🧩 Expresión fija — ga je gang:

• literal — «ve tu camino»: de gang es aquí la marcha, el paso, no el pasillo.
• significa — adelante, tú mismo, hazlo. Sirve para dar permiso.
• piezas fijas — ga + je + gang, sin artículo. Con u cambia el posesivo, Gaat u uw gang.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | con jij | Mag ik even bellen? — Ga je gang. | ¿Puedo llamar un momento? —Adelante. |
| 2 | con u | Gaat u gerust uw gang. | Adelante, con toda confianza. |
| 3 | con gerust | Ga gerust je gang, ik vind het niet erg. | Adelante, de verdad, no me importa. |

• falso amigo — de gang suelto es el pasillo: Hij staat in de gang = está en el pasillo.

🔑 El truco que casi nunca falla: Si el «adelante» da permiso es Ga je gang, y si mete prisa es Vooruit.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'adelante, hazlo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'adelante, hazlo' LIMIT 1), 'nl_NL', 'ga je gang', 'ja ie jang', '• [geb.] Ga je gang! — ¡Adelante!
• [geb.] Gaat u gerust uw gang. — Adelante, con toda confianza.
• [vraag] Mag ik? — Ga je gang. — ¿Puedo? —Adelante.
• [geb.] Ga gerust je gang, ik vind het niet erg. — Adelante, de verdad, no me importa.
• [bijzin] Als je wilt koken, ga je gang. — Si quieres cocinar, adelante.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'adelante, hazlo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'adelante, hazlo' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));


-- 2) Frases habladas

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Vamos dentro, que empieza a llover.', 'SENTENCE', 'Ejemplo de "naar binnen" (can.)', 'NAAR BINNEN GAAN = entrar: hay movimiento hacia dentro, así que lleva naar. Laten we … = vamos a, la propuesta.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Vamos dentro, que empieza a llover.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Vamos dentro, que empieza a llover.' LIMIT 1), 'nl_NL', 'Laten we naar binnen gaan, het begint te regenen.', 'láten ue naar bínen jaan, et bejínt te réjenen');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vamos dentro, que empieza a llover.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Vamos dentro, que empieza a llover.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia dentro' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Vamos dentro, que empieza a llover.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Mete la bici para dentro.', 'SENTENCE', 'Ejemplo de "naar binnen" (geb.)', 'NAAR BINNEN con brengen = meter algo para dentro. Llevar algo a otro sitio es brengen, no nemen.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mete la bici para dentro.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mete la bici para dentro.' LIMIT 1), 'nl_NL', 'Breng de fiets naar binnen.', 'breng de fiits naar bínen');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mete la bici para dentro.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mete la bici para dentro.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia dentro' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Mete la bici para dentro.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'El vecino mira hacia dentro por la ventana.', 'SENTENCE', 'Ejemplo de "naar binnen" (can.)', 'NAAR BINNEN KIJKEN = mirar hacia dentro. La mirada también es dirección, así que lleva naar. door het raam = por la ventana.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El vecino mira hacia dentro por la ventana.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El vecino mira hacia dentro por la ventana.' LIMIT 1), 'nl_NL', 'De buurman kijkt door het raam naar binnen.', 'de búurman kéikt dor et raam naar bínen');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El vecino mira hacia dentro por la ventana.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El vecino mira hacia dentro por la ventana.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia dentro' LIMIT 1), (SELECT id FROM words_es WHERE text = 'El vecino mira hacia dentro por la ventana.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Mira afuera, está nevando!', 'SENTENCE', 'Ejemplo de "naar buiten" (geb.)', 'NAAR BUITEN KIJKEN = mirar afuera, hacia fuera. Y «está nevando» es un presente simple: het sneeuwt.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Mira afuera, está nevando!');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡Mira afuera, está nevando!' LIMIT 1), 'nl_NL', 'Kijk naar buiten, het sneeuwt!', 'kéik naar bóiten, et snéut');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Mira afuera, está nevando!' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Mira afuera, está nevando!' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia fuera' LIMIT 1), (SELECT id FROM words_es WHERE text = '¡Mira afuera, está nevando!' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'La puerta se abre hacia fuera.', 'SENTENCE', 'Ejemplo de "naar buiten" (can.)', 'NAAR BUITEN = hacia fuera. opengaan es separable: la partícula open se va al final, De deur gaat naar buiten open.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'La puerta se abre hacia fuera.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'La puerta se abre hacia fuera.' LIMIT 1), 'nl_NL', 'De deur gaat naar buiten open.', 'de dör jaat naar bóiten ópen');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'La puerta se abre hacia fuera.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'La puerta se abre hacia fuera.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia fuera' LIMIT 1), (SELECT id FROM words_es WHERE text = 'La puerta se abre hacia fuera.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Todos fuera!', 'SENTENCE', 'Ejemplo de "naar buiten" (geb.)', 'NAAR BUITEN sin verbo = ¡fuera!, la orden de salir. iedereen = todos, todo el mundo.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Todos fuera!');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡Todos fuera!' LIMIT 1), 'nl_NL', 'Iedereen naar buiten!', 'íidereen naar bóiten');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Todos fuera!' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Todos fuera!' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia fuera' LIMIT 1), (SELECT id FROM words_es WHERE text = '¡Todos fuera!' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Hoy nos quedamos dentro, hace mucho frío. (inv)', 'SENTENCE', 'Ejemplo de "binnen" (inv.)', 'BINNEN BLIJVEN = quedarse dentro: no hay movimiento, así que va sin naar. (inv) porque abre con vandaag.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Hoy nos quedamos dentro, hace mucho frío. (inv)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Hoy nos quedamos dentro, hace mucho frío. (inv)' LIMIT 1), 'nl_NL', 'Vandaag blijven we binnen, het is erg koud.', 'fandáaj bléifen ue bínen, et is erj kaut');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hoy nos quedamos dentro, hace mucho frío. (inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hoy nos quedamos dentro, hace mucho frío. (inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'dentro, bajo techo' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Hoy nos quedamos dentro, hace mucho frío. (inv)' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Aquí dentro no se puede fumar. (inv)', 'SENTENCE', 'Ejemplo de "binnen" (inv.)', 'HIER BINNEN = aquí dentro, ESTAR. El «se puede» impersonal es mag je o mag men. (inv) porque abre con hier binnen.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Aquí dentro no se puede fumar. (inv)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí dentro no se puede fumar. (inv)' LIMIT 1), 'nl_NL', 'Hier binnen mag je niet roken.', 'hiir bínen maj ie niit róken');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí dentro no se puede fumar. (inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Aquí dentro no se puede fumar. (inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'dentro, bajo techo' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Aquí dentro no se puede fumar. (inv)' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Está dentro, en la cocina. (él)', 'SENTENCE', 'Ejemplo de "binnen" (can.)', 'BINNEN = dentro, ESTAR. Con zijn no hay movimiento, así que nunca lleva naar.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Está dentro, en la cocina. (él)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Está dentro, en la cocina. (él)' LIMIT 1), 'nl_NL', 'Hij is binnen, in de keuken.', 'hei is bínen, in de kóken');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Está dentro, en la cocina. (él)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Está dentro, en la cocina. (él)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'dentro, bajo techo' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Está dentro, en la cocina. (él)' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Cenamos fuera, en el jardín. (presente)', 'SENTENCE', 'Ejemplo de "buiten" (can.)', 'BUITEN ETEN = comer al aire libre. Ojo, «salir a cenar fuera» a un restaurante es uit eten gaan.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cenamos fuera, en el jardín. (presente)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cenamos fuera, en el jardín. (presente)' LIMIT 1), 'nl_NL', 'We eten buiten, in de tuin.', 'ue éten bóiten, in de tóin');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cenamos fuera, en el jardín. (presente)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cenamos fuera, en el jardín. (presente)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'fuera, al aire libre' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Cenamos fuera, en el jardín. (presente)' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Hace buen tiempo, vamos a sentarnos fuera.', 'SENTENCE', 'Ejemplo de "buiten" (can.)', 'BUITEN GAAN ZITTEN = sentarse fuera. Va sin naar porque buiten dice dónde te sientas, no hacia dónde vas.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Hace buen tiempo, vamos a sentarnos fuera.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Hace buen tiempo, vamos a sentarnos fuera.' LIMIT 1), 'nl_NL', 'Het is mooi weer, laten we buiten gaan zitten.', 'et is mói ueer, láten ue bóiten jaan síten');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hace buen tiempo, vamos a sentarnos fuera.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Hace buen tiempo, vamos a sentarnos fuera.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'fuera, al aire libre' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Hace buen tiempo, vamos a sentarnos fuera.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Mi habitación está arriba.', 'SENTENCE', 'Ejemplo de "boven" (can.)', 'BOVEN = arriba, en el piso de arriba. ESTAR, sin movimiento.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mi habitación está arriba.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi habitación está arriba.' LIMIT 1), 'nl_NL', 'Mijn kamer is boven.', 'méin kámer is bófen');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi habitación está arriba.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mi habitación está arriba.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'arriba, en el piso de arriba' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Mi habitación está arriba.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Hay alguien arriba?', 'SENTENCE', 'Ejemplo de "boven" (vraag)', 'BOVEN = arriba, ESTAR. «Hay alguien» es is er iemand, con er de relleno.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Hay alguien arriba?');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Hay alguien arriba?' LIMIT 1), 'nl_NL', 'Is er iemand boven?', 'is er íimand bófen');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Hay alguien arriba?' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Hay alguien arriba?' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'arriba, en el piso de arriba' LIMIT 1), (SELECT id FROM words_es WHERE text = '¿Hay alguien arriba?' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Te espero abajo.', 'SENTENCE', 'Ejemplo de "beneden" (can.)', 'BENEDEN = abajo, ESTAR. wachten rige op: wachten op iemand = esperar a alguien, y op je va al final.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Te espero abajo.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Te espero abajo.' LIMIT 1), 'nl_NL', 'Ik wacht beneden op je.', 'ik uajt benéden op ie');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Te espero abajo.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Te espero abajo.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'abajo, en el piso de abajo' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Te espero abajo.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Los vecinos de abajo hacen mucho ruido.', 'SENTENCE', 'Ejemplo de "beneden" (can.)', 'DE BENEDENBUREN = los vecinos de abajo, en una sola palabra. Los de arriba son de bovenburen. Y el ruido es het lawaai.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los vecinos de abajo hacen mucho ruido.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Los vecinos de abajo hacen mucho ruido.' LIMIT 1), 'nl_NL', 'De benedenburen maken veel lawaai.', 'de benédenbüren máken feel laúai');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Los vecinos de abajo hacen mucho ruido.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Los vecinos de abajo hacen mucho ruido.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'abajo, en el piso de abajo' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Los vecinos de abajo hacen mucho ruido.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Sube las maletas arriba.', 'SENTENCE', 'Ejemplo de "naar boven" (geb.)', 'NAAR BOVEN = al piso de arriba, IR. Con cosas, brengen: Breng de koffers naar boven.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Sube las maletas arriba.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Sube las maletas arriba.' LIMIT 1), 'nl_NL', 'Breng de koffers naar boven.', 'breng de kófers naar bófen');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Sube las maletas arriba.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Sube las maletas arriba.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'al piso de arriba' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Sube las maletas arriba.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me voy arriba a dormir.', 'SENTENCE', 'Ejemplo de "naar boven" (can.)', 'NAAR BOVEN GAAN = subir de piso. El «a dormir» de finalidad es om te slapen.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me voy arriba a dormir.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me voy arriba a dormir.' LIMIT 1), 'nl_NL', 'Ik ga naar boven om te slapen.', 'ik ja naar bófen om te slápen');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me voy arriba a dormir.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me voy arriba a dormir.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'al piso de arriba' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Me voy arriba a dormir.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Ahora bajo!', 'SENTENCE', 'Ejemplo de "naar beneden" (can.)', 'NAAR BENEDEN KOMEN = bajar, cuando vas hacia donde está quien te llama. zo = ahora mismo, enseguida.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Ahora bajo!');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡Ahora bajo!' LIMIT 1), 'nl_NL', 'Ik kom zo naar beneden!', 'ik kom so naar benéden');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Ahora bajo!' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Ahora bajo!' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'al piso de abajo' LIMIT 1), (SELECT id FROM words_es WHERE text = '¡Ahora bajo!' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Baja, que la cena está lista.', 'SENTENCE', 'Ejemplo de "naar beneden" (geb.)', 'NAAR BENEDEN KOMEN = bajar hacia quien te llama, por eso komen y no gaan. het eten = la comida o la cena.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Baja, que la cena está lista.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Baja, que la cena está lista.' LIMIT 1), 'nl_NL', 'Kom naar beneden, het eten is klaar.', 'kom naar benéden, et éten is klaar');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Baja, que la cena está lista.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Baja, que la cena está lista.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'al piso de abajo' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Baja, que la cena está lista.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'El gato está debajo de la cama.', 'SENTENCE', 'Ejemplo de "onder" (can.)', 'ONDER = debajo de, con el sitio detrás. Y el gato zit, no is: el neerlandés dice cómo está.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El gato está debajo de la cama.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El gato está debajo de la cama.' LIMIT 1), 'nl_NL', 'De kat zit onder het bed.', 'de kat sit ónder et bet');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El gato está debajo de la cama.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El gato está debajo de la cama.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'debajo de' LIMIT 1), (SELECT id FROM words_es WHERE text = 'El gato está debajo de la cama.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Las llaves estaban debajo del cojín.', 'SENTENCE', 'Ejemplo de "onder" (imperf.)', 'ONDER = debajo de. Las cosas planas o tumbadas liggen, así que estaban es lagen. het kussen = el cojín o la almohada.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Las llaves estaban debajo del cojín.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Las llaves estaban debajo del cojín.' LIMIT 1), 'nl_NL', 'De sleutels lagen onder het kussen.', 'de slótels lájen ónder et kúsen');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Las llaves estaban debajo del cojín.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Las llaves estaban debajo del cojín.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'debajo de' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Las llaves estaban debajo del cojín.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Has mirado debajo?', 'SENTENCE', 'Ejemplo de "onder" (vraag)', 'ERONDER = debajo, cuando ya se sabe de qué. onder no se queda solo: o lleva algo detrás o se vuelve eronder.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Has mirado debajo?');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has mirado debajo?' LIMIT 1), 'nl_NL', 'Heb je eronder gekeken?', 'hep ie erónder jekéken');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has mirado debajo?' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Has mirado debajo?' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'debajo de' LIMIT 1), (SELECT id FROM words_es WHERE text = '¿Has mirado debajo?' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Estamos a cinco grados bajo cero.', 'SENTENCE', 'Ejemplo de "onder" (can.)', 'ONDER NUL = bajo cero. El «estamos a» del tiempo es het is.

🧩 Expresión fija — onder nul:

• literal — «debajo de cero».
• significa — bajo cero, temperaturas negativas. El contrario es boven nul.
• piezas fijas — graden onder nul, sin artículo, y el sujeto es het. Het is vijf graden onder nul.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | presente | Het is vijf graden onder nul. | Estamos a cinco grados bajo cero. |
| 2 | imperfecto | Vannacht was het tien graden onder nul. | Anoche estuvimos a diez bajo cero. |
| 3 | el contrario | Het is twee graden boven nul. | Estamos a dos grados sobre cero. |
| 4 | al hablar | Morgen wordt het min drie. | Mañana estaremos a menos tres. |

🔑 El truco que casi nunca falla: El «estamos a» del tiempo se dice het is, sin nosotros y sin a.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Estamos a cinco grados bajo cero.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Estamos a cinco grados bajo cero.' LIMIT 1), 'nl_NL', 'Het is vijf graden onder nul.', 'et is féif jráden ónder nul');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estamos a cinco grados bajo cero.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Estamos a cinco grados bajo cero.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'debajo de' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Estamos a cinco grados bajo cero.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Firme abajo del todo.', 'SENTENCE', 'Ejemplo de "onderaan" (geb.)', 'ONDERAAN = abajo del todo de la hoja. Firmar es je handtekening zetten, y con usted el posesivo es uw.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Firme abajo del todo.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Firme abajo del todo.' LIMIT 1), 'nl_NL', 'Zet uw handtekening onderaan.', 'set uu hándtekening onderáan');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Firme abajo del todo.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Firme abajo del todo.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'abajo del todo' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Firme abajo del todo.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Da un paso al frente.', 'SENTENCE', 'Ejemplo de "naar voren" (geb.)', 'NAAR VOREN = al frente, hacia la parte de delante. een stap doen = dar un paso.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Da un paso al frente.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Da un paso al frente.' LIMIT 1), 'nl_NL', 'Doe een stap naar voren.', 'du en stap naar fóren');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Da un paso al frente.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Da un paso al frente.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia la parte de delante' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Da un paso al frente.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Siéntate más adelante, que lo ves mejor.', 'SENTENCE', 'Ejemplo de "naar voren" (geb.)', 'NAAR VOREN GAAN ZITTEN = sentarse más adelante, más cerca del frente. dan zie je het beter = así lo ves mejor.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Siéntate más adelante, que lo ves mejor.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Siéntate más adelante, que lo ves mejor.' LIMIT 1), 'nl_NL', 'Ga wat verder naar voren zitten, dan zie je het beter.', 'ja uat férder naar fóren síten, dan sii ie et béter');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Siéntate más adelante, que lo ves mejor.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Siéntate más adelante, que lo ves mejor.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia la parte de delante' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Siéntate más adelante, que lo ves mejor.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Échate un poco hacia atrás.', 'SENTENCE', 'Ejemplo de "naar achteren" (geb.)', 'NAAR ACHTEREN = hacia atrás con el cuerpo. een beetje = un poco, la cantidad pequeña.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Échate un poco hacia atrás.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Échate un poco hacia atrás.' LIMIT 1), 'nl_NL', 'Ga een beetje naar achteren.', 'ja en béitie naar ájteren');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Échate un poco hacia atrás.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Échate un poco hacia atrás.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'hacia la parte de atrás' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Échate un poco hacia atrás.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Esto es un gran paso adelante.', 'SENTENCE', 'Ejemplo de "vooruit" (can.)', 'EEN STAP VOORUIT = un paso adelante en figurado, un progreso. Para el paso físico al frente se dice een stap naar voren.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Esto es un gran paso adelante.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Esto es un gran paso adelante.' LIMIT 1), 'nl_NL', 'Dit is een grote stap vooruit.', 'dit is en jróte stap foróit');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esto es un gran paso adelante.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Esto es un gran paso adelante.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES (250, (SELECT id FROM words_es WHERE text = 'Esto es un gran paso adelante.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Adelante, que ya vamos tarde!', 'SENTENCE', 'Ejemplo de "vooruit" (geb.)', 'VOORUIT! = ¡venga, adelante!, para meter prisa o dar ánimos. «vamos tarde» es we zijn laat.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Adelante, que ya vamos tarde!');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡Adelante, que ya vamos tarde!' LIMIT 1), 'nl_NL', 'Vooruit, we zijn al laat!', 'foróit, ue séin al laat');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Adelante, que ya vamos tarde!' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Adelante, que ya vamos tarde!' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES (250, (SELECT id FROM words_es WHERE text = '¡Adelante, que ya vamos tarde!' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Da marcha atrás un poco, que viene un coche.', 'SENTENCE', 'Ejemplo de "achteruit" (geb.)', 'ACHTERUIT RIJDEN = dar marcha atrás. een stukje = un poco de distancia, un trocito.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Da marcha atrás un poco, que viene un coche.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Da marcha atrás un poco, que viene un coche.' LIMIT 1), 'nl_NL', 'Rij een stukje achteruit, er komt een auto.', 'rei en stúkie ajteróit, er komt en áuto');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Da marcha atrás un poco, que viene un coche.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Da marcha atrás un poco, que viene un coche.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES (251, (SELECT id FROM words_es WHERE text = 'Da marcha atrás un poco, que viene un coche.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'La tienda va a menos.', 'SENTENCE', 'Ejemplo de "achteruit" (can.)', 'ACHTERUITGAAN = ir a menos, empeorar: el negocio recula como un coche. También se dice Het gaat achteruit met de winkel.

🧩 Expresión fija — het gaat achteruit met iets:

• literal — «va hacia atrás con algo».
• significa — algo va a menos, empeora. El contrario es het gaat vooruit met.
• piezas fijas — het vacío como sujeto, el verbo gaan, achteruit y al final met + lo que empeora.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | presente | Het gaat achteruit met de winkel. | La tienda va a menos. |
| 2 | perfecto, con zijn | Het is achteruitgegaan met zijn gezondheid. | Su salud ha empeorado. |
| 3 | sin het ni met | Zijn gezondheid gaat achteruit. | Su salud va a peor. |
| 4 | el contrario | Het gaat vooruit met het project. | El proyecto avanza. |

• variante — también vale con sujeto directo, sin het ni met: De winkel gaat achteruit.

🔑 El truco que casi nunca falla: Si en español algo «va a menos», piensa en un coche que recula, achteruit.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'La tienda va a menos.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'La tienda va a menos.' LIMIT 1), 'nl_NL', 'De winkel gaat achteruit.', 'de uínkel jaat ajteróit');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'La tienda va a menos.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'La tienda va a menos.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES (251, (SELECT id FROM words_es WHERE text = 'La tienda va a menos.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'No mires atrás.', 'SENTENCE', 'Ejemplo de "achterom kijken" (geb.)', 'ACHTEROM KIJKEN = mirar atrás girando la cabeza. En la orden, achterom se queda al final.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'No mires atrás.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'No mires atrás.' LIMIT 1), 'nl_NL', 'Kijk niet achterom.', 'kéik niit ájterom');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No mires atrás.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'No mires atrás.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'mirar atrás' LIMIT 1), (SELECT id FROM words_es WHERE text = 'No mires atrás.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿Puedo usar tu cargador? —Sí, adelante.', 'SENTENCE', 'Ejemplo de "ga je gang" (vraag)', 'GA JE GANG = adelante, el permiso. de oplader = el cargador.

🧩 Expresión fija — ga je gang:

• literal — «ve tu camino»: de gang es aquí la marcha, el paso, no el pasillo.
• significa — adelante, tú mismo, hazlo. Sirve para dar permiso.
• piezas fijas — ga + je + gang, sin artículo. Con u cambia el posesivo, Gaat u uw gang.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | con jij | Mag ik even bellen? — Ga je gang. | ¿Puedo llamar un momento? —Adelante. |
| 2 | con u | Gaat u gerust uw gang. | Adelante, con toda confianza. |
| 3 | con gerust | Ga gerust je gang, ik vind het niet erg. | Adelante, de verdad, no me importa. |

• falso amigo — de gang suelto es el pasillo: Hij staat in de gang = está en el pasillo.

🔑 El truco que casi nunca falla: Si el «adelante» da permiso es Ga je gang, y si mete prisa es Vooruit.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿Puedo usar tu cargador? —Sí, adelante.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿Puedo usar tu cargador? —Sí, adelante.' LIMIT 1), 'nl_NL', 'Mag ik je oplader gebruiken? — Ja, ga je gang.', 'maj ik ie ópláder jebróiken? ia, ja ie jang');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Puedo usar tu cargador? —Sí, adelante.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿Puedo usar tu cargador? —Sí, adelante.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'adelante, hazlo' LIMIT 1), (SELECT id FROM words_es WHERE text = '¿Puedo usar tu cargador? —Sí, adelante.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡Mira hacia arriba, un avión!', 'SENTENCE', 'Ejemplo de "omhoog" (geb.)', 'OMHOOG = hacia arriba, dirección vertical sin pisos. Para subir de piso es naar boven.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡Mira hacia arriba, un avión!');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡Mira hacia arriba, un avión!' LIMIT 1), 'nl_NL', 'Kijk omhoog, een vliegtuig!', 'kéik omhóoj, en flíijtoij');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Mira hacia arriba, un avión!' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡Mira hacia arriba, un avión!' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES (244, (SELECT id FROM words_es WHERE text = '¡Mira hacia arriba, un avión!' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Los precios no paran de subir.', 'SENTENCE', 'Ejemplo de "omhoog" (can.)', 'OMHOOG GAAN = subir, en figurado los precios. steeds = cada vez más, sin parar.

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Los precios no paran de subir.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Los precios no paran de subir.' LIMIT 1), 'nl_NL', 'De prijzen gaan steeds omhoog.', 'de préisen jaan steets omhóoj');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Los precios no paran de subir.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Los precios no paran de subir.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES (244, (SELECT id FROM words_es WHERE text = 'Los precios no paran de subir.' LIMIT 1), 'EXAMPLE');


-- 3) El bloque en las madres que ya existian (omhoog, omlaag, vooruit, achteruit)

UPDATE words_es SET rules_help = rules_help || '

🛗 Dentro, fuera, arriba y abajo — estar allí o ir hacia allí:

| # | forma | español | cuándo | ejemplo |
|---|---|---|---|---|
| 1 | **binnen** | dentro | ESTAR bajo techo, en casa | We blijven binnen. |
| 2 | **naar binnen** | hacia dentro | IR: entrar, meter algo | Breng de fiets naar binnen. |
| 3 | **buiten** | fuera | ESTAR al aire libre | De kinderen spelen buiten. |
| 4 | **naar buiten** | hacia fuera | IR: salir, mirar afuera | Kijk naar buiten! |
| 5 | **boven** | arriba | ESTAR en el piso de arriba | Mijn kamer is boven. |
| 6 | **naar boven** | al piso de arriba | IR: subir de piso | Breng de koffers naar boven. |
| 7 | **beneden** | abajo | ESTAR en el piso de abajo | Ik wacht beneden op je. |
| 8 | **naar beneden** | al piso de abajo | IR: bajar de piso | Ik kom zo naar beneden! |
| 9 | **omhoog / omlaag** | hacia arriba / hacia abajo | dirección vertical sin pisos: mirar, manos, precios | De prijzen gaan omhoog. |
| 10 | **onder** | debajo de | con algo detrás que nombras | De kat zit onder het bed. |
| 11 | **eronder** | debajo | cuando ya se sabe de qué | Heb je eronder gekeken? |
| 12 | **onderaan** | abajo del todo | página, lista, formulario | Zet uw handtekening onderaan. |
| 13 | **vooruit / achteruit** | hacia delante / hacia atrás | avanzar o recular, y en figurado mejorar o empeorar | een stap vooruit |
| 14 | **naar voren / naar achteren** | al frente / al fondo | hacia la parte de delante o de atrás de un sitio | Doe een stap naar voren. |
| 15 | **achterom** | atrás, girando la cabeza | casi siempre con kijken | Kijk niet achterom. |

🔑 El truco que casi nunca falla: ¿Hay movimiento hacia ese sitio? Entonces va naar delante. Si ya estás allí, la palabra va sola.

📌 Regla de bolsillo:
• ¿Cambias de piso dentro de un edificio? → naar boven / naar beneden.
• ¿Solo hacia arriba o hacia abajo, sin pisos? → omhoog / omlaag.
• ¿Debajo de algo que nombras? → onder + sustantivo, y eronder si ya se sabe de qué.
• ¿Abajo del todo de una hoja o una lista? → onderaan.

🪜 Los tres «¡adelante!»:
• Llaman a la puerta → Kom binnen! (o Binnen! a secas; Kom maar binnen si invitas con cariño).
• Te piden permiso → Ga je gang!
• Metes prisa o das ánimos → Vooruit! (o Kom op!).

⚠️ Las trampas:
1. binnenkomen es un verbo separable, así que «entra» es Kom binnen, SIN naar. Con gaan valen las dos, naar binnen gaan y binnengaan.
2. «Comer fuera» en un restaurante es uit eten gaan; buiten eten es comer al aire libre.
3. «Abajo» en un edificio es beneden, no onder. onder siempre pide algo detrás (onder de tafel, onder ons).
4. Lo que está debajo de algo casi nunca «is»: el neerlandés dice cómo está. De kat zit, de sleutels liggen, de fiets staat.

🏋️ Ejercicio:
• Het regent, we blijven ___. (binnen)
• Kom ___, het eten is klaar! (naar beneden)
• De kat zit ___ de tafel. (onder)
• Kijk ___, een vliegtuig! (omhoog)
• Mag ik je fiets lenen? Ja, ga je ___. (gang)', updated_at = datetime('now')
WHERE id IN (244, 245, 250, 251) AND rules_help IS NOT NULL AND rules_help NOT LIKE '%🛗 Dentro, fuera, arriba y abajo%';


-- 4) Frases que ya existian y encajan: se suman al grupo sin salir del suyo

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES (476, (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES (911, (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES (1072, (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES (1115, (SELECT id FROM word_groups WHERE title = 'bewegingen-richtingen'));
