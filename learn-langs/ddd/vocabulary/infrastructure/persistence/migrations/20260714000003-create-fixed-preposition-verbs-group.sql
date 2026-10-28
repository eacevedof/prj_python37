-- Learn Languages App - Grupo "verbos con preposición fija - vaste voorzetsels"
-- Migration: 20260714000003-create-fixed-preposition-verbs-group.sql
-- Description: 13 frases cotidianas con verbos (y adjetivos) que rigen una preposición fija
--   (denken aan, wachten op, luisteren naar, kijken naar, houden van, rekenen op, vragen
--   naar, geloven in, praten met, lachen om, trots/boos zijn op, dromen van), con pronombres
--   variados en forma TÓNICA tras la preposición. rules_help = nota del verbo + el "porqué"
--   de la preposición (la rige el verbo, no el pronombre; la a personal española es falsa
--   preposición; tras preposición forma tónica y hen nunca hun) + fórmula + 🧭 ejemplo.
--   La tarjeta de wachten op incluye además el bloque 🔤 del orden fijo "maar even".
--   Al final, UPDATE que añade ese mismo bloque 🔤 a la tarjeta existente "Bel haar maar even"
--   del grupo pronombres (la frase que originó la duda). Corre después de 20260713000004.
--   Pronunciation con DutchToSpanishPhoneticService. 100% aditiva e IDEMPOTENTE
--   (INSERT ... WHERE NOT EXISTS / OR IGNORE; UPDATE con guarda NOT LIKE '%🔤%').
--   No toca audios ni imágenes existentes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'verbos con preposición fija - vaste voorzetsels',
    'Verbos (y adjetivos) que rigen una preposición fija — denken aan, wachten op, luisteren naar, houden van, rekenen op, geloven in, trots/boos zijn op…: la preposición la manda el verbo (no el pronombre) y tras ella el pronombre va en forma tónica; frases cotidianas con pronombres variados',
    'migracion'
);

-- ==============================================================================
-- denken aan (jou): Ik denk de hele dag aan jou.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pienso en ti todo el día', 'PHRASE', 'Preposición fija: denken aan', 'denken aan = pensar EN. denken exige la preposición aan; sin ella la frase está mal (Ik denk jou ✗).

Verbos con preposición fija (vaste voorzetsels): la preposición la manda el VERBO, no el pronombre — se aprende con cada verbo (como en español pensar EN, contar CON, depender DE). El complemento es objeto de esa preposición.
• Tras preposición el pronombre va en forma TÓNICA: aan mij, op jou, naar hem, van haar, in hen (nunca hun tras preposición). Coloquialmente se oye la átona (voor me, op je), pero la plena es lo estándar.
• Trampa del español: la a de "no LOS invité" / "invitar A alguien" es la a personal (marca de objeto), NO una preposición; uitnodigen, zien, kennen, bellen… llevan objeto directo SIN preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto (prep + objeto) al final.

🧭 Cuándo usarlo: mensaje cariñoso a alguien lejos. Ej.: → Ik denk de hele dag aan jou (pienso en ti todo el día).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pienso en ti todo el día' AND notes = 'Preposición fija: denken aan');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'pienso en ti todo el día' AND notes = 'Preposición fija: denken aan' LIMIT 1),
    'nl_NL', 'Ik denk de hele dag aan jou.', 'Ik denk de ele daj an yau.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pienso en ti todo el día' AND notes = 'Preposición fija: denken aan' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos con preposición fija - vaste voorzetsels'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pienso en ti todo el día' AND notes = 'Preposición fija: denken aan' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- wachten op (mij) + maar even: Wacht maar even op mij!
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'espérame un momentito', 'PHRASE', 'Preposición fija: wachten op', 'wachten op = esperar (a). wachten rige op; el complemento es objeto de op → op mij.

