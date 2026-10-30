-- Learn Languages App - Migration
-- Migration: 20261029000003-grupo-kim-familie
-- Description: Eduardo: "vamos a crear grupos kin con todas estas palabras ... ojo revisa que no
--   existan", sobre las listas de Flashcards in Quizlet de Learn Dutch with Kim. Seleccion por
--   frecuencia (wordfreq, Zipf) aprobada con "procedamos asi".
--
--   Grupo 'kim - familie' (lista Familie, quizlet.com/_982rts): 30 tarjetas WORD nuevas. Ninguna
--   existia en el mazo (cruce por words_lang nl_NL). Cada una con articulo en la respuesta (§3.1),
--   pronunciacion, 5 frases en notes (§3.7) y ayuda corta. Se corrigen dos erratas de Kim: peuter no
--   es minnow sino el niño de 2-4 años, y kleuter es el de 4-6 (infantil), no toddler.
--
--   Bloques identicos inyectados (§3.3): 🔑 genero de las personas, 📌 de familie o het gezin,
--   📌 neef y nicht primo y sobrino, 🪜 la escalera de las edades, 📌 huis, thuis y naar huis,
--   📌 de verjaardag y jarig zijn. Expresiones fijas (§3.10): iemand tegenkomen, een gezin
--   stichten, het uitmaken met iemand. Todas van al grupo y a generic.

PRAGMA foreign_keys = ON;

INSERT INTO word_groups (title, description, source)
SELECT 'kim - familie', 'La familia en neerlandes, de la lista Familie de Kim: padres, hermanos, abuelos, tios, primos y las etapas de la infancia. Casi todo va con de, porque son personas; las excepciones son het kind, het kleinkind, het gezin, het huis, het huwelijk y het thuis. Las dos trampas del grupo son neef y nicht, que valen a la vez para primo y sobrino, y la diferencia entre de familie (toda la parentela) y het gezin (los que viven bajo el mismo techo).', 'Familie - Flashcards in Quizlet - Learn Dutch with Kim - https://quizlet.com/_982rts'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'kim - familie');

-- de baby
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el bebé', 'WORD', 'kim - familie: de baby', 'de baby = el bebe · plural de baby''s, con apostrofo porque acaba en vocal que cambiaria el sonido.

💡 Se pronuncia a la inglesa, béebi.

🪜 La escalera de las edades:

| # | palabra | edad | español |
|---|---|---|---|
| 1 | de baby | 0-1 | el bebe |
| 2 | de peuter | 2-4 | el niño que aun no va al cole |
| 3 | de kleuter | 4-6 | el niño de infantil, groep 1 y 2 |
| 4 | het kind | 6-12 | el niño, y tambien el hijo de cualquier edad |
| 5 | de puber | 12-16 | el adolescente en plena pubertad |
| 6 | de tiener | 13-19 | el adolescente, mas neutro |

🧠 La imagen — peuter viene de peuteren, trastear con los dedos, que es lo que hace un niño de dos años; kleuter es el que ya va a la kleuterschool.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el bebé' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el bebé' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de baby', 'de béebi', '• [can.] De baby slaapt eindelijk. — El bebé por fin duerme.
• [perf.] Mijn zus heeft gisteren een baby gekregen. — Mi hermana tuvo ayer un bebé.
• [vraag] Is het een jongen of een meisje? — ¿Es niño o niña?
• [inv.] Morgen komt de baby thuis uit het ziekenhuis. — Mañana el bebé vuelve a casa del hospital.
• [bijzin] Ik ben moe omdat de baby de hele nacht huilde. — Estoy cansado porque el bebé lloró toda la noche.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el bebé' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el bebé' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de broer
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el hermano', 'WORD', 'kim - familie: de broer', 'de broer = el hermano · plural de broers.

📌 Hermanos en general se dice broers en zussen — Heb je broers en zussen? Existe het broertje para el hermano pequeño, en diminutivo y con het.

🔑 El truco que casi nunca falla — las personas van con de (de vader, de zus, de oom), salvo het kind, het kleinkind y todo lo que acaba en -je (het meisje, het zoontje).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el hermano' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el hermano' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de broer', 'de brur', '• [can.] Mijn broer woont in Utrecht. — Mi hermano vive en Utrecht.
• [vraag] Heb jij broers of zussen? — ¿Tienes hermanos?
• [perf.] Mijn broer heeft me geholpen met de verhuizing. — Mi hermano me ayudó con la mudanza.
• [inv.] Vroeger deelde ik een kamer met mijn broer. — Antes compartía habitación con mi hermano.
• [bijzin] Ik weet niet of mijn broer vanavond komt. — No sé si mi hermano viene esta noche.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el hermano' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el hermano' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de dochter
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la hija', 'WORD', 'kim - familie: de dochter', 'de dochter = la hija · plural de dochters.

🧠 La imagen — es la misma palabra que el ingles daughter y el aleman Tochter; la ch suena como la j española.

