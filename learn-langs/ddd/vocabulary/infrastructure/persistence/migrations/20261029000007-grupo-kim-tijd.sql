-- Learn Languages App - Migration
-- Migration: 20261029000007-grupo-kim-tijd
-- Description: Eduardo: «vamos a crear grupos kim con todas estas palabras … ojo revisa que no existan», sobre las listas de Quizlet de Learn Dutch with Kim, con la seleccion por frecuencia aprobada el 2026-10-29.
--
--   Lista Tijd: 22 palabras. de wekker (82) ya existia y solo se ENLAZA. Se crean 21 WORD (het hier
--   en nu tambien como WORD, porque es un sustantivo con het). Los grupos 26 (la hora) y 45 (los
--   meses) solo tienen PHRASE con estas palabras: ninguna WORD equivalente que reutilizar.
--
--   Textos ES desambiguados sin parentesis (§3.0): de morgen frente a de ochtend ('la mañana,
--   sinonimo de ochtend'), de avond frente a de nacht (antes de dormir / mientras dormimos), het uur
--   ('la hora, sesenta minutos'), de klok frente a de wandklok (101) y het horloge, y de seconde
--   ('el segundo, la unidad de tiempo', para no confundirlo con tweede).
--
--   Bloques compartidos (§3.3), byte a byte: '📌 … de morgen, morgen o de ochtend' (morgen, ochtend),
--   '📌 … het uur, de klok, het horloge o hoe laat' (uur, klok, horloge), '📌 … de avond o de nacht'
--   (avond, nacht), '🌓 Las partes del dia' (ochtend, middag, avond, nacht) y '🪜 La escalera del
--   tiempo' (verleden, heden, toekomst).

PRAGMA foreign_keys = ON;


-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'kim - tijd',
       'El tiempo de la lista Tijd de Learn Dutch with Kim: las partes del día, las unidades, los relojes y la escalera del pasado al futuro, cada palabra con su de o het. Ensaya lo que se confunde: de morgen frente a morgen, het uur frente a hoe laat, de avond frente a de nacht y het kwartier frente a kwart.',
       'Tijd - Flashcards in Quizlet - Learn Dutch with Kim - https://quizlet.com/_982rqi'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'kim - tijd');

-- =============================================================================
-- 2. Las 21 tarjetas nuevas
-- =============================================================================
-- de tijd
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el tiempo que pasa', 'WORD', 'kim - tijd: de tijd',
'de tijd = el tiempo que pasa, el que mide el reloj. Es de-woord, plural de tijden, que significa épocas.

⚠️ El tiempo que hace no es tijd sino het weer, como en Wat voor weer is het?

• tijd hebben voor — tener tiempo para, sin artículo: Ik heb geen tijd.
• op tijd — a tiempo, puntual.
• het is hoog tijd — ya va siendo hora.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el tiempo que pasa');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el tiempo que pasa' LIMIT 1),
    'nl_NL', 'de tijd', 'de teit',
'• [can.] Ik heb vandaag geen tijd. — Hoy no tengo tiempo.
• [perf.] We hebben een leuke tijd gehad. — Lo hemos pasado bien.
• [vraag] Heb je even tijd? — ¿Tienes un momento?
• [bijzin] Ik weet niet of ik op tijd kom. — No sé si llegaré a tiempo.
• [uitdr.] Het is hoog tijd om te gaan. — Ya va siendo hora de irse.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tiempo que pasa' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el tiempo que pasa' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- het hier en nu
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el aquí y ahora', 'WORD', 'kim - tijd: het hier en nu',
'het hier en nu = el aquí y ahora. Es het-woord porque son adverbios usados como sustantivo, y no tiene plural.

• in het hier en nu leven — vivir el momento.
• nu meteen — ahora mismo.

🔑 El truco que casi nunca falla: un adverbio o un infinitivo usado como sustantivo lleva het, como het hier en nu, het nu o het eten.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el aquí y ahora');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el aquí y ahora' LIMIT 1),
    'nl_NL', 'het hier en nu', 'het hiir en nü',
