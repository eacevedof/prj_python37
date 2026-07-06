-- Learn Languages App - Grupo "soms-weleens-ooit": frecuencias y "vez/veces"
-- Migration: 20260706000008-create-soms-weleens-group.sql
-- Description: Crea el grupo "soms-weleens-ooit" con 10 frases muy usadas que
--   cubren: weleens (experiencia y ocasional), soms (a veces y "por
--   casualidad" en preguntas), ooit (algun dia/alguna vez), een paar keer,
--   een enkele keer, af en toe, nog een keer y el falso amigo het enige.
--   Incluye rules_help por frase. Idempotente. No toca ids existentes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. GRUPO
-- ==============================================================================
INSERT OR IGNORE INTO word_groups (title, description, source)
VALUES (
    'soms-weleens-ooit',
    'Frecuencias y "vez": weleens (alguna vez), soms (a veces / por casualidad), ooit (algun dia), een paar keer, een enkele keer, af en toe, nog een keer, het enige',
    'migracion'
);

-- ==============================================================================
-- 2. PALABRAS EN ESPAÑOL (solo si no existen)
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes)
SELECT '¿has estado alguna vez?', 'PHRASE', 'weleens: pregunta de experiencia'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿has estado alguna vez?');

INSERT INTO words_es (text, word_type, notes)
SELECT 'eso pasa a veces', 'PHRASE', 'weleens: frecuencia ocasional'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'eso pasa a veces');

INSERT INTO words_es (text, word_type, notes)
SELECT 'a veces', 'PHRASE', 'soms: frecuencia'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'a veces');

INSERT INTO words_es (text, word_type, notes)
SELECT '¿por casualidad...?', 'PHRASE', 'soms en preguntas: acaso/por casualidad'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = '¿por casualidad...?');

INSERT INTO words_es (text, word_type, notes)
SELECT 'algún día', 'PHRASE', 'ooit: momento indefinido futuro/pasado'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'algún día');

INSERT INTO words_es (text, word_type, notes)
SELECT 'algunas veces', 'PHRASE', 'een paar keer: unas cuantas veces'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'algunas veces');

INSERT INTO words_es (text, word_type, notes)
SELECT 'alguna que otra vez', 'PHRASE', 'een enkele keer: rara vez'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'alguna que otra vez');

INSERT INTO words_es (text, word_type, notes)
SELECT 'de vez en cuando', 'PHRASE', 'af en toe'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'de vez en cuando');

INSERT INTO words_es (text, word_type, notes)
SELECT 'otra vez, una vez más', 'PHRASE', 'nog een keer'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'otra vez, una vez más');

INSERT INTO words_es (text, word_type, notes)
SELECT 'lo único', 'PHRASE', 'het enige: falso amigo (no es "vez")'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'lo único');

-- ==============================================================================
-- 3. TRADUCCIONES + 5 EJEMPLOS
-- ==============================================================================

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿has estado alguna vez?'),
    'nl_NL',
    'ben je weleens geweest?',
    '• [vraag] Ben je weleens in Amsterdam geweest? — ¿Has estado alguna vez en Ámsterdam?
• [vraag] Heb je weleens haring geprobeerd? — ¿Has probado alguna vez el arenque?
• [vraag] Heb je weleens op een boot geslapen? — ¿Has dormido alguna vez en un barco?
• [can.] Ik ben er weleens geweest. — He estado alguna vez.
• [bijzin] Ze vroeg of ik weleens in Spanje was geweest. — Preguntó si había estado alguna vez en España.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'eso pasa a veces'),
    'nl_NL',
    'dat gebeurt weleens',
    '• [can.] Dat gebeurt weleens. — Eso pasa a veces.
• [can.] Iedereen vergeet weleens iets. — A todo el mundo se le olvida algo alguna vez.
• [can.] Ik ga weleens naar de sauna. — Voy alguna que otra vez a la sauna.
• [vraag] Maak jij weleens een fout? — ¿Tú cometes errores alguna vez?
• [uitdr.] Kom nog weleens langs! — ¡Pásate algún día!'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'a veces'),
    'nl_NL',
    'soms',
    '• [can.] Ik werk soms thuis. — A veces trabajo desde casa.
• [inv.] Soms regent het hier de hele dag. — A veces aquí llueve todo el día.
• [uitdr.] Soms wel, soms niet. — A veces sí, a veces no.
• [vraag] Eet je soms vlees? — ¿Comes carne a veces?
• [bijzin] Ik denk dat hij soms eenzaam is. — Creo que a veces se siente solo.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = '¿por casualidad...?'),
    'nl_NL',
    'heb je soms...?',
    '• [vraag] Heb je soms mijn sleutels gezien? — ¿Has visto por casualidad mis llaves?
• [vraag] Weet jij soms hoe laat het is? — ¿Sabes por casualidad qué hora es?
• [vraag] Heb je soms een oplader bij je? — ¿Llevas por casualidad un cargador?
• [vraag] Ben je soms boos? — ¿Acaso estás enfadado? (con retintín)
• [bijzin] Vraag even of hij soms een pen heeft. — Pregunta si por casualidad tiene un boli.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'algún día'),
    'nl_NL',
    'ooit',
    '• [inv.] Ooit ga ik naar Japan. — Algún día iré a Japón.