🔑 El truco que casi nunca falla — las personas van con de (de vader, de zus, de oom), salvo het kind, het kleinkind y todo lo que acaba en -je (het meisje, het zoontje).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la hija' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la hija' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de dochter', 'de dójter', '• [can.] Onze dochter is zeven jaar. — Nuestra hija tiene siete años.
• [perf.] Hun dochter is vorig jaar getrouwd. — Su hija se casó el año pasado.
• [vraag] Hoe heet je dochter? — ¿Cómo se llama tu hija?
• [inv.] Elke ochtend breng ik mijn dochter naar school. — Cada mañana llevo a mi hija al colegio.
• [bijzin] Ze is blij dat haar dochter dichtbij woont. — Está contenta de que su hija viva cerca.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la hija' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la hija' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de ex
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el ex, la ex', 'WORD', 'kim - familie: de ex', 'de ex = el ex o la ex · plural de exen.

💡 Vale para los dos sexos, igual que en español. Para ser mas preciso — mijn ex-man, mijn ex-vrouw, mijn ex-vriendin.

🧩 Expresión fija — iemand tegenkomen:
• literal — venir contra alguien.
• significa — encontrarse con alguien por casualidad.
• piezas fijas — tegen es particula separable y se va al final en la principal.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ik kom haar vaak tegen. | Me la encuentro a menudo. |
| 2 | imperfecto | Gisteren kwam ik mijn ex tegen. | Ayer me encontré con mi ex. |
| 3 | perfecto | Ik ben hem nooit meer tegengekomen. | No me lo he vuelto a encontrar. |

🔑 El truco que casi nunca falla — por casualidad es tegenkomen; quedar a proposito es afspreken met.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el ex, la ex' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el ex, la ex' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de ex', 'de eks', '• [can.] Mijn ex woont nog steeds in Amsterdam. — Mi ex sigue viviendo en Ámsterdam.
• [perf.] Ik heb mijn ex al jaren niet gezien. — Hace años que no veo a mi ex.
• [vraag] Heb je nog contact met je ex? — ¿Sigues en contacto con tu ex?
• [inv.] Gisteren kwam ik mijn ex tegen in de supermarkt. — Ayer me encontré con mi ex en el súper.
• [bijzin] Hij zegt dat hij goed overweg kan met zijn ex. — Dice que se lleva bien con su ex.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el ex, la ex' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el ex, la ex' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de familie
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la familia', 'WORD', 'kim - familie: de familie', 'de familie = la familia, la parentela · plural de families.

📌 de familie o het gezin:
• de familie — toda la parentela, abuelos, tios y primos incluidos. Mijn hele familie komt met Kerst.
• het gezin — solo padres e hijos, los que viven juntos. Wij zijn een gezin van vier.
• Para decir familia numerosa o familia monoparental se usa gezin — een groot gezin, een eenoudergezin.
• Ojo, de familie es singular aunque sean muchos — De familie is groot, no «zijn groot».

💡 familie zijn van iemand es ser pariente de alguien — Zij is familie van mijn moeder.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la familia' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la familia' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de familie', 'de famíili', '• [can.] Mijn familie woont in Spanje. — Mi familia vive en España.
• [perf.] We hebben de hele familie uitgenodigd. — Hemos invitado a toda la familia.
• [inv.] Met Kerst zie ik mijn familie. — En Navidad veo a mi familia.
• [vraag] Heb je familie in Nederland? — ¿Tienes familia en Holanda?
• [uitdr.] Hij is familie van me. — Es pariente mío.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la familia' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la familia' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- het gezin
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el núcleo familiar', 'WORD', 'kim - familie: het gezin', 'het gezin = la familia de casa, padres e hijos · plural de gezinnen.

📌 de familie o het gezin:
• de familie — toda la parentela, abuelos, tios y primos incluidos. Mijn hele familie komt met Kerst.
• het gezin — solo padres e hijos, los que viven juntos. Wij zijn een gezin van vier.
• Para decir familia numerosa o familia monoparental se usa gezin — een groot gezin, een eenoudergezin.
• Ojo, de familie es singular aunque sean muchos — De familie is groot, no «zijn groot».

🧩 Expresión fija — een gezin stichten:
• literal — fundar una familia.
• significa — casarse o juntarse y tener hijos.
• piezas fijas — stichten, no maken ni beginnen.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ze willen een gezin stichten. | Quieren formar una familia. |
| 2 | perfecto | Hij heeft jong een gezin gesticht. | Formó una familia joven. |
| 3 | subordinada | … voordat ze een gezin stichten. | … antes de formar una familia. |

🔑 El truco que casi nunca falla — si los cuentas sentados a la mesa de casa, es gezin.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el núcleo familiar' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el núcleo familiar' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'het gezin', 'het jesín', '• [can.] Wij zijn een gezin van vier. — Somos una familia de cuatro.
• [perf.] Ze hebben een gezin gesticht. — Han formado una familia.
• [vraag] Hoe groot is jullie gezin? — ¿Cuántos sois en casa?
• [inv.] Op zondag eet het hele gezin samen. — Los domingos come toda la familia junta.
• [bijzin] Hij werkt veel omdat hij een groot gezin heeft. — Trabaja mucho porque tiene una familia numerosa.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el núcleo familiar' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el núcleo familiar' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- het huis
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la casa', 'WORD', 'kim - familie: het huis', 'het huis = la casa · plural de huizen, la s se vuelve z.

