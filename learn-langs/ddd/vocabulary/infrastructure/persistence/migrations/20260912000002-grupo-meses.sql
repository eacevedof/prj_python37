-- Learn Languages App - Migration
-- Migration: 20260912000002-grupo-meses
-- Description: Eduardo: "crea un grupo con los meses".
--
--   El mazo no tenia NI UN mes: ni januari ni ninguno de los doce aparecia en words_lang, y de
--   calendario solo habia maandag/vrijdag (1095), elke week y de hele dag. Hueco completo.
--
--   Se crea 'los meses - de maanden en de datum' con 22 tarjetas: las 12 WORD de los meses (cada
--   una con sus 5 ejemplos en words_lang.notes, §3.7) y 10 PHRASE que ejercitan lo que de verdad
--   se falla al usarlos:
--     - la MINUSCULA (in januari, nunca «in Januari»): es el calco del ingles el que hace fallar.
--     - in / op / om: mes, año y estacion con in; dia y fecha con op; hora con om.
--     - la fecha con numero CARDINAL y sin articulo (op 12 oktober = op twaalf oktober).
--     - begin / half / eind + mes, sin articulo ni preposicion (begin mei, eind juli).
--     - la asimetria estacion/mes: in DE zomer pero in mei.
--     - vorige/deze/volgende maand sin preposicion, y la -e del adjetivo (volgende maand pero
--       volgend jaar, porque het jaar es het-woord).
--     - jarig zijn y no «verjaardag hebben», y el het postizo de Vandaag is het 3 september.
--     - como se leen los años (negentienvijfentachtig frente a tweeduizend zesentwintig).
--
--   Cada mes lleva ademas lo que cae en el en Holanda (Koningsdag, Bevrijdingsdag, Prinsjesdag,
--   Sint-Maarten, Sinterklaas, el cambio de hora), que es lo que hace que la fecha se fije, y el
--   dato practico de juni/juli: al telefono se dicen juno y julei para no confundirlos.
--
--   Bloque compartido '📅 Los doce meses y las tres reglas que los rigen' (§3.3): tabla de los 12
--   con abreviatura, pronunciacion y festivo, las tres reglas, el truco de in/op/om, los tramos
--   begin/half/eind, el vocabulario del calendario con articulo y las estaciones.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'los meses - de maanden en de datum',
       'Los doce meses del año en neerlandes y todo lo que hace falta para dar una fecha. Van SIEMPRE en minuscula (in januari, nunca «in Januari»: el fallo viene del ingles, no del español) y no llevan articulo, al reves que las estaciones (in mei pero in de zomer). Las tres preposiciones no se mezclan: in para el mes, el año y la estacion; op para el dia y la fecha concreta; om para la hora; y met para las fiestas (met Kerst). La fecha se dice con numero cardinal y sin articulo — op 12 oktober es op twaalf oktober, no «de twaalfde» —, y para quedar sin comprometerse estan begin mei, half juni y eind augustus, sin articulo ni preposicion. Incluye el tiempo relativo sin preposicion (vorige maand, deze maand, volgende maand, y volgend jaar con la -e que cae porque het jaar es het-woord), jarig zijn en vez de tener cumpleaños, el het postizo de Vandaag is het 3 september, como se leen los años (negentienvijfentachtig frente a tweeduizend zesentwintig) y el calendario festivo holandes mes a mes: Nieuwjaar, Carnaval, Koningsdag, Bevrijdingsdag, Prinsjesdag, Sint-Maarten, Sinterklaas y Kerst. Con el dato que salva por telefono: juni y juli se dicen juno y julei para no confundirlos',
       'migracion'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'los meses - de maanden en de datum');

-- =============================================================================
-- 2. Los doce meses (WORD)
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'enero', 'WORD', 'Meses: januari',
'januari = enero, y en minuscula, que es el fallo numero uno del hispanohablante que sabe ingles.

📐 Como se usa: In januari is het koud en donker — con el mes siempre va in, nunca op.

🎉 Lo que cae en enero: El 1 es Nieuwjaar (Año Nuevo), que en Holanda se come con oliebollen, y el mes entero es el de los buenos propositos — de goede voornemens.

📋 Tres usos reales:
• In januari begint het nieuwe jaar. — En enero empieza el año nuevo.
• Op 1 januari zijn alle winkels dicht. — El 1 de enero están todas las tiendas cerradas.
• Begin januari ga ik weer aan het werk. — A principios de enero vuelvo al trabajo.

🔤 La escritura: Abreviado es jan., y en una fecha se escribe 1 januari 2026 — dia, mes, año, sin comas y sin de.

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: januari');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'febrero', 'WORD', 'Meses: februari',
'februari = febrero. El mes corto: 28 dias, y 29 en het schrikkeljaar, el año bisiesto.

📐 Como se usa: In februari is het carnaval, vooral in het zuiden. El carnaval es cosa del sur catolico (Brabante y Limburgo), no de Amsterdam.

🎉 Lo que cae en febrero: Valentijnsdag el 14 y el carnaval, que cambia de fecha cada año porque va cuarenta dias antes de Pasen (la Pascua).

