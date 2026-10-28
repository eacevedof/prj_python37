-- Learn Languages App - Migration
-- Migration: 20261022000001-kwetsbaar-vulnerable
-- Description: Eduardo: "en palabras dificiles, vulnerable, recuerda con frases habladas muy usadas".
--
--   No habia nada de kwetsbaar en el mazo. Se mete en el grupo 28 «palabras dificiles» (y en generic):
--   1. Dos tarjetas WORD con sus 5 frases en notes y la tabla 🗣️ en la ayuda: vulnerable -> kwetsbaar
--      y la vulnerabilidad -> de kwetsbaarheid.
--   2. 11 frases SENTENCE habladas colgadas con EXAMPLE: zich kwetsbaar voelen, zich kwetsbaar
--      opstellen (2), extra kwetsbaar, nog heel kwetsbaar, kwetsbaar voor, omdat, gekwetst,
--      vatbaar voor (la trampa), kwetsbaarheid tonen y la vulnerabilidad informatica.
--      Marcas: (inv) en 2, (ella) en 1, (el) en 2.
--   3. Bloque compartido «🛡️ Vulnerable — kwetsbaar y sus rivales» en las 13: mapa de 9 formas
--      (kwetsbaar, vatbaar, gevoelig, weerloos, de zwakke plek, onkwetsbaar/weerbaar), la imagen
--      kwets-baar = herible, truco, regla de bolsillo, cuatro trampas y ejercicio.
--   4. 🧩 zich kwetsbaar opstellen (madre y 2 frases) y la ficha del verbo kwetsen (madre y la frase
--      de gekwetst): sin antonimo claro, transitivo directo, no separable.
--
--   Tarjetas nuevas sin audio.

PRAGMA foreign_keys = ON;


-- 1) Tarjetas madre

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'vulnerable', 'WORD', 'dificil: kwetsbaar (vulnerable)', 'kwetsbaar = vulnerable, frágil: que se puede herir, en el cuerpo o en los sentimientos. Con algo detrás rige voor (kwetsbaar voor aanvallen). Y la frase más hablada es zich kwetsbaar opstellen, abrirse.

🗣️ Cinco usos, alternando tiempo y persona:

| # | etiqueta | neerlandés | español |
|---|---|---|---|
| 1 | can. | Ik voel me een beetje kwetsbaar. | Me siento un poco vulnerable. |
| 2 | perf. | Ze heeft zich heel kwetsbaar opgesteld. | Se ha mostrado muy vulnerable. |
| 3 | inv. | Na de operatie was hij nog heel kwetsbaar. | Tras la operación seguía muy vulnerable. |
| 4 | geb. | Durf je kwetsbaar op te stellen. | Atrévete a mostrarte vulnerable. |
| 5 | bijzin | Hij zei het omdat hij zich kwetsbaar voelde. | Lo dijo porque se sentía vulnerable. |

🛡️ Vulnerable — kwetsbaar y sus rivales:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | vulnerable, frágil, que se puede herir | **kwetsbaar** | lo normal: personas, grupos, sistemas, la naturaleza |
| 2 | vulnerable a algo | **kwetsbaar voor** | Het systeem is kwetsbaar voor aanvallen |
| 3 | mostrarse vulnerable, abrirse | **zich kwetsbaar opstellen** | lo más hablado: emociones, pareja, trabajo |
| 4 | la vulnerabilidad, el fallo de seguridad | **de kwetsbaarheid** | personas y también software |
| 5 | propenso a pillar algo | **vatbaar voor** | Ik ben vatbaar voor verkoudheid |
| 6 | sensible, susceptible | **gevoelig (voor)** | la piel, un tema, una persona que se ofende |
| 7 | indefenso | **weerloos** | no puede defenderse en absoluto |
| 8 | el punto débil | **de zwakke plek** | Dat is zijn zwakke plek |
| 9 | invulnerable · resiliente | **onkwetsbaar** · **weerbaar** | los contrarios |

🧠 La imagen de la palabra es kwets-baar, «herible». Viene de kwetsen (herir) + -baar (-ble), como eetbaar (comestible) o drinkbaar (bebible). Lo vulnerable es lo que se puede herir.

🔑 El truco que casi nunca falla: Si el español dice «vulnerable», es kwetsbaar; si dice «propenso a pillar» algo (un resfriado, una infección), es vatbaar voor.

📌 Regla de bolsillo:
• ¿Se le puede hacer daño, en el cuerpo o en los sentimientos? → kwetsbaar.
• ¿Pilla enfermedades con facilidad? → vatbaar voor.
• ¿Reacciona mucho, se ofende o le escuece? → gevoelig.
• ¿No puede defenderse en absoluto? → weerloos.

⚠️ Trampa 1. kwetsbaar no es «débil» a secas: un niño débil es een zwak kind; kwetsbaar es que se le puede hacer daño.

⚠️ Trampa 2. Para enfermedades no se dice «kwetsbaar voor griep» sino vatbaar voor griep.

⚠️ Trampa 3. zich kwetsbaar opstellen es algo bueno en neerlandés, abrirse con sinceridad. Se oye en el trabajo, en terapia y en pareja.

⚠️ Trampa 4. Como adjetivo delante del sustantivo lleva -e (een kwetsbare groep, kwetsbare ouderen) y detrás del verbo no (hij is kwetsbaar). Comparativo kwetsbaarder.

🏋️ Ejercicio:
• Los niños pequeños son muy … → (kwetsbaar)
• Soy muy propenso a los resfriados → (Ik ben erg vatbaar voor verkoudheid)
• Atrévete a mostrarte vulnerable → (Durf je kwetsbaar op te stellen)
• Tengo la piel muy sensible → (Ik heb een erg gevoelige huid)

🧩 Expresión fija — zich kwetsbaar opstellen:

• literal — colocarse vulnerable, ponerse donde te pueden herir.
• significa — abrirse, enseñar lo que sientes o lo que no sabes, sin coraza.
• piezas fijas — el reflexivo (me, je, zich, ons) y opstellen, que es separable. La partícula op se va al final y el ge- se mete dentro (opgesteld, con hebben).

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | presente | Hij stelt zich nooit kwetsbaar op. | Nunca se muestra vulnerable. |
| 2 | perfecto | Ze heeft zich heel kwetsbaar opgesteld. | Se ha mostrado muy vulnerable. |
| 3 | con te | Durf je kwetsbaar op te stellen. | Atrévete a mostrarte vulnerable. |
| 4 | subordinada | … omdat hij zich kwetsbaar opstelde. | … porque se abrió. |

• variante — zich kwetsbaar tonen, casi lo mismo.
• opstellen — débil y separable. Presente ik stel op, jij stelt op, wij stellen op; imperfecto stelde op, stelden op; participio opgesteld con hebben. Fuera de la expresión es redactar (een brief opstellen) o colocar.

🔑 El truco que casi nunca falla: Si en español «te abres» o «bajas la guardia», en neerlandés je stelt je kwetsbaar op.

