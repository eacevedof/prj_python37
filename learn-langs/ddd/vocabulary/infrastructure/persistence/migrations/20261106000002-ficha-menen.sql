-- Learn Languages App - Migration
-- Migration: 20261106000002-ficha-menen
-- Description: Eduardo (2026-11-06): «en 1669 en palabra a palabra incluye meen nuevo verbo para mi, cuando se usa».
--
--   La 1669 (Houd je me voor de gek of meen je het?) gana en su 📖 la viñeta de menen y, delante del 🧩, la ficha
--   del verbo del §2 (tabla de conjugación, participio, inversión, sin preposición, sin antónimo claro, de mening,
--   no separable) más la tabla '🗣️ Cuándo se usa menen' con sus seis usos y la trampa menen ≠ bedoelen. El mismo
--   bloque, byte a byte (§3.3), va a la PHRASE y la SENTENCE de jerga 'dat meen je niet', que tratan del verbo.
--   En la 1669 la viñeta vieja de 📖 se corrige: ya no dice 'querer decir' (eso es bedoelen).

UPDATE words_es SET rules_help = REPLACE(rules_help, '• houden voor — tomar por, Ik hield hem voor een Duitser.

🧩 Expresión fija — ', '• houden voor — tomar por, Ik hield hem voor een Duitser.
• menen — decir algo en serio; ficha completa debajo.

📐 Conjugacion de menen (débil · simple):

| persona | presente | imperfecto |
|---|---|---|
| ik | meen | meende |
| jij / je | meent | meende |
| u | meent | meende |
| hij / zij / het | meent | meende |
| wij | menen | meenden |
| jullie | menen | meenden |
| zij (plural) | menen | meenden |

• participio — gemeend, con hebben y con ge- normal, porque menen es un verbo simple: Ik heb het niet zo gemeend (no lo he dicho con esa intención).
• al invertir, jij pierde la -t: Meen je het? — no «meent je het».
• la raíz — meen, con ee doble porque la sílaba se cierra; en menen la e ya es larga y va sola.
• preposicion — ninguna, es transitivo directo: iets menen, het menen.
• antonimo — no tiene uno claro; lo contrario se dice con una frase, Het was maar een grapje (solo era una broma).
• sustantivo — de mening, la opinión, con over: Wat is jouw mening over het plan? (¿qué opinas del plan?); van mening zijn dat, opinar que. Y el adjetivo gemeend, sincero: een gemeend compliment.
• separable — no, es un verbo simple, sin partícula.

🗣️ Cuándo se usa menen:

| # | uso | ejemplo | español |
|---|---|---|---|
| 1 | decir algo en serio, el uso de cada día | Ik meen het. | Lo digo en serio. |
| 2 | sorpresa, no me lo creo | Dat meen je niet! | ¡No me digas! |
| 3 | pregunta para comprobar | Meen je dat? | ¿Lo dices en serio? |
| 4 | la intención | Hij meent het goed. | Lo hace con buena intención. |
| 5 | creer, opinar, formal o escrito | Ik meen dat hij gelijk heeft. | Creo que tiene razón. |
| 6 | creer algo que resulta falso, en imperfecto | Ik meende je te kennen. | Creía que te conocía. |

⚠️ Querer decir no es menen sino bedoelen, Wat bedoel je? (¿qué quieres decir?). En Bélgica se oye Wat meen je?, en los Países Bajos suena raro.

🔑 El truco que casi nunca falla: si en español cabe en serio, es menen, y si cabe querer decir, es bedoelen.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'frases hechas: iemand voor de gek houden' AND word_type = 'PHRASE' LIMIT 1)) AND rules_help NOT LIKE '%📐 Conjugacion de menen%';

UPDATE words_es SET rules_help = REPLACE(rules_help, '• menen — decir algo en serio, querer decir, Ik meen het, lo digo en serio.

🧩 Expresión fija — ', '• menen — decir algo en serio, Ik meen het, lo digo en serio; ficha completa debajo.

📐 Conjugacion de menen (débil · simple):

| persona | presente | imperfecto |
|---|---|---|
| ik | meen | meende |
| jij / je | meent | meende |
| u | meent | meende |
| hij / zij / het | meent | meende |
| wij | menen | meenden |
| jullie | menen | meenden |
| zij (plural) | menen | meenden |

• participio — gemeend, con hebben y con ge- normal, porque menen es un verbo simple: Ik heb het niet zo gemeend (no lo he dicho con esa intención).
• al invertir, jij pierde la -t: Meen je het? — no «meent je het».
• la raíz — meen, con ee doble porque la sílaba se cierra; en menen la e ya es larga y va sola.
• preposicion — ninguna, es transitivo directo: iets menen, het menen.
• antonimo — no tiene uno claro; lo contrario se dice con una frase, Het was maar een grapje (solo era una broma).
• sustantivo — de mening, la opinión, con over: Wat is jouw mening over het plan? (¿qué opinas del plan?); van mening zijn dat, opinar que. Y el adjetivo gemeend, sincero: een gemeend compliment.
• separable — no, es un verbo simple, sin partícula.

🗣️ Cuándo se usa menen:

| # | uso | ejemplo | español |
|---|---|---|---|
| 1 | decir algo en serio, el uso de cada día | Ik meen het. | Lo digo en serio. |
| 2 | sorpresa, no me lo creo | Dat meen je niet! | ¡No me digas! |
| 3 | pregunta para comprobar | Meen je dat? | ¿Lo dices en serio? |
| 4 | la intención | Hij meent het goed. | Lo hace con buena intención. |
| 5 | creer, opinar, formal o escrito | Ik meen dat hij gelijk heeft. | Creo que tiene razón. |
| 6 | creer algo que resulta falso, en imperfecto | Ik meende je te kennen. | Creía que te conocía. |

⚠️ Querer decir no es menen sino bedoelen, Wat bedoel je? (¿qué quieres decir?). En Bélgica se oye Wat meen je?, en los Países Bajos suena raro.

🔑 El truco que casi nunca falla: si en español cabe en serio, es menen, y si cabe querer decir, es bedoelen.

🧩 Expresión fija — '), updated_at = datetime('now')
 WHERE id IN ((SELECT id FROM words_es WHERE notes = 'jerga: dat meen je niet' AND word_type = 'PHRASE' LIMIT 1), (SELECT word_es_id_b FROM word_es_relations WHERE word_es_id_a = (SELECT id FROM words_es WHERE notes = 'jerga: dat meen je niet' AND word_type = 'PHRASE' LIMIT 1) AND relation_type = 'EXAMPLE' LIMIT 1)) AND rules_help NOT LIKE '%📐 Conjugacion de menen%';

