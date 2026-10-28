-- Learn Languages App - Migration
-- Migration: 20260912000004-estaciones-grupo-meses
-- Description: Eduardo: "en el grupo de meses pon las estaciones".
--
--   La 20260912000002 (grupo 45, los meses) YA ESTA APLICADA — el runner la registro al arrancar
--   la app a las 13:23 del 2026-09-12 —, asi que las estaciones NO se fusionan en ella: van en
--   migracion propia (§5.1: una migracion registrada no se re-ejecuta nunca).
--
--   Las estaciones estaban solo de pasada: una linea de aviso en el bloque de los meses y la
--   tarjeta 1134 (In de zomer is het hier warm). Ninguna era examinable.
--
--   9 tarjetas nuevas al grupo 45:
--     - 4 WORD con su articulo (§3.1): de lente, de zomer, de herfst, de winter.
--     - 5 PHRASE: In de lente bloeit alles (la asimetria in DE estacion / in mes), Vorige zomer
--       was het heel warm (vorige sin preposicion + imperfecto del decorado + het del clima),
--       In de herfst regent het hier veel (los verbos del tiempo con het), In de winter wordt het
--       om vijf uur donker (worden + adjetivo donde el español tiene un verbo de cambio) y
--       Wat is jouw favoriete seizoen? (wat frente a welk).
--   Las cuatro frases de estacion cuelgan de su WORD con relacion EXAMPLE (§5.5).
--
--   Bloque compartido nuevo '🍂 Las cuatro estaciones y sus dos nombres' (§3.3): tabla con el
--   gemelo formal (het voorjaar / het najaar), la fecha de inicio y lo que trae cada una; las
--   cuatro cosas que retener (articulo si y mes no, el gemelo formal, el genero — todas DE pero
--   voorjaar y najaar HET porque llevan jaar dentro —, y que como adjetivo se pegan sin nada:
--   zomervakantie, winterjas); el truco de cuando usar voorjaar/najaar (oficina y plazos) frente
--   a lente/herfst (tiempo, campo, vacaciones); y el tiempo tipico de cada estacion.
--   Se inyecta en las 31 tarjetas del grupo (las 22 que ya estaban + las 9 nuevas).
--
--   Las 9 nuevas llevan ademas el bloque '📅 Los doce meses' byte a byte igual que las otras 22.

PRAGMA foreign_keys = ON;

-- =============================================================================
-- 1. Las 9 tarjetas nuevas (4 estaciones + 5 frases)
-- =============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la primavera', 'WORD', 'Seizoen: lente',
'de lente = la primavera. Con articulo de, y empieza el 21 de marzo: op 21 maart begint de lente.

📐 Su gemelo formal es het voorjaar, con het porque lleva jaar dentro. Significa lo mismo, pero se usa en el trabajo y en los plazos: in het voorjaar leveren we op (entregamos en primavera).

📋 Donde la oiras:
• In de lente bloeit alles. — En primavera florece todo.
• De lente begint op 21 maart. — La primavera empieza el 21 de marzo.
• We hebben echt lenteweer vandaag. — Hoy hace un tiempo de primavera de verdad.

🌷 Su vocabulario: de bloesem (la flor de los árboles), de tulpen (los tulipanes, que se ven de abril a mayo), het lenteweer (el tiempo primaveral) y de lentekriebels, que es literalmente el cosquilleo de primavera — las ganas de salir y de empezar cosas cuando sube la temperatura.

⚠️ Y la asimetria de siempre: la estacion lleva articulo y el mes no. In de lente pero in maart.

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Seizoen: lente');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el verano', 'WORD', 'Seizoen: zomer',
'de zomer = el verano. Con articulo de, y empieza el 21 de junio, que es ademas el dia mas largo: en Holanda no oscurece hasta casi las once.

📐 Esta es la unica de las cuatro que NO tiene gemelo formal: No existe «het zomerjaar». Lente y herfst si lo tienen (het voorjaar, het najaar).

