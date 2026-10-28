-- Learn Languages App - Grupo "alles-allemaal" y sus variantes
-- Migration: 20260706000007-create-alles-allemaal-group.sql
-- Description: Crea el grupo "alles-allemaal" con 9 frases muy usadas que
--   cubren: alles (todo, singular general), allemaal (todos-distributivo,
--   con personas, y el coloquial "un monton de"), alles wat (todo lo que),
--   alle + sustantivo (todos los...), iedereen (todo el mundo) y allebei
--   (ambos). Incluye rules_help por frase para el boton de ayuda.
--   Idempotente: WHERE NOT EXISTS / INSERT OR IGNORE. No toca ids existentes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'alles-allemaal',
    'alles (todo), allemaal (todos/un monton), alles wat (todo lo que), alle+sustantivo, iedereen (todo el mundo) y allebei (ambos)',
    'migracion'
);

-- ==============================================================================
-- 2. PALABRAS EN ESPAÑOL (solo si no existen)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes)
SELECT '¿todo bien?', 'PHRASE', 'alles: saludo universal'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿todo bien?');

INSERT INTO words_es (text, word_type, notes)
SELECT 'lo regalé todo', 'PHRASE', 'alles: todo en general'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'lo regalé todo');

INSERT INTO words_es (text, word_type, notes)
SELECT 'todo lo que dices', 'PHRASE', 'alles wat: todo lo que'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'todo lo que dices');

INSERT INTO words_es (text, word_type, notes)
SELECT 'los regalé todos', 'PHRASE', 'allemaal: distributivo sobre plural'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'los regalé todos');

INSERT INTO words_es (text, word_type, notes)
SELECT 'vamos todos', 'PHRASE', 'allemaal: con personas/sujetos'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'vamos todos');

INSERT INTO words_es (text, word_type, notes)
SELECT 'un montón de trastos', 'PHRASE', 'allemaal coloquial: un monton de'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'un montón de trastos');

INSERT INTO words_es (text, word_type, notes)
SELECT 'todos los niños', 'PHRASE', 'alle + sustantivo'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'todos los niños');

INSERT INTO words_es (text, word_type, notes)
SELECT 'todo el mundo', 'PHRASE', 'iedereen: personas'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'todo el mundo');

INSERT INTO words_es (text, word_type, notes)
SELECT 'los dos, ambos', 'PHRASE', 'allebei: ambos'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'los dos, ambos');

-- ==============================================================================
-- 3. TRADUCCIONES + 5 EJEMPLOS
-- ==============================================================================

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿todo bien?'),
    'nl_NL',
    'alles goed?',
    '• [vraag] Hoi, alles goed? — Hola, ¿todo bien?
• [vraag] Alles goed met je moeder? — ¿Tu madre está bien?
• [perf.] Alles is goed gegaan. — Todo ha salido bien.
• [uitdr.] Alles kits? — ¿Todo guay? (variante muy coloquial)
• [bijzin] Ik hoop dat alles goed komt. — Espero que todo se arregle.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'lo regalé todo'),
    'nl_NL',
    'ik heb alles weggegeven',
    '• [can.] Ik heb alles weggegeven. — Lo regalé todo.
• [inv.] Na de verhuizing heb ik alles weggegeven. — Tras la mudanza lo regalé todo.
• [vraag] Heb je echt alles weggegeven? — ¿De verdad lo regalaste todo?
• [can.] Alles is weg. — No queda nada, todo ha desaparecido.
• [uitdr.] Alles of niets! — ¡Todo o nada!'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'todo lo que dices'),
    'nl_NL',
    'alles wat je zegt',
    '• [can.] Alles wat je zegt, is waar. — Todo lo que dices es verdad.
• [can.] Ik geloof alles wat hij vertelt. — Me creo todo lo que cuenta.
• [inv.] Van alles wat ik at, was dit het lekkerst. — De todo lo que comí, esto fue lo más rico.
• [bijzin] Alles wat je nodig hebt, ligt klaar. — Todo lo que necesitas está preparado.
• [uitdr.] Ik heb van alles geprobeerd. — He probado de todo ("van alles" = de todo un poco).'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'los regalé todos'),
    'nl_NL',
    'ik heb ze allemaal weggegeven',
    '• [can.] Ik heb ze allemaal weggegeven. — Los regalé todos.
