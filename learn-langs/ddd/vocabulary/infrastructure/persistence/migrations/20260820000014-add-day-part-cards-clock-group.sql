-- Learn Languages App - Grupo «la hora»: las cuatro franjas del día (5 tarjetas)
-- Migration: 20260820000014-add-day-part-cards-clock-group.sql
-- Description: el grupo 26 solo tocaba las franjas de pasada, en la 751 y en la linea ☀️ del
--   mapa compartido. Eduardo pide ejemplos propios con 's ochtends, 's morgens, 's middags y
--   's nachts, asi que entran cinco tarjetas nuevas —una por franja mas la variante
--   's morgens— y el grupo pasa de 12 a 17.
--   Ejes que enseñan: (a) el complemento de tiempo en 1a posicion obliga a INVERTIR
--   ('s Ochtends ONTBIJT IK); (b) la ortografia del 's, que va en minuscula y le pasa la
--   mayuscula a la palabra siguiente; (c) 's morgens = 's ochtends, pero morgen a secas es
--   MANANA, el dia siguiente; (d) los limites reales de los tramos (6-12 / 12-18 / 18-24 /
--   0-6), que no coinciden con los del espanol; (e) el error clasico de traducir «por la
--   noche» por 's nachts cuando casi siempre es 's avonds; y (f) la serie van- (vanochtend,
--   vanmiddag, vanavond, vannacht), con el doble sentido de vannacht.
--   El bloque compartido 🕰️ se copio de la tarjeta 740 para que las cinco salgan identicas
--   a las doce que ya estaban. Pronunciaciones del DutchToSpanishPhoneticService.
--   Sin parentesis en el texto espanol: se locuta (norma del 2026-08-20).
--   100% aditiva e IDEMPOTENTE (INSERT ... WHERE NOT EXISTS / OR IGNORE).
--   Generada por script y escrita fuera de migrations/, movida ya terminada.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 01) hora: franja - s ochtends (por la manana)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'por las mañanas desayuno a las siete', 'PHRASE', 'hora: franja - s ochtends (por la manana)', '''s ochtends = por las mañanas, lo HABITUAL (no una mañana concreta). Ese ''s es un resto del genitivo antiguo «des», y por eso lleva apóstrofo.
🕰️ El reloj neerlandes de un vistazo:
• La clave: el reloj cuelga de la MEDIA, y la media pertenece a la hora SIGUIENTE. half tien = 9:30.
• :01-:15 → minutos + over + hora. vijf over negen (9:05) · kwart over negen (9:15).
• :16-:29 → [30 menos el minuto] + voor half + hora siguiente. 9:20 → tien voor half tien.
• :30 → half + hora siguiente. half tien = 9:30.
• :31-:44 → [minuto menos 30] + over half + hora siguiente. 9:35 → vijf over half tien.
• :45 → kwart voor + hora siguiente. kwart voor tien = 9:45.
• :46-:59 → [60 menos el minuto] + voor + hora siguiente. 9:55 → vijf voor tien.
⚠️ La trampa: half tien NO es las diez y media. Si te citan om half tien y apareces a las 10:30, llegas una hora tarde.
⚠️ Las dos restas: del :16 al :29 restas a 30 (voor half) y del :46 al :59 restas a 60 (voor). Mezclarlas es el error tipico.
🔢 Version digital (trenes, horarios, citas oficiales): negen uur negentien, y en 24 h eenentwintig uur negentien. Se entiende siempre, pero al hablar suena a locutor.
🕘 Aproximar: een uur of tien (sobre las diez) · tegen tienen (hacia las diez) · rond tien uur · omstreeks tien uur (formal) · bijna tien uur (casi) · ruim na tienen (pasadas de largo).
☀️ Franja del dia: ''s ochtends (manana) · ''s middags (mediodia y primera tarde) · ''s avonds (noche) · ''s nachts (madrugada). negen uur ''s avonds = 21:00.
📌 Con preposicion, siempre OM: om negen uur, om kwart over negen, om half tien. Nunca «op negen uur» (op es para el dia: op maandag). Y para preguntar, hoe laat: Hoe laat is het?
🔟 Horas en -en (solo en aproximaciones y con over/voor sueltos): tegen tienen, rond enen, over negenen, tussen zevenen en achten.
📐 Estructura: al abrir la frase con el complemento de tiempo hay INVERSIÓN — ''s Ochtends + ontbijt (verbo, 2a posicion) + ik (sujeto). Si lo pones en medio no hay inversion: Ik ontbijt ''s ochtends om zeven uur.

⚠️ Ortografia: el ''s va en MINUSCULA y la mayuscula se la lleva la palabra siguiente — ''s Ochtends…, igual que en ''s-Hertogenbosch. Nunca «S ochtends» ni «''S Ochtends».

⚠️ Habitual o concreto, que no es lo mismo: ''s ochtends = por las mananas (siempre) · vanochtend = esta manana (hoy) · morgenochtend = manana por la manana · gisterochtend = ayer por la manana. Ver la tarjeta de vanochtend vs vanmorgen.

🏋️ Ejercicio: «por las mananas trabajo en casa» → ___ ___ werk ik thuis. (Respuesta: ''s Ochtends, con inversion.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'por las mañanas desayuno a las siete' AND notes = 'hora: franja - s ochtends (por la manana)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'por las mañanas desayuno a las siete' AND notes = 'hora: franja - s ochtends (por la manana)' LIMIT 1),
    'nl_NL', '''s Ochtends ontbijt ik om zeven uur.', '''s Ojtends ontbeit ik om sefen ur.',
    '• [inv.] ''s Ochtends ontbijt ik om zeven uur. — Por las mañanas desayuno a las siete.