📌 huis, thuis y naar huis:
• het huis — el edificio, la casa como objeto. Ons huis heeft drie kamers.
• het thuis — el hogar, el sitio donde uno se siente en casa. Dit is mijn thuis.
• thuis, sin articulo — en casa, sin movimiento. Ik ben thuis.
• naar huis — a casa, con movimiento. Ik ga naar huis, nunca «naar thuis».
🔑 El truco que casi nunca falla — si hay movimiento hacia casa, naar huis; si estas quieto, thuis.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la casa' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la casa' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'het huis', 'het háus', '• [can.] Ons huis heeft een kleine tuin. — Nuestra casa tiene un jardín pequeño.
• [perf.] Ze hebben vorig jaar een huis gekocht. — Compraron una casa el año pasado.
• [geb.] Ga maar naar huis, je bent ziek. — Vete a casa, que estás enfermo.
• [inv.] Om zes uur ben ik meestal thuis. — A las seis suelo estar en casa.
• [bijzin] Ik bel je zodra ik thuis ben. — Te llamo en cuanto esté en casa.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la casa' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la casa' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- het huwelijk
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el matrimonio', 'WORD', 'kim - familie: het huwelijk', 'het huwelijk = el matrimonio, y tambien la boda · plural de huwelijken.

📌 La boda se dice het huwelijk o de bruiloft; de bruiloft es la fiesta, het huwelijk la institucion y tambien el acto.
• trouwen met — casarse con: Ik ben getrouwd met Ana, con zijn.
• scheiden — divorciarse: Ze zijn gescheiden, con zijn.

💡 Aqui no hay regla de genero fiable, se aprende con el het pegado — het huwelijk.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el matrimonio' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el matrimonio' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'het huwelijk', 'het júwelek', '• [can.] Hun huwelijk is erg gelukkig. — Su matrimonio es muy feliz.
• [perf.] Het huwelijk heeft twintig jaar geduurd. — El matrimonio duró veinte años.
• [inv.] Na tien jaar huwelijk zijn ze gescheiden. — Tras diez años de matrimonio se separaron.
• [vraag] Ga je naar het huwelijk van je neef? — ¿Vas a la boda de tu primo?
• [bijzin] Ze vertelde dat haar huwelijk in juni is. — Contó que su boda es en junio.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el matrimonio' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el matrimonio' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- het kind
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el niño, la niña', 'WORD', 'kim - familie: het kind', 'het kind = el niño o la niña, y tambien el hijo · plural de kinderen, irregular.

⚠️ Es het aunque sea una persona, igual que het meisje.

💡 Tener hijos se dice kinderen hebben; hijos e hijas a la vez es kinderen, no «zonen».

🪜 La escalera de las edades:

| # | palabra | edad | español |
|---|---|---|---|
| 1 | de baby | 0-1 | el bebe |
| 2 | de peuter | 2-4 | el niño que aun no va al cole |
| 3 | de kleuter | 4-6 | el niño de infantil, groep 1 y 2 |
| 4 | het kind | 6-12 | el niño, y tambien el hijo de cualquier edad |
| 5 | de puber | 12-16 | el adolescente en plena pubertad |
| 6 | de tiener | 13-19 | el adolescente, mas neutro |

🧠 La imagen — peuter viene de peuteren, trastear con los dedos, que es lo que hace un niño de dos años; kleuter es el que ya va a la kleuterschool.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el niño, la niña' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el niño, la niña' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'het kind', 'het kint', '• [can.] Het kind speelt in de tuin. — El niño juega en el jardín.
• [vraag] Hebben jullie kinderen? — ¿Tenéis hijos?
• [perf.] Ze hebben drie kinderen gekregen. — Han tenido tres hijos.
• [inv.] Als kind woonde ik op het platteland. — De niño vivía en el campo.
• [bijzin] Ik weet niet hoe oud zijn kinderen zijn. — No sé cuántos años tienen sus hijos.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el niño, la niña' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el niño, la niña' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- het kleinkind
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el nieto, la nieta', 'WORD', 'kim - familie: het kleinkind', 'het kleinkind = el nieto o la nieta · plural de kleinkinderen.

🧠 La imagen — klein + kind, el niño pequeño de la familia; por eso hereda el het y el plural irregular de het kind.

