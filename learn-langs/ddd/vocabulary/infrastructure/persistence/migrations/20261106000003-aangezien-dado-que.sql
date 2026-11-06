-- Learn Languages App - Migration
-- Migration: 20261106000003-aangezien-dado-que
-- Description: Eduardo (2026-11-06): «agrega esto como palabra dificil: aangezien».
--
--   Ya existía la PHRASE 1006 (Aangezien het al laat is, stoppen we) en los grupos generic y 38, pero no la
--   palabra. Se mete en el grupo 28 «palabras dificiles» (y en generic):
--   1. Tarjeta WORD 'dado que, puesto que, ya que' -> aangezien, con sus 5 frases en notes y la tabla 🗣️.
--   2. 6 SENTENCE colgadas con EXAMPLE: delante con inversión (3, marca inv), perfecto, pasado, detrás sin
--      inversión, formal con u, y la trampa: el participio de aanzien (Ik werd voor een toerist aangezien).
--   3. Bloque compartido «🧷 Aangezien» en las 7: rivales (omdat, want, nu, doordat, aanzien voor), la imagen
--      «visto que», el orden, el acento que distingue a los gemelos (aangeZIEN / AANgezien), la ficha del verbo
--      aanzien (porque aparece en una respuesta), truco, tres trampas y ejercicio.
--
--   Tarjetas nuevas sin audio.

PRAGMA foreign_keys = ON;

-- 1) Tarjeta madre

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'dado que, puesto que, ya que', 'WORD', 'dificil: aangezien (dado que)', 'aangezien = dado que, puesto que, ya que. Es una conjunción subordinante y presenta una causa que los dos ya conocen o que es evidente, por eso suele ir delante. Registro algo formal: un correo, una reunión, una explicación seria.

🗣️ Cinco usos, alternando tiempo y posición:

| # | etiqueta | neerlandés | español |
|---|---|---|---|
| 1 | inv. | Aangezien je toch thuis bent, kun je de was doen. | Ya que estás en casa, puedes poner la lavadora. |
| 2 | perf. | Aangezien hij niet gereageerd heeft, bel ik hem morgen. | Como no ha contestado, lo llamo mañana. |
| 3 | verl. | Aangezien de trein vertraging had, kwam ik te laat. | Como el tren llevaba retraso, llegué tarde. |
| 4 | bijzin | We blijven binnen, aangezien het zo hard regent. | Nos quedamos dentro, ya que llueve tanto. |
| 5 | formeel | Aangezien u niet aanwezig was, sturen wij u het verslag. | Puesto que usted no estuvo presente, le enviamos el acta. |

🧷 Aangezien — dado que, y su gemelo el participio de aanzien:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | porque | **omdat** | lo normal al hablar, causa con motivo |
| 2 | pues, que | **want** | coordinante, no manda el verbo al final |
| 3 | dado que, puesto que, visto que | **aangezien** | algo formal, causa que los dos ya conocen |
| 4 | ya que estás, ahora que | **nu** | la versión hablada: Nu je hier toch bent, … |
| 5 | porque, sin voluntad | **doordat** | efecto material: Doordat het glad was, viel ik |
| 6 | tomar a alguien por | **iemand aanzien voor** | participio aangezien: Ik werd voor een Duitser aangezien |

🧠 La imagen de la palabra es aan-ge-zien, «visto». Aangezien het laat is es visto que es tarde, y por eso presenta una causa que ya está a la vista de todos.

📐 Es subordinante y manda el verbo al final de su parte, aangezien het laat IS. Si va delante, la principal invierte, Aangezien het laat is, GAAN WE. Si va detrás, la principal queda normal, We gaan, aangezien het laat is.

🔊 El acento distingue a los gemelos. La conjunción carga en zien, aanjesín. El participio de aanzien carga en aan, áanjesin, como todo verbo separable.

