-- Learn Languages App - Grupo "om ... te + infinitivo - om te, alleen te of kaal"
-- Migration: 20260820000007-create-om-te-infinitive-group.sql
-- Description: las TRES formas de enganchar un infinitivo en neerlandes, que es lo que se
--   mezcla: (1) infinitivo DESNUDO tras modales, gaan/komen/blijven, laten/doen, verbos de
--   percepcion y helpen/leren; (2) solo TE tras proberen, beginnen, vergeten, weigeren,
--   besluiten, hopen, durven, hoeven y zitten/staan/liggen/lopen te; (3) OM ... TE, que es
--   obligatorio con finalidad («para»), tras sustantivo (tijd/zin/kans/reden), tras te +
--   adjetivo o adjetivo + genoeg, y en «Het is + adjetivo + om te».
--   Lo pidio Eduardo a partir de la tarjeta 718 del dialogo del pasaporte: «Ik kom een nieuw
--   paspoort aanvragen» va con infinitivo PELADO, y meterle om te ahi es el error tipico,
--   porque komen/gaan/blijven no lo admiten. Con destino y finalidad marcada, en cambio, si
--   vuelve el om: «Ik ga naar de ambassade om een paspoort aan te vragen».
--   Tambien cubre la colocacion de te DENTRO del verbo separable (om je op te halen) y el
--   orden om + resto + te + infinitivo al final.
--   Se evitan duplicados: ya existian 684 (om brood te kopen), 589 (Om mee te nemen), 679
--   (Ik probeer gezond te eten) y el grupo 22 entero de hoeven te; se citan en la ayuda en
--   vez de repetirlas.
--   15 tarjetas. Mapa compartido inyectado con REPLACE sobre @@OMTE@@.
--   100% aditiva e IDEMPOTENTE. Escrita fuera de migrations/ y movida ya terminada.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'om te + infinitivo - om te, alleen te of kaal',
    'Las tres maneras de enganchar un infinitivo y cuando toca cada una: infinitivo DESNUDO (modales, gaan/komen/blijven, laten, zien/horen, helpen), solo TE (proberen, beginnen, vergeten, weigeren, hoeven, zitten/staan te) y OM ... TE (finalidad, tras sustantivo como tijd/zin/kans, tras te + adjetivo o adjetivo + genoeg, y en Het is + adjetivo). Incluye el orden om + resto + te + infinitivo al final, la colocacion de te DENTRO del separable (om je op te halen) y el error de meter om te donde el verbo pide infinitivo pelado (Ik kom je helpen)',
    'migracion'
);

-- ==============================================================================
-- 01) om ... te de finalidad
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'llamo para pedir cita', 'PHRASE', 'om te: finalidad (para)', 'La finalidad va con OM ... TE: si en espanol cabe «para», en neerlandes hace falta el om. Ik bel om een afspraak te maken.
@@OMTE@@
📐 Estructura: sujeto + verbo + om + resto (een afspraak) + te + infinitivo (maken) AL FINAL.

⚠️ Aqui el om NO se puede quitar: «Ik bel een afspraak te maken» no existe. La prueba del algodon es traducir con «para»: si encaja, va om.

🧭 Cuando usarlo: explicar el motivo de una llamada, una visita o un viaje. Ej.: → Ik bel om een afspraak te maken bij de tandarts.

🏋️ Ejercicio: «voy al centro para comprar un regalo» → Ik ga naar de stad ___ een cadeau ___ kopen. (Respuesta: om ... te.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'llamo para pedir cita' AND notes = 'om te: finalidad (para)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'llamo para pedir cita' AND notes = 'om te: finalidad (para)' LIMIT 1),
    'nl_NL', 'Ik bel om een afspraak te maken.', 'Ik bel om en afsprak te maken.',
    '• [can.] Ik bel om een afspraak te maken. — Llamo para pedir cita.
• [can.] Ik schrijf je om het uit te leggen. — Te escribo para explicártelo.
• [vraag] Bel je om te vragen hoe laat het begint? — ¿Llamas para preguntar a qué hora empieza?
• [inv.] Om geld te sparen fietst hij naar zijn werk. — Para ahorrar dinero va al trabajo en bici.
• [perf.] Ik heb gebeld om het door te geven. — He llamado para comunicarlo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'llamo para pedir cita' AND notes = 'om te: finalidad (para)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'llamo para pedir cita' AND notes = 'om te: finalidad (para)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 02) te DENTRO del verbo separable
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'he venido a recogerte', 'PHRASE', 'om te: te dentro del separable (op te halen)', 'Con un verbo SEPARABLE, el te se mete DENTRO y quedan tres palabras: ophalen → op TE halen. Ik ben gekomen om je op te halen.
@@OMTE@@
📐 Estructura: om + objeto (je) + particula (op) + te + verbo (halen). Nunca «om je te ophalen».

