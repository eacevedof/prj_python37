-- Learn Languages App - Grupo "er" y todas sus variantes
-- Migration: 20260707000001-create-er-group.sql
-- Description: Crea el grupo "er" con 12 entradas que cubren las cuatro vidas
--   de er: existencial (er is/zijn = hay), locativo atono (= alli/aqui),
--   cantidad (ik heb er drie), preposicional (ervan/erin/eraan/ermee) y el
--   pasivo impersonal (er wordt...), mas expresiones cotidianas de altisima
--   frecuencia (wat is er, ik heb er zin in, ik kan er niets aan doen...).
--   Incluye rules_help por entrada. Idempotente. No toca ids existentes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'er',
    'Las cuatro vidas de er: existencial (er is/zijn = hay), locativo (alli atono), cantidad (ik heb er drie), preposicional (ervan/erin/eraan/ermee) y pasivo impersonal (er wordt...), con las expresiones diarias mas usadas',
    'migracion'
);

-- ==============================================================================
-- 2. PALABRAS EN ESPAÑOL (solo si no existen)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes)
SELECT 'hay', 'PHRASE', 'er existencial: er is / er zijn'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'hay');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿qué pasa?', 'PHRASE', 'wat is er: existencial en pregunta'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿qué pasa?');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿qué está pasando?', 'PHRASE', 'wat is er aan de hand: frase hecha'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿qué está pasando?');

INSERT INTO words_es (text, word_type, notes)
SELECT 'ya estoy aquí', 'PHRASE', 'ik ben er: presencia/llegada'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'ya estoy aquí');

INSERT INTO words_es (text, word_type, notes)
SELECT 'nunca he estado allí', 'PHRASE', 'er locativo atono'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'nunca he estado allí');

INSERT INTO words_es (text, word_type, notes)
SELECT 'tengo tres (de esos)', 'PHRASE', 'er de cantidad'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'tengo tres (de esos)');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿qué te parece?', 'PHRASE', 'wat vind je ervan: er+van'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿qué te parece?');

INSERT INTO words_es (text, word_type, notes)
SELECT '¡qué ganas!', 'PHRASE', 'ik heb er zin in: er+in'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡qué ganas!');

INSERT INTO words_es (text, word_type, notes)
SELECT 'no puedo hacer nada', 'PHRASE', 'ik kan er niets aan doen: er+aan'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'no puedo hacer nada');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿cómo te va?', 'PHRASE', 'hoe gaat het ermee: er+mee'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿cómo te va?');

INSERT INTO words_es (text, word_type, notes)
SELECT 'llaman a la puerta', 'PHRASE', 'er wordt...: pasivo impersonal'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'llaman a la puerta');

INSERT INTO words_es (text, word_type, notes)
SELECT '¡a por ello!', 'PHRASE', 'we gaan ertegenaan: motivacional'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¡a por ello!');

-- ==============================================================================
-- 3. TRADUCCIONES + 5 EJEMPLOS
-- ==============================================================================

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'hay'),
    'nl_NL',
    'er is, er zijn',
    '• [can.] Er is koffie in de keuken. — Hay café en la cocina.
• [can.] Er zijn veel fietsen in Amsterdam. — Hay muchas bicis en Ámsterdam.
• [vraag] Is er nog melk? — ¿Queda leche?
• [inv.] Vanavond is er een feestje bij de buren. — Esta noche hay fiesta en casa de los vecinos.
• [bijzin] Ik blijf thuis, omdat er storm is. — Me quedo en casa porque hay tormenta.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿qué pasa?'),
    'nl_NL',
    'wat is er?',
    '• [vraag] Wat is er? — ¿Qué pasa?
• [vraag] Wat is er met jou? — ¿Qué te pasa a ti?
• [vraag] Is er iets? — ¿Pasa algo?
• [can.] Er is niets, hoor. — No pasa nada, tranquilo.
• [bijzin] Vertel me wat er is. — Cuéntame qué pasa.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿qué está pasando?'),
    'nl_NL',
    'wat is er aan de hand?',
    '• [vraag] Wat is er aan de hand? — ¿Qué está pasando?
