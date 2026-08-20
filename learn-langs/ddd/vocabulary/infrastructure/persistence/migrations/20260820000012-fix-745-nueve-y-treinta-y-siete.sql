-- Learn Languages App - Fix 745: 9:37 es «las nueve y treinta y siete»
-- Migration: 20260820000012-fix-745-nueve-y-treinta-y-siete.sql
-- Description: la tarjeta del 9:37 se creo con «las diez menos veintitres», que en espanol
--   nadie dice con 23 minutos: lo natural es «las nueve y treinta y siete». Se corrige el
--   texto de la tarjeta, el primer ejemplo de words_lang.notes que lo repetia, y la linea ⚠️
--   de la ayuda, que se apoyaba en ese «menos» para explicar el cruce de los dos idiomas: se
--   reescribe diciendo lo que de verdad pasa — el espanol puede contar de las dos maneras y
--   el neerlandes solo tiene un camino, contar desde la MEDIA.
--   OJO al aplicarla: hay que borrar tambien data/audio/word-745-es-es-castellano.mp3, porque
--   la cache de audio va por id y no se entera del cambio de texto (el -nl-nl- se queda: el
--   neerlandes no cambia). Se hizo a mano el 2026-08-20.
--   IDEMPOTENTE: los REPLACE buscan el texto viejo, que tras la primera pasada ya no existe.
--   Escrita fuera de migrations/ y movida ya terminada.

-- Texto de la tarjeta
UPDATE words_es
SET text = 'las nueve y treinta y siete (9:37)',
    updated_at = datetime('now')
WHERE id = 745
  AND text = 'las diez menos veintitrés (9:37)';

-- La línea ⚠️ de la ayuda, que se apoyaba en el «menos»
UPDATE words_es
SET rules_help = REPLACE(
    rules_help,
    '⚠️ Aqui se cruzan los dos idiomas: el espanol ya cuenta hacia atras (las diez menos veintitres) y el neerlandes todavia cuenta hacia delante desde la media. No traduzcas: recalcula desde el reloj.',
    '⚠️ Aqui se cruzan los dos idiomas. El espanol puede contar de dos maneras —hacia delante (las nueve y treinta y siete) o hacia atras (las diez menos veintitres)— pero el neerlandes solo tiene un camino: contar desde la MEDIA, hacia delante. No traduzcas: recalcula desde el reloj.'
)
WHERE id = 745
  AND instr(COALESCE(rules_help, ''), 'el espanol ya cuenta hacia atras (las diez menos veintitres)') > 0;

-- El primer ejemplo, que repetía la traducción vieja
UPDATE words_lang
SET notes = REPLACE(
    notes,
    'Het is zeven over half tien. — Son las diez menos veintitrés.',
    'Het is zeven over half tien. — Son las nueve y treinta y siete.'
),
    updated_at = datetime('now')
WHERE word_es_id = 745
  AND instr(COALESCE(notes, ''), 'Son las diez menos veintitrés.') > 0;