• [can.] Ik werk ''s ochtends altijd thuis. — Por las mañanas trabajo siempre en casa.
• [vraag] Kun je ''s ochtends bellen? — ¿Puedes llamar por la mañana?
• [can.] De winkel is alleen ''s ochtends open. — La tienda solo abre por la mañana.
• [uitdr.] Ik ben geen ochtendmens. — No soy persona de mañanas.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'por las mañanas desayuno a las siete' AND notes = 'hora: franja - s ochtends (por la manana)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'por las mañanas desayuno a las siete' AND notes = 'hora: franja - s ochtends (por la manana)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 02) hora: franja - s morgens (variante de s ochtends)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'por las mañanas salgo a correr', 'PHRASE', 'hora: franja - s morgens (variante de s ochtends)', '''s morgens = exactamente lo mismo que ''s ochtends: son sinónimos. Hoy ''s ochtends es el más común; ''s morgens suena un punto más formal o de gente mayor.
🕰️ El reloj neerlandes de un vistazo:
• La clave: el reloj cuelga de la MEDIA, y la media pertenece a la hora SIGUIENTE. half tien = 9:30.
• :01-:15 → minutos + over + hora. vijf over negen (9:05) · kwart over negen (9:15).
• :16-:29 → [30 menos el minuto] + voor half + hora siguiente. 9:20 → tien voor half tien.
• :30 → half + hora siguiente. half tien = 9:30.
• :31-:44 → [minuto menos 30] + over half + hora siguiente. 9:35 → vijf over half tien.
• :45 → kwart voor + hora siguiente. kwart voor tien = 9:45.
• :46-:59 → [60 menos el minuto] + voor + hora siguiente. 9:55 → vijf voor tien.
⚠️ La trampa: half tien NO es las diez y media. Si te citan om half tien y apareces a las 10:30, llegas una hora tarde.
⚠️ Las dos restas: del :16 al :29 restas a 30 (voor half) y del :46 al :59 restas a 60 (voor). Mezclarlas es el error tipico.
🔢 Version digital (trenes, horarios, citas oficiales): negen uur negentien, y en 24 h eenentwintig uur negentien. Se entiende siempre, pero al hablar suena a locutor.
🕘 Aproximar: een uur of tien (sobre las diez) · tegen tienen (hacia las diez) · rond tien uur · omstreeks tien uur (formal) · bijna tien uur (casi) · ruim na tienen (pasadas de largo).
☀️ Franja del dia: ''s ochtends (manana) · ''s middags (mediodia y primera tarde) · ''s avonds (noche) · ''s nachts (madrugada). negen uur ''s avonds = 21:00.
📌 Con preposicion, siempre OM: om negen uur, om kwart over negen, om half tien. Nunca «op negen uur» (op es para el dia: op maandag). Y para preguntar, hoe laat: Hoe laat is het?
🔟 Horas en -en (solo en aproximaciones y con over/voor sueltos): tegen tienen, rond enen, over negenen, tussen zevenen en achten.
📐 Estructura: complemento de tiempo en 1a posicion → INVERSION: ''s Morgens + ga + ik + hardlopen (infinitivo al final, que gaan lo lleva pelado).

⚠️ La trampa gorda de esta palabra: morgen, sin ''s y sin -s, significa MANANA (el dia siguiente). ''s morgens = por las mananas. Y morgenochtend / morgenvroeg = manana por la manana. «Ik ga morgen hardlopen» y «Ik ga ''s morgens hardlopen» no dicen lo mismo.

⚠️ El mismo par se repite en el resto: vanochtend / vanmorgen (esta manana) son sinonimos igual que ''s ochtends / ''s morgens.

🏋️ Ejercicio: «manana por la manana tengo cita» → ___ heb ik een afspraak. (Respuesta: Morgenochtend. Si dices ''s morgens seria «por las mananas».)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'por las mañanas salgo a correr' AND notes = 'hora: franja - s morgens (variante de s ochtends)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'por las mañanas salgo a correr' AND notes = 'hora: franja - s morgens (variante de s ochtends)' LIMIT 1),
    'nl_NL', '''s Morgens ga ik hardlopen.', '''s Morjens ja ik ardlopen.',
    '• [inv.] ''s Morgens ga ik hardlopen. — Por las mañanas salgo a correr.