⚠️ La lista es larga y siempre igual: aanvragen → aan te vragen · meenemen → mee te nemen · opstaan → op te staan · uitleggen → uit te leggen · doorgeven → door te geven · afspreken → af te spreken.

⚠️ Ojo al perfecto de komen: va con ZIJN (Ik BEN gekomen), porque es movimiento.

🏋️ Ejercicio: «vengo para traer el paquete» → Ik kom om het pakket ___ ___ nemen. (Respuesta: mee te. El te va dentro.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'he venido a recogerte' AND notes = 'om te: te dentro del separable (op te halen)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'he venido a recogerte' AND notes = 'om te: te dentro del separable (op te halen)' LIMIT 1),
    'nl_NL', 'Ik ben gekomen om je op te halen.', 'Ik ben jekomen om ye op te alen.',
    '• [perf.] Ik ben gekomen om je op te halen. — He venido a recogerte.
• [can.] Ik ga naar de ambassade om een paspoort aan te vragen. — Voy a la embajada a solicitar un pasaporte.
• [can.] Hij belt om het adres door te geven. — Llama para dar la dirección.
• [vraag] Heb je tijd om het even uit te leggen? — ¿Tienes un momento para explicarlo?
• [geb.] Vergeet niet om je jas mee te nemen. — No te olvides de llevarte el abrigo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'he venido a recogerte' AND notes = 'om te: te dentro del separable (op te halen)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'he venido a recogerte' AND notes = 'om te: te dentro del separable (op te halen)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 03) komen + infinitivo PELADO (el caso del dialogo del pasaporte)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'vengo a ayudarte', 'PHRASE', 'infinitivo pelado: komen (ni om ni te)', 'Con KOMEN el infinitivo va PELADO: ni om ni te. Ik kom je helpen. El espanol mete un «a» (vengo A ayudarte) que en neerlandes no se traduce por nada.
@@OMTE@@
📐 Estructura: sujeto + kom (2a posicion) + objeto (je) + infinitivo (helpen) al final. Sin te.

⚠️ Este es EL error: «Ik kom om je te helpen» suena a finalidad subrayada y no es lo que se dice. Lo mismo en la tarjeta del consulado: Ik kom een nieuw paspoort aanvragen, no «om ... aan te vragen».

⚠️ Matiz que salva la regla: si el movimiento lleva DESTINO explicito y quieres marcar el para que, el om vuelve — Ik ga naar de ambassade om een paspoort aan te vragen. Con destino, om; sin destino, infinitivo pelado.

