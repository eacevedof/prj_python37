-- Learn Languages App - Por que no vale "Ze stond bij haar moeder tot het einde" en la 820
-- Migration: 20260826000006-help-bijstaan-vs-staan-bij-820.sql
-- Description: La tarjeta 820 usa bijstaan (asistir/apoyar), separable con objeto DIRECTO
--   sin preposicion: "Ze stond haar moeder bij tot het einde". Se explica en su rules_help
--   por que poner "bij" pegado al verbo ("stond bij haar moeder") no es un simple error de
--   orden sino que cambia de verbo: convierte bijstaan (apoyar) en staan + bij como
--   preposicion normal (estar de pie junto a), perdiendo el sentido de apoyo.
--   100% aditiva e idempotente: solo UPDATE con guard (rules_help IS NULL).

UPDATE words_es
SET rules_help = '"Ze stond bij haar moeder tot het einde" no es agramatical, pero NO dice lo mismo: cambia de verbo.

⚠️ El problema no es solo el orden, es que "bij" deja de ser la particula separable de bijstaan y pasa a leerse como preposicion suelta detras de staan (estar de pie):
• ✅ bijstaan (apoyar, asistir) — Ze stond haar moeder bij tot het einde. — Estuvo al lado de su madre hasta el final (apoyo, sentido figurado). El objeto (haar moeder) es DIRECTO, sin preposicion, y la particula bij se va al final de la frase.
• ⚠️ staan bij (estar de pie junto a) — Ze stond bij haar moeder tot het einde. — Estuvo de pie junto a su madre hasta el final (presencia fisica literal, sin idea de apoyo). Aqui "bij" es una preposicion normal delante de haar moeder, como bij het raam (junto a la ventana).

📐 La regla que lo explica: en un verbo separable, el objeto directo va PEGADO al verbo conjugado y la particula (bij, mee, op…) se va SIEMPRE al final de la frase — nunca justo detras del verbo. En cuanto pones "bij" justo despues de stond, deja de ser particula separable y se convierte en preposicion, con otro significado.

🗺️ Mismo patron con otro separable de estar/quedarse:
• Ik sta je bij. — Estoy a tu lado (te apoyo, bijstaan). ≠ Ik sta bij jou. — Estoy de pie junto a ti (posicion fisica, staan + bij preposicion).
• Ze bleef bij hem staan. — Se quedo de pie junto a el (idea distinta otra vez: blijven staan = quedarse de pie, y bij hem es un complemento de lugar, no un separable).',
    updated_at = datetime('now')
WHERE id = 820
  AND rules_help IS NULL;