📐 Conjugacion de aanzien (fuerte · separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | zie aan | zag aan |
| jij / je | ziet aan | zag aan |
| u | ziet aan | zag aan |
| hij / zij / het | ziet aan | zag aan |
| wij | zien aan | zagen aan |
| jullie | zien aan | zagen aan |
| zij (plural) | zien aan | zagen aan |

• participio — aangezien, con hebben: Ze hebben me voor een toerist aangezien. En pasiva, con worden: Ik werd voor een toerist aangezien.
• preposicion — voor, iemand aanzien voor iets: tomar a alguien por algo.
• separable — sí: Ze zagen me voor een Duitser AAN, y en infinitivo aan te zien.
• sustantivo — het aanzien, el prestigio: een man van aanzien, un hombre de prestigio.
• expresion hecha — Het is niet om aan te zien, da pena verlo, es horroroso.
• antonimo — no tiene uno claro.

🔑 El truco que casi nunca falla: Si en español cabe «visto que» o «puesto que», es aangezien. Si es «ya que estás» dicho en casa, es nu. Y si es un «porque» normal, omdat.

⚠️ Trampa 1. aangezien suena a correo, reunión o explicación seria. En la charla de casa se dice omdat, o nu para el «ya que».

⚠️ Trampa 2. No se dice «aangezien dat»: esa forma es antigua. Detrás va directamente la frase, aangezien het regent.

⚠️ Trampa 3. Si ves voor … aangezien al final, es el participio de aanzien, tomar por, y no tiene nada de causa.

🏋️ Ejercicio:
• Como ya es tarde, nos vamos → (Aangezien het al laat is, gaan we)
• Ya que estás aquí, ayúdame → (Nu je hier toch bent, help me even)
• Me tomaron por alemán → (Ik werd voor een Duitser aangezien)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'dado que, puesto que, ya que');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'dado que, puesto que, ya que' LIMIT 1), 'nl_NL', 'aangezien', 'aanjesín', '• [inv.] Aangezien je toch thuis bent, kun je de was doen. — Ya que estás en casa, puedes poner la lavadora.
• [perf.] Aangezien hij niet gereageerd heeft, bel ik hem morgen. — Como no ha contestado, lo llamo mañana.
• [verl.] Aangezien de trein vertraging had, kwam ik te laat. — Como el tren llevaba retraso, llegué tarde.
• [bijzin] We blijven binnen, aangezien het zo hard regent. — Nos quedamos dentro, ya que llueve tanto.
• [formeel] Aangezien u niet aanwezig was, sturen wij u het verslag. — Puesto que usted no estuvo presente, le enviamos el acta.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'dado que, puesto que, ya que' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'dado que, puesto que, ya que' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

-- 2) Frases habladas

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Ya que estás en casa, puedes poner la lavadora. (inv)', 'SENTENCE', 'Ejemplo de "aangezien" (inv.)', 'AANGEZIEN JE TOCH THUIS BENT = ya que estás en casa. toch es «de todas formas», el «ya que estás» español. Subordinada delante: bent se va al final y la principal invierte, KUN JE. de was doen es hacer la colada.

🧷 Aangezien — dado que, y su gemelo el participio de aanzien:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | porque | **omdat** | lo normal al hablar, causa con motivo |
| 2 | pues, que | **want** | coordinante, no manda el verbo al final |
| 3 | dado que, puesto que, visto que | **aangezien** | algo formal, causa que los dos ya conocen |
| 4 | ya que estás, ahora que | **nu** | la versión hablada: Nu je hier toch bent, … |
| 5 | porque, sin voluntad | **doordat** | efecto material: Doordat het glad was, viel ik |
| 6 | tomar a alguien por | **iemand aanzien voor** | participio aangezien: Ik werd voor een Duitser aangezien |

🧠 La imagen de la palabra es aan-ge-zien, «visto». Aangezien het laat is es visto que es tarde, y por eso presenta una causa que ya está a la vista de todos.

📐 Es subordinante y manda el verbo al final de su parte, aangezien het laat IS. Si va delante, la principal invierte, Aangezien het laat is, GAAN WE. Si va detrás, la principal queda normal, We gaan, aangezien het laat is.

🔊 El acento distingue a los gemelos. La conjunción carga en zien, aanjesín. El participio de aanzien carga en aan, áanjesin, como todo verbo separable.