• [can.] De boeken heb ik allemaal gelezen. — Los libros los he leído todos.
• [vraag] Heb je ze allemaal weggegeven? — ¿Los has regalado todos?
• [inv.] Gisteren heb ik ze allemaal opgeruimd. — Ayer los recogí todos.
• [bijzin] Ze vroeg of ik ze allemaal nog had. — Preguntó si aún los tenía todos.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'vamos todos'),
    'nl_NL',
    'we gaan allemaal',
    '• [can.] We gaan allemaal. — Vamos todos.
• [can.] Jullie zijn allemaal welkom. — Todos vosotros sois bienvenidos.
• [inv.] Vanavond komen ze allemaal. — Esta noche vienen todos.
• [vraag] Gaan jullie allemaal mee? — ¿Os apuntáis todos?
• [uitdr.] Allemaal tegelijk! — ¡Todos a la vez!'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'un montón de trastos'),
    'nl_NL',
    'allemaal troep',
    '• [can.] Er ligt allemaal troep op straat. — Hay un montón de trastos por la calle.
• [can.] Ik kreeg allemaal reclame in de bus. — Me llegó un montón de propaganda al buzón.
• [inv.] In de schuur staat allemaal oude rommel. — En el cobertizo hay un montón de trastos viejos.
• [vraag] Wat is dat allemaal? — ¿Qué es todo esto?
• [uitdr.] Wat moet ik daar allemaal mee? — ¿Y qué hago yo con todo eso?'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'todos los niños'),
    'nl_NL',
    'alle kinderen',
    '• [can.] Alle kinderen krijgen een cadeautje. — Todos los niños reciben un regalito.
• [can.] Ik werk alle dagen behalve zondag. — Trabajo todos los días menos el domingo.
• [inv.] In alle winkels is het druk. — En todas las tiendas hay gente.
• [vraag] Zijn alle plaatsen bezet? — ¿Están ocupados todos los sitios?
• [uitdr.] Hij stond in alle vroegte op. — Se levantó de madrugada (frase hecha: in alle vroegte).'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'todo el mundo'),
    'nl_NL',
    'iedereen',
    '• [can.] Iedereen weet het. — Todo el mundo lo sabe (¡verbo en singular!).
• [inv.] Op het feest kende iedereen elkaar. — En la fiesta todos se conocían.
• [perf.] Iedereen is al naar huis gegaan. — Todo el mundo se ha ido ya a casa.
• [vraag] Is iedereen er? — ¿Están todos?
• [bijzin] Ze zegt dat iedereen welkom is. — Dice que todo el mundo es bienvenido.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'los dos, ambos'),
    'nl_NL',
    'allebei',
    '• [can.] We komen allebei. — Venimos los dos.
• [can.] Ik vind ze allebei leuk. — Me gustan los dos.
• [vraag] Willen jullie allebei koffie? — ¿Queréis café los dos?
• [inv.] Op de foto lachen ze allebei. — En la foto sonríen ambos.
• [uitdr.] Het kan allebei. — Valen las dos opciones.'
);

-- ==============================================================================
-- 4. ASOCIAR AL GRUPO "alles-allemaal" (y a "generic")
-- ==============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, (SELECT id FROM word_groups WHERE title = 'alles-allemaal')
FROM words_es we
WHERE we.text IN (
    '¿todo bien?', 'lo regalé todo', 'todo lo que dices', 'los regalé todos',
    'vamos todos', 'un montón de trastos', 'todos los niños', 'todo el mundo',
    'los dos, ambos'
);

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, (SELECT id FROM word_groups WHERE title = 'generic')
FROM words_es we
WHERE we.text IN (
    '¿todo bien?', 'lo regalé todo', 'todo lo que dices', 'los regalé todos',
    'vamos todos', 'un montón de trastos', 'todos los niños', 'todo el mundo',
    'los dos, ambos'
);

-- ==============================================================================
-- 5. REGLAS DE USO (boton de ayuda del Aprendizaje)
-- ==============================================================================

UPDATE words_es SET rules_help = 'ALLES GOED? = el saludo informal universal («¿todo bien?»).
ALLES es «todo» como masa general y va SIEMPRE en singular: alles is..., alles gaat...
Respuestas típicas: Ja hoor, prima! · Het gaat wel (regular) · Druk, druk, druk (liado).
Variantes: Alles kits? (muy coloquial) · Hoe is het? · Hoe gaat het?
«Alles goed met + persona?» pregunta por alguien: Alles goed met je moeder?' WHERE text = '¿todo bien?';