• [vraag] Wat is er hier aan de hand? — ¿Qué pasa aquí?
• [can.] Er is niets aan de hand. — No pasa nada, todo en orden.
• [inv.] Buiten is er iets aan de hand. — Fuera está pasando algo.
• [bijzin] Ik weet niet wat er aan de hand is. — No sé qué está pasando.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'ya estoy aquí'),
    'nl_NL',
    'ik ben er',
    '• [can.] Ik ben er! — ¡Ya estoy aquí!
• [can.] De taxi is er. — El taxi ya está aquí.
• [vraag] Is iedereen er? — ¿Están todos?
• [perf.] Ben je er al? Ik ben er net. — ¿Ya has llegado? Acabo de llegar.
• [uitdr.] Ik ben er bijna! — ¡Ya casi llego!'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'nunca he estado allí'),
    'nl_NL',
    'ik ben er nooit geweest',
    '• [can.] Ik ben er nooit geweest. — Nunca he estado allí.
• [vraag] Ben je er weleens geweest? — ¿Has estado allí alguna vez?
• [can.] Ik kom er vaak. — Voy mucho por allí.
• [inv.] Vroeger woonde ik er. — Antes vivía allí.
• [bijzin] Ze zegt dat het er mooi is. — Dice que allí es bonito.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'tengo tres (de esos)'),
    'nl_NL',
    'ik heb er drie',
    '• [can.] Ik heb er drie. — Tengo tres (de esos).
• [vraag] Hoeveel heb je er? — ¿Cuántos tienes?
• [can.] Ik wil er nog een. — Quiero otro más.
• [can.] We hebben er geen meer. — Ya no nos quedan.
• [bijzin] Hij vroeg hoeveel ik er nog had. — Preguntó cuántos me quedaban.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿qué te parece?'),
    'nl_NL',
    'wat vind je ervan?',
    '• [vraag] Wat vind je ervan? — ¿Qué te parece?
• [vraag] Wat vond je van de film? — ¿Qué te pareció la peli? (con sustantivo: van + cosa)
• [can.] Ik vind er niets aan. — No le veo la gracia (frase hecha).
• [can.] Ik weet er niets van. — No sé nada de eso.
• [bijzin] Zeg eens wat je ervan vindt. — Di qué te parece.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¡qué ganas!'),
    'nl_NL',
    'ik heb er zin in',
    '• [can.] Ik heb er zin in! — ¡Qué ganas tengo!
• [vraag] Heb je er zin in? — ¿Tienes ganas?
• [can.] Ik heb er geen zin in. — No me apetece nada.
• [can.] Ik heb zin in koffie. — Me apetece un café (con sustantivo: zin in + cosa).
• [bijzin] Ze zei dat ze er echt zin in had. — Dijo que tenía muchísimas ganas.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'no puedo hacer nada'),
    'nl_NL',
    'ik kan er niets aan doen',
    '• [can.] Ik kan er niets aan doen. — No puedo hacer nada / no es culpa mía.
• [vraag] Kun je er iets aan doen? — ¿Puedes hacer algo al respecto?
• [can.] Daar kan ik niets aan doen. — Eso no está en mi mano (enfático con daar).
• [can.] We moeten er iets aan doen. — Tenemos que hacer algo al respecto.
• [bijzin] Hij zegt dat hij er niets aan kan doen. — Dice que no es culpa suya.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿cómo te va?'),
    'nl_NL',
    'hoe gaat het ermee?',
    '• [vraag] Hoe gaat het ermee? — ¿Cómo te va?
• [vraag] Hoe staat het ermee? — ¿Cómo va eso? (el estado de un asunto)
• [can.] Het gaat er goed mee. — Va bien la cosa.
• [can.] Ik ben er druk mee bezig. — Estoy muy liado con ello.
• [bijzin] Ze vroeg hoe het ermee ging. — Preguntó cómo iba todo.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'llaman a la puerta'),
    'nl_NL',
    'er wordt aangebeld',
    '• [can.] Er wordt aangebeld. — Llaman a la puerta (el timbre).