💡 Para el sexo — de kleinzoon (el nieto), de kleindochter (la nieta), los dos con de.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el nieto, la nieta' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el nieto, la nieta' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'het kleinkind', 'het kléinkint', '• [can.] Oma past op haar kleinkinderen. — La abuela cuida de sus nietos.
• [perf.] Ze hebben net hun eerste kleinkind gekregen. — Acaban de tener su primer nieto.
• [vraag] Hoeveel kleinkinderen heeft je opa? — ¿Cuántos nietos tiene tu abuelo?
• [inv.] Elke woensdag komen de kleinkinderen. — Cada miércoles vienen los nietos.
• [bijzin] Hij is trots omdat zijn kleinkind is geslaagd. — Está orgulloso porque su nieto ha aprobado.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el nieto, la nieta' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el nieto, la nieta' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de kleuter
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el niño de cuatro a seis años', 'WORD', 'kim - familie: de kleuter', 'de kleuter = el niño de cuatro a seis años, el de infantil · plural de kleuters.

⚠️ En la lista de Kim sale como toddler, pero toddler es mas bien de peuter; kleuter es el que ya va al cole.

🪜 La escalera de las edades:

| # | palabra | edad | español |
|---|---|---|---|
| 1 | de baby | 0-1 | el bebe |
| 2 | de peuter | 2-4 | el niño que aun no va al cole |
| 3 | de kleuter | 4-6 | el niño de infantil, groep 1 y 2 |
| 4 | het kind | 6-12 | el niño, y tambien el hijo de cualquier edad |
| 5 | de puber | 12-16 | el adolescente en plena pubertad |
| 6 | de tiener | 13-19 | el adolescente, mas neutro |

🧠 La imagen — peuter viene de peuteren, trastear con los dedos, que es lo que hace un niño de dos años; kleuter es el que ya va a la kleuterschool.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el niño de cuatro a seis años' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el niño de cuatro a seis años' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de kleuter', 'de klóiter', '• [can.] De kleuters zitten in groep 1 en 2. — Los niños de infantil están en groep 1 y 2.
• [perf.] Ik heb vroeger op een kleuterschool gewerkt. — Antes trabajé en una escuela infantil.
• [inv.] ''s Ochtends zingen de kleuters een liedje. — Por la mañana los pequeños cantan una canción.
• [vraag] Is je zoon al een kleuter? — ¿Tu hijo ya va a infantil?
• [bijzin] Ze is juf omdat ze graag met kleuters werkt. — Es maestra porque le gusta trabajar con niños pequeños.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el niño de cuatro a seis años' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el niño de cuatro a seis años' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de leeftijd
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la edad', 'WORD', 'kim - familie: de leeftijd', 'de leeftijd = la edad · plural de leeftijden.

🧠 La imagen — leef de leven (vivir) + tijd (tiempo), el tiempo vivido; tijd es de, y el compuesto hereda el de.

📌 Para preguntar la edad no se usa leeftijd sino Hoe oud ben je? — Ik ben dertig (jaar), nunca «ik heb dertig jaar».
🔑 El truco que casi nunca falla — en neerlandes la edad se ES, no se TIENE: ik ben dertig.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la edad' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la edad' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de leeftijd', 'de léeftait', '• [can.] Op mijn leeftijd slaap ik minder. — A mi edad duermo menos.
• [vraag] Wat is je leeftijd? — ¿Cuál es tu edad?
• [perf.] Ze is op jonge leeftijd naar Nederland gekomen. — Vino a Holanda de joven.
• [inv.] Vanaf die leeftijd mag je stemmen. — A partir de esa edad puedes votar.
• [bijzin] Het maakt niet uit welke leeftijd je hebt. — Da igual la edad que tengas.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la edad' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la edad' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de liefde
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el amor', 'WORD', 'kim - familie: de liefde', 'de liefde = el amor · plural de liefdes, poco usado.

🔑 El truco que casi nunca falla — las palabras en -de y -te que salen de un adjetivo son de: lief → de liefde, warm → de warmte, diep → de diepte.

📌 Querer a alguien no es liefde hebben, es houden van — Ik hou van jou. Enamorarse, verliefd worden op.

💡 Colocaciones — liefde op het eerste gezicht (amor a primera vista), uit liefde (por amor), met liefde (con mucho gusto).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el amor' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el amor' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de liefde', 'de líifde', '• [can.] Liefde is het belangrijkste in het leven. — El amor es lo más importante de la vida.
• [perf.] Ze hebben elkaar op het werk leren kennen en het was liefde op het eerste gezicht. — Se conocieron en el trabajo y fue amor a primera vista.
• [uitdr.] Ze is mijn grote liefde. — Es el amor de mi vida.
• [inv.] Uit liefde doe je soms rare dingen. — Por amor a veces haces cosas raras.
• [bijzin] Hij schrijft dat hij haar liefde mist. — Escribe que echa de menos su amor.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el amor' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el amor' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de moeder
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la madre', 'WORD', 'kim - familie: de moeder', 'de moeder = la madre · plural de moeders.

💡 En familia se dice mama o mam — Mam, waar is mijn jas? El registro mas formal es moeder.

