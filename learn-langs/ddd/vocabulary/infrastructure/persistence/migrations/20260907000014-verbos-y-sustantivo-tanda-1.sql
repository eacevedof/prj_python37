-- Learn Languages App - Migration
-- Migration: 20260907000014-verbos-y-sustantivo-tanda-1
-- Description: Eduardo: "crea otro grupo con los 100 verbos mas usados y su sustantivo
--   (con de het) pero pon frases mas usadas es decir tanto verbo como sustantivo en
--   frases no palabras sueltas".
--
--   Alcance: 100 verbos por dos tarjetas cada uno (la del verbo en frase y la del
--   sustantivo en frase) son 200 tarjetas. Hacerlas de golpe con la ficha completa de
--   cada verbo saldria mal, asi que van por TANDAS de 20 verbos. Esta es la tanda 1, con
--   los veinte que mejor sirven para abrir: frecuentes y con un sustantivo derivado claro
--   y de uso diario. Quedan cuatro tandas.
--
--   Los veinte de esta tanda, con su pareja: vragen/de vraag, denken/de gedachte,
--   beginnen/het begin, helpen/de hulp, leven/het leven, wonen/de woning, eten/het eten,
--   drinken/de drank, slapen/de slaap, betalen/de betaling, reizen/de reis, rijden/de rit,
--   werken/het werk, spreken/het gesprek, komen/de komst, gaan/de gang, zien/het gezicht,
--   geven/de gift, kopen/de koop y verkopen/de verkoop. Son 40 tarjetas PHRASE.
--
--   Ninguna palabra suelta: las cuarenta son frases de uso real (Mag ik je iets vragen?,
--   Ik heb een vraag, Kan ik met pin betalen?, Het huis staat te koop, Goede reis!).
--
--   El bloque compartido resuelve lo que de verdad pedia Eduardo con el de/het: el
--   articulo del derivado NO es aleatorio, lo decide la terminacion. -ing y -heid siempre
--   de; ge- y los infinitivos sustantivados siempre het; raiz desnuda casi siempre de, con
--   cuatro excepciones que se listan (het begin, het werk, het antwoord, het bezoek) y las
--   dos que van al reves (de gedachte, de gedaante).
--
--   La tarjeta del verbo lleva sus tres formas, su auxiliar y su regimen; la del
--   sustantivo, por que lleva ese articulo, su plural y sus colocaciones.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'verbos frecuentes y su sustantivo - vragen, de vraag',
       'Los verbos mas usados del neerlandes emparejados con su sustantivo derivado, cada uno en una frase de uso real y nunca como palabra suelta: Mag ik je iets vragen? junto a Ik heb een vraag. La tarjeta del verbo trae sus tres formas, su auxiliar y las preposiciones que rige; la del sustantivo, su articulo con el motivo (la terminacion lo decide: -ing y -heid son siempre de, ge- y los infinitivos sustantivados siempre het, la raiz desnuda casi siempre de), su plural y las colocaciones con las que aparece de verdad. Se construye por tandas de veinte verbos',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'verbos frecuentes y su sustantivo - vragen, de vraag');

-- =============================================================================
-- 2. Las 40 tarjetas: por cada verbo, una del verbo y otra del sustantivo
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿te puedo preguntar una cosa?', 'PHRASE', 'Verbo frecuente: vragen',
'Mag ik je iets vragen? = ¿te puedo preguntar una cosa?. El verbo es vragen, y su sustantivo es de vraag, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: vragen – vroeg – heeft gevraagd. El auxiliar del perfecto es hebben.

⚠️ Rige naar cuando preguntas POR algo o alguien: vragen naar de weg (preguntar el camino). Y om cuando PIDES: vragen om hulp (pedir ayuda). Sin preposicion, preguntar algo a alguien: iemand iets vragen.

🔗 La pareja: vragen → de vraag. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: vragen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tengo una pregunta', 'PHRASE', 'Verbo frecuente: de vraag',
'Ik heb een vraag. = tengo una pregunta. El sustantivo es de vraag, derivado del verbo vragen.

🔤 Por que lleva ese articulo: raiz desnuda, y las raices desnudas casi siempre son de.

📋 Como se usa: El plural es de vragen, igual que el infinitivo. Colocaciones: een vraag stellen (hacer una pregunta, con stellen y no con doen), de vraag is of… (la cuestion es si…), geen vraag te veel (ninguna pregunta esta de mas). Y en economia, vraag en aanbod es oferta y demanda, con la vraag en el lado de la demanda.