🏋️ Ejercicio: «vengo a cenar» → Ik kom ___. (Respuesta: eten. Pelado, sin te.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'vengo a ayudarte' AND notes = 'infinitivo pelado: komen (ni om ni te)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'vengo a ayudarte' AND notes = 'infinitivo pelado: komen (ni om ni te)' LIMIT 1),
    'nl_NL', 'Ik kom je helpen.', 'Ik kom ye elpen.',
    '• [can.] Ik kom je helpen. — Vengo a ayudarte.
• [can.] Ik kom een nieuw paspoort aanvragen. — Vengo a solicitar un pasaporte nuevo.
• [vraag] Kom je vanavond eten? — ¿Vienes a cenar esta noche?
• [can.] Ze komt de sleutel brengen. — Viene a traer la llave.
• [inv.] Morgen komt hij de wasmachine repareren. — Mañana viene a arreglar la lavadora.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'vengo a ayudarte' AND notes = 'infinitivo pelado: komen (ni om ni te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'vengo a ayudarte' AND notes = 'infinitivo pelado: komen (ni om ni te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 04) gaan + infinitivo pelado
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'voy a nadar', 'PHRASE', 'infinitivo pelado: gaan (ni om ni te)', 'GAAN + infinitivo pelado = ir a hacer algo, y tambien el futuro proximo. Ik ga zwemmen. Ni om ni te.
@@OMTE@@
📐 Estructura: sujeto + ga (2a posicion) + resto + infinitivo al final.

⚠️ gaan + infinitivo hace dos cosas a la vez: «voy a nadar» (movimiento) y «voy a hacerlo» (futuro cercano: Ik ga het morgen doen). El contexto decide.

⚠️ Si aparece el DESTINO, la finalidad ya pide om ... te: Ik ga naar het zwembad om te zwemmen (voy a la piscina a nadar). Sin destino, pelado.

🏋️ Ejercicio: «voy a dormir» → Ik ga ___. (Respuesta: slapen. Sin te.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'voy a nadar' AND notes = 'infinitivo pelado: gaan (ni om ni te)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a nadar' AND notes = 'infinitivo pelado: gaan (ni om ni te)' LIMIT 1),
    'nl_NL', 'Ik ga zwemmen.', 'Ik ja suemmen.',
    '• [can.] Ik ga zwemmen. — Voy a nadar.
• [can.] Ik ga het morgen doen. — Lo voy a hacer mañana.
• [vraag] Ga je mee winkelen? — ¿Te vienes de compras?
• [can.] We gaan zo eten. — Vamos a comer enseguida.
• [can.] Ik ga naar het zwembad om te zwemmen. — Voy a la piscina a nadar.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a nadar' AND notes = 'infinitivo pelado: gaan (ni om ni te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a nadar' AND notes = 'infinitivo pelado: gaan (ni om ni te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 05) blijven + infinitivo pelado
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿te quedas a cenar?', 'PHRASE', 'infinitivo pelado: blijven (ni om ni te)', 'BLIJVEN + infinitivo pelado = quedarse a hacer algo, o seguir haciendolo. Blijf je eten? Ni om ni te.
@@OMTE@@
📐 Pregunta si/no: verbo en 1a posicion + sujeto + infinitivo al final.

⚠️ blijven tiene dos lecturas: quedarse A (Blijf je eten? = ¿te quedas a cenar?) y seguir (Hij blijft praten = no para de hablar). Las dos con infinitivo pelado.

⚠️ Perfecto de blijven: con ZIJN y doble infinitivo — Ik ben blijven eten (me quede a cenar), no «gebleven te eten».

🏋️ Ejercicio: «¿te quedas a dormir?» → Blijf je ___? (Respuesta: slapen.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿te quedas a cenar?' AND notes = 'infinitivo pelado: blijven (ni om ni te)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = '¿te quedas a cenar?' AND notes = 'infinitivo pelado: blijven (ni om ni te)' LIMIT 1),
    'nl_NL', 'Blijf je eten?', 'Bleif ye eten?',
    '• [vraag] Blijf je eten? — ¿Te quedas a cenar?
• [can.] Hij blijft maar praten. — No para de hablar.
• [perf.] Ik ben blijven slapen. — Me quedé a dormir.
• [geb.] Blijf rustig zitten. — Quédate sentado tranquilo.
• [can.] De winkel blijft open tot zes uur. — La tienda sigue abierta hasta las seis.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿te quedas a cenar?' AND notes = 'infinitivo pelado: blijven (ni om ni te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿te quedas a cenar?' AND notes = 'infinitivo pelado: blijven (ni om ni te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 06) beginnen + te (sin om)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'empieza a llover', 'PHRASE', 'solo te: beginnen te (sin om)', 'BEGINNEN pide TE pelado, sin om: Het begint te regenen. El infinitivo es su complemento, no una finalidad.
@@OMTE@@
📐 Estructura: sujeto + begint (2a posicion) + te + infinitivo al final.

⚠️ En este grupo estan los verbos que llevan te SIN om: proberen (Ik probeer gezond te eten), beginnen, vergeten, weigeren, besluiten, hopen, durven, beloven, hoeven. Meterles om no es imposible al hablar, pero no hace falta y suena recargado.

⚠️ beginnen tambien va con met + sustantivo: beginnen MET het werk (empezar con el trabajo) frente a beginnen TE werken (empezar a trabajar).

🏋️ Ejercicio: «empieza a hablar» → Hij begint ___ praten. (Respuesta: te, sin om.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'empieza a llover' AND notes = 'solo te: beginnen te (sin om)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'empieza a llover' AND notes = 'solo te: beginnen te (sin om)' LIMIT 1),
    'nl_NL', 'Het begint te regenen.', 'Et bejint te rejenen.',
    '• [can.] Het begint te regenen. — Empieza a llover.
• [can.] Ze begon te lachen. — Se echó a reír.
• [perf.] Hij is begonnen te werken. — Ha empezado a trabajar.
• [can.] We beginnen met de eerste oefening. — Empezamos con el primer ejercicio.
• [vraag] Wanneer begin je te studeren? — ¿Cuándo empiezas a estudiar?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'empieza a llover' AND notes = 'solo te: beginnen te (sin om)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'empieza a llover' AND notes = 'solo te: beginnen te (sin om)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 07) vergeten + te
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no te olvides de llamar', 'PHRASE', 'solo te: vergeten te (sin om)', 'VERGETEN pide TE: Vergeet niet te bellen. El espanol mete «de» (olvidarse DE llamar) que aqui no se traduce.
@@OMTE@@
📐 Imperativo: verbo en 1a posicion + niet + te + infinitivo al final.

⚠️ Con objeto en medio, el te sigue pegado al infinitivo: Vergeet niet je paspoort mee te nemen (no olvides llevarte el pasaporte) — separable, te dentro.

⚠️ vergeten es de los que cambian de auxiliar segun el sentido: Ik ben het vergeten (se me ha olvidado, cambio de estado) frente a Ik heb vergeten te bellen (olvide llamar, accion).

🏋️ Ejercicio: «no te olvides de cerrar la puerta» → Vergeet niet de deur ___ ___ doen. (Respuesta: dicht te. Separable con te dentro.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no te olvides de llamar' AND notes = 'solo te: vergeten te (sin om)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'no te olvides de llamar' AND notes = 'solo te: vergeten te (sin om)' LIMIT 1),
    'nl_NL', 'Vergeet niet te bellen.', 'Ferjet nit te bellen.',
    '• [geb.] Vergeet niet te bellen. — No te olvides de llamar.
• [geb.] Vergeet niet je paspoort mee te nemen. — No olvides llevarte el pasaporte.
• [perf.] Ik heb vergeten het door te geven. — Se me olvidó comunicarlo.
• [perf.] Ik ben zijn naam vergeten. — Se me ha olvidado su nombre.
• [vraag] Ben je niets vergeten? — ¿No te olvidas de nada?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no te olvides de llamar' AND notes = 'solo te: vergeten te (sin om)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no te olvides de llamar' AND notes = 'solo te: vergeten te (sin om)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 08) weigeren + te
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'se niega a pagar (él)', 'PHRASE', 'solo te: weigeren te (sin om)', 'WEIGEREN pide TE: Hij weigert te betalen. En espanol es «negarse A», con preposicion; en neerlandes basta el te.
@@OMTE@@
📐 Estructura: sujeto + weigert (2a posicion) + te + infinitivo al final.

⚠️ Familia de este bloque, todos con te y sin om: weigeren (negarse), besluiten (decidir), beloven (prometer), hopen (esperar), durven (atreverse), proberen (intentar). Ik hoop je snel te zien · Hij belooft te komen.

⚠️ No lo confundas con ontkennen (negar un hecho): Hij ontkent dat hij er was (niega que estuviera alli). weigeren es negarse a HACER algo.

🏋️ Ejercicio: «prometo llamarte» → Ik beloof je ___ bellen. (Respuesta: te.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'se niega a pagar (él)' AND notes = 'solo te: weigeren te (sin om)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'se niega a pagar (él)' AND notes = 'solo te: weigeren te (sin om)' LIMIT 1),
    'nl_NL', 'Hij weigert te betalen.', 'Ei ueijert te betalen.',
    '• [can.] Hij weigert te betalen. — Se niega a pagar.
• [can.] Ik hoop je snel te zien. — Espero verte pronto.
• [can.] Hij belooft op tijd te komen. — Promete venir a tiempo.
• [perf.] We hebben besloten te verhuizen. — Hemos decidido mudarnos.
• [vraag] Durf je het te vragen? — ¿Te atreves a preguntarlo?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se niega a pagar (él)' AND notes = 'solo te: weigeren te (sin om)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se niega a pagar (él)' AND notes = 'solo te: weigeren te (sin om)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 09) om te tras SUSTANTIVO (tijd, zin, kans, reden)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no tengo tiempo para cocinar', 'PHRASE', 'om te: tras sustantivo (tijd om te)', 'Detras de un SUSTANTIVO el om es obligatorio: tijd, zin, kans, reden, moeite, plan, manier. Ik heb geen tijd om te koken.
@@OMTE@@
📐 Estructura: sujeto + heb + geen tijd (sustantivo) + om + te + infinitivo.

⚠️ «Ik heb geen tijd te koken» esta MAL: si delante hay un sustantivo, hace falta el om. Es el error contrario al de meter om donde no toca.

⚠️ La lista corta que cubre casi todo: geen tijd om te (no tener tiempo de) · zin om te (ganas de) · een kans om te (una oportunidad de) · een reden om te (un motivo para) · geen moeite om te (ningun esfuerzo).

⚠️ Ojo con zin: zin OM TE + infinitivo (Ik heb zin om uit te gaan) pero zin IN + sustantivo (Ik heb zin in koffie).

🏋️ Ejercicio: «tengo ganas de salir» → Ik heb zin ___ uit ___ gaan. (Respuesta: om ... te.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no tengo tiempo para cocinar' AND notes = 'om te: tras sustantivo (tijd om te)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'no tengo tiempo para cocinar' AND notes = 'om te: tras sustantivo (tijd om te)' LIMIT 1),
    'nl_NL', 'Ik heb geen tijd om te koken.', 'Ik eb jen teid om te koken.',
    '• [can.] Ik heb geen tijd om te koken. — No tengo tiempo para cocinar.
• [can.] Ik heb zin om uit te gaan. — Tengo ganas de salir.
• [can.] Dit is een goede kans om Nederlands te oefenen. — Es una buena oportunidad para practicar neerlandés.
• [vraag] Heb je tijd om even te bellen? — ¿Tienes tiempo para llamar un momento?
• [can.] Er is geen reden om bang te zijn. — No hay motivo para tener miedo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no tengo tiempo para cocinar' AND notes = 'om te: tras sustantivo (tijd om te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no tengo tiempo para cocinar' AND notes = 'om te: tras sustantivo (tijd om te)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 10) om te tras te + adjetivo (demasiado ... para)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'estoy demasiado cansado para cocinar', 'PHRASE', 'om te: te + adjetivo + om te', 'TE + adjetivo = demasiado..., y lo que sigue pide OM TE: Ik ben te moe om te koken.
@@OMTE@@
📐 Estructura: sujeto + ben + te + adjetivo (moe) + om + te + infinitivo.

⚠️ Cuidado con los dos «te» de la misma frase: el primero es «demasiado» (te moe) y el segundo es la particula del infinitivo (te koken). No son la misma palabra.

⚠️ La pareja: te + adjetivo (demasiado) y adjetivo + genoeg (lo bastante), y las dos cierran con om te. Te moe om te koken · oud genoeg om te rijden.

🏋️ Ejercicio: «es demasiado tarde para llamar» → Het is ___ laat ___ ___ bellen. (Respuesta: te ... om te.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'estoy demasiado cansado para cocinar' AND notes = 'om te: te + adjetivo + om te');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'estoy demasiado cansado para cocinar' AND notes = 'om te: te + adjetivo + om te' LIMIT 1),
    'nl_NL', 'Ik ben te moe om te koken.', 'Ik ben te mu om te koken.',
    '• [can.] Ik ben te moe om te koken. — Estoy demasiado cansado para cocinar.
• [can.] Het is te laat om nog te bellen. — Es demasiado tarde para llamar ya.
• [can.] Die tas is te zwaar om te dragen. — Ese bolso pesa demasiado para llevarlo.
• [vraag] Ben je te druk om te komen? — ¿Estás demasiado liado para venir?
• [can.] Het is te koud om buiten te zitten. — Hace demasiado frío para estar fuera.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estoy demasiado cansado para cocinar' AND notes = 'om te: te + adjetivo + om te' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'estoy demasiado cansado para cocinar' AND notes = 'om te: te + adjetivo + om te' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 11) om te tras adjetivo + genoeg
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'es lo bastante mayor para viajar solo (él)', 'PHRASE', 'om te: adjetivo + genoeg + om te', 'GENOEG va DETRAS del adjetivo (oud genoeg, no «genoeg oud») y lo que sigue pide OM TE: Hij is oud genoeg om alleen te reizen.
@@OMTE@@
📐 Estructura: sujeto + is + adjetivo + genoeg + om + resto (alleen) + te + infinitivo.

⚠️ Con SUSTANTIVO, genoeg puede ir delante o detras (genoeg geld o geld genoeg), pero con ADJETIVO siempre detras: groot genoeg, sterk genoeg, oud genoeg.

⚠️ Fijate donde cae el resto de la frase: alleen va DENTRO del bloque om ... te, antes del infinitivo. Om + todo lo demas + te + infinitivo.

🏋️ Ejercicio: «es lo bastante grande para trabajar» → Hij is ___ ___ om te werken. (Respuesta: oud genoeg.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'es lo bastante mayor para viajar solo (él)' AND notes = 'om te: adjetivo + genoeg + om te');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'es lo bastante mayor para viajar solo (él)' AND notes = 'om te: adjetivo + genoeg + om te' LIMIT 1),
    'nl_NL', 'Hij is oud genoeg om alleen te reizen.', 'Ei is aud jenuj om allen te reisen.',
    '• [can.] Hij is oud genoeg om alleen te reizen. — Es lo bastante mayor para viajar solo.
