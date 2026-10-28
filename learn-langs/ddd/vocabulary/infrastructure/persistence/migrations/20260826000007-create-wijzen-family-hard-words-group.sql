-- Learn Languages App - Anade la familia de wijzen (senalar) y la trampa wijzigen al grupo de palabras dificiles
-- Migration: 20260826000007-create-wijzen-family-hard-words-group.sql
-- Description: Anade wijzigen (modificar, verbo aparte y debil), aanwijzen (senalar/designar),
--   afwijzen (rechazar) + su sustantivo afwijzing, verwijzen (remitir, inseparable) y uitwijzen
--   (demostrar/expulsar) al grupo 28, cada una con su rules_help, 5 frases de ejemplo en notes
--   (3 en el caso del sustantivo) y 2 promovidas a tarjetas SENTENCE entrenables. Se excluye
--   bijwijzen por no ser una palabra real en neerlandes.
--   La tabla de la familia + la trampa de wijzigen es un bloque IDENTICO repetido en las 6
--   tarjetas (misma teoria, no reescrita).
--   100% aditiva e idempotente: solo INSERT (NOT EXISTS / OR IGNORE).

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- wijzigen
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'modificar, cambiar (un plan, una ley, una fecha, un contrato)', 'WORD', 'dificil: wijzigen (modificar/cambiar, verbo debil — NO es de la familia de wijzen)', 'wijzigen = modificar, cambiar algo que ya existe (un plan, una ley, una fecha, un contrato, unos ajustes). Verbo debil (regular): wijzigt, wijzigde, gewijzigd. No es separable.
📐 Conjugacion: presente — ik wijzig · jij/hij wijzigt · wij/jullie/zij wijzigen. pasado — ik/jij/hij wijzigde · wij/jullie/zij wijzigden. participio — gewijzigd (heeft gewijzigd).
📌 Regla de bolsillo: si en espanol dices «modificar/cambiar» algo que ya existe (fecha, ley, plan) → wijzigen. Si hablas de contenido que editas a mano (un texto, una foto) → bewerken.

🗺️ La familia de wijzen (apuntar/senalar) — todos verbos fuertes (wijst-wees-gewezen) con un prefijo delante:

| neerlandes | significado | separable | ejemplo |
|---|---|---|---|
| **aanwijzen** | senalar, designar, nombrar | si: wijst … aan | Hij wees de dader aan. — Senalo al culpable. |
| **afwijzen** | rechazar, denegar | si: wijst … af | Ze wees het verzoek af. — Rechazo la peticion. |
| **uitwijzen** | demostrar (una investigacion) / expulsar (legal) | si: wijst … uit | Het onderzoek zal het uitwijzen. — La investigacion lo demostrara. |
| **verwijzen** | remitir, referir(se) a | NO, es inseparable | De dokter verwees me naar een specialist. — El medico me remitio a un especialista. |

⚠️ La trampa del prefijo: aan-, af- y uit- son separables (se despegan y el participio lleva ge- en medio: aangewezen, afgewezen, uitgewezen). ver- es de los prefijos que NUNCA se separan (be-, ge-, er-, her-, ont-, ver-) y el participio NO lleva ge-: verwezen, no geverwezen.

⚠️ Otra trampa, la mas peligrosa: wijzigen SE PARECE mucho a esta familia pero NO es un compuesto de wijzen — es un verbo aparte, DEBIL y regular: wijzigt, wijzigde, gewijzigd. Nada de particula, nada de vocal fuerte.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'modificar, cambiar (un plan, una ley, una fecha, un contrato)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'modificar, cambiar (un plan, una ley, una fecha, un contrato)' LIMIT 1),
    'nl_NL', 'wijzigen', 'weisijen',
    '• [can.] Ik wijzig de afspraak naar volgende week. — Cambio la cita a la semana que viene.