• [can.] Er wordt op de deur geklopt. — Están llamando a la puerta (golpes).
• [can.] Er wordt hier hard gewerkt. — Aquí se trabaja duro.
• [inv.] ''s Avonds wordt er veel gebeld. — Por la noche llama mucha gente.
• [bijzin] Ik hoor dat er wordt aangebeld. — Oigo que llaman a la puerta.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¡a por ello!'),
    'nl_NL',
    'we gaan ertegenaan!',
    '• [uitdr.] We gaan ertegenaan! — ¡A por ello, vamos allá!
• [geb.] Kom op, ga ervoor! — ¡Venga, a por ello! (ergens voor gaan)
• [can.] Ik ga er vol voor. — Voy a por todas.
• [uitdr.] Erop of eronder! — ¡O todo o nada!
• [bijzin] De coach zegt dat we ertegenaan moeten. — El míster dice que hay que darlo todo.'
);

-- ==============================================================================
-- 4. ASOCIAR AL GRUPO "er" (y a "generic")
-- ==============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, (SELECT id FROM word_groups WHERE title = 'er')
FROM words_es we
WHERE we.text IN (
    'hay', '¿qué pasa?', '¿qué está pasando?', 'ya estoy aquí',
    'nunca he estado allí', 'tengo tres (de esos)', '¿qué te parece?',
    '¡qué ganas!', 'no puedo hacer nada', '¿cómo te va?',
    'llaman a la puerta', '¡a por ello!'
);

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, (SELECT id FROM word_groups WHERE title = 'generic')
FROM words_es we
WHERE we.text IN (
    'hay', '¿qué pasa?', '¿qué está pasando?', 'ya estoy aquí',
    'nunca he estado allí', 'tengo tres (de esos)', '¿qué te parece?',
    '¡qué ganas!', 'no puedo hacer nada', '¿cómo te va?',
    'llaman a la puerta', '¡a por ello!'
);

-- ==============================================================================
-- 5. REGLAS DE USO (boton de ayuda del Aprendizaje)
-- ==============================================================================

UPDATE words_es SET rules_help = 'ER EXISTENCIAL = «hay». Con sujeto INDEFINIDO, er es obligatorio:
• Er is koffie. — Hay café. · Er zijn veel mensen. — Hay mucha gente.
Concordancia: er is + singular, er zijn + plural (a diferencia de «hay», invariable).
Sin er la frase se rompe: «hoewel meer verkeer is» ✗ → hoewel ER meer verkeer is ✓.
Con sujeto definido, sin er: Het verkeer is erger.
En pasado: er was / er waren — había.' WHERE text = 'hay';

UPDATE words_es SET rules_help = 'WAT IS ER? = ¿qué pasa? (literal: ¿qué hay?). El er existencial en pregunta.
• Wat is er met jou? — ¿Qué te pasa? (met + persona)
• Is er iets? — ¿Pasa algo? · Er is niets. — No pasa nada.
El «hoor» de «Er is niets, hoor» es partícula tranquilizadora (tranquilo, eh).
En subordinada: Vertel me wat er IS (verbo al final).' WHERE text = '¿qué pasa?';

UPDATE words_es SET rules_help = 'WAT IS ER AAN DE HAND? = ¿qué está pasando? Frase hecha cotidiana
(literal: ¿qué hay en la mano?).
• Er is niets aan de hand. — Todo en orden, no pasa nada.
• Er is iets aan de hand met de auto. — Al coche le pasa algo.
Más intensa que «wat is er?»: sugiere que algo raro está ocurriendo.' WHERE text = '¿qué está pasando?';

UPDATE words_es SET rules_help = 'IK BEN ER = ya estoy aquí / he llegado. ER locativo átono (el lugar del que hablamos).
• De taxi is er. — El taxi ya está. · Is iedereen er? — ¿Están todos?
• Ik ben er bijna! — ¡Casi llego! (también figurado: casi lo tengo)
ER es átono; si quieres énfasis en el lugar usa DAAR/HIER:
Ik ben DAAR nooit — allí no voy nunca (señalando).' WHERE text = 'ya estoy aquí';