📋 Tres usos reales:
• In februari heeft de maand 28 dagen. — En febrero el mes tiene 28 días.
• Om de vier jaar is het een schrikkeljaar. — Cada cuatro años es bisiesto.
• Op 14 februari is het Valentijnsdag. — El 14 de febrero es San Valentín.

🔤 La escritura: Abreviado es feb., y ojo a la -r- del medio, que se escribe aunque casi no se oiga.

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: februari');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'marzo', 'WORD', 'Meses: maart',
'maart = marzo. Es el unico mes que no acaba como en español, y el que abre la primavera: op 21 maart begint de lente.

📐 Como se usa: In maart gaat de zomertijd in — el ultimo domingo de marzo el reloj se adelanta una hora.

🌦️ El refran que lo define: Maart roert zijn staart (marzo mueve la cola), o sea que el tiempo se vuelve loco justo cuando parecia que mejoraba.

📋 Tres usos reales:
• In maart begint de lente. — En marzo empieza la primavera.
• Eind maart gaat de klok een uur vooruit. — A finales de marzo el reloj se adelanta una hora.
• We hebben een afspraak half maart. — Tenemos una cita a mediados de marzo.

🔤 La escritura: Abreviado es mrt., sin la -a-, que es la unica abreviatura de mes que no son las tres primeras letras.

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: maart');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'abril', 'WORD', 'Meses: april',
'april = abril, con el acento en la segunda silaba: a-PRIL, no «Á-pril».

📐 Como se usa: Op 27 april is het Koningsdag, el dia del Rey, que es LA fiesta nacional holandesa: todo el pais de naranja y mercadillos en la calle (de vrijmarkt).

🃏 Y el 1 de abril es el dia de las bromas, como nuestro 28 de diciembre: 1 april, kikker in je bil, que es la cantinela infantil cuando cuela la broma.

📋 Tres usos reales:
• Op 27 april vieren we Koningsdag. — El 27 de abril celebramos el Día del Rey.
• In april is het weer wisselvallig. — En abril el tiempo es variable.
• Half april gaan de terrassen weer open. — A mediados de abril abren las terrazas otra vez.

🌦️ El refran: Aprilletje zoet geeft nog weleens een witte hoed — abril dulce a veces se pone sombrero blanco, o sea que aun puede nevar.

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: april');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'mayo', 'WORD', 'Meses: mei',
'mei = mayo. El nombre de mes mas corto del neerlandes, y no se abrevia nunca porque ya son tres letras.

📐 Como se usa: Op 5 mei is het Bevrijdingsdag, el dia de la Liberacion de 1945; la vispera, el 4, es Dodenherdenking, con dos minutos de silencio a las ocho de la tarde.

📋 Tres usos reales:
• Op 5 mei vieren we de bevrijding. — El 5 de mayo celebramos la liberación.
• In mei leggen alle vogels een ei. — En mayo todos los pájaros ponen un huevo.
• Begin mei zijn de tulpen uitgebloeid. — A principios de mayo los tulipanes ya se han pasado.

🌷 El refran que todo holandes sabe: In mei leggen alle vogels een ei — sirve de regla nemotecnica para el mes y de manera de decir que todo florece.

⚠️ Y no lo confundas con maart al oido: mei rima con el español mái, y maart tiene la a larga y la -rt final.

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: mei');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'junio', 'WORD', 'Meses: juni',
'juni = junio, y se dice yúni, con la j de yo-yo.

🔑 El dato que te salvara por telefono: Para no confundir juni con juli, los holandeses dicen juno y julei al deletrear fechas. Si te dictan una fecha y oyes juno, es junio.

📐 Como se usa: Op 21 juni begint de zomer, y es el dia mas largo del año — en Holanda no oscurece hasta casi las once.

📋 Tres usos reales:
• In juni begint de zomer. — En junio empieza el verano.
• Eind juni zijn de examens afgelopen. — A finales de junio se acaban los exámenes.
• Op de derde zondag van juni is het Vaderdag. — El tercer domingo de junio es el Día del Padre.

🔤 La escritura: Abreviado es jun., aunque en un calendario veras juni entero justo para no confundirlo con juli.

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: juni');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'julio', 'WORD', 'Meses: juli',
'juli = julio, y se dice yúli. Su gemelo de sonido es juni, y por eso al telefono se dice julei.

📐 Como se usa: In juli begint de zomervakantie, que en Holanda va por regiones (noord, midden, zuid) y no empieza el mismo dia en todo el pais.

🏖️ El mes de la bouwvak: Son las vacaciones colectivas de la construccion, cuando media Holanda coge la caravana y se va al sur.

📋 Tres usos reales:
• In juli gaan we op vakantie. — En julio nos vamos de vacaciones.
• Half juli is het hier het drukst. — A mediados de julio es cuando más gente hay.
• De vakantie begint eind juli. — Las vacaciones empiezan a finales de julio.