🔑 El truco que casi nunca falla — las personas van con de (de vader, de zus, de oom), salvo het kind, het kleinkind y todo lo que acaba en -je (het meisje, het zoontje).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la madre' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la madre' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de moeder', 'de múder', '• [can.] Mijn moeder belt me elke zondag. — Mi madre me llama cada domingo.
• [perf.] Mijn moeder heeft altijd hard gewerkt. — Mi madre siempre ha trabajado mucho.
• [vraag] Hoe gaat het met je moeder? — ¿Qué tal tu madre?
• [inv.] In mei is het Moederdag. — En mayo es el Día de la Madre.
• [bijzin] Ik ga langs omdat mijn moeder jarig is. — Paso a verla porque es el cumpleaños de mi madre.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la madre' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la madre' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de neef
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el primo, el sobrino', 'WORD', 'kim - familie: de neef', 'de neef = el primo y tambien el sobrino · plural de neven, irregular.

📌 neef y nicht, primo y sobrino a la vez:
• de neef — el primo Y el sobrino; de nicht — la prima Y la sobrina.
• El neerlandes no los distingue con la palabra. Si hace falta, se explica el parentesco — mijn neef, de zoon van mijn broer (sobrino) frente a mijn neef, de zoon van mijn oom (primo).
• Hay palabras precisas pero suenan formales — de oomzegger (sobrino) y de volle neef (primo hermano). En la calle, neef y nicht.
• ⚠️ nicht en registro coloquial tambien se usa como insulto hacia hombres gais; en contexto de familia no hay ambiguedad.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el primo, el sobrino' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el primo, el sobrino' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de neef', 'de neef', '• [can.] Mijn neef studeert in Leiden. — Mi primo estudia en Leiden.
• [perf.] Ik heb mijn neef al lang niet gezien. — Hace mucho que no veo a mi primo.
• [vraag] Is hij je neef of je broer? — ¿Es tu primo o tu hermano?
• [inv.] Vorige week is mijn neefje geboren. — La semana pasada nació mi sobrinito.
• [bijzin] Ze zegt dat haar neef bij de politie werkt. — Dice que su primo trabaja en la policía.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el primo, el sobrino' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el primo, el sobrino' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de nicht
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la prima, la sobrina', 'WORD', 'kim - familie: de nicht', 'de nicht = la prima y tambien la sobrina · plural de nichten.

📌 neef y nicht, primo y sobrino a la vez:
• de neef — el primo Y el sobrino; de nicht — la prima Y la sobrina.
• El neerlandes no los distingue con la palabra. Si hace falta, se explica el parentesco — mijn neef, de zoon van mijn broer (sobrino) frente a mijn neef, de zoon van mijn oom (primo).
• Hay palabras precisas pero suenan formales — de oomzegger (sobrino) y de volle neef (primo hermano). En la calle, neef y nicht.
• ⚠️ nicht en registro coloquial tambien se usa como insulto hacia hombres gais; en contexto de familia no hay ambiguedad.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la prima, la sobrina' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la prima, la sobrina' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de nicht', 'de nijt', '• [can.] Mijn nicht woont in België. — Mi prima vive en Bélgica.
• [perf.] Mijn nicht is net afgestudeerd. — Mi sobrina acaba de terminar la carrera.
• [vraag] Hoe oud is je nichtje? — ¿Cuántos años tiene tu sobrinita?
• [inv.] Zaterdag gaan we naar de bruiloft van mijn nicht. — El sábado vamos a la boda de mi prima.
• [bijzin] Ik wist niet dat zij je nicht was. — No sabía que era tu prima.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la prima, la sobrina' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la prima, la sobrina' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de oma
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la abuela', 'WORD', 'kim - familie: de oma', 'de oma = la abuela · plural de oma''s, con apostrofo para no leer «omas» con a breve.

💡 Formal es de grootmoeder. Los abuelos juntos, opa en oma o de grootouders.

📌 naar oma gaan es ir a casa de la abuela, sin huis — igual que naar de dokter.

🔑 El truco que casi nunca falla — las personas van con de (de vader, de zus, de oom), salvo het kind, het kleinkind y todo lo que acaba en -je (het meisje, het zoontje).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la abuela' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la abuela' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de oma', 'de óoma', '• [can.] Mijn oma is negentig jaar. — Mi abuela tiene noventa años.
• [perf.] Oma heeft een taart gebakken. — La abuela ha hecho una tarta.
• [inv.] Op zondag gaan we naar oma. — Los domingos vamos a casa de la abuela.
• [vraag] Woont je oma nog alleen? — ¿Tu abuela sigue viviendo sola?
• [bijzin] Ik mis het eten dat oma altijd kookte. — Echo de menos la comida que hacía la abuela.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la abuela' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la abuela' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de oom
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el tío', 'WORD', 'kim - familie: de oom', 'de oom = el tio · plural de ooms.

💡 Los tios juntos, oom en tante. El hijo de tu oom es tu neef, y el de tu broer tambien — ver de neef.