• [can.] De kamer is groot genoeg om te werken. — La habitación es lo bastante grande para trabajar.
• [vraag] Ben je sterk genoeg om dat te tillen? — ¿Tienes fuerza suficiente para levantar eso?
• [can.] Ik heb genoeg geld om een fiets te kopen. — Tengo dinero suficiente para comprar una bici.
• [can.] Het is warm genoeg om buiten te eten. — Hace calor suficiente para comer fuera.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'es lo bastante mayor para viajar solo (él)' AND notes = 'om te: adjetivo + genoeg + om te' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'es lo bastante mayor para viajar solo (él)' AND notes = 'om te: adjetivo + genoeg + om te' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 12) Het is + adjetivo + om te
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'es difícil aprender neerlandés', 'PHRASE', 'om te: Het is + adjetivo + om te', 'La formula HET IS + adjetivo + OM TE: Het is moeilijk om Nederlands te leren. El het del principio es un sujeto postizo; lo de verdad importante viene detras.
@@OMTE@@
📐 Estructura: Het + is + adjetivo (moeilijk) + om + objeto (Nederlands) + te + infinitivo (leren).

⚠️ Aqui el om es opcional en la norma («Het is moeilijk Nederlands te leren» tambien es correcto), pero al hablar se pone SIEMPRE. Ponlo tu tambien.