'• [can.] Ik probeer in het hier en nu te leven. — Intento vivir en el aquí y ahora.
• [perf.] Door yoga heb ik geleerd in het hier en nu te zijn. — Con el yoga he aprendido a estar en el aquí y ahora.
• [inv.] Na de cursus denk ik meer aan het hier en nu. — Después del curso pienso más en el aquí y ahora.
• [bijzin] Ze zegt dat het hier en nu het enige is wat telt. — Dice que el aquí y ahora es lo único que cuenta.
• [geb.] Blijf in het hier en nu. — Quédate en el aquí y ahora.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el aquí y ahora' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el aquí y ahora' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- het uur
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la hora, sesenta minutos', 'WORD', 'kim - tijd: het uur',
'het uur = la hora como duración de sesenta minutos. Es het-woord, plural de uren.

📌 Regla de bolsillo, het uur, de klok, het horloge o hoe laat:
• ¿Una duración de sesenta minutos? → het uur — Ik heb twee uur gewacht.
• ¿El reloj de la pared, de la torre o de la cocina? → de klok.
• ¿El reloj de pulsera? → het horloge.
• ¿Preguntas la hora? → Hoe laat is het? — nunca «welk uur is het».

⚠️ Tras un número uur va en singular, twee uur y om vijf uur, y el plural uren es para cantidades vagas, Ik heb uren gewacht.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la hora, sesenta minutos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la hora, sesenta minutos' LIMIT 1),
    'nl_NL', 'het uur', 'het ür',
'• [can.] De les duurt een uur. — La clase dura una hora.
• [perf.] Ik heb twee uur op de bus gewacht. — He esperado el autobús dos horas.
• [inv.] Om acht uur begint de film. — La película empieza a las ocho.
• [bijzin] Ik weet niet hoeveel uur ik per week werk. — No sé cuántas horas trabajo a la semana.
• [uitdr.] Ik kom om een uur of acht. — Vengo sobre las ocho.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la hora, sesenta minutos' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la hora, sesenta minutos' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- het moment
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el momento', 'WORD', 'kim - tijd: het moment',
'het moment = el momento. Es het-woord, plural de momenten.

• op dit moment — en este momento, ahora.
• het ogenblik — el instante, sinónimo: Een ogenblikje!
• momenteel — actualmente.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el momento');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el momento' LIMIT 1),
    'nl_NL', 'het moment', 'het momént',
'• [can.] Dit is het beste moment van de dag. — Este es el mejor momento del día.
• [perf.] Ik heb lang op dit moment gewacht. — He esperado mucho este momento.
• [inv.] Op dit moment ben ik niet thuis. — En este momento no estoy en casa.
• [bijzin] Bel me als je een moment hebt. — Llámame cuando tengas un momento.
• [uitdr.] Moment, ik kom eraan! — ¡Un momento, ya voy!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el momento' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el momento' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de morgen
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la mañana, forma más formal', 'WORD', 'kim - tijd: de morgen',
'de morgen = la mañana, la parte del día, sinónimo de de ochtend. Es de-woord, plural de morgens.

📌 Regla de bolsillo, de morgen, morgen o de ochtend:
• ¿Con artículo, la parte del día? → de ochtend o de morgen, que son sinónimos.
• ¿Sin artículo, el día siguiente? → morgen — Morgen ga ik werken.
• ¿Las dos cosas a la vez? → morgenochtend, que es mañana por la mañana y nunca «morgen morgen».
• ¿El saludo? → goedemorgen, que es la morgen de la parte del día.

🔑 El truco que casi nunca falla: si lleva de delante es la mañana del día, y si va sola es el día de mañana.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la mañana, forma más formal');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la mañana, forma más formal' LIMIT 1),
    'nl_NL', 'de morgen', 'de mórjen',