🔑 El truco que casi nunca falla — las personas van con de (de vader, de zus, de oom), salvo het kind, het kleinkind y todo lo que acaba en -je (het meisje, het zoontje).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el tío' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el tío' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de oom', 'de oom', '• [can.] Mijn oom heeft een boerderij. — Mi tío tiene una granja.
• [perf.] Mijn oom heeft lang in Indonesië gewoond. — Mi tío vivió mucho tiempo en Indonesia.
• [vraag] Is dat je oom of je opa? — ¿Ese es tu tío o tu abuelo?
• [inv.] Morgen komen mijn oom en tante eten. — Mañana vienen mi tío y mi tía a comer.
• [bijzin] Ik weet dat mijn oom graag vist. — Sé que a mi tío le gusta pescar.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tío' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tío' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de opa
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el abuelo', 'WORD', 'kim - familie: de opa', 'de opa = el abuelo · plural de opa''s.

💡 Formal es de grootvader. lijken op is parecerse a — Hij lijkt op zijn opa.

🔑 El truco que casi nunca falla — las personas van con de (de vader, de zus, de oom), salvo het kind, het kleinkind y todo lo que acaba en -je (het meisje, het zoontje).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el abuelo' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el abuelo' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de opa', 'de óopa', '• [can.] Mijn opa vertelt graag verhalen. — A mi abuelo le gusta contar historias.
• [perf.] Opa is vorig jaar overleden. — El abuelo murió el año pasado.
• [vraag] Hoe oud is je opa? — ¿Cuántos años tiene tu abuelo?
• [inv.] Elke ochtend wandelt opa met de hond. — Cada mañana el abuelo pasea al perro.
• [bijzin] Ze lijkt op haar opa, zegt iedereen. — Se parece a su abuelo, dice todo el mundo.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el abuelo' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el abuelo' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de ouders
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'los padres', 'WORD', 'kim - familie: de ouders', 'de ouders = los padres · singular de ouder, el padre o la madre sin decir cual.

🧠 La imagen — ouder es tambien mayor, el comparativo de oud; los padres son los mayores de la casa, igual que el ingles elders.

⚠️ Mis padres es mijn ouders, nunca «mijn vaders», que serian dos padres varones.
💡 bij mijn ouders wonen es vivir con mis padres, con bij, no met.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'los padres' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'los padres' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de ouders', 'de áuders', '• [can.] Mijn ouders wonen in Madrid. — Mis padres viven en Madrid.
• [perf.] Ik heb mijn ouders gisteren gebeld. — Ayer llamé a mis padres.
• [vraag] Komen je ouders ook? — ¿Vienen también tus padres?
• [inv.] In de zomer bezoek ik mijn ouders. — En verano visito a mis padres.
• [bijzin] Ze woont nog bij haar ouders omdat huren duur is. — Todavía vive con sus padres porque alquilar es caro.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los padres' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los padres' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de partner
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la pareja', 'WORD', 'kim - familie: de partner', 'de partner = la pareja · plural de partners.

📌 Neutro y muy usado en formularios. En lo informal, mijn vriend (mi novio) y mijn vriendin (mi novia); de vriend sin mijn es tambien el amigo, y el contexto decide.

🔑 El truco que casi nunca falla — en papeles y en la gemeente, partner; con amigos, vriend o vriendin.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la pareja' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la pareja' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de partner', 'de pártner', '• [can.] Mijn partner werkt in de zorg. — Mi pareja trabaja en sanidad.
• [perf.] Ze heeft haar partner op een feestje ontmoet. — Conoció a su pareja en una fiesta.
• [vraag] Neem je je partner mee? — ¿Traes a tu pareja?
• [inv.] Samen met mijn partner heb ik een huis gekocht. — Con mi pareja he comprado una casa.
• [bijzin] Op het formulier staat dat je partner moet tekenen. — En el formulario pone que tu pareja tiene que firmar.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la pareja' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la pareja' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de peuter
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el niño de dos a cuatro años', 'WORD', 'kim - familie: de peuter', 'de peuter = el niño de dos a cuatro años, el que aun no va al cole · plural de peuters.

⚠️ En la lista de Kim sale como minnow, que es un error; peuter es el toddler del ingles.

🪜 La escalera de las edades:

| # | palabra | edad | español |
|---|---|---|---|
| 1 | de baby | 0-1 | el bebe |
| 2 | de peuter | 2-4 | el niño que aun no va al cole |
| 3 | de kleuter | 4-6 | el niño de infantil, groep 1 y 2 |
| 4 | het kind | 6-12 | el niño, y tambien el hijo de cualquier edad |
| 5 | de puber | 12-16 | el adolescente en plena pubertad |
| 6 | de tiener | 13-19 | el adolescente, mas neutro |

🧠 La imagen — peuter viene de peuteren, trastear con los dedos, que es lo que hace un niño de dos años; kleuter es el que ya va a la kleuterschool.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el niño de dos a cuatro años' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el niño de dos a cuatro años' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de peuter', 'de péuter', '• [can.] De peuter wil alles zelf doen. — El niño pequeño quiere hacerlo todo solo.
• [perf.] Onze peuter is net naar de opvang gegaan. — Nuestro pequeño acaba de empezar la guarde.
• [inv.] Op de peuterspeelzaal spelen ze de hele ochtend. — En la guardería juegan toda la mañana.
• [vraag] Is een peuter van drie niet te jong voor school? — ¿No es un niño de tres años demasiado pequeño para el cole?
• [bijzin] Je merkt dat hij een peuter is omdat hij steeds nee zegt. — Se nota que es un niño pequeño porque siempre dice que no.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el niño de dos a cuatro años' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el niño de dos a cuatro años' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de puber
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el adolescente', 'WORD', 'kim - familie: de puber', 'de puber = el adolescente en plena pubertad · plural de pubers.