🔤 La escritura: Abreviado es jul., y la trampa sigue siendo la misma — jun. y jul. se parecen demasiado, asi que en fechas importantes escribe el mes entero.

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: juli');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'agosto', 'WORD', 'Meses: augustus',
'augustus = agosto. Es el mes con el nombre mas largo y el unico que acaba en -us, porque viene del emperador Augusto.

📐 Como se usa: In augustus is het hoogseizoen, la temporada alta, y a finales vuelve el colegio: eind augustus begint de school weer.

📋 Tres usos reales:
• In augustus is iedereen op vakantie. — En agosto todo el mundo está de vacaciones.
• Eind augustus begint het schooljaar. — A finales de agosto empieza el curso.
• Op 15 augustus zijn we terug. — El 15 de agosto estamos de vuelta.

🔤 La escritura: Abreviado es aug., y la g es la jota fuerte holandesa, la misma de goed y de dag.

⚠️ No le pongas la mayuscula que le pondrias en ingles (August): en neerlandes es augustus, siempre en minuscula, igual que los once restantes.

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: augustus');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'septiembre', 'WORD', 'Meses: september',
'september = septiembre. Fijate en que el neerlandes NO lleva la i del español: septembre en frances, september aqui.

📐 Como se usa: In september begint het nieuwe schooljaar y el 23 empieza de herfst, el otoño.

👑 Lo que cae en septiembre: Prinsjesdag, el tercer martes, cuando el Rey lee el discurso del trono en La Haya y se presenta el presupuesto. Es el arranque del año politico holandes.

📋 Tres usos reales:
• In september gaan de kinderen weer naar school. — En septiembre los niños vuelven al cole.
• Op de derde dinsdag van september is het Prinsjesdag. — El tercer martes de septiembre es el Prinsjesdag.
• Begin september is het nog vaak mooi weer. — A principios de septiembre todavía suele hacer bueno.

🔤 La escritura: Abreviado es sep. (tambien sept.), y el acento va en la segunda silaba: sep-TEM-ber.

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: september');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'octubre', 'WORD', 'Meses: oktober',
'oktober = octubre, con K. Es de los pocos sitios donde el neerlandes escribe k donde el español pone c.

📐 Como se usa: In oktober gaat de wintertijd in — el ultimo domingo de octubre el reloj se atrasa una hora y anochece a las cinco.

🍂 El mes de la herfstvakantie: Es la semana de vacaciones escolares de otoño, y el mes en que caen las hojas — de blaadjes vallen.

📋 Tres usos reales:
• In oktober wordt het vroeg donker. — En octubre oscurece pronto.
• Eind oktober gaat de klok een uur terug. — A finales de octubre el reloj se atrasa una hora.
• We gaan in de herfstvakantie weg. — Nos vamos en las vacaciones de otoño.

🔤 La escritura: Abreviado es okt., con k tambien.

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: oktober');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'noviembre', 'WORD', 'Meses: november',
'november = noviembre, otra vez sin la i del español, y con el acento en la segunda silaba: no-VEM-ber.

📐 Como se usa: In november is het grijs en nat — es el mes mas oscuro del calendario holandes, el de la sombersta maand.

🏮 Lo que cae en noviembre: Sint-Maarten el 11, cuando los niños salen con farolillos cantando puerta por puerta a cambio de caramelos, y a mediados llega Sinterklaas en barco desde España — de intocht van Sinterklaas.

📋 Tres usos reales:
• In november regent het bijna elke dag. — En noviembre llueve casi todos los días.
• Op 11 november is het Sint-Maarten. — El 11 de noviembre es San Martín.
• Half november komt Sinterklaas aan. — A mediados de noviembre llega Sinterklaas.

🔤 La escritura: Abreviado es nov.

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: november');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'diciembre', 'WORD', 'Meses: december',
'december = diciembre, y se dice deesémber, con la d inicial y no con la des- del español.

📐 Como se usa: December es el mes de las fiestas: pakjesavond el 5, Kerst el 25 y el 26, y Oud en Nieuw el 31.

🎁 Y las dos navidades holandesas, que conviene no mezclar: Sinterklaas (el 5, con regalos y poemas) es la fiesta de los niños, y Kerstmis (el 25 y el 26, que son eerste en tweede kerstdag) es la de la familia y la comida.

📋 Tres usos reales:
• Op 5 december vieren we Sinterklaas. — El 5 de diciembre celebramos Sinterklaas.
• Met Kerst eten we met de hele familie. — En Navidad comemos con toda la familia.
• Op 31 december vieren we Oud en Nieuw. — El 31 de diciembre celebramos Nochevieja.

🔤 La escritura: Abreviado es dec., y fijate en que con las fiestas se usa met y no in — met Kerst, met Oud en Nieuw, pero in december.

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: december');

-- =============================================================================
-- 3. Las diez frases de fecha y uso (PHRASE)
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿en qué mes es tu cumpleaños?', 'PHRASE', 'Meses: welke maand jarig',
'In welke maand ben je jarig? = ¿en qué mes es tu cumpleaños? Dos cosas que el español hace distinto: el mes va con in, y cumplir años es SER jarig, no tenerlo.

