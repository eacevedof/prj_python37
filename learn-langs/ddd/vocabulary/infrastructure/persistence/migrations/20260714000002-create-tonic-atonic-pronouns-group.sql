-- Learn Languages App - Grupo "pronombres átono/tónico - mij of me"
-- Migration: 20260714000002-create-tonic-atonic-pronouns-group.sql
-- Description: 13 frases cotidianas para reforzar la forma ÁTONA (reducida) vs TÓNICA (plena)
--   de los pronombres de objeto, respondiendo a "¿por qué unas veces mij y otras me?":
--   átona (me/je/ze/’m/’r) para el habla normal; tónica (mij/jou/hem/haar/hen/hun) para
--   énfasis/contraste y SIEMPRE tras preposición. Cubre ik, jij, hij, zij, wij, u, jullie
--   y refuerza el trío ze/hen/hun (directo/indirecto). Pronombres variados, frases
--   distintas a las del grupo "pronombres - voornaamwoorden".
--   Nota técnica: las formas reducidas ’m/’r usan apóstrofo tipográfico (’, U+2019), no el
--   apóstrofo recto, para no interferir con el delimitador de cadena SQL.
--   rules_help = nota del pronombre + regla átono/tónico + fórmula + 🧭 ejemplo.
--   Pronunciation con DutchToSpanishPhoneticService. 100% aditiva e IDEMPOTENTE
--   (INSERT ... WHERE NOT EXISTS / OR IGNORE): no toca audios ni imágenes existentes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'pronombres átono/tónico - mij of me',
    'Refuerzo de las formas átona vs tónica de los pronombres de objeto (por qué mij o me): reducida (me/je/ze/’m/’r) para el habla normal y plena (mij/jou/hem/haar/hen/hun) para énfasis o tras preposición; con je, hij, u, jullie y el trío ze/hen/hun (directo/indirecto)',
    'migracion'
);

-- ==============================================================================
-- me (ik átono): Kun je me even helpen?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿me echas una mano?', 'PHRASE', 'Átono/tónico: me (ik átono)', 'me = forma ÁTONA de 1ª persona (me/a mí), la normal en el día a día. even suaviza (un momento).

Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.

📐 Pregunta sí/no (ja/nee-vraag): verbo conjugado en 1ª posición + sujeto + resto; los demás verbos al final.

🧭 Cuándo usarlo: pedir ayuda con naturalidad. Ej.: cargas bolsas → Kun je me even helpen? (¿me echas una mano?).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿me echas una mano?' AND notes = 'Átono/tónico: me (ik átono)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿me echas una mano?' AND notes = 'Átono/tónico: me (ik átono)' LIMIT 1),
    'nl_NL', 'Kun je me even helpen?', 'Kun ye me efen elpen?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿me echas una mano?' AND notes = 'Átono/tónico: me (ik átono)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronombres átono/tónico - mij of me'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿me echas una mano?' AND notes = 'Átono/tónico: me (ik átono)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- mij (ik tónico): Geef het maar aan mij.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'dámelo a mí', 'PHRASE', 'Átono/tónico: mij (ik tónico)', 'mij = forma TÓNICA de 1ª persona; aquí obligatoria por ir tras la preposición aan, y además recalca a MÍ (frente a otros).

Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.

📐 Imperativo: verbo en 1ª posición (forma de ik) + resto; sin sujeto.

🧭 Cuándo usarlo: reclamar algo para ti o repartir tareas. Ej.: → Geef het maar aan mij, ik regel het (dámelo a mí, yo me ocupo).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'dámelo a mí' AND notes = 'Átono/tónico: mij (ik tónico)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'dámelo a mí' AND notes = 'Átono/tónico: mij (ik tónico)' LIMIT 1),
    'nl_NL', 'Geef het maar aan mij.', 'Jef et mar an mei.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'dámelo a mí' AND notes = 'Átono/tónico: mij (ik tónico)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronombres átono/tónico - mij of me'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'dámelo a mí' AND notes = 'Átono/tónico: mij (ik tónico)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- je (jij átono): Ik bel je straks.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'te llamo luego', 'PHRASE', 'Átono/tónico: je (jij átono)', 'je = forma ÁTONA de tú (te), lo normal. straks = luego / en un rato.

Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.