• [perf.] De gemeente heeft de regels gewijzigd. — El ayuntamiento ha modificado las normas.
• [can.] Hij wijzigt zijn wachtwoord elke maand. — Cambia su contraseña cada mes.
• [inv.] Zodra het contract is gewijzigd, tekenen we opnieuw. — En cuanto se modifique el contrato, firmamos de nuevo.
• [vraag] Kun je de datum nog wijzigen? — ¿Puedes cambiar todavía la fecha?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'modificar, cambiar (un plan, una ley, una fecha, un contrato)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'modificar, cambiar (un plan, una ley, una fecha, un contrato)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes)
SELECT 'Cambio la cita a la semana que viene.', 'SENTENCE', 'Ejemplo de "wijzigen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Cambio la cita a la semana que viene.' AND notes = 'Ejemplo de "wijzigen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Cambio la cita a la semana que viene.' AND notes = 'Ejemplo de "wijzigen" (can.)' LIMIT 1),
    'nl_NL', 'Ik wijzig de afspraak naar volgende week.', 'Ik weisij de afsprak nar folgende uek.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cambio la cita a la semana que viene.' AND notes = 'Ejemplo de "wijzigen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Cambio la cita a la semana que viene.' AND notes = 'Ejemplo de "wijzigen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'modificar, cambiar (un plan, una ley, una fecha, un contrato)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Cambio la cita a la semana que viene.' AND notes = 'Ejemplo de "wijzigen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'El ayuntamiento ha modificado las normas.', 'SENTENCE', 'Ejemplo de "wijzigen" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El ayuntamiento ha modificado las normas.' AND notes = 'Ejemplo de "wijzigen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El ayuntamiento ha modificado las normas.' AND notes = 'Ejemplo de "wijzigen" (perf.)' LIMIT 1),
    'nl_NL', 'De gemeente heeft de regels gewijzigd.', 'De jemente eft de rejels jeweisijt.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El ayuntamiento ha modificado las normas.' AND notes = 'Ejemplo de "wijzigen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El ayuntamiento ha modificado las normas.' AND notes = 'Ejemplo de "wijzigen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'modificar, cambiar (un plan, una ley, una fecha, un contrato)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'El ayuntamiento ha modificado las normas.' AND notes = 'Ejemplo de "wijzigen" (perf.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- aanwijzen
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'señalar, designar, nombrar (a alguien o algo)', 'WORD', 'dificil: aanwijzen (senalar/designar/nombrar)', 'aanwijzen = señalar con el dedo, o designar/nombrar a alguien para un cargo o tarea. Separable y fuerte: wijst … aan, wees … aan, heeft … aangewezen.
📐 Conjugacion: presente — ik wijs aan · jij/hij wijst aan · wij/jullie/zij wijzen aan. pasado — ik/jij/hij wees aan · wij/jullie/zij wezen aan. participio — aangewezen (heeft aangewezen).
📌 Regla de bolsillo: dedo o decision que designa algo/a alguien concreto → aanwijzen. El sustantivo aanwijzing significa pista o instruccion (de aanwijzingen volgen = seguir las instrucciones).

🗺️ La familia de wijzen (apuntar/senalar) — todos verbos fuertes (wijst-wees-gewezen) con un prefijo delante:

| neerlandes | significado | separable | ejemplo |
|---|---|---|---|
| **aanwijzen** | senalar, designar, nombrar | si: wijst … aan | Hij wees de dader aan. — Senalo al culpable. |
| **afwijzen** | rechazar, denegar | si: wijst … af | Ze wees het verzoek af. — Rechazo la peticion. |
| **uitwijzen** | demostrar (una investigacion) / expulsar (legal) | si: wijst … uit | Het onderzoek zal het uitwijzen. — La investigacion lo demostrara. |
| **verwijzen** | remitir, referir(se) a | NO, es inseparable | De dokter verwees me naar een specialist. — El medico me remitio a un especialista. |

⚠️ La trampa del prefijo: aan-, af- y uit- son separables (se despegan y el participio lleva ge- en medio: aangewezen, afgewezen, uitgewezen). ver- es de los prefijos que NUNCA se separan (be-, ge-, er-, her-, ont-, ver-) y el participio NO lleva ge-: verwezen, no geverwezen.