🔗 La pareja: de vraag ← vragen. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: de vraag');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me lo estoy pensando', 'PHRASE', 'Verbo frecuente: denken',
'Ik denk er nog over na. = me lo estoy pensando. El verbo es denken, y su sustantivo es de gedachte, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: denken – dacht – heeft gedacht. El auxiliar del perfecto es hebben.

⚠️ Rige aan para pensar EN algo (Ik denk aan jou) y over para pensar SOBRE algo, darle vueltas (nadenken over). Fuerte e irregular: dacht no se parece nada al infinitivo.

🔗 La pareja: denken → de gedachte. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: denken');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'es una buena idea', 'PHRASE', 'Verbo frecuente: de gedachte',
'Dat is een goede gedachte. = es una buena idea. El sustantivo es de gedachte, derivado del verbo denken.

🔤 Por que lleva ese articulo: empieza por ge-, pero es de las excepciones: gedachte es de y no het.

📋 Como se usa: Ojo con esta, que rompe la regla: casi todos los sustantivos con ge- son het (het gesprek, het gezicht), pero de gedachte es de. El plural es de gedachten. Colocaciones: in gedachten zijn (estar absorto), van gedachten veranderen (cambiar de opinion), een goede gedachte (una buena idea). Y het idee tambien existe y es mas corriente para idea.

🔗 La pareja: de gedachte ← denken. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: de gedachte');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'empezamos a las nueve', 'PHRASE', 'Verbo frecuente: beginnen',
'We beginnen om negen uur. = empezamos a las nueve. El verbo es beginnen, y su sustantivo es het begin, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: beginnen – begon – is begonnen. El auxiliar del perfecto es zijn.

⚠️ Su auxiliar es ZIJN, no hebben: Ik ben begonnen. Es de los verbos de cambio de estado. Rige met para empezar CON algo (beginnen met het huiswerk) y aan para ponerse a algo (aan een boek beginnen).

🔗 La pareja: beginnen → het begin. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: beginnen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'al principio era difícil', 'PHRASE', 'Verbo frecuente: het begin',
'In het begin was het moeilijk. = al principio era difícil. El sustantivo es het begin, derivado del verbo beginnen.

🔤 Por que lleva ese articulo: raiz desnuda, pero esta es het: hay que aprenderla asi.

📋 Como se usa: Sin plural en el uso normal. Colocaciones: in het begin (al principio), vanaf het begin (desde el principio), aan het begin van (al comienzo de), het begin van het einde (el principio del fin). Y beginner es el principiante, con de.

🔗 La pareja: het begin ← beginnen. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: het begin');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿me ayudas un momento?', 'PHRASE', 'Verbo frecuente: helpen',
'Kun je me even helpen? = ¿me ayudas un momento?. El verbo es helpen, y su sustantivo es de hulp, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: helpen – hielp – heeft geholpen. El auxiliar del perfecto es hebben.

⚠️ Fuerte: hielp y geholpen. Rige met para ayudar CON algo (helpen met de afwas) y bij en contexto mas formal. Y en una tienda, Wordt u al geholpen? es ¿le atienden ya?

🔗 La pareja: helpen → de hulp. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: helpen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'gracias por tu ayuda', 'PHRASE', 'Verbo frecuente: de hulp',
'Bedankt voor je hulp. = gracias por tu ayuda. El sustantivo es de hulp, derivado del verbo helpen.

🔤 Por que lleva ese articulo: raiz desnuda, de.

📋 Como se usa: Casi siempre en singular. Colocaciones: om hulp vragen (pedir ayuda), hulp nodig hebben (necesitar ayuda), eerste hulp (primeros auxilios, y de ahi EHBO), de hulpverlener (el socorrista). Y hulp tambien es la persona que ayuda en casa: de huishoudelijke hulp.

🔗 La pareja: de hulp ← helpen. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: de hulp');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'todavía vive', 'PHRASE', 'Verbo frecuente: leven',
'Hij leeft nog. = todavía vive. El verbo es leven, y su sustantivo es het leven, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: leven – leefde – heeft geleefd. El auxiliar del perfecto es hebben.

⚠️ Debil y regular. Rige van para vivir DE algo (leven van je pensioen). Ojo de no confundirlo con wonen, que es residir en un sitio: Ik woon in Madrid, maar ik leef goed.

🔗 La pareja: leven → het leven. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: leven');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la vida es cara', 'PHRASE', 'Verbo frecuente: het leven',
'Het leven is duur. = la vida es cara. El sustantivo es het leven, derivado del verbo leven.

🔤 Por que lleva ese articulo: infinitivo sustantivado, y todos los infinitivos sustantivados son het.

