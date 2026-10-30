-- Learn Languages App - Migration
-- Migration: 20261029000006-grupo-kim-lichaam
-- Description: Eduardo: «vamos a crear grupos kim con todas estas palabras … ojo revisa que no existan», sobre las listas de Quizlet de Learn Dutch with Kim (lessons/flashcards-in-quizlet), con la seleccion por frecuencia aprobada el 2026-10-29.
--
--   Lista Lichaam: 41 palabras. 28 ya estaban en el mazo (grupo 4, partes del cuerpo) y solo se
--   ENLAZAN al grupo nuevo. 'el cuerpo' (id 195) existia como WORD SIN traduccion (pendiente 7.1
--   de la howto-skill): se le pone het lichaam y su ayuda en vez de duplicarla. Se crean 11:
--   het hart, het gezicht, de seks, het bloed, de buik, de hersenen, de keel, de hals, de bil,
--   de navel, de hiel. de borsten no se crea: es el plural de de borst (13).
--
--   de bil se crea aunque exista 'los gluteos' -> de billen (60): es la forma singular de Kim y la
--   ayuda explica que el plural es lo habitual.
--
--   Bloque compartido (§3.3) '📌 Regla de bolsillo, de nek, de hals o de keel' en de keel, de hals
--   y de nek (11, que no tenia ayuda: se le crea entera con WHERE rules_help IS NULL, §5.4).

PRAGMA foreign_keys = ON;


-- =============================================================================
-- 1. El grupo
-- =============================================================================
INSERT INTO word_groups (title, description, source)
SELECT 'kim - lichaam',
       'Partes del cuerpo de la lista Lichaam de Learn Dutch with Kim, cada una con su de o het. Junta las 28 que ya estaban en el mazo con las nuevas: el cuerpo, el corazón, la cara, la sangre, la barriga, el cerebro y compañía. Incluye la regla de bolsillo de de nek, de hals y de keel, y el plural de de hersenen.',
       'Lichaam - Flashcards in Quizlet - Learn Dutch with Kim - https://quizlet.com/_982ruv'
WHERE NOT EXISTS (SELECT 1 FROM word_groups WHERE title = 'kim - lichaam');

-- =============================================================================
-- 2. el cuerpo (195): existia sin traduccion, se completa
-- =============================================================================
UPDATE words_es SET rules_help = 'het lichaam = el cuerpo. Es het-woord, plural de lichamen, con una sola a porque la sílaba queda abierta.

• lichamelijk — físico, corporal: lichamelijke klachten.
• het lijf — el cuerpo, más coloquial: Ik heb overal pijn in mijn lijf.'
WHERE text = 'el cuerpo' AND word_type = 'WORD' AND rules_help IS NULL;

-- het lichaam
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el cuerpo', 'WORD', 'kim - lichaam: het lichaam',
'het lichaam = el cuerpo. Es het-woord, plural de lichamen, con una sola a porque la sílaba queda abierta.

• lichamelijk — físico, corporal: lichamelijke klachten.
• het lijf — el cuerpo, más coloquial: Ik heb overal pijn in mijn lijf.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el cuerpo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuerpo' LIMIT 1),
    'nl_NL', 'het lichaam', 'het líjaam',
'• [can.] Mijn lichaam heeft rust nodig. — Mi cuerpo necesita descanso.
• [perf.] Na de marathon heeft mijn hele lichaam pijn gedaan. — Después del maratón me ha dolido todo el cuerpo.
• [inv.] Na een lange wandeling is mijn lichaam moe. — Después de un paseo largo tengo el cuerpo cansado.
• [bijzin] De dokter zegt dat mijn lichaam het virus zelf opruimt. — El médico dice que mi cuerpo elimina el virus solo.
• [uitdr.] Een gezonde geest in een gezond lichaam. — Mente sana en cuerpo sano.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuerpo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - lichaam'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuerpo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- =============================================================================
-- 3. Las 11 tarjetas nuevas
-- =============================================================================
-- het hart
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el corazón', 'WORD', 'kim - lichaam: het hart',
'het hart = el corazón. Es het-woord, plural de harten.

