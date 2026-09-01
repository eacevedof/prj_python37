-- Learn Languages App - «mening» y no «opinie», y como se opina en neerlandes (duda de la 862)
-- Migration: 20260901000001-help-mening-vs-opinie.sql
-- Description: Eduardo en la 862 (Ik heb mijn mening veranderd): «¿por que mening y no opinie?».
--   Porque opinie EXISTE pero no es la palabra de esta frase: la opinion de UNA persona es de
--   mening, y opinie se reserva para la opinion COLECTIVA y el lenguaje de los medios (de publieke
--   opinie, het opiniestuk, de opiniepeiling, de opiniemakers). Es falso amigo puro: el espanol
--   «opinion» es de todos los dias y opinie no.
--   La 862 estaba SIN rules_help y se crea entera, ademas de con la respuesta, con la trampa que
--   la frase esconde: veranderen cambia de AUXILIAR segun lleve objeto — «Ik HEB mijn mening
--   veranderd» (transitivo) frente a «Ik BEN van mening veranderd» (cambio de estado, sin objeto),
--   y al lado «Ik heb me bedacht» de la 570.
--   Bloque 💬 IDENTICO byte a byte en la 862, en la 880 (Ieder van ons heeft een mening) y en la
--   tarjeta nueva: el reparto mening/opinie, el campo lexico entero con su articulo, la escalera
--   de registro para opinar (volgens mij · ik vind · naar mijn mening · mijns inziens · ik ben van
--   mening dat), la diferencia ik denk / ik vind que el espanol mezcla en «creo», las formulas
--   fijas con mening y la ficha completa de verschillen (regimen van/met/over, conjugacion en
--   tabla, participio y auxiliar, sustantivo het verschil con su antonimo de overeenkomst, el
--   antonimo del verbo — het eens zijn / overeenkomen — y su expresion hecha).
--   Y se crea el vocabulario que faltaba, examinable: la palabra «de mening» como tarjeta WORD
--   (no estaba en el mazo, solo aparecia dentro de frases) con DOS frases SENTENCE entrenables
--   relacionadas (EXAMPLE) — una de volgens mij + inversion y otra de van mening verschillen, esta
--   marcada «(presente)» porque «discrepamos» es ambiguo en espanol.
--   100% aditiva e idempotente: INSERT con NOT EXISTS / OR IGNORE y UPDATE con guard por marca.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. Tarjeta 862: no tenia ayuda, se crea con la respuesta a la duda
-- ==============================================================================
UPDATE words_es
SET rules_help = 'opinie existe, pero no es la palabra de esta frase: la opinion de UNA persona es de mening. opinie se reserva para la opinion COLECTIVA y para el lenguaje de los medios — de publieke opinie (la opinion publica), het opiniestuk (el articulo de opinion), de opiniepeiling (la encuesta), de opiniemakers.

📌 Es falso amigo puro, y de los que mas se cuelan: en espanol «opinion» es palabra de todos los dias, en neerlandes opinie no. «Ik heb mijn opinie veranderd» se entiende, pero suena a traduccion literal; nadie lo dice.

🔁 Las dos maneras de decir que cambias de opinion — y ojo al AUXILIAR, que es la trampa de esta tarjeta:
• Ik heb mijn mening veranderd. — con objeto (mijn mening), o sea transitivo → HEBBEN. Es la frase de la tarjeta.
• Ik ben van mening veranderd. — sin objeto, es un cambio de estado → ZIJN. Igual funciona Ik ben van gedachten veranderd.
• Ik heb me bedacht. — me lo he pensado mejor, he cambiado de idea. Reflexivo y siempre con hebben (es la 570).

⚠️ Fijate en que es el MISMO verbo, veranderen, con dos auxiliares segun lleve objeto o no: Het weer is veranderd (solo, zijn) frente a Ik heb mijn mening veranderd (lo cambio yo, hebben). La conjugacion completa esta en la 860.

📐 Estructura: sujeto + heb (2a casilla) + mijn mening + participio al final. Perfecto de manual: veranderd cierra la frase.',
    updated_at = datetime('now')