UPDATE words_es SET rules_help = 'ALLES = «todo» en general (masa indefinida, SINGULAR).
No se refiere a un grupo concreto mencionado: Ik heb alles weggegeven = regalé todas mis cosas.
Contraste clave con ALLEMAAL (distributivo sobre un plural concreto):
• Ik heb alles weggegeven. — Lo regalé TODO.
• Ik heb ze allemaal weggegeven. — LOS regalé TODOS (esos).
Para personas no se usa alles: todo el mundo = IEDEREEN.' WHERE text = 'lo regalé todo';

UPDATE words_es SET rules_help = '«TODO LO QUE...» = ALLES WAT (nunca «alles dat»).
Tras alles, iets, niets, veel y superlativos, el relativo es WAT:
• alles wat je zegt — todo lo que dices
• iets wat ik niet snap — algo que no entiendo
• het mooiste wat ik ken — lo más bonito que conozco
En la subordinada el verbo va al final: Alles wat je nodig HEBT, ligt klaar.
«Van alles» = de todo un poco: Ik heb van alles geprobeerd.' WHERE text = 'todo lo que dices';

UPDATE words_es SET rules_help = 'ALLEMAAL = «todos (cada uno de ellos)»: refuerza un PLURAL concreto ya mencionado.
Es el «los... todos» del español: De boeken heb ik allemaal gelezen.
Suele ir con el pronombre ze: Ik heb ze allemaal weggegeven.
Contraste: alles = todo (general, singular) / allemaal = todos esos (distributivo).
Posición: en el campo medio, tras el pronombre — ...ze allemaal... — nunca al final tras el participio.' WHERE text = 'los regalé todos';

UPDATE words_es SET rules_help = 'ALLEMAAL con SUJETOS/personas = «todos (nosotros/vosotros/ellos)».
• We gaan allemaal. — Vamos todos.
• Jullie zijn allemaal welkom. — Todos sois bienvenidos.
• Ze komen allemaal. — Vienen todos.
Va detrás del verbo conjugado (campo medio), no delante del sujeto.
Para «todo el mundo» sin sujeto previo, usa IEDEREEN: Iedereen gaat.' WHERE text = 'vamos todos';

UPDATE words_es SET rules_help = 'ALLEMAAL coloquial = «un montón de / puro» (uso informal muy frecuente).
• Er ligt allemaal troep op straat. — Hay un montón de trastos por la calle.
• allemaal smoesjes! — ¡puras excusas!
También en preguntas retóricas: Wat is dat allemaal? — ¿Qué es todo esto?
Wat moet ik daar allemaal mee? — ¿Y qué hago yo con todo eso?
Registro informal; en texto formal se usa «een heleboel» o «veel».' WHERE text = 'un montón de trastos';

UPDATE words_es SET rules_help = 'ALLE + SUSTANTIVO = «todos los / todas las» (determinante, sin artículo).
• alle kinderen — todos los niños · alle dagen — todos los días
No lleva de/het: alle boeken (no «alle de boeken»).
Con het-words en singular: HEEL = entero: de hele dag (todo el día), het hele huis.
Ojo: «todos los días» cotidiano suele ser ELKE dag (cada día): Ik fiets elke dag.
Frase hecha: in alle vroegte — de madrugada.' WHERE text = 'todos los niños';

UPDATE words_es SET rules_help = 'IEDEREEN = «todo el mundo / todos» (PERSONAS) y va con verbo en SINGULAR:
• Iedereen weet het. — Todo el mundo lo sabe (weet, no weten).
El trío completo: IEDEREEN (personas) / ALLES (cosas) / ALLEMAAL (refuerzo de un plural).
Negaciones: niemand = nadie · niets/niks = nada.
• Iedereen was er, maar niemand zei iets. — Estaban todos, pero nadie dijo nada.' WHERE text = 'todo el mundo';

UPDATE words_es SET rules_help = 'ALLEBEI = «ambos, los dos» (personas o cosas).
• We komen allebei. — Venimos los dos.
• Ik vind ze allebei leuk. — Me gustan los dos.
Posición como allemaal: campo medio, tras verbo/pronombre.
Sinónimo: alle twee (más enfático); beide es formal/escrito.
«Het kan allebei» = valen ambas opciones. Con 3+ ya no: allemaal o alle drie.' WHERE text = 'los dos, ambos';