📋 Como se usa: Es el mismo infinitivo usado como sustantivo, y por eso het. Plural de levens. Colocaciones: het dagelijks leven (la vida diaria), in het echte leven (en la vida real), levenslang (de por vida), Zo is het leven (asi es la vida). Y de levensverzekering es el seguro de vida.

🔗 La pareja: het leven ← leven. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: het leven');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'vivo en Ámsterdam', 'PHRASE', 'Verbo frecuente: wonen',
'Ik woon in Amsterdam. = vivo en Ámsterdam. El verbo es wonen, y su sustantivo es de woning, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: wonen – woonde – heeft gewoond. El auxiliar del perfecto es hebben.

⚠️ Debil. Es residir, tener el domicilio, frente a leven que es estar vivo. Con ciudad va in (in Amsterdam) y con calle va op o aan (op de Kalverstraat, aan de gracht).

🔗 La pareja: wonen → de woning. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: wonen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'buscamos vivienda', 'PHRASE', 'Verbo frecuente: de woning',
'We zoeken een woning. = buscamos vivienda. El sustantivo es de woning, derivado del verbo wonen.

🔤 Por que lleva ese articulo: acaba en -ing, y todo -ing es de.

📋 Como se usa: Plural de woningen. Es el termino neutro y administrativo para vivienda; het huis es la casa concreta y het appartement el piso. Colocaciones: de woningmarkt (el mercado inmobiliario), de sociale huurwoning (la vivienda social), de woningnood (la crisis de vivienda), que es palabra de telediario en Paises Bajos.

🔗 La pareja: de woning ← wonen. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: de woning');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'comemos a las seis', 'PHRASE', 'Verbo frecuente: eten',
'We eten om zes uur. = comemos a las seis. El verbo es eten, y su sustantivo es het eten, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: eten – at – heeft gegeten. El auxiliar del perfecto es hebben.

⚠️ Fuerte, y de los que mas cambian: at en singular, aten en plural, gegeten de participio. Ojo al solape: wij eten (presente) frente a wij aten (imperfecto).

🔗 La pareja: eten → het eten. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: eten');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la comida está lista', 'PHRASE', 'Verbo frecuente: het eten',
'Het eten is klaar. = la comida está lista. El sustantivo es het eten, derivado del verbo eten.

🔤 Por que lleva ese articulo: infinitivo sustantivado, het.

📋 Como se usa: Sin plural. Es la comida como sustancia o como el acto: Het eten is klaar. Para el plato concreto, het gerecht; para la comida del mediodia, de lunch; para la cena, het avondeten. Colocaciones: eten koken (cocinar), uit eten gaan (salir a cenar), het eten opwarmen (calentar la comida).

🔗 La pareja: het eten ← eten. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: het eten');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿quieres beber algo?', 'PHRASE', 'Verbo frecuente: drinken',
'Wil je iets drinken? = ¿quieres beber algo?. El verbo es drinken, y su sustantivo es de drank, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: drinken – dronk – heeft gedronken. El auxiliar del perfecto es hebben.

⚠️ Fuerte, con el cambio i–o–o: drinken, dronk, gedronken. El mismo patron que zingen (zong, gezongen) y beginnen (begon, begonnen).

🔗 La pareja: drinken → de drank. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: drinken');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la bebida está incluida', 'PHRASE', 'Verbo frecuente: de drank',
'De drank is inbegrepen. = la bebida está incluida. El sustantivo es de drank, derivado del verbo drinken.

🔤 Por que lleva ese articulo: raiz con cambio de vocal, y es de.

📋 Como se usa: Plural de dranken. Es la bebida como producto, sobre todo la alcoholica: sterke drank (bebida fuerte), de drankwinkel (la tienda de licores), alcoholvrije drank. Para lo que pides en un bar, het drankje (het por el diminutivo -je): Wil je een drankje? Y het drinken es el acto de beber.

🔗 La pareja: de drank ← drinken. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: de drank');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'he dormido mal', 'PHRASE', 'Verbo frecuente: slapen',
'Ik heb slecht geslapen. = he dormido mal. El verbo es slapen, y su sustantivo es de slaap, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: slapen – sliep – heeft geslapen. El auxiliar del perfecto es hebben.

⚠️ Fuerte: sliep, geslapen. Ojo a la ortografia, que alterna aa y a: ik slaap con dos aes, wij slapen con una.

🔗 La pareja: slapen → de slaap. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: slapen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tengo sueño', 'PHRASE', 'Verbo frecuente: de slaap',
'Ik heb slaap. = tengo sueño. El sustantivo es de slaap, derivado del verbo slapen.

