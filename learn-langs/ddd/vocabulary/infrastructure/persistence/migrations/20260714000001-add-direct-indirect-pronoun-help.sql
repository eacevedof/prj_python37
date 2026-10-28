-- Learn Languages App - Ayuda directo/indirecto en el trío ze/hen/hun (a ellos)
-- Migration: 20260714000001-add-direct-indirect-pronoun-help.sql
-- Description: Añade un bloque "🎯 directo vs indirecto" al rules_help de las 3 tarjetas
--   del grupo pronombres que usan el trío de 3ª persona plural: ze (personas, directo),
--   hen (directo) y hun (indirecto). Aclara: ze = comodín átono para directo e indirecto
--   (lo normal al hablar); hen = directo/tras preposición (formal); hun = indirecto
--   (formal); registro y énfasis. Corre DESPUÉS de 20260713000004 (que añade el 🧭).
--   100% aditiva e IDEMPOTENTE: solo UPDATE de words_es.rules_help (APPEND) con guarda
--   NOT LIKE '%🎯%'. NO toca words_lang (audio_path), imágenes, notes ni text.

PRAGMA foreign_keys = ON;

-- ze (personas plural) — Ik heb ze gisteren gezien. (DIRECTO)
UPDATE words_es SET rules_help = rules_help || '

🎯 ze / hen / hun (a ellos): ze es el comodín átono y lo más normal al hablar; sirve para directo E indirecto. Aquí es objeto DIRECTO (los vi = ze). Equivalente formal en directo: hen (Ik heb hen gisteren gezien). Para el INDIRECTO (les) la forma cuidada es hun. ze nunca se acentúa; para enfatizar usa hen/hun (o aan hen).'
WHERE notes = 'Pronombre objeto: ze (personas plural)' AND rules_help NOT LIKE '%🎯%';

-- hen (directo) — Ik heb hen niet uitgenodigd. (DIRECTO)
UPDATE words_es SET rules_help = rules_help || '

🎯 hen vs hun vs ze: hen = objeto DIRECTO de personas (los) y tras preposición (aan hen, voor hen); registro cuidado. Coloquial y neutro: ze (Ik heb ze niet uitgenodigd). Para el objeto INDIRECTO (les) → hun. hen/hun admiten énfasis; ze no.'
WHERE notes = 'Pronombre objeto: hen (directo)' AND rules_help NOT LIKE '%🎯%';

-- hun (indirecto) — Ik heb hun niets verteld. (INDIRECTO)
UPDATE words_es SET rules_help = rules_help || '

🎯 hun vs hen vs ze: hun = objeto INDIRECTO de personas (les, a ellos), sin preposición — iets aan iemand vertellen; registro cuidado. Coloquial: ze, mismo sentido pero átono (Ik heb ze niets verteld). El DIRECTO (los) es hen. Para recalcar a ELLOS usa hun / aan hen: Ik heb hun niets verteld, maar jou wél. Ojo: hun como SUJETO (hun hebben…) está mal; como indirecto es correcto.'
WHERE notes = 'Pronombre objeto: hun (indirecto)' AND rules_help NOT LIKE '%🎯%';