💡 La etapa es de puberteit, con -teit y por tanto de. Mas neutro y sin connotacion, de tiener.

🪜 La escalera de las edades:

| # | palabra | edad | español |
|---|---|---|---|
| 1 | de baby | 0-1 | el bebe |
| 2 | de peuter | 2-4 | el niño que aun no va al cole |
| 3 | de kleuter | 4-6 | el niño de infantil, groep 1 y 2 |
| 4 | het kind | 6-12 | el niño, y tambien el hijo de cualquier edad |
| 5 | de puber | 12-16 | el adolescente en plena pubertad |
| 6 | de tiener | 13-19 | el adolescente, mas neutro |

🧠 La imagen — peuter viene de peuteren, trastear con los dedos, que es lo que hace un niño de dos años; kleuter es el que ya va a la kleuterschool.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el adolescente' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el adolescente' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de puber', 'de púber', '• [can.] Mijn zoon is een echte puber. — Mi hijo es un adolescente de manual.
• [perf.] Ze is een stuk rustiger geworden sinds ze geen puber meer is. — Se ha calmado mucho desde que dejó la adolescencia.
• [vraag] Hoe ga je om met een puber? — ¿Cómo se trata con un adolescente?
• [inv.] Als puber was ik erg verlegen. — De adolescente era muy tímido.
• [bijzin] Ik snap dat pubers lang slapen. — Entiendo que los adolescentes duerman mucho.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el adolescente' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el adolescente' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de relatie
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la relación', 'WORD', 'kim - familie: de relatie', 'de relatie = la relacion, sobre todo de pareja · plural de relaties.

🔑 El truco que casi nunca falla — las palabras en -tie son de y suenan con s: de relatie, de situatie, de informatie.

🧩 Expresión fija — het uitmaken met iemand:
• literal — acabarlo con alguien.
• significa — cortar con la pareja.
• piezas fijas — un het vacio y uit separable.

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | principal | Ze maakt het uit met hem. | Corta con él. |
| 2 | perfecto | Hij heeft het uitgemaakt. | Ha cortado. |
| 3 | subordinada | … omdat ze het heeft uitgemaakt. | … porque ella cortó. |

💡 een relatie hebben met iemand — salir con alguien, tener pareja.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la relación' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la relación' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de relatie', 'de reláasi', '• [can.] Ze hebben al vijf jaar een relatie. — Llevan cinco años juntos.
• [perf.] Hij heeft de relatie gisteren uitgemaakt. — Ayer cortó la relación.
• [vraag] Heb je een relatie? — ¿Tienes pareja?
• [inv.] Met mijn collega''s heb ik een goede relatie. — Con mis compañeros tengo buena relación.
• [bijzin] Ze vertelt niet veel over haar relatie. — No cuenta mucho de su relación.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la relación' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la relación' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de tante
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la tía', 'WORD', 'kim - familie: de tante', 'de tante = la tia · plural de tantes.

💡 Delante del nombre se usa tal cual — tante Els, oom Piet. La hija de tu tante es tu nicht, igual que la de tu hermano — ver de nicht.

🔑 El truco que casi nunca falla — las personas van con de (de vader, de zus, de oom), salvo het kind, het kleinkind y todo lo que acaba en -je (het meisje, het zoontje).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la tía' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la tía' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de tante', 'de tánte', '• [can.] Mijn tante woont naast ons. — Mi tía vive al lado.
• [perf.] Tante Els heeft ons een kaart gestuurd. — La tía Els nos ha mandado una postal.
• [vraag] Heb je veel tantes? — ¿Tienes muchas tías?
• [inv.] Bij mijn tante eten we altijd pannenkoeken. — En casa de mi tía siempre comemos tortitas.
• [bijzin] Ik weet niet of mijn tante kinderen heeft. — No sé si mi tía tiene hijos.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la tía' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la tía' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- het thuis
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el hogar', 'WORD', 'kim - familie: het thuis', 'het thuis = el hogar · sin plural.

📌 huis, thuis y naar huis:
• het huis — el edificio, la casa como objeto. Ons huis heeft drie kamers.
• het thuis — el hogar, el sitio donde uno se siente en casa. Dit is mijn thuis.
• thuis, sin articulo — en casa, sin movimiento. Ik ben thuis.
• naar huis — a casa, con movimiento. Ik ga naar huis, nunca «naar thuis».
🔑 El truco que casi nunca falla — si hay movimiento hacia casa, naar huis; si estas quieto, thuis.

