-- Learn Languages App - Fuera el dígito entre paréntesis del grupo «la hora»
-- Migration: 20260820000013-clean-digit-tags-clock-group.sql
-- Description: las tarjetas de la hora llevaban el dígito al final del texto espanol —«las
--   nueve y media (9:30)»— como desambiguador visual. Pero el slider LOCUTA el texto espanol
--   (word_slider_controller: _play_text_audio con es_ES), asi que se lee en voz alta y
--   redunda: «las nueve y media, nueve treinta». Eduardo lo pide para la 744 y se aplica a
--   las 10 tarjetas del grupo que lo llevan, porque el motivo es el mismo en todas y ninguna
--   pierde claridad sin el (las 748 y 750 no tienen parentesis y no se tocan).
--   Mismo corte que en el grupo 25: por el primer « (», que en estas frases solo aparece en
--   el marcador. IDEMPOTENTE por el LIKE '% (%)'.
--   OJO al aplicarla: hay que borrar los mp3 ES ya cacheados de estas tarjetas
--   (data/audio/word-<id>-es-es-castellano.mp3), porque la cache va por id y no se entera del
--   cambio de texto. Se hizo a mano el 2026-08-20 (4 ficheros: 741, 744, 746 y 751).
--   El numero sigue estando donde hace falta: en words_es.notes de cada tarjeta
--   («hora: 9:30 - half tien (la trampa)») y en el mapa 🕰️ que llevan las 12 en su ayuda.
--   Escrita fuera de migrations/ y movida ya terminada.

UPDATE words_es
SET text = RTRIM(SUBSTR(text, 1, INSTR(text, ' (') - 1)),
    updated_at = datetime('now')
WHERE id IN (
    SELECT word_es_id FROM word_es_groups
    WHERE group_id = (SELECT id FROM word_groups WHERE title = 'la hora - hoe laat is het')
)
AND text LIKE '% (%)'
AND INSTR(text, ' (') > 0;
