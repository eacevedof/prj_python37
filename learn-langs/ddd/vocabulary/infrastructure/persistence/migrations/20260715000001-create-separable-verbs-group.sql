-- Learn Languages App - Grupo "verbos separables - scheidbare werkwoorden"
-- Migration: 20260715000001-create-separable-verbs-group.sql
-- Description: 15 frases cotidianas con los verbos separables más usados (opbellen,
--   opstaan, aankomen, afspreken, opnemen, meenemen, ophalen, uitnodigen, terugbellen,
--   uitgeven, weggaan, opruimen, aantrekken, opschieten, uitzetten), MEZCLANDO tiempos:
--   presente, pasado (imperfectum) y presente perfecto (voltooid), con pronombres
--   variados (ik, je, hij, we, u, jullie, ze, hem, ons). rules_help = nota del verbo +
--   el mecanismo separable (prefijo al final en presente/pasado; repegado con -ge- dentro
--   en el perfecto; hebben/zijn; te en infinitivo; bijzin entero al final) + 📐 fórmula +
--   🧭 ejemplo. Nace de la duda "Ik bel je op straks" (el prefijo op no va en medio).
--   Corre después de 20260714000007. Pronunciation con DutchToSpanishPhoneticService.
--   100% aditiva e IDEMPOTENTE (INSERT ... WHERE NOT EXISTS / OR IGNORE). No toca audios
--   ni imágenes existentes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'verbos separables - scheidbare werkwoorden',
    'Verbos separables (scheidbare werkwoorden): el prefijo (op, mee, aan, uit, af, terug, weg…) se separa y viaja según el tiempo — al final en presente y pasado, repegado con -ge- dentro en el perfecto (opbellen → opgebeld); frases cotidianas mezclando presente, pasado y presente perfecto con pronombres variados',
    'migracion'
);

-- ==============================================================================
-- opbellen (perfecto, je): Ik heb je gisteren opgebeld.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'te llamé ayer', 'PHRASE', 'Verbo separable: opbellen (perfecto)', 'opbellen = llamar por teléfono (op + bellen). En el perfecto el participio es opgebeld (op+ge+beld) con auxiliar hebben → Ik heb je opgebeld. gisteren = ayer.

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Perfecto: sujeto + heb (2ª posición) + resto + participio (op+ge+beld) al final.