🔤 Por que lleva ese articulo: raiz desnuda, de.

📋 Como se usa: Sin plural en este sentido. Fijate en que el sueño se TIENE con hebben: Ik heb slaap, igual que Ik heb honger. Colocaciones: in slaap vallen (quedarse dormido), de slaapkamer (el dormitorio, ya en tu mazo), een slaapje doen (echar una cabezada), slaap lekker (que duermas bien, la despedida de la noche).

🔗 La pareja: de slaap ← slapen. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: de slaap');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿puedo pagar con tarjeta?', 'PHRASE', 'Verbo frecuente: betalen',
'Kan ik met pin betalen? = ¿puedo pagar con tarjeta?. El verbo es betalen, y su sustantivo es de betaling, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: betalen – betaalde – heeft betaald. El auxiliar del perfecto es hebben.

⚠️ Debil e INSEPARABLE: be- es prefijo atono, asi que el participio va sin ge-, betaald y nunca «gebetaald». Rige voor para pagar POR algo: betalen voor de schade.

🔗 La pareja: betalen → de betaling. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: betalen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el pago se ha realizado', 'PHRASE', 'Verbo frecuente: de betaling',
'De betaling is gelukt. = el pago se ha realizado. El sustantivo es de betaling, derivado del verbo betalen.

🔤 Por que lleva ese articulo: acaba en -ing, y todo -ing es de.

📋 Como se usa: Plural de betalingen. Y aqui va vocabulario que necesitas de verdad en Paises Bajos: met pin betalen es pagar con tarjeta de debito, y es lo normal en todas partes; contant es en efectivo, y muchos sitios ya no lo aceptan; de rekening es la cuenta o la factura; de overschrijving es la transferencia; Tikkie es la app con la que todo el mundo se reclama dinero entre amigos.

🔗 La pareja: de betaling ← betalen. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: de betaling');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me gusta viajar solo', 'PHRASE', 'Verbo frecuente: reizen',
'Ik reis graag alleen. = me gusta viajar solo. El verbo es reizen, y su sustantivo es de reis, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: reizen – reisde – heeft gereisd. El auxiliar del perfecto es hebben.

⚠️ Debil, con el cambio de z a s: reizen con z en infinitivo y plural, ik reis con s en singular. Es la misma alternancia de huizen y huis. Su auxiliar es hebben, pero con destino explicito se usa zijn: Ik ben naar Parijs gereisd.

🔗 La pareja: reizen → de reis. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: reizen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡buen viaje!', 'PHRASE', 'Verbo frecuente: de reis',
'Goede reis! = ¡buen viaje!. El sustantivo es de reis, derivado del verbo reizen.

🔤 Por que lleva ese articulo: raiz desnuda, de.

📋 Como se usa: Plural de reizen, otra vez igual que el infinitivo. Colocaciones: op reis gaan (irse de viaje), een reis boeken (reservar un viaje), de zakenreis (el viaje de negocios), het reisbureau (la agencia). Goede reis! es lo que se le dice a quien se va, y tambien vale Fijne reis!

🔗 La pareja: de reis ← reizen. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: de reis');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'conduce demasiado rápido', 'PHRASE', 'Verbo frecuente: rijden',
'Hij rijdt te hard. = conduce demasiado rápido. El verbo es rijden, y su sustantivo es de rit, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: rijden – reed – heeft gereden. El auxiliar del perfecto es hebben.

⚠️ Fuerte, con el cambio ij–ee–e: rijden, reed, gereden, el mismo de kijken y blijven. Con destino, auxiliar zijn: Ik ben naar Utrecht gereden. Sin destino, hebben.

🔗 La pareja: rijden → de rit. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: rijden');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'fue un trayecto largo', 'PHRASE', 'Verbo frecuente: de rit',
'Het was een lange rit. = fue un trayecto largo. El sustantivo es de rit, derivado del verbo rijden.

🔤 Por que lleva ese articulo: raiz con vocal corta, de.

📋 Como se usa: Plural de ritten, con la t doblada porque la vocal es corta. Es el trayecto concreto: een ritje maken (dar una vuelta), de treinrit, de taxirit. No lo confundas con de reis, que es el viaje entero y mas largo. Y het rijbewijs es el carnet de conducir, palabra que necesitaras.

🔗 La pareja: de rit ← rijden. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: de rit');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'trabajo desde casa', 'PHRASE', 'Verbo frecuente: werken',
'Ik werk vanuit huis. = trabajo desde casa. El verbo es werken, y su sustantivo es het werk, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: werken – werkte – heeft gewerkt. El auxiliar del perfecto es hebben.