📐 Conjugacion de kwetsen (débil · no separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | kwets | kwetste |
| jij / je | kwetst | kwetste |
| u | kwetst | kwetste |
| hij / zij / het | kwetst | kwetste |
| wij | kwetsen | kwetsten |
| jullie | kwetsen | kwetsten |
| zij (plural) | kwetsen | kwetsten |

• participio — gekwetst, con hebben: Je hebt me gekwetst. Y como adjetivo, gekwetst es dolido: Ik voel me gekwetst.
• al invertir, jij pierde la -t: Kwets jij hem niet? — no «kwetst jij».
• preposicion — no rige ninguna, es transitivo directo: iemand kwetsen. Es herir sobre todo los sentimientos; la herida física es verwonden.
• separable — no, es un verbo simple y el ge- va delante (gekwetst).
• antonimo — no tiene uno claro; lo más cercano es troosten (consolar).
• sustantivo — de kwetsuur (la lesión, en deporte) y de kwetsbaarheid (la vulnerabilidad).
• expresion hecha — iemands gevoelens kwetsen, herir los sentimientos de alguien. Y Dat kwetst me, eso me duele.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'vulnerable');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'vulnerable' LIMIT 1), 'nl_NL', 'kwetsbaar', 'kuétsbaar', '• [can.] Ik voel me een beetje kwetsbaar. — Me siento un poco vulnerable.
• [perf.] Ze heeft zich heel kwetsbaar opgesteld. — Se ha mostrado muy vulnerable.
• [inv.] Na de operatie was hij nog heel kwetsbaar. — Tras la operación seguía muy vulnerable.
• [geb.] Durf je kwetsbaar op te stellen. — Atrévete a mostrarte vulnerable.
• [bijzin] Hij zei het omdat hij zich kwetsbaar voelde. — Lo dijo porque se sentía vulnerable.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'vulnerable' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'vulnerable' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la vulnerabilidad', 'WORD', 'dificil: de kwetsbaarheid (la vulnerabilidad)', 'de kwetsbaarheid = la vulnerabilidad. Como todo -heid, es de-woord. En informática es también el fallo de seguridad (een kwetsbaarheid, o het lek).

🗣️ Cinco usos, alternando tiempo y persona:

| # | etiqueta | neerlandés | español |
|---|---|---|---|
| 1 | can. | Kwetsbaarheid tonen is geen zwakte. | Mostrar vulnerabilidad no es debilidad. |
| 2 | perf. | Ze hebben een kwetsbaarheid in de app gevonden. | Han encontrado una vulnerabilidad en la aplicación. |
| 3 | can. | Zijn kwetsbaarheid maakt hem menselijk. | Su vulnerabilidad lo hace humano. |
| 4 | inv. | In een relatie hoort kwetsbaarheid erbij. | En una relación, la vulnerabilidad va incluida. |
| 5 | uitdr. | de kwetsbaarheid van ouderen | la vulnerabilidad de los mayores |

🛡️ Vulnerable — kwetsbaar y sus rivales:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | vulnerable, frágil, que se puede herir | **kwetsbaar** | lo normal: personas, grupos, sistemas, la naturaleza |
| 2 | vulnerable a algo | **kwetsbaar voor** | Het systeem is kwetsbaar voor aanvallen |
| 3 | mostrarse vulnerable, abrirse | **zich kwetsbaar opstellen** | lo más hablado: emociones, pareja, trabajo |
| 4 | la vulnerabilidad, el fallo de seguridad | **de kwetsbaarheid** | personas y también software |
| 5 | propenso a pillar algo | **vatbaar voor** | Ik ben vatbaar voor verkoudheid |
| 6 | sensible, susceptible | **gevoelig (voor)** | la piel, un tema, una persona que se ofende |
| 7 | indefenso | **weerloos** | no puede defenderse en absoluto |
| 8 | el punto débil | **de zwakke plek** | Dat is zijn zwakke plek |
| 9 | invulnerable · resiliente | **onkwetsbaar** · **weerbaar** | los contrarios |

🧠 La imagen de la palabra es kwets-baar, «herible». Viene de kwetsen (herir) + -baar (-ble), como eetbaar (comestible) o drinkbaar (bebible). Lo vulnerable es lo que se puede herir.

🔑 El truco que casi nunca falla: Si el español dice «vulnerable», es kwetsbaar; si dice «propenso a pillar» algo (un resfriado, una infección), es vatbaar voor.

📌 Regla de bolsillo:
• ¿Se le puede hacer daño, en el cuerpo o en los sentimientos? → kwetsbaar.
• ¿Pilla enfermedades con facilidad? → vatbaar voor.
• ¿Reacciona mucho, se ofende o le escuece? → gevoelig.
• ¿No puede defenderse en absoluto? → weerloos.

⚠️ Trampa 1. kwetsbaar no es «débil» a secas: un niño débil es een zwak kind; kwetsbaar es que se le puede hacer daño.

⚠️ Trampa 2. Para enfermedades no se dice «kwetsbaar voor griep» sino vatbaar voor griep.

⚠️ Trampa 3. zich kwetsbaar opstellen es algo bueno en neerlandés, abrirse con sinceridad. Se oye en el trabajo, en terapia y en pareja.

⚠️ Trampa 4. Como adjetivo delante del sustantivo lleva -e (een kwetsbare groep, kwetsbare ouderen) y detrás del verbo no (hij is kwetsbaar). Comparativo kwetsbaarder.

🏋️ Ejercicio:
• Los niños pequeños son muy … → (kwetsbaar)
• Soy muy propenso a los resfriados → (Ik ben erg vatbaar voor verkoudheid)
• Atrévete a mostrarte vulnerable → (Durf je kwetsbaar op te stellen)
• Tengo la piel muy sensible → (Ik heb een erg gevoelige huid)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la vulnerabilidad');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la vulnerabilidad' LIMIT 1), 'nl_NL', 'de kwetsbaarheid', 'de kuétsbaarheit', '• [can.] Kwetsbaarheid tonen is geen zwakte. — Mostrar vulnerabilidad no es debilidad.
• [perf.] Ze hebben een kwetsbaarheid in de app gevonden. — Han encontrado una vulnerabilidad en la aplicación.
• [can.] Zijn kwetsbaarheid maakt hem menselijk. — Su vulnerabilidad lo hace humano.
• [inv.] In een relatie hoort kwetsbaarheid erbij. — En una relación, la vulnerabilidad va incluida.
• [uitdr.] de kwetsbaarheid van ouderen — la vulnerabilidad de los mayores.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la vulnerabilidad' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la vulnerabilidad' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));


-- 2) Frases habladas

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Me siento un poco vulnerable.', 'SENTENCE', 'Ejemplo de "kwetsbaar" (can.)', 'ZICH KWETSBAAR VOELEN = sentirse vulnerable. Sentirse es reflexivo, ik voel me, y een beetje es el «un poco» de cantidad.