• [can.] Hij drinkt ''s morgens twee koffie. — Por las mañanas se toma dos cafés.
• [inv.] ''s Morgens vroeg is het rustig op straat. — Por la mañana temprano la calle está tranquila.
• [vraag] Werk jij ''s morgens of ''s middags? — ¿Trabajas por la mañana o por la tarde?
• [uitdr.] Morgenochtend heb ik een afspraak. — Mañana por la mañana tengo cita.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'por las mañanas salgo a correr' AND notes = 'hora: franja - s morgens (variante de s ochtends)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'por las mañanas salgo a correr' AND notes = 'hora: franja - s morgens (variante de s ochtends)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 03) hora: franja - s middags (mediodia y primera tarde)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'por las tardes trabajo en casa', 'PHRASE', 'hora: franja - s middags (mediodia y primera tarde)', '''s middags va de las 12 a las 18: cubre el mediodía Y la primera parte de la tarde. El español dice «por la tarde», pero el tramo neerlandés empieza antes.
🕰️ El reloj neerlandes de un vistazo:
• La clave: el reloj cuelga de la MEDIA, y la media pertenece a la hora SIGUIENTE. half tien = 9:30.
• :01-:15 → minutos + over + hora. vijf over negen (9:05) · kwart over negen (9:15).
• :16-:29 → [30 menos el minuto] + voor half + hora siguiente. 9:20 → tien voor half tien.
• :30 → half + hora siguiente. half tien = 9:30.
• :31-:44 → [minuto menos 30] + over half + hora siguiente. 9:35 → vijf over half tien.
• :45 → kwart voor + hora siguiente. kwart voor tien = 9:45.
• :46-:59 → [60 menos el minuto] + voor + hora siguiente. 9:55 → vijf voor tien.
⚠️ La trampa: half tien NO es las diez y media. Si te citan om half tien y apareces a las 10:30, llegas una hora tarde.
⚠️ Las dos restas: del :16 al :29 restas a 30 (voor half) y del :46 al :59 restas a 60 (voor). Mezclarlas es el error tipico.
🔢 Version digital (trenes, horarios, citas oficiales): negen uur negentien, y en 24 h eenentwintig uur negentien. Se entiende siempre, pero al hablar suena a locutor.
🕘 Aproximar: een uur of tien (sobre las diez) · tegen tienen (hacia las diez) · rond tien uur · omstreeks tien uur (formal) · bijna tien uur (casi) · ruim na tienen (pasadas de largo).
☀️ Franja del dia: ''s ochtends (manana) · ''s middags (mediodia y primera tarde) · ''s avonds (noche) · ''s nachts (madrugada). negen uur ''s avonds = 21:00.
📌 Con preposicion, siempre OM: om negen uur, om kwart over negen, om half tien. Nunca «op negen uur» (op es para el dia: op maandag). Y para preguntar, hoe laat: Hoe laat is het?
🔟 Horas en -en (solo en aproximaciones y con over/voor sueltos): tegen tienen, rond enen, over negenen, tussen zevenen en achten.
📐 Estructura: ''s Middags + werk (verbo) + ik + thuis. Otra vez inversion por abrir con el tiempo.

⚠️ de middag no es «medio dia» a secas: es el mediodia y la sobremesa. La comida fuerte del dia en Paises Bajos suele ser por la noche, asi que ''s middags lo normal es un boterham.

⚠️ Los limites reales de los cuatro tramos: ''s ochtends (6-12) · ''s middags (12-18) · ''s avonds (18-24) · ''s nachts (0-6). No coinciden con los del espanol, y por eso «por la tarde» se reparte entre middags y avonds.

🏋️ Ejercicio: «esta tarde tengo libre» → ___ heb ik vrij. (Respuesta: Vanmiddag. ''s middags seria «por las tardes».)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'por las tardes trabajo en casa' AND notes = 'hora: franja - s middags (mediodia y primera tarde)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'por las tardes trabajo en casa' AND notes = 'hora: franja - s middags (mediodia y primera tarde)' LIMIT 1),
    'nl_NL', '''s Middags werk ik thuis.', '''s Middajs uerk ik taus.',
    '• [inv.] ''s Middags werk ik thuis. — Por las tardes trabajo en casa.