'• [uitdr.] Goedemorgen, hoe gaat het? — Buenos días, ¿qué tal?
• [can.] Ik werk alleen in de morgen. — Solo trabajo por la mañana.
• [perf.] Ik heb de hele morgen gestudeerd. — He estudiado toda la mañana.
• [inv.] ''s Morgens drink ik altijd koffie. — Por las mañanas siempre tomo café.
• [bijzin] Ze belde me toen het nog vroeg in de morgen was. — Me llamó cuando aún era temprano por la mañana.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la mañana, forma más formal' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la mañana, forma más formal' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de ochtend
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la mañana', 'WORD', 'kim - tijd: de ochtend',
'de ochtend = la mañana, la parte del día. Es de-woord, plural de ochtenden, y la palabra más neutra en Holanda.

📌 Regla de bolsillo, de morgen, morgen o de ochtend:
• ¿Con artículo, la parte del día? → de ochtend o de morgen, que son sinónimos.
• ¿Sin artículo, el día siguiente? → morgen — Morgen ga ik werken.
• ¿Las dos cosas a la vez? → morgenochtend, que es mañana por la mañana y nunca «morgen morgen».
• ¿El saludo? → goedemorgen, que es la morgen de la parte del día.

🔑 El truco que casi nunca falla: si lleva de delante es la mañana del día, y si va sola es el día de mañana.

🌓 Las partes del día, ''s ochtends, ''s middags, ''s avonds y ''s nachts:

| # | parte | más o menos | por las … |
|---|---|---|---|
| 1 | de ochtend / de morgen | de 6 a 12 | ''s ochtends / ''s morgens |
| 2 | de middag | de 12 a 18 | ''s middags |
| 3 | de avond | de 18 a 24 | ''s avonds |
| 4 | de nacht | de 0 a 6 | ''s nachts |

• ''s — lo que queda de des, un genitivo antiguo, y por eso lleva apóstrofo: ''s avonds es des avonds.
• vanochtend, vanmiddag, vanavond, vannacht — esta mañana, esta tarde, esta noche.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la mañana');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la mañana' LIMIT 1),
    'nl_NL', 'de ochtend', 'de ójtent',
'• [can.] De ochtend is mijn favoriete deel van de dag. — La mañana es mi parte favorita del día.
• [perf.] Ik heb vanochtend hardgelopen. — Esta mañana he salido a correr.
• [inv.] ''s Ochtends neem ik de trein. — Por las mañanas cojo el tren.
• [bijzin] Ik ben blij als de ochtend rustig begint. — Me alegra que la mañana empiece tranquila.
• [vraag] Kun je morgenochtend langskomen? — ¿Puedes pasarte mañana por la mañana?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la mañana' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la mañana' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de toekomst
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el futuro', 'WORD', 'kim - tijd: de toekomst',
'de toekomst = el futuro. Es de-woord y en el uso normal no tiene plural.

• in de toekomst — en el futuro, con artículo.
• toekomstig — futuro como adjetivo: mijn toekomstige baan.

🪜 La escalera del tiempo, het verleden, het heden y de toekomst:

| # | palabra | español | lo que se dice en el habla |
|---|---|---|---|
| 1 | het verleden | el pasado | vroeger, antes |
| 2 | het heden | el presente | nu, tegenwoordig |
| 3 | de toekomst | el futuro | straks, later, in de toekomst |

• het verleden — viene de verlijden, pasar, así que es lo que ya ha pasado.
• de toekomst — viene de toekomen, lo que está por venir.

⚠️ Los tiempos verbales se llaman distinto, de verleden tijd es el pasado gramatical y de toekomende tijd el futuro.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el futuro');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el futuro' LIMIT 1),
    'nl_NL', 'de toekomst', 'de túkomst',
'• [can.] Niemand weet wat de toekomst brengt. — Nadie sabe lo que trae el futuro.
• [perf.] We hebben veel over de toekomst gepraat. — Hemos hablado mucho del futuro.
• [inv.] In de toekomst wil ik in Nederland wonen. — En el futuro quiero vivir en Países Bajos.
• [bijzin] Ik maak me zorgen omdat de toekomst onzeker is. — Me preocupo porque el futuro es incierto.
• [uitdr.] De toekomst ligt open. — El futuro está abierto.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el futuro' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el futuro' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de middag
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la tarde', 'WORD', 'kim - tijd: de middag',
'de middag = la tarde, de las doce a las seis más o menos. Es de-woord, plural de middagen.