🛡️ Vulnerable — kwetsbaar y sus rivales:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | vulnerable, frágil, que se puede herir | **kwetsbaar** | lo normal: personas, grupos, sistemas, la naturaleza |
| 2 | vulnerable a algo | **kwetsbaar voor** | Het systeem is kwetsbaar voor aanvallen |
| 3 | mostrarse vulnerable, abrirse | **zich kwetsbaar opstellen** | lo más hablado: emociones, pareja, trabajo |
| 4 | la vulnerabilidad, el fallo de seguridad | **de kwetsbaarheid** | personas y también software |
| 5 | propenso a pillar algo | **vatbaar voor** | Ik ben vatbaar voor verkoudheid |
| 6 | sensible, susceptible | **gevoelig (voor)** | la piel, un tema, una persona que se ofende |
| 7 | indefenso | **weerloos** | no puede defenderse en absoluto |
| 8 | el punto débil | **de zwakke plek** | Dat is zijn zwakke plek |
| 9 | invulnerable · resiliente | **onkwetsbaar** · **weerbaar** | los contrarios |

🧠 La imagen de la palabra es kwets-baar, «herible». Viene de kwetsen (herir) + -baar (-ble), como eetbaar (comestible) o drinkbaar (bebible). Lo vulnerable es lo que se puede herir.

🔑 El truco que casi nunca falla: Si el español dice «vulnerable», es kwetsbaar; si dice «propenso a pillar» algo (un resfriado, una infección), es vatbaar voor.

📌 Regla de bolsillo:
• ¿Se le puede hacer daño, en el cuerpo o en los sentimientos? → kwetsbaar.
• ¿Pilla enfermedades con facilidad? → vatbaar voor.
• ¿Reacciona mucho, se ofende o le escuece? → gevoelig.
• ¿No puede defenderse en absoluto? → weerloos.

⚠️ Trampa 1. kwetsbaar no es «débil» a secas: un niño débil es een zwak kind; kwetsbaar es que se le puede hacer daño.

⚠️ Trampa 2. Para enfermedades no se dice «kwetsbaar voor griep» sino vatbaar voor griep.

⚠️ Trampa 3. zich kwetsbaar opstellen es algo bueno en neerlandés, abrirse con sinceridad. Se oye en el trabajo, en terapia y en pareja.

⚠️ Trampa 4. Como adjetivo delante del sustantivo lleva -e (een kwetsbare groep, kwetsbare ouderen) y detrás del verbo no (hij is kwetsbaar). Comparativo kwetsbaarder.

🏋️ Ejercicio:
• Los niños pequeños son muy … → (kwetsbaar)
• Soy muy propenso a los resfriados → (Ik ben erg vatbaar voor verkoudheid)
• Atrévete a mostrarte vulnerable → (Durf je kwetsbaar op te stellen)
• Tengo la piel muy sensible → (Ik heb een erg gevoelige huid)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Me siento un poco vulnerable.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Me siento un poco vulnerable.' LIMIT 1), 'nl_NL', 'Ik voel me een beetje kwetsbaar.', 'ik fuul me en béitie kuétsbaar');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me siento un poco vulnerable.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Me siento un poco vulnerable.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'vulnerable' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Me siento un poco vulnerable.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Atrévete a mostrarte vulnerable.', 'SENTENCE', 'Ejemplo de "kwetsbaar" (geb.)', 'DURF JE … OP TE STELLEN = atrévete a. durven va con te, y en el separable el te se mete en medio: op te stellen.

🧩 Expresión fija — zich kwetsbaar opstellen:

• literal — colocarse vulnerable, ponerse donde te pueden herir.
• significa — abrirse, enseñar lo que sientes o lo que no sabes, sin coraza.
• piezas fijas — el reflexivo (me, je, zich, ons) y opstellen, que es separable. La partícula op se va al final y el ge- se mete dentro (opgesteld, con hebben).

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | presente | Hij stelt zich nooit kwetsbaar op. | Nunca se muestra vulnerable. |
| 2 | perfecto | Ze heeft zich heel kwetsbaar opgesteld. | Se ha mostrado muy vulnerable. |
| 3 | con te | Durf je kwetsbaar op te stellen. | Atrévete a mostrarte vulnerable. |
| 4 | subordinada | … omdat hij zich kwetsbaar opstelde. | … porque se abrió. |

• variante — zich kwetsbaar tonen, casi lo mismo.
• opstellen — débil y separable. Presente ik stel op, jij stelt op, wij stellen op; imperfecto stelde op, stelden op; participio opgesteld con hebben. Fuera de la expresión es redactar (een brief opstellen) o colocar.

🔑 El truco que casi nunca falla: Si en español «te abres» o «bajas la guardia», en neerlandés je stelt je kwetsbaar op.

🛡️ Vulnerable — kwetsbaar y sus rivales:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | vulnerable, frágil, que se puede herir | **kwetsbaar** | lo normal: personas, grupos, sistemas, la naturaleza |
| 2 | vulnerable a algo | **kwetsbaar voor** | Het systeem is kwetsbaar voor aanvallen |
| 3 | mostrarse vulnerable, abrirse | **zich kwetsbaar opstellen** | lo más hablado: emociones, pareja, trabajo |
| 4 | la vulnerabilidad, el fallo de seguridad | **de kwetsbaarheid** | personas y también software |
| 5 | propenso a pillar algo | **vatbaar voor** | Ik ben vatbaar voor verkoudheid |
| 6 | sensible, susceptible | **gevoelig (voor)** | la piel, un tema, una persona que se ofende |
| 7 | indefenso | **weerloos** | no puede defenderse en absoluto |
| 8 | el punto débil | **de zwakke plek** | Dat is zijn zwakke plek |
| 9 | invulnerable · resiliente | **onkwetsbaar** · **weerbaar** | los contrarios |

🧠 La imagen de la palabra es kwets-baar, «herible». Viene de kwetsen (herir) + -baar (-ble), como eetbaar (comestible) o drinkbaar (bebible). Lo vulnerable es lo que se puede herir.

🔑 El truco que casi nunca falla: Si el español dice «vulnerable», es kwetsbaar; si dice «propenso a pillar» algo (un resfriado, una infección), es vatbaar voor.

📌 Regla de bolsillo:
• ¿Se le puede hacer daño, en el cuerpo o en los sentimientos? → kwetsbaar.
• ¿Pilla enfermedades con facilidad? → vatbaar voor.
• ¿Reacciona mucho, se ofende o le escuece? → gevoelig.
• ¿No puede defenderse en absoluto? → weerloos.

⚠️ Trampa 1. kwetsbaar no es «débil» a secas: un niño débil es een zwak kind; kwetsbaar es que se le puede hacer daño.

⚠️ Trampa 2. Para enfermedades no se dice «kwetsbaar voor griep» sino vatbaar voor griep.

⚠️ Trampa 3. zich kwetsbaar opstellen es algo bueno en neerlandés, abrirse con sinceridad. Se oye en el trabajo, en terapia y en pareja.

⚠️ Trampa 4. Como adjetivo delante del sustantivo lleva -e (een kwetsbare groep, kwetsbare ouderen) y detrás del verbo no (hij is kwetsbaar). Comparativo kwetsbaarder.