• [can.] Ik eet ''s middags meestal een boterham. — Al mediodía suelo comer un bocadillo.
• [vraag] Kom je ''s middags langs? — ¿Te pasas por la tarde?
• [can.] De school is ''s middags om drie uur uit. — El colegio sale a las tres de la tarde.
• [uitdr.] Vanmiddag heb ik vrij. — Esta tarde tengo libre.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'por las tardes trabajo en casa' AND notes = 'hora: franja - s middags (mediodia y primera tarde)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'por las tardes trabajo en casa' AND notes = 'hora: franja - s middags (mediodia y primera tarde)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 04) hora: franja - s avonds (tarde-noche)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'por las noches veo la tele', 'PHRASE', 'hora: franja - s avonds (tarde-noche)', '''s avonds va de las 18 a las 24, y es lo que el español llama «por la noche» el noventa por ciento de las veces: cuando aún estás despierto.
🕰️ El reloj neerlandes de un vistazo:
• La clave: el reloj cuelga de la MEDIA, y la media pertenece a la hora SIGUIENTE. half tien = 9:30.
• :01-:15 → minutos + over + hora. vijf over negen (9:05) · kwart over negen (9:15).
• :16-:29 → [30 menos el minuto] + voor half + hora siguiente. 9:20 → tien voor half tien.
• :30 → half + hora siguiente. half tien = 9:30.
• :31-:44 → [minuto menos 30] + over half + hora siguiente. 9:35 → vijf over half tien.
• :45 → kwart voor + hora siguiente. kwart voor tien = 9:45.
• :46-:59 → [60 menos el minuto] + voor + hora siguiente. 9:55 → vijf voor tien.
⚠️ La trampa: half tien NO es las diez y media. Si te citan om half tien y apareces a las 10:30, llegas una hora tarde.
⚠️ Las dos restas: del :16 al :29 restas a 30 (voor half) y del :46 al :59 restas a 60 (voor). Mezclarlas es el error tipico.
🔢 Version digital (trenes, horarios, citas oficiales): negen uur negentien, y en 24 h eenentwintig uur negentien. Se entiende siempre, pero al hablar suena a locutor.
🕘 Aproximar: een uur of tien (sobre las diez) · tegen tienen (hacia las diez) · rond tien uur · omstreeks tien uur (formal) · bijna tien uur (casi) · ruim na tienen (pasadas de largo).
☀️ Franja del dia: ''s ochtends (manana) · ''s middags (mediodia y primera tarde) · ''s avonds (noche) · ''s nachts (madrugada). negen uur ''s avonds = 21:00.
📌 Con preposicion, siempre OM: om negen uur, om kwart over negen, om half tien. Nunca «op negen uur» (op es para el dia: op maandag). Y para preguntar, hoe laat: Hoe laat is het?
🔟 Horas en -en (solo en aproximaciones y con over/voor sueltos): tegen tienen, rond enen, over negenen, tussen zevenen en achten.
📐 Estructura: ''s Avonds + kijk + ik + tv. Y en medio de la frase, sin inversion: Ik kijk ''s avonds tv.

⚠️ EL error clasico del hispanohablante: traducir «por la noche» por ''s nachts. Si estas despierto —cenando, viendo la tele, saliendo— es ''s AVONDS. ''s nachts es cuando la gente duerme.

⚠️ La familia del avond: vanavond (esta noche) · gisteravond (anoche) · morgenavond (manana por la noche) · de avond (la tarde-noche) · goedenavond (el saludo a partir de las seis).

🏋️ Ejercicio: «por la noche leo un rato» → ___ lees ik even. (Respuesta: ''s Avonds, no ''s nachts: estas despierto.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'por las noches veo la tele' AND notes = 'hora: franja - s avonds (tarde-noche)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'por las noches veo la tele' AND notes = 'hora: franja - s avonds (tarde-noche)' LIMIT 1),
    'nl_NL', '''s Avonds kijk ik tv.', '''s Afonds keik ik tf.',
    '• [inv.] ''s Avonds kijk ik tv. — Por las noches veo la tele.