WHERE id = 862
  AND rules_help IS NULL;

-- ==============================================================================
-- 2. La palabra que faltaba en el mazo: de mening, como tarjeta examinable
-- ==============================================================================
INSERT INTO words_es (text, word_type, notes, rules_help)
SELECT 'la opinión, el parecer', 'WORD', 'dificil: de mening (la opinion, el parecer)', 'de mening = la opinion, el parecer de una persona. Es la palabra normal y de todos los dias; opinie solo vale para la opinion colectiva y la de los medios (de publieke opinie).

📐 Estructura: es de-woord, de mening, plural de meningen. Se usa con un posesivo (mijn mening) o con van (de mening van mijn vader).

⚠️ Al hablar, «en mi opinion» casi nunca es naar mijn mening: es volgens mij. Y «me parece que» es ik vind, no ik denk.'
WHERE NOT EXISTS (SELECT 1 FROM words_es WHERE text = 'la opinión, el parecer');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation, notes)
VALUES ((SELECT id FROM words_es WHERE text = 'la opinión, el parecer' LIMIT 1),
    'nl_NL', 'de mening', 'de mening',
    '• [can.] Volgens mij is het te duur. — En mi opinión es demasiado caro.
• [can.] Daarover verschillen we van mening. — Sobre eso discrepamos.
• [perf.] Ik heb mijn mening veranderd. — He cambiado de opinión.
• [vraag] Wat is jouw mening hierover? — ¿Cuál es tu opinión sobre esto?
• [uitdr.] De meningen zijn verdeeld. — Las opiniones están divididas.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la opinión, el parecer' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'la opinión, el parecer' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

-- ------------------------------------------------------------------ frase 1
INSERT INTO words_es (text, word_type, notes)
SELECT 'En mi opinión es demasiado caro.', 'SENTENCE', 'Ejemplo de "mening" (inv.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
                  WHERE text = 'En mi opinión es demasiado caro.' AND notes = 'Ejemplo de "mening" (inv.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'En mi opinión es demasiado caro.' AND notes = 'Ejemplo de "mening" (inv.)' LIMIT 1),
    'nl_NL', 'Volgens mij is het te duur.', 'Foljens mei is et te dur.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En mi opinión es demasiado caro.' AND notes = 'Ejemplo de "mening" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'En mi opinión es demasiado caro.' AND notes = 'Ejemplo de "mening" (inv.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'la opinión, el parecer' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'En mi opinión es demasiado caro.' AND notes = 'Ejemplo de "mening" (inv.)' LIMIT 1),
    'EXAMPLE');

-- ------------------------------------------------------------------ frase 2
INSERT INTO words_es (text, word_type, notes)
SELECT 'Sobre eso discrepamos. (presente)', 'SENTENCE', 'Ejemplo de "mening" (can.)'
WHERE NOT EXISTS (SELECT 1 FROM words_es
                  WHERE text = 'Sobre eso discrepamos. (presente)' AND notes = 'Ejemplo de "mening" (can.)');

INSERT OR IGNORE INTO words_lang (word_es_id, lang_code, text, pronunciation)
VALUES ((SELECT id FROM words_es WHERE text = 'Sobre eso discrepamos. (presente)' AND notes = 'Ejemplo de "mening" (can.)' LIMIT 1),
    'nl_NL', 'Daarover verschillen we van mening.', 'Daarofer fersjillen we fan mening.');

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Sobre eso discrepamos. (presente)' AND notes = 'Ejemplo de "mening" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'palabras dificiles - moeilijke woorden'));

INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES ((SELECT id FROM words_es WHERE text = 'Sobre eso discrepamos. (presente)' AND notes = 'Ejemplo de "mening" (can.)' LIMIT 1),
    (SELECT id FROM word_groups WHERE title = 'generic'));

INSERT OR IGNORE INTO word_es_relations (word_es_id_a, word_es_id_b, relation_type)
VALUES ((SELECT id FROM words_es WHERE text = 'la opinión, el parecer' LIMIT 1),
    (SELECT id FROM words_es WHERE text = 'Sobre eso discrepamos. (presente)' AND notes = 'Ejemplo de "mening" (can.)' LIMIT 1),
    'EXAMPLE');