🏋️ Ejercicio:
• Los niños pequeños son muy … → (kwetsbaar)
• Soy muy propenso a los resfriados → (Ik ben erg vatbaar voor verkoudheid)
• Atrévete a mostrarte vulnerable → (Durf je kwetsbaar op te stellen)
• Tengo la piel muy sensible → (Ik heb een erg gevoelige huid)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Atrévete a mostrarte vulnerable.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Atrévete a mostrarte vulnerable.' LIMIT 1), 'nl_NL', 'Durf je kwetsbaar op te stellen.', 'durf ie kuétsbaar op te stélen');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Atrévete a mostrarte vulnerable.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Atrévete a mostrarte vulnerable.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'vulnerable' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Atrévete a mostrarte vulnerable.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Se ha mostrado muy vulnerable. (ella)', 'SENTENCE', 'Ejemplo de "kwetsbaar" (perf.)', 'ZICH KWETSBAAR OPSTELLEN en perfecto: heeft … opgesteld, con el ge- dentro del separable.

🧩 Expresión fija — zich kwetsbaar opstellen:

• literal — colocarse vulnerable, ponerse donde te pueden herir.
• significa — abrirse, enseñar lo que sientes o lo que no sabes, sin coraza.
• piezas fijas — el reflexivo (me, je, zich, ons) y opstellen, que es separable. La partícula op se va al final y el ge- se mete dentro (opgesteld, con hebben).

| # | forma | ejemplo | español |
|---|---|---|---|
| 1 | presente | Hij stelt zich nooit kwetsbaar op. | Nunca se muestra vulnerable. |
| 2 | perfecto | Ze heeft zich heel kwetsbaar opgesteld. | Se ha mostrado muy vulnerable. |
| 3 | con te | Durf je kwetsbaar op te stellen. | Atrévete a mostrarte vulnerable. |
| 4 | subordinada | … omdat hij zich kwetsbaar opstelde. | … porque se abrió. |

• variante — zich kwetsbaar tonen, casi lo mismo.
• opstellen — débil y separable. Presente ik stel op, jij stelt op, wij stellen op; imperfecto stelde op, stelden op; participio opgesteld con hebben. Fuera de la expresión es redactar (een brief opstellen) o colocar.

🔑 El truco que casi nunca falla: Si en español «te abres» o «bajas la guardia», en neerlandés je stelt je kwetsbaar op.

🛡️ Vulnerable — kwetsbaar y sus rivales:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | vulnerable, frágil, que se puede herir | **kwetsbaar** | lo normal: personas, grupos, sistemas, la naturaleza |
| 2 | vulnerable a algo | **kwetsbaar voor** | Het systeem is kwetsbaar voor aanvallen |
| 3 | mostrarse vulnerable, abrirse | **zich kwetsbaar opstellen** | lo más hablado: emociones, pareja, trabajo |
| 4 | la vulnerabilidad, el fallo de seguridad | **de kwetsbaarheid** | personas y también software |
| 5 | propenso a pillar algo | **vatbaar voor** | Ik ben vatbaar voor verkoudheid |
| 6 | sensible, susceptible | **gevoelig (voor)** | la piel, un tema, una persona que se ofende |
| 7 | indefenso | **weerloos** | no puede defenderse en absoluto |
| 8 | el punto débil | **de zwakke plek** | Dat is zijn zwakke plek |
| 9 | invulnerable · resiliente | **onkwetsbaar** · **weerbaar** | los contrarios |

🧠 La imagen de la palabra es kwets-baar, «herible». Viene de kwetsen (herir) + -baar (-ble), como eetbaar (comestible) o drinkbaar (bebible). Lo vulnerable es lo que se puede herir.

🔑 El truco que casi nunca falla: Si el español dice «vulnerable», es kwetsbaar; si dice «propenso a pillar» algo (un resfriado, una infección), es vatbaar voor.

📌 Regla de bolsillo:
• ¿Se le puede hacer daño, en el cuerpo o en los sentimientos? → kwetsbaar.
• ¿Pilla enfermedades con facilidad? → vatbaar voor.
• ¿Reacciona mucho, se ofende o le escuece? → gevoelig.
• ¿No puede defenderse en absoluto? → weerloos.

⚠️ Trampa 1. kwetsbaar no es «débil» a secas: un niño débil es een zwak kind; kwetsbaar es que se le puede hacer daño.

⚠️ Trampa 2. Para enfermedades no se dice «kwetsbaar voor griep» sino vatbaar voor griep.

⚠️ Trampa 3. zich kwetsbaar opstellen es algo bueno en neerlandés, abrirse con sinceridad. Se oye en el trabajo, en terapia y en pareja.

⚠️ Trampa 4. Como adjetivo delante del sustantivo lleva -e (een kwetsbare groep, kwetsbare ouderen) y detrás del verbo no (hij is kwetsbaar). Comparativo kwetsbaarder.

🏋️ Ejercicio:
• Los niños pequeños son muy … → (kwetsbaar)
• Soy muy propenso a los resfriados → (Ik ben erg vatbaar voor verkoudheid)
• Atrévete a mostrarte vulnerable → (Durf je kwetsbaar op te stellen)
• Tengo la piel muy sensible → (Ik heb een erg gevoelige huid)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Se ha mostrado muy vulnerable. (ella)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Se ha mostrado muy vulnerable. (ella)' LIMIT 1), 'nl_NL', 'Ze heeft zich heel kwetsbaar opgesteld.', 'se heeft sij heel kuétsbaar ópjestelt');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Se ha mostrado muy vulnerable. (ella)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Se ha mostrado muy vulnerable. (ella)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'vulnerable' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Se ha mostrado muy vulnerable. (ella)' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'En invierno los mayores son especialmente vulnerables. (inv)', 'SENTENCE', 'Ejemplo de "kwetsbaar" (inv.)', 'EXTRA KWETSBAAR = especialmente vulnerable; al hablar, extra hace de «especialmente». ouderen son los mayores. (inv) porque abre con in de winter.

🛡️ Vulnerable — kwetsbaar y sus rivales:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | vulnerable, frágil, que se puede herir | **kwetsbaar** | lo normal: personas, grupos, sistemas, la naturaleza |
| 2 | vulnerable a algo | **kwetsbaar voor** | Het systeem is kwetsbaar voor aanvallen |
| 3 | mostrarse vulnerable, abrirse | **zich kwetsbaar opstellen** | lo más hablado: emociones, pareja, trabajo |
| 4 | la vulnerabilidad, el fallo de seguridad | **de kwetsbaarheid** | personas y también software |
| 5 | propenso a pillar algo | **vatbaar voor** | Ik ben vatbaar voor verkoudheid |
| 6 | sensible, susceptible | **gevoelig (voor)** | la piel, un tema, una persona que se ofende |
| 7 | indefenso | **weerloos** | no puede defenderse en absoluto |
| 8 | el punto débil | **de zwakke plek** | Dat is zijn zwakke plek |
| 9 | invulnerable · resiliente | **onkwetsbaar** · **weerbaar** | los contrarios |

🧠 La imagen de la palabra es kwets-baar, «herible». Viene de kwetsen (herir) + -baar (-ble), como eetbaar (comestible) o drinkbaar (bebible). Lo vulnerable es lo que se puede herir.

🔑 El truco que casi nunca falla: Si el español dice «vulnerable», es kwetsbaar; si dice «propenso a pillar» algo (un resfriado, una infección), es vatbaar voor.