Verbos con preposición fija (vaste voorzetsels): la preposición la manda el VERBO, no el pronombre — se aprende con cada verbo (como en español pensar EN, contar CON, depender DE). El complemento es objeto de esa preposición.
• Tras preposición el pronombre va en forma TÓNICA: aan mij, op jou, naar hem, van haar, in hen (nunca hun tras preposición). Coloquialmente se oye la átona (voor me, op je), pero la plena es lo estándar.
• Trampa del español: la a de "no LOS invité" / "invitar A alguien" es la a personal (marca de objeto), NO una preposición; uitnodigen, zien, kennen, bellen… llevan objeto directo SIN preposición.

📐 Imperativo: verbo en 1ª posición (forma de ik) + resto; sin sujeto.

🧭 Cuándo usarlo: pedir a alguien que te espere un momento. Ej.: → Wacht maar even op mij! (espérame un momentito).

🔤 Orden fijo maar even (nunca even maar): cuando maar y even van juntos, maar SIEMPRE va antes que even — es una colocación fija de partículas. maar suaviza (venga, sin brusquedad) y even = un momento/rápido; juntos = anda, un momentito. Ej.: Kom maar even hier (ven un momento) · Wacht maar even (espera un momento) · Bel haar maar even (llámala un momento).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'espérame un momentito' AND notes = 'Preposición fija: wachten op');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'espérame un momentito' AND notes = 'Preposición fija: wachten op' LIMIT 1),
    'nl_NL', 'Wacht maar even op mij!', 'Uajt mar efen op mei!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'espérame un momentito' AND notes = 'Preposición fija: wachten op' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos con preposición fija - vaste voorzetsels'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'espérame un momentito' AND notes = 'Preposición fija: wachten op' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- luisteren naar (hem): Luister goed naar hem.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'escúchalo bien', 'PHRASE', 'Preposición fija: luisteren naar', 'luisteren naar = escuchar (a). luisteren rige naar → naar hem.

Verbos con preposición fija (vaste voorzetsels): la preposición la manda el VERBO, no el pronombre — se aprende con cada verbo (como en español pensar EN, contar CON, depender DE). El complemento es objeto de esa preposición.
• Tras preposición el pronombre va en forma TÓNICA: aan mij, op jou, naar hem, van haar, in hen (nunca hun tras preposición). Coloquialmente se oye la átona (voor me, op je), pero la plena es lo estándar.
• Trampa del español: la a de "no LOS invité" / "invitar A alguien" es la a personal (marca de objeto), NO una preposición; uitnodigen, zien, kennen, bellen… llevan objeto directo SIN preposición.

📐 Imperativo: verbo en 1ª posición (forma de ik) + resto; sin sujeto.

🧭 Cuándo usarlo: dar un consejo (hazle caso). Ej.: → Luister goed naar hem, hij weet het (escúchalo bien, él sabe).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'escúchalo bien' AND notes = 'Preposición fija: luisteren naar');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'escúchalo bien' AND notes = 'Preposición fija: luisteren naar' LIMIT 1),
    'nl_NL', 'Luister goed naar hem.', 'Lauster jud nar em.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'escúchalo bien' AND notes = 'Preposición fija: luisteren naar' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos con preposición fija - vaste voorzetsels'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'escúchalo bien' AND notes = 'Preposición fija: luisteren naar' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- kijken naar (ons): Iedereen keek naar ons.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'todos nos miraron', 'PHRASE', 'Preposición fija: kijken naar', 'kijken naar = mirar (a) / ver. kijken rige naar → naar ons (ons tiene forma única).

Verbos con preposición fija (vaste voorzetsels): la preposición la manda el VERBO, no el pronombre — se aprende con cada verbo (como en español pensar EN, contar CON, depender DE). El complemento es objeto de esa preposición.
• Tras preposición el pronombre va en forma TÓNICA: aan mij, op jou, naar hem, van haar, in hen (nunca hun tras preposición). Coloquialmente se oye la átona (voor me, op je), pero la plena es lo estándar.
• Trampa del español: la a de "no LOS invité" / "invitar A alguien" es la a personal (marca de objeto), NO una preposición; uitnodigen, zien, kennen, bellen… llevan objeto directo SIN preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto (prep + objeto) al final.

