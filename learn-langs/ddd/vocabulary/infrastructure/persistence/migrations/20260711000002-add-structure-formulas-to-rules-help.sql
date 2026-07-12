-- Learn Languages App - Fórmulas de estructura en las ayudas (rules_help)
-- Migration: 20260711000002-add-structure-formulas-to-rules-help.sql
-- Description: Añade a rules_help la fórmula de orden de palabras que corresponde a cada
--   frase, en TODOS los grupos: subordinada (bijzin), inversión, pregunta con interrogativo,
--   pregunta sí/no, oración principal (hoofdzin) y frase hecha. La clasificación usa:
--   1) el tipo anotado en las tarjetas de ejemplo (notes 'Ejemplo de "..." (vraag|bijzin|can.|inv.|uitdr.)')
--   2) la estructura del texto NL (termina en ?, empieza por palabra-W, pronombre sujeto o conjunción).
--   Idempotente: cada palabra recibe UNA fórmula como máximo (guarda NOT LIKE '%📐%') y el
--   contenido previo de rules_help se conserva (la fórmula se AÑADE al final, nunca se pisa).
--   No toca notes, audio_path ni imágenes.

PRAGMA foreign_keys = ON;

-- ==============================================================================
-- 1. Frases hechas (uitdr.): orden fijo, sin fórmula que aplicar
-- ==============================================================================
UPDATE words_es
SET rules_help = CASE
        WHEN rules_help IS NULL OR rules_help = '' THEN '📐 Frase hecha: orden fijo, se memoriza tal cual.'
        ELSE rules_help || char(10) || char(10) || '📐 Frase hecha: orden fijo, se memoriza tal cual.'
    END,
    updated_at = datetime('now')
WHERE (rules_help IS NULL OR rules_help NOT LIKE '%📐%')
AND notes LIKE 'Ejemplo de %(uitdr.)';

-- ==============================================================================
-- 2. Subordinadas anotadas (bijzin)
-- ==============================================================================
UPDATE words_es
SET rules_help = CASE
        WHEN rules_help IS NULL OR rules_help = '' THEN '📐 Subordinada (bijzin): conjunción (dat/of/omdat/als…) + sujeto + complementos + TODOS los verbos al final. Si la subordinada va delante, la principal sigue con inversión: verbo + sujeto.'
        ELSE rules_help || char(10) || char(10) || '📐 Subordinada (bijzin): conjunción (dat/of/omdat/als…) + sujeto + complementos + TODOS los verbos al final. Si la subordinada va delante, la principal sigue con inversión: verbo + sujeto.'
    END,
    updated_at = datetime('now')
WHERE (rules_help IS NULL OR rules_help NOT LIKE '%📐%')
AND notes LIKE 'Ejemplo de %(bijzin)';

-- ==============================================================================
-- 3. Inversiones anotadas (inv.)
-- ==============================================================================
UPDATE words_es
SET rules_help = CASE
        WHEN rules_help IS NULL OR rules_help = '' THEN '📐 Inversión: complemento (tiempo/lugar/objeto…) en 1ª posición + verbo conjugado (2ª posición) + sujeto + resto; los demás verbos al final.'
        ELSE rules_help || char(10) || char(10) || '📐 Inversión: complemento (tiempo/lugar/objeto…) en 1ª posición + verbo conjugado (2ª posición) + sujeto + resto; los demás verbos al final.'
    END,
    updated_at = datetime('now')
WHERE (rules_help IS NULL OR rules_help NOT LIKE '%📐%')
AND notes LIKE 'Ejemplo de %(inv.)';

-- ==============================================================================
-- 4. Preguntas con palabra interrogativa (W-vraag): texto NL termina en ? y
--    empieza por wie/wat/waar/wanneer/waarom/hoe/welk(e)/hoeveel
-- ==============================================================================
UPDATE words_es
SET rules_help = CASE
        WHEN rules_help IS NULL OR rules_help = '' THEN '📐 Pregunta con interrogativo (W-vraag): palabra-W (wat/waar/wie/hoe/wanneer/waarom…) + verbo conjugado + sujeto + resto; los demás verbos al final.'
        ELSE rules_help || char(10) || char(10) || '📐 Pregunta con interrogativo (W-vraag): palabra-W (wat/waar/wie/hoe/wanneer/waarom…) + verbo conjugado + sujeto + resto; los demás verbos al final.'
    END,
    updated_at = datetime('now')
WHERE (rules_help IS NULL OR rules_help NOT LIKE '%📐%')
AND word_type IN ('PHRASE', 'SENTENCE')
AND EXISTS (
    SELECT 1 FROM words_lang wl
    WHERE wl.word_es_id = words_es.id
    AND wl.lang_code = 'nl_NL'
    AND wl.text LIKE '%?'
    AND (
        wl.text LIKE 'wie %' OR wl.text LIKE 'wat %' OR wl.text LIKE 'waar%'
        OR wl.text LIKE 'wanneer %' OR wl.text LIKE 'waarom %' OR wl.text LIKE 'hoe%'
        OR wl.text LIKE 'welk%'
    )
);