🧭 Cuándo usarlo: contar que llamaste a alguien. Ej.: → Ik heb je gisteren opgebeld, maar je nam niet op (te llamé ayer, pero no lo cogiste).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'te llamé ayer' AND notes = 'Verbo separable: opbellen (perfecto)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'te llamé ayer' AND notes = 'Verbo separable: opbellen (perfecto)' LIMIT 1),
    'nl_NL', 'Ik heb je gisteren opgebeld.', 'Ik eb ye jisteren opjebeld.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'te llamé ayer' AND notes = 'Verbo separable: opbellen (perfecto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'te llamé ayer' AND notes = 'Verbo separable: opbellen (perfecto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- opstaan (perfecto zijn, ik): Vanochtend ben ik laat opgestaan.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'esta mañana me he levantado tarde', 'PHRASE', 'Verbo separable: opstaan (perfecto, zijn)', 'opstaan = levantarse (op + staan). Lleva zijn en el perfecto por ser cambio de estado → ben opgestaan (op+ge+staan). Vanochtend = esta mañana.

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Perfecto con adverbio delante: adverbio + ben (2ª posición) + sujeto + resto + participio (opgestaan) al final.

🧭 Cuándo usarlo: excusarte por llegar tarde. Ej.: → Sorry, vanochtend ben ik laat opgestaan (perdona, esta mañana me he levantado tarde).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'esta mañana me he levantado tarde' AND notes = 'Verbo separable: opstaan (perfecto, zijn)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'esta mañana me he levantado tarde' AND notes = 'Verbo separable: opstaan (perfecto, zijn)' LIMIT 1),
    'nl_NL', 'Vanochtend ben ik laat opgestaan.', 'Fanojtend ben ik lat opjestan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'esta mañana me he levantado tarde' AND notes = 'Verbo separable: opstaan (perfecto, zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'esta mañana me he levantado tarde' AND notes = 'Verbo separable: opstaan (perfecto, zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- aankomen (perfecto zijn, we): We zijn net aangekomen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'acabamos de llegar', 'PHRASE', 'Verbo separable: aankomen (perfecto, zijn)', 'aankomen = llegar (aan + komen). Es movimiento → auxiliar zijn: We zijn aangekomen (aan+ge+komen). net = acabar de (recencia).

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Perfecto con zijn: sujeto + zijn (2ª posición) + resto + participio (aangekomen) al final.

🧭 Cuándo usarlo: avisar de que acabáis de llegar. Ej.: → We zijn net aangekomen, alles goed (acabamos de llegar, todo bien).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'acabamos de llegar' AND notes = 'Verbo separable: aankomen (perfecto, zijn)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'acabamos de llegar' AND notes = 'Verbo separable: aankomen (perfecto, zijn)' LIMIT 1),
    'nl_NL', 'We zijn net aangekomen.', 'Ue sein net anjekomen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'acabamos de llegar' AND notes = 'Verbo separable: aankomen (perfecto, zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'acabamos de llegar' AND notes = 'Verbo separable: aankomen (perfecto, zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- afspreken (presente, we): We spreken om acht uur af.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'quedamos a las ocho', 'PHRASE', 'Verbo separable: afspreken (presente)', 'afspreken = quedar / acordar (af + spreken). En presente el prefijo af se va al final → We spreken … af. om acht uur = a las ocho.

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Presente (frase principal): sujeto + verbo (2ª posición) + tiempo/lugar + prefijo (af) al final.

🧭 Cuándo usarlo: cerrar una cita o un plan. Ej.: → We spreken om acht uur af bij de bioscoop (quedamos a las ocho en el cine).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'quedamos a las ocho' AND notes = 'Verbo separable: afspreken (presente)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'quedamos a las ocho' AND notes = 'Verbo separable: afspreken (presente)' LIMIT 1),
    'nl_NL', 'We spreken om acht uur af.', 'Ue spreken om ajt ur af.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'quedamos a las ocho' AND notes = 'Verbo separable: afspreken (presente)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'quedamos a las ocho' AND notes = 'Verbo separable: afspreken (presente)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- opnemen (pasado, je): Waarom nam je niet op?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿por qué no lo cogiste?', 'PHRASE', 'Verbo separable: opnemen (pasado)', 'opnemen = coger (el teléfono) / grabar (op + nemen). Pasado de nemen: nam; el prefijo op se queda al final → nam … op.

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Pregunta-W (pasado): palabra-W + verbo en pasado + sujeto + resto + prefijo (op) al final.

🧭 Cuándo usarlo: reprochar una llamada perdida. Ej.: → Ik belde je, waarom nam je niet op? (te llamé, ¿por qué no lo cogiste?).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿por qué no lo cogiste?' AND notes = 'Verbo separable: opnemen (pasado)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿por qué no lo cogiste?' AND notes = 'Verbo separable: opnemen (pasado)' LIMIT 1),
    'nl_NL', 'Waarom nam je niet op?', 'Uarom nam ye nit op?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿por qué no lo cogiste?' AND notes = 'Verbo separable: opnemen (pasado)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿por qué no lo cogiste?' AND notes = 'Verbo separable: opnemen (pasado)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- meenemen (pasado, hem): Ik nam hem mee naar huis.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'me lo llevé a casa', 'PHRASE', 'Verbo separable: meenemen (pasado)', 'meenemen = llevarse / traer (mee + nemen). Pasado: nam … mee. hem = objeto (lo/le, a él).

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Pasado (frase principal): sujeto + verbo en pasado (2ª posición) + objeto + lugar + prefijo (mee) al final.

🧭 Cuándo usarlo: contar que te llevaste a alguien o algo. Ej.: → Hij had te veel op, dus ik nam hem mee naar huis (había bebido de más, así que me lo llevé a casa).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'me lo llevé a casa' AND notes = 'Verbo separable: meenemen (pasado)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'me lo llevé a casa' AND notes = 'Verbo separable: meenemen (pasado)' LIMIT 1),
    'nl_NL', 'Ik nam hem mee naar huis.', 'Ik nam em me nar aus.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me lo llevé a casa' AND notes = 'Verbo separable: meenemen (pasado)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'me lo llevé a casa' AND notes = 'Verbo separable: meenemen (pasado)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- ophalen (presente, jullie): Ik haal jullie om zes uur op.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'os recojo a las seis', 'PHRASE', 'Verbo separable: ophalen (presente)', 'ophalen = recoger / ir a buscar (a alguien) (op + halen). Presente: haal … op. jullie = os / a vosotros.

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Presente (frase principal): sujeto + verbo (2ª posición) + objeto + tiempo + prefijo (op) al final.

🧭 Cuándo usarlo: quedar para recoger a alguien. Ej.: → Ik haal jullie om zes uur op met de auto (os recojo a las seis en coche).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'os recojo a las seis' AND notes = 'Verbo separable: ophalen (presente)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'os recojo a las seis' AND notes = 'Verbo separable: ophalen (presente)' LIMIT 1),
    'nl_NL', 'Ik haal jullie om zes uur op.', 'Ik al yulli om ses ur op.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'os recojo a las seis' AND notes = 'Verbo separable: ophalen (presente)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'os recojo a las seis' AND notes = 'Verbo separable: ophalen (presente)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- uitnodigen (perfecto, ons): Ze hebben ons uitgenodigd.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'nos han invitado', 'PHRASE', 'Verbo separable: uitnodigen (perfecto)', 'uitnodigen = invitar (uit + nodigen). Perfecto: uitgenodigd (uit+ge+nodigd) con hebben. ons = nos.

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Perfecto: sujeto + hebben (2ª posición) + objeto + participio (uitgenodigd) al final.

🧭 Cuándo usarlo: contar que os han invitado. Ej.: → Ze hebben ons uitgenodigd voor het feest (nos han invitado a la fiesta).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'nos han invitado' AND notes = 'Verbo separable: uitnodigen (perfecto)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'nos han invitado' AND notes = 'Verbo separable: uitnodigen (perfecto)' LIMIT 1),
    'nl_NL', 'Ze hebben ons uitgenodigd.', 'Se ebben ons autjenodijd.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'nos han invitado' AND notes = 'Verbo separable: uitnodigen (perfecto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'nos han invitado' AND notes = 'Verbo separable: uitnodigen (perfecto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- terugbellen (perfecto, u): Heeft hij u al teruggebeld?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿ya le ha devuelto la llamada?', 'PHRASE', 'Verbo separable: terugbellen (perfecto)', 'terugbellen = devolver la llamada (terug + bellen). Perfecto: teruggebeld (terug+ge+beld) con hebben. u = usted (formal).

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Pregunta sí/no (perfecto): heeft + sujeto + resto + participio (teruggebeld) al final.

🧭 Cuándo usarlo: preguntar si ya te respondieron. Ej.: → Heeft hij u al teruggebeld? (¿ya le ha devuelto la llamada?).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿ya le ha devuelto la llamada?' AND notes = 'Verbo separable: terugbellen (perfecto)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿ya le ha devuelto la llamada?' AND notes = 'Verbo separable: terugbellen (perfecto)' LIMIT 1),
    'nl_NL', 'Heeft hij u al teruggebeld?', 'Eft ei u al terujjebeld?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿ya le ha devuelto la llamada?' AND notes = 'Verbo separable: terugbellen (perfecto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿ya le ha devuelto la llamada?' AND notes = 'Verbo separable: terugbellen (perfecto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- uitgeven (perfecto, ik): Ik heb te veel geld uitgegeven.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'he gastado demasiado dinero', 'PHRASE', 'Verbo separable: uitgeven (perfecto)', 'uitgeven = gastar (dinero) / publicar (uit + geven). Perfecto: uitgegeven (uit+ge+geven) con hebben. te veel = demasiado.

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Perfecto: sujeto + heb (2ª posición) + objeto + participio (uitgegeven) al final.

🧭 Cuándo usarlo: lamentar un gasto. Ej.: → Ik heb dit weekend te veel geld uitgegeven (este finde he gastado demasiado dinero).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'he gastado demasiado dinero' AND notes = 'Verbo separable: uitgeven (perfecto)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'he gastado demasiado dinero' AND notes = 'Verbo separable: uitgeven (perfecto)' LIMIT 1),
    'nl_NL', 'Ik heb te veel geld uitgegeven.', 'Ik eb te fel jeld autjejefen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'he gastado demasiado dinero' AND notes = 'Verbo separable: uitgeven (perfecto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'he gastado demasiado dinero' AND notes = 'Verbo separable: uitgeven (perfecto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- weggaan (perfecto zijn, ze): Ze zijn al weggegaan.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ya se han ido', 'PHRASE', 'Verbo separable: weggaan (perfecto, zijn)', 'weggaan = irse / marcharse (weg + gaan). Movimiento → auxiliar zijn: zijn weggegaan (weg+ge+gaan). al = ya.

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Perfecto con zijn: sujeto + zijn (2ª posición) + al + participio (weggegaan) al final.

🧭 Cuándo usarlo: decir que la gente ya se fue. Ej.: → Toen ik aankwam, waren ze al weggegaan (cuando llegué, ya se habían ido). En presente perfecto: Ze zijn al weggegaan (ya se han ido).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ya se han ido' AND notes = 'Verbo separable: weggaan (perfecto, zijn)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ya se han ido' AND notes = 'Verbo separable: weggaan (perfecto, zijn)' LIMIT 1),
    'nl_NL', 'Ze zijn al weggegaan.', 'Se sein al uejjejan.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ya se han ido' AND notes = 'Verbo separable: weggaan (perfecto, zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ya se han ido' AND notes = 'Verbo separable: weggaan (perfecto, zijn)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- opruimen (perfecto, je): Heb je je kamer al opgeruimd?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿ya has ordenado tu cuarto?', 'PHRASE', 'Verbo separable: opruimen (perfecto)', 'opruimen = ordenar / recoger (op + ruimen). Perfecto: opgeruimd (op+ge+ruimd) con hebben. je kamer = tu cuarto.

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Pregunta sí/no (perfecto): heb + je + objeto + al + participio (opgeruimd) al final.

🧭 Cuándo usarlo: preguntar o mandar recoger. Ej.: → Heb je je kamer al opgeruimd? (¿ya has ordenado tu cuarto?).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿ya has ordenado tu cuarto?' AND notes = 'Verbo separable: opruimen (perfecto)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿ya has ordenado tu cuarto?' AND notes = 'Verbo separable: opruimen (perfecto)' LIMIT 1),
    'nl_NL', 'Heb je je kamer al opgeruimd?', 'Eb ye ye kamer al opjeraumd?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿ya has ordenado tu cuarto?' AND notes = 'Verbo separable: opruimen (perfecto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿ya has ordenado tu cuarto?' AND notes = 'Verbo separable: opruimen (perfecto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- aantrekken (imperativo, je): Trek je jas aan, het is koud.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'ponte la chaqueta, hace frío', 'PHRASE', 'Verbo separable: aantrekken (imperativo)', 'aantrekken = ponerse (una prenda) (aan + trekken). Imperativo: Trek … aan. (aandoen sirve para abrigo/zapatos; aantrekken para prendas que se estiran al ponerse).

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Imperativo: verbo (1ª posición) + objeto + prefijo (aan) al final; sin sujeto.

🧭 Cuándo usarlo: decir a alguien que se abrigue. Ej.: → Trek je jas aan, het is koud buiten (ponte la chaqueta, hace frío fuera).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ponte la chaqueta, hace frío' AND notes = 'Verbo separable: aantrekken (imperativo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'ponte la chaqueta, hace frío' AND notes = 'Verbo separable: aantrekken (imperativo)' LIMIT 1),
    'nl_NL', 'Trek je jas aan, het is koud.', 'Trek ye yas an, et is kaud.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ponte la chaqueta, hace frío' AND notes = 'Verbo separable: aantrekken (imperativo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'ponte la chaqueta, hace frío' AND notes = 'Verbo separable: aantrekken (imperativo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- opschieten (imperativo): Schiet op, we komen te laat!
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡date prisa, que llegamos tarde!', 'PHRASE', 'Verbo separable: opschieten (imperativo)', 'opschieten = darse prisa (op + schieten). Imperativo muy usado: Schiet op! El prefijo op se va al final.

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Imperativo: verbo (1ª posición) + prefijo (op) al final; sin sujeto.

🧭 Cuándo usarlo: meter prisa a alguien. Ej.: → Schiet op, we komen te laat! (¡date prisa, que llegamos tarde!). También: Schiet eens op! (¡venga, deprisa!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡date prisa, que llegamos tarde!' AND notes = 'Verbo separable: opschieten (imperativo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡date prisa, que llegamos tarde!' AND notes = 'Verbo separable: opschieten (imperativo)' LIMIT 1),
    'nl_NL', 'Schiet op, we komen te laat!', 'Sjit op, ue komen te lat!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡date prisa, que llegamos tarde!' AND notes = 'Verbo separable: opschieten (imperativo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡date prisa, que llegamos tarde!' AND notes = 'Verbo separable: opschieten (imperativo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- uitzetten (imperativo, je): Zet je telefoon even uit.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'apaga el móvil un momento', 'PHRASE', 'Verbo separable: uitzetten (imperativo)', 'uitzetten = apagar (aparatos) (uit + zetten); su opuesto es aanzetten (encender). Imperativo: Zet … uit. even suaviza (un momento).

Verbos separables (scheidbare werkwoorden): son prefijo + verbo (opbellen, meenemen, aankomen); el prefijo (op, mee, aan, uit, af, terug, weg…) se SEPARA y viaja según el tiempo.
• Presente y pasado (frase principal): el verbo conjugado va en 2ª posición y el prefijo se va SOLO al FINAL → Ik bel je op · Ik belde je op. Nunca en medio: Ik bel je op straks ✗ → Ik bel je straks op ✓.
• Presente perfecto: el prefijo se REPEGA y el -ge- del participio se mete EN MEDIO → op+ge+beld = opgebeld, mee+ge+nomen = meegenomen, aan+ge+komen = aangekomen; el participio entero va al final (Ik heb je opgebeld).
• Auxiliar: hebben por defecto; zijn si hay movimiento o cambio de estado (opstaan, aankomen, weggaan → ben/is/zijn … opgestaan/aangekomen/weggegaan).
• Infinitivo con modal o con te: NO se separa; solo el te se cuela dentro → Ik moet je opbellen · om je op te bellen.
• Subordinada (bijzin): el verbo va entero al final → …omdat ik je later opbel.
Truco: en frase simple el trocito (op/mee/aan…) cae al final del escenario; en el perfecto vuelve pegado con -ge- dentro.

📐 Imperativo: verbo (1ª posición) + objeto + partícula + prefijo (uit) al final; sin sujeto.

🧭 Cuándo usarlo: pedir apagar un aparato. Ej.: → Zet je telefoon even uit tijdens het eten (apaga el móvil un momento durante la cena).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'apaga el móvil un momento' AND notes = 'Verbo separable: uitzetten (imperativo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'apaga el móvil un momento' AND notes = 'Verbo separable: uitzetten (imperativo)' LIMIT 1),
    'nl_NL', 'Zet je telefoon even uit.', 'Set ye telefon efen aut.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'apaga el móvil un momento' AND notes = 'Verbo separable: uitzetten (imperativo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos separables - scheidbare werkwoorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'apaga el móvil un momento' AND notes = 'Verbo separable: uitzetten (imperativo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