⚠️ Otra trampa, la mas peligrosa: wijzigen (modificar, cambiar) SE PARECE mucho a esta familia pero NO es un compuesto de wijzen — es un verbo aparte, DEBIL y regular: wijzigt, wijzigde, gewijzigd. Nada de particula, nada de vocal fuerte.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'señalar, designar, nombrar (a alguien o algo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'señalar, designar, nombrar (a alguien o algo)' LIMIT 1),
    'nl_NL', 'aanwijzen', 'anweisen',
    '• [can.] Ze wijst altijd de beste oplossing aan. — Siempre señala la mejor solución.
• [perf.] Hij is aangewezen als teamleider. — Ha sido nombrado jefe de equipo.
• [can.] De leraar wijst een leerling aan om te antwoorden. — El profesor designa a un alumno para responder.
• [inv.] Zodra de winnaar is aangewezen, klinkt applaus. — En cuanto se designa al ganador, suena el aplauso.
• [vraag] Kun je op de kaart aanwijzen waar je woont? — ¿Puedes señalar en el mapa dónde vives?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'señalar, designar, nombrar (a alguien o algo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'señalar, designar, nombrar (a alguien o algo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes)
SELECT 'Ha sido nombrado jefe de equipo.', 'SENTENCE', 'Ejemplo de "aanwijzen" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ha sido nombrado jefe de equipo.' AND notes = 'Ejemplo de "aanwijzen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha sido nombrado jefe de equipo.' AND notes = 'Ejemplo de "aanwijzen" (perf.)' LIMIT 1),
    'nl_NL', 'Hij is aangewezen als teamleider.', 'Ei is anjeuesen als timlider.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha sido nombrado jefe de equipo.' AND notes = 'Ejemplo de "aanwijzen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha sido nombrado jefe de equipo.' AND notes = 'Ejemplo de "aanwijzen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'señalar, designar, nombrar (a alguien o algo)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Ha sido nombrado jefe de equipo.' AND notes = 'Ejemplo de "aanwijzen" (perf.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'El profesor designa a un alumno para responder.', 'SENTENCE', 'Ejemplo de "aanwijzen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El profesor designa a un alumno para responder.' AND notes = 'Ejemplo de "aanwijzen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El profesor designa a un alumno para responder.' AND notes = 'Ejemplo de "aanwijzen" (can.)' LIMIT 1),
    'nl_NL', 'De leraar wijst een leerling aan om te antwoorden.', 'De lerar weist en lerlinj an om te antuorden.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El profesor designa a un alumno para responder.' AND notes = 'Ejemplo de "aanwijzen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El profesor designa a un alumno para responder.' AND notes = 'Ejemplo de "aanwijzen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'señalar, designar, nombrar (a alguien o algo)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'El profesor designa a un alumno para responder.' AND notes = 'Ejemplo de "aanwijzen" (can.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- afwijzen
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'rechazar, denegar (una solicitud, una petición, a una persona)', 'WORD', 'dificil: afwijzen (rechazar/denegar)', 'afwijzen = rechazar o denegar una solicitud, peticion, propuesta o a una persona. Separable y fuerte: wijst … af, wees … af, heeft … afgewezen.
📐 Conjugacion: presente — ik wijs af · jij/hij wijst af · wij/jullie/zij wijzen af. pasado — ik/jij/hij wees af · wij/jullie/zij wezen af. participio — afgewezen (heeft afgewezen).
📌 El sustantivo es afwijzing (el rechazo, la denegacion): een afwijzing krijgen = recibir un rechazo/una negativa.

🗺️ La familia de wijzen (apuntar/senalar) — todos verbos fuertes (wijst-wees-gewezen) con un prefijo delante:

| neerlandes | significado | separable | ejemplo |
|---|---|---|---|
| **aanwijzen** | senalar, designar, nombrar | si: wijst … aan | Hij wees de dader aan. — Senalo al culpable. |
| **afwijzen** | rechazar, denegar | si: wijst … af | Ze wees het verzoek af. — Rechazo la peticion. |
| **uitwijzen** | demostrar (una investigacion) / expulsar (legal) | si: wijst … uit | Het onderzoek zal het uitwijzen. — La investigacion lo demostrara. |
| **verwijzen** | remitir, referir(se) a | NO, es inseparable | De dokter verwees me naar een specialist. — El medico me remitio a un especialista. |