📌 Regla de bolsillo:
• ¿Se le puede hacer daño, en el cuerpo o en los sentimientos? → kwetsbaar.
• ¿Pilla enfermedades con facilidad? → vatbaar voor.
• ¿Reacciona mucho, se ofende o le escuece? → gevoelig.
• ¿No puede defenderse en absoluto? → weerloos.

⚠️ Trampa 1. kwetsbaar no es «débil» a secas: un niño débil es een zwak kind; kwetsbaar es que se le puede hacer daño.

⚠️ Trampa 2. Para enfermedades no se dice «kwetsbaar voor griep» sino vatbaar voor griep.

⚠️ Trampa 3. zich kwetsbaar opstellen es algo bueno en neerlandés, abrirse con sinceridad. Se oye en el trabajo, en terapia y en pareja.

⚠️ Trampa 4. Como adjetivo delante del sustantivo lleva -e (een kwetsbare groep, kwetsbare ouderen) y detrás del verbo no (hij is kwetsbaar). Comparativo kwetsbaarder.

🏋️ Ejercicio:
• Los niños pequeños son muy … → (kwetsbaar)
• Soy muy propenso a los resfriados → (Ik ben erg vatbaar voor verkoudheid)
• Atrévete a mostrarte vulnerable → (Durf je kwetsbaar op te stellen)
• Tengo la piel muy sensible → (Ik heb een erg gevoelige huid)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'En invierno los mayores son especialmente vulnerables. (inv)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'En invierno los mayores son especialmente vulnerables. (inv)' LIMIT 1), 'nl_NL', 'In de winter zijn ouderen extra kwetsbaar.', 'in de uínter séin óuderen ékstra kuétsbaar');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En invierno los mayores son especialmente vulnerables. (inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En invierno los mayores son especialmente vulnerables. (inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'vulnerable' LIMIT 1), (SELECT id FROM words_es WHERE text = 'En invierno los mayores son especialmente vulnerables. (inv)' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Tras la operación seguía muy vulnerable. (él, inv)', 'SENTENCE', 'Ejemplo de "kwetsbaar" (inv.)', 'NOG HEEL KWETSBAAR = todavía muy vulnerable; el «seguía» es was … nog. (inv) porque abre con na de operatie.

🛡️ Vulnerable — kwetsbaar y sus rivales:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | vulnerable, frágil, que se puede herir | **kwetsbaar** | lo normal: personas, grupos, sistemas, la naturaleza |
| 2 | vulnerable a algo | **kwetsbaar voor** | Het systeem is kwetsbaar voor aanvallen |
| 3 | mostrarse vulnerable, abrirse | **zich kwetsbaar opstellen** | lo más hablado: emociones, pareja, trabajo |
| 4 | la vulnerabilidad, el fallo de seguridad | **de kwetsbaarheid** | personas y también software |
| 5 | propenso a pillar algo | **vatbaar voor** | Ik ben vatbaar voor verkoudheid |
| 6 | sensible, susceptible | **gevoelig (voor)** | la piel, un tema, una persona que se ofende |
| 7 | indefenso | **weerloos** | no puede defenderse en absoluto |
| 8 | el punto débil | **de zwakke plek** | Dat is zijn zwakke plek |
| 9 | invulnerable · resiliente | **onkwetsbaar** · **weerbaar** | los contrarios |

🧠 La imagen de la palabra es kwets-baar, «herible». Viene de kwetsen (herir) + -baar (-ble), como eetbaar (comestible) o drinkbaar (bebible). Lo vulnerable es lo que se puede herir.

🔑 El truco que casi nunca falla: Si el español dice «vulnerable», es kwetsbaar; si dice «propenso a pillar» algo (un resfriado, una infección), es vatbaar voor.

📌 Regla de bolsillo:
• ¿Se le puede hacer daño, en el cuerpo o en los sentimientos? → kwetsbaar.
• ¿Pilla enfermedades con facilidad? → vatbaar voor.
• ¿Reacciona mucho, se ofende o le escuece? → gevoelig.
• ¿No puede defenderse en absoluto? → weerloos.

⚠️ Trampa 1. kwetsbaar no es «débil» a secas: un niño débil es een zwak kind; kwetsbaar es que se le puede hacer daño.

⚠️ Trampa 2. Para enfermedades no se dice «kwetsbaar voor griep» sino vatbaar voor griep.

⚠️ Trampa 3. zich kwetsbaar opstellen es algo bueno en neerlandés, abrirse con sinceridad. Se oye en el trabajo, en terapia y en pareja.

⚠️ Trampa 4. Como adjetivo delante del sustantivo lleva -e (een kwetsbare groep, kwetsbare ouderen) y detrás del verbo no (hij is kwetsbaar). Comparativo kwetsbaarder.

🏋️ Ejercicio:
• Los niños pequeños son muy … → (kwetsbaar)
• Soy muy propenso a los resfriados → (Ik ben erg vatbaar voor verkoudheid)
• Atrévete a mostrarte vulnerable → (Durf je kwetsbaar op te stellen)
• Tengo la piel muy sensible → (Ik heb een erg gevoelige huid)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Tras la operación seguía muy vulnerable. (él, inv)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Tras la operación seguía muy vulnerable. (él, inv)' LIMIT 1), 'nl_NL', 'Na de operatie was hij nog heel kwetsbaar.', 'na de operáatsie uas hei noj heel kuétsbaar');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tras la operación seguía muy vulnerable. (él, inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tras la operación seguía muy vulnerable. (él, inv)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'vulnerable' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Tras la operación seguía muy vulnerable. (él, inv)' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'El sistema es vulnerable a los ataques.', 'SENTENCE', 'Ejemplo de "kwetsbaar" (can.)', 'KWETSBAAR VOOR = vulnerable a, y la preposición es voor, nunca aan. de aanval es el ataque, plural aanvallen.

🛡️ Vulnerable — kwetsbaar y sus rivales:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | vulnerable, frágil, que se puede herir | **kwetsbaar** | lo normal: personas, grupos, sistemas, la naturaleza |
| 2 | vulnerable a algo | **kwetsbaar voor** | Het systeem is kwetsbaar voor aanvallen |
| 3 | mostrarse vulnerable, abrirse | **zich kwetsbaar opstellen** | lo más hablado: emociones, pareja, trabajo |
| 4 | la vulnerabilidad, el fallo de seguridad | **de kwetsbaarheid** | personas y también software |
| 5 | propenso a pillar algo | **vatbaar voor** | Ik ben vatbaar voor verkoudheid |
| 6 | sensible, susceptible | **gevoelig (voor)** | la piel, un tema, una persona que se ofende |
| 7 | indefenso | **weerloos** | no puede defenderse en absoluto |
| 8 | el punto débil | **de zwakke plek** | Dat is zijn zwakke plek |
| 9 | invulnerable · resiliente | **onkwetsbaar** · **weerbaar** | los contrarios |

🧠 La imagen de la palabra es kwets-baar, «herible». Viene de kwetsen (herir) + -baar (-ble), como eetbaar (comestible) o drinkbaar (bebible). Lo vulnerable es lo que se puede herir.