⚠️ Con t al final, y suena igual que hard (duro), porque en neerlandés la d final se pronuncia t.

• de hartslag — el pulso, el latido.
• de hartaanval — el infarto.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el corazón');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el corazón' LIMIT 1),
    'nl_NL', 'het hart', 'het hart',
'• [can.] Mijn hart klopt heel snel. — Mi corazón late muy deprisa.
• [perf.] De dokter heeft naar mijn hart geluisterd. — El médico me ha auscultado el corazón.
• [vraag] Heb je last van je hart? — ¿Tienes problemas de corazón?
• [bijzin] Ik weet dat zijn hart op de goede plek zit. — Sé que tiene buen corazón.
• [uitdr.] Ik zeg het uit de grond van mijn hart. — Lo digo de todo corazón.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el corazón' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - lichaam'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el corazón' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- het gezicht
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la cara', 'WORD', 'kim - lichaam: het gezicht',
'het gezicht = la cara. Es het-woord, plural de gezichten.

🧠 La imagen: gezicht viene de zien (ver), igual que het zicht (la vista), así que la cara es lo que se ve.

• het zicht — la vista, la visibilidad.
• het gelaat — el rostro, solo en lenguaje escrito.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la cara');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la cara' LIMIT 1),
    'nl_NL', 'het gezicht', 'het jesíjt',
'• [can.] Ze heeft een vriendelijk gezicht. — Tiene una cara simpática.
• [perf.] Ik heb zijn gezicht nooit gezien. — Nunca le he visto la cara.
• [geb.] Was je gezicht met koud water. — Lávate la cara con agua fría.
• [bijzin] Ik zag aan zijn gezicht dat hij boos was. — Le vi en la cara que estaba enfadado.
• [uitdr.] Hij wil zijn gezicht niet verliezen. — No quiere quedar mal.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la cara' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - lichaam'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la cara' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de seks
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el sexo', 'WORD', 'kim - lichaam: de seks',
'de seks = el sexo, la relación sexual. Es de-woord y no se usa en plural.

⚠️ El sexo como género no es seks sino het geslacht, que es lo que pregunta un formulario.

• seksueel — sexual.
• seks hebben met — tener relaciones con, sin artículo.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el sexo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el sexo' LIMIT 1),
    'nl_NL', 'de seks', 'de seks',
'• [can.] Ze praten open over seks. — Hablan abiertamente de sexo.
• [vraag] Hebben jullie het op school over seks gehad? — ¿Os hablaron de sexo en el colegio?
• [inv.] Op tv zie je tegenwoordig veel seks. — Hoy en día se ve mucho sexo en la tele.
• [bijzin] Hij vindt dat seks geen taboe moet zijn. — Opina que el sexo no debería ser tabú.
• [uitdr.] Seks verkoopt. — El sexo vende.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el sexo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - lichaam'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el sexo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- het bloed
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la sangre', 'WORD', 'kim - lichaam: het bloed',
'het bloed = la sangre. Es het-woord y no tiene plural.

• bloeden — sangrar: Mijn neus bloedt.
• bloed geven — donar sangre, sin artículo.
• de bloeddruk — la tensión arterial.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la sangre');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la sangre' LIMIT 1),
    'nl_NL', 'het bloed', 'het blut',
'• [can.] Ik kan geen bloed zien. — No soporto ver sangre.
• [perf.] Ik heb vorige maand bloed gegeven. — El mes pasado doné sangre.
• [vraag] Moet ik nuchter zijn voor het bloedonderzoek? — ¿Tengo que ir en ayunas al análisis de sangre?
• [bijzin] De dokter zei dat er bloed in de urine zat. — El médico dijo que había sangre en la orina.
• [uitdr.] Bloed is dikker dan water. — La sangre tira.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la sangre' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - lichaam'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la sangre' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de buik
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la barriga', 'WORD', 'kim - lichaam: de buik',
'de buik = la barriga, el vientre. Es de-woord, plural de buiken.