🧭 Cuándo usarlo: quedar en llamar. Ej.: → Ik bel je straks, oké? (te llamo luego, ¿vale?).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'te llamo luego' AND notes = 'Átono/tónico: je (jij átono)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'te llamo luego' AND notes = 'Átono/tónico: je (jij átono)' LIMIT 1),
    'nl_NL', 'Ik bel je straks.', 'Ik bel ye straks.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'te llamo luego' AND notes = 'Átono/tónico: je (jij átono)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronombres átono/tónico - mij of me'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'te llamo luego' AND notes = 'Átono/tónico: je (jij átono)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- jou (jij tónico): Dit is voor jou.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'esto es para ti', 'PHRASE', 'Átono/tónico: jou (jij tónico)', 'jou = forma TÓNICA de tú; obligatoria tras preposición (voor jou) y para contraste (a TI).

Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.

🧭 Cuándo usarlo: dar un regalo o algo a alguien. Ej.: → Dit is voor jou! (¡esto es para ti!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'esto es para ti' AND notes = 'Átono/tónico: jou (jij tónico)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'esto es para ti' AND notes = 'Átono/tónico: jou (jij tónico)' LIMIT 1),
    'nl_NL', 'Dit is voor jou.', 'Dit is for yau.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'esto es para ti' AND notes = 'Átono/tónico: jou (jij tónico)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronombres átono/tónico - mij of me'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'esto es para ti' AND notes = 'Átono/tónico: jou (jij tónico)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- hem (hij tras preposición): Ik heb het aan hem gegeven.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'se lo he dado a él', 'PHRASE', 'Átono/tónico: hem (hij tras preposición)', 'hem = objeto de él; tras preposición (aan hem) va siempre en forma plena hem. En el habla, como objeto directo, se reduce a ’m (Ik zie ’m).

Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.

🧭 Cuándo usarlo: aclarar a quién le diste algo. Ej.: → Ik heb het aan hem gegeven, niet aan haar (se lo he dado a él, no a ella).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'se lo he dado a él' AND notes = 'Átono/tónico: hem (hij tras preposición)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'se lo he dado a él' AND notes = 'Átono/tónico: hem (hij tras preposición)' LIMIT 1),
    'nl_NL', 'Ik heb het aan hem gegeven.', 'Ik eb et an em jejefen.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se lo he dado a él' AND notes = 'Átono/tónico: hem (hij tras preposición)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronombres átono/tónico - mij of me'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'se lo he dado a él' AND notes = 'Átono/tónico: hem (hij tras preposición)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- hem (hij directo): Ik vertrouw hem niet.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'no me fío de él', 'PHRASE', 'Átono/tónico: hem (hij directo)', 'hem = objeto directo (lo/le, él). Coloquial reducido: ’m (Ik vertrouw ’m niet). vertrouwen = fiarse de.

Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.

🧭 Cuándo usarlo: expresar desconfianza. Ej.: → Ik vertrouw hem niet, wees voorzichtig (no me fío de él, ten cuidado).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no me fío de él' AND notes = 'Átono/tónico: hem (hij directo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'no me fío de él' AND notes = 'Átono/tónico: hem (hij directo)' LIMIT 1),
    'nl_NL', 'Ik vertrouw hem niet.', 'Ik fertrauu em nit.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no me fío de él' AND notes = 'Átono/tónico: hem (hij directo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronombres átono/tónico - mij of me'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'no me fío de él' AND notes = 'Átono/tónico: hem (hij directo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- haar (zij ella): Ik heb haar net nog gesproken.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'justo he hablado con ella', 'PHRASE', 'Átono/tónico: haar (zij ella)', 'haar = objeto de ella (la/le); también su (posesivo). Forma reducida coloquial: ’r / d’r. net nog = justo hace nada.

Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.

🧭 Cuándo usarlo: decir que acabas de hablar con ella. Ej.: → Ik heb haar net nog gesproken (justo he hablado con ella hace nada).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'justo he hablado con ella' AND notes = 'Átono/tónico: haar (zij ella)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'justo he hablado con ella' AND notes = 'Átono/tónico: haar (zij ella)' LIMIT 1),
    'nl_NL', 'Ik heb haar net nog gesproken.', 'Ik eb ar net noj jesproken.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'justo he hablado con ella' AND notes = 'Átono/tónico: haar (zij ella)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronombres átono/tónico - mij of me'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'justo he hablado con ella' AND notes = 'Átono/tónico: haar (zij ella)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- ons (wij): Hij heeft ons uitgenodigd.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'nos ha invitado', 'PHRASE', 'Átono/tónico: ons (wij)', 'ons = objeto de nosotros (nos); tiene UNA sola forma, no se reduce ni cambia. También nuestro (posesivo: ons huis).

Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.

🧭 Cuándo usarlo: contar que os invitaron. Ej.: → Hij heeft ons uitgenodigd voor het feest (nos ha invitado a la fiesta).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'nos ha invitado' AND notes = 'Átono/tónico: ons (wij)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'nos ha invitado' AND notes = 'Átono/tónico: ons (wij)' LIMIT 1),
    'nl_NL', 'Hij heeft ons uitgenodigd.', 'Ei eft ons autjenodijd.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'nos ha invitado' AND notes = 'Átono/tónico: ons (wij)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronombres átono/tónico - mij of me'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'nos ha invitado' AND notes = 'Átono/tónico: ons (wij)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- u (formal): Wat kan ik voor u doen?
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT '¿qué puedo hacer por usted?', 'PHRASE', 'Átono/tónico: u (formal)', 'u = usted, trato formal; una sola forma para sujeto y objeto, NO se reduce ni tiene variante tónica. Aquí va tras preposición (voor u).

Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.

📐 Pregunta con interrogativo (W-vraag): palabra-W + verbo conjugado + sujeto + resto; los demás verbos al final.

🧭 Cuándo usarlo: atención al público, formal. Ej.: → Goedemiddag, wat kan ik voor u doen? (buenas, ¿qué puedo hacer por usted?).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿qué puedo hacer por usted?' AND notes = 'Átono/tónico: u (formal)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = '¿qué puedo hacer por usted?' AND notes = 'Átono/tónico: u (formal)' LIMIT 1),
    'nl_NL', 'Wat kan ik voor u doen?', 'Uat kan ik for u dun?');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿qué puedo hacer por usted?' AND notes = 'Átono/tónico: u (formal)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronombres átono/tónico - mij of me'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = '¿qué puedo hacer por usted?' AND notes = 'Átono/tónico: u (formal)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- jullie (plural): Ik heb jullie gemist.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'os he echado de menos', 'PHRASE', 'Átono/tónico: jullie (plural)', 'jullie = os / vosotros (objeto); forma única (la reducida je es rara y coloquial). También vuestro (posesivo: jullie huis).

Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.