⚠️ La tarde española de las ocho ya es de avond, y el mediodía exacto es twaalf uur.

• goedemiddag — buenas tardes.

🌓 Las partes del día, ''s ochtends, ''s middags, ''s avonds y ''s nachts:

| # | parte | más o menos | por las … |
|---|---|---|---|
| 1 | de ochtend / de morgen | de 6 a 12 | ''s ochtends / ''s morgens |
| 2 | de middag | de 12 a 18 | ''s middags |
| 3 | de avond | de 18 a 24 | ''s avonds |
| 4 | de nacht | de 0 a 6 | ''s nachts |

• ''s — lo que queda de des, un genitivo antiguo, y por eso lleva apóstrofo: ''s avonds es des avonds.
• vanochtend, vanmiddag, vanavond, vannacht — esta mañana, esta tarde, esta noche.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la tarde');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la tarde' LIMIT 1),
    'nl_NL', 'de middag', 'de mídaj',
'• [uitdr.] Goedemiddag, kan ik u helpen? — Buenas tardes, ¿le puedo ayudar?
• [perf.] We hebben de hele middag in het park gezeten. — Hemos estado toda la tarde en el parque.
• [inv.] Morgenmiddag heb ik een afspraak. — Mañana por la tarde tengo una cita.
• [bijzin] Ik bel je als ik vanmiddag tijd heb. — Te llamo si esta tarde tengo tiempo.
• [vraag] Wat doe je vanmiddag? — ¿Qué haces esta tarde?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la tarde' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la tarde' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de avond
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la noche, antes de dormir', 'WORD', 'kim - tijd: de avond',
'de avond = la noche mientras aún estás despierto, de las seis a medianoche más o menos. Es de-woord, plural de avonden.

📌 Regla de bolsillo, de avond o de nacht:
• ¿Cenas, sales o ves la tele? → de avond — goedenavond.
• ¿Duermes, o son altas horas de la madrugada? → de nacht — goedenacht, welterusten.
• ¿Esta noche, aún despierto? → vanavond.
• ¿Esta noche, durmiendo, o la que acaba de pasar? → vannacht.

🌓 Las partes del día, ''s ochtends, ''s middags, ''s avonds y ''s nachts:

| # | parte | más o menos | por las … |
|---|---|---|---|
| 1 | de ochtend / de morgen | de 6 a 12 | ''s ochtends / ''s morgens |
| 2 | de middag | de 12 a 18 | ''s middags |
| 3 | de avond | de 18 a 24 | ''s avonds |
| 4 | de nacht | de 0 a 6 | ''s nachts |

• ''s — lo que queda de des, un genitivo antiguo, y por eso lleva apóstrofo: ''s avonds es des avonds.
• vanochtend, vanmiddag, vanavond, vannacht — esta mañana, esta tarde, esta noche.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la noche, antes de dormir');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la noche, antes de dormir' LIMIT 1),
    'nl_NL', 'de avond', 'de áavont',
'• [uitdr.] Goedenavond, welkom! — Buenas noches, ¡bienvenidos!
• [perf.] We hebben een gezellige avond gehad. — Hemos pasado una noche muy agradable.
• [inv.] ''s Avonds kook ik meestal. — Por las noches suelo cocinar.
• [vraag] Heb je vanavond tijd? — ¿Tienes tiempo esta noche?
• [bijzin] Ik weet niet of ik vanavond kan komen. — No sé si podré venir esta noche.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la noche, antes de dormir' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la noche, antes de dormir' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de nacht
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la noche, mientras dormimos', 'WORD', 'kim - tijd: de nacht',
'de nacht = la noche de dormir, de medianoche a la madrugada. Es de-woord, plural de nachten.

