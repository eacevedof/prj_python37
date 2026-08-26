-- Learn Languages App - Conjugacion de schijnen en la ayuda de la tarjeta 812
-- Migration: 20260826000003-help-schijnen-conjugation-812.sql
-- Description: La tarjeta 812 ("Antes no salia nunca, a menos que hiciera sol.") usa "de zon
--   scheen", pasado fuerte de schijnen (brillar). Se anade a su rules_help la conjugacion de
--   schijnen (presente, pasado, participio) para justificar la forma "scheen" de la frase.
--   100% aditiva e idempotente: solo UPDATE con guard (rules_help IS NULL).

UPDATE words_es
SET rules_help = 'Esta frase usa el pasado de schijnen (brillar), verbo fuerte (irregular): cambia la vocal de la raiz en vez de anadir -te/-de.

📐 Conjugacion de schijnen:
• presente — ik schijn · jij/hij schijnt · wij/jullie/zij schijnen
• pasado (imperfecto) — ik/jij/hij scheen · wij/jullie/zij schenen
• participio — geschenen (heeft geschenen)

🗣 En la frase: De zon scheen. — Brillaba el sol / Hacia sol. (pasado, singular: scheen, no ''scheende'')

🗺️ El mismo verbo, otro sentido: schijnen tambien significa "parecer" (con dat/oration), y se conjuga igual — Het schijnt dat hij ziek is. — Parece que esta enfermo. Ze scheen het niet te weten. — Parecia que no lo sabia.',
    updated_at = datetime('now')
WHERE id = 812
  AND rules_help IS NULL;