⚠️ La trampa del prefijo: aan-, af- y uit- son separables (se despegan y el participio lleva ge- en medio: aangewezen, afgewezen, uitgewezen). ver- es de los prefijos que NUNCA se separan (be-, ge-, er-, her-, ont-, ver-) y el participio NO lleva ge-: verwezen, no geverwezen.

⚠️ Otra trampa, la mas peligrosa: wijzigen (modificar, cambiar) SE PARECE mucho a esta familia pero NO es un compuesto de wijzen — es un verbo aparte, DEBIL y regular: wijzigt, wijzigde, gewijzigd. Nada de particula, nada de vocal fuerte.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'rechazar, denegar (una solicitud, una petición, a una persona)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'rechazar, denegar (una solicitud, una petición, a una persona)' LIMIT 1),
    'nl_NL', 'afwijzen', 'afweisen',
    '• [can.] De bank wijst de aanvraag af. — El banco rechaza la solicitud.
• [perf.] Ze hebben mijn visum afgewezen. — Han denegado mi visado.
• [can.] Hij wijst elk voorstel meteen af. — Rechaza cualquier propuesta al instante.
• [inv.] Zodra het verzoek is afgewezen, kun je in beroep gaan. — En cuanto se deniegue la solicitud, puedes recurrir.
• [vraag] Waarom wees ze zijn aanbod af? — ¿Por qué rechazó ella su oferta?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'rechazar, denegar (una solicitud, una petición, a una persona)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'rechazar, denegar (una solicitud, una petición, a una persona)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes)
SELECT 'El banco rechaza la solicitud.', 'SENTENCE', 'Ejemplo de "afwijzen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El banco rechaza la solicitud.' AND notes = 'Ejemplo de "afwijzen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El banco rechaza la solicitud.' AND notes = 'Ejemplo de "afwijzen" (can.)' LIMIT 1),
    'nl_NL', 'De bank wijst de aanvraag af.', 'De bank weist de anfrag af.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El banco rechaza la solicitud.' AND notes = 'Ejemplo de "afwijzen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El banco rechaza la solicitud.' AND notes = 'Ejemplo de "afwijzen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'rechazar, denegar (una solicitud, una petición, a una persona)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'El banco rechaza la solicitud.' AND notes = 'Ejemplo de "afwijzen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Han denegado mi visado.', 'SENTENCE', 'Ejemplo de "afwijzen" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Han denegado mi visado.' AND notes = 'Ejemplo de "afwijzen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Han denegado mi visado.' AND notes = 'Ejemplo de "afwijzen" (perf.)' LIMIT 1),
    'nl_NL', 'Ze hebben mijn visum afgewezen.', 'Se eben mein fisum afjeuesen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Han denegado mi visado.' AND notes = 'Ejemplo de "afwijzen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Han denegado mi visado.' AND notes = 'Ejemplo de "afwijzen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'rechazar, denegar (una solicitud, una petición, a una persona)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Han denegado mi visado.' AND notes = 'Ejemplo de "afwijzen" (perf.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- afwijzing (sustantivo)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el rechazo, la denegación', 'WORD', 'dificil: afwijzing (sustantivo de afwijzen)', 'de afwijzing = el rechazo, la denegación (sustantivo de género común: de afwijzing, plural de afwijzingen). Se usa tanto para trámites (una solicitud denegada) como en lo emocional (sentirse rechazado).
🗺️ Colocaciones frecuentes: een afwijzing krijgen/ontvangen = recibir un rechazo. een afwijzing sturen = enviar una denegación. bang zijn voor afwijzing = tener miedo al rechazo (emocional).
📌 Viene de afwijzen (rechazar) — ver esa tarjeta para la conjugación y la familia de wijzen.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el rechazo, la denegación');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el rechazo, la denegación' LIMIT 1),
    'nl_NL', 'de afwijzing', 'de affeisinj',
    '• [can.] Ik kreeg gisteren een afwijzing van de universiteit. — Ayer recibí una denegación de la universidad.