• de buikpijn — el dolor de barriga.
• op je buik liggen — estar boca abajo.

🔑 El truco que casi nunca falla: pijn se pega a la parte del cuerpo y va sin artículo, como en hoofdpijn, buikpijn, keelpijn o rugpijn.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la barriga');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la barriga' LIMIT 1),
    'nl_NL', 'de buik', 'de beuk',
'• [can.] Ik heb buikpijn. — Me duele la barriga.
• [perf.] Hij heeft een dikke buik gekregen. — Le ha salido barriga.
• [inv.] ''s Nachts slaap ik op mijn buik. — Por la noche duermo boca abajo.
• [bijzin] Ze zegt dat haar buik al weken opgezet is. — Dice que lleva semanas con la barriga hinchada.
• [uitdr.] Ik heb er mijn buik vol van. — Estoy harto de eso.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la barriga' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - lichaam'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la barriga' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de hersenen
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el cerebro', 'WORD', 'kim - lichaam: de hersenen',
'de hersenen = el cerebro. Va en plural en neerlandés y en el habla también se dice de hersens.

• het brein — el cerebro en sentido culto o figurado: het brein achter de overval.
• de hersenschudding — la conmoción cerebral.

🔑 El truco que casi nunca falla: el español lo cuenta en singular y el neerlandés en plural, así que el verbo va siempre en plural, de hersenen werken.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el cerebro');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el cerebro' LIMIT 1),
    'nl_NL', 'de hersenen', 'de hér-se-nen',
'• [can.] Je hersenen hebben slaap nodig. — Tu cerebro necesita dormir.
• [perf.] Hij heeft een hersenschudding opgelopen. — Ha sufrido una conmoción cerebral.
• [inv.] Na een lange dag werken mijn hersenen niet meer. — Después de un día largo el cerebro ya no me funciona.
• [bijzin] Onderzoekers zeggen dat de hersenen tot je vijfentwintigste groeien. — Los investigadores dicen que el cerebro crece hasta los veinticinco.
• [geb.] Gebruik je hersens! — ¡Usa la cabeza!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cerebro' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - lichaam'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cerebro' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de keel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la garganta', 'WORD', 'kim - lichaam: de keel',
'de keel = la garganta, por dentro. Es de-woord, plural de kelen.

• de keelpijn — el dolor de garganta.
• zijn keel schrapen — carraspear.

📌 Regla de bolsillo, de nek, de hals o de keel:
• ¿Por detrás, donde da la tortícolis? → de nek — Ik heb een stijve nek.
• ¿Por delante o de lado, donde va el collar? → de hals — een ketting om je hals.
• ¿Por dentro, al tragar o al hablar? → de keel — Ik heb keelpijn.

⚠️ En el habla de nek vale también para el cuello entero, y nekpijn es el dolor de cuello de toda la vida.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la garganta');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la garganta' LIMIT 1),
    'nl_NL', 'de keel', 'de keel',
'• [can.] Ik heb een zere keel. — Me duele la garganta.
• [perf.] Ik heb de hele dag keelpijn gehad. — He tenido dolor de garganta todo el día.
• [vraag] Doet je keel pijn als je slikt? — ¿Te duele la garganta al tragar?
• [bijzin] Hij schraapte zijn keel voordat hij begon te praten. — Carraspeó antes de empezar a hablar.
• [uitdr.] Ik heb een kikker in mijn keel. — Tengo carraspera.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la garganta' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - lichaam'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la garganta' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de hals
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el cuello por delante', 'WORD', 'kim - lichaam: de hals',
'de hals = el cuello, sobre todo por delante y de lado. Es de-woord, plural de halzen.