⚠️ jarig zijn, nunca «verjaardag hebben»: Ik ben jarig (es mi cumpleaños), Hij is morgen jarig (mañana es su cumpleaños), de jarige (el homenajeado). El sustantivo de verjaardag existe, pero se usa para la fiesta: Ik ga naar zijn verjaardag.

📐 Y welke concuerda con el sustantivo: Welke maand, porque de maand es palabra de, pero welk jaar porque het jaar es palabra het.

📋 El molde en sus variantes:
• In welke maand ben je jarig? — ¿En qué mes es tu cumpleaños?
• Wanneer ben je jarig? — ¿Cuándo es tu cumpleaños?
• Ik ben in oktober jarig. — Cumplo años en octubre.

🎂 Y lo que se dice ese dia: Gefeliciteerd! (¡felicidades!) o Van harte gefeliciteerd met je verjaardag! En Holanda ademas se felicita a la familia del que cumple, que descoloca la primera vez.

🏋️ Ejercicio: «¿cuándo cumples años?» → ___ ben je jarig? (Respuesta: Wanneer.)

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: welke maand jarig');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'mi cumpleaños es el 12 de octubre', 'PHRASE', 'Meses: 12 oktober jarig',
'Ik ben op 12 oktober jarig = mi cumpleaños es el 12 de octubre. La fecha concreta pide OP, mientras que el mes a secas pide in.

📐 La fecha se dice con numero CARDINAL y sin articulo: Op 12 oktober se lee op twaalf oktober, nunca «op de twaalfde oktober». El ordinal solo se usa en textos solemnes o al preguntar de hoeveelste.

📋 Las tres preposiciones del calendario, juntas:
• Op 12 oktober ben ik jarig. — El 12 de octubre es mi cumpleaños. (fecha o dia → op)
• In oktober ben ik jarig. — Cumplo años en octubre. (mes → in)
• Om acht uur eten we. — A las ocho comemos. (hora → om)

🔑 El truco: Cuanto mas corto es el tramo, mas cerrada es la preposicion — in para el mes o el año, op para el dia, om para la hora.

⚠️ Y el orden en la frase: Ik ben op 12 oktober jarig, con jarig al final, porque jarig es la parte que cierra el predicado. Tambien vale Op 12 oktober ben ik jarig, con inversion, si quieres poner el foco en la fecha.

🏋️ Ejercicio: «el 3 de mayo tengo cita» → ___ 3 mei heb ik een afspraak. (Respuesta: Op.)

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: 12 oktober jarig');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'nací en abril de 1985', 'PHRASE', 'Meses: in april geboren',
'Ik ben in april 1985 geboren = nací en abril de 1985. El neerlandes no tiene un verbo nacer: usa geboren zijn, que es un perfecto con zijn.

📐 Y el año NO lleva de: Se dice in april 1985, no «in april van 1985». El orden es mes + año, sin nada en medio.

🔢 Como se leen los años, que es lo que mas cuesta:
• 1985 — negentienvijfentachtig (diecinueve ochenta y cinco).
• 2008 — tweeduizend acht.
• 2026 — tweeduizend zesentwintig.

📐 Como se parte el año: Hasta 1999 va en dos mitades, como en ingles (negentien + vijfentachtig); a partir de 2000 se dice entero con tweeduizend.

📋 El molde con geboren:
• Ik ben in 1985 geboren. — Nací en 1985.
• Waar ben je geboren? — ¿Dónde naciste?
• Mijn dochter is in mei geboren. — Mi hija nació en mayo.

⚠️ Nunca con hebben: «ik heb geboren» no existe. Y si es un animal o el parto en si, el verbo es bevallen (dar a luz): Ze is bevallen van een zoon.

🏋️ Ejercicio: «nació en 2010» → Hij is in ___ geboren. (Respuesta: tweeduizend tien.)

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: in april geboren');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'nos vemos a principios de mayo', 'PHRASE', 'Meses: begin mei',
'We zien elkaar begin mei = nos vemos a principios de mayo. begin, half y eind van pegados al mes SIN articulo y SIN preposicion: begin mei, y no «in het begin van mei».

📐 Los tres tramos, que es lo que se usa para quedar:
• begin mei — a principios de mayo.
• half juni — a mediados de junio.
• eind augustus — a finales de agosto.

🔑 El truco: Si en español dirias a principios, a mediados o a finales de, en neerlandes quita la preposicion y el articulo y pega la palabra al mes. Es mas corto que en español, no mas largo.

📋 En frase entera:
• We zien elkaar begin mei. — Nos vemos a principios de mayo.
• Eind maart gaat de klok vooruit. — A finales de marzo se adelanta el reloj.
• Half juli ben ik met vakantie. — A mediados de julio estoy de vacaciones.

⚠️ Y elkaar es el pronombre reciproco, el nos el uno al otro: We zien elkaar (nos vemos), We kennen elkaar (nos conocemos), We helpen elkaar (nos ayudamos). No lo cambies por ons, que es el reflexivo.