📋 Donde lo oiras:
• In de zomer is het hier warm. — En verano hace calor aquí.
• Vorige zomer was het heel warm. — El verano pasado hizo mucho calor.
• We gaan in de zomer naar Spanje. — En verano nos vamos a España.

🏖️ Su vocabulario: de zomervakantie (las vacaciones de verano), de zomertijd (el horario de verano, que entra en marzo), het zomerweer, de zonnebrand (la crema solar) y een terrasje pakken, que es la expresion holandesa por excelencia — sentarse en una terraza en cuanto sale el sol.

⚠️ Ojo a la pareja con el mes: in de zomer lleva articulo, in juli no lleva nada.

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Seizoen: zomer');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el otoño', 'WORD', 'Seizoen: herfst',
'de herfst = el otoño. Con articulo de, y empieza el 23 de septiembre. Se pronuncia con la h aspirada y las dos consonantes finales bien marcadas: HERFST.

📐 Su gemelo formal es het najaar, el año tardio, con het por el jaar que lleva dentro. En una reunion oiras in het najaar; hablando del tiempo, in de herfst.

📋 Donde lo oiras:
• In de herfst regent het hier veel. — En otoño llueve mucho aquí.
• De herfstbladeren liggen op straat. — Las hojas de otoño están por la calle.
• In het najaar komt de nieuwe versie. — La nueva versión sale en otoño.

🍂 Su vocabulario: de herfstbladeren (las hojas), de storm (el temporal, que en Holanda tiene nombre propio y avisos), de herfstvakantie (la semana de vacaciones escolares) y het is guur, que es ese frio humedo y con viento que no tiene traduccion buena al español.

⚠️ Y la pronunciacion: herfst acumula cuatro consonantes al final (r-f-s-t) y no se puede simplificar. Es de las palabras que mas cuesta encajar.

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Seizoen: herfst');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el invierno', 'WORD', 'Seizoen: winter',
'de winter = el invierno. Con articulo de, y empieza el 21 de diciembre. La w suena entre v y u: VÍN-ter.

📐 Tampoco tiene gemelo formal: No existe «het winterjaar». Solo lente y herfst lo tienen.

📋 Donde lo oiras:
• In de winter wordt het om vijf uur donker. — En invierno oscurece a las cinco.
• Doe je winterjas aan, het vriest. — Ponte el abrigo, está helando.
• Vorige winter heeft het niet gesneeuwd. — El invierno pasado no nevó.

❄️ Su vocabulario: de winterjas (el abrigo), de vorst (la helada), het ijs (el hielo, y tambien el helado), sneeuwen (nevar), schaatsen (patinar sobre hielo) y de Elfstedentocht, la carrera de las Once Ciudades en patines por los canales de Frisia, que solo se puede celebrar cuando el hielo aguanta — la ultima fue en 1997.

⚠️ Y el verbo del tiempo va con het: het vriest (hiela), het sneeuwt (nieva), het dooit (deshiela). Nunca con sujeto personal.

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Seizoen: winter');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'en primavera florece todo', 'PHRASE', 'Seizoen: bloeit alles',
'In de lente bloeit alles = en primavera florece todo. La estacion va con IN + DE, al reves que el mes, que va con in a secas.

📐 Y la inversion de siempre: Al abrir con In de lente, el verbo se queda en segunda posicion y el sujeto pasa detras — bloeit alles, no «alles bloeit» en ese orden.

📋 La asimetria, en tres pares:
• In de lente… — En primavera… / In maart… — En marzo…
• In de zomer… — En verano… / In juli… — En julio…
• In de winter… — En invierno… / In december… — En diciembre…

🌷 bloeien es florecer, y da de bloem (la flor), de bloesem (la flor del árbol) y uitgebloeid (que ya se ha pasado). Es verbo debil: bloeide / gebloeid, con hebben.

