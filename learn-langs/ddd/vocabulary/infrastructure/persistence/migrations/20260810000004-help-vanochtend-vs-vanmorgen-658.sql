-- Learn Languages App - Ayuda: vanochtend vs vanmorgen (tarjeta 658)
-- Migration: 20260810000004-help-vanochtend-vs-vanmorgen-658.sql
-- Description: Eduardo (658 "Vanochtend ben ik laat opgestaan") pregunta por que
--   vanochtend y no vanmorgen. Respuesta (bloque 🌅): son SINONIMOS, las dos = "esta
--   manana", vanmorgen NO esta mal (vanochtend algo mas estandar en NL). Trampa: morgen
--   a secas = "manana" (tomorrow) pero vanmorgen = "esta manana"; manana por la manana =
--   morgenochtend. Familia van- (vanochtend/vanmorgen, vanmiddag, vanavond, vannacht).
--   Keyeada por id, idempotente por emoji-guarda 🌅, solo UPDATE de rules_help.

PRAGMA foreign_keys = ON;

-- 658 · vanochtend vs vanmorgen
UPDATE words_es SET rules_help = rules_help || '

🌅 ¿Por que "vanochtend" y no "vanmorgen"?
Son SINONIMOS: las dos significan "esta manana" y las dos son correctas. "Vanmorgen" NO esta mal; la tarjeta usa "vanochtend" solo porque en Holanda es la forma algo mas estandar/neutra ("vanmorgen" es igual de comun, muy coloquial). Es van + parte del dia: de ochtend = de morgen = la manana.

⚠️ Trampa: "morgen" a secas = "manana" (tomorrow), pero "vanmorgen" = "esta manana" (van + morgen). No las confundas. "Manana por la manana" = morgenochtend.

Familia van- (hoy mismo):
- vanochtend / vanmorgen = esta manana
- vanmiddag = esta tarde (mediodia)
- vanavond = esta noche (tarde-noche)
- vannacht = esta noche (madrugada)
Paralelo: ayer -> gisterochtend / gistermiddag / gisteravond · manana (tomorrow) -> morgenochtend / morgenmiddag / morgenavond.'
WHERE id = 658 AND COALESCE(rules_help,'') NOT LIKE '%🌅%';