🏋️ Ejercicio: «a finales de enero» → ___ januari. (Respuesta: eind.)

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: begin mei');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿a qué día estamos hoy?', 'PHRASE', 'Meses: de hoeveelste',
'De hoeveelste is het vandaag? = ¿a qué día estamos hoy? Es la pregunta de la FECHA, y es de las que se oyen a diario en la oficina.

📐 hoeveelste es el ordinal de hoeveel (cuanto): literalmente el cuantesimo. Y se contesta con el ordinal o con la fecha entera: De vijfde, o Het is 5 mei.

⚠️ No la confundas con la del dia de la semana, que es otra pregunta: Welke dag is het vandaag? — Het is maandag. Una pide el numero y otra el nombre del dia.

📋 Las tres preguntas del calendario:
• De hoeveelste is het vandaag? — ¿A qué día estamos? (la fecha)
• Welke dag is het vandaag? — ¿Qué día es hoy? (lunes, martes…)
• Hoe laat is het? — ¿Qué hora es?

🔢 Los ordinales para contestar: Son eerste, tweede, derde, vierde, vijfde… hasta twintigste. De 1 a 19 se forman con -de (vierde, tiende) menos eerste, derde y achtste; de 20 en adelante con -ste (twintigste, dertigste).

🏋️ Ejercicio: «¿a qué día estamos?» → De ___ is het vandaag? (Respuesta: hoeveelste.)

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: de hoeveelste');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'hoy es 3 de septiembre', 'PHRASE', 'Meses: vandaag 3 september',
'Vandaag is het 3 september = hoy es 3 de septiembre. Fijate en el het, que el español no dice: la fecha y el tiempo van siempre con het als sujeto postizo.

📐 El molde es Het is + fecha, y al abrir con Vandaag se invierte: Vandaag is het… Lo mismo pasa con el tiempo (Het regent), la hora (Het is acht uur) y las estaciones (Het is zomer).

📋 El het que el español se come:
• Vandaag is het 3 september. — Hoy es 3 de septiembre.
• Het is maandag. — Es lunes.
• Het is koud vandaag. — Hoy hace frío.

📐 Y como se escribe una fecha entera: 3 september 2026, en ese orden y sin comas. En formato corto, 03-09-2026 — dia primero, al reves que el ingles, igual que en español.

⚠️ Al leerla en voz alta: drie september, con cardinal. El de la fecha con articulo (de derde september) queda para discursos y actas.

🏋️ Ejercicio: «hoy es 1 de mayo» → Vandaag is ___ 1 mei. (Respuesta: het.)

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: vandaag 3 september');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'en verano hace calor aquí', 'PHRASE', 'Meses: in de zomer warm',
'In de zomer is het hier warm = en verano hace calor aquí. Aqui esta la asimetria que hay que fijar: las estaciones llevan articulo y los meses no.

📐 Donde esta la diferencia: Se dice in de zomer, in de winter, in de lente y in de herfst, con de; pero in mei y in december, sin nada. El mes funciona como nombre propio de tramo y la estacion como sustantivo comun.

📋 Las cuatro estaciones, con su articulo y su alternativa:
• de lente, o het voorjaar — la primavera.
• de zomer — el verano.
• de herfst, o het najaar — el otoño.
• de winter — el invierno.

🔑 El truco de voorjaar y najaar: Son el año temprano y el año tardio, y se usan mucho en contexto de trabajo y de plazos (in het voorjaar leveren we op — entregamos en primavera).

⚠️ Y el hace del tiempo no es un verbo hacer: es het is — Het is warm (hace calor), Het is koud (hace frío), Het regent (llueve). «Het maakt warm» no existe.

🏋️ Ejercicio: «en invierno oscurece pronto» → ___ ___ winter wordt het vroeg donker. (Respuesta: In de.)

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: in de zomer warm');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'las vacaciones empiezan a finales de julio', 'PHRASE', 'Meses: vakantie eind juli',
'De vakantie begint eind juli = las vacaciones empiezan a finales de julio. eind + mes, sin articulo y sin preposicion, igual que begin y half.

📐 de vakantie va en SINGULAR: El español dice las vacaciones en plural y el neerlandes lo dice en singular, como la fiesta o el viaje. Ik ga op vakantie (me voy de vacaciones), nunca «op vakanties».

📋 El vocabulario de las vacaciones, con su articulo:
• de zomervakantie — las vacaciones de verano.
• de herfstvakantie — las de otoño.
• de kerstvakantie — las de Navidad.
• de bouwvak — las vacaciones colectivas de la construccion, en julio o agosto.

📐 Y las preposiciones que pide vakantie: Son op vakantie gaan (irse de vacaciones), met vakantie zijn (estar de vacaciones) e in de vakantie (durante las vacaciones).

⚠️ En Holanda las vacaciones escolares van por regiones (noord, midden, zuid) para repartir el trafico, asi que eind juli vale para una zona y no para otra: pregunta siempre welke regio.

