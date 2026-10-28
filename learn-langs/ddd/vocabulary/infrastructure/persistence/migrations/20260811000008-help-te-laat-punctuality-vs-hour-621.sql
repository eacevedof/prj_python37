-- Learn Languages App - Ayuda: te laat (puntualidad) vs laat (hora del dia) (tarjeta 621)
-- Migration: 20260811000008-help-te-laat-punctuality-vs-hour-621.sql
-- Description: Eduardo pregunta por que no puede ser "jij bent laat gekomen" y que aporta
--   "te". Clave: laat = tarde en el dia (hora avanzada); te laat = tarde en puntualidad
--   (pasada la hora acordada). Sin "te" la frase es gramaticalmente posible pero describe
--   la hora del dia, no impuntualidad. Bloque ⏰.

PRAGMA foreign_keys = ON;

-- 621 · laat (hora) vs te laat (puntualidad)
UPDATE words_es SET rules_help = COALESCE(rules_help, '') || '

⏰ ¿Por que "te laat" y no "laat" solo? Porque en NL son cosas distintas:

- laat = tarde en el sentido de hora avanzada del dia.
  Hij komt laat thuis = llega tarde a casa (de noche, a una hora tardía).
  Het wordt laat = se hace tarde.

- te laat = tarde en el sentido de puntualidad: pasada la hora acordada/esperada.
  Jij bent te laat gekomen = has llegado tarde (no a tiempo). ← 621
  Je bent te laat = llegas tarde / eres impuntual.

"Jij bent laat gekomen" es gramaticalmente posible pero significa "llegaste a una hora tardía" (describiendo el momento del dia), NO "llegaste despues de la hora acordada".

¿Que aporta "te"? Establece referencia a una hora esperada: no es solo que la hora fuera avanzada, sino que superaste el limite acordado. Como en te groot (demasiado grande, supera la medida) -> te laat = supera la hora. En el uso cotidiano te laat ya no suena a "demasiado" sino simplemente a "tarde (impuntual)": es una colocacion fija.

Regla mental: llegada impuntual -> SIEMPRE te laat · hora avanzada del dia -> laat.'
WHERE id = 621 AND COALESCE(rules_help,'') NOT LIKE '%⏰%';
