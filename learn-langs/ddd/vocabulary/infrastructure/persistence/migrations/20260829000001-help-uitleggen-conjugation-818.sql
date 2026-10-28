-- Learn Languages App - Conjugacion de uitleggen en la ayuda de la tarjeta 818
-- Migration: 20260829000001-help-uitleggen-conjugation-818.sql
-- Description: La tarjeta 818 ("Lo explico otra vez, con calma y despacio.") usa el pasado
--   de uitleggen (explicar), separable de leggen (poner, debil). Se anade a su rules_help la
--   conjugacion de uitleggen (presente, pasado, participio) para justificar "legde uit".
--   100% aditiva e idempotente: solo UPDATE con guard (rules_help IS NULL).

UPDATE words_es
SET rules_help = 'Esta frase usa el pasado de uitleggen (explicar), separable de leggen (poner, colocar). leggen es debil (regular): raiz leg + -de/-den en pasado, ge-...-d en participio.

📐 Conjugacion de uitleggen:
• presente — ik leg uit · jij/hij legt uit · wij/jullie/zij leggen uit
• pasado (imperfecto) — ik/jij/hij legde uit · wij/jullie/zij legden uit
• participio — uitgelegd (heeft uitgelegd)

🗣 En la frase: Hij legde het nogmaals uit. — Lo explicó otra vez. (pasado, singular: legde uit)
• presente — Ze legt het altijd heel duidelijk uit. — Siempre lo explica muy claro.
• participio — Heb je het al uitgelegd? — ¿Ya lo has explicado?',
    updated_at = datetime('now')
WHERE id = 818
  AND rules_help IS NULL;