⚠️ Misma formula con otros adjetivos y con leuk/fijn/belangrijk/verboden: Het is leuk om je te zien · Het is belangrijk om op tijd te komen · Het is verboden om hier te roken.

🏋️ Ejercicio: «es importante llegar a tiempo» → Het is belangrijk ___ op tijd ___ komen. (Respuesta: om ... te.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'es difícil aprender neerlandés' AND notes = 'om te: Het is + adjetivo + om te');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'es difícil aprender neerlandés' AND notes = 'om te: Het is + adjetivo + om te' LIMIT 1),
    'nl_NL', 'Het is moeilijk om Nederlands te leren.', 'Et is muileik om Nederlands te leren.',
    '• [can.] Het is moeilijk om Nederlands te leren. — Es difícil aprender neerlandés.
• [can.] Het is leuk om je weer te zien. — Es un gusto volver a verte.
• [can.] Het is belangrijk om op tijd te komen. — Es importante llegar a tiempo.
• [can.] Het is verboden om hier te roken. — Está prohibido fumar aquí.
• [vraag] Is het moeilijk om hier te parkeren? — ¿Es difícil aparcar aquí?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'es difícil aprender neerlandés' AND notes = 'om te: Het is + adjetivo + om te' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'es difícil aprender neerlandés' AND notes = 'om te: Het is + adjetivo + om te' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 13) percepción (horen/zien) + infinitivo pelado
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'le oigo cantar (a él)', 'PHRASE', 'infinitivo pelado: horen/zien (percepcion)', 'Los verbos de PERCEPCION (horen, zien, voelen) llevan objeto + infinitivo PELADO: Ik hoor hem zingen. En espanol es igual (le oigo cantar), sin preposicion.
@@OMTE@@
📐 Estructura: sujeto + hoor (2a posicion) + objeto (hem) + infinitivo (zingen) al final. Ni om ni te.