UPDATE words_es SET rules_help = 'ER LOCATIVO = «allí» átono, sin énfasis. Es la versión débil de daar:
• Ik ben er nooit geweest. — Nunca he estado (allí).
• Ik kom er vaak. — Voy mucho (por allí). · Het is er mooi. — Allí es bonito.
ER nunca puede llevar énfasis ni ir en primera posición; DAAR sí:
DAAR ben ik nooit geweest! — ¡ALLÍ no he estado nunca!
Regla: sin señalar → er; señalando/contrastando → daar (o hier).' WHERE text = 'nunca he estado allí';

UPDATE words_es SET rules_help = 'ER DE CANTIDAD: obligatorio cuando das un NÚMERO sin repetir el sustantivo:
• Hoeveel fietsen heb je? Ik heb ER drie. — Tengo tres (de esas).
• Ik wil er nog een. — Quiero otro. · We hebben er geen meer. — No quedan.
En español lo omitimos («tengo tres»); en neerlandés el er es imprescindible:
«Ik heb drie» ✗. Funciona con een, geen, veel, genoeg: Ik heb er genoeg.' WHERE text = 'tengo tres (de esos)';

UPDATE words_es SET rules_help = 'ER + PREPOSICIÓN = preposición + «ello» (cosa ya mencionada):
ervan (de ello), erin (en ello), ermee (con ello), eraan (a/en ello), erover...
• Wat vind je ervan? — ¿Qué te parece (eso)?
Con la cosa nombrada, preposición normal: Wat vind je van de film?
Se puede partir: Ik weet ER niets VAN. — No sé nada de eso.
Con énfasis, daar+prep: Wat vind je DAARvan? — ¿Y eso qué te parece?' WHERE text = '¿qué te parece?';

UPDATE words_es SET rules_help = 'ZIN HEBBEN IN = apetecer/tener ganas. Con la cosa dicha: zin in + sustantivo
(Ik heb zin in koffie); si ya se mencionó, ER...IN partido:
• Ik heb ER zin IN! — ¡Qué ganas (de eso)!
• Ik heb er geen zin in. — No me apetece nada (quejica estrella del idioma).
Estructura partida típica: er + [resto] + preposición al final.' WHERE text = '¡qué ganas!';

UPDATE words_es SET rules_help = 'ERGENS IETS AAN (KUNNEN) DOEN = poder hacer algo al respecto:
• Ik kan er niets aan doen. — No puedo hacer nada / no es culpa mía (excusa universal).
• We moeten er iets aan doen. — Hay que hacer algo al respecto.
Con énfasis: DAAR kan ik niets aan doen. — Eso sí que no está en mi mano.
El er sustituye al problema ya mencionado (aan + ello).' WHERE text = 'no puedo hacer nada';

UPDATE words_es SET rules_help = 'HOE GAAT HET ERMEE? = ¿cómo te va? — saludo diario (ermee = met + ello/contigo).
Respuestas: Goed, hoor! · Het gaat wel. (regular) · Druk! (liado)
• Hoe staat het ermee? — ¿Cómo va (el asunto)?
• Ik ben er druk mee bezig. — Estoy a tope con ello (er...mee partido).
Versión corta del saludo: Hoe gaat het? / Hoe is het?' WHERE text = '¿cómo te va?';

UPDATE words_es SET rules_help = 'ER + PASIVO IMPERSONAL: acción sin sujeto conocido («se...», «llaman...»):
• Er wordt aangebeld. — Llaman al timbre. · Er wordt geklopt. — Llaman (golpes).
• Er wordt hard gewerkt. — Se trabaja duro.
Presente: er wordt... · pasado: er werd... · perfecto: er is ge...
(er is ingebroken — han entrado a robar). Siempre verbo en SINGULAR:
er es sujeto vacío, no hay agente.' WHERE text = 'llaman a la puerta';

UPDATE words_es SET rules_help = 'ERGENS TEGENAAN GAAN = ponerse a ello con energía:
• We gaan ertegenaan! — ¡A por ello! (gimnasio, lunes, proyecto...)
Familia motivacional con er/voor:
• Ga ervoor! — ¡A por ello! · Ik ga er vol voor. — Voy a por todas.
• Erop of eronder! — ¡O todo o nada! (frase hecha)
Ojo literal: ergens tegenaan lopen/botsen = chocarse contra algo.' WHERE text = '¡a por ello!';