• [inv.] Ooit komt de dag dat alles lukt. — Algún día llegará el día en que todo salga.
• [vraag] Ben je ooit verliefd geweest? — ¿Has estado enamorado alguna vez?
• [can.] Ik heb ooit in Utrecht gewoond. — Viví en Utrecht en su día.
• [bijzin] Hij hoopt dat hij ooit een huis kan kopen. — Espera poder comprarse una casa algún día.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'algunas veces'),
    'nl_NL',
    'een paar keer',
    '• [can.] Ik ben er een paar keer geweest. — He estado allí algunas veces.
• [can.] Ik heb het een paar keer geprobeerd. — Lo he intentado unas cuantas veces.
• [inv.] Een paar keer per week sport ik. — Unas cuantas veces por semana hago deporte.
• [vraag] Hoe vaak? Een paar keer maar. — ¿Cuántas veces? Solo unas pocas.
• [bijzin] Ik weet het, omdat ik het een paar keer heb gezien. — Lo sé porque lo he visto varias veces.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'alguna que otra vez'),
    'nl_NL',
    'een enkele keer',
    '• [can.] Ik eet een enkele keer vlees. — Como carne alguna que otra vez.
• [can.] We gaan een enkele keer uit eten. — Salimos a cenar alguna que otra vez.
• [inv.] Slechts een enkele keer komt hij te laat. — Solo muy rara vez llega tarde.
• [vraag] Rook je nog? Een enkele keer. — ¿Sigues fumando? Alguna que otra vez.
• [bijzin] Het gebeurt maar een enkele keer dat het hier sneeuwt. — Solo muy de vez en cuando nieva aquí.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'de vez en cuando'),
    'nl_NL',
    'af en toe',
    '• [can.] Ik drink af en toe een biertje. — Me tomo una cerveza de vez en cuando.
• [inv.] Af en toe bel ik mijn oma. — De vez en cuando llamo a mi abuela.
• [can.] We zien elkaar af en toe. — Nos vemos de vez en cuando.
• [vraag] Sport je af en toe? — ¿Haces deporte de vez en cuando?
• [uitdr.] Zo nu en dan doe ik een dutje. — De tanto en tanto echo una siesta ("zo nu en dan" = af en toe).'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'otra vez, una vez más'),
    'nl_NL',
    'nog een keer',
    '• [can.] Ik doe het nog een keer. — Lo hago otra vez.
• [geb.] Zeg het nog een keer! — ¡Dilo otra vez!
• [vraag] Zullen we het nog een keer proberen? — ¿Lo intentamos una vez más?
• [inv.] Die film wil ik nog een keer zien. — Esa peli quiero verla otra vez.
• [uitdr.] Nog één keer en dan stoppen we. — Una última vez y paramos.'
);

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, notes)
VALUES (
    (SELECT id FROM words_es WHERE text = 'lo único'),
    'nl_NL',
    'het enige',
    '• [can.] Het enige wat ik wil, is rust. — Lo único que quiero es tranquilidad.
• [can.] Hij is de enige die het weet. — Es el único que lo sabe.
• [can.] Dit is het enige exemplaar. — Este es el único ejemplar.
• [vraag] Ben ik de enige die dit raar vindt? — ¿Soy el único al que esto le parece raro?
• [bijzin] Het enige wat je hoeft te doen, is bellen. — Lo único que tienes que hacer es llamar.'
);

-- ==============================================================================
-- 4. ASOCIAR AL GRUPO "soms-weleens-ooit" (y a "generic")
-- ==============================================================================
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, (SELECT id FROM word_groups WHERE title = 'soms-weleens-ooit')
FROM words_es we
WHERE we.text IN (
    '¿has estado alguna vez?', 'eso pasa a veces', 'a veces', '¿por casualidad...?',
    'algún día', 'algunas veces', 'alguna que otra vez', 'de vez en cuando',
    'otra vez, una vez más', 'lo único'
);

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
SELECT we.id, (SELECT id FROM word_groups WHERE title = 'generic')
FROM words_es we
WHERE we.text IN (
    '¿has estado alguna vez?', 'eso pasa a veces', 'a veces', '¿por casualidad...?',
    'algún día', 'algunas veces', 'alguna que otra vez', 'de vez en cuando',
    'otra vez, una vez más', 'lo único'
);

-- ==============================================================================
-- 5. REGLAS DE USO (boton de ayuda del Aprendizaje)
-- ==============================================================================

UPDATE words_es SET rules_help = 'WELEENS (wel + eens) = «alguna vez», átono y cotidiano.
Es LA forma normal de preguntar por EXPERIENCIAS (con perfecto):
• Ben je weleens in Parijs geweest? — ¿Has estado alguna vez en París?
OOIT también vale pero es más enfático («¿alguna vez en tu vida?»).
Ortografía oficial: junto (weleens); lo verás separado (wel eens) a menudo.
Se pronuncia sin acento: «w''léns».' WHERE text = '¿has estado alguna vez?';