• [inv.] Na de derde afwijzing gaf ze de moed niet op. — Después del tercer rechazo, no se rindió.
• [can.] Hij is bang voor afwijzing. — Tiene miedo al rechazo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el rechazo, la denegación' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el rechazo, la denegación' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes)
SELECT 'Ayer recibí una denegación de la universidad.', 'SENTENCE', 'Ejemplo de "afwijzing" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ayer recibí una denegación de la universidad.' AND notes = 'Ejemplo de "afwijzing" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer recibí una denegación de la universidad.' AND notes = 'Ejemplo de "afwijzing" (can.)' LIMIT 1),
    'nl_NL', 'Ik kreeg gisteren een afwijzing van de universiteit.', 'Ik krej jisteren en affeisinj fan de uniferziteit.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer recibí una denegación de la universidad.' AND notes = 'Ejemplo de "afwijzing" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ayer recibí una denegación de la universidad.' AND notes = 'Ejemplo de "afwijzing" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'el rechazo, la denegación' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Ayer recibí una denegación de la universidad.' AND notes = 'Ejemplo de "afwijzing" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Después del tercer rechazo, no se rindió.', 'SENTENCE', 'Ejemplo de "afwijzing" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Después del tercer rechazo, no se rindió.' AND notes = 'Ejemplo de "afwijzing" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Después del tercer rechazo, no se rindió.' AND notes = 'Ejemplo de "afwijzing" (inv.)' LIMIT 1),
    'nl_NL', 'Na de derde afwijzing gaf ze de moed niet op.', 'Na de derde affeisinj jaf se de mut nit op.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Después del tercer rechazo, no se rindió.' AND notes = 'Ejemplo de "afwijzing" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Después del tercer rechazo, no se rindió.' AND notes = 'Ejemplo de "afwijzing" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'el rechazo, la denegación' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Después del tercer rechazo, no se rindió.' AND notes = 'Ejemplo de "afwijzing" (inv.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- verwijzen
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'remitir, referir a alguien/algo (a otra fuente, persona o lugar)', 'WORD', 'dificil: verwijzen (remitir/referir), inseparable', 'verwijzen = remitir o referir a alguien/algo hacia otra fuente, persona, lugar o documento: verwijzen naar = referirse a / remitir a. Verbo fuerte pero con prefijo INSEPARABLE ver-: nunca se despega y el participio no lleva ge-.
📐 Conjugacion: presente — ik verwijs · jij/hij verwijst · wij/jullie/zij verwijzen. pasado — ik/jij/hij verwees · wij/jullie/zij verwezen. participio — verwezen (heeft verwezen, sin ge-).
📌 El sustantivo es verwijzing (la referencia, la remision, la derivacion medica): een verwijzing naar de specialist = una derivacion al especialista.

🗺️ La familia de wijzen (apuntar/senalar) — todos verbos fuertes (wijst-wees-gewezen) con un prefijo delante:

| neerlandes | significado | separable | ejemplo |
|---|---|---|---|
| **aanwijzen** | senalar, designar, nombrar | si: wijst … aan | Hij wees de dader aan. — Senalo al culpable. |
| **afwijzen** | rechazar, denegar | si: wijst … af | Ze wees het verzoek af. — Rechazo la peticion. |
| **uitwijzen** | demostrar (una investigacion) / expulsar (legal) | si: wijst … uit | Het onderzoek zal het uitwijzen. — La investigacion lo demostrara. |
| **verwijzen** | remitir, referir(se) a | NO, es inseparable | De dokter verwees me naar een specialist. — El medico me remitio a un especialista. |

⚠️ La trampa del prefijo: aan-, af- y uit- son separables (se despegan y el participio lleva ge- en medio: aangewezen, afgewezen, uitgewezen). ver- es de los prefijos que NUNCA se separan (be-, ge-, er-, her-, ont-, ver-) y el participio NO lleva ge-: verwezen, no geverwezen.