🔑 El truco que casi nunca falla: Si el español dice «vulnerable», es kwetsbaar; si dice «propenso a pillar» algo (un resfriado, una infección), es vatbaar voor.

📌 Regla de bolsillo:
• ¿Se le puede hacer daño, en el cuerpo o en los sentimientos? → kwetsbaar.
• ¿Pilla enfermedades con facilidad? → vatbaar voor.
• ¿Reacciona mucho, se ofende o le escuece? → gevoelig.
• ¿No puede defenderse en absoluto? → weerloos.

⚠️ Trampa 1. kwetsbaar no es «débil» a secas: un niño débil es een zwak kind; kwetsbaar es que se le puede hacer daño.

⚠️ Trampa 2. Para enfermedades no se dice «kwetsbaar voor griep» sino vatbaar voor griep.

⚠️ Trampa 3. zich kwetsbaar opstellen es algo bueno en neerlandés, abrirse con sinceridad. Se oye en el trabajo, en terapia y en pareja.

⚠️ Trampa 4. Como adjetivo delante del sustantivo lleva -e (een kwetsbare groep, kwetsbare ouderen) y detrás del verbo no (hij is kwetsbaar). Comparativo kwetsbaarder.

🏋️ Ejercicio:
• Los niños pequeños son muy … → (kwetsbaar)
• Soy muy propenso a los resfriados → (Ik ben erg vatbaar voor verkoudheid)
• Atrévete a mostrarte vulnerable → (Durf je kwetsbaar op te stellen)
• Tengo la piel muy sensible → (Ik heb een erg gevoelige huid)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El sistema es vulnerable a los ataques.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El sistema es vulnerable a los ataques.' LIMIT 1), 'nl_NL', 'Het systeem is kwetsbaar voor aanvallen.', 'et sistéem is kuétsbaar foor áanfalen');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El sistema es vulnerable a los ataques.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El sistema es vulnerable a los ataques.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'vulnerable' LIMIT 1), (SELECT id FROM words_es WHERE text = 'El sistema es vulnerable a los ataques.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Lo dijo porque se sentía vulnerable. (él)', 'SENTENCE', 'Ejemplo de "kwetsbaar" (bijzin)', 'OMDAT manda el verbo al final de su frase: … omdat hij zich kwetsbaar voelde. zei es el imperfecto de zeggen.

🛡️ Vulnerable — kwetsbaar y sus rivales:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | vulnerable, frágil, que se puede herir | **kwetsbaar** | lo normal: personas, grupos, sistemas, la naturaleza |
| 2 | vulnerable a algo | **kwetsbaar voor** | Het systeem is kwetsbaar voor aanvallen |
| 3 | mostrarse vulnerable, abrirse | **zich kwetsbaar opstellen** | lo más hablado: emociones, pareja, trabajo |
| 4 | la vulnerabilidad, el fallo de seguridad | **de kwetsbaarheid** | personas y también software |
| 5 | propenso a pillar algo | **vatbaar voor** | Ik ben vatbaar voor verkoudheid |
| 6 | sensible, susceptible | **gevoelig (voor)** | la piel, un tema, una persona que se ofende |
| 7 | indefenso | **weerloos** | no puede defenderse en absoluto |
| 8 | el punto débil | **de zwakke plek** | Dat is zijn zwakke plek |
| 9 | invulnerable · resiliente | **onkwetsbaar** · **weerbaar** | los contrarios |

🧠 La imagen de la palabra es kwets-baar, «herible». Viene de kwetsen (herir) + -baar (-ble), como eetbaar (comestible) o drinkbaar (bebible). Lo vulnerable es lo que se puede herir.

🔑 El truco que casi nunca falla: Si el español dice «vulnerable», es kwetsbaar; si dice «propenso a pillar» algo (un resfriado, una infección), es vatbaar voor.

📌 Regla de bolsillo:
• ¿Se le puede hacer daño, en el cuerpo o en los sentimientos? → kwetsbaar.
• ¿Pilla enfermedades con facilidad? → vatbaar voor.
• ¿Reacciona mucho, se ofende o le escuece? → gevoelig.
• ¿No puede defenderse en absoluto? → weerloos.

⚠️ Trampa 1. kwetsbaar no es «débil» a secas: un niño débil es een zwak kind; kwetsbaar es que se le puede hacer daño.

⚠️ Trampa 2. Para enfermedades no se dice «kwetsbaar voor griep» sino vatbaar voor griep.

⚠️ Trampa 3. zich kwetsbaar opstellen es algo bueno en neerlandés, abrirse con sinceridad. Se oye en el trabajo, en terapia y en pareja.

⚠️ Trampa 4. Como adjetivo delante del sustantivo lleva -e (een kwetsbare groep, kwetsbare ouderen) y detrás del verbo no (hij is kwetsbaar). Comparativo kwetsbaarder.

🏋️ Ejercicio:
• Los niños pequeños son muy … → (kwetsbaar)
• Soy muy propenso a los resfriados → (Ik ben erg vatbaar voor verkoudheid)
• Atrévete a mostrarte vulnerable → (Durf je kwetsbaar op te stellen)
• Tengo la piel muy sensible → (Ik heb een erg gevoelige huid)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Lo dijo porque se sentía vulnerable. (él)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo dijo porque se sentía vulnerable. (él)' LIMIT 1), 'nl_NL', 'Hij zei het omdat hij zich kwetsbaar voelde.', 'hei sei et omdát hei sij kuétsbaar fúulde');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo dijo porque se sentía vulnerable. (él)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Lo dijo porque se sentía vulnerable. (él)' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'vulnerable' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Lo dijo porque se sentía vulnerable. (él)' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Tus palabras me han herido.', 'SENTENCE', 'Ejemplo de "kwetsbaar" (perf.)', 'GEKWETST = herido, en los sentimientos; es el participio de kwetsen, el verbo del que sale kwetsbaar.

📐 Conjugacion de kwetsen (débil · no separable):

| persona | presente | imperfecto |
|---|---|---|
| ik | kwets | kwetste |
| jij / je | kwetst | kwetste |
| u | kwetst | kwetste |
| hij / zij / het | kwetst | kwetste |
| wij | kwetsen | kwetsten |
| jullie | kwetsen | kwetsten |
| zij (plural) | kwetsen | kwetsten |

• participio — gekwetst, con hebben: Je hebt me gekwetst. Y como adjetivo, gekwetst es dolido: Ik voel me gekwetst.
• al invertir, jij pierde la -t: Kwets jij hem niet? — no «kwetst jij».
• preposicion — no rige ninguna, es transitivo directo: iemand kwetsen. Es herir sobre todo los sentimientos; la herida física es verwonden.
• separable — no, es un verbo simple y el ge- va delante (gekwetst).
• antonimo — no tiene uno claro; lo más cercano es troosten (consolar).
• sustantivo — de kwetsuur (la lesión, en deporte) y de kwetsbaarheid (la vulnerabilidad).
• expresion hecha — iemands gevoelens kwetsen, herir los sentimientos de alguien. Y Dat kwetst me, eso me duele.

