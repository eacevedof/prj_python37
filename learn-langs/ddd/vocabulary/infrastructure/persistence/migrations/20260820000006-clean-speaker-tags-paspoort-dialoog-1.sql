-- Learn Languages App - Limpieza: fuera los marcadores «(NN · hablante)» del grupo 25
-- Migration: 20260820000006-clean-speaker-tags-paspoort-dialoog-1.sql
-- Description: las 24 tarjetas de «paspoort dialoog 1» llevaban al final del texto espanol un
--   marcador de turno y hablante —«(01 · yo)», «(07 · empleado)»— pensado como anotacion
--   visual. Pero el slider LOCUTA el texto espanol (word_slider_controller: _play_text_audio
--   con es_ES), asi que el marcador se lee en voz alta y estorba. Eduardo deduce por contexto
--   a quien le toca cada frase, asi que se quita del texto.
--   No se pierde nada: el numero de turno y el hablante siguen en words_es.notes
--   («paspoort dialoog 1: 07 empleado - numero y ventanilla») y el dialogo entero, en orden,
--   sigue en el rules_help de las 24 tarjetas.
--   El corte es por el primer « (» del texto, que en estas 24 frases solo aparece en el
--   marcador (ninguna lleva parentesis legitimo). IDEMPOTENTE: tras la pasada no queda texto
--   que case con «% (%)».
--   Nota: Eduardo ya habia editado dos a mano desde la app — la 731, donde el borrado dejo un
--   «(yo)» suelto, y la 739, que quedo limpia. Por eso el patron es «% (%)» y no «%(__ · %)»:
--   asi barre tambien los restos a medio quitar y respeta las ya limpias.
--   OJO al aplicarla: hay que borrar tambien los mp3 ES ya cacheados de estas tarjetas
--   (data/audio/word-<id>-es-es-castellano.mp3), porque la cache va por id y no se entera
--   del cambio de texto. Se hizo a mano el 2026-08-20 (14 ficheros).
--   Escrita fuera de migrations/ y movida ya terminada (leccion del 2026-08-20).

UPDATE words_es
SET text = RTRIM(SUBSTR(text, 1, INSTR(text, ' (') - 1)),
    updated_at = datetime('now')
WHERE id IN (
    SELECT word_es_id FROM word_es_groups
    WHERE group_id = (SELECT id FROM word_groups WHERE title = 'paspoort dialoog 1')
)
AND text LIKE '% (%)'
AND INSTR(text, ' (') > 0;