📌 Regla de bolsillo, de avond o de nacht:
• ¿Cenas, sales o ves la tele? → de avond — goedenavond.
• ¿Duermes, o son altas horas de la madrugada? → de nacht — goedenacht, welterusten.
• ¿Esta noche, aún despierto? → vanavond.
• ¿Esta noche, durmiendo, o la que acaba de pasar? → vannacht.

🌓 Las partes del día, ''s ochtends, ''s middags, ''s avonds y ''s nachts:

| # | parte | más o menos | por las … |
|---|---|---|---|
| 1 | de ochtend / de morgen | de 6 a 12 | ''s ochtends / ''s morgens |
| 2 | de middag | de 12 a 18 | ''s middags |
| 3 | de avond | de 18 a 24 | ''s avonds |
| 4 | de nacht | de 0 a 6 | ''s nachts |

• ''s — lo que queda de des, un genitivo antiguo, y por eso lleva apóstrofo: ''s avonds es des avonds.
• vanochtend, vanmiddag, vanavond, vannacht — esta mañana, esta tarde, esta noche.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la noche, mientras dormimos');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la noche, mientras dormimos' LIMIT 1),
    'nl_NL', 'de nacht', 'de najt',
'• [can.] Ik slaap acht uur per nacht. — Duermo ocho horas por noche.
• [perf.] Ik heb vannacht slecht geslapen. — Esta noche he dormido mal.
• [inv.] ''s Nachts is het hier heel stil. — Por la noche aquí hay mucho silencio.
• [bijzin] Hij belde midden in de nacht omdat hij ziek was. — Llamó en plena noche porque estaba enfermo.
• [uitdr.] Welterusten en goedenacht! — ¡Que descanses y buenas noches!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la noche, mientras dormimos' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la noche, mientras dormimos' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de periode
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el periodo', 'WORD', 'kim - tijd: de periode',
'de periode = el periodo, la temporada. Es de-woord, plural de periodes o de perioden.

• een drukke periode — una temporada de mucho trabajo.
• de proefperiode — el periodo de prueba.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el periodo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el periodo' LIMIT 1),
    'nl_NL', 'de periode', 'de peri-óode',
'• [can.] Het is een drukke periode op mijn werk. — Es una temporada de mucho lío en el trabajo.
• [perf.] Ik heb een moeilijke periode gehad. — He pasado una mala racha.
• [inv.] In die periode woonde ik in Utrecht. — En esa época vivía en Utrecht.
• [bijzin] Ik weet niet hoe lang de proefperiode duurt. — No sé cuánto dura el periodo de prueba.
• [vraag] Voor welke periode wil je de auto huren? — ¿Para qué periodo quieres alquilar el coche?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el periodo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el periodo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de vakantie
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las vacaciones', 'WORD', 'kim - tijd: de vakantie',
'de vakantie = las vacaciones. Es de-woord y va en singular, al revés que en español; plural de vakanties.

• op vakantie gaan — irse de vacaciones, con op y sin artículo.
• de zomervakantie — las vacaciones de verano.

🔑 El truco que casi nunca falla: el español lo dice en plural y el neerlandés en singular, así que es Mijn vakantie is voorbij y nunca «zijn voorbij».'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'las vacaciones');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'las vacaciones' LIMIT 1),
    'nl_NL', 'de vakantie', 'de fakántsi',
'• [inv.] Volgende week ga ik op vakantie. — La semana que viene me voy de vacaciones.
• [perf.] We zijn op vakantie in Italië geweest. — Hemos estado de vacaciones en Italia.
• [vraag] Waar ga je deze zomer op vakantie? — ¿Dónde te vas de vacaciones este verano?
• [bijzin] Ik ben blij dat de vakantie bijna begint. — Me alegro de que las vacaciones empiecen pronto.
• [uitdr.] Fijne vakantie! — ¡Felices vacaciones!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las vacaciones' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'las vacaciones' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- het verleden
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el pasado', 'WORD', 'kim - tijd: het verleden',
'het verleden = el pasado. Es het-woord y no tiene plural.