📐 Conjugacion de aanzien (fuerte · separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | zie aan | zag aan |
| jij / je | ziet aan | zag aan |
| u | ziet aan | zag aan |
| hij / zij / het | ziet aan | zag aan |
| wij | zien aan | zagen aan |
| jullie | zien aan | zagen aan |
| zij (plural) | zien aan | zagen aan |

• participio — aangezien, con hebben: Ze hebben me voor een toerist aangezien. En pasiva, con worden: Ik werd voor een toerist aangezien.
• preposicion — voor, iemand aanzien voor iets: tomar a alguien por algo.
• separable — sí: Ze zagen me voor een Duitser AAN, y en infinitivo aan te zien.
• sustantivo — het aanzien, el prestigio: een man van aanzien, un hombre de prestigio.
• expresion hecha — Het is niet om aan te zien, da pena verlo, es horroroso.
• antonimo — no tiene uno claro.

🔑 El truco que casi nunca falla: Si en español cabe «visto que» o «puesto que», es aangezien. Si es «ya que estás» dicho en casa, es nu. Y si es un «porque» normal, omdat.

⚠️ Trampa 1. aangezien suena a correo, reunión o explicación seria. En la charla de casa se dice omdat, o nu para el «ya que».

⚠️ Trampa 2. No se dice «aangezien dat»: esa forma es antigua. Detrás va directamente la frase, aangezien het regent.

⚠️ Trampa 3. Si ves voor … aangezien al final, es el participio de aanzien, tomar por, y no tiene nada de causa.

🏋️ Ejercicio:
• Como ya es tarde, nos vamos → (Aangezien het al laat is, gaan we)
• Ya que estás aquí, ayúdame → (Nu je hier toch bent, help me even)
• Me tomaron por alemán → (Ik werd voor een Duitser aangezien)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ya que estás en casa, puedes poner la lavadora. (inv)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya que estás en casa, puedes poner la lavadora. (inv)' LIMIT 1), 'nl_NL', 'Aangezien je toch thuis bent, kun je de was doen.', 'aanjesín ie toj töis bent, kun ie de uas dun');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya que estás en casa, puedes poner la lavadora. (inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ya que estás en casa, puedes poner la lavadora. (inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'dado que, puesto que, ya que' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Ya que estás en casa, puedes poner la lavadora. (inv)' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Como no ha contestado, lo llamo mañana. (él, inv)', 'SENTENCE', 'Ejemplo de "aangezien" (perf.)', 'AANGEZIEN HIJ NIET GEREAGEERD HEEFT = como no ha contestado. En la subordinada el perfecto va al final, participio y luego heeft (también vale heeft gereageerd). Después invierte la principal, BEL IK. reageren es contestar a un mensaje; antwoorden es responder a una pregunta.

🧷 Aangezien — dado que, y su gemelo el participio de aanzien:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | porque | **omdat** | lo normal al hablar, causa con motivo |
| 2 | pues, que | **want** | coordinante, no manda el verbo al final |
| 3 | dado que, puesto que, visto que | **aangezien** | algo formal, causa que los dos ya conocen |
| 4 | ya que estás, ahora que | **nu** | la versión hablada: Nu je hier toch bent, … |
| 5 | porque, sin voluntad | **doordat** | efecto material: Doordat het glad was, viel ik |
| 6 | tomar a alguien por | **iemand aanzien voor** | participio aangezien: Ik werd voor een Duitser aangezien |

🧠 La imagen de la palabra es aan-ge-zien, «visto». Aangezien het laat is es visto que es tarde, y por eso presenta una causa que ya está a la vista de todos.

📐 Es subordinante y manda el verbo al final de su parte, aangezien het laat IS. Si va delante, la principal invierte, Aangezien het laat is, GAAN WE. Si va detrás, la principal queda normal, We gaan, aangezien het laat is.

🔊 El acento distingue a los gemelos. La conjunción carga en zien, aanjesín. El participio de aanzien carga en aan, áanjesin, como todo verbo separable.

📐 Conjugacion de aanzien (fuerte · separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | zie aan | zag aan |
| jij / je | ziet aan | zag aan |
| u | ziet aan | zag aan |
| hij / zij / het | ziet aan | zag aan |
| wij | zien aan | zagen aan |
| jullie | zien aan | zagen aan |
| zij (plural) | zien aan | zagen aan |

• participio — aangezien, con hebben: Ze hebben me voor een toerist aangezien. En pasiva, con worden: Ik werd voor een toerist aangezien.
• preposicion — voor, iemand aanzien voor iets: tomar a alguien por algo.
• separable — sí: Ze zagen me voor een Duitser AAN, y en infinitivo aan te zien.
• sustantivo — het aanzien, el prestigio: een man van aanzien, un hombre de prestigio.
• expresion hecha — Het is niet om aan te zien, da pena verlo, es horroroso.
• antonimo — no tiene uno claro.

🔑 El truco que casi nunca falla: Si en español cabe «visto que» o «puesto que», es aangezien. Si es «ya que estás» dicho en casa, es nu. Y si es un «porque» normal, omdat.

⚠️ Trampa 1. aangezien suena a correo, reunión o explicación seria. En la charla de casa se dice omdat, o nu para el «ya que».

⚠️ Trampa 2. No se dice «aangezien dat»: esa forma es antigua. Detrás va directamente la frase, aangezien het regent.

⚠️ Trampa 3. Si ves voor … aangezien al final, es el participio de aanzien, tomar por, y no tiene nada de causa.

🏋️ Ejercicio:
• Como ya es tarde, nos vamos → (Aangezien het al laat is, gaan we)
• Ya que estás aquí, ayúdame → (Nu je hier toch bent, help me even)
• Me tomaron por alemán → (Ik werd voor een Duitser aangezien)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Como no ha contestado, lo llamo mañana. (él, inv)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Como no ha contestado, lo llamo mañana. (él, inv)' LIMIT 1), 'nl_NL', 'Aangezien hij niet gereageerd heeft, bel ik hem morgen.', 'aanjesín hei nit jereajéert heeft, bel ik em mórjen');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Como no ha contestado, lo llamo mañana. (él, inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Como no ha contestado, lo llamo mañana. (él, inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'dado que, puesto que, ya que' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Como no ha contestado, lo llamo mañana. (él, inv)' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Como el tren llevaba retraso, llegué tarde. (inv)', 'SENTENCE', 'Ejemplo de "aangezien" (verl.)', 'AANGEZIEN DE TREIN VERTRAGING HAD = como el tren llevaba retraso. Pasado en las dos partes: had al final de la subordinada y KWAM IK invertido. vertraging hebben es llevar retraso. Al hablar oirás más doordat u omdat; aangezien suena a explicación seria, por ejemplo a tu jefe.

🧷 Aangezien — dado que, y su gemelo el participio de aanzien:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | porque | **omdat** | lo normal al hablar, causa con motivo |
| 2 | pues, que | **want** | coordinante, no manda el verbo al final |
| 3 | dado que, puesto que, visto que | **aangezien** | algo formal, causa que los dos ya conocen |
| 4 | ya que estás, ahora que | **nu** | la versión hablada: Nu je hier toch bent, … |
| 5 | porque, sin voluntad | **doordat** | efecto material: Doordat het glad was, viel ik |
| 6 | tomar a alguien por | **iemand aanzien voor** | participio aangezien: Ik werd voor een Duitser aangezien |

🧠 La imagen de la palabra es aan-ge-zien, «visto». Aangezien het laat is es visto que es tarde, y por eso presenta una causa que ya está a la vista de todos.

📐 Es subordinante y manda el verbo al final de su parte, aangezien het laat IS. Si va delante, la principal invierte, Aangezien het laat is, GAAN WE. Si va detrás, la principal queda normal, We gaan, aangezien het laat is.

🔊 El acento distingue a los gemelos. La conjunción carga en zien, aanjesín. El participio de aanzien carga en aan, áanjesin, como todo verbo separable.

📐 Conjugacion de aanzien (fuerte · separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | zie aan | zag aan |
| jij / je | ziet aan | zag aan |
| u | ziet aan | zag aan |
| hij / zij / het | ziet aan | zag aan |
| wij | zien aan | zagen aan |
| jullie | zien aan | zagen aan |
| zij (plural) | zien aan | zagen aan |

• participio — aangezien, con hebben: Ze hebben me voor een toerist aangezien. En pasiva, con worden: Ik werd voor een toerist aangezien.
• preposicion — voor, iemand aanzien voor iets: tomar a alguien por algo.
• separable — sí: Ze zagen me voor een Duitser AAN, y en infinitivo aan te zien.
• sustantivo — het aanzien, el prestigio: een man van aanzien, un hombre de prestigio.
• expresion hecha — Het is niet om aan te zien, da pena verlo, es horroroso.
• antonimo — no tiene uno claro.

🔑 El truco que casi nunca falla: Si en español cabe «visto que» o «puesto que», es aangezien. Si es «ya que estás» dicho en casa, es nu. Y si es un «porque» normal, omdat.

⚠️ Trampa 1. aangezien suena a correo, reunión o explicación seria. En la charla de casa se dice omdat, o nu para el «ya que».

⚠️ Trampa 2. No se dice «aangezien dat»: esa forma es antigua. Detrás va directamente la frase, aangezien het regent.

⚠️ Trampa 3. Si ves voor … aangezien al final, es el participio de aanzien, tomar por, y no tiene nada de causa.

🏋️ Ejercicio:
• Como ya es tarde, nos vamos → (Aangezien het al laat is, gaan we)
• Ya que estás aquí, ayúdame → (Nu je hier toch bent, help me even)
• Me tomaron por alemán → (Ik werd voor een Duitser aangezien)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Como el tren llevaba retraso, llegué tarde. (inv)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Como el tren llevaba retraso, llegué tarde. (inv)' LIMIT 1), 'nl_NL', 'Aangezien de trein vertraging had, kwam ik te laat.', 'aanjesín de trein fertráajing hat, kuam ik te laat');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Como el tren llevaba retraso, llegué tarde. (inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Como el tren llevaba retraso, llegué tarde. (inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'dado que, puesto que, ya que' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Como el tren llevaba retraso, llegué tarde. (inv)' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Nos quedamos dentro, ya que llueve tanto.', 'SENTENCE', 'Ejemplo de "aangezien" (bijzin)', 'WE BLIJVEN BINNEN, AANGEZIEN … = nos quedamos dentro, ya que … Con la subordinada detrás, la principal va en orden normal (we blijven) y solo cambia la parte de aangezien: regent al final. zo hard regenen es llover tan fuerte.

🧷 Aangezien — dado que, y su gemelo el participio de aanzien:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | porque | **omdat** | lo normal al hablar, causa con motivo |
| 2 | pues, que | **want** | coordinante, no manda el verbo al final |
| 3 | dado que, puesto que, visto que | **aangezien** | algo formal, causa que los dos ya conocen |
| 4 | ya que estás, ahora que | **nu** | la versión hablada: Nu je hier toch bent, … |
| 5 | porque, sin voluntad | **doordat** | efecto material: Doordat het glad was, viel ik |
| 6 | tomar a alguien por | **iemand aanzien voor** | participio aangezien: Ik werd voor een Duitser aangezien |

🧠 La imagen de la palabra es aan-ge-zien, «visto». Aangezien het laat is es visto que es tarde, y por eso presenta una causa que ya está a la vista de todos.

📐 Es subordinante y manda el verbo al final de su parte, aangezien het laat IS. Si va delante, la principal invierte, Aangezien het laat is, GAAN WE. Si va detrás, la principal queda normal, We gaan, aangezien het laat is.

🔊 El acento distingue a los gemelos. La conjunción carga en zien, aanjesín. El participio de aanzien carga en aan, áanjesin, como todo verbo separable.

📐 Conjugacion de aanzien (fuerte · separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | zie aan | zag aan |
| jij / je | ziet aan | zag aan |
| u | ziet aan | zag aan |
| hij / zij / het | ziet aan | zag aan |
| wij | zien aan | zagen aan |
| jullie | zien aan | zagen aan |
| zij (plural) | zien aan | zagen aan |

• participio — aangezien, con hebben: Ze hebben me voor een toerist aangezien. En pasiva, con worden: Ik werd voor een toerist aangezien.
• preposicion — voor, iemand aanzien voor iets: tomar a alguien por algo.
• separable — sí: Ze zagen me voor een Duitser AAN, y en infinitivo aan te zien.
• sustantivo — het aanzien, el prestigio: een man van aanzien, un hombre de prestigio.
• expresion hecha — Het is niet om aan te zien, da pena verlo, es horroroso.
• antonimo — no tiene uno claro.

🔑 El truco que casi nunca falla: Si en español cabe «visto que» o «puesto que», es aangezien. Si es «ya que estás» dicho en casa, es nu. Y si es un «porque» normal, omdat.

⚠️ Trampa 1. aangezien suena a correo, reunión o explicación seria. En la charla de casa se dice omdat, o nu para el «ya que».

⚠️ Trampa 2. No se dice «aangezien dat»: esa forma es antigua. Detrás va directamente la frase, aangezien het regent.

⚠️ Trampa 3. Si ves voor … aangezien al final, es el participio de aanzien, tomar por, y no tiene nada de causa.

🏋️ Ejercicio:
• Como ya es tarde, nos vamos → (Aangezien het al laat is, gaan we)
• Ya que estás aquí, ayúdame → (Nu je hier toch bent, help me even)
• Me tomaron por alemán → (Ik werd voor een Duitser aangezien)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Nos quedamos dentro, ya que llueve tanto.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Nos quedamos dentro, ya que llueve tanto.' LIMIT 1), 'nl_NL', 'We blijven binnen, aangezien het zo hard regent.', 'ue bléifen bínen, aanjesín et so hart réjent');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Nos quedamos dentro, ya que llueve tanto.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Nos quedamos dentro, ya que llueve tanto.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'dado que, puesto que, ya que' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Nos quedamos dentro, ya que llueve tanto.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Puesto que usted no estuvo presente, le enviamos el acta. (inv)', 'SENTENCE', 'Ejemplo de "aangezien" (formeel)', 'AANGEZIEN U NIET AANWEZIG WAS = puesto que usted no estuvo presente. Es el terreno natural de aangezien: un correo de trabajo o una carta. aanwezig es presente; het verslag, el acta o el informe. Invierte la principal, STUREN WIJ.

🧷 Aangezien — dado que, y su gemelo el participio de aanzien:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | porque | **omdat** | lo normal al hablar, causa con motivo |
| 2 | pues, que | **want** | coordinante, no manda el verbo al final |
| 3 | dado que, puesto que, visto que | **aangezien** | algo formal, causa que los dos ya conocen |
| 4 | ya que estás, ahora que | **nu** | la versión hablada: Nu je hier toch bent, … |
| 5 | porque, sin voluntad | **doordat** | efecto material: Doordat het glad was, viel ik |
| 6 | tomar a alguien por | **iemand aanzien voor** | participio aangezien: Ik werd voor een Duitser aangezien |

🧠 La imagen de la palabra es aan-ge-zien, «visto». Aangezien het laat is es visto que es tarde, y por eso presenta una causa que ya está a la vista de todos.

📐 Es subordinante y manda el verbo al final de su parte, aangezien het laat IS. Si va delante, la principal invierte, Aangezien het laat is, GAAN WE. Si va detrás, la principal queda normal, We gaan, aangezien het laat is.

🔊 El acento distingue a los gemelos. La conjunción carga en zien, aanjesín. El participio de aanzien carga en aan, áanjesin, como todo verbo separable.

📐 Conjugacion de aanzien (fuerte · separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | zie aan | zag aan |
| jij / je | ziet aan | zag aan |
| u | ziet aan | zag aan |
| hij / zij / het | ziet aan | zag aan |
| wij | zien aan | zagen aan |
| jullie | zien aan | zagen aan |
| zij (plural) | zien aan | zagen aan |

• participio — aangezien, con hebben: Ze hebben me voor een toerist aangezien. En pasiva, con worden: Ik werd voor een toerist aangezien.
• preposicion — voor, iemand aanzien voor iets: tomar a alguien por algo.
• separable — sí: Ze zagen me voor een Duitser AAN, y en infinitivo aan te zien.
• sustantivo — het aanzien, el prestigio: een man van aanzien, un hombre de prestigio.
• expresion hecha — Het is niet om aan te zien, da pena verlo, es horroroso.
• antonimo — no tiene uno claro.

🔑 El truco que casi nunca falla: Si en español cabe «visto que» o «puesto que», es aangezien. Si es «ya que estás» dicho en casa, es nu. Y si es un «porque» normal, omdat.

⚠️ Trampa 1. aangezien suena a correo, reunión o explicación seria. En la charla de casa se dice omdat, o nu para el «ya que».

⚠️ Trampa 2. No se dice «aangezien dat»: esa forma es antigua. Detrás va directamente la frase, aangezien het regent.

⚠️ Trampa 3. Si ves voor … aangezien al final, es el participio de aanzien, tomar por, y no tiene nada de causa.

🏋️ Ejercicio:
• Como ya es tarde, nos vamos → (Aangezien het al laat is, gaan we)
• Ya que estás aquí, ayúdame → (Nu je hier toch bent, help me even)
• Me tomaron por alemán → (Ik werd voor een Duitser aangezien)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Puesto que usted no estuvo presente, le enviamos el acta. (inv)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Puesto que usted no estuvo presente, le enviamos el acta. (inv)' LIMIT 1), 'nl_NL', 'Aangezien u niet aanwezig was, sturen wij u het verslag.', 'aanjesín u nit aanuésij uas, stúuren uei u et ferslaj');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Puesto que usted no estuvo presente, le enviamos el acta. (inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Puesto que usted no estuvo presente, le enviamos el acta. (inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'dado que, puesto que, ya que' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Puesto que usted no estuvo presente, le enviamos el acta. (inv)' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me tomaron por un turista.', 'SENTENCE', 'Ejemplo de "aanzien" (perf.)', 'IEMAND VOOR … AANZIEN = tomar a alguien por … Aquí aangezien NO es «dado que»: es el participio de aanzien, en pasiva con werd. Se nota en el acento, ÁAN-gezien, y en que va al final con voor delante. También vale Ze zagen me voor een toerist aan.

🧷 Aangezien — dado que, y su gemelo el participio de aanzien:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | porque | **omdat** | lo normal al hablar, causa con motivo |
| 2 | pues, que | **want** | coordinante, no manda el verbo al final |
| 3 | dado que, puesto que, visto que | **aangezien** | algo formal, causa que los dos ya conocen |
| 4 | ya que estás, ahora que | **nu** | la versión hablada: Nu je hier toch bent, … |
| 5 | porque, sin voluntad | **doordat** | efecto material: Doordat het glad was, viel ik |
| 6 | tomar a alguien por | **iemand aanzien voor** | participio aangezien: Ik werd voor een Duitser aangezien |

🧠 La imagen de la palabra es aan-ge-zien, «visto». Aangezien het laat is es visto que es tarde, y por eso presenta una causa que ya está a la vista de todos.

📐 Es subordinante y manda el verbo al final de su parte, aangezien het laat IS. Si va delante, la principal invierte, Aangezien het laat is, GAAN WE. Si va detrás, la principal queda normal, We gaan, aangezien het laat is.

🔊 El acento distingue a los gemelos. La conjunción carga en zien, aanjesín. El participio de aanzien carga en aan, áanjesin, como todo verbo separable.

📐 Conjugacion de aanzien (fuerte · separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | zie aan | zag aan |
| jij / je | ziet aan | zag aan |
| u | ziet aan | zag aan |
| hij / zij / het | ziet aan | zag aan |
| wij | zien aan | zagen aan |
| jullie | zien aan | zagen aan |
| zij (plural) | zien aan | zagen aan |

• participio — aangezien, con hebben: Ze hebben me voor een toerist aangezien. En pasiva, con worden: Ik werd voor een toerist aangezien.
• preposicion — voor, iemand aanzien voor iets: tomar a alguien por algo.
• separable — sí: Ze zagen me voor een Duitser AAN, y en infinitivo aan te zien.
• sustantivo — het aanzien, el prestigio: een man van aanzien, un hombre de prestigio.
• expresion hecha — Het is niet om aan te zien, da pena verlo, es horroroso.
• antonimo — no tiene uno claro.

🔑 El truco que casi nunca falla: Si en español cabe «visto que» o «puesto que», es aangezien. Si es «ya que estás» dicho en casa, es nu. Y si es un «porque» normal, omdat.

⚠️ Trampa 1. aangezien suena a correo, reunión o explicación seria. En la charla de casa se dice omdat, o nu para el «ya que».

⚠️ Trampa 2. No se dice «aangezien dat»: esa forma es antigua. Detrás va directamente la frase, aangezien het regent.

⚠️ Trampa 3. Si ves voor … aangezien al final, es el participio de aanzien, tomar por, y no tiene nada de causa.

🏋️ Ejercicio:
• Como ya es tarde, nos vamos → (Aangezien het al laat is, gaan we)
• Ya que estás aquí, ayúdame → (Nu je hier toch bent, help me even)
• Me tomaron por alemán → (Ik werd voor een Duitser aangezien)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me tomaron por un turista.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me tomaron por un turista.' LIMIT 1), 'nl_NL', 'Ik werd voor een toerist aangezien.', 'ik uert foor en turíst áanjesin');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me tomaron por un turista.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me tomaron por un turista.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'dado que, puesto que, ya que' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Me tomaron por un turista.' LIMIT 1), 'EXAMPLE');