🏋️ Ejercicio: «me voy de vacaciones en agosto» → Ik ga in augustus ___ vakantie. (Respuesta: op.)

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: vakantie eind juli');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el mes que viene empiezo un curso', 'PHRASE', 'Meses: volgende maand cursus',
'Volgende maand begin ik een cursus = el mes que viene empiezo un curso. volgende maand va SIN preposicion y sin articulo: el tiempo relativo no lleva in.

📐 La familia entera va sin preposicion: Son vorige maand (el mes pasado), deze maand (este mes) y volgende maand (el mes que viene). Igual con week, jaar y weekend — vorige week, dit jaar, volgend weekend.

⚠️ Y ojo a la -e del adjetivo, que cambia con el articulo de la palabra: volgende maand y volgende week (son de), pero volgend jaar y volgend weekend (son het). Es la regla del adjetivo con het-woord indeterminado.

📋 Los tres tiempos relativos en fila:
• Vorige maand was ik ziek. — El mes pasado estuve enfermo.
• Deze maand heb ik het druk. — Este mes tengo mucho lío.
• Volgende maand begin ik een cursus. — El mes que viene empiezo un curso.

📐 Y fijate en la inversion: Al abrir con Volgende maand, el verbo se queda en segunda posicion y el sujeto pasa detras — begin ik, no «ik begin».

🏋️ Ejercicio: «el año que viene me mudo» → ___ jaar ga ik verhuizen. (Respuesta: Volgend.)

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: volgende maand cursus');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'en diciembre celebramos Sinterklaas', 'PHRASE', 'Meses: in december sinterklaas',
'In december vieren we Sinterklaas = en diciembre celebramos Sinterklaas. El mes con in, y la fiesta concreta con met: in december, pero met Kerst.

📐 Las tres preposiciones de las fiestas, que no se mezclan:
• in + mes: in december, in mei.
• op + fecha o dia: op 5 december, op zondag.
• met + fiesta: met Kerst, met Pasen, met Oud en Nieuw.

📋 El calendario festivo holandes, para situarte:
• Sinterklaas — el 5 de diciembre, pakjesavond, con regalos y poemas burlones.
• Kerst — el 25 y el 26, eerste en tweede kerstdag.
• Oud en Nieuw — Nochevieja, con oliebollen y fuegos.
• Koningsdag — el 27 de abril, todo el país de naranja.

📐 Stamtijden de vieren (debil):

| infinitief | imperfectum | voltooid deelwoord |
|---|---|---|
| vieren | vierde / vierden | gevierd (hebben) |

• preposicion — transitivo directo (we vieren Kerst), y con la persona con quien se celebra, met: Ik vier het met mijn familie.
• sustantivo derivado — het feest (la fiesta), de viering (la celebracion), de feestdag (el dia festivo).
• expresion hecha — Dat mag gevierd worden! (¡eso hay que celebrarlo!).

🏋️ Ejercicio: «en Navidad comemos juntos» → ___ Kerst eten we samen. (Respuesta: Met.)

📅 Los doce meses y las tres reglas que los rigen:

| mes | abrev. | se dice | lo que cae ahi |
|---|---|---|---|
| januari | jan. | yánuwari | Nieuwjaar, el 1 |
| februari | feb. | feebruwari | Carnaval y Valentijnsdag |
| maart | mrt. | maart | empieza la lente, el 21 |
| april | apr. | apríl | Koningsdag, el 27 |
| mei | mei | mei | Bevrijdingsdag, el 5 |
| juni | jun. | yúni | empieza el verano, el 21 |
| juli | jul. | yúli | las vacaciones escolares |
| augustus | aug. | aujústus | el final de las vacaciones |
| september | sep. | septémber | Prinsjesdag, el 3er martes |
| oktober | okt. | októober | vuelve el horario de invierno |
| november | nov. | novémber | Sint-Maarten, el 11 |
| december | dec. | deesémber | Sinterklaas el 5 y Kerst el 25 |

📌 Las tres reglas que no puedes fallar:
• MINUSCULA siempre: in januari, y nunca «in Januari». El neerlandes solo pone mayuscula al empezar la frase y en los nombres propios, y un mes no lo es. Es el calco del ingles el que te hara fallar, no el español.
• Mes, año o estacion piden IN; un dia o una fecha concreta piden OP; la hora pide OM. In mei, in 2026, in de zomer · op 5 mei, op maandag · om acht uur.
• La fecha va con numero CARDINAL y sin articulo: 5 mei se dice vijf mei, no «de vijfde mei». El ordinal solo asoma en textos solemnes (de vijfde mei 1945).

🔑 El truco del in / op / om: Cuanto mas CORTO es el tramo, mas cerrada es la preposicion — in para lo ancho (el año, la estacion, el mes), op para un dia suelto, om para el punto exacto de la hora.

🧊 Los tramos de mes, que van sin articulo: Se dice begin mei (a principios de mayo), half juni (a mediados de junio) y eind augustus (a finales de agosto). Es lo que oiras para quedar sin comprometerse con un dia.