🧭 Cuándo usarlo: contar una situación de vergüenza o protagonismo. Ej.: → Iedereen keek naar ons (todos nos miraron).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'todos nos miraron' AND notes = 'Preposición fija: kijken naar');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'todos nos miraron' AND notes = 'Preposición fija: kijken naar' LIMIT 1),
    'nl_NL', 'Iedereen keek naar ons.', 'Ideren kek nar ons.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'todos nos miraron' AND notes = 'Preposición fija: kijken naar' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos con preposición fija - vaste voorzetsels'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'todos nos miraron' AND notes = 'Preposición fija: kijken naar' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- houden van (jullie): Ik hou van jullie.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'os quiero', 'PHRASE', 'Preposición fija: houden van', 'houden van = querer / gustar. houden rige van → van jullie. Ik hou van je (a secas) es la forma más oída.

Verbos con preposición fija (vaste voorzetsels): la preposición la manda el VERBO, no el pronombre — se aprende con cada verbo (como en español pensar EN, contar CON, depender DE). El complemento es objeto de esa preposición.
• Tras preposición el pronombre va en forma TÓNICA: aan mij, op jou, naar hem, van haar, in hen (nunca hun tras preposición). Coloquialmente se oye la átona (voor me, op je), pero la plena es lo estándar.
• Trampa del español: la a de "no LOS invité" / "invitar A alguien" es la a personal (marca de objeto), NO una preposición; uitnodigen, zien, kennen, bellen… llevan objeto directo SIN preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto (prep + objeto) al final.

🧭 Cuándo usarlo: declaración de cariño a varios (familia, amigos). Ej.: → Ik hou van jullie (os quiero).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'os quiero' AND notes = 'Preposición fija: houden van');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'os quiero' AND notes = 'Preposición fija: houden van' LIMIT 1),
    'nl_NL', 'Ik hou van jullie.', 'Ik au fan yulli.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'os quiero' AND notes = 'Preposición fija: houden van' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos con preposición fija - vaste voorzetsels'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'os quiero' AND notes = 'Preposición fija: houden van' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- rekenen op (u): We rekenen op u.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'contamos con usted', 'PHRASE', 'Preposición fija: rekenen op', 'rekenen op = contar con. rekenen rige op → op u (forma formal). Frase muy usada para expresar confianza.

Verbos con preposición fija (vaste voorzetsels): la preposición la manda el VERBO, no el pronombre — se aprende con cada verbo (como en español pensar EN, contar CON, depender DE). El complemento es objeto de esa preposición.
• Tras preposición el pronombre va en forma TÓNICA: aan mij, op jou, naar hem, van haar, in hen (nunca hun tras preposición). Coloquialmente se oye la átona (voor me, op je), pero la plena es lo estándar.
• Trampa del español: la a de "no LOS invité" / "invitar A alguien" es la a personal (marca de objeto), NO una preposición; uitnodigen, zien, kennen, bellen… llevan objeto directo SIN preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto (prep + objeto) al final.

🧭 Cuándo usarlo: expresar confianza en alguien (trabajo, favores). Ej.: → We rekenen op u (contamos con usted). Tuteo: Ik reken op jou!'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'contamos con usted' AND notes = 'Preposición fija: rekenen op');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'contamos con usted' AND notes = 'Preposición fija: rekenen op' LIMIT 1),
    'nl_NL', 'We rekenen op u.', 'Ue rekenen op u.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'contamos con usted' AND notes = 'Preposición fija: rekenen op' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos con preposición fija - vaste voorzetsels'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'contamos con usted' AND notes = 'Preposición fija: rekenen op' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- vragen naar (haar): De buurvrouw vroeg naar haar.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la vecina preguntó por ella', 'PHRASE', 'Preposición fija: vragen naar', 'vragen naar = preguntar POR (interesarse). vragen rige naar → naar haar. (vragen om = pedir algo; vragen aan = preguntar a alguien).