🛡️ Vulnerable — kwetsbaar y sus rivales:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | vulnerable, frágil, que se puede herir | **kwetsbaar** | lo normal: personas, grupos, sistemas, la naturaleza |
| 2 | vulnerable a algo | **kwetsbaar voor** | Het systeem is kwetsbaar voor aanvallen |
| 3 | mostrarse vulnerable, abrirse | **zich kwetsbaar opstellen** | lo más hablado: emociones, pareja, trabajo |
| 4 | la vulnerabilidad, el fallo de seguridad | **de kwetsbaarheid** | personas y también software |
| 5 | propenso a pillar algo | **vatbaar voor** | Ik ben vatbaar voor verkoudheid |
| 6 | sensible, susceptible | **gevoelig (voor)** | la piel, un tema, una persona que se ofende |
| 7 | indefenso | **weerloos** | no puede defenderse en absoluto |
| 8 | el punto débil | **de zwakke plek** | Dat is zijn zwakke plek |
| 9 | invulnerable · resiliente | **onkwetsbaar** · **weerbaar** | los contrarios |

🧠 La imagen de la palabra es kwets-baar, «herible». Viene de kwetsen (herir) + -baar (-ble), como eetbaar (comestible) o drinkbaar (bebible). Lo vulnerable es lo que se puede herir.

🔑 El truco que casi nunca falla: Si el español dice «vulnerable», es kwetsbaar; si dice «propenso a pillar» algo (un resfriado, una infección), es vatbaar voor.

📌 Regla de bolsillo:
• ¿Se le puede hacer daño, en el cuerpo o en los sentimientos? → kwetsbaar.
• ¿Pilla enfermedades con facilidad? → vatbaar voor.
• ¿Reacciona mucho, se ofende o le escuece? → gevoelig.
• ¿No puede defenderse en absoluto? → weerloos.

⚠️ Trampa 1. kwetsbaar no es «débil» a secas: un niño débil es een zwak kind; kwetsbaar es que se le puede hacer daño.

⚠️ Trampa 2. Para enfermedades no se dice «kwetsbaar voor griep» sino vatbaar voor griep.

⚠️ Trampa 3. zich kwetsbaar opstellen es algo bueno en neerlandés, abrirse con sinceridad. Se oye en el trabajo, en terapia y en pareja.

⚠️ Trampa 4. Como adjetivo delante del sustantivo lleva -e (een kwetsbare groep, kwetsbare ouderen) y detrás del verbo no (hij is kwetsbaar). Comparativo kwetsbaarder.

🏋️ Ejercicio:
• Los niños pequeños son muy … → (kwetsbaar)
• Soy muy propenso a los resfriados → (Ik ben erg vatbaar voor verkoudheid)
• Atrévete a mostrarte vulnerable → (Durf je kwetsbaar op te stellen)
• Tengo la piel muy sensible → (Ik heb een erg gevoelige huid)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Tus palabras me han herido.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Tus palabras me han herido.' LIMIT 1), 'nl_NL', 'Je woorden hebben me gekwetst.', 'ie uóorden hében me jekuétst');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tus palabras me han herido.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Tus palabras me han herido.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'vulnerable' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Tus palabras me han herido.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Soy muy propenso a los resfriados.', 'SENTENCE', 'Ejemplo de "kwetsbaar" (can.)', 'VATBAAR VOOR = propenso a pillar algo, para enfermedades. Aquí kwetsbaar sonaría raro: es la trampa 2 del mapa. de verkoudheid es el resfriado.

🛡️ Vulnerable — kwetsbaar y sus rivales:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | vulnerable, frágil, que se puede herir | **kwetsbaar** | lo normal: personas, grupos, sistemas, la naturaleza |
| 2 | vulnerable a algo | **kwetsbaar voor** | Het systeem is kwetsbaar voor aanvallen |
| 3 | mostrarse vulnerable, abrirse | **zich kwetsbaar opstellen** | lo más hablado: emociones, pareja, trabajo |
| 4 | la vulnerabilidad, el fallo de seguridad | **de kwetsbaarheid** | personas y también software |
| 5 | propenso a pillar algo | **vatbaar voor** | Ik ben vatbaar voor verkoudheid |
| 6 | sensible, susceptible | **gevoelig (voor)** | la piel, un tema, una persona que se ofende |
| 7 | indefenso | **weerloos** | no puede defenderse en absoluto |
| 8 | el punto débil | **de zwakke plek** | Dat is zijn zwakke plek |
| 9 | invulnerable · resiliente | **onkwetsbaar** · **weerbaar** | los contrarios |

🧠 La imagen de la palabra es kwets-baar, «herible». Viene de kwetsen (herir) + -baar (-ble), como eetbaar (comestible) o drinkbaar (bebible). Lo vulnerable es lo que se puede herir.

🔑 El truco que casi nunca falla: Si el español dice «vulnerable», es kwetsbaar; si dice «propenso a pillar» algo (un resfriado, una infección), es vatbaar voor.

📌 Regla de bolsillo:
• ¿Se le puede hacer daño, en el cuerpo o en los sentimientos? → kwetsbaar.
• ¿Pilla enfermedades con facilidad? → vatbaar voor.
• ¿Reacciona mucho, se ofende o le escuece? → gevoelig.
• ¿No puede defenderse en absoluto? → weerloos.

⚠️ Trampa 1. kwetsbaar no es «débil» a secas: un niño débil es een zwak kind; kwetsbaar es que se le puede hacer daño.

⚠️ Trampa 2. Para enfermedades no se dice «kwetsbaar voor griep» sino vatbaar voor griep.

⚠️ Trampa 3. zich kwetsbaar opstellen es algo bueno en neerlandés, abrirse con sinceridad. Se oye en el trabajo, en terapia y en pareja.

⚠️ Trampa 4. Como adjetivo delante del sustantivo lleva -e (een kwetsbare groep, kwetsbare ouderen) y detrás del verbo no (hij is kwetsbaar). Comparativo kwetsbaarder.

🏋️ Ejercicio:
• Los niños pequeños son muy … → (kwetsbaar)
• Soy muy propenso a los resfriados → (Ik ben erg vatbaar voor verkoudheid)
• Atrévete a mostrarte vulnerable → (Durf je kwetsbaar op te stellen)
• Tengo la piel muy sensible → (Ik heb een erg gevoelige huid)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Soy muy propenso a los resfriados.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Soy muy propenso a los resfriados.' LIMIT 1), 'nl_NL', 'Ik ben erg vatbaar voor verkoudheid.', 'ik ben erj fátbaar foor ferkáudheit');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Soy muy propenso a los resfriados.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Soy muy propenso a los resfriados.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'vulnerable' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Soy muy propenso a los resfriados.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Mostrar vulnerabilidad no es debilidad.', 'SENTENCE', 'Ejemplo de "kwetsbaarheid" (can.)', 'KWETSBAARHEID TONEN = mostrar vulnerabilidad, y el infinitivo hace de sujeto. de zwakte es la debilidad, y va geen porque niega un sustantivo.