⚠️ Otra trampa, la mas peligrosa: wijzigen (modificar, cambiar) SE PARECE mucho a esta familia pero NO es un compuesto de wijzen — es un verbo aparte, DEBIL y regular: wijzigt, wijzigde, gewijzigd. Nada de particula, nada de vocal fuerte.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'remitir, referir a alguien/algo (a otra fuente, persona o lugar)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'remitir, referir a alguien/algo (a otra fuente, persona o lugar)' LIMIT 1),
    'nl_NL', 'verwijzen', 'ferweisen',
    '• [can.] De dokter verwijst me naar een specialist. — El médico me remite a un especialista.
• [perf.] Ze heeft naar het verkeerde document verwezen. — Ha hecho referencia al documento equivocado.
• [can.] Hij verwijst altijd naar dezelfde bron. — Siempre remite a la misma fuente.
• [inv.] Zodra de huisarts heeft verwezen, kun je een afspraak maken. — En cuanto el médico de cabecera haya derivado, puedes pedir cita.
• [vraag] Waarnaar verwijst deze voetnoot? — ¿A qué remite esta nota al pie?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'remitir, referir a alguien/algo (a otra fuente, persona o lugar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'remitir, referir a alguien/algo (a otra fuente, persona o lugar)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes)
SELECT 'El médico me remite a un especialista.', 'SENTENCE', 'Ejemplo de "verwijzen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El médico me remite a un especialista.' AND notes = 'Ejemplo de "verwijzen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El médico me remite a un especialista.' AND notes = 'Ejemplo de "verwijzen" (can.)' LIMIT 1),
    'nl_NL', 'De dokter verwijst me naar een specialist.', 'De dokter ferweist me nar en spesjalist.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El médico me remite a un especialista.' AND notes = 'Ejemplo de "verwijzen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El médico me remite a un especialista.' AND notes = 'Ejemplo de "verwijzen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'remitir, referir a alguien/algo (a otra fuente, persona o lugar)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'El médico me remite a un especialista.' AND notes = 'Ejemplo de "verwijzen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'Ha hecho referencia al documento equivocado.', 'SENTENCE', 'Ejemplo de "verwijzen" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Ha hecho referencia al documento equivocado.' AND notes = 'Ejemplo de "verwijzen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha hecho referencia al documento equivocado.' AND notes = 'Ejemplo de "verwijzen" (perf.)' LIMIT 1),
    'nl_NL', 'Ze heeft naar het verkeerde document verwezen.', 'Se eft nar et ferkerde dokument ferwesen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha hecho referencia al documento equivocado.' AND notes = 'Ejemplo de "verwijzen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Ha hecho referencia al documento equivocado.' AND notes = 'Ejemplo de "verwijzen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'remitir, referir a alguien/algo (a otra fuente, persona o lugar)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Ha hecho referencia al documento equivocado.' AND notes = 'Ejemplo de "verwijzen" (perf.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- uitwijzen
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'demostrar, revelar (una investigación) / expulsar (por ley, inmigración)', 'WORD', 'dificil: uitwijzen (demostrar-investigacion / expulsar-legal)', 'uitwijzen tiene dos sentidos, segun el sujeto: (1) con un sujeto como "onderzoek" o "tijd" = demostrar, revelar, resultar (algo se sabra con el tiempo o una investigacion); (2) con un sujeto como el Estado o un juez = expulsar a alguien del pais (contexto legal/inmigracion). Separable y fuerte: wijst … uit, wees … uit, heeft … uitgewezen.
📐 Conjugacion: presente — ik wijs uit · jij/hij wijst uit · wij/jullie/zij wijzen uit. pasado — ik/jij/hij wees uit · wij/jullie/zij wezen uit. participio — uitgewezen (heeft uitgewezen).
📌 Regla de bolsillo: si el sujeto es una investigacion/el tiempo → "se vera/demostrara". Si el sujeto es una autoridad y el objeto una persona → "expulsar".

🗺️ La familia de wijzen (apuntar/senalar) — todos verbos fuertes (wijst-wees-gewezen) con un prefijo delante:

| neerlandes | significado | separable | ejemplo |
|---|---|---|---|
| **aanwijzen** | senalar, designar, nombrar | si: wijst … aan | Hij wees de dader aan. — Senalo al culpable. |
| **afwijzen** | rechazar, denegar | si: wijst … af | Ze wees het verzoek af. — Rechazo la peticion. |
| **uitwijzen** | demostrar (una investigacion) / expulsar (legal) | si: wijst … uit | Het onderzoek zal het uitwijzen. — La investigacion lo demostrara. |
| **verwijzen** | remitir, referir(se) a | NO, es inseparable | De dokter verwees me naar een specialist. — El medico me remitio a un especialista. |

⚠️ La trampa del prefijo: aan-, af- y uit- son separables (se despegan y el participio lleva ge- en medio: aangewezen, afgewezen, uitgewezen). ver- es de los prefijos que NUNCA se separan (be-, ge-, er-, her-, ont-, ver-) y el participio NO lleva ge-: verwezen, no geverwezen.

⚠️ Otra trampa, la mas peligrosa: wijzigen (modificar, cambiar) SE PARECE mucho a esta familia pero NO es un compuesto de wijzen — es un verbo aparte, DEBIL y regular: wijzigt, wijzigde, gewijzigd. Nada de particula, nada de vocal fuerte.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'demostrar, revelar (una investigación) / expulsar (por ley, inmigración)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'demostrar, revelar (una investigación) / expulsar (por ley, inmigración)' LIMIT 1),
    'nl_NL', 'uitwijzen', 'euteisen',
    '• [can.] De tijd zal het uitwijzen. — El tiempo lo dirá / lo demostrará.
• [perf.] Onderzoek heeft uitgewezen dat het virus muteert. — La investigación ha revelado que el virus muta.
• [can.] De rechter wijst de asielzoeker uit. — El juez expulsa al solicitante de asilo.
• [inv.] Zodra de test dat uitwijst, nemen we maatregelen. — En cuanto la prueba lo demuestre, tomamos medidas.
• [vraag] Wat zal de toekomst uitwijzen? — ¿Qué demostrará el futuro?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'demostrar, revelar (una investigación) / expulsar (por ley, inmigración)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'demostrar, revelar (una investigación) / expulsar (por ley, inmigración)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT INTO words_es (text, word_type, notes)
SELECT 'El tiempo lo dirá.', 'SENTENCE', 'Ejemplo de "uitwijzen" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'El tiempo lo dirá.' AND notes = 'Ejemplo de "uitwijzen" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'El tiempo lo dirá.' AND notes = 'Ejemplo de "uitwijzen" (can.)' LIMIT 1),
    'nl_NL', 'De tijd zal het uitwijzen.', 'De teit sal et euteisen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El tiempo lo dirá.' AND notes = 'Ejemplo de "uitwijzen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'El tiempo lo dirá.' AND notes = 'Ejemplo de "uitwijzen" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'demostrar, revelar (una investigación) / expulsar (por ley, inmigración)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'El tiempo lo dirá.' AND notes = 'Ejemplo de "uitwijzen" (can.)' LIMIT 1),
    'EXAMPLE');

INSERT INTO words_es (text, word_type, notes)
SELECT 'La investigación ha revelado que el virus muta.', 'SENTENCE', 'Ejemplo de "uitwijzen" (perf.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'La investigación ha revelado que el virus muta.' AND notes = 'Ejemplo de "uitwijzen" (perf.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'La investigación ha revelado que el virus muta.' AND notes = 'Ejemplo de "uitwijzen" (perf.)' LIMIT 1),
    'nl_NL', 'Onderzoek heeft uitgewezen dat het virus muteert.', 'Onderzuk eft eutejeuesen dat et firus mutert.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'La investigación ha revelado que el virus muta.' AND notes = 'Ejemplo de "uitwijzen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'La investigación ha revelado que el virus muta.' AND notes = 'Ejemplo de "uitwijzen" (perf.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'demostrar, revelar (una investigación) / expulsar (por ley, inmigración)' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'La investigación ha revelado que el virus muta.' AND notes = 'Ejemplo de "uitwijzen" (perf.)' LIMIT 1),
    'EXAMPLE');