Verbos con preposición fija (vaste voorzetsels): la preposición la manda el VERBO, no el pronombre — se aprende con cada verbo (como en español pensar EN, contar CON, depender DE). El complemento es objeto de esa preposición.
• Tras preposición el pronombre va en forma TÓNICA: aan mij, op jou, naar hem, van haar, in hen (nunca hun tras preposición). Coloquialmente se oye la átona (voor me, op je), pero la plena es lo estándar.
• Trampa del español: la a de "no LOS invité" / "invitar A alguien" es la a personal (marca de objeto), NO una preposición; uitnodigen, zien, kennen, bellen… llevan objeto directo SIN preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto (prep + objeto) al final.

🧭 Cuándo usarlo: contar que alguien se interesó por otra persona. Ej.: → De buurvrouw vroeg naar haar (la vecina preguntó por ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la vecina preguntó por ella' AND notes = 'Preposición fija: vragen naar');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'la vecina preguntó por ella' AND notes = 'Preposición fija: vragen naar' LIMIT 1),
    'nl_NL', 'De buurvrouw vroeg naar haar.', 'De burfrauu fruj nar ar.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la vecina preguntó por ella' AND notes = 'Preposición fija: vragen naar' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos con preposición fija - vaste voorzetsels'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la vecina preguntó por ella' AND notes = 'Preposición fija: vragen naar' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- geloven in (hen): Ik geloof in hen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'creo en ellos', 'PHRASE', 'Preposición fija: geloven in', 'geloven in = creer EN (confiar). geloven rige in → in hen (tras preposición SIEMPRE hen, nunca hun; coloquial ze).

Verbos con preposición fija (vaste voorzetsels): la preposición la manda el VERBO, no el pronombre — se aprende con cada verbo (como en español pensar EN, contar CON, depender DE). El complemento es objeto de esa preposición.
• Tras preposición el pronombre va en forma TÓNICA: aan mij, op jou, naar hem, van haar, in hen (nunca hun tras preposición). Coloquialmente se oye la átona (voor me, op je), pero la plena es lo estándar.
• Trampa del español: la a de "no LOS invité" / "invitar A alguien" es la a personal (marca de objeto), NO una preposición; uitnodigen, zien, kennen, bellen… llevan objeto directo SIN preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto (prep + objeto) al final.

🧭 Cuándo usarlo: dar ánimo o expresar fe en un equipo/personas. Ej.: → Ik geloof in hen, ze gaan het redden (creo en ellos, lo van a lograr).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'creo en ellos' AND notes = 'Preposición fija: geloven in');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'creo en ellos' AND notes = 'Preposición fija: geloven in' LIMIT 1),
    'nl_NL', 'Ik geloof in hen.', 'Ik jelof in en.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'creo en ellos' AND notes = 'Preposición fija: geloven in' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos con preposición fija - vaste voorzetsels'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'creo en ellos' AND notes = 'Preposición fija: geloven in' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- praten met (jou): Ik wil even met jou praten.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'quiero hablar un momento contigo', 'PHRASE', 'Preposición fija: praten met', 'praten met = hablar CON. praten rige met (o over = hablar de algo) → met jou. Con modal (wil), praten va al final.

Verbos con preposición fija (vaste voorzetsels): la preposición la manda el VERBO, no el pronombre — se aprende con cada verbo (como en español pensar EN, contar CON, depender DE). El complemento es objeto de esa preposición.
• Tras preposición el pronombre va en forma TÓNICA: aan mij, op jou, naar hem, van haar, in hen (nunca hun tras preposición). Coloquialmente se oye la átona (voor me, op je), pero la plena es lo estándar.
• Trampa del español: la a de "no LOS invité" / "invitar A alguien" es la a personal (marca de objeto), NO una preposición; uitnodigen, zien, kennen, bellen… llevan objeto directo SIN preposición.

📐 Oración principal (hoofdzin) con modal: sujeto + wil (2ª posición) + resto + praten (infinitivo) al final.