🧭 Cuándo usarlo: reencuentro con amigos. Ej.: → Ik heb jullie gemist! (¡os he echado de menos!).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'os he echado de menos' AND notes = 'Átono/tónico: jullie (plural)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'os he echado de menos' AND notes = 'Átono/tónico: jullie (plural)' LIMIT 1),
    'nl_NL', 'Ik heb jullie gemist.', 'Ik eb yulli jemist.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'os he echado de menos' AND notes = 'Átono/tónico: jullie (plural)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronombres átono/tónico - mij of me'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'os he echado de menos' AND notes = 'Átono/tónico: jullie (plural)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- ze (zij pl directo, átono): Ik zie ze bijna elke dag.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'los veo casi a diario', 'PHRASE', 'Átono/tónico: ze (zij pl directo)', 'ze = forma ÁTONA comodín para ellos/ellas (personas y cosas), directo e indirecto; lo normal al hablar. No se acentúa; para enfatizar usa hen/hun.

Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.

🧭 Cuándo usarlo: hablar de gente que ves a menudo. Ej.: → Mijn buren? Ik zie ze bijna elke dag (¿mis vecinos? los veo casi a diario).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'los veo casi a diario' AND notes = 'Átono/tónico: ze (zij pl directo)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'los veo casi a diario' AND notes = 'Átono/tónico: ze (zij pl directo)' LIMIT 1),
    'nl_NL', 'Ik zie ze bijna elke dag.', 'Ik si se beina elke daj.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los veo casi a diario' AND notes = 'Átono/tónico: ze (zij pl directo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronombres átono/tónico - mij of me'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'los veo casi a diario' AND notes = 'Átono/tónico: ze (zij pl directo)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- hen (zij pl tras preposición): Ik denk vaak aan hen.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'pienso mucho en ellos', 'PHRASE', 'Átono/tónico: hen (zij pl tras preposición)', 'hen = forma plena; obligatoria tras preposición (aan hen) y como objeto directo formal (los). Aquí denken aan → hen (no ze).

Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.