📐 El vocabulario del calendario: Cada uno con su articulo — de maand (el mes), het jaar (el año), de week (la semana), de dag (el dia), de datum (la fecha), het seizoen (la estacion), de verjaardag (el cumpleaños), de feestdag (el festivo) y het schrikkeljaar (el año bisiesto).

🗓️ Y los dos que se preguntan a diario: De hoeveelste is het vandaag? (¿a que dia estamos?) y Wanneer ben je jarig? (¿cuando es tu cumpleaños?). Ojo a jarig zijn, que es SER y no tener: Ik ben jarig, nunca «ik heb verjaardag».

⚠️ Las estaciones si llevan articulo, al reves que los meses: in de zomer pero in juli. Son de lente o het voorjaar (la primavera), de zomer, de herfst o het najaar (el otoño) y de winter.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Meses: in december sinterklaas');

-- =============================================================================
-- 4. Traducciones
-- =============================================================================
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT we.id, 'nl_NL', v.nl, v.pron, v.notas
FROM (
    SELECT 'Meses: januari' AS k, 'januari' AS nl, 'yánuwari' AS pron, '• [can.] In januari is het koud. — En enero hace frío.
• [datum] Op 1 januari is het Nieuwjaar. — El 1 de enero es Año Nuevo.
• [begin] Begin januari ga ik weer aan het werk. — A principios de enero vuelvo al trabajo.
• [vraag] Ben je in januari jarig? — ¿Cumples años en enero?
• [uitdr.] de eerste maand van het jaar — el primer mes del año.' AS notas
    UNION ALL SELECT 'Meses: februari', 'februari', 'feebruwari', '• [can.] In februari is het carnaval. — En febrero es el carnaval.
• [datum] Op 14 februari is het Valentijnsdag. — El 14 de febrero es San Valentín.
• [uitdr.] een schrikkeljaar — un año bisiesto, con 29 februari.
• [vraag] Heeft februari dit jaar 29 dagen? — ¿Tiene febrero 29 días este año?
• [bijzin] Ik hoop dat het in februari niet vriest. — Espero que en febrero no hiele.'
    UNION ALL SELECT 'Meses: maart', 'maart', 'maart', '• [can.] In maart begint de lente. — En marzo empieza la primavera.
• [datum] Op 21 maart is het de eerste lentedag. — El 21 de marzo es el primer día de primavera.
• [eind] Eind maart gaat de klok vooruit. — A finales de marzo se adelanta el reloj.
• [uitdr.] Maart roert zijn staart. — En marzo el tiempo se vuelve loco.
• [vraag] Wanneer in maart kom je? — ¿Cuándo vienes en marzo?'
    UNION ALL SELECT 'Meses: april', 'april', 'apríl', '• [can.] In april is het weer wisselvallig. — En abril el tiempo es variable.
• [datum] Op 27 april is het Koningsdag. — El 27 de abril es el Día del Rey.
• [uitdr.] 1 april, kikker in je bil. — La cantinela del día de las bromas.
• [half] Half april gaan de terrassen open. — A mediados de abril abren las terrazas.
• [vraag] Ga je in april op vakantie? — ¿Te vas de vacaciones en abril?'
    UNION ALL SELECT 'Meses: mei', 'mei', 'mei', '• [can.] In mei is het weer lekker. — En mayo hace buen tiempo.
• [datum] Op 5 mei is het Bevrijdingsdag. — El 5 de mayo es el Día de la Liberación.
• [uitdr.] In mei leggen alle vogels een ei. — En mayo todos los pájaros ponen un huevo.
• [begin] Begin mei bloeien de tulpen niet meer. — A principios de mayo ya no florecen los tulipanes.
• [vraag] Ben jij in mei jarig? — ¿Cumples años en mayo?'
    UNION ALL SELECT 'Meses: juni', 'juni', 'yúni', '• [can.] In juni begint de zomer. — En junio empieza el verano.
• [datum] Op 21 juni is het de langste dag. — El 21 de junio es el día más largo.
• [uitdr.] juno zeggen aan de telefoon — decir juno por teléfono, para no confundirlo con juli.
• [eind] Eind juni zijn de examens klaar. — A finales de junio acaban los exámenes.
• [vraag] Heb je in juni tijd? — ¿Tienes tiempo en junio?'
    UNION ALL SELECT 'Meses: juli', 'juli', 'yúli', '• [can.] In juli gaan we op vakantie. — En julio nos vamos de vacaciones.
• [datum] Op 1 juli begint de zomervakantie. — El 1 de julio empiezan las vacaciones de verano.
• [uitdr.] julei zeggen aan de telefoon — decir julei por teléfono, para no confundirlo con juni.
• [half] Half juli is het hier het drukst. — A mediados de julio hay más gente que nunca.
• [vraag] Wanneer in juli ben je vrij? — ¿Cuándo estás libre en julio?'
    UNION ALL SELECT 'Meses: augustus', 'augustus', 'aujústus', '• [can.] In augustus is iedereen op vakantie. — En agosto todo el mundo está de vacaciones.
• [datum] Op 15 augustus komen we terug. — El 15 de agosto volvemos.
• [eind] Eind augustus begint het schooljaar. — A finales de agosto empieza el curso.
• [uitdr.] het hoogseizoen — la temporada alta.
• [vraag] Werk je in augustus door? — ¿Sigues trabajando en agosto?'
    UNION ALL SELECT 'Meses: september', 'september', 'septémber', '• [can.] In september begint het schooljaar. — En septiembre empieza el curso.
• [datum] Op de derde dinsdag van september is het Prinsjesdag. — El tercer martes de septiembre es el Prinsjesdag.
• [begin] Begin september is het nog mooi weer. — A principios de septiembre todavía hace bueno.
• [uitdr.] het najaar — el otoño, literalmente el año tardío.
• [vraag] Start de cursus in september? — ¿El curso empieza en septiembre?'
    UNION ALL SELECT 'Meses: oktober', 'oktober', 'októober', '• [can.] In oktober wordt het vroeg donker. — En octubre oscurece pronto.
• [datum] Op 31 oktober is het Halloween. — El 31 de octubre es Halloween.
• [eind] Eind oktober gaat de klok terug. — A finales de octubre se atrasa el reloj.
• [uitdr.] de herfstvakantie — las vacaciones de otoño.
• [vraag] Ben je in oktober thuis? — ¿Estás en casa en octubre?'
    UNION ALL SELECT 'Meses: november', 'november', 'novémber', '• [can.] In november is het grijs en nat. — En noviembre está gris y llueve.
• [datum] Op 11 november is het Sint-Maarten. — El 11 de noviembre es San Martín.
• [half] Half november komt Sinterklaas aan. — A mediados de noviembre llega Sinterklaas.
• [uitdr.] de donkerste maand — el mes más oscuro.
• [vraag] Heb je in november vakantie? — ¿Tienes vacaciones en noviembre?'
    UNION ALL SELECT 'Meses: december', 'december', 'deesémber', '• [can.] In december is het druk in de winkels. — En diciembre las tiendas están a tope.
• [datum] Op 5 december is het pakjesavond. — El 5 de diciembre es la noche de los regalos.
• [uitdr.] met Kerst — en Navidad, con met y no con in.
• [eind] Eind december vieren we Oud en Nieuw. — A finales de diciembre celebramos Nochevieja.
• [vraag] Wat doe je met Kerst? — ¿Qué haces en Navidad?'
    UNION ALL SELECT 'Meses: welke maand jarig', 'In welke maand ben je jarig?', 'in velke maant ben ye yárej', NULL
    UNION ALL SELECT 'Meses: 12 oktober jarig', 'Ik ben op 12 oktober jarig.', 'ik ben op tuaalf októober yárej', NULL
    UNION ALL SELECT 'Meses: in april geboren', 'Ik ben in april 1985 geboren.', 'ik ben in apríl neejentinvaifentájtej jebóoren', NULL
    UNION ALL SELECT 'Meses: begin mei', 'We zien elkaar begin mei.', 've zin elkáar bejin mei', NULL
    UNION ALL SELECT 'Meses: de hoeveelste', 'De hoeveelste is het vandaag?', 'de huvéelste is het fandaaj', NULL
    UNION ALL SELECT 'Meses: vandaag 3 september', 'Vandaag is het 3 september.', 'fandaaj is het dri septémber', NULL
    UNION ALL SELECT 'Meses: in de zomer warm', 'In de zomer is het hier warm.', 'in de zóomer is het hiir varm', NULL
    UNION ALL SELECT 'Meses: vakantie eind juli', 'De vakantie begint eind juli.', 'de fakánsi bejint eint yúli', NULL
    UNION ALL SELECT 'Meses: volgende maand cursus', 'Volgende maand begin ik een cursus.', 'fólgende maant bejin ik en kursus', NULL
    UNION ALL SELECT 'Meses: in december sinterklaas', 'In december vieren we Sinterklaas.', 'in deesémber firen ve sínterklaas', NULL
) v
JOIN words_es we ON we.notes = v.k;

-- =============================================================================
-- 5. Al grupo nuevo y a generic
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Meses: %' AND g.title = 'los meses - de maanden en de datum';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Meses: %' AND g.title = 'generic';

-- =============================================================================
-- 6. Las frases colgadas de su mes como EXAMPLE (§5.5)
-- =============================================================================
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
SELECT m.id, f.id, 'EXAMPLE'
FROM (
    SELECT 'Meses: oktober' AS mes, 'Meses: 12 oktober jarig' AS frase
    UNION ALL SELECT 'Meses: april', 'Meses: in april geboren'
    UNION ALL SELECT 'Meses: mei', 'Meses: begin mei'
    UNION ALL SELECT 'Meses: september', 'Meses: vandaag 3 september'
    UNION ALL SELECT 'Meses: juli', 'Meses: vakantie eind juli'
    UNION ALL SELECT 'Meses: december', 'Meses: in december sinterklaas'
) r
JOIN words_es m ON m.notes = r.mes
JOIN words_es f ON f.notes = r.frase;