• in het verleden — en el pasado, con artículo.
• vroeger — antes, en otros tiempos, que es lo que más se dice: Vroeger rookte ik.

🪜 La escalera del tiempo, het verleden, het heden y de toekomst:

| # | palabra | español | lo que se dice en el habla |
|---|---|---|---|
| 1 | het verleden | el pasado | vroeger, antes |
| 2 | het heden | el presente | nu, tegenwoordig |
| 3 | de toekomst | el futuro | straks, later, in de toekomst |

• het verleden — viene de verlijden, pasar, así que es lo que ya ha pasado.
• de toekomst — viene de toekomen, lo que está por venir.

⚠️ Los tiempos verbales se llaman distinto, de verleden tijd es el pasado gramatical y de toekomende tijd el futuro.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el pasado');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el pasado' LIMIT 1),
    'nl_NL', 'het verleden', 'het ferléeden',
'• [can.] Het verleden kun je niet veranderen. — El pasado no se puede cambiar.
• [perf.] Hij heeft een moeilijk verleden gehad. — Ha tenido un pasado difícil.
• [inv.] In het verleden werkte ik als kok. — En el pasado trabajé de cocinero.
• [bijzin] Ze praat niet graag over het verleden omdat het pijn doet. — No le gusta hablar del pasado porque le duele.
• [uitdr.] Dat is verleden tijd. — Eso es agua pasada.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el pasado' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el pasado' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- het heden
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el presente, el momento actual', 'WORD', 'kim - tijd: het heden',
'het heden = el presente, el momento actual, y es palabra algo formal. Es het-woord y no tiene plural.

• tot op heden — hasta la fecha.
• tegenwoordig — hoy en día, el adverbio que se usa en el habla.

🪜 La escalera del tiempo, het verleden, het heden y de toekomst:

| # | palabra | español | lo que se dice en el habla |
|---|---|---|---|
| 1 | het verleden | el pasado | vroeger, antes |
| 2 | het heden | el presente | nu, tegenwoordig |
| 3 | de toekomst | el futuro | straks, later, in de toekomst |

• het verleden — viene de verlijden, pasar, así que es lo que ya ha pasado.
• de toekomst — viene de toekomen, lo que está por venir.

⚠️ Los tiempos verbales se llaman distinto, de verleden tijd es el pasado gramatical y de toekomende tijd el futuro.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el presente, el momento actual');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el presente, el momento actual' LIMIT 1),
    'nl_NL', 'het heden', 'het héeden',
'• [can.] Het heden is belangrijker dan het verleden. — El presente es más importante que el pasado.
• [perf.] Het museum heeft verleden en heden met elkaar verbonden. — El museo ha unido el pasado y el presente.
• [inv.] Tot op heden heb ik geen antwoord gekregen. — Hasta la fecha no he recibido respuesta.
• [bijzin] Ik denk dat je meer van het heden moet genieten. — Creo que tienes que disfrutar más del presente.
• [uitdr.] Van verleden tot heden. — Del pasado al presente.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el presente, el momento actual' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el presente, el momento actual' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de minuut
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el minuto', 'WORD', 'kim - tijd: de minuut',
'de minuut = el minuto. Es de-woord, plural de minuten.

⚠️ Al revés que uur, minuut sí va en plural tras un número, vijf minuten pero twee uur.

• het minuutje — el minutito.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el minuto');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el minuto' LIMIT 1),
    'nl_NL', 'de minuut', 'de minüt',
'• [can.] De bus komt over vijf minuten. — El autobús llega dentro de cinco minutos.
• [perf.] Ik heb tien minuten gewacht. — He esperado diez minutos.
• [vraag] Heb je een minuutje? — ¿Tienes un minuto?
• [bijzin] Ik zeg het je zodra ik een minuut vrij heb. — Te lo digo en cuanto tenga un minuto libre.
• [uitdr.] Elke minuut telt. — Cada minuto cuenta.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el minuto' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el minuto' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de klok
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el reloj de pared', 'WORD', 'kim - tijd: de klok',
'de klok = el reloj de pared, de torre o de cocina, el que no se lleva puesto. Es de-woord, plural de klokken, y también es la campana.