🧭 Cuándo usarlo: hablar de seres queridos que están lejos. Ej.: → Ik denk vaak aan hen (pienso mucho en ellos).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'pienso mucho en ellos' AND notes = 'Átono/tónico: hen (zij pl tras preposición)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'pienso mucho en ellos' AND notes = 'Átono/tónico: hen (zij pl tras preposición)' LIMIT 1),
    'nl_NL', 'Ik denk vaak aan hen.', 'Ik denk fak an en.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pienso mucho en ellos' AND notes = 'Átono/tónico: hen (zij pl tras preposición)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronombres átono/tónico - mij of me'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'pienso mucho en ellos' AND notes = 'Átono/tónico: hen (zij pl tras preposición)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ==============================================================================
-- hun (zij pl indirecto): Ik heb hun een kaartje gestuurd.
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'les mandé una postal', 'PHRASE', 'Átono/tónico: hun (zij pl indirecto)', 'hun = objeto INDIRECTO de personas (les, a ellos), sin preposición — iets sturen aan iemand. Coloquial: ze. El directo (los) es hen. Ojo: hun como SUJETO (hun hebben…) está mal.

Átono vs tónico: casi todos los pronombres de objeto tienen dos formas.
• átona (reducida) — la normal al hablar, no se acentúa: me, je, ’m, ’r, ze.
• tónica (plena) — para ÉNFASIS/contraste y SIEMPRE tras preposición (aan, voor, met, op…): mij, jou, hem, haar, hen/hun.
Paradigma: ik→me/mij · jij→je/jou · hij→(’m)/hem · zij ella→(’r)/haar · u→u · wij→ons · jullie→jullie · zij pl→ze / hen (directo) / hun (indirecto). u, ons y jullie no tienen forma reducida.
Regla práctica: por defecto la átona; usa la tónica para recalcar (a MÍ, a TI) o detrás de preposición.

📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.

🧭 Cuándo usarlo: contar un detalle que tuviste con alguien. Ej.: → Ik heb hun een kaartje gestuurd (les mandé una postal).'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'les mandé una postal' AND notes = 'Átono/tónico: hun (zij pl indirecto)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'les mandé una postal' AND notes = 'Átono/tónico: hun (zij pl indirecto)' LIMIT 1),
    'nl_NL', 'Ik heb hun een kaartje gestuurd.', 'Ik eb un en kartye jesturd.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'les mandé una postal' AND notes = 'Átono/tónico: hun (zij pl indirecto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronombres átono/tónico - mij of me'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'les mandé una postal' AND notes = 'Átono/tónico: hun (zij pl indirecto)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
