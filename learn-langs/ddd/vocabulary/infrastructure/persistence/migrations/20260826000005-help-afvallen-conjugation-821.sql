-- Learn Languages App - Conjugacion de afvallen en la ayuda de la tarjeta 821
-- Migration: 20260826000005-help-afvallen-conjugation-821.sql
-- Description: La tarjeta 821 ("He adelgazado cinco kilos.") usa el perfecto de afvallen
--   (adelgazar), separable de vallen (caer, fuerte). Se anade a su rules_help la conjugacion
--   de afvallen (presente, imperfecto, participio), incluido el porque de "ben" en vez de
--   "heb" en el perfecto (auxiliar zijn, verbo de cambio de estado).
--   100% aditiva e idempotente: solo UPDATE con guard (rules_help IS NULL).

UPDATE words_es
SET rules_help = 'afvallen = af + vallen. vallen es fuerte (val-viel-gevallen) y usa zijn como auxiliar del perfecto, por ser verbo de cambio de estado/movimiento: por eso "ben afgevallen", no "heb afgevallen".

📐 Conjugacion de afvallen:
• presente — ik val af · jij/hij valt af · wij/jullie/zij vallen af
• imperfecto (pasado) — ik/jij/hij viel af · wij/jullie/zij vielen af
• participio — afgevallen (is/ben afgevallen)

🗣 En la frase: Ik ben vijf kilo afgevallen. — He adelgazado cinco kilos. (perfecto: ben + participio)
• presente — Hij valt steeds meer af. — Cada vez adelgaza más.
• pasado — Ze viel vorig jaar tien kilo af. — Adelgazó diez kilos el año pasado.

📌 Regla de bolsillo: los verbos de vallen (caer, y sus compuestos: afvallen, opvallen, uitvallen…) casi siempre van con zijn en el perfecto, igual que gaan o komen — porque describen un cambio de estado o de lugar, no una acción que se hace sobre algo.',
    updated_at = datetime('now')
WHERE id = 821
  AND rules_help IS NULL;