⚠️ Y alles es singular aunque signifique todo: alles is klaar (todo está listo), no «alles zijn».

🏋️ Ejercicio: «en otoño llueve» → ___ ___ herfst regent het. (Respuesta: In de.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Seizoen: bloeit alles');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el verano pasado hizo mucho calor', 'PHRASE', 'Seizoen: vorige zomer warm',
'Vorige zomer was het heel warm = el verano pasado hizo mucho calor. Tres cosas del mazo en una frase: vorige sin preposicion, el imperfecto para el decorado del pasado, y el het postizo del tiempo atmosferico.

📐 vorige zomer va SIN in y sin articulo, como vorige week y vorig jaar. La preposicion solo aparece cuando la estacion no lleva vorige/deze/volgende: in de zomer.

📐 Y va en IMPERFECTO, no en perfecto: was het heel warm. El tiempo que hacia es decorado del pasado, y eso en neerlandes es imperfectum — como toda la familia de zijn y hebben.

📋 La serie completa, sin preposicion:
• vorige zomer — el verano pasado.
• deze zomer — este verano.
• volgende zomer — el verano que viene.
• vorig jaar — el año pasado. (vorig sin -e porque het jaar es het-woord)

⚠️ Y el hace del clima no es hacer: es het is o het was. Het was warm, nunca «het maakte warm».

🏋️ Ejercicio: «el invierno pasado hizo frío» → ___ winter was het koud. (Respuesta: Vorige.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Seizoen: vorige zomer warm');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'en otoño llueve mucho aquí', 'PHRASE', 'Seizoen: herfst regent',
'In de herfst regent het hier veel = en otoño llueve mucho aquí. Los verbos del tiempo llevan SIEMPRE het como sujeto, aunque el español no ponga ninguno.

📐 El orden dentro de la frase: In de herfst (tiempo, en primera posicion) + regent (verbo, segunda) + het (sujeto) + hier (lugar ligero) + veel (cantidad). Los adverbios cortos como hier se pegan detras del sujeto.

📋 Los verbos del tiempo, todos con het:
• het regent — llueve. · het waait — hace viento.
• het vriest — hiela. · het sneeuwt — nieva.
• het hagelt — graniza. · het dooit — deshiela.

🌧️ regenen es debil: regende / geregend, con hebben. Y su sustantivo es de regen, de donde salen de regenjas (el chubasquero), de regenbui (el chaparron) y het regent pijpenstelen, que es llover a cantaros — literalmente llover cañas de pipa.

⚠️ No digas «in de herfst het regent»: el verbo va segundo siempre que algo ocupe el primer lugar.

🏋️ Ejercicio: «en invierno nieva poco» → In de winter ___ het weinig. (Respuesta: sneeuwt.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Seizoen: herfst regent');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'en invierno oscurece a las cinco', 'PHRASE', 'Seizoen: winter donker',
'In de winter wordt het om vijf uur donker = en invierno oscurece a las cinco. El español tiene un verbo para eso (oscurecer) y el neerlandes lo dice con worden + adjetivo: se vuelve oscuro.

🔑 El truco de worden: Cada vez que el español tenga un verbo de CAMBIO (oscurecer, anochecer, envejecer, enfriarse), el neerlandes casi siempre lo parte en worden + adjetivo. Het wordt donker, hij wordt oud, het wordt koud.

📐 Y las tres preposiciones de esta sola frase: in de winter (estacion), om vijf uur (hora) y ninguna con el mes si lo hubiera. Es el resumen del grupo.

📋 worden + adjetivo, en la practica:
• Het wordt donker. — Está oscureciendo.
• Het wordt koud. — Está refrescando.
• Hij wordt zenuwachtig. — Se está poniendo nervioso.

⚠️ En Holanda esto es literal: en diciembre anochece hacia las 16:30 y amanece pasadas las 8:30. Por eso november y december son de donkere maanden.

🏋️ Ejercicio: «se está haciendo tarde» → Het ___ laat. (Respuesta: wordt.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Seizoen: winter donker');
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿cuál es tu estación favorita?', 'PHRASE', 'Seizoen: favoriete seizoen',
'Wat is jouw favoriete seizoen? = ¿cuál es tu estación favorita? Fijate en el Wat: el neerlandes pregunta con QUE donde el español pregunta con cual.

🔑 La regla del wat frente a welk: Wat pregunta por la cosa en abierto (Wat is jouw favoriete seizoen?), y welk o welke pregunta eligiendo dentro de un grupo cerrado (Welk seizoen vind je het mooist? — de los cuatro). El español usa cual para las dos.

📐 het seizoen es palabra HET, asi que el adjetivo posesivo y el determinante concuerdan: jouw favoriete seizoen, welk seizoen, dit seizoen.

📋 Como se contesta:
• Mijn favoriete seizoen is de zomer. — Mi estación favorita es el verano.
• Ik hou het meest van de herfst. — La que más me gusta es el otoño.
• De winter vind ik niks. — El invierno no me gusta nada.

🧮 Y het seizoen tiene segunda vida: Es la temporada en deporte y en television — het voetbalseizoen, het nieuwe seizoen van de serie, en het hoogseizoen (la temporada alta).

🏋️ Ejercicio: «¿qué estación prefieres?» → ___ seizoen vind je het mooist? (Respuesta: Welk.)

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
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE notes = 'Seizoen: favoriete seizoen');

-- =============================================================================
-- 2. Traducciones
-- =============================================================================
INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
SELECT we.id, 'nl_NL', v.nl, v.pron, v.notas
FROM (
    SELECT 'Seizoen: lente' AS k, 'de lente' AS nl, 'de lénte' AS pron, '• [can.] In de lente bloeit alles. — En primavera florece todo.
• [datum] De lente begint op 21 maart. — La primavera empieza el 21 de marzo.
• [uitdr.] de lentekriebels — el cosquilleo de primavera, las ganas de salir.
• [formeel] In het voorjaar leveren we op. — Entregamos en primavera.
• [vraag] Hou je van de lente? — ¿Te gusta la primavera?' AS notas
    UNION ALL SELECT 'Seizoen: zomer', 'de zomer', 'de zóomer', '• [can.] In de zomer is het hier warm. — En verano hace calor aquí.
• [imperf.] Vorige zomer was het heel warm. — El verano pasado hizo mucho calor.
• [perf.] Ik heb hem sinds de zomer niet gezien. — No lo veo desde el verano.
• [uitdr.] een terrasje pakken — sentarse en una terraza.
• [vraag] Wat doe je deze zomer? — ¿Qué haces este verano?'
    UNION ALL SELECT 'Seizoen: herfst', 'de herfst', 'de hérfst', '• [can.] In de herfst regent het hier veel. — En otoño llueve mucho aquí.
• [datum] De herfst begint op 23 september. — El otoño empieza el 23 de septiembre.
• [formeel] In het najaar komt de nieuwe versie. — La nueva versión sale en otoño.
• [uitdr.] het is guur — hace un frío húmedo y desapacible.
• [vraag] Heb je herfstvakantie? — ¿Tienes vacaciones de otoño?'
    UNION ALL SELECT 'Seizoen: winter', 'de winter', 'de vínter', '• [can.] In de winter wordt het om vijf uur donker. — En invierno oscurece a las cinco.
• [geb.] Doe je winterjas aan, het vriest. — Ponte el abrigo, está helando.
• [perf.] Vorige winter heeft het niet gesneeuwd. — El invierno pasado no nevó.
• [uitdr.] de Elfstedentocht — la carrera de las Once Ciudades sobre patines.
• [vraag] Ga je in de winter schaatsen? — ¿Vas a patinar en invierno?'
    UNION ALL SELECT 'Seizoen: bloeit alles', 'In de lente bloeit alles.', 'in de lénte bluit áles', NULL
    UNION ALL SELECT 'Seizoen: vorige zomer warm', 'Vorige zomer was het heel warm.', 'fórije zóomer vas het heel varm', NULL
    UNION ALL SELECT 'Seizoen: herfst regent', 'In de herfst regent het hier veel.', 'in de hérfst réejent het hiir feel', NULL
    UNION ALL SELECT 'Seizoen: winter donker', 'In de winter wordt het om vijf uur donker.', 'in de vínter vort het om faif uur dónker', NULL
    UNION ALL SELECT 'Seizoen: favoriete seizoen', 'Wat is jouw favoriete seizoen?', 'vat is yau favoríite saizún', NULL
) v
JOIN words_es we ON we.notes = v.k;

-- =============================================================================
-- 3. Al grupo de los meses y a generic
-- =============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Seizoen: %' AND g.title = 'los meses - de maanden en de datum';

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, g.id FROM words_es we, word_groups g
WHERE we.notes LIKE 'Seizoen: %' AND g.title = 'generic';

-- =============================================================================
-- 4. Cada frase colgada de su estacion (EXAMPLE)
-- =============================================================================
INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
SELECT m.id, f.id, 'EXAMPLE'
FROM (
    SELECT 'Seizoen: lente' AS est, 'Seizoen: bloeit alles' AS frase
    UNION ALL SELECT 'Seizoen: zomer', 'Seizoen: vorige zomer warm'
    UNION ALL SELECT 'Seizoen: herfst', 'Seizoen: herfst regent'
    UNION ALL SELECT 'Seizoen: winter', 'Seizoen: winter donker'
) r
JOIN words_es m ON m.notes = r.est
JOIN words_es f ON f.notes = r.frase;

-- =============================================================================
-- 5. El bloque de las estaciones en TODAS las del grupo (§3.3)
--    Guard doble: idempotente por la marca y protegido del NULL || texto (§5.4)
-- =============================================================================
UPDATE words_es
SET rules_help = rules_help || '

🍂 Las cuatro estaciones y sus dos nombres:

| estacion | el otro nombre | empieza | lo que trae |
|---|---|---|---|
| **de lente** | het voorjaar | 21 maart | de bloesem, de lentekriebels |
| **de zomer** | — | 21 juni | de zomervakantie, de zomertijd |
| **de herfst** | het najaar | 23 september | de storm, de herfstvakantie |
| **de winter** | — | 21 december | de vorst, de winterjas |

📌 Lo que hay que retener:
• Las estaciones LLEVAN articulo y los meses no: in de zomer pero in juli. Es la asimetria que mas se falla.
• lente y herfst tienen un gemelo formal: het voorjaar y het najaar, literalmente el año temprano y el año tardio. Son los que se usan en el trabajo y en los plazos.
• El genero: de lente, de zomer, de herfst y de winter son todas DE, pero het voorjaar y het najaar son HET, porque llevan jaar dentro (het jaar).
• Como adjetivo se pegan al sustantivo sin nada en medio: de zomervakantie, de winterjas, de herfstbladeren, het lenteweer.

🔑 El truco de voorjaar y najaar: Si la frase es de oficina, de plazos o de entregas, van het voorjaar y het najaar (in het voorjaar leveren we op). Si hablas del tiempo, del campo o de las vacaciones, van de lente y de herfst.

🌦️ Y el tiempo de cada una, que es de lo que se habla a diario: In de lente is het wisselvallig (variable) · In de zomer is het warm en licht tot elf uur · In de herfst waait het en regent het · In de winter vriest het en wordt het om vijf uur donker.',
    updated_at = datetime('now')
WHERE id IN (SELECT wg.word_es_id FROM word_es_groups wg
             JOIN word_groups g ON g.id = wg.group_id
             WHERE g.title = 'los meses - de maanden en de datum')
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%Las cuatro estaciones y sus dos nombres%';