• de halsketting — el collar.
• iemand om de hals vallen — echarse al cuello de alguien.

📌 Regla de bolsillo, de nek, de hals o de keel:
• ¿Por detrás, donde da la tortícolis? → de nek — Ik heb een stijve nek.
• ¿Por delante o de lado, donde va el collar? → de hals — een ketting om je hals.
• ¿Por dentro, al tragar o al hablar? → de keel — Ik heb keelpijn.

⚠️ En el habla de nek vale también para el cuello entero, y nekpijn es el dolor de cuello de toda la vida.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el cuello por delante');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuello por delante' LIMIT 1),
    'nl_NL', 'de hals', 'de hals',
'• [can.] Een giraf heeft een heel lange hals. — Una jirafa tiene el cuello muy largo.
• [perf.] Ze is me om de hals gevallen. — Se me ha echado al cuello.
• [inv.] In de winter draag ik een sjaal om mijn hals. — En invierno llevo una bufanda al cuello.
• [bijzin] Ik zag dat hij een tatoeage op zijn hals had. — Vi que tenía un tatuaje en el cuello.
• [uitdr.] Hij heeft zich problemen op de hals gehaald. — Se ha buscado problemas.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuello por delante' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - lichaam'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el cuello por delante' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de bil
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la nalga', 'WORD', 'kim - lichaam: de bil',
'de bil = la nalga, una sola. Es de-woord, plural de billen, que es como se dice casi siempre.

• op je billen vallen — caerse de culo.
• de kont — el culo, coloquial, frente a de billen, que es neutro.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la nalga');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la nalga' LIMIT 1),
    'nl_NL', 'de bil', 'de bil',
'• [can.] De baby heeft een rode bil. — El bebé tiene una nalga roja.
• [perf.] Ik ben op mijn billen gevallen. — Me he caído de culo.
• [inv.] Na het fietsen doen mijn billen pijn. — Después de la bici me duelen las nalgas.
• [bijzin] De verpleegster zegt dat de prik in je bil gaat. — La enfermera dice que el pinchazo va en la nalga.
• [uitdr.] Hij moest met de billen bloot. — Tuvo que confesarlo todo.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la nalga' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - lichaam'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la nalga' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de navel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el ombligo', 'WORD', 'kim - lichaam: de navel',
'de navel = el ombligo. Es de-woord, plural de navels.

• de navelstreng — el cordón umbilical.
• navelstaren — mirarse el ombligo, pensar solo en uno mismo.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el ombligo');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el ombligo' LIMIT 1),
    'nl_NL', 'de navel', 'de náavel',
'• [can.] Haar shirt is zo kort dat je haar navel ziet. — Su camiseta es tan corta que se le ve el ombligo.
• [perf.] De verpleegster heeft de navelstreng doorgeknipt. — La enfermera ha cortado el cordón umbilical.
• [inv.] Bij deze oefening trek je je navel naar binnen. — En este ejercicio metes el ombligo hacia dentro.
• [bijzin] Ze vertelde dat ze een piercing in haar navel had laten zetten. — Contó que se había hecho un piercing en el ombligo.
• [geb.] Stop met navelstaren! — ¡Deja de mirarte el ombligo!');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el ombligo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - lichaam'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el ombligo' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- de hiel
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'el talón', 'WORD', 'kim - lichaam: de hiel',
'de hiel = el talón. Es de-woord, plural de hielen.

• de hak — el tacón del zapato, y en el habla también el talón: hoge hakken.
• de achillespees — el tendón de Aquiles.

🧠 La imagen: de achilleshiel es el talón de Aquiles, el punto débil, igual que en español.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'el talón');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'el talón' LIMIT 1),
    'nl_NL', 'de hiel', 'de hiil',