⚠️ En perfecto aparece el DOBLE INFINITIVO: Ik heb hem horen zingen (le he oido cantar), no «gehoord». Le pasa a horen, zien, laten, helpen y a los modales.

⚠️ Con zien y horen tambien cabe la subordinada con dat: Ik zie dat hij komt (veo que viene) frente a Ik zie hem komen (le veo venir).

🏋️ Ejercicio: «la veo venir» → Ik zie haar ___. (Respuesta: komen. Pelado.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'le oigo cantar (a él)' AND notes = 'infinitivo pelado: horen/zien (percepcion)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'le oigo cantar (a él)' AND notes = 'infinitivo pelado: horen/zien (percepcion)' LIMIT 1),
    'nl_NL', 'Ik hoor hem zingen.', 'Ik or em sinjen.',
    '• [can.] Ik hoor hem zingen. — Le oigo cantar.
• [can.] Ik zie haar komen. — La veo venir.
• [perf.] Ik heb hem horen zingen. — Le he oído cantar.
• [can.] Voel je de trein aankomen? — ¿Notas que llega el tren?
• [can.] Hij helpt me afwassen. — Me ayuda a fregar.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'le oigo cantar (a él)' AND notes = 'infinitivo pelado: horen/zien (percepcion)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'le oigo cantar (a él)' AND notes = 'infinitivo pelado: horen/zien (percepcion)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 14) zitten/staan/liggen + te (el «estar -ndo»)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'está leyendo (sentado)', 'PHRASE', 'solo te: zitten/staan/liggen te (estar -ndo)', 'ZITTEN / STAAN / LIGGEN / LOPEN + TE + infinitivo es el «estar haciendo» neerlandes, con la postura incluida: Hij zit te lezen = esta (sentado) leyendo.
@@OMTE@@
📐 Estructura: sujeto + zit (2a posicion) + te + infinitivo. Aqui el om es IMPOSIBLE.