-- ==============================================================================
-- 5. Resto de preguntas (sí/no, ja/nee-vraag): texto NL termina en ?
-- ==============================================================================
UPDATE words_es
SET rules_help = CASE
        WHEN rules_help IS NULL OR rules_help = '' THEN '📐 Pregunta sí/no (ja/nee-vraag): verbo conjugado en 1ª posición + sujeto + resto; los demás verbos al final (con jij el verbo pierde la -t: zul jij?).'
        ELSE rules_help || char(10) || char(10) || '📐 Pregunta sí/no (ja/nee-vraag): verbo conjugado en 1ª posición + sujeto + resto; los demás verbos al final (con jij el verbo pierde la -t: zul jij?).'
    END,
    updated_at = datetime('now')
WHERE (rules_help IS NULL OR rules_help NOT LIKE '%📐%')
AND word_type IN ('PHRASE', 'SENTENCE')
AND EXISTS (
    SELECT 1 FROM words_lang wl
    WHERE wl.word_es_id = words_es.id
    AND wl.lang_code = 'nl_NL'
    AND wl.text LIKE '%?'
);

-- ==============================================================================
-- 6. Principales anotadas (can.)
-- ==============================================================================
UPDATE words_es
SET rules_help = CASE
        WHEN rules_help IS NULL OR rules_help = '' THEN '📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
        ELSE rules_help || char(10) || char(10) || '📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
    END,
    updated_at = datetime('now')
WHERE (rules_help IS NULL OR rules_help NOT LIKE '%📐%')
AND notes LIKE 'Ejemplo de %(can.)';

-- ==============================================================================
-- 7. Frases que empiezan por conjunción subordinante -> subordinada
-- ==============================================================================
UPDATE words_es
SET rules_help = CASE
        WHEN rules_help IS NULL OR rules_help = '' THEN '📐 Subordinada (bijzin): conjunción (dat/of/omdat/als…) + sujeto + complementos + TODOS los verbos al final. Si la subordinada va delante, la principal sigue con inversión: verbo + sujeto.'
        ELSE rules_help || char(10) || char(10) || '📐 Subordinada (bijzin): conjunción (dat/of/omdat/als…) + sujeto + complementos + TODOS los verbos al final. Si la subordinada va delante, la principal sigue con inversión: verbo + sujeto.'
    END,
    updated_at = datetime('now')
WHERE (rules_help IS NULL OR rules_help NOT LIKE '%📐%')
AND word_type IN ('PHRASE', 'SENTENCE')
AND EXISTS (
    SELECT 1 FROM words_lang wl
    WHERE wl.word_es_id = words_es.id
    AND wl.lang_code = 'nl_NL'
    AND (
        wl.text LIKE 'omdat %' OR wl.text LIKE 'als %' OR wl.text LIKE 'hoewel %'
        OR wl.text LIKE 'terwijl %' OR wl.text LIKE 'toen %' OR wl.text LIKE 'voordat %'
        OR wl.text LIKE 'nadat %' OR wl.text LIKE 'zodat %' OR wl.text LIKE 'tenzij %'
        OR wl.text LIKE 'zodra %' OR wl.text LIKE 'omdat %'
    )
);

-- ==============================================================================
-- 8. Frases declarativas que empiezan por sujeto -> oración principal
-- ==============================================================================
UPDATE words_es
SET rules_help = CASE
        WHEN rules_help IS NULL OR rules_help = '' THEN '📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
        ELSE rules_help || char(10) || char(10) || '📐 Oración principal (hoofdzin): sujeto + verbo conjugado (2ª posición) + tiempo/manera/lugar + resto de verbos al final.'
    END,
    updated_at = datetime('now')
WHERE (rules_help IS NULL OR rules_help NOT LIKE '%📐%')
AND word_type IN ('PHRASE', 'SENTENCE')
AND EXISTS (
    SELECT 1 FROM words_lang wl
    WHERE wl.word_es_id = words_es.id
    AND wl.lang_code = 'nl_NL'
    AND (
        wl.text LIKE 'ik %' OR wl.text LIKE 'jij %' OR wl.text LIKE 'je %'
        OR wl.text LIKE 'u %' OR wl.text LIKE 'hij %' OR wl.text LIKE 'zij %'
        OR wl.text LIKE 'ze %' OR wl.text LIKE 'het %' OR wl.text LIKE 'we %'
        OR wl.text LIKE 'wij %' OR wl.text LIKE 'jullie %' OR wl.text LIKE 'dat %'
        OR wl.text LIKE 'dit %' OR wl.text LIKE 'er %' OR wl.text LIKE 'die %'
        OR wl.text LIKE 'iedereen %' OR wl.text LIKE 'alles %' OR wl.text LIKE 'niemand %'
    )
);
