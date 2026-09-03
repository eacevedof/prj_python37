-- Learn Languages App - tarjeta nueva: Hoe het er ook uitziet (grupo de pronunciacion)
-- Migration: 20260902000005-nueva-hoe-het-er-ook-uitziet.sql
-- Description: Eduardo: «dificil pronunciacion hoe het er ook uitziet». La cadena no existia en
--   el mazo (solo la 459 con ermee) y es oro doble: fonetica (het atono → ''t pegado a hoe:
--   «hut-er-ok», el fenomeno estrella del grupo 33) y gramatica (la formula concesiva con el er
--   de eruitzien, que ademas cierra el trio con la 819). Se crea como SENTENCE examinable
--   («Pinte como pinte, seguimos adelante.» → Hoe het er ook uitziet, we gaan door.) con la
--   ficha completa de eruitzien segun la normativa (tabla de 7 personas, participio eruitgezien,
--   er como parte del verbo frente a uitzien naar, eruitzien als, sin antonimo — justificado —,
--   het uiterlijk / het uitzicht, Het ziet ernaar uit dat…) y el bloque 🌀 de la formula
--   IDENTICO byte a byte al que la 20260902000004 mete en la 819. Grupos: pronunciacion (33) y
--   generic. Idempotente: NOT EXISTS / OR IGNORE.

PRAGMA foreign_keys = ON;

INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'Pinte como pinte, seguimos adelante.', 'SENTENCE', 'Ejemplo de "eruitzien" (concesiva)', 'Formula concesiva hoe … ook + eruitzien (tener aspecto): «pinte como pinte». Y hablada se pega: hoe het er → «hut-er», que es por lo que esta en el grupo de pronunciacion.

🎙️ Como suena de verdad:

• het es atono: pierde la h y la e — queda ''''t — y se pega a hoe: hoe ''''t → «hut».
• la t enlaza con er, y ook atono es «ok»: hut-er-ok.
• uitziet: la ui suena «au» → «autsit».
• entero: Hut-er-ok autsit, ue jan dor.

📐 Conjugacion de eruitzien (fuerte y separable: er + uit + zien):

| persona | presente | imperfecto |
|---|---|---|
| ik | zie eruit | zag eruit |
| jij / je | ziet eruit | zag eruit |
| u | ziet eruit | zag eruit |
| hij / zij / het | ziet eruit | zag eruit |
| wij | zien eruit | zagen eruit |
| jullie | zien eruit | zagen eruit |
| zij (plural) | zien eruit | zagen eruit |

• participio — eruitgezien, con hebben y el ge- dentro (er … uit-ge-zien): Ze heeft er moe uitgezien.
• el er es PARTE del verbo y se separa del uit en la frase: Het ziet ER goed UIT. — Tiene buena pinta. Sin er, uitzien es otro verbo: uitzien naar = tener ganas de.
• al invertir, jij pierde la -t: Zie je er moe uit?
• preposicion — eruitzien als (parecer, tener pinta de): Hij ziet eruit als een politieagent.
• antonimo — no aplica: es un verbo de apariencia; se niega o se gradua (er goed/slecht uitzien).
• sustantivos — het uiterlijk (el aspecto) · het uitzicht (la vista, el panorama).
• expresion hecha — Het ziet ernaar uit dat het gaat regenen. — Parece que va a llover.
• doorgaan (seguimos adelante) tambien es separable: we gaan door.

🌀 La formula concesiva: interrogativo + (er) + ook … + verbo al final:

| formula | literal | espanol |
|---|---|---|
| wat er ook gebeurt | lo que sea que pase | pase lo que pase |
| wie er ook komt | quien sea que venga | venga quien venga |
| waar je ook bent | donde sea que estes | estes donde estes |
| hoe het er ook uitziet | el aspecto que sea que tenga | pinte como pinte |

• el ook es el «-quiera» espanol: sin el, la frase se queda en una relativa normal (wat er gebeurt = lo que pasa) y pierde el «pase lo que pase».
• el er solo aparece si la gramatica lo pide: en wat/wie er ook … porque el sujeto es indefinido (viene de Er gebeurt iets); en hoe het er ook uitziet porque es parte del verbo eruitzien; en waar je ook bent no hay er, porque je es definido.
• el verbo va al final: son subordinadas.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'Pinte como pinte, seguimos adelante.' AND notes = 'Ejemplo de "eruitzien" (concesiva)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Pinte como pinte, seguimos adelante.' AND notes = 'Ejemplo de "eruitzien" (concesiva)' LIMIT 1),
    'nl_NL', 'Hoe het er ook uitziet, we gaan door.', 'Hut-er-ok autsit, ue jan dor.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Pinte como pinte, seguimos adelante.' AND notes = 'Ejemplo de "eruitzien" (concesiva)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Pinte como pinte, seguimos adelante.' AND notes = 'Ejemplo de "eruitzien" (concesiva)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));