• de klok rond — las veinticuatro horas.

📌 Regla de bolsillo, het uur, de klok, het horloge o hoe laat:
• ¿Una duración de sesenta minutos? → het uur — Ik heb twee uur gewacht.
• ¿El reloj de la pared, de la torre o de la cocina? → de klok.
• ¿El reloj de pulsera? → het horloge.
• ¿Preguntas la hora? → Hoe laat is het? — nunca «welk uur is het».

⚠️ Tras un número uur va en singular, twee uur y om vijf uur, y el plural uren es para cantidades vagas, Ik heb uren gewacht.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el reloj de pared');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el reloj de pared' LIMIT 1),
    'nl_NL', 'de klok', 'de klok',
'• [can.] De klok in de keuken loopt achter. — El reloj de la cocina va atrasado.
• [perf.] Heb je de klok al verzet? — ¿Ya has cambiado la hora del reloj?
• [inv.] Vannacht gaat de klok een uur terug. — Esta noche se atrasa la hora.
• [bijzin] Ik kijk steeds op de klok omdat ik haast heb. — No paro de mirar el reloj porque tengo prisa.
• [uitdr.] Hij werkt de klok rond. — Trabaja a todas horas.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el reloj de pared' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el reloj de pared' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de pauze
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la pausa, el descanso', 'WORD', 'kim - tijd: de pauze',
'de pauze = la pausa, el descanso. Es de-woord, plural de pauzes.

• pauze nemen — hacer una pausa, sin artículo.
• de lunchpauze — la pausa para comer.
• pauzeren — hacer una pausa, el verbo.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la pausa, el descanso');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la pausa, el descanso' LIMIT 1),
    'nl_NL', 'de pauze', 'de páuse',
'• [can.] We hebben om twaalf uur pauze. — Tenemos descanso a las doce.
• [perf.] Ik heb nog geen pauze gehad. — Todavía no he tenido descanso.
• [inv.] Na de pauze gaan we verder. — Después del descanso seguimos.
• [bijzin] Ik bel je terug als ik pauze heb. — Te devuelvo la llamada cuando tenga descanso.
• [geb.] Neem even pauze! — ¡Tómate un descanso!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la pausa, el descanso' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la pausa, el descanso' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de seconde
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el segundo, la unidad de tiempo', 'WORD', 'kim - tijd: de seconde',
'de seconde = el segundo de tiempo. Es de-woord, plural de seconden.

⚠️ El segundo de una serie no es seconde sino tweede, como en de tweede keer.

• het secondje — el segundito.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el segundo, la unidad de tiempo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el segundo, la unidad de tiempo' LIMIT 1),
    'nl_NL', 'de seconde', 'de sekónde',
'• [can.] Een minuut heeft zestig seconden. — Un minuto tiene sesenta segundos.
• [perf.] Hij heeft het record met twee seconden verbeterd. — Ha mejorado el récord en dos segundos.
• [inv.] Binnen een paar seconden was alles weg. — En pocos segundos todo había desaparecido.
• [bijzin] Ik weet niet hoeveel seconden het duurde. — No sé cuántos segundos duró.
• [geb.] Wacht een secondje! — ¡Espera un segundito!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el segundo, la unidad de tiempo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el segundo, la unidad de tiempo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- het horloge
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el reloj de pulsera', 'WORD', 'kim - tijd: het horloge',
'het horloge = el reloj de pulsera. Es het-woord, plural de horloges, y la g suena como la j francesa.

📌 Regla de bolsillo, het uur, de klok, het horloge o hoe laat:
• ¿Una duración de sesenta minutos? → het uur — Ik heb twee uur gewacht.
• ¿El reloj de la pared, de la torre o de la cocina? → de klok.
• ¿El reloj de pulsera? → het horloge.
• ¿Preguntas la hora? → Hoe laat is het? — nunca «welk uur is het».