💡 Bienvenido a casa se dice Welkom thuis!'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el hogar' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el hogar' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'het thuis', 'het táus', '• [can.] Nederland is nu mijn thuis. — Holanda es ahora mi hogar.
• [perf.] Ze heeft hier een nieuw thuis gevonden. — Ha encontrado aquí un nuevo hogar.
• [geb.] Doe alsof je thuis bent. — Haz como si estuvieras en tu casa.
• [inv.] Vandaag werk ik thuis. — Hoy trabajo desde casa.
• [vraag] Is er iemand thuis? — ¿Hay alguien en casa?');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el hogar' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el hogar' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de vader
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el padre', 'WORD', 'kim - familie: de vader', 'de vader = el padre · plural de vaders.

💡 En familia, papa o pap. La v inicial suena casi como una f suave, fáader.

🔑 El truco que casi nunca falla — las personas van con de (de vader, de zus, de oom), salvo het kind, het kleinkind y todo lo que acaba en -je (het meisje, het zoontje).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el padre' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el padre' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de vader', 'de fáader', '• [can.] Mijn vader is gepensioneerd. — Mi padre está jubilado.
• [perf.] Mijn vader heeft dit huis zelf gebouwd. — Mi padre construyó esta casa él mismo.
• [vraag] Wat doet je vader? — ¿A qué se dedica tu padre?
• [inv.] In juni vieren we Vaderdag. — En junio celebramos el Día del Padre.
• [bijzin] Hij lijkt op zijn vader, al zegt hij van niet. — Se parece a su padre, aunque diga que no.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el padre' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el padre' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de verjaardag
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el cumpleaños', 'WORD', 'kim - familie: de verjaardag', 'de verjaardag = el cumpleaños · plural de verjaardagen.

📌 de verjaardag y jarig zijn:
• de verjaardag — la fiesta o la fecha. Ik ga naar de verjaardag van mijn oma.
• jarig zijn — ser tu cumpleaños hoy. Ik ben vandaag jarig, nunca «ik heb verjaardag».
• Se felicita con Gefeliciteerd!, y en Holanda tambien a la familia — Gefeliciteerd met je moeder!
🔑 El truco que casi nunca falla — si en español dices hoy es mi cumple, en neerlandes es Ik ben jarig.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el cumpleaños' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el cumpleaños' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de verjaardag', 'de ferjáardaj', '• [can.] Mijn verjaardag is in maart. — Mi cumpleaños es en marzo.
• [perf.] We hebben zijn verjaardag gevierd met taart. — Celebramos su cumpleaños con tarta.
• [uitdr.] Ik ben vandaag jarig! — ¡Hoy es mi cumpleaños!
• [vraag] Kom je naar mijn verjaardag? — ¿Vienes a mi cumpleaños?
• [bijzin] Ik was vergeten dat het jouw verjaardag was. — Se me había olvidado que era tu cumpleaños.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cumpleaños' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cumpleaños' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de zoon
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el hijo', 'WORD', 'kim - familie: de zoon', 'de zoon = el hijo · plural de zonen, y en lengua hablada tambien de zoons.

⚠️ Hijos en general, chicos y chicas, es kinderen — Ik heb twee kinderen, no «twee zonen» si hay una niña.

🔑 El truco que casi nunca falla — las personas van con de (de vader, de zus, de oom), salvo het kind, het kleinkind y todo lo que acaba en -je (het meisje, het zoontje).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el hijo' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el hijo' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de zoon', 'de soon', '• [can.] Onze zoon zit op de universiteit. — Nuestro hijo está en la universidad.
• [perf.] Ze hebben een zoon gekregen. — Han tenido un hijo.
• [vraag] Hoe oud is je zoon? — ¿Cuántos años tiene tu hijo?
• [inv.] Elke zaterdag voetbalt mijn zoon. — Cada sábado mi hijo juega al fútbol.
• [bijzin] Ik ben trots dat mijn zoon zo goed Nederlands spreekt. — Estoy orgulloso de que mi hijo hable tan bien neerlandés.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el hijo' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el hijo' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- de zus
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la hermana', 'WORD', 'kim - familie: de zus', 'de zus = la hermana · plural de zussen, se dobla la s.

💡 Formal es de zuster, que tambien es la enfermera o la monja. El diminutivo het zusje es la hermana pequeña.

🔑 El truco que casi nunca falla — las personas van con de (de vader, de zus, de oom), salvo het kind, het kleinkind y todo lo que acaba en -je (het meisje, het zoontje).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la hermana' AND word_type = 'WORD');
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la hermana' AND word_type = 'WORD' LIMIT 1), 'nl_NL', 'de zus', 'de sus', '• [can.] Mijn zus is ouder dan ik. — Mi hermana es mayor que yo.
• [perf.] Mijn zus heeft me met mijn huiswerk geholpen. — Mi hermana me ayudó con los deberes.
• [vraag] Heb je een zus? — ¿Tienes una hermana?
• [inv.] Morgen komt mijn zusje logeren. — Mañana viene mi hermanita a dormir.
• [bijzin] Ik weet niet waar mijn zus nu woont. — No sé dónde vive ahora mi hermana.');
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la hermana' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'kim - familie'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la hermana' AND word_type = 'WORD' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));