-- ==============================================================================
-- 3. El bloque compartido: mening, opinie y como se opina
-- ==============================================================================
UPDATE words_es
SET rules_help = rules_help || '

💬 «Opinion» en neerlandes: mening, opinie y como se opina de verdad
La regla, en una linea: la opinion de UNA persona es de mening; opinie es la opinion COLECTIVA y la de los medios. Si la frase lleva un posesivo (mi opinion, tu opinion), es mening.

| en espanol | neerlandes | cuando |
|---|---|---|
| mi opinion, tu parecer | **de mening** | la de una persona — el 95% de las veces |
| la opinion publica | **de publieke opinie** | colectiva, de sociedad |
| un articulo de opinion | **het opiniestuk** | prensa |
| una encuesta de opinion | **de opiniepeiling** | prensa y politica |
| los que crean opinion | **de opiniemakers** | prensa y politica |

📚 El campo lexico entero, con su articulo: de mening (la opinion) · de opinie (la publica, la de los medios) · de gedachte (el pensamiento, la idea) · het idee (la idea) · het standpunt (la postura) · de opvatting (la concepcion) · de overtuiging (la conviccion) · het oordeel (el juicio) · de indruk (la impresion) · de visie (la vision, el enfoque).

🗣️ Y ahora lo util: como se OPINA, de lo mas hablado a lo mas formal.

| en espanol | neerlandes | registro |
|---|---|---|
| yo creo que, me parece que | **volgens mij** | lo que se dice al hablar, todo el rato |
| me parece, opino | **ik vind (dat)** | hablado, valoracion personal |
| en mi opinion | **naar mijn mening** | formal, escrito |
| a mi juicio | **mijns inziens** (m.i.) | muy formal, casi solo escrito |
| soy de la opinion de que | **ik ben van mening dat** | formal |

⚠️ ik denk dat no es ik vind dat, aunque el espanol los mezcle en «creo»: ik denk = creo, supongo, es una creencia sobre un hecho (Ik denk dat hij ziek is); ik vind = me parece, es una valoracion (Ik vind het te duur). Decir «Ik denk dat het te duur is» suena a que lo calculas, no a que te parezca caro.

🤝 Las formulas fijas con mening, que se aprenden enteras: naar mijn mening · van mening zijn dat · van mening verschillen (met iemand, over iets) · de meningen zijn verdeeld (las opiniones estan divididas) · een mening vormen (formarse una opinion) · zijn mening geven (dar su opinion) · Wat is jouw mening hierover?

🔀 verschillen, el verbo de discrepar — ficha completa:
Regimen: verschillen VAN algo (ser distinto de: Dit verschilt van dat) · van mening verschillen MET iemand OVER iets (discrepar con alguien sobre algo). Es debil y no separable.

| persona | presente | imperfecto |
|---|---|---|
| ik | verschil | verschilde |
| jij / je | verschilt | verschilde |
| u | verschilt | verschilde |
| hij / zij / het | verschilt | verschilde |
| wij | verschillen | verschilden |
| jullie | verschillen | verschilden |
| zij (plural) | verschillen | verschilden |

• participio — verschild, con hebben: We hebben altijd van mening verschild. En la practica se usa mas en presente e imperfecto.
• al invertir, jij pierde la -t: Verschil jij daarin van mening? — no «verschilt jij».
• el sustantivo — het verschil (la diferencia), plural de verschillen ↔ de overeenkomst (la semejanza, y tambien el acuerdo o contrato). Y el adjetivo verschillend (distinto, diverso).
• antonimos — verschillen ↔ overeenkomen (coincidir, concordar) y het eens zijn (estar de acuerdo): We zijn het eens frente a We verschillen van mening.
• expresion hecha — Daarover verschillen we van mening. — Sobre eso discrepamos. Y la muy usada De meningen zijn verdeeld.',
    updated_at = datetime('now')
WHERE (id IN (862, 880) OR text = 'la opinión, el parecer')
  AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%💬 «Opinion» en neerlandes%';