'• [can.] Mijn hiel doet pijn als ik loop. — Me duele el talón al andar.
• [perf.] Ik heb een blaar op mijn hiel gekregen. — Me ha salido una ampolla en el talón.
• [inv.] Met deze schoenen heb ik last van mijn hielen. — Con estos zapatos me molestan los talones.
• [bijzin] De fysiotherapeut zegt dat ik eerst op mijn hiel moet landen. — El fisio dice que tengo que apoyar primero el talón.
• [uitdr.] Dat is zijn achilleshiel. — Ese es su talón de Aquiles.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el talón' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'kim - lichaam'));
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'el talón' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));


-- =============================================================================
-- 4. de nek (11): ayuda con el bloque compartido
-- =============================================================================
UPDATE words_es SET rules_help = 'de nek = el cuello, sobre todo por detrás. Es de-woord, plural de nekken.

• de nekpijn — el dolor de cuello.

📌 Regla de bolsillo, de nek, de hals o de keel:
• ¿Por detrás, donde da la tortícolis? → de nek — Ik heb een stijve nek.
• ¿Por delante o de lado, donde va el collar? → de hals — een ketting om je hals.
• ¿Por dentro, al tragar o al hablar? → de keel — Ik heb keelpijn.

⚠️ En el habla de nek vale también para el cuello entero, y nekpijn es el dolor de cuello de toda la vida.'
WHERE id = (SELECT word_es_id FROM words_lang WHERE lang_code = 'nl_NL' AND text = 'de nek') AND rules_help IS NULL;

UPDATE words_es SET rules_help = rules_help || '

📌 Regla de bolsillo, de nek, de hals o de keel:
• ¿Por detrás, donde da la tortícolis? → de nek — Ik heb een stijve nek.
• ¿Por delante o de lado, donde va el collar? → de hals — een ketting om je hals.
• ¿Por dentro, al tragar o al hablar? → de keel — Ik heb keelpijn.

⚠️ En el habla de nek vale también para el cuello entero, y nekpijn es el dolor de cuello de toda la vida.'
WHERE id = (SELECT word_es_id FROM words_lang WHERE lang_code = 'nl_NL' AND text = 'de nek') AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%📌 Regla de bolsillo, de nek, de hals o de keel%';

-- =============================================================================
-- 5. Las 28 que ya existian
-- =============================================================================
-- Enlazar las tarjetas ya existentes (ids esperados en la BD a 2026-10-29):
--   de arm -> id 16
--   het been -> id 22
--   de borst -> id 13
--   de duim -> id 30
--   de elleboog -> id 18
--   het haar -> id 40
--   de hand -> id 20
--   het hoofd -> id 10
--   de huid -> id 63
--   de knie -> id 24
--   de kont -> id 61
--   de lip -> id 50
--   de mond -> id 49
--   de nek -> id 11
--   de neus -> id 46
--   het oog -> id 45
--   het oor -> id 47
--   de pols -> id 19
--   de rug -> id 14
--   de schouder -> id 12
--   de tand -> id 51
--   de teen -> id 29
--   de tong -> id 54
--   de vinger -> id 21
--   de voet -> id 28
--   de wang -> id 48
--   de wenkbrauw -> id 42
--   de wimper -> id 44
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT l.word_es_id, (SELECT id FROM word_groups WHERE title = 'kim - lichaam')
FROM words_lang l JOIN words_es e ON e.id = l.word_es_id
WHERE l.lang_code = 'nl_NL' AND e.word_type = 'WORD'
  AND l.text IN ('de arm', 'het been', 'de borst', 'de duim', 'de elleboog', 'het haar', 'de hand', 'het hoofd', 'de huid', 'de knie', 'de kont', 'de lip', 'de mond', 'de nek', 'de neus', 'het oog', 'het oor', 'de pols', 'de rug', 'de schouder', 'de tand', 'de teen', 'de tong', 'de vinger', 'de voet', 'de wang', 'de wenkbrauw', 'de wimper');