⚠️ El neerlandes no tiene gerundio: para decir «esta leyendo» usa la postura (zit/staat/ligt te) o simplemente el presente (Hij leest). Tambien vale aan het + infinitivo: Hij is aan het lezen.

⚠️ Elige la postura de verdad: zitten (sentado), staan (de pie: Ze staat te koken), liggen (tumbado: Hij ligt te slapen), lopen (andando, y con matiz de fastidio: Hij loopt te zeuren = esta ahi quejandose).

🏋️ Ejercicio: «está cocinando (de pie)» → Ze ___ te koken. (Respuesta: staat.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'está leyendo (sentado)' AND notes = 'solo te: zitten/staan/liggen te (estar -ndo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'está leyendo (sentado)' AND notes = 'solo te: zitten/staan/liggen te (estar -ndo)' LIMIT 1),
    'nl_NL', 'Hij zit te lezen.', 'Ei sit te lesen.',
    '• [can.] Hij zit te lezen. — Está leyendo.
• [can.] Ze staat te koken. — Está cocinando.
• [can.] De kinderen liggen te slapen. — Los niños están durmiendo.
• [can.] Hij is aan het werken. — Está trabajando.
• [uitdr.] Hij loopt te zeuren. — Ahí está, quejándose.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'está leyendo (sentado)' AND notes = 'solo te: zitten/staan/liggen te (estar -ndo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'está leyendo (sentado)' AND notes = 'solo te: zitten/staan/liggen te (estar -ndo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- 15) laten + infinitivo pelado
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'voy a cortarme el pelo (en la peluquería)', 'PHRASE', 'infinitivo pelado: laten (mandar hacer)', 'LATEN + infinitivo PELADO = mandar hacer algo, que te lo hagan: Ik laat mijn haar knippen (voy a que me corten el pelo). Ni om ni te.
@@OMTE@@
📐 Estructura: sujeto + laat (2a posicion) + objeto (mijn haar) + infinitivo (knippen) al final.

⚠️ La diferencia con el espanol: «me corto el pelo» no lo haces tu, te lo hacen. Ese matiz en neerlandes es obligatorio y se marca con laten: Ik knip mijn haar seria que te lo cortas tu mismo.

⚠️ En perfecto, doble infinitivo otra vez: Ik heb mijn haar laten knippen, nunca «gelaten».

⚠️ Familia de laten: een foto laten maken (hacerse una foto), de auto laten repareren (llevar el coche al taller), iets laten zien (enseñar algo), laten weten (avisar: Laat het me weten).

🏋️ Ejercicio: «voy a que me arreglen el coche» → Ik laat mijn auto ___. (Respuesta: repareren.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'voy a cortarme el pelo (en la peluquería)' AND notes = 'infinitivo pelado: laten (mandar hacer)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a cortarme el pelo (en la peluquería)' AND notes = 'infinitivo pelado: laten (mandar hacer)' LIMIT 1),
    'nl_NL', 'Ik laat mijn haar knippen.', 'Ik lat mein ar knippen.',
    '• [can.] Ik laat mijn haar knippen. — Voy a cortarme el pelo.
• [perf.] Ik heb mijn auto laten repareren. — He llevado el coche a arreglar.
• [geb.] Laat het me even weten. — Avísame.
• [vraag] Kun je me dat laten zien? — ¿Me lo puedes enseñar?
• [can.] We laten een nieuwe sleutel maken. — Vamos a hacer una llave nueva.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a cortarme el pelo (en la peluquería)' AND notes = 'infinitivo pelado: laten (mandar hacer)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'voy a cortarme el pelo (en la peluquería)' AND notes = 'infinitivo pelado: laten (mandar hacer)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- BLOQUE COMPARTIDO: el mapa de decisión om te / te / pelado
-- Se escribe una vez y se inyecta en las 15 tarjetas. Idempotente.
-- ==============================================================================
UPDATE words_es
SET rules_help = REPLACE(rules_help, '@@OMTE@@', '🧭 ¿om te, solo te, o infinitivo pelado? El mapa entero:
1️⃣ INFINITIVO PELADO (ni om ni te), porque el verbo se lo traga tal cual:
• modales: kunnen, moeten, mogen, willen, zullen. Ik wil naar huis.
• movimiento y permanencia: gaan, komen, blijven. Ik ga zwemmen · Ik kom je helpen · Blijf je eten?
• laten y doen: Ik laat mijn haar knippen.
• percepcion: zien, horen, voelen. Ik hoor hem zingen.
• helpen y leren: Hij helpt me afwassen · Ik leer autorijden.
2️⃣ SOLO TE (sin om), cuando el infinitivo es el complemento del verbo:
• proberen, beginnen, vergeten, weigeren, besluiten, hopen, durven, beloven, hoeven (niet). Ik probeer gezond te eten · Het begint te regenen · Je hoeft niet te komen.
• zitten / staan / liggen / lopen te = el «estar haciendo». Hij zit te lezen. Aqui el om es imposible.
3️⃣ OM ... TE, obligatorio en estos cuatro sitios:
• FINALIDAD: si en espanol cabe «para», va om. Ik ga naar de winkel om brood te kopen.
• Detras de un SUSTANTIVO: tijd, zin, kans, reden, moeite, plan. Ik heb geen tijd om te koken.
• Detras de te + adjetivo o de adjetivo + genoeg. Ik ben te moe om te koken · oud genoeg om te reizen.
• En Het is + adjetivo. Het is moeilijk om Nederlands te leren.
📐 El ORDEN es siempre el mismo: om + todo lo demas (objetos y complementos) + te + INFINITIVO al final. Ik bel je om het adres door te geven.
✂️ Con verbo SEPARABLE el te va DENTRO y quedan tres palabras: aanvragen → aan te vragen · ophalen → op te halen · meenemen → mee te nemen · opstaan → op te staan · uitleggen → uit te leggen.
⚠️ Error 1, meter om te donde el verbo pide pelado: Ik kom een nieuw paspoort aanvragen (asi se dice), no «Ik kom om een nieuw paspoort aan te vragen». Con gaan/komen/blijven, pelado. Matiz: si el movimiento lleva DESTINO y quieres marcar el para que, vuelve el om — Ik ga naar de ambassade om een paspoort aan te vragen.
⚠️ Error 2, quitar el om donde hace falta: «Ik heb geen tijd te koken» esta mal; es Ik heb geen tijd OM te koken.
🧪 Truco para decidir en dos segundos: ¿puedo decir «para» en espanol? → om ... te. ¿El verbo es de la lista de los pelados (modal, gaan/komen/blijven, laten, zien/horen)? → nada. ¿Ninguna de las dos? → solo te.
🔎 Y ojo, om tiene otras vidas que no son esta: la hora (om negen uur), «alrededor de» (om de hoek) y la preposicion fija de vragen om / het gaat erom.')
WHERE id IN (
    SELECT word_es_id FROM word_es_groups
    WHERE group_id = (SELECT id FROM word_groups WHERE title = 'om te + infinitivo - om te, alleen te of kaal')
)
AND rules_help LIKE '%@@OMTE@@%';
