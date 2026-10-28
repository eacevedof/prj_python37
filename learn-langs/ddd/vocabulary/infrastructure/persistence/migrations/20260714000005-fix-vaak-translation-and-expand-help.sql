-- Learn Languages App - Corrige traducción vaak y amplía ayuda de la tarjeta hen (id 642)
-- Migration: 20260714000005-fix-vaak-translation-and-expand-help.sql
-- Description: La tarjeta "Ik denk vaak aan hen" (grupo pronombres átono/tónico) tenía el
--   español "pienso mucho en ellos", que corresponde a veel, no a vaak (frecuencia).
--   (1) corrige el text -> "pienso a menudo en ellos";
--   (2) corrige ese paréntesis dentro del rules_help;
--   (3) amplía la ayuda con un bloque 🔁 sobre vaak (frecuencia) vs veel (cantidad).
--   Todo keyeado por notes (único), idempotente. NO toca words_lang (el neerlandés y el
--   audio están bien), ni imágenes, ni notes.

PRAGMA foreign_keys = ON;

-- (1) corregir el español del prompt: mucho -> a menudo (para casar con vaak)
UPDATE words_es SET text = 'pienso a menudo en ellos'
WHERE notes = 'Átono/tónico: hen (zij pl tras preposición)' AND text = 'pienso mucho en ellos';

-- (2) corregir el mismo paréntesis dentro de la ayuda
UPDATE words_es
SET rules_help = REPLACE(rules_help, '(pienso mucho en ellos)', '(pienso a menudo en ellos)')
WHERE notes = 'Átono/tónico: hen (zij pl tras preposición)'
  AND rules_help LIKE '%(pienso mucho en ellos)%';

-- (3) ampliar la ayuda: distinción vaak (frecuencia) vs veel (cantidad)
UPDATE words_es
SET rules_help = rules_help || '

🔁 vaak vs veel (a menudo vs mucho): vaak mide FRECUENCIA (cuántas veces) → Ik denk vaak aan hen = pienso a menudo en ellos. veel mide CANTIDAD/intensidad (cuánto) → Ik denk veel aan hen = pienso mucho en ellos. En español coloquial los dos caen en "mucho", pero en neerlandés se distinguen. Con verbos de actividad se ve claro: Ik werk vaak (a menudo, muchos días) vs Ik werk veel (muchas horas). Ojo: con nadenken (reflexionar) suele ir veel → Ik heb er veel over nagedacht (le he dado muchas vueltas).'
WHERE notes = 'Átono/tónico: hen (zij pl tras preposición)'
  AND rules_help NOT LIKE '%🔁%';
