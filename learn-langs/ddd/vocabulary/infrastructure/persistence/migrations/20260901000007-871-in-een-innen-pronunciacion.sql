-- Learn Languages App - la 871 al grupo de pronunciacion: «in een» suena «innen»
-- Migration: 20260901000007-871-in-een-innen-pronunciacion.sql
-- Description: Eduardo sobre la 871 (omgezet in een concreet plan): «el "in een" me cuesta»,
--   en el contexto del grupo 33 (pronunciacion - palabras que se pegan al hablar). Es el
--   fenomeno que el propio grupo lista: la een atona se reduce a 'n y se pega a la preposicion,
--   asi que in een suena «innen» como una sola palabra (igual van een → fannen, met een →
--   metten, op een → oppen). Tres cambios: (1) la 871 entra en el grupo 33; (2) su
--   pronunciation deja de escribir «in en» separado y pasa a «innen», que es lo que se oye;
--   (3) bloque 🔗 en su ayuda con la regla, cuatro ejemplos, el truco (dilo como UNA palabra
--   llana acabada en -en) y la excepcion (geen y el numeral één llevan e plena y tonica).
--   Sin audio que desincronizar (audio_path/audio_url a NULL en la 871). Idempotente: texto
--   viejo exacto en el WHERE de la pronunciacion, OR IGNORE en la membresia y guard 🔗 +
--   IS NOT NULL en el append.

PRAGMA foreign_keys = ON;

-- 1. Al grupo de pronunciacion
INSERT OR IGNORE INTO word_es_groups (word_es_id, group_id)
VALUES (871, (SELECT id FROM word_groups WHERE title = 'pronunciacion - palabras que se pegan al hablar'));

-- 2. La pronunciacion, como suena de verdad
UPDATE words_lang
SET pronunciation = 'Se eft et ide omjeset innen konkret plan.'
WHERE word_es_id = 871
  AND pronunciation = 'Se eft et ide omjeset in en konkret plan.';

-- 3. El fenomeno, en la ayuda
UPDATE words_es
SET rules_help = rules_help || '

🔗 Por que «in een» se traba — y como suena de verdad:

En el habla, een es ATONO y se reduce a ''n (una vocal muda, sin cuerpo): nunca suena «e-en». La preposicion se lo come, y las dos palabras suenan como UNA sola, llana y acabada en -en:
• in een concreet plan → innen konkret plan (in + ''n = «innen»)
• van een vriend → fannen frint
• met een mes → metten mes
• op een dag → oppen daj

🔑 El truco: no intentes decir dos palabras. Di la preposicion con -en pegada detras (innen, fannen, metten, oppen) y een ya esta dicho. Si te suena a una sola palabra, lo estas haciendo bien.

⚠️ No lo confundas con geen (jen), cuya e SI es plena y tonica: Ik heb geen honger. La e de een solo es plena cuando es el numero uno («UN cafe, no dos»), y entonces se escribe één, con tilde.'
WHERE id = 871 AND rules_help IS NOT NULL
  AND rules_help NOT LIKE '%🔗%';