🛡️ Vulnerable — kwetsbaar y sus rivales:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | vulnerable, frágil, que se puede herir | **kwetsbaar** | lo normal: personas, grupos, sistemas, la naturaleza |
| 2 | vulnerable a algo | **kwetsbaar voor** | Het systeem is kwetsbaar voor aanvallen |
| 3 | mostrarse vulnerable, abrirse | **zich kwetsbaar opstellen** | lo más hablado: emociones, pareja, trabajo |
| 4 | la vulnerabilidad, el fallo de seguridad | **de kwetsbaarheid** | personas y también software |
| 5 | propenso a pillar algo | **vatbaar voor** | Ik ben vatbaar voor verkoudheid |
| 6 | sensible, susceptible | **gevoelig (voor)** | la piel, un tema, una persona que se ofende |
| 7 | indefenso | **weerloos** | no puede defenderse en absoluto |
| 8 | el punto débil | **de zwakke plek** | Dat is zijn zwakke plek |
| 9 | invulnerable · resiliente | **onkwetsbaar** · **weerbaar** | los contrarios |

🧠 La imagen de la palabra es kwets-baar, «herible». Viene de kwetsen (herir) + -baar (-ble), como eetbaar (comestible) o drinkbaar (bebible). Lo vulnerable es lo que se puede herir.

🔑 El truco que casi nunca falla: Si el español dice «vulnerable», es kwetsbaar; si dice «propenso a pillar» algo (un resfriado, una infección), es vatbaar voor.

📌 Regla de bolsillo:
• ¿Se le puede hacer daño, en el cuerpo o en los sentimientos? → kwetsbaar.
• ¿Pilla enfermedades con facilidad? → vatbaar voor.
• ¿Reacciona mucho, se ofende o le escuece? → gevoelig.
• ¿No puede defenderse en absoluto? → weerloos.

⚠️ Trampa 1. kwetsbaar no es «débil» a secas: un niño débil es een zwak kind; kwetsbaar es que se le puede hacer daño.

⚠️ Trampa 2. Para enfermedades no se dice «kwetsbaar voor griep» sino vatbaar voor griep.

⚠️ Trampa 3. zich kwetsbaar opstellen es algo bueno en neerlandés, abrirse con sinceridad. Se oye en el trabajo, en terapia y en pareja.

⚠️ Trampa 4. Como adjetivo delante del sustantivo lleva -e (een kwetsbare groep, kwetsbare ouderen) y detrás del verbo no (hij is kwetsbaar). Comparativo kwetsbaarder.

🏋️ Ejercicio:
• Los niños pequeños son muy … → (kwetsbaar)
• Soy muy propenso a los resfriados → (Ik ben erg vatbaar voor verkoudheid)
• Atrévete a mostrarte vulnerable → (Durf je kwetsbaar op te stellen)
• Tengo la piel muy sensible → (Ik heb een erg gevoelige huid)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Mostrar vulnerabilidad no es debilidad.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Mostrar vulnerabilidad no es debilidad.' LIMIT 1), 'nl_NL', 'Kwetsbaarheid tonen is geen zwakte.', 'kuétsbaarheit tónen is jeen suákte');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mostrar vulnerabilidad no es debilidad.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Mostrar vulnerabilidad no es debilidad.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'la vulnerabilidad' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Mostrar vulnerabilidad no es debilidad.' LIMIT 1), 'EXAMPLE');

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Han encontrado una vulnerabilidad en la aplicación.', 'SENTENCE', 'Ejemplo de "kwetsbaarheid" (perf.)', 'EEN KWETSBAARHEID = un fallo de seguridad en informática. El «han» impersonal es ze hebben. gevonden es el participio de vinden.

🛡️ Vulnerable — kwetsbaar y sus rivales:

| # | en español | neerlandés | cuándo |
|---|---|---|---|
| 1 | vulnerable, frágil, que se puede herir | **kwetsbaar** | lo normal: personas, grupos, sistemas, la naturaleza |
| 2 | vulnerable a algo | **kwetsbaar voor** | Het systeem is kwetsbaar voor aanvallen |
| 3 | mostrarse vulnerable, abrirse | **zich kwetsbaar opstellen** | lo más hablado: emociones, pareja, trabajo |
| 4 | la vulnerabilidad, el fallo de seguridad | **de kwetsbaarheid** | personas y también software |
| 5 | propenso a pillar algo | **vatbaar voor** | Ik ben vatbaar voor verkoudheid |
| 6 | sensible, susceptible | **gevoelig (voor)** | la piel, un tema, una persona que se ofende |
| 7 | indefenso | **weerloos** | no puede defenderse en absoluto |
| 8 | el punto débil | **de zwakke plek** | Dat is zijn zwakke plek |
| 9 | invulnerable · resiliente | **onkwetsbaar** · **weerbaar** | los contrarios |

🧠 La imagen de la palabra es kwets-baar, «herible». Viene de kwetsen (herir) + -baar (-ble), como eetbaar (comestible) o drinkbaar (bebible). Lo vulnerable es lo que se puede herir.

🔑 El truco que casi nunca falla: Si el español dice «vulnerable», es kwetsbaar; si dice «propenso a pillar» algo (un resfriado, una infección), es vatbaar voor.

📌 Regla de bolsillo:
• ¿Se le puede hacer daño, en el cuerpo o en los sentimientos? → kwetsbaar.
• ¿Pilla enfermedades con facilidad? → vatbaar voor.
• ¿Reacciona mucho, se ofende o le escuece? → gevoelig.
• ¿No puede defenderse en absoluto? → weerloos.

⚠️ Trampa 1. kwetsbaar no es «débil» a secas: un niño débil es een zwak kind; kwetsbaar es que se le puede hacer daño.

⚠️ Trampa 2. Para enfermedades no se dice «kwetsbaar voor griep» sino vatbaar voor griep.

⚠️ Trampa 3. zich kwetsbaar opstellen es algo bueno en neerlandés, abrirse con sinceridad. Se oye en el trabajo, en terapia y en pareja.

⚠️ Trampa 4. Como adjetivo delante del sustantivo lleva -e (een kwetsbare groep, kwetsbare ouderen) y detrás del verbo no (hij is kwetsbaar). Comparativo kwetsbaarder.

🏋️ Ejercicio:
• Los niños pequeños son muy … → (kwetsbaar)
• Soy muy propenso a los resfriados → (Ik ben erg vatbaar voor verkoudheid)
• Atrévete a mostrarte vulnerable → (Durf je kwetsbaar op te stellen)
• Tengo la piel muy sensible → (Ik heb een erg gevoelige huid)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Han encontrado una vulnerabilidad en la aplicación.');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Han encontrado una vulnerabilidad en la aplicación.' LIMIT 1), 'nl_NL', 'Ze hebben een kwetsbaarheid in de app gevonden.', 'se hében en kuétsbaarheit in de ep jefónden');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Han encontrado una vulnerabilidad en la aplicación.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Han encontrado una vulnerabilidad en la aplicación.' LIMIT 1), (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'la vulnerabilidad' LIMIT 1), (SELECT id FROM words_es WHERE text = 'Han encontrado una vulnerabilidad en la aplicación.' LIMIT 1), 'EXAMPLE');
