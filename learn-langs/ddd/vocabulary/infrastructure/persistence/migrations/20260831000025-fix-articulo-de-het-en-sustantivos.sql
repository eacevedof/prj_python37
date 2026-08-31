-- Learn Languages App - Todo sustantivo se estudia CON su articulo (de/het) - repaso completo
-- Migration: 20260831000025-fix-articulo-de-het-en-sustantivos.sql
-- Description: Eduardo, sobre la 780: «incluye de/het, repasa todos los sustantivos a ver donde
--   falta — en el examen siempre tengo que indicar el articulo, asi refuerzo si la palabra es
--   de o het». Es la misma norma que ya se aplicaba a la ayuda (citar el sustantivo con su
--   articulo), pero llevada a la RESPUESTA de la tarjeta: si el articulo no esta en words_lang,
--   el examen no lo pide y el genero no se fija nunca.
--   Repaso de las 196 tarjetas WORD y las 395 PHRASE, comparando el articulo espanol con el
--   neerlandes. Resultado: 125 sustantivos ya lo llevaban bien, 4 sin articulo y 1 con el
--   articulo EQUIVOCADO. Se corrigen los cinco:
--     · 780 afschrikking -> de afschrikking (su propia ayuda ya decia «de afschrikking»)
--     ·  95 de deurkozijn -> het deurkozijn — ERROR de genero: kozijn es het-woord, como ya
--          estaba bien en su gemela, la 121 het raamkozijn
--     ·   6 dag -> de dag ·  8 voetballer -> de voetballer ·  9 nachtkastje -> het nachtkastje
--   En las tres ultimas el espanol tampoco llevaba articulo y se lo anade, que es como estan las
--   otras 125 (el dia, el futbolista, la mesa de noche). Se actualiza tambien la pronunciacion
--   donde existia (95 y 780); ninguna de las cinco tiene audio generado, asi que no queda nada
--   desincronizado.
--   El corrector es por distancia de Levenshtein: olvidar el articulo ya no da 1.0 (baja a ~0.8),
--   que es justo el refuerzo que se busca.
--   Nota de las que NO se tocan: 80 «de matras» (el Groene Boekje admite het y de) y las 33
--   tarjetas WORD que siguen SIN traduccion neerlandesa (159-203), que es harina de otro costal.
--   100% aditiva e idempotente: cada UPDATE lleva guard por el texto exacto.

-- ==============================================================================
-- 1. 780 la disuasion: afschrikking -> de afschrikking
-- ==============================================================================
UPDATE words_lang
SET text = 'de afschrikking',
    pronunciation = 'de afsjrikkinj',
    updated_at = datetime('now')
WHERE word_es_id = 780
  AND text = 'afschrikking';

-- ==============================================================================
-- 2. 95 el marco de la puerta: de deurkozijn -> het deurkozijn (genero equivocado)
-- ==============================================================================
UPDATE words_lang
SET text = 'het deurkozijn',
    pronunciation = 'het dur-ko-zein',
    updated_at = datetime('now')
WHERE word_es_id = 95
  AND text = 'de deurkozijn';

-- ==============================================================================
-- 3. 6 dia: dag -> de dag
-- ==============================================================================
UPDATE words_lang
SET text = 'de dag',
    updated_at = datetime('now')
WHERE word_es_id = 6
  AND text = 'dag';

UPDATE words_es
SET text = 'el día',
    updated_at = datetime('now')
WHERE id = 6
  AND text = 'día';

-- ==============================================================================
-- 4. 8 futbolista: voetballer -> de voetballer
-- ==============================================================================
UPDATE words_lang
SET text = 'de voetballer',
    updated_at = datetime('now')
WHERE word_es_id = 8
  AND text = 'voetballer';

UPDATE words_es
SET text = 'el futbolista',
    updated_at = datetime('now')
WHERE id = 8
  AND text = 'futbolista';

-- ==============================================================================
-- 5. 9 mesa de noche: nachtkastje -> het nachtkastje (diminutivo, siempre het)
-- ==============================================================================
UPDATE words_lang
SET text = 'het nachtkastje',
    updated_at = datetime('now')
WHERE word_es_id = 9
  AND text = 'nachtkastje';

UPDATE words_es
SET text = 'la mesa de noche',
    updated_at = datetime('now')
WHERE id = 9
  AND text = 'mesa de noche';