🧭 Cuándo usarlo: pedir una conversación (a veces seria). Ej.: → Ik wil even met jou praten (quiero hablar un momento contigo).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'quiero hablar un momento contigo' AND notes = 'Preposición fija: praten met');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'quiero hablar un momento contigo' AND notes = 'Preposición fija: praten met' LIMIT 1),
    'nl_NL', 'Ik wil even met jou praten.', 'Ik uil efen met yau praten.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'quiero hablar un momento contigo' AND notes = 'Preposición fija: praten met' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos con preposición fija - vaste voorzetsels'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'quiero hablar un momento contigo' AND notes = 'Preposición fija: praten met' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- lachen om (mij): Waarom lachen jullie om mij?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿por qué os reís de mí?', 'PHRASE', 'Preposición fija: lachen om', 'lachen om = reírse DE. lachen rige om → om mij. (uitlachen iemand = burlarse de alguien, ese lleva objeto directo).

Verbos con preposición fija (vaste voorzetsels): la preposición la manda el VERBO, no el pronombre — se aprende con cada verbo (como en español pensar EN, contar CON, depender DE). El complemento es objeto de esa preposición.
• Tras preposición el pronombre va en forma TÓNICA: aan mij, op jou, naar hem, van haar, in hen (nunca hun tras preposición). Coloquialmente se oye la átona (voor me, op je), pero la plena es lo estándar.
• Trampa del español: la a de "no LOS invité" / "invitar A alguien" es la a personal (marca de objeto), NO una preposición; uitnodigen, zien, kennen, bellen… llevan objeto directo SIN preposición.

📐 Pregunta con interrogativo (W-vraag): palabra-W + verbo conjugado + sujeto + resto (prep + objeto) al final.

🧭 Cuándo usarlo: reprochar burlas. Ej.: → Waarom lachen jullie om mij? (¿por qué os reís de mí?).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿por qué os reís de mí?' AND notes = 'Preposición fija: lachen om');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿por qué os reís de mí?' AND notes = 'Preposición fija: lachen om' LIMIT 1),
    'nl_NL', 'Waarom lachen jullie om mij?', 'Uarom lajen yulli om mei?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿por qué os reís de mí?' AND notes = 'Preposición fija: lachen om' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos con preposición fija - vaste voorzetsels'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿por qué os reís de mí?' AND notes = 'Preposición fija: lachen om' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- trots zijn op (jou): Ik ben trots op jou!
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¡estoy orgulloso de ti!', 'PHRASE', 'Preposición fija: trots zijn op', 'trots zijn op = estar orgulloso DE. Es adjetivo + preposición fija (misma lógica que los verbos) → op jou.

Verbos con preposición fija (vaste voorzetsels): la preposición la manda el VERBO o adjetivo, no el pronombre — se aprende con cada uno (como en español pensar EN, contar CON, depender DE). El complemento es objeto de esa preposición.
• Tras preposición el pronombre va en forma TÓNICA: aan mij, op jou, naar hem, van haar, in hen (nunca hun tras preposición). Coloquialmente se oye la átona (voor me, op je), pero la plena es lo estándar.
• Trampa del español: la a de "no LOS invité" / "invitar A alguien" es la a personal (marca de objeto), NO una preposición; uitnodigen, zien, kennen, bellen… llevan objeto directo SIN preposición.

📐 Oración principal (hoofdzin): sujeto + ben (2ª posición) + trots + op jou.

🧭 Cuándo usarlo: felicitar/animar a alguien por un logro. Ej.: → Ik ben zo trots op jou! (¡estoy muy orgulloso de ti!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡estoy orgulloso de ti!' AND notes = 'Preposición fija: trots zijn op');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¡estoy orgulloso de ti!' AND notes = 'Preposición fija: trots zijn op' LIMIT 1),
    'nl_NL', 'Ik ben trots op jou!', 'Ik ben trots op yau!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡estoy orgulloso de ti!' AND notes = 'Preposición fija: trots zijn op' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos con preposición fija - vaste voorzetsels'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¡estoy orgulloso de ti!' AND notes = 'Preposición fija: trots zijn op' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- boos zijn op (mij): Ben je boos op mij?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿estás enfadado conmigo?', 'PHRASE', 'Preposición fija: boos zijn op', 'boos zijn op = estar enfadado CON. Adjetivo + preposición fija → op mij (ojo: en español es "con", en neerlandés op).