⚠️ Debil y regular. Rige aan para trabajar EN un proyecto (werken aan een plan), bij para trabajar EN una empresa (Ik werk bij Philips) y als para el puesto (als lerares werken). Y sin sujeto humano significa funcionar: Het werkt niet.

🔗 La pareja: werken → het werk. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: werken');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'voy al trabajo', 'PHRASE', 'Verbo frecuente: het werk',
'Ik ga naar mijn werk. = voy al trabajo. El sustantivo es het werk, derivado del verbo werken.

🔤 Por que lleva ese articulo: raiz desnuda, pero esta es het: hay que aprenderla asi.

📋 Como se usa: Plural de werken, que ademas es como se llaman las obras de un autor. Fijate en que al trabajo se va con el POSESIVO y sin articulo: naar mijn werk, op mijn werk. Colocaciones: aan het werk! (¡a trabajar!), werk zoeken (buscar trabajo), de werkgever (el empleador) y de werknemer (el empleado), que se distinguen por quien da y quien toma el trabajo.

🔗 La pareja: het werk ← werken. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: het werk');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿hablas neerlandés?', 'PHRASE', 'Verbo frecuente: spreken',
'Spreek je Nederlands? = ¿hablas neerlandés?. El verbo es spreken, y su sustantivo es het gesprek, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: spreken – sprak – heeft gesproken. El auxiliar del perfecto es hebben.

⚠️ Fuerte, con el cambio e–a–o: spreken, sprak, gesproken. Rige met para hablar CON alguien y over para hablar DE algo. Es algo mas formal que praten: Mag ik u even spreken? es ¿puedo hablar un momento con usted?

🔗 La pareja: spreken → het gesprek. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: spreken');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tuvimos una buena conversación', 'PHRASE', 'Verbo frecuente: het gesprek',
'We hadden een goed gesprek. = tuvimos una buena conversación. El sustantivo es het gesprek, derivado del verbo spreken.

🔤 Por que lleva ese articulo: empieza por ge-, y los sustantivos con ge- suelen ser het.

📋 Como se usa: Plural de gesprekken, con la k doblada. Colocaciones: een gesprek voeren (mantener una conversacion, con voeren y no con hebben en registro formal), het sollicitatiegesprek (la entrevista de trabajo), in gesprek (comunicando, al telefono). Y de spraak es el habla como facultad, distinto de het gesprek, que es la conversacion concreta.

🔗 La pareja: het gesprek ← spreken. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: het gesprek');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿vienes tú también?', 'PHRASE', 'Verbo frecuente: komen',
'Kom je ook? = ¿vienes tú también?. El verbo es komen, y su sustantivo es de komst, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: komen – kwam – is gekomen. El auxiliar del perfecto es zijn.

⚠️ Fuerte, y su auxiliar es ZIJN porque es de movimiento: Ik ben gekomen. Ojo a la ortografia: ik kom con una o corta, wij komen con o larga. Y kwam en imperfecto, kwamen en plural.

🔗 La pareja: komen → de komst. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: komen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'esperamos su llegada', 'PHRASE', 'Verbo frecuente: de komst',
'We wachten op zijn komst. = esperamos su llegada. El sustantivo es de komst, derivado del verbo komen.

🔤 Por que lleva ese articulo: acaba en -st sobre la raiz, y es de.

📋 Como se usa: Sin plural. Es formal y se usa sobre todo en anuncios y noticias: de komst van de trein, bij aankomst (a la llegada). En el dia a dia se dice mas de aankomst, con aan-. Colocaciones: de wederkomst (la segunda venida), toekomst (el futuro, literalmente lo que viene hacia ti), que es la palabra realmente util de esta familia: de toekomst is onzeker.

🔗 La pareja: de komst ← komen. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: de komst');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿cómo va?', 'PHRASE', 'Verbo frecuente: gaan',
'Hoe gaat het? = ¿cómo va?. El verbo es gaan, y su sustantivo es de gang, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: gaan – ging – is gegaan. El auxiliar del perfecto es zijn.

⚠️ Fuerte e irregular, con auxiliar ZIJN. Hoe gaat het? es EL saludo neerlandes, y se contesta Goed, en met jou? Y gaan + infinitivo sin te es la manera normal de decir el futuro: Ik ga morgen werken.

🔗 La pareja: gaan → de gang. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: gaan');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el abrigo está en el pasillo', 'PHRASE', 'Verbo frecuente: de gang',
'De jas hangt in de gang. = el abrigo está en el pasillo. El sustantivo es de gang, derivado del verbo gaan.