• [can.] Ik bel je ''s avonds wel. — Ya te llamo por la noche.
• [can.] De winkels zijn op donderdag ''s avonds open. — Los jueves las tiendas abren por la noche.
• [vraag] Eten jullie altijd om zes uur ''s avonds? — ¿Cenáis siempre a las seis de la tarde?
• [uitdr.] Vanavond blijf ik thuis. — Esta noche me quedo en casa.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'por las noches veo la tele' AND notes = 'hora: franja - s avonds (tarde-noche)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'por las noches veo la tele' AND notes = 'hora: franja - s avonds (tarde-noche)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 05) hora: franja - s nachts (madrugada)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'de madrugada duermo mal', 'PHRASE', 'hora: franja - s nachts (madrugada)', '''s nachts es la madrugada, de 0 a 6: la franja en que la gente duerme. En español se dice «de noche» o «de madrugada», pero no es el «por la noche» de después de cenar.
🕰️ El reloj neerlandes de un vistazo:
• La clave: el reloj cuelga de la MEDIA, y la media pertenece a la hora SIGUIENTE. half tien = 9:30.
• :01-:15 → minutos + over + hora. vijf over negen (9:05) · kwart over negen (9:15).
• :16-:29 → [30 menos el minuto] + voor half + hora siguiente. 9:20 → tien voor half tien.
• :30 → half + hora siguiente. half tien = 9:30.
• :31-:44 → [minuto menos 30] + over half + hora siguiente. 9:35 → vijf over half tien.
• :45 → kwart voor + hora siguiente. kwart voor tien = 9:45.
• :46-:59 → [60 menos el minuto] + voor + hora siguiente. 9:55 → vijf voor tien.
⚠️ La trampa: half tien NO es las diez y media. Si te citan om half tien y apareces a las 10:30, llegas una hora tarde.
⚠️ Las dos restas: del :16 al :29 restas a 30 (voor half) y del :46 al :59 restas a 60 (voor). Mezclarlas es el error tipico.
🔢 Version digital (trenes, horarios, citas oficiales): negen uur negentien, y en 24 h eenentwintig uur negentien. Se entiende siempre, pero al hablar suena a locutor.
🕘 Aproximar: een uur of tien (sobre las diez) · tegen tienen (hacia las diez) · rond tien uur · omstreeks tien uur (formal) · bijna tien uur (casi) · ruim na tienen (pasadas de largo).
☀️ Franja del dia: ''s ochtends (manana) · ''s middags (mediodia y primera tarde) · ''s avonds (noche) · ''s nachts (madrugada). negen uur ''s avonds = 21:00.
📌 Con preposicion, siempre OM: om negen uur, om kwart over negen, om half tien. Nunca «op negen uur» (op es para el dia: op maandag). Y para preguntar, hoe laat: Hoe laat is het?
🔟 Horas en -en (solo en aproximaciones y con over/voor sueltos): tegen tienen, rond enen, over negenen, tussen zevenen en achten.
📐 Estructura: ''s Nachts + slaap + ik + slecht. Inversion otra vez.

⚠️ El par que hay que tener claro: ''s avonds = despierto (18-24) · ''s nachts = durmiendo (0-6). «Hij werkt ''s nachts» = hace turno de noche; «Hij werkt ''s avonds» = trabaja por la tarde-noche. No son lo mismo.

⚠️ vannacht mira en las DOS direcciones y lo decide el contexto: Vannacht heb ik slecht geslapen (anoche dormi mal) frente a Vannacht gaat het vriezen (esta noche va a helar). Ese doble sentido no lo tienen vanavond ni vanochtend.

🏋️ Ejercicio: «trabaja de noche en el hospital» → Hij werkt ___ in het ziekenhuis. (Respuesta: ''s nachts.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'de madrugada duermo mal' AND notes = 'hora: franja - s nachts (madrugada)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'de madrugada duermo mal' AND notes = 'hora: franja - s nachts (madrugada)' LIMIT 1),
    'nl_NL', '''s Nachts slaap ik slecht.', '''s Najts slap ik slejt.',
    '• [inv.] ''s Nachts slaap ik slecht. — De madrugada duermo mal.
• [can.] Hij werkt ''s nachts in het ziekenhuis. — Trabaja de noche en el hospital.
• [inv.] ''s Nachts rijden er geen treinen. — De madrugada no circulan trenes.
• [vraag] Word je ''s nachts vaak wakker? — ¿Te despiertas a menudo de noche?
• [uitdr.] Vannacht heb ik niet geslapen. — Esta noche no he dormido.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'de madrugada duermo mal' AND notes = 'hora: franja - s nachts (madrugada)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'de madrugada duermo mal' AND notes = 'hora: franja - s nachts (madrugada)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