UPDATE words_es SET rules_help = 'WELEENS con presente = frecuencia ocasional: «a veces, alguna que otra vez».
• Dat gebeurt weleens. — Eso pasa a veces.
• Iedereen maakt weleens een fout. — Todos cometemos algún error alguna vez.
Más esporádico que SOMS (a veces con cierta regularidad).
NOG WELEENS = «algún día (ya llegará)»: Kom nog weleens langs! — ¡Pásate algún día!
Dat zullen we nog weleens zien! — ¡Eso ya lo veremos!' WHERE text = 'eso pasa a veces';

UPDATE words_es SET rules_help = 'SOMS = «a veces» (frecuencia con cierta regularidad).
• Ik werk soms thuis. — A veces trabajo desde casa.
• Soms wel, soms niet. — A veces sí, a veces no.
Escala de frecuencia: altijd (siempre) > vaak (a menudo) > soms (a veces) > af en toe (de vez en cuando) > weleens (esporádico) > zelden (rara vez) > nooit (nunca).
¡Ojo! En preguntas soms cambia de significado: «por casualidad» (ver esa entrada).' WHERE text = 'a veces';

UPDATE words_es SET rules_help = 'SOMS en preguntas de sí/no = «por casualidad / acaso» (¡no significa «a veces»!).
• Heb je soms mijn sleutels gezien? — ¿Has visto por casualidad mis llaves?
• Weet jij soms hoe laat het is? — ¿Sabes por casualidad la hora?
Suaviza la pregunta (no doy por hecho que sepas/tengas).
Con tono seco es «acaso», con retintín: Ben je soms boos? — ¿Acaso estás enfadado?
Truco: pregunta sí/no + soms = por casualidad; frase afirmativa + soms = a veces.' WHERE text = '¿por casualidad...?';

UPDATE words_es SET rules_help = 'OOIT = momento indefinido en el tiempo: «algún día» (futuro) o «alguna vez / en su día» (pasado).
• Ooit ga ik naar Japan. — Algún día iré a Japón.
• Ik heb ooit in Utrecht gewoond. — Viví en Utrecht en su día.
• Ben je ooit...? — ¿Alguna vez...? (más enfático que weleens)
NO cuenta veces: para «1 vez, 2 veces» usa een keer.
Truco: si encaja «en su día / algún día» → ooit.' WHERE text = 'algún día';

UPDATE words_es SET rules_help = 'EEN PAAR KEER = «algunas veces, unas cuantas» (cuenta veces, pocas).
• Ik ben er een paar keer geweest. — He estado unas cuantas veces.
Familia de contar: één keer (una vez) · twee keer (dos veces) · een paar keer (unas pocas) · vaak (muchas, a menudo).
Sinónimo algo más formal: enkele keren.
También «een keer» coloquial = un día de estos: We moeten een keer afspreken!' WHERE text = 'algunas veces';

UPDATE words_es SET rules_help = 'EEN ENKELE KEER = «alguna que otra vez, muy rara vez» (menos que soms).
• Ik eet een enkele keer vlees. — Como carne alguna que otra vez.
Con «slechts» o «maar» se refuerza lo excepcional: slechts een enkele keer.
No confundir con ENKELE KEREN (plural) = algunas veces (unas cuantas, más que una enkele keer).
Y nada que ver con DE/HET ENIGE = el/lo único.' WHERE text = 'alguna que otra vez';

UPDATE words_es SET rules_help = 'AF EN TOE = «de vez en cuando» (comodín cotidiano, entre soms y weleens).
• Ik drink af en toe een biertje. — Una cerveza de vez en cuando.
Sinónimos: zo nu en dan · zo af en toe · van tijd tot tijd (formal).
Posición: campo medio (Ik bel af en toe...) o delante con inversión (Af en toe bel ik...).
Escala: soms (a veces) ≥ af en toe (de vez en cuando) > weleens (esporádico) > zelden (rara vez).' WHERE text = 'de vez en cuando';

UPDATE words_es SET rules_help = 'NOG EEN KEER = «otra vez, una vez más» (repetición).
• Zeg het nog een keer! — ¡Dilo otra vez!
Aquí NOG es el de cantidad («uno más»), no el de «todavía»: nog een koffie = otro café.
Variantes: nog eens (igual, algo más formal) · nog één keer (énfasis: UNA última vez) · alweer = otra vez (con fastidio: Alweer?! — ¡¿otra vez?!).
OPNIEUW = de nuevo, desde cero: begin opnieuw — empieza de nuevo.' WHERE text = 'otra vez, una vez más';

UPDATE words_es SET rules_help = 'ENIGE = falso amigo: NO es «vez». Significa «único» o (formal) «algo de».
• de enige = el único: Hij is de enige die het weet.
• het enige = lo único: Het enige wat ik wil... (¡con WAT, como alles wat!)
• enige tijd/ervaring = algo de tiempo/experiencia (registro formal).
«El único que» = de enige DIE (personas); «lo único que» = het enige WAT.
Para «alguna vez» usa weleens/ooit; para «algunas veces», een paar keer.' WHERE text = 'lo único';