Verbos con preposición fija (vaste voorzetsels): la preposición la manda el VERBO o adjetivo, no el pronombre — se aprende con cada uno (como en español pensar EN, contar CON, depender DE). El complemento es objeto de esa preposición.
• Tras preposición el pronombre va en forma TÓNICA: aan mij, op jou, naar hem, van haar, in hen (nunca hun tras preposición). Coloquialmente se oye la átona (voor me, op je), pero la plena es lo estándar.
• Trampa del español: la a de "no LOS invité" / "invitar A alguien" es la a personal (marca de objeto), NO una preposición; uitnodigen, zien, kennen, bellen… llevan objeto directo SIN preposición.

📐 Pregunta sí/no (ja/nee-vraag): verbo conjugado en 1ª posición + sujeto + resto (prep + objeto) al final.

🧭 Cuándo usarlo: tantear si alguien se ha molestado contigo. Ej.: → Ben je boos op mij? (¿estás enfadado conmigo?).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿estás enfadado conmigo?' AND notes = 'Preposición fija: boos zijn op');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿estás enfadado conmigo?' AND notes = 'Preposición fija: boos zijn op' LIMIT 1),
    'nl_NL', 'Ben je boos op mij?', 'Ben ye bos op mei?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿estás enfadado conmigo?' AND notes = 'Preposición fija: boos zijn op' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos con preposición fija - vaste voorzetsels'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿estás enfadado conmigo?' AND notes = 'Preposición fija: boos zijn op' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- dromen van (hem): Ze droomt nog steeds van hem.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'todavía sueña con él', 'PHRASE', 'Preposición fija: dromen van', 'dromen van = soñar CON. dromen rige van → van hem (ojo: español "con", neerlandés van). También dromen over.

Verbos con preposición fija (vaste voorzetsels): la preposición la manda el VERBO, no el pronombre — se aprende con cada verbo (como en español pensar EN, contar CON, depender DE). El complemento es objeto de esa preposición.
• Tras preposición el pronombre va en forma TÓNICA: aan mij, op jou, naar hem, van haar, in hen (nunca hun tras preposición). Coloquialmente se oye la átona (voor me, op je), pero la plena es lo estándar.
• Trampa del español: la a de "no LOS invité" / "invitar A alguien" es la a personal (marca de objeto), NO una preposición; uitnodigen, zien, kennen, bellen… llevan objeto directo SIN preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto (prep + objeto) al final.

🧭 Cuándo usarlo: hablar de un recuerdo persistente o de amor. Ej.: → Ze droomt nog steeds van hem (todavía sueña con él).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'todavía sueña con él' AND notes = 'Preposición fija: dromen van');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'todavía sueña con él' AND notes = 'Preposición fija: dromen van' LIMIT 1),
    'nl_NL', 'Ze droomt nog steeds van hem.', 'Se dromt noj steds fan em.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'todavía sueña con él' AND notes = 'Preposición fija: dromen van' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'verbos con preposición fija - vaste voorzetsels'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'todavía sueña con él' AND notes = 'Preposición fija: dromen van' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- UPDATE: añade el bloque 🔤 maar even a la tarjeta existente "Bel haar maar even"
-- (grupo pronombres) — la frase que originó la duda. Corre tras 20260713000004.
-- ==============================================================================
UPDATE words_es SET rules_help = rules_help || '

🔤 Orden fijo maar even (nunca even maar): cuando maar y even van juntos, maar SIEMPRE va antes que even — es una colocación fija de partículas. maar suaviza la orden (venga, sin brusquedad) y even = un momento/rápido; juntos = anda, un momentito. Ej.: Kom maar even hier (ven un momento) · Wacht maar even (espera un momento).'
WHERE notes = 'Pronombre objeto: haar' AND text = 'llámala un momento, anda' AND rules_help NOT LIKE '%🔤%';