🔤 Por que lleva ese articulo: raiz con cambio de vocal, de.

📋 Como se usa: Plural de gangen. Tiene dos vidas: el pasillo de una casa y la marcha o el curso de algo. In de gang (en el pasillo) frente a de gang van zaken (el curso de los acontecimientos), aan de gang zijn (estar en marcha) y op gang komen (arrancar). Y en un restaurante, een gang es un plato del menu: een viergangenmenu.

🔗 La pareja: de gang ← gaan. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: de gang');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'te veo mañana', 'PHRASE', 'Verbo frecuente: zien',
'Ik zie je morgen. = te veo mañana. El verbo es zien, y su sustantivo es het gezicht, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: zien – zag – heeft gezien. El auxiliar del perfecto es hebben.

⚠️ Fuerte e irregular: zag en singular, zagen en plural, gezien de participio. Ik zie je morgen es la despedida mas corriente, junto con Tot ziens.

🔗 La pareja: zien → het gezicht. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: zien');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'tiene una cara amable', 'PHRASE', 'Verbo frecuente: het gezicht',
'Hij heeft een vriendelijk gezicht. = tiene una cara amable. El sustantivo es het gezicht, derivado del verbo zien.

🔤 Por que lleva ese articulo: empieza por ge-, het.

📋 Como se usa: Plural de gezichten. Tiene dos sentidos que conviene separar: la cara y la vista. Het gezicht es la cara (een vriendelijk gezicht) y tambien la vision; het zicht es la visibilidad (slecht zicht, poca visibilidad). Colocaciones: uit het oog, uit het hart (ojos que no ven), op het eerste gezicht (a primera vista), zijn gezicht verliezen (perder la cara).

🔗 La pareja: het gezicht ← zien. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: het gezicht');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿me pasas la sal?', 'PHRASE', 'Verbo frecuente: geven',
'Kun je me het zout geven? = ¿me pasas la sal?. El verbo es geven, y su sustantivo es de gift, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: geven – gaf – heeft gegeven. El auxiliar del perfecto es hebben.

⚠️ Fuerte: gaf en singular, gaven en plural. Se construye con dos objetos sin preposicion, igual que en español: iemand iets geven (Kun je me het zout geven?). Con aan cuando el destinatario va detras: Geef het aan mij.

🔗 La pareja: geven → de gift. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: geven');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'fue un donativo de los vecinos', 'PHRASE', 'Verbo frecuente: de gift',
'Het was een gift van de buren. = fue un donativo de los vecinos. El sustantivo es de gift, derivado del verbo geven.

🔤 Por que lleva ese articulo: raiz con vocal corta, de.

📋 Como se usa: Plural de giften. Es el donativo, la donacion. Ojo con el falso amigo: en ingles gift es regalo, pero en neerlandes el regalo es het cadeau of het geschenk, y de gift es el donativo a una causa. Y hay otra trampa: het gif, sin t, es el veneno. Colocaciones: een gift doen (hacer un donativo), de gave (el don, el talento), que es otra derivada de geven.

🔗 La pareja: de gift ← geven. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: de gift');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me he comprado una bici nueva', 'PHRASE', 'Verbo frecuente: kopen',
'Ik heb een nieuwe fiets gekocht. = me he comprado una bici nueva. El verbo es kopen, y su sustantivo es de koop, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: kopen – kocht – heeft gekocht. El auxiliar del perfecto es hebben.

⚠️ Irregular: kocht y gekocht, con esa cht que no esta en el infinitivo. Va con el mismo patron que zoeken (zocht, gezocht) y brengen (bracht, gebracht).

🔗 La pareja: kopen → de koop. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: kopen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la casa está en venta', 'PHRASE', 'Verbo frecuente: de koop',
'Het huis staat te koop. = la casa está en venta. El sustantivo es de koop, derivado del verbo kopen.

🔤 Por que lleva ese articulo: raiz desnuda, de.

📋 Como se usa: Plural de kopen. Colocaciones que veras por la calle: te koop (en venta, en los carteles), te huur (en alquiler, su pareja), de koopwoning (la vivienda en propiedad), de koopjes (las gangas), de koopzondag (el domingo con comercios abiertos). Y op de koop toe es por si fuera poco.

🔗 La pareja: de koop ← kopen. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: de koop');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'aquí venden buen queso', 'PHRASE', 'Verbo frecuente: verkopen',
'Ze verkopen hier goede kaas. = aquí venden buen queso. El verbo es verkopen, y su sustantivo es de verkoop, que tiene su propia tarjeta en este grupo.