⚠️ Tras un número uur va en singular, twee uur y om vijf uur, y el plural uren es para cantidades vagas, Ik heb uren gewacht.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el reloj de pulsera');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el reloj de pulsera' LIMIT 1),
    'nl_NL', 'het horloge', 'het horlóoshe',
'• [can.] Mijn horloge loopt voor. — Mi reloj va adelantado.
• [perf.] Ik heb een nieuw horloge gekregen. — Me han regalado un reloj nuevo.
• [inv.] Zonder horloge weet ik nooit hoe laat het is. — Sin reloj nunca sé qué hora es.
• [vraag] Hoe laat is het op jouw horloge? — ¿Qué hora tienes en tu reloj?
• [bijzin] Ik zag dat hij steeds op zijn horloge keek. — Vi que no paraba de mirar el reloj.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el reloj de pulsera' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el reloj de pulsera' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- het kwartier
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el cuarto de hora', 'WORD', 'kim - tijd: het kwartier',
'het kwartier = el cuarto de hora, quince minutos de duración. Es het-woord, plural de kwartieren.

⚠️ Al dar la hora no se dice kwartier sino kwart, como en kwart over negen o kwart voor tien.

• over een kwartier — dentro de un cuarto de hora.
• driekwartier — tres cuartos de hora, en una palabra.

🔑 El truco que casi nunca falla: si preguntas cuánto dura es kwartier, y si preguntas qué hora es, kwart.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el cuarto de hora');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuarto de hora' LIMIT 1),
    'nl_NL', 'het kwartier', 'het kuartíir',
'• [can.] De trein vertrekt over een kwartier. — El tren sale dentro de un cuarto de hora.
• [perf.] Ik heb een kwartier op je gewacht. — Te he esperado un cuarto de hora.
• [inv.] Elk kwartier komt er een bus. — Cada cuarto de hora pasa un autobús.
• [bijzin] Bel me als je over een kwartier niet thuis bent. — Llámame si dentro de un cuarto de hora no estás en casa.
• [vraag] Is het kwart over of kwart voor? — ¿Es y cuarto o menos cuarto?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuarto de hora' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuarto de hora' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de kalender
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el calendario', 'WORD', 'kim - tijd: de kalender',
'de kalender = el calendario. Es de-woord, plural de kalenders.

• de agenda — la agenda, donde se apuntan las citas.
• de verjaardagskalender — el calendario de cumpleaños, que en Holanda se cuelga en el baño.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el calendario');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el calendario' LIMIT 1),
    'nl_NL', 'de kalender', 'de kalénder',
'• [can.] De kalender hangt in de keuken. — El calendario está colgado en la cocina.
• [perf.] Ik heb je verjaardag op de kalender gezet. — He apuntado tu cumpleaños en el calendario.
• [inv.] Volgens de kalender is het vandaag een feestdag. — Según el calendario hoy es festivo.
• [bijzin] Ik kijk even op de kalender of ik vrij ben. — Miro en el calendario si estoy libre.
• [vraag] Heb jij ook een verjaardagskalender op de wc? — ¿Tú también tienes un calendario de cumpleaños en el baño?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el calendario' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - tijd'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el calendario' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));


-- =============================================================================
-- 3. La que ya existia
-- =============================================================================
-- Enlazar las tarjetas ya existentes (ids esperados en la BD a 2026-10-29):
--   de wekker -> id 82
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT l.word_es_id, (SELECT id FROM word_groups WHERE title = 'kim - tijd')
FROM words_lang l JOIN words_es e ON e.id = l.word_es_id
WHERE l.lang_code = 'nl_NL' AND e.word_type = 'WORD'
  AND l.text IN ('de wekker');

-- de wekker no estaba en 'generic': se le pone, como a toda tarjeta (§5.5)
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT l.word_es_id, (SELECT id FROM word_groups WHERE title = 'generic')
FROM words_lang l JOIN words_es e ON e.id = l.word_es_id
WHERE l.lang_code = 'nl_NL' AND e.word_type = 'WORD'
  AND l.text IN ('de wekker');