📊 Las tres formas: verkopen – verkocht – heeft verkocht. El auxiliar del perfecto es hebben.

⚠️ Es kopen con el prefijo ver-, que es atono e INSEPARABLE: el participio va sin ge-, verkocht y nunca «geverkocht». Es el mismo ver- de verpakken y verbergen.

🔗 La pareja: verkopen → de verkoop. Estudialas juntas, porque en neerlandes se pasa de una a otra todo el rato.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: verkopen');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las ventas van bien', 'PHRASE', 'Verbo frecuente: de verkoop',
'De verkoop gaat goed. = las ventas van bien. El sustantivo es de verkoop, derivado del verbo verkopen.

🔤 Por que lleva ese articulo: raiz con prefijo, de.

📋 Como se usa: Casi siempre en singular. Colocaciones: te koop aanbieden (poner a la venta), de verkoper (el vendedor), de uitverkoop (las rebajas), uitverkocht (agotado, lo que veras en los carteles de los conciertos). Y de omzet es la facturacion, que es la palabra que oiras en contexto de empresa.

🔗 La pareja: de verkoop ← verkopen. La tarjeta del verbo esta en este mismo grupo.

🔤 Del verbo al sustantivo, y de donde sale su de o su het:

Casi todo verbo neerlandes tiene un sustantivo derivado, y el articulo no es aleatorio: lo decide la TERMINACION. Estas reglas resuelven la mayoria.

| terminacion | articulo | ejemplos |
|---|---|---|
| **-ing** | siempre **de** | de betaling, de woning, de vergadering, de verhuizing |
| **-heid** | siempre **de** | de gezondheid, de waarheid, de snelheid |
| **-ie** / **-tie** | siempre **de** | de situatie, de vakantie, de politie |
| **ge-** + raiz | casi siempre **het** | het gesprek, het gezicht, het gebouw, het geluid |
| infinitivo sustantivado | siempre **het** | het eten, het leven, het werken, het slapen |
| **-je** (diminutivo) | siempre **het** | het drankje, het ritje, het kaartje |
| raiz desnuda | casi siempre **de** | de vraag, de hulp, de slaap, de koop, de reis |

⚠️ Las excepciones que hay que aprender una a una, porque van contra la regla de la raiz desnuda: het begin, het werk, het antwoord, het bezoek. Y al reves, contra la de ge-: de gedachte y de gedaante son de, no het.

🔑 El truco que resuelve el 90%: Mira como acaba la palabra antes de mirar el diccionario. Si acaba en -ing o -heid, es de sin pensarlo. Si empieza por ge- o es un infinitivo usado como nombre, es het. Si es la raiz pelada del verbo, apuesta por de y aprende las cuatro excepciones.

📐 Y una cosa que ahorra memoria: muchos plurales coinciden con el infinitivo. de vraag hace de vragen, de reis hace de reizen, de koop hace de kopen. No es casualidad: es la misma raiz con la misma terminacion.

📌 Como estudiar cada pareja: aprendete siempre las dos tarjetas juntas, la del verbo y la del sustantivo. En neerlandes se pasa de una a otra constantemente — Mag ik je iets vragen? y Ik heb een vraag dicen casi lo mismo, y quien solo sabe el verbo se queda a medias.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Verbo frecuente: de verkoop');

-- =============================================================================
-- 3. Traducciones
-- =============================================================================
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
SELECT we.id, 'nl_NL', v.nl, v.pron
FROM (
    SELECT 'Verbo frecuente: vragen' AS k, 'Mag ik je iets vragen?' AS nl, 'maj ik ye its fraajen' AS pron
    UNION ALL SELECT 'Verbo frecuente: de vraag', 'Ik heb een vraag.', 'ik hep en fraaj'
    UNION ALL SELECT 'Verbo frecuente: denken', 'Ik denk er nog over na.', 'ik denk er noj oover na'
    UNION ALL SELECT 'Verbo frecuente: de gedachte', 'Dat is een goede gedachte.', 'dat is en jude jedajte'
    UNION ALL SELECT 'Verbo frecuente: beginnen', 'We beginnen om negen uur.', 've bejinen om neejen uur'
    UNION ALL SELECT 'Verbo frecuente: het begin', 'In het begin was het moeilijk.', 'in het bejin vas het muilek'
    UNION ALL SELECT 'Verbo frecuente: helpen', 'Kun je me even helpen?', 'kun ye me eefen helpen'
    UNION ALL SELECT 'Verbo frecuente: de hulp', 'Bedankt voor je hulp.', 'bedankt foor ye hulp'
    UNION ALL SELECT 'Verbo frecuente: leven', 'Hij leeft nog.', 'hai leeft noj'
    UNION ALL SELECT 'Verbo frecuente: het leven', 'Het leven is duur.', 'het leeven is duur'
    UNION ALL SELECT 'Verbo frecuente: wonen', 'Ik woon in Amsterdam.', 'ik voon in ámsterdam'
    UNION ALL SELECT 'Verbo frecuente: de woning', 'We zoeken een woning.', 've zuken en vooning'
    UNION ALL SELECT 'Verbo frecuente: eten', 'We eten om zes uur.', 've eeten om zes uur'
    UNION ALL SELECT 'Verbo frecuente: het eten', 'Het eten is klaar.', 'het eeten is klaar'
    UNION ALL SELECT 'Verbo frecuente: drinken', 'Wil je iets drinken?', 'vil ye its drinken'
    UNION ALL SELECT 'Verbo frecuente: de drank', 'De drank is inbegrepen.', 'de drank is inbejreepen'
    UNION ALL SELECT 'Verbo frecuente: slapen', 'Ik heb slecht geslapen.', 'ik hep slejt jeslaapen'
    UNION ALL SELECT 'Verbo frecuente: de slaap', 'Ik heb slaap.', 'ik hep slaap'
    UNION ALL SELECT 'Verbo frecuente: betalen', 'Kan ik met pin betalen?', 'kan ik met pin betaalen'
    UNION ALL SELECT 'Verbo frecuente: de betaling', 'De betaling is gelukt.', 'de betaaling is jelukt'
    UNION ALL SELECT 'Verbo frecuente: reizen', 'Ik reis graag alleen.', 'ik rais jraaj aleen'
    UNION ALL SELECT 'Verbo frecuente: de reis', 'Goede reis!', 'jude rais'
    UNION ALL SELECT 'Verbo frecuente: rijden', 'Hij rijdt te hard.', 'hai rait te hart'
    UNION ALL SELECT 'Verbo frecuente: de rit', 'Het was een lange rit.', 'het vas en lange rit'
    UNION ALL SELECT 'Verbo frecuente: werken', 'Ik werk vanuit huis.', 'ik verk fanáit hais'
    UNION ALL SELECT 'Verbo frecuente: het werk', 'Ik ga naar mijn werk.', 'ik ja naar main verk'
    UNION ALL SELECT 'Verbo frecuente: spreken', 'Spreek je Nederlands?', 'spreek ye neederlants'
    UNION ALL SELECT 'Verbo frecuente: het gesprek', 'We hadden een goed gesprek.', 've haden en jut jesprek'
    UNION ALL SELECT 'Verbo frecuente: komen', 'Kom je ook?', 'kom ye ook'
    UNION ALL SELECT 'Verbo frecuente: de komst', 'We wachten op zijn komst.', 've vajten op zain komst'
    UNION ALL SELECT 'Verbo frecuente: gaan', 'Hoe gaat het?', 'hu jaat het'
    UNION ALL SELECT 'Verbo frecuente: de gang', 'De jas hangt in de gang.', 'de yas hangt in de jang'
    UNION ALL SELECT 'Verbo frecuente: zien', 'Ik zie je morgen.', 'ik zi ye mórjen'
    UNION ALL SELECT 'Verbo frecuente: het gezicht', 'Hij heeft een vriendelijk gezicht.', 'hai heeft en frindelek jezijt'
    UNION ALL SELECT 'Verbo frecuente: geven', 'Kun je me het zout geven?', 'kun ye me het zaut jeefen'
    UNION ALL SELECT 'Verbo frecuente: de gift', 'Het was een gift van de buren.', 'het vas en jift fan de buuren'
    UNION ALL SELECT 'Verbo frecuente: kopen', 'Ik heb een nieuwe fiets gekocht.', 'ik hep en niuue fits jekojt'
    UNION ALL SELECT 'Verbo frecuente: de koop', 'Het huis staat te koop.', 'het hais staat te koop'
    UNION ALL SELECT 'Verbo frecuente: verkopen', 'Ze verkopen hier goede kaas.', 'ze ferkoopen hiir jude kaas'
    UNION ALL SELECT 'Verbo frecuente: de verkoop', 'De verkoop gaat goed.', 'de ferkoop jaat jut'
) v
JOIN words_es we ON we.notes = v.k;

-- =============================================================================
-- 4. Al grupo nuevo y a generic
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Verbo frecuente: %' AND g.title = 'verbos frecuentes y su sustantivo - vragen, de vraag';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Verbo frecuente: %' AND g.title = 'generic';
